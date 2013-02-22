From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 22 Feb 2013 15:37:18 +0100
Subject: [PATCH] dma: imx-dma: Add oftree support
Message-ID: <1361543838-12604-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding devicetree support for imx-dma driver. Use driver name for
function 'imx_dma_is_general_purpose' because the devicename for
devicetree initialized devices is different.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 .../devicetree/bindings/dma/fsl-imx-dma.txt        | 13 ++++++++++++
 drivers/dma/imx-dma.c                              | 23 ++++++++++++++++++++++
 include/linux/platform_data/dma-imx.h              |  3 ++-
 3 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt
new file mode 100644
index 0000000..9a1df37
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-dma.txt
@@ -0,0 +1,13 @@
+* Freescale Direct Memory Access (DMA) Controller for i.MX
+
+Required properties:
+- compatible : Should be "fsl,<chip>-dma". chip can be imx1, imx21 or imx27
+- reg : Should contain DMA registers location and length
+- interrupts : First item should be DMA interrupt, second one is optional and
+  should contain DMA Error interrupt
+
+dma: dma at 10001000 {
+	compatible = "fsl,imx27-dma";
+	reg = <0x10001000 0x1000>;
+	interrupts = <32 33>;
+};
diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index a7dcf78..73eb59c 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -26,6 +26,7 @@
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 
 #include <asm/irq.h>
 #include <linux/platform_data/dma-imx.h>
@@ -201,6 +202,22 @@ static struct platform_device_id imx_dma_devtype[] = {
 };
 MODULE_DEVICE_TABLE(platform, imx_dma_devtype);
 
+static const struct of_device_id imx_dma_of_dev_id[] = {
+	{
+		.compatible = "fsl,imx1-dma",
+		.data = &imx_dma_devtype[IMX1_DMA],
+	}, {
+		.compatible = "fsl,imx21-dma",
+		.data = &imx_dma_devtype[IMX21_DMA],
+	}, {
+		.compatible = "fsl,imx27-dma",
+		.data = &imx_dma_devtype[IMX27_DMA],
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, imx_dma_of_dev_id);
+
 static inline int is_imx1_dma(struct imxdma_engine *imxdma)
 {
 	return imxdma->devtype == IMX1_DMA;
@@ -1000,9 +1017,14 @@ static int __init imxdma_probe(struct platform_device *pdev)
 	{
 	struct imxdma_engine *imxdma;
 	struct resource *res;
+	const struct of_device_id *of_id;
 	int ret, i;
 	int irq, irq_err;
 
+	of_id = of_match_device(imx_dma_of_dev_id, &pdev->dev);
+	if (of_id)
+		pdev->id_entry = of_id->data;
+
 	imxdma = devm_kzalloc(&pdev->dev, sizeof(*imxdma), GFP_KERNEL);
 	if (!imxdma)
 		return -ENOMEM;
@@ -1159,6 +1181,7 @@ static int __exit imxdma_remove(struct platform_device *pdev)
 static struct platform_driver imxdma_driver = {
 	.driver		= {
 		.name	= "imx-dma",
+		.of_match_table = imx_dma_of_dev_id,
 	},
 	.id_table	= imx_dma_devtype,
 	.remove		= __exit_p(imxdma_remove),
diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
index f6d30cc..2ce4aba 100644
--- a/include/linux/platform_data/dma-imx.h
+++ b/include/linux/platform_data/dma-imx.h
@@ -63,7 +63,8 @@ static inline int imx_dma_is_general_purpose(struct dma_chan *chan)
 	return strstr(dev_name(chan->device->dev), "sdma") ||
 		!strcmp(dev_name(chan->device->dev), "imx1-dma") ||
 		!strcmp(dev_name(chan->device->dev), "imx21-dma") ||
-		!strcmp(dev_name(chan->device->dev), "imx27-dma");
+		!strcmp(dev_name(chan->device->dev), "imx27-dma") ||
+		!strcmp(chan->device->dev->driver->name, "imx-dma");
 }
 
 #endif
-- 
1.8.1.2
