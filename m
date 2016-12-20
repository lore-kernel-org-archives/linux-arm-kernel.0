From: codekipper@gmail.com (codekipper at gmail.com)
Date: Tue, 20 Dec 2016 15:49:14 +0100
Subject: [PATCH 2/2] ASoC: sun4i-spdif: Add quirks to the spdif driver
In-Reply-To: <20161220144914.30945-1-codekipper@gmail.com>
References: <20161220144914.30945-1-codekipper@gmail.com>
Message-ID: <20161220144914.30945-3-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

It has been seen that some newer SoCs have a different TX FIFO
address and we already have the difference with the A31 requiring
a reset. Add a quirks structure so that these can be managed
easily.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 sound/soc/sunxi/sun4i-spdif.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 048de15d6937..fec62ee1fc72 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -403,9 +403,29 @@ static struct snd_soc_dai_driver sun4i_spdif_dai = {
 	.name = "spdif",
 };
 
+struct sun4i_spdif_quirks {
+	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
+	bool has_reset;
+};
+
+static const struct sun4i_spdif_quirks sun4i_a10_spdif_quirks = {
+	.reg_dac_txdata	= SUN4I_SPDIF_TXFIFO,
+};
+
+static const struct sun4i_spdif_quirks sun6i_a31_spdif_quirks = {
+	.reg_dac_txdata	= SUN4I_SPDIF_TXFIFO,
+	.has_reset	= true,
+};
+
 static const struct of_device_id sun4i_spdif_of_match[] = {
-	{ .compatible = "allwinner,sun4i-a10-spdif", },
-	{ .compatible = "allwinner,sun6i-a31-spdif", },
+	{
+		.compatible = "allwinner,sun4i-a10-spdif",
+		.data = &sun4i_a10_spdif_quirks,
+	},
+	{
+		.compatible = "allwinner,sun6i-a31-spdif",
+		.data = &sun6i_a31_spdif_quirks,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_spdif_of_match);
@@ -438,6 +458,7 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
 {
 	struct sun4i_spdif_dev *host;
 	struct resource *res;
+	const struct sun4i_spdif_quirks *quirks;
 	int ret;
 	void __iomem *base;
 
@@ -459,6 +480,12 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	quirks = of_device_get_match_data(&pdev->dev);
+	if (quirks == NULL) {
+		dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
+		return -ENODEV;
+	}
+
 	host->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 						&sun4i_spdif_regmap_config);
 
@@ -476,14 +503,13 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
 		goto err_disable_apb_clk;
 	}
 
-	host->dma_params_tx.addr = res->start + SUN4I_SPDIF_TXFIFO;
+	host->dma_params_tx.addr = res->start + quirks->reg_dac_txdata;
 	host->dma_params_tx.maxburst = 8;
 	host->dma_params_tx.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 
 	platform_set_drvdata(pdev, host);
 
-	if (of_device_is_compatible(pdev->dev.of_node,
-				    "allwinner,sun6i-a31-spdif")) {
+	if (quirks->has_reset) {
 		host->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
 		if (IS_ERR(host->rst) && PTR_ERR(host->rst) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
-- 
2.11.0
