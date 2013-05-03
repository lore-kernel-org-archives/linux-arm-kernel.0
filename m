From: shc_work@mail.ru (Alexander Shiyan)
Date: Fri,  3 May 2013 15:16:08 +0400
Subject: [PATCH 1/2] dmaengine: imx-dma: Add device tree probe support
Message-ID: <1367579769-22958-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree probe support for imx-dma driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 .../devicetree/bindings/dma/fsl-imx-dma.txt         | 18 ++++++++++++++++++
 drivers/dma/imx-dma.c                               | 21 +++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt
new file mode 100644
index 0000000..9409682
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt
@@ -0,0 +1,18 @@
+* Freescale Direct Memory Access (DMA) Controller for i.MX
+
+Required properties:
+- compatible: Should be "fsl,<chip>-dma"
+- reg: Should contain DMA registers location and length
+- interrupts: Should contain DMA interrupt
+- clocks: Pointer to the reference clocks
+- clock-names: Names of DMA reference clocks
+
+Examples:
+
+dma: dma at 10001000 {
+	compatible = "fsl,imx27-dma";
+	reg = <0x10001000 0x1000>;
+	interrupts = <32>;
+	clocks = <&clks 50>, <&clks 70>;
+	clock-names = "ipg", "ahb";
+};
diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index f285833..ce8c2a0 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -27,6 +27,8 @@
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/irq.h>
 #include <linux/platform_data/dma-imx.h>
@@ -202,6 +204,14 @@ static struct platform_device_id imx_dma_devtype[] = {
 };
 MODULE_DEVICE_TABLE(platform, imx_dma_devtype);
 
+static const struct of_device_id imx_dma_dt_ids[] = {
+	{ .compatible = "fsl,imx1-dma",  .data = &imx_dma_devtype[IMX1_DMA], },
+	{ .compatible = "fsl,imx21-dma", .data = &imx_dma_devtype[IMX21_DMA], },
+	{ .compatible = "fsl,imx27-dma", .data = &imx_dma_devtype[IMX27_DMA], },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, imx_dma_dt_ids);
+
 static inline int is_imx1_dma(struct imxdma_engine *imxdma)
 {
 	return imxdma->devtype == IMX1_DMA;
@@ -997,7 +1007,9 @@ static void imxdma_issue_pending(struct dma_chan *chan)
 }
 
 static int __init imxdma_probe(struct platform_device *pdev)
-	{
+{
+	const struct of_device_id *of_id =
+			of_match_device(imx_dma_dt_ids, &pdev->dev);
 	struct imxdma_engine *imxdma;
 	struct resource *res;
 	int ret, i;
@@ -1007,6 +1019,8 @@ static int __init imxdma_probe(struct platform_device *pdev)
 	if (!imxdma)
 		return -ENOMEM;
 
+	if (of_id)
+		pdev->id_entry = of_id->data;
 	imxdma->devtype = pdev->id_entry->driver_data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1136,6 +1150,8 @@ static int __init imxdma_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	dev_info(imxdma->dev, "initialized\n");
+
 	return 0;
 
 err:
@@ -1158,7 +1174,8 @@ static int imxdma_remove(struct platform_device *pdev)
 
 static struct platform_driver imxdma_driver = {
 	.driver		= {
-		.name	= "imx-dma",
+		.name		= "imx-dma",
+		.of_match_table	= imx_dma_dt_ids,
 	},
 	.id_table	= imx_dma_devtype,
 	.remove		= imxdma_remove,
-- 
1.8.1.5
