From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:43:15 +0000
Subject: [PATCH 39/48] ARM: PL08x: don't manipulate txd->srcbus or txd->dstbus
	during LLI fill
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt7T-0003Rw-LA@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't alter any txd->srcbus or txd->dstbus values while building the
LLI list.  This allows us to see the original dma_addr_t values passed
in via the prep_memcpy() method.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |  159 ++++++++++++++++++++++++----------------------
 1 files changed, 83 insertions(+), 76 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index be7fa17..39970c5 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -481,38 +481,45 @@ static inline u32 pl08x_cctl_bits(u32 cctl, u8 srcwidth, u8 dstwidth,
 	return retbits;
 }
 
+struct pl08x_lli_build_data {
+	struct pl08x_txd *txd;
+	struct pl08x_driver_data *pl08x;
+	struct pl08x_bus_data srcbus;
+	struct pl08x_bus_data dstbus;
+	size_t remainder;
+};
+
 /*
  * Autoselect a master bus to use for the transfer
  * this prefers the destination bus if both available
  * if fixed address on one bus the other will be chosen
  */
-static void pl08x_choose_master_bus(struct pl08x_bus_data *src_bus,
-	struct pl08x_bus_data *dst_bus, struct pl08x_bus_data **mbus,
-	struct pl08x_bus_data **sbus, u32 cctl)
+static void pl08x_choose_master_bus(struct pl08x_lli_build_data *bd,
+	struct pl08x_bus_data **mbus, struct pl08x_bus_data **sbus, u32 cctl)
 {
 	if (!(cctl & PL080_CONTROL_DST_INCR)) {
-		*mbus = src_bus;
-		*sbus = dst_bus;
+		*mbus = &bd->srcbus;
+		*sbus = &bd->dstbus;
 	} else if (!(cctl & PL080_CONTROL_SRC_INCR)) {
-		*mbus = dst_bus;
-		*sbus = src_bus;
+		*mbus = &bd->dstbus;
+		*sbus = &bd->srcbus;
 	} else {
-		if (dst_bus->buswidth == 4) {
-			*mbus = dst_bus;
-			*sbus = src_bus;
-		} else if (src_bus->buswidth == 4) {
-			*mbus = src_bus;
-			*sbus = dst_bus;
-		} else if (dst_bus->buswidth == 2) {
-			*mbus = dst_bus;
-			*sbus = src_bus;
-		} else if (src_bus->buswidth == 2) {
-			*mbus = src_bus;
-			*sbus = dst_bus;
+		if (bd->dstbus.buswidth == 4) {
+			*mbus = &bd->dstbus;
+			*sbus = &bd->srcbus;
+		} else if (bd->srcbus.buswidth == 4) {
+			*mbus = &bd->srcbus;
+			*sbus = &bd->dstbus;
+		} else if (bd->dstbus.buswidth == 2) {
+			*mbus = &bd->dstbus;
+			*sbus = &bd->srcbus;
+		} else if (bd->srcbus.buswidth == 2) {
+			*mbus = &bd->srcbus;
+			*sbus = &bd->dstbus;
 		} else {
-			/* src_bus->buswidth == 1 */
-			*mbus = dst_bus;
-			*sbus = src_bus;
+			/* bd->srcbus.buswidth == 1 */
+			*mbus = &bd->dstbus;
+			*sbus = &bd->srcbus;
 		}
 	}
 }
@@ -521,29 +528,29 @@ static void pl08x_choose_master_bus(struct pl08x_bus_data *src_bus,
  * Fills in one LLI for a certain transfer descriptor
  * and advance the counter
  */
-static void pl08x_fill_lli_for_desc(struct pl08x_driver_data *pl08x,
-	struct pl08x_txd *txd, int num_llis, int len, u32 cctl, u32 *remainder)
+static void pl08x_fill_lli_for_desc(struct pl08x_lli_build_data *bd,
+	int num_llis, int len, u32 cctl)
 {
-	struct pl08x_lli *llis_va = txd->llis_va;
-	dma_addr_t llis_bus = txd->llis_bus;
+	struct pl08x_lli *llis_va = bd->txd->llis_va;
+	dma_addr_t llis_bus = bd->txd->llis_bus;
 
 	BUG_ON(num_llis >= MAX_NUM_TSFR_LLIS);
 
 	llis_va[num_llis].cctl = cctl;
-	llis_va[num_llis].src = txd->srcbus.addr;
-	llis_va[num_llis].dst = txd->dstbus.addr;
+	llis_va[num_llis].src = bd->srcbus.addr;
+	llis_va[num_llis].dst = bd->dstbus.addr;
 	llis_va[num_llis].lli = llis_bus + (num_llis + 1) * sizeof(struct pl08x_lli);
-	if (pl08x->lli_buses & PL08X_AHB2)
+	if (bd->pl08x->lli_buses & PL08X_AHB2)
 		llis_va[num_llis].lli |= PL080_LLI_LM_AHB2;
 
 	if (cctl & PL080_CONTROL_SRC_INCR)
-		txd->srcbus.addr += len;
+		bd->srcbus.addr += len;
 	if (cctl & PL080_CONTROL_DST_INCR)
-		txd->dstbus.addr += len;
+		bd->dstbus.addr += len;
 
-	BUG_ON(*remainder < len);
+	BUG_ON(bd->remainder < len);
 
-	*remainder -= len;
+	bd->remainder -= len;
 }
 
 /*
@@ -567,7 +574,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 			      struct pl08x_txd *txd)
 {
 	struct pl08x_bus_data *mbus, *sbus;
-	size_t remainder;
+	struct pl08x_lli_build_data bd;
 	int num_llis = 0;
 	u32 cctl;
 	size_t max_bytes_per_lli;
@@ -586,38 +593,43 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	/* Get the default CCTL */
 	cctl = txd->cctl;
 
+	bd.txd = txd;
+	bd.pl08x = pl08x;
+	bd.srcbus.addr = txd->srcbus.addr;
+	bd.dstbus.addr = txd->dstbus.addr;
+
 	/* Find maximum width of the source bus */
-	txd->srcbus.maxwidth =
+	bd.srcbus.maxwidth =
 		pl08x_get_bytes_for_cctl((cctl & PL080_CONTROL_SWIDTH_MASK) >>
 				       PL080_CONTROL_SWIDTH_SHIFT);
 
 	/* Find maximum width of the destination bus */
-	txd->dstbus.maxwidth =
+	bd.dstbus.maxwidth =
 		pl08x_get_bytes_for_cctl((cctl & PL080_CONTROL_DWIDTH_MASK) >>
 				       PL080_CONTROL_DWIDTH_SHIFT);
 
 	/* Set up the bus widths to the maximum */
-	txd->srcbus.buswidth = txd->srcbus.maxwidth;
-	txd->dstbus.buswidth = txd->dstbus.maxwidth;
+	bd.srcbus.buswidth = bd.srcbus.maxwidth;
+	bd.dstbus.buswidth = bd.dstbus.maxwidth;
 	dev_vdbg(&pl08x->adev->dev,
 		 "%s source bus is %d bytes wide, dest bus is %d bytes wide\n",
-		 __func__, txd->srcbus.buswidth, txd->dstbus.buswidth);
+		 __func__, bd.srcbus.buswidth, bd.dstbus.buswidth);
 
 
 	/*
 	 * Bytes transferred == tsize * MIN(buswidths), not max(buswidths)
 	 */
-	max_bytes_per_lli = min(txd->srcbus.buswidth, txd->dstbus.buswidth) *
+	max_bytes_per_lli = min(bd.srcbus.buswidth, bd.dstbus.buswidth) *
 		PL080_CONTROL_TRANSFER_SIZE_MASK;
 	dev_vdbg(&pl08x->adev->dev,
 		 "%s max bytes per lli = %zu\n",
 		 __func__, max_bytes_per_lli);
 
 	/* We need to count this down to zero */
-	remainder = txd->len;
+	bd.remainder = txd->len;
 	dev_vdbg(&pl08x->adev->dev,
 		 "%s remainder = %zu\n",
-		 __func__, remainder);
+		 __func__, bd.remainder);
 
 	/*
 	 * Choose bus to align to
@@ -625,22 +637,20 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	 * - if fixed address on one bus chooses other
 	 * - modifies cctl to choose an appropriate master
 	 */
-	pl08x_choose_master_bus(&txd->srcbus, &txd->dstbus,
-				&mbus, &sbus, cctl);
+	pl08x_choose_master_bus(&bd, &mbus, &sbus, cctl);
 
 	if (txd->len < mbus->buswidth) {
 		/*
 		 * Less than a bus width available
 		 * - send as single bytes
 		 */
-		while (remainder) {
+		while (bd.remainder) {
 			dev_vdbg(&pl08x->adev->dev,
 				 "%s single byte LLIs for a transfer of "
 				 "less than a bus width (remain 0x%08x)\n",
-				 __func__, remainder);
+				 __func__, bd.remainder);
 			cctl = pl08x_cctl_bits(cctl, 1, 1, 1);
-			pl08x_fill_lli_for_desc(pl08x, txd, num_llis++, 1,
-					cctl, &remainder);
+			pl08x_fill_lli_for_desc(&bd, num_llis++, 1, cctl);
 			total_bytes++;
 		}
 	} else {
@@ -652,10 +662,9 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 			dev_vdbg(&pl08x->adev->dev,
 				"%s adjustment lli for less than bus width "
 				 "(remain 0x%08x)\n",
-				 __func__, remainder);
+				 __func__, bd.remainder);
 			cctl = pl08x_cctl_bits(cctl, 1, 1, 1);
-			pl08x_fill_lli_for_desc(pl08x, txd, num_llis++, 1,
-					cctl, &remainder);
+			pl08x_fill_lli_for_desc(&bd, num_llis++, 1, cctl);
 			total_bytes++;
 		}
 
@@ -675,14 +684,14 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 		 * Make largest possible LLIs until less than one bus
 		 * width left
 		 */
-		while (remainder > (mbus->buswidth - 1)) {
+		while (bd.remainder > (mbus->buswidth - 1)) {
 			size_t lli_len, target_len, tsize, odd_bytes;
 
 			/*
 			 * If enough left try to send max possible,
 			 * otherwise try to send the remainder
 			 */
-			target_len = min(remainder, max_bytes_per_lli);
+			target_len = min(bd.remainder, max_bytes_per_lli);
 
 			/*
 			 * Set bus lengths for incrementing buses to the
@@ -690,24 +699,24 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 			 * limiting on the target length calculated above.
 			 */
 			if (cctl & PL080_CONTROL_SRC_INCR)
-				txd->srcbus.fill_bytes =
-					pl08x_pre_boundary(txd->srcbus.addr,
+				bd.srcbus.fill_bytes =
+					pl08x_pre_boundary(bd.srcbus.addr,
 						target_len);
 			else
-				txd->srcbus.fill_bytes = target_len;
+				bd.srcbus.fill_bytes = target_len;
 
 			if (cctl & PL080_CONTROL_DST_INCR)
-				txd->dstbus.fill_bytes =
-					pl08x_pre_boundary(txd->dstbus.addr,
+				bd.dstbus.fill_bytes =
+					pl08x_pre_boundary(bd.dstbus.addr,
 						target_len);
 			else
-				txd->dstbus.fill_bytes = target_len;
+				bd.dstbus.fill_bytes = target_len;
 
 			/* Find the nearest */
-			lli_len	= min(txd->srcbus.fill_bytes,
-				txd->dstbus.fill_bytes);
+			lli_len	= min(bd.srcbus.fill_bytes,
+				      bd.dstbus.fill_bytes);
 
-			BUG_ON(lli_len > remainder);
+			BUG_ON(lli_len > bd.remainder);
 
 			if (lli_len <= 0) {
 				dev_err(&pl08x->adev->dev,
@@ -764,15 +773,15 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 				}
 
 				cctl = pl08x_cctl_bits(cctl,
-						       txd->srcbus.buswidth,
-						       txd->dstbus.buswidth,
+						       bd.srcbus.buswidth,
+						       bd.dstbus.buswidth,
 						       tsize);
 
 				dev_vdbg(&pl08x->adev->dev,
 					"%s fill lli with single lli chunk of size 0x%08zx (remainder 0x%08zx)\n",
-					__func__, lli_len, remainder);
-				pl08x_fill_lli_for_desc(pl08x, txd, num_llis++,
-						lli_len, cctl, &remainder);
+					__func__, lli_len, bd.remainder);
+				pl08x_fill_lli_for_desc(&bd, num_llis++,
+					lli_len, cctl);
 				total_bytes += lli_len;
 			}
 
@@ -784,14 +793,13 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 				 */
 				int j;
 				for (j = 0; (j < mbus->buswidth)
-						&& (remainder); j++) {
+						&& (bd.remainder); j++) {
 					cctl = pl08x_cctl_bits(cctl, 1, 1, 1);
 					dev_vdbg(&pl08x->adev->dev,
 						"%s align with boundary, single byte (remain 0x%08zx)\n",
-						__func__, remainder);
-					pl08x_fill_lli_for_desc(pl08x, txd,
-							num_llis++, 1, cctl,
-							&remainder);
+						__func__, bd.remainder);
+					pl08x_fill_lli_for_desc(&bd,
+						num_llis++, 1, cctl);
 					total_bytes++;
 				}
 			}
@@ -800,13 +808,12 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 		/*
 		 * Send any odd bytes
 		 */
-		while (remainder) {
+		while (bd.remainder) {
 			cctl = pl08x_cctl_bits(cctl, 1, 1, 1);
 			dev_vdbg(&pl08x->adev->dev,
 				"%s align with boundary, single odd byte (remain %zu)\n",
-				__func__, remainder);
-			pl08x_fill_lli_for_desc(pl08x, txd, num_llis++, 1,
-					cctl, &remainder);
+				__func__, bd.remainder);
+			pl08x_fill_lli_for_desc(&bd, num_llis++, 1, cctl);
 			total_bytes++;
 		}
 	}
-- 
1.6.2.5
