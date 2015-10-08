From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Thu,  8 Oct 2015 20:40:07 +0800
Subject: [PATCH v2 1/3] ASoC: rockchip: i2s: add 8 channels capture support
In-Reply-To: <1444308009-29088-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1444308009-29088-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <1444308009-29088-2-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

support max 8 channels capture, please add property
'rockchip,capture-channels' in dts to enable this,
if not, support 2 channels capture default.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

Changes in v2: 
- remove lrck mode, and move it to new patch

 sound/soc/rockchip/rockchip_i2s.c | 40 +++++++++++++++++++++++++++++++++++++--
 sound/soc/rockchip/rockchip_i2s.h | 10 ++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index b936102..f07833b 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -245,8 +245,34 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	regmap_update_bits(i2s->regmap, I2S_TXCR, I2S_TXCR_VDW_MASK, val);
-	regmap_update_bits(i2s->regmap, I2S_RXCR, I2S_RXCR_VDW_MASK, val);
+	switch (params_channels(params)) {
+	case 8:
+		val |= I2S_CHN_8;
+		break;
+	case 6:
+		val |= I2S_CHN_6;
+		break;
+	case 4:
+		val |= I2S_CHN_4;
+		break;
+	case 2:
+		val |= I2S_CHN_2;
+		break;
+	default:
+		dev_err(i2s->dev, "invalid channel: %d\n",
+			params_channels(params));
+		return -EINVAL;
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		regmap_update_bits(i2s->regmap, I2S_RXCR,
+				   I2S_RXCR_VDW_MASK | I2S_RXCR_CSR_MASK,
+				   val);
+	else
+		regmap_update_bits(i2s->regmap, I2S_TXCR,
+				   I2S_TXCR_VDW_MASK | I2S_TXCR_CSR_MASK,
+				   val);
+
 	regmap_update_bits(i2s->regmap, I2S_DMACR, I2S_DMACR_TDL_MASK,
 			   I2S_DMACR_TDL(16));
 	regmap_update_bits(i2s->regmap, I2S_DMACR, I2S_DMACR_RDL_MASK,
@@ -415,10 +441,12 @@ static const struct regmap_config rockchip_i2s_regmap_config = {
 
 static int rockchip_i2s_probe(struct platform_device *pdev)
 {
+	struct device_node *node = pdev->dev.of_node;
 	struct rk_i2s_dev *i2s;
 	struct resource *res;
 	void __iomem *regs;
 	int ret;
+	int val;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
 	if (!i2s) {
@@ -475,6 +503,14 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
+	/* refine capture channels */
+	if (!of_property_read_u32(node, "rockchip,capture-channels", &val)) {
+		if (val >= 2 && val <= 8)
+			rockchip_i2s_dai.capture.channels_max = val;
+		else
+			rockchip_i2s_dai.capture.channels_max = 2;
+	}
+
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &rockchip_i2s_component,
 					      &rockchip_i2s_dai, 1);
diff --git a/sound/soc/rockchip/rockchip_i2s.h b/sound/soc/rockchip/rockchip_i2s.h
index 93f456f..a54ee35 100644
--- a/sound/soc/rockchip/rockchip_i2s.h
+++ b/sound/soc/rockchip/rockchip_i2s.h
@@ -49,6 +49,9 @@
  * RXCR
  * receive operation control register
 */
+#define I2S_RXCR_CSR_SHIFT	15
+#define I2S_RXCR_CSR(x)		(x << I2S_RXCR_CSR_SHIFT)
+#define I2S_RXCR_CSR_MASK	(3 << I2S_RXCR_CSR_SHIFT)
 #define I2S_RXCR_HWT		BIT(14)
 #define I2S_RXCR_SJM_SHIFT	12
 #define I2S_RXCR_SJM_R		(0 << I2S_RXCR_SJM_SHIFT)
@@ -207,6 +210,13 @@ enum {
 	ROCKCHIP_DIV_BCLK,
 };
 
+/* channel select */
+#define I2S_CSR_SHIFT	15
+#define I2S_CHN_2	(0 << I2S_CSR_SHIFT)
+#define I2S_CHN_4	(1 << I2S_CSR_SHIFT)
+#define I2S_CHN_6	(2 << I2S_CSR_SHIFT)
+#define I2S_CHN_8	(3 << I2S_CSR_SHIFT)
+
 /* I2S REGS */
 #define I2S_TXCR	(0x0000)
 #define I2S_RXCR	(0x0004)
-- 
2.3.6
