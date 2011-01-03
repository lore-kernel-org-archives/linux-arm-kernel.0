From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:37:31 +0000
Subject: [PATCH 22/48] ARM: PL08x: use 'size_t' for lengths
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt1v-0001PN-VU@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use size_t for variables denoting lengths throughout, and use the 'z'
qualifier for printing the value.  For safety, add a BUG_ON() in
pl08x_fill_lli_for_desc() to catch the remainder potentially becoming
negative.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |   40 +++++++++++++++++-----------------------
 include/linux/amba/pl08x.h |    4 ++--
 2 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 760b71e..fa78697 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -342,7 +342,7 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
 	struct pl08x_txd *txdi = NULL;
 	struct pl08x_txd *txd;
 	unsigned long flags;
-	u32 bytes = 0;
+	size_t bytes = 0;
 
 	spin_lock_irqsave(&plchan->lock, flags);
 
@@ -470,7 +470,7 @@ static inline unsigned int pl08x_get_bytes_for_cctl(unsigned int coded)
 }
 
 static inline u32 pl08x_cctl_bits(u32 cctl, u8 srcwidth, u8 dstwidth,
-				  u32 tsize)
+				  size_t tsize)
 {
 	u32 retbits = cctl;
 
@@ -583,6 +583,8 @@ static int pl08x_fill_lli_for_desc(struct pl08x_driver_data *pl08x,
 	if (cctl & PL080_CONTROL_DST_INCR)
 		txd->dstbus.addr += len;
 
+	BUG_ON(*remainder < len);
+
 	*remainder -= len;
 
 	return num_llis + 1;
@@ -591,7 +593,7 @@ static int pl08x_fill_lli_for_desc(struct pl08x_driver_data *pl08x,
 /*
  * Return number of bytes to fill to boundary, or len
  */
-static inline u32 pl08x_pre_boundary(u32 addr, u32 len)
+static inline size_t pl08x_pre_boundary(u32 addr, size_t len)
 {
 	u32 boundary;
 
@@ -614,11 +616,11 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 {
 	struct pl08x_channel_data *cd = txd->cd;
 	struct pl08x_bus_data *mbus, *sbus;
-	u32 remainder;
+	size_t remainder;
 	int num_llis = 0;
 	u32 cctl;
-	int max_bytes_per_lli;
-	int total_bytes = 0;
+	size_t max_bytes_per_lli;
+	size_t total_bytes = 0;
 	struct pl08x_lli *llis_va;
 
 	txd->llis_va = dma_pool_alloc(pl08x->pool, GFP_NOWAIT,
@@ -686,13 +688,13 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	max_bytes_per_lli = min(txd->srcbus.buswidth, txd->dstbus.buswidth) *
 		PL080_CONTROL_TRANSFER_SIZE_MASK;
 	dev_vdbg(&pl08x->adev->dev,
-		 "%s max bytes per lli = %d\n",
+		 "%s max bytes per lli = %zu\n",
 		 __func__, max_bytes_per_lli);
 
 	/* We need to count this down to zero */
 	remainder = txd->len;
 	dev_vdbg(&pl08x->adev->dev,
-		 "%s remainder = %d\n",
+		 "%s remainder = %zu\n",
 		 __func__, remainder);
 
 	/*
@@ -760,9 +762,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 		 * width left
 		 */
 		while (remainder > (mbus->buswidth - 1)) {
-			int lli_len, target_len;
-			int tsize;
-			int odd_bytes;
+			size_t lli_len, target_len, tsize, odd_bytes;
 
 			/*
 			 * If enough left try to send max possible,
@@ -805,7 +805,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 
 			if (lli_len <= 0) {
 				dev_err(&pl08x->adev->dev,
-					"%s lli_len is %d, <= 0\n",
+					"%s lli_len is %zu, <= 0\n",
 						__func__, lli_len);
 				return 0;
 			}
@@ -853,7 +853,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 
 				if (target_len != lli_len) {
 					dev_vdbg(&pl08x->adev->dev,
-					"%s can't send what we want. Desired 0x%08x, lli of 0x%08x bytes in txd of 0x%08x\n",
+					"%s can't send what we want. Desired 0x%08zx, lli of 0x%08zx bytes in txd of 0x%08zx\n",
 					__func__, target_len, lli_len, txd->len);
 				}
 
@@ -863,7 +863,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 						       tsize);
 
 				dev_vdbg(&pl08x->adev->dev,
-					"%s fill lli with single lli chunk of size 0x%08x (remainder 0x%08x)\n",
+					"%s fill lli with single lli chunk of size 0x%08zx (remainder 0x%08zx)\n",
 					__func__, lli_len, remainder);
 				num_llis = pl08x_fill_lli_for_desc(pl08x, txd,
 						num_llis, lli_len, cctl,
@@ -882,7 +882,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 						&& (remainder); j++) {
 					cctl = pl08x_cctl_bits(cctl, 1, 1, 1);
 					dev_vdbg(&pl08x->adev->dev,
-						"%s align with boundary, single byte (remain 0x%08x)\n",
+						"%s align with boundary, single byte (remain 0x%08zx)\n",
 						__func__, remainder);
 					num_llis =
 						pl08x_fill_lli_for_desc(pl08x,
@@ -896,16 +896,10 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 		/*
 		 * Send any odd bytes
 		 */
-		if (remainder < 0) {
-			dev_err(&pl08x->adev->dev, "%s remainder not fitted 0x%08x bytes\n",
-					__func__, remainder);
-			return 0;
-		}
-
 		while (remainder) {
 			cctl = pl08x_cctl_bits(cctl, 1, 1, 1);
 			dev_vdbg(&pl08x->adev->dev,
-				"%s align with boundary, single odd byte (remain %d)\n",
+				"%s align with boundary, single odd byte (remain %zu)\n",
 				__func__, remainder);
 			num_llis = pl08x_fill_lli_for_desc(pl08x, txd, num_llis,
 					1, cctl, &remainder);
@@ -914,7 +908,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	}
 	if (total_bytes != txd->len) {
 		dev_err(&pl08x->adev->dev,
-			"%s size of encoded lli:s don't match total txd, transferred 0x%08x from size 0x%08x\n",
+			"%s size of encoded lli:s don't match total txd, transferred 0x%08zx from size 0x%08zx\n",
 			__func__, total_bytes, txd->len);
 		return 0;
 	}
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 3ecc20f..2c834ed 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -77,7 +77,7 @@ struct pl08x_bus_data {
 	dma_addr_t addr;
 	u8 maxwidth;
 	u8 buswidth;
-	u32 fill_bytes;
+	size_t fill_bytes;
 };
 
 /**
@@ -113,7 +113,7 @@ struct pl08x_txd {
 	enum dma_data_direction	direction;
 	struct pl08x_bus_data srcbus;
 	struct pl08x_bus_data dstbus;
-	int len;
+	size_t len;
 	dma_addr_t llis_bus;
 	void *llis_va;
 	struct pl08x_channel_data *cd;
-- 
1.6.2.5
