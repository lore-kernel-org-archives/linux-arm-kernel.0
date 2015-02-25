From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 25 Feb 2015 22:57:59 +0100
Subject: [PATCH 1/4] ASoC: kirkwood: enable Kirkwood driver for Armada 38x
 platforms
In-Reply-To: <1424901482-3809-1-git-send-email-mw@semihalf.com>
References: <y>
 <1424901482-3809-1-git-send-email-mw@semihalf.com>
Message-ID: <1424901482-3809-2-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The audio unit of Marvell Armada38x SoC is similar to the ones comprised by
other Marvell SoCs (Kirkwood, Dove and Armada 370). Therefore Kirkwood audio
driver can be used to support it and this commit adds new compatible string
to identify Armada 38x variant.

Two new memory regions are added: first one for PLL configuration and
the second one for choosing one of audio I/O modes (I2S or S/PDIF).
For the latter purpose a new optional DT property is added ('spdif-mode').

kirkwood-i2s driver is extended by adding a new init function for Armada
38x flavor and also a routine that enables PLL output (i.e. MCLK)
configuration.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 .../devicetree/bindings/sound/mvebu-audio.txt      |  14 ++-
 sound/soc/kirkwood/kirkwood-i2s.c                  | 132 ++++++++++++++++++++-
 sound/soc/kirkwood/kirkwood.h                      |   2 +
 3 files changed, 145 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mvebu-audio.txt b/Documentation/devicetree/bindings/sound/mvebu-audio.txt
index cb8c07c..4f5dec5 100644
--- a/Documentation/devicetree/bindings/sound/mvebu-audio.txt
+++ b/Documentation/devicetree/bindings/sound/mvebu-audio.txt
@@ -6,9 +6,14 @@ Required properties:
   "marvell,kirkwood-audio" for Kirkwood platforms
   "marvell,dove-audio" for Dove platforms
   "marvell,armada370-audio" for Armada 370 platforms
+  "marvell,armada-380-audio" for Armada 38x platforms
 
 - reg: physical base address of the controller and length of memory mapped
-  region.
+  region (named "i2s_regs").
+  With "marvell,armada-380-audio" two other regions are required:
+  first of those is dedicated for Audio PLL Configuration registers
+  (named "pll_regs") and the second one ("soc_ctrl") - for register
+  where one of exceptive I/O types (I2S or S/PDIF) is set.
 
 - interrupts:
   with "marvell,kirkwood-audio", the audio interrupt
@@ -23,6 +28,13 @@ Required properties:
 	"internal" for the internal clock
 	"extclk" for the external clock
 
+Optional properties:
+
+- spdif-mode:
+  Enable S/PDIF mode on Armada 38x SoC. Using this property
+  disables standard I2S I/O. Valid only with "marvell,armada-380-audio"
+  compatible string.
+
 Example:
 
 i2s1: audio-controller at b4000 {
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index def7d82..8818861 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -37,6 +37,124 @@
 	(SNDRV_PCM_FMTBIT_S16_LE | \
 	 SNDRV_PCM_FMTBIT_S24_LE)
 
+/* These registers are relative to the second register region -
+ * audio pll configuration.
+ */
+#define A38X_PLL_CONF_REG0			0x0
+#define     A38X_PLL_FB_CLK_DIV_OFFSET		10
+#define     A38X_PLL_FB_CLK_DIV_MASK		0x7fc00
+#define A38X_PLL_CONF_REG1			0x4
+#define     A38X_PLL_FREQ_OFFSET_MASK		0xffff
+#define     A38X_PLL_FREQ_OFFSET_VALID		BIT(16)
+#define     A38X_PLL_SW_RESET			BIT(31)
+#define A38X_PLL_CONF_REG2			0x8
+#define     A38X_PLL_AUDIO_POSTDIV_MASK		0x7f
+
+/* Bit below belongs to SoC control register corresponding to the third
+ * register region.
+ */
+#define A38X_SPDIF_MODE_ENABLE			BIT(27)
+
+static int armada_38x_i2s_init_quirk(struct platform_device *pdev,
+				     struct kirkwood_dma_data *priv,
+				     struct snd_soc_dai_driver *dai_drv)
+{
+	struct resource *mem;
+	u32 reg_val;
+	int i;
+
+	mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pll_regs");
+	priv->pll_config = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(priv->pll_config))
+		return -ENOMEM;
+
+	mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "soc_ctrl");
+	priv->soc_control = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(priv->soc_control))
+		return -ENOMEM;
+
+	/* Select one of exceptive modes: I2S or S/PDIF */
+	reg_val = readl(priv->soc_control);
+	if (of_property_read_bool(np, "spdif-mode")) {
+		reg_val |= A38X_SPDIF_MODE_ENABLE;
+		dev_info(&pdev->dev, "using S/PDIF mode\n");
+	} else {
+		reg_val &= ~A38X_SPDIF_MODE_ENABLE;
+		dev_info(&pdev->dev, "using I2S mode\n");
+	}
+	writel(reg_val, priv->soc_control);
+
+	/* Update available rates of mclk's fs */
+	for (i = 0; i < 2; i++) {
+		dai_drv[i].playback.rates |= SNDRV_PCM_RATE_192000;
+		dai_drv[i].capture.rates |= SNDRV_PCM_RATE_192000;
+	}
+
+	return 0;
+}
+
+static inline void armada_38x_set_pll(void __iomem *base, unsigned long rate)
+{
+	u32 reg_val;
+	u16 freq_offset = 0x22b0;
+	u8 audio_postdiv, fb_clk_div = 0x1d;
+
+	/* Set frequency offset value to not valid and enable PLL reset */
+	reg_val = readl(base + A38X_PLL_CONF_REG1);
+	reg_val &= ~A38X_PLL_FREQ_OFFSET_VALID;
+	reg_val &= ~A38X_PLL_SW_RESET;
+	writel(reg_val, base + A38X_PLL_CONF_REG1);
+
+	udelay(1);
+
+	/* Update PLL parameters */
+	switch (rate) {
+	default:
+	case 44100:
+		freq_offset = 0x735;
+		fb_clk_div = 0x1b;
+		audio_postdiv = 0xc;
+		break;
+	case 48000:
+		audio_postdiv = 0xc;
+		break;
+	case 96000:
+		audio_postdiv = 0x6;
+		break;
+	case 192000:
+		audio_postdiv = 0x3;
+		break;
+	}
+
+	reg_val = readl(base + A38X_PLL_CONF_REG0);
+	reg_val &= ~A38X_PLL_FB_CLK_DIV_MASK;
+	reg_val |= (fb_clk_div << A38X_PLL_FB_CLK_DIV_OFFSET);
+	writel(reg_val, base + A38X_PLL_CONF_REG0);
+
+	reg_val = readl(base + A38X_PLL_CONF_REG2);
+	reg_val &= ~A38X_PLL_AUDIO_POSTDIV_MASK;
+	reg_val |= audio_postdiv;
+	writel(reg_val, base + A38X_PLL_CONF_REG2);
+
+	reg_val = readl(base + A38X_PLL_CONF_REG1);
+	reg_val &= ~A38X_PLL_FREQ_OFFSET_MASK;
+	reg_val |= freq_offset;
+	writel(reg_val, base + A38X_PLL_CONF_REG1);
+
+	udelay(1);
+
+	/* Disable reset */
+	reg_val |= A38X_PLL_SW_RESET;
+	writel(reg_val, base + A38X_PLL_CONF_REG1);
+
+	/* Wait 50us for PLL to lock */
+	udelay(50);
+
+	/* Restore frequency offset value validity */
+	reg_val |= A38X_PLL_FREQ_OFFSET_VALID;
+	writel(reg_val, base + A38X_PLL_CONF_REG1);
+}
+
 static int kirkwood_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
 {
@@ -112,7 +230,10 @@ static void kirkwood_set_rate(struct snd_soc_dai *dai,
 		 * defined in kirkwood_i2s_dai */
 		dev_dbg(dai->dev, "%s: dco set rate = %lu\n",
 			__func__, rate);
-		kirkwood_set_dco(priv->io, rate);
+		if (priv->pll_config)
+			armada_38x_set_pll(priv->pll_config, rate);
+		else
+			kirkwood_set_dco(priv->io, rate);
 
 		clks_ctrl = KIRKWOOD_MCLK_SOURCE_DCO;
 	} else {
@@ -544,7 +665,7 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 	}
 	dev_set_drvdata(&pdev->dev, priv);
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "i2s_regs");
 	priv->io = devm_ioremap_resource(&pdev->dev, mem);
 	if (IS_ERR(priv->io))
 		return PTR_ERR(priv->io);
@@ -555,6 +676,12 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	if (of_device_is_compatible(np, "marvell,armada-380-audio")) {
+		err = armada_38x_i2s_init_quirk(pdev, priv, soc_dai);
+		if (err < 0)
+			return err;
+	}
+
 	if (np) {
 		priv->burst = 128;		/* might be 32 or 128 */
 	} else if (data) {
@@ -647,6 +774,7 @@ static struct of_device_id mvebu_audio_of_match[] = {
 	{ .compatible = "marvell,kirkwood-audio" },
 	{ .compatible = "marvell,dove-audio" },
 	{ .compatible = "marvell,armada370-audio" },
+	{ .compatible = "marvell,armada-380-audio" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mvebu_audio_of_match);
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index 90e32a7..0bb6dc6 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -133,6 +133,8 @@
 
 struct kirkwood_dma_data {
 	void __iomem *io;
+	void __iomem *pll_config;
+	void __iomem *soc_control;
 	struct clk *clk;
 	struct clk *extclk;
 	uint32_t ctl_play;
-- 
1.8.3.1
