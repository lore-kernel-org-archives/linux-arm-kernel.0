From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 04 Aug 2013 20:27:03 +0100
Subject: [PATCH RFC 06/13] ASoC: kirkwood: combine kirkwood-i2s and
 kirkwood-dma drivers
In-Reply-To: <20130804192136.GK23006@n2100.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
Message-ID: <E1V63xH-0004lZ-TX@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These really should be a single driver because they're fully integrated
in hardware.  Make them so.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-dove/common.c          |    4 ++--
 arch/arm/mach-kirkwood/common.c      |   24 +++++++++---------------
 sound/soc/kirkwood/Kconfig           |    5 -----
 sound/soc/kirkwood/Makefile          |    4 +---
 sound/soc/kirkwood/kirkwood-dma.c    |   30 +-----------------------------
 sound/soc/kirkwood/kirkwood-i2s.c    |   21 ++++++++++++++++-----
 sound/soc/kirkwood/kirkwood-openrd.c |    4 ++--
 sound/soc/kirkwood/kirkwood-t5325.c  |    4 ++--
 sound/soc/kirkwood/kirkwood.h        |    2 ++
 9 files changed, 35 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index e2b5da0..68a2d6a 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -109,8 +109,8 @@ static void __init dove_clk_init(void)
 	orion_clkdev_add(NULL, "sdhci-dove.1", sdio1);
 	orion_clkdev_add(NULL, "orion_nand", nand);
 	orion_clkdev_add(NULL, "cafe1000-ccic.0", camera);
-	orion_clkdev_add(NULL, "kirkwood-i2s.0", i2s0);
-	orion_clkdev_add(NULL, "kirkwood-i2s.1", i2s1);
+	orion_clkdev_add(NULL, "mvebu-audio.0", i2s0);
+	orion_clkdev_add(NULL, "mvebu-audio.1", i2s1);
 	orion_clkdev_add(NULL, "mv_crypto", crypto);
 	orion_clkdev_add(NULL, "dove-ac97", ac97);
 	orion_clkdev_add(NULL, "dove-pdma", pdma);
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index f389228..d24d39d 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -263,7 +263,7 @@ void __init kirkwood_clk_init(void)
 	orion_clkdev_add(NULL, MV_XOR_NAME ".1", xor1);
 	orion_clkdev_add("0", "pcie", pex0);
 	orion_clkdev_add("1", "pcie", pex1);
-	orion_clkdev_add(NULL, "kirkwood-i2s", audio);
+	orion_clkdev_add(NULL, "mvebu-audio", audio);
 	orion_clkdev_add(NULL, MV64XXX_I2C_CTLR_NAME ".0", runit);
 	orion_clkdev_add(NULL, MV64XXX_I2C_CTLR_NAME ".1", runit);
 
@@ -559,7 +559,7 @@ void __init kirkwood_timer_init(void)
 /*****************************************************************************
  * Audio
  ****************************************************************************/
-static struct resource kirkwood_i2s_resources[] = {
+static struct resource kirkwood_audio_resources[] = {
 	[0] = {
 		.start  = AUDIO_PHYS_BASE,
 		.end    = AUDIO_PHYS_BASE + SZ_16K - 1,
@@ -572,29 +572,23 @@ static struct resource kirkwood_i2s_resources[] = {
 	},
 };
 
-static struct kirkwood_asoc_platform_data kirkwood_i2s_data = {
+static struct kirkwood_asoc_platform_data kirkwood_audio_data = {
 	.burst       = 128,
 };
 
-static struct platform_device kirkwood_i2s_device = {
-	.name		= "kirkwood-i2s",
+static struct platform_device kirkwood_audio_device = {
+	.name		= "mvebu-audio",
 	.id		= -1,
-	.num_resources	= ARRAY_SIZE(kirkwood_i2s_resources),
-	.resource	= kirkwood_i2s_resources,
+	.num_resources	= ARRAY_SIZE(kirkwood_audio_resources),
+	.resource	= kirkwood_audio_resources,
 	.dev		= {
-		.platform_data	= &kirkwood_i2s_data,
+		.platform_data	= &kirkwood_audio_data,
 	},
 };
 
-static struct platform_device kirkwood_pcm_device = {
-	.name		= "kirkwood-pcm-audio",
-	.id		= -1,
-};
-
 void __init kirkwood_audio_init(void)
 {
-	platform_device_register(&kirkwood_i2s_device);
-	platform_device_register(&kirkwood_pcm_device);
+	platform_device_register(&kirkwood_audio_device);
 }
 
 /*****************************************************************************
diff --git a/sound/soc/kirkwood/Kconfig b/sound/soc/kirkwood/Kconfig
index c62d715..b6917a7 100644
--- a/sound/soc/kirkwood/Kconfig
+++ b/sound/soc/kirkwood/Kconfig
@@ -6,14 +6,10 @@ config SND_KIRKWOOD_SOC
 	  the Kirkwood I2S interface. You will also need to select the
 	  audio interfaces to support below.
 
-config SND_KIRKWOOD_SOC_I2S
-	tristate
-
 config SND_KIRKWOOD_SOC_OPENRD
 	tristate "SoC Audio support for Kirkwood Openrd Client"
 	depends on SND_KIRKWOOD_SOC && (MACH_OPENRD_CLIENT || MACH_OPENRD_ULTIMATE)
 	depends on I2C
-	select SND_KIRKWOOD_SOC_I2S
 	select SND_SOC_CS42L51
 	help
 	  Say Y if you want to add support for SoC audio on
@@ -22,7 +18,6 @@ config SND_KIRKWOOD_SOC_OPENRD
 config SND_KIRKWOOD_SOC_T5325
 	tristate "SoC Audio support for HP t5325"
 	depends on SND_KIRKWOOD_SOC && MACH_T5325 && I2C
-	select SND_KIRKWOOD_SOC_I2S
 	select SND_SOC_ALC5623
 	help
 	  Say Y if you want to add support for SoC audio on
diff --git a/sound/soc/kirkwood/Makefile b/sound/soc/kirkwood/Makefile
index 3e62ae9..9e78138 100644
--- a/sound/soc/kirkwood/Makefile
+++ b/sound/soc/kirkwood/Makefile
@@ -1,8 +1,6 @@
-snd-soc-kirkwood-objs := kirkwood-dma.o
-snd-soc-kirkwood-i2s-objs := kirkwood-i2s.o
+snd-soc-kirkwood-objs := kirkwood-dma.o kirkwood-i2s.o
 
 obj-$(CONFIG_SND_KIRKWOOD_SOC) += snd-soc-kirkwood.o
-obj-$(CONFIG_SND_KIRKWOOD_SOC_I2S) += snd-soc-kirkwood-i2s.o
 
 snd-soc-openrd-objs := kirkwood-openrd.o
 snd-soc-t5325-objs := kirkwood-t5325.o
diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index 112c262..2091d55 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -334,36 +334,8 @@ static void kirkwood_dma_free_dma_buffers(struct snd_pcm *pcm)
 	}
 }
 
-static struct snd_soc_platform_driver kirkwood_soc_platform = {
+struct snd_soc_platform_driver kirkwood_soc_platform = {
 	.ops		= &kirkwood_dma_ops,
 	.pcm_new	= kirkwood_dma_new,
 	.pcm_free	= kirkwood_dma_free_dma_buffers,
 };
-
-static int kirkwood_soc_platform_probe(struct platform_device *pdev)
-{
-	return snd_soc_register_platform(&pdev->dev, &kirkwood_soc_platform);
-}
-
-static int kirkwood_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
-}
-
-static struct platform_driver kirkwood_pcm_driver = {
-	.driver = {
-			.name = "kirkwood-pcm-audio",
-			.owner = THIS_MODULE,
-	},
-
-	.probe = kirkwood_soc_platform_probe,
-	.remove = kirkwood_soc_platform_remove,
-};
-
-module_platform_driver(kirkwood_pcm_driver);
-
-MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>");
-MODULE_DESCRIPTION("Marvell Kirkwood Audio DMA module");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:kirkwood-pcm-audio");
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index f39e57c..84dd9b0 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -24,7 +24,7 @@
 #include <linux/platform_data/asoc-kirkwood.h>
 #include "kirkwood.h"
 
-#define DRV_NAME	"kirkwood-i2s"
+#define DRV_NAME	"mvebu-audio"
 
 #define KIRKWOOD_I2S_RATES \
 	(SNDRV_PCM_RATE_44100 | \
@@ -523,10 +523,20 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 
 	err = snd_soc_register_component(&pdev->dev, &kirkwood_i2s_component,
 					 soc_dai, 1);
-	if (!err)
-		return 0;
-	dev_err(&pdev->dev, "snd_soc_register_component failed\n");
+	if (err) {
+		dev_err(&pdev->dev, "snd_soc_register_component failed\n");
+		goto err_component;
+	}
 
+	err = snd_soc_register_platform(&pdev->dev, &kirkwood_soc_platform);
+	if (err) {
+		dev_err(&pdev->dev, "snd_soc_register_platform failed\n");
+		goto err_platform;
+	}
+	return 0;
+ err_platform:
+	snd_soc_unregister_component(&pdev->dev);
+ err_component:
 	if (!IS_ERR(priv->extclk))
 		clk_disable_unprepare(priv->extclk);
 	clk_disable_unprepare(priv->clk);
@@ -538,6 +548,7 @@ static int kirkwood_i2s_dev_remove(struct platform_device *pdev)
 {
 	struct kirkwood_dma_data *priv = dev_get_drvdata(&pdev->dev);
 
+	snd_soc_unregister_platform(&pdev->dev);
 	snd_soc_unregister_component(&pdev->dev);
 
 	if (!IS_ERR(priv->extclk))
@@ -562,4 +573,4 @@ module_platform_driver(kirkwood_i2s_driver);
 MODULE_AUTHOR("Arnaud Patard, <arnaud.patard@rtp-net.org>");
 MODULE_DESCRIPTION("Kirkwood I2S SoC Interface");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:kirkwood-i2s");
+MODULE_ALIAS("platform:mvebu-audio");
diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/kirkwood-openrd.c
index b979c71..a25dfcf 100644
--- a/sound/soc/kirkwood/kirkwood-openrd.c
+++ b/sound/soc/kirkwood/kirkwood-openrd.c
@@ -54,8 +54,8 @@ static struct snd_soc_dai_link openrd_client_dai[] = {
 {
 	.name = "CS42L51",
 	.stream_name = "CS42L51 HiFi",
-	.cpu_dai_name = "kirkwood-i2s",
-	.platform_name = "kirkwood-pcm-audio",
+	.cpu_dai_name = "mvebu-audio",
+	.platform_name = "mvebu-audio",
 	.codec_dai_name = "cs42l51-hifi",
 	.codec_name = "cs42l51-codec.0-004a",
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS,
diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/kirkwood-t5325.c
index 1d0ed6f..82a8c5f 100644
--- a/sound/soc/kirkwood/kirkwood-t5325.c
+++ b/sound/soc/kirkwood/kirkwood-t5325.c
@@ -70,8 +70,8 @@ static struct snd_soc_dai_link t5325_dai[] = {
 {
 	.name = "ALC5621",
 	.stream_name = "ALC5621 HiFi",
-	.cpu_dai_name = "kirkwood-i2s",
-	.platform_name = "kirkwood-pcm-audio",
+	.cpu_dai_name = "mvebu-audio",
+	.platform_name = "mvebu-audio",
 	.codec_dai_name = "alc5621-hifi",
 	.codec_name = "alc562x-codec.0-001a",
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS,
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index 9a50607..1d13dee 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -138,4 +138,6 @@ struct kirkwood_dma_data {
 	int burst;
 };
 
+extern struct snd_soc_platform_driver kirkwood_soc_platform;
+
 #endif
-- 
1.7.4.4
