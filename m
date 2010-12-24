From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Dec 2010 10:08:45 +0000
Subject: [PATCH 08/11] ARM: PL08x: prefix hex numbers with 0x
In-Reply-To: <20101224100550.GB20587@n2100.arm.linux.org.uk>
References: <20101224100550.GB20587@n2100.arm.linux.org.uk>
Message-ID: <E1PW4Zp-0006Di-9g@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A driver which emits both decimal and hex numbers in its printk
creates confusion as to what is what.  Prefix hex numbers with 0x.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 29890b1..79a8679 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -187,8 +187,8 @@ static void pl08x_set_cregs(struct pl08x_driver_data *pl08x,
 		;
 
 	dev_vdbg(&pl08x->adev->dev,
-		"WRITE channel %d: csrc=%08x, cdst=%08x, "
-		 "cctl=%08x, clli=%08x, ccfg=%08x\n",
+		"WRITE channel %d: csrc=0x%08x, cdst=0x%08x, "
+		 "cctl=0x%08x, clli=0x%08x, ccfg=0x%08x\n",
 		ch->id,
 		ch->csrc,
 		ch->cdst,
@@ -720,7 +720,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 		while (remainder) {
 			dev_vdbg(&pl08x->adev->dev,
 				 "%s single byte LLIs for a transfer of "
-				 "less than a bus width (remain %08x)\n",
+				 "less than a bus width (remain 0x%08x)\n",
 				 __func__, remainder);
 			cctl = pl08x_cctl_bits(cctl, 1, 1, 1);
 			num_llis =
@@ -736,7 +736,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 		while ((mbus->addr) % (mbus->buswidth)) {
 			dev_vdbg(&pl08x->adev->dev,
 				"%s adjustment lli for less than bus width "
-				 "(remain %08x)\n",
+				 "(remain 0x%08x)\n",
 				 __func__, remainder);
 			cctl = pl08x_cctl_bits(cctl, 1, 1, 1);
 			num_llis = pl08x_fill_lli_for_desc
@@ -854,7 +854,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 
 				if (target_len != lli_len) {
 					dev_vdbg(&pl08x->adev->dev,
-					"%s can't send what we want. Desired %08x, lli of %08x bytes in txd of %08x\n",
+					"%s can't send what we want. Desired 0x%08x, lli of 0x%08x bytes in txd of 0x%08x\n",
 					__func__, target_len, lli_len, txd->len);
 				}
 
@@ -864,7 +864,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 						       tsize);
 
 				dev_vdbg(&pl08x->adev->dev,
-					"%s fill lli with single lli chunk of size %08x (remainder %08x)\n",
+					"%s fill lli with single lli chunk of size 0x%08x (remainder 0x%08x)\n",
 					__func__, lli_len, remainder);
 				num_llis = pl08x_fill_lli_for_desc(pl08x, txd,
 						num_llis, lli_len, cctl,
@@ -883,7 +883,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 						&& (remainder); j++) {
 					cctl = pl08x_cctl_bits(cctl, 1, 1, 1);
 					dev_vdbg(&pl08x->adev->dev,
-						"%s align with boundary, single byte (remain %08x)\n",
+						"%s align with boundary, single byte (remain 0x%08x)\n",
 						__func__, remainder);
 					num_llis =
 						pl08x_fill_lli_for_desc(pl08x,
@@ -966,7 +966,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 
 		for (i = 0; i < num_llis; i++) {
 			dev_vdbg(&pl08x->adev->dev,
-				 "lli %d @%p: csrc=%08x, cdst=%08x, cctl=%08x, clli=%08x\n",
+				 "lli %d @%p: csrc=0x%08x, cdst=0x%08x, cctl=0x%08x, clli=0x%08x\n",
 				 i,
 				 &llis_va[i],
 				 llis_va[i].src,
@@ -1274,7 +1274,7 @@ static void dma_set_runtime_config(struct dma_chan *chan,
 
 	dev_dbg(&pl08x->adev->dev,
 		"configured channel %s (%s) for %s, data width %d, "
-		"maxburst %d words, LE, CCTL=%08x, CCFG=%08x\n",
+		"maxburst %d words, LE, CCTL=0x%08x, CCFG=0x%08x\n",
 		dma_chan_name(chan), plchan->name,
 		(config->direction == DMA_FROM_DEVICE) ? "RX" : "TX",
 		addr_width,
@@ -2083,7 +2083,7 @@ static int pl08x_probe(struct amba_device *adev, struct amba_id *id)
 
 	amba_set_drvdata(adev, pl08x);
 	init_pl08x_debugfs(pl08x);
-	dev_info(&pl08x->adev->dev, "ARM(R) %s DMA block initialized @%08x\n",
+	dev_info(&pl08x->adev->dev, "ARM(R) %s DMA block initialized @0x%08x\n",
 		vd->name, adev->res.start);
 	return 0;
 
-- 
1.6.2.5
