From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:33:26 +0000
Subject: [PATCH 10/48] ARM: PL08x: improve the announcement printk
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZsxy-0001OW-M0@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include the revision number of the PL08x primecell in the boot-time
printk to allow proper identification of the peripheral.  Reformat
the announcement printk format reflect what we do for other primecell
drivers - generally "PLXXX revX at 0xNNNNNNNN irq X".

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 4b63fc3..75ab4e4 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -98,13 +98,11 @@
 /**
  * struct vendor_data - vendor-specific config parameters
  * for PL08x derivatives
- * @name: the name of this specific variant
  * @channels: the number of channels available in this variant
  * @dualmaster: whether this version supports dual AHB masters
  * or not.
  */
 struct vendor_data {
-	char *name;
 	u8 channels;
 	bool dualmaster;
 };
@@ -2024,7 +2022,7 @@ static int pl08x_probe(struct amba_device *adev, struct amba_id *id)
 	writel(0x000000FF, pl08x->base + PL080_TC_CLEAR);
 
 	ret = request_irq(adev->irq[0], pl08x_irq, IRQF_DISABLED,
-			  vd->name, pl08x);
+			  DRIVER_NAME, pl08x);
 	if (ret) {
 		dev_err(&adev->dev, "%s failed to request interrupt %d\n",
 			__func__, adev->irq[0]);
@@ -2095,8 +2093,9 @@ static int pl08x_probe(struct amba_device *adev, struct amba_id *id)
 
 	amba_set_drvdata(adev, pl08x);
 	init_pl08x_debugfs(pl08x);
-	dev_info(&pl08x->adev->dev, "ARM(R) %s DMA block initialized @%08x\n",
-		vd->name, adev->res.start);
+	dev_info(&pl08x->adev->dev, "DMA: PL%03x rev%u at 0x%08llx irq %d\n",
+		 amba_part(adev), amba_rev(adev),
+		 (unsigned long long)adev->res.start, adev->irq[0]);
 	return 0;
 
 out_no_slave_reg:
@@ -2123,13 +2122,11 @@ out_no_pl08x:
 
 /* PL080 has 8 channels and the PL080 have just 2 */
 static struct vendor_data vendor_pl080 = {
-	.name = "PL080",
 	.channels = 8,
 	.dualmaster = true,
 };
 
 static struct vendor_data vendor_pl081 = {
-	.name = "PL081",
 	.channels = 2,
 	.dualmaster = false,
 };
-- 
1.6.2.5
