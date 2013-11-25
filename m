From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 25 Nov 2013 12:13:39 +0100
Subject: [PATCH v2 3/9] ASoC: fsl-ssi: Add imx50-ssi and of_device_id matching
In-Reply-To: <1385378025-1262-1-git-send-email-mpa@pengutronix.de>
References: <1385378025-1262-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1385378025-1262-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a small but significant difference between imx21-ssi and
imx50-ssi and above. imx21-ssi does not allow online reconfiguration of
some registers. They have to be configured at the beginning.

imx50-ssi has to reconfigure the SSI unit while it is running. Otherwise
it would not be possible to have two streams in parallel. The new SDMA
unit in imx50 and above has to be configured before the first DMA
request arrives. Therefor we need to setup TDMAE/RDMAE just before
starting the stream.

This patch introduces distinct imx50-ssi as compatible and adds
of_device_id matching in the probe function.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 57e331f..5e95244 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -187,6 +187,20 @@ struct fsl_ssi_private {
 	char name[1];
 };
 
+enum fsl_ssi_type {
+	FSL_SSI_MCP8610,
+	FSL_SSI_MX21,
+	FSL_SSI_MX50,
+};
+
+static const struct of_device_id fsl_ssi_ids[] = {
+	{ .compatible = "fsl,mpc8610-ssi", .data = (void *) FSL_SSI_MCP8610},
+	{ .compatible = "fsl,imx50-ssi", .data = (void *) FSL_SSI_MX50},
+	{ .compatible = "fsl,imx21-ssi", .data = (void *) FSL_SSI_MX21},
+	{}
+};
+MODULE_DEVICE_TABLE(of, fsl_ssi_ids);
+
 /**
  * fsl_ssi_isr: SSI interrupt handler
  *
@@ -922,6 +936,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	int ret = 0;
 	struct device_attribute *dev_attr = NULL;
 	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *of_id;
+	enum fsl_ssi_type hw_type;
 	const char *p, *sprop;
 	const uint32_t *iprop;
 	struct resource res;
@@ -936,6 +952,11 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	if (!of_device_is_available(np))
 		return -ENODEV;
 
+	of_id = of_match_device(fsl_ssi_ids, &pdev->dev);
+	if (!of_id)
+		return -EINVAL;
+	hw_type = (enum fsl_ssi_type) of_id->data;
+
 	/* We only support the SSI in "I2S Slave" mode */
 	sprop = of_get_property(np, "fsl,mode", NULL);
 	if (!sprop) {
@@ -1009,7 +1030,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
                 /* Older 8610 DTs didn't have the fifo-depth property */
 		ssi_private->fifo_depth = 8;
 
-	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx21-ssi")) {
+	if (hw_type == FSL_SSI_MX21 || hw_type == FSL_SSI_MX50) {
 		u32 dma_events[2];
 		ssi_private->ssi_on_imx = true;
 
@@ -1199,13 +1220,6 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id fsl_ssi_ids[] = {
-	{ .compatible = "fsl,mpc8610-ssi", },
-	{ .compatible = "fsl,imx21-ssi", },
-	{}
-};
-MODULE_DEVICE_TABLE(of, fsl_ssi_ids);
-
 static struct platform_driver fsl_ssi_driver = {
 	.driver = {
 		.name = "fsl-ssi-dai",
-- 
1.8.4.2
