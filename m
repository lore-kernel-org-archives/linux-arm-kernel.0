From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 Apr 2016 07:30:55 +0100
Subject: Applied "ASoC: rockchip: i2s: configure the sdio pins' iomux mode" to
 the asoc tree
In-Reply-To: <1460366763-25658-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <E1aprqh-0008Dx-S8@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: i2s: configure the sdio pins' iomux mode

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 72b7ba1f1477f1b9b0a3ddf2dd4b5392ce88a8a3 Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Mon, 11 Apr 2016 17:26:03 +0800
Subject: [PATCH] ASoC: rockchip: i2s: configure the sdio pins' iomux mode

There are 3 i2s sdio pins, which iomux mode is as follows:

 - sdi3_sdo1
 - sdi2_sdo2
 - sdi1_sdo3

we need to configure these pins' iomux mode via the GRF register
when use multi channel playback/capture.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/rockchip-i2s.txt     |  5 ++
 sound/soc/rockchip/rockchip_i2s.c                  | 67 +++++++++++++++++++---
 sound/soc/rockchip/rockchip_i2s.h                  |  7 +++
 3 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 6e86d8aa29b4..4ea29aa9af59 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -23,6 +23,11 @@ Required properties:
 - rockchip,playback-channels: max playback channels, if not set, 8 channels default.
 - rockchip,capture-channels: max capture channels, if not set, 2 channels default.
 
+Required properties for controller which support multi channels
+playback/capture:
+
+- rockchip,grf: the phandle of the syscon node for GRF register.
+
 Example for rk3288 I2S controller:
 
 i2s at ff890000 {
diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 2f8e20416bd3..d4f7eac5cfd4 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -11,8 +11,10 @@
  */
 
 #include <linux/module.h>
+#include <linux/mfd/syscon.h>
 #include <linux/delay.h>
 #include <linux/of_gpio.h>
+#include <linux/of_device.h>
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -23,6 +25,11 @@
 
 #define DRV_NAME "rockchip-i2s"
 
+struct rk_i2s_pins {
+	u32 reg_offset;
+	u32 shift;
+};
+
 struct rk_i2s_dev {
 	struct device *dev;
 
@@ -33,8 +40,10 @@ struct rk_i2s_dev {
 	struct snd_dmaengine_dai_dma_data playback_dma_data;
 
 	struct regmap *regmap;
+	struct regmap *grf;
 
 	bool is_master_mode;
+	const struct rk_i2s_pins *pins;
 };
 
 static int i2s_runtime_suspend(struct device *dev)
@@ -277,6 +286,30 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 				   I2S_TXCR_VDW_MASK | I2S_TXCR_CSR_MASK,
 				   val);
 
+	if (!IS_ERR(i2s->grf) && i2s->pins) {
+		regmap_read(i2s->regmap, I2S_TXCR, &val);
+		val &= I2S_TXCR_CSR_MASK;
+
+		switch (val) {
+		case I2S_CHN_4:
+			val = I2S_IO_4CH_OUT_6CH_IN;
+			break;
+		case I2S_CHN_6:
+			val = I2S_IO_6CH_OUT_4CH_IN;
+			break;
+		case I2S_CHN_8:
+			val = I2S_IO_8CH_OUT_2CH_IN;
+			break;
+		default:
+			val = I2S_IO_2CH_OUT_8CH_IN;
+			break;
+		}
+
+		val <<= i2s->pins->shift;
+		val |= (I2S_IO_DIRECTION_MASK << i2s->pins->shift) << 16;
+		regmap_write(i2s->grf, i2s->pins->reg_offset, val);
+	}
+
 	regmap_update_bits(i2s->regmap, I2S_DMACR, I2S_DMACR_TDL_MASK,
 			   I2S_DMACR_TDL(16));
 	regmap_update_bits(i2s->regmap, I2S_DMACR, I2S_DMACR_RDL_MASK,
@@ -462,9 +495,23 @@ static const struct regmap_config rockchip_i2s_regmap_config = {
 	.cache_type = REGCACHE_FLAT,
 };
 
+static const struct rk_i2s_pins rk3399_i2s_pins = {
+	.reg_offset = 0xe220,
+	.shift = 11,
+};
+
+static const struct of_device_id rockchip_i2s_match[] = {
+	{ .compatible = "rockchip,rk3066-i2s", },
+	{ .compatible = "rockchip,rk3188-i2s", },
+	{ .compatible = "rockchip,rk3288-i2s", },
+	{ .compatible = "rockchip,rk3399-i2s", .data = &rk3399_i2s_pins },
+	{},
+};
+
 static int rockchip_i2s_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
+	const struct of_device_id *of_id;
 	struct rk_i2s_dev *i2s;
 	struct snd_soc_dai_driver *soc_dai;
 	struct resource *res;
@@ -478,6 +525,17 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	i2s->dev = &pdev->dev;
+
+	i2s->grf = syscon_regmap_lookup_by_phandle(node, "rockchip,grf");
+	if (!IS_ERR(i2s->grf)) {
+		of_id = of_match_device(rockchip_i2s_match, &pdev->dev);
+		if (!of_id || !of_id->data)
+			return -EINVAL;
+
+		i2s->pins = of_id->data;
+	}
+
 	/* try to prepare related clocks */
 	i2s->hclk = devm_clk_get(&pdev->dev, "i2s_hclk");
 	if (IS_ERR(i2s->hclk)) {
@@ -517,7 +575,6 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 	i2s->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	i2s->capture_dma_data.maxburst = 4;
 
-	i2s->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, i2s);
 
 	pm_runtime_enable(&pdev->dev);
@@ -583,14 +640,6 @@ static int rockchip_i2s_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id rockchip_i2s_match[] = {
-	{ .compatible = "rockchip,rk3066-i2s", },
-	{ .compatible = "rockchip,rk3188-i2s", },
-	{ .compatible = "rockchip,rk3288-i2s", },
-	{ .compatible = "rockchip,rk3399-i2s", },
-	{},
-};
-
 static const struct dev_pm_ops rockchip_i2s_pm_ops = {
 	SET_RUNTIME_PM_OPS(i2s_runtime_suspend, i2s_runtime_resume,
 			   NULL)
diff --git a/sound/soc/rockchip/rockchip_i2s.h b/sound/soc/rockchip/rockchip_i2s.h
index dc6e2c74d088..8e239d301bc7 100644
--- a/sound/soc/rockchip/rockchip_i2s.h
+++ b/sound/soc/rockchip/rockchip_i2s.h
@@ -236,4 +236,11 @@ enum {
 #define I2S_TXDR	(0x0024)
 #define I2S_RXDR	(0x0028)
 
+/* io direction cfg register */
+#define I2S_IO_DIRECTION_MASK	(7)
+#define I2S_IO_8CH_OUT_2CH_IN	(0)
+#define I2S_IO_6CH_OUT_4CH_IN	(4)
+#define I2S_IO_4CH_OUT_6CH_IN	(6)
+#define I2S_IO_2CH_OUT_8CH_IN	(7)
+
 #endif /* _ROCKCHIP_IIS_H */
-- 
2.8.0.rc3
