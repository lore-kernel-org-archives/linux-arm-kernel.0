From: zhangfei.gao@marvell.com (Zhangfei Gao)
Date: Fri, 27 Jul 2012 12:46:20 +0800
Subject: [PATCH 2/4] dmaengine: mmp_tdma: add dt support
In-Reply-To: <1343364382-16269-1-git-send-email-zhangfei.gao@marvell.com>
References: <1343364382-16269-1-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <1343364382-16269-3-git-send-email-zhangfei.gao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 Documentation/devicetree/bindings/dma/mmp-dma.txt |   27 +++++++++++
 drivers/dma/mmp_tdma.c                            |   51 +++++++++++++--------
 2 files changed, 58 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/mmp-dma.txt b/Documentation/devicetree/bindings/dma/mmp-dma.txt
index c4a311f..2622a95 100644
--- a/Documentation/devicetree/bindings/dma/mmp-dma.txt
+++ b/Documentation/devicetree/bindings/dma/mmp-dma.txt
@@ -40,3 +40,30 @@ pdma: dma-controller at d4000000 {
 	      dma-channels = <16>;
       };
 
+
+Marvell Two Channel DMA Controller used specifically for audio
+Used platfroms: pxa688, pxa910
+
+Required properties:
+- compatible: Should be "marvell,mmp-adma" or "marvell,pxa910-squ"
+- reg: Should contain DMA registers location and length.
+- interrupts: Either contain all of the per-channel DMA interrupts
+		or one irq for dma device
+
+Examples:
+
+/* each channel has specific irq */
+adma0: dma-controller at d42a0800 {
+	      compatible = "marvell,mmp-adma";
+	      reg = <0xd42a0800 0x100>;
+	      interrupts = <18 19>;
+	      interrupt-parent = <&intcmux32>;
+      };
+
+/* One irq for all channels */
+squ: dma-controller at d42a0800 {
+	      compatible = "marvell,pxa910-squ";
+	      reg = <0xd42a0800 0x100>;
+	      interrupts = <46>;
+      };
+
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 8a15cf2..9376ea8 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 #include <mach/regs-icu.h>
 #include <mach/sram.h>
+#include <linux/of_device.h>
 
 #include "dmaengine.h"
 
@@ -127,7 +128,6 @@ struct mmp_tdma_device {
 	void __iomem			*base;
 	struct dma_device		device;
 	struct mmp_tdma_chan		*tdmac[TDMA_CHANNEL_NUM];
-	int				irq;
 };
 
 #define to_mmp_tdma_chan(dchan) container_of(dchan, struct mmp_tdma_chan, chan)
@@ -492,7 +492,7 @@ static int __devinit mmp_tdma_chan_init(struct mmp_tdma_device *tdev,
 		return -ENOMEM;
 	}
 	if (irq)
-		tdmac->irq = irq + idx;
+		tdmac->irq = irq;
 	tdmac->dev	   = tdev->dev;
 	tdmac->chan.device = &tdev->device;
 	tdmac->idx	   = idx;
@@ -505,34 +505,43 @@ static int __devinit mmp_tdma_chan_init(struct mmp_tdma_device *tdev,
 	/* add the channel to tdma_chan list */
 	list_add_tail(&tdmac->chan.device_node,
 			&tdev->device.channels);
-
 	return 0;
 }
 
+static struct of_device_id mmp_tdma_dt_ids[] = {
+	{ .compatible = "marvell,mmp-adma", .data = (void *)MMP_AUD_TDMA},
+	{ .compatible = "marvell,pxa910-squ", .data = (void *)PXA910_SQU},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mmp_tdma_dt_ids);
+
 static int __devinit mmp_tdma_probe(struct platform_device *pdev)
 {
-	const struct platform_device_id *id = platform_get_device_id(pdev);
-	enum mmp_tdma_type type = id->driver_data;
+	enum mmp_tdma_type type;
+	const struct of_device_id *of_id;
 	struct mmp_tdma_device *tdev;
 	struct resource *iores;
 	int i, ret;
-	int irq = 0;
+	int irq = 0, irq_num = 0;
 	int chan_num = TDMA_CHANNEL_NUM;
 
+	of_id = of_match_device(mmp_tdma_dt_ids, &pdev->dev);
+	if (of_id)
+		type = (enum mmp_tdma_type) of_id->data;
+	else
+		type = platform_get_device_id(pdev)->driver_data;
+
 	/* always have couple channels */
 	tdev = devm_kzalloc(&pdev->dev, sizeof(*tdev), GFP_KERNEL);
 	if (!tdev)
 		return -ENOMEM;
 
 	tdev->dev = &pdev->dev;
-	iores = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!iores)
-		return -EINVAL;
 
-	if (resource_size(iores) != chan_num)
-		tdev->irq = iores->start;
-	else
-		irq = iores->start;
+	for (i = 0; i < chan_num; i++) {
+		if (platform_get_irq(pdev, i) > 0)
+			irq_num++;
+	}
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!iores)
@@ -542,25 +551,26 @@ static int __devinit mmp_tdma_probe(struct platform_device *pdev)
 	if (!tdev->base)
 		return -EADDRNOTAVAIL;
 
-	if (tdev->irq) {
-		ret = devm_request_irq(&pdev->dev, tdev->irq,
+	INIT_LIST_HEAD(&tdev->device.channels);
+
+	if (irq_num != chan_num) {
+		irq = platform_get_irq(pdev, 0);
+		ret = devm_request_irq(&pdev->dev, irq,
 			mmp_tdma_int_handler, IRQF_DISABLED, "tdma", tdev);
 		if (ret)
 			return ret;
 	}
 
-	dma_cap_set(DMA_SLAVE, tdev->device.cap_mask);
-	dma_cap_set(DMA_CYCLIC, tdev->device.cap_mask);
-
-	INIT_LIST_HEAD(&tdev->device.channels);
-
 	/* initialize channel parameters */
 	for (i = 0; i < chan_num; i++) {
+		irq = (irq_num != chan_num) ? 0 : platform_get_irq(pdev, i);
 		ret = mmp_tdma_chan_init(tdev, i, irq, type);
 		if (ret)
 			return ret;
 	}
 
+	dma_cap_set(DMA_SLAVE, tdev->device.cap_mask);
+	dma_cap_set(DMA_CYCLIC, tdev->device.cap_mask);
 	tdev->device.dev = &pdev->dev;
 	tdev->device.device_alloc_chan_resources =
 					mmp_tdma_alloc_chan_resources;
@@ -595,6 +605,7 @@ static struct platform_driver mmp_tdma_driver = {
 	.driver		= {
 		.name	= "mmp-tdma",
 		.owner  = THIS_MODULE,
+		.of_match_table = mmp_tdma_dt_ids,
 	},
 	.id_table	= mmp_tdma_id_table,
 	.probe		= mmp_tdma_probe,
-- 
1.7.1
