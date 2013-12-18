From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 18 Dec 2013 12:57:39 +0100
Subject: [PATCH v3 3/9] ASoC: fsl-ssi: Add imx51-ssi and of_device_id matching
In-Reply-To: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
References: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1387367865-26391-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a small but significant difference between imx21-ssi and
imx51-ssi and above. imx21-ssi does not allow online reconfiguration of
some registers. They have to be configured at the beginning.

imx51-ssi has to reconfigure the SSI unit while it is running. Otherwise
it would not be possible to have two streams in parallel. The new SDMA
unit in imx51 and above has to be configured before the first DMA
request arrives. Therefor we need to setup TDMAE/RDMAE just before
starting the stream.

This patch introduces distinct imx51-ssi as compatible and adds
of_device_id matching in the probe function.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e949ce5..a889df5 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -122,6 +122,13 @@ static inline void write_ssi_mask(u32 __iomem *addr, u32 clear, u32 set)
 		CCSR_SSI_SIER_TUE0_EN | CCSR_SSI_SIER_TFRC_EN)
 #define FSLSSI_SISR_MASK (FSLSSI_SIER_DBG_RX_FLAGS | FSLSSI_SIER_DBG_TX_FLAGS)
 
+
+enum fsl_ssi_type {
+	FSL_SSI_MCP8610,
+	FSL_SSI_MX21,
+	FSL_SSI_MX51,
+};
+
 /**
  * fsl_ssi_private: per-SSI private data
  *
@@ -184,6 +191,14 @@ struct fsl_ssi_private {
 	char name[1];
 };
 
+static const struct of_device_id fsl_ssi_ids[] = {
+	{ .compatible = "fsl,mpc8610-ssi", .data = (void *) FSL_SSI_MCP8610},
+	{ .compatible = "fsl,imx51-ssi", .data = (void *) FSL_SSI_MX51},
+	{ .compatible = "fsl,imx21-ssi", .data = (void *) FSL_SSI_MX21},
+	{}
+};
+MODULE_DEVICE_TABLE(of, fsl_ssi_ids);
+
 /**
  * fsl_ssi_isr: SSI interrupt handler
  *
@@ -863,6 +878,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	int ret = 0;
 	struct device_attribute *dev_attr = NULL;
 	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *of_id;
+	enum fsl_ssi_type hw_type;
 	const char *p, *sprop;
 	const uint32_t *iprop;
 	struct resource res;
@@ -877,6 +894,11 @@ static int fsl_ssi_probe(struct platform_device *pdev)
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
@@ -953,7 +975,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
                 /* Older 8610 DTs didn't have the fifo-depth property */
 		ssi_private->fifo_depth = 8;
 
-	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx21-ssi")) {
+	if (hw_type == FSL_SSI_MX21 || hw_type == FSL_SSI_MX51) {
 		u32 dma_events[2];
 		ssi_private->ssi_on_imx = true;
 
@@ -1139,13 +1161,6 @@ static int fsl_ssi_remove(struct platform_device *pdev)
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
1.8.5.1
