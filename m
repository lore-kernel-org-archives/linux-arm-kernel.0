From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Wed,  6 Apr 2016 16:38:22 +0800
Subject: [PATCH] ASoC: rockchip: i2s: configure the sdio pins' iomux mode
Message-ID: <1459931902-77324-1-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are 3 i2s sdio pins, which iomux mode is as follows:

 - sdi3_sdo1
 - sdi2_sdo2
 - sdi1_sdo3

we need to configure these pins' iomux mode via the GRF register
when use multi channel playback/capture.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 .../devicetree/bindings/sound/rockchip-i2s.txt     |  5 +++
 sound/soc/rockchip/rockchip_i2s.c                  | 39 +++++++++++++++++++++-
 sound/soc/rockchip/rockchip_i2s.h                  |  8 +++++
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 6e86d8a..ad72a7d 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -23,6 +23,11 @@ Required properties:
 - rockchip,playback-channels: max playback channels, if not set, 8 channels default.
 - rockchip,capture-channels: max capture channels, if not set, 2 channels default.
 
+Required properties for controller which support multi channels playback/capture:
+
+- rockchip,grf: Should be phandle/offset pair. the phandle of the syscon node for GRF register,
+  and the offset of the GRF for control register.
+
 Example for rk3288 I2S controller:
 
 i2s at ff890000 {
diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 2f8e204..bc72780 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mfd/syscon.h>
 #include <linux/delay.h>
 #include <linux/of_gpio.h>
 #include <linux/clk.h>
@@ -33,6 +34,8 @@ struct rk_i2s_dev {
 	struct snd_dmaengine_dai_dma_data playback_dma_data;
 
 	struct regmap *regmap;
+	struct regmap *grf;
+	u32 iocfg_reg;
 
 	bool is_master_mode;
 };
@@ -277,6 +280,29 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 				   I2S_TXCR_VDW_MASK | I2S_TXCR_CSR_MASK,
 				   val);
 
+	if (!IS_ERR(i2s->grf)) {
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
+		regmap_write(i2s->grf, i2s->iocfg_reg,
+			     I2S_IO_DIRECTION_MASK << 16 | val);
+	}
+
 	regmap_update_bits(i2s->regmap, I2S_DMACR, I2S_DMACR_TDL_MASK,
 			   I2S_DMACR_TDL(16));
 	regmap_update_bits(i2s->regmap, I2S_DMACR, I2S_DMACR_RDL_MASK,
@@ -478,6 +504,18 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	i2s->dev = &pdev->dev;
+
+	i2s->grf = syscon_regmap_lookup_by_phandle(node, "rockchip,grf");
+	if (!IS_ERR(i2s->grf)) {
+		ret = of_property_read_u32_index(node, "rockchip,grf",
+						 1, &i2s->iocfg_reg);
+		if (ret) {
+			dev_err(&pdev->dev, "Can't get iocfg_reg offset\n");
+			return ret;
+		}
+	}
+
 	/* try to prepare related clocks */
 	i2s->hclk = devm_clk_get(&pdev->dev, "i2s_hclk");
 	if (IS_ERR(i2s->hclk)) {
@@ -517,7 +555,6 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 	i2s->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	i2s->capture_dma_data.maxburst = 4;
 
-	i2s->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, i2s);
 
 	pm_runtime_enable(&pdev->dev);
diff --git a/sound/soc/rockchip/rockchip_i2s.h b/sound/soc/rockchip/rockchip_i2s.h
index dc6e2c7..9a6aabf 100644
--- a/sound/soc/rockchip/rockchip_i2s.h
+++ b/sound/soc/rockchip/rockchip_i2s.h
@@ -236,4 +236,12 @@ enum {
 #define I2S_TXDR	(0x0024)
 #define I2S_RXDR	(0x0028)
 
+/* io direction cfg register */
+#define I2S_IO_DIRECTION_SHIFT	11
+#define I2S_IO_DIRECTION_MASK	(7 << I2S_IO_DIRECTION_SHIFT)
+#define I2S_IO_8CH_OUT_2CH_IN	(0 << I2S_IO_DIRECTION_SHIFT)
+#define I2S_IO_6CH_OUT_4CH_IN	(1 << I2S_IO_DIRECTION_SHIFT)
+#define I2S_IO_4CH_OUT_6CH_IN	(3 << I2S_IO_DIRECTION_SHIFT)
+#define I2S_IO_2CH_OUT_8CH_IN	(7 << I2S_IO_DIRECTION_SHIFT)
+
 #endif /* _ROCKCHIP_IIS_H */
-- 
1.9.1
