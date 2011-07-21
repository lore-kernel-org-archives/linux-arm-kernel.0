From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jul 2011 17:12:06 +0100
Subject: [PATCH 3/9] DMA: PL08x: clean up LLI debugging
In-Reply-To: <20110721160800.GR26574@n2100.arm.linux.org.uk>
References: <20110721160800.GR26574@n2100.arm.linux.org.uk>
Message-ID: <E1Qjvr4-0003MJ-ST@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clean up debugging when setting up the LLI list.  This reduces the
amount of output while preserving the information, and makes it easier
to read.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   33 ++++++++++++++++-----------------
 1 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 6808f7d..1c641bf 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -617,25 +617,15 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	/* Set up the bus widths to the maximum */
 	bd.srcbus.buswidth = bd.srcbus.maxwidth;
 	bd.dstbus.buswidth = bd.dstbus.maxwidth;
-	dev_vdbg(&pl08x->adev->dev,
-		 "%s source bus is %d bytes wide, dest bus is %d bytes wide\n",
-		 __func__, bd.srcbus.buswidth, bd.dstbus.buswidth);
-
 
 	/*
 	 * Bytes transferred == tsize * MIN(buswidths), not max(buswidths)
 	 */
 	max_bytes_per_lli = min(bd.srcbus.buswidth, bd.dstbus.buswidth) *
 		PL080_CONTROL_TRANSFER_SIZE_MASK;
-	dev_vdbg(&pl08x->adev->dev,
-		 "%s max bytes per lli = %zu\n",
-		 __func__, max_bytes_per_lli);
 
 	/* We need to count this down to zero */
 	bd.remainder = txd->len;
-	dev_vdbg(&pl08x->adev->dev,
-		 "%s remainder = %zu\n",
-		 __func__, bd.remainder);
 
 	/*
 	 * Choose bus to align to
@@ -644,6 +634,16 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	 */
 	pl08x_choose_master_bus(&bd, &mbus, &sbus, cctl);
 
+	dev_vdbg(&pl08x->adev->dev, "src=0x%08x%s/%u dst=0x%08x%s/%u len=%zu llimax=%zu\n",
+		 bd.srcbus.addr, cctl & PL080_CONTROL_SRC_INCR ? "+" : "",
+		 bd.srcbus.buswidth,
+		 bd.dstbus.addr, cctl & PL080_CONTROL_DST_INCR ? "+" : "",
+		 bd.dstbus.buswidth,
+		 bd.remainder, max_bytes_per_lli);
+	dev_vdbg(&pl08x->adev->dev, "mbus=%s sbus=%s\n",
+		 mbus == &bd.srcbus ? "src" : "dst",
+		 sbus == &bd.srcbus ? "src" : "dst");
+
 	if (txd->len < mbus->buswidth) {
 		/* Less than a bus width available - send as single bytes */
 		while (bd.remainder) {
@@ -835,15 +835,14 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 	{
 		int i;
 
+		dev_vdbg(&pl08x->adev->dev,
+			 "%-3s %-9s  %-10s %-10s %-10s %s\n",
+			 "lli", "", "csrc", "cdst", "clli", "cctl");
 		for (i = 0; i < num_llis; i++) {
 			dev_vdbg(&pl08x->adev->dev,
-				 "lli %d @%p: csrc=0x%08x, cdst=0x%08x, cctl=0x%08x, clli=0x%08x\n",
-				 i,
-				 &llis_va[i],
-				 llis_va[i].src,
-				 llis_va[i].dst,
-				 llis_va[i].cctl,
-				 llis_va[i].lli
+				 "%3d @%p: 0x%08x 0x%08x 0x%08x 0x%08x\n",
+				 i, &llis_va[i], llis_va[i].src,
+				 llis_va[i].dst, llis_va[i].lli, llis_va[i].cctl
 				);
 		}
 	}
-- 
1.7.4.4
