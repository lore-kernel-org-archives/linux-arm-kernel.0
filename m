From: voice.shen@atmel.com (Bo Shen)
Date: Tue,  6 Nov 2012 13:57:53 +0800
Subject: [RFC patch v3 3/4] ASoC: atmel-ssc-dai: register dai and pcm directly
In-Reply-To: <1352181474-19597-1-git-send-email-voice.shen@atmel.com>
References: <1352181474-19597-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1352181474-19597-3-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register dai and pcm directly
fix issue when register dai and pcm directly
Add device tree support
 
Signed-off-by: Bo Shen <voice.shen@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Change since v2
  - Register dai and pcm directly according to Mark Brown's suggestion
    - using name to distinguish ssc register for audio or library
      if for audio, the name with dai subfix
      if for library, the name without dai subfix
  - fix the issue for sam9g20-wm8731
    - when register dai and pcm cause the sam9g20-wm8731 doesn't work,
      so fix it
  - Add device tree support
    - Detail information reference atmel-ssc-dai.txt binding document
Change since v1
  No change
---
 .../devicetree/bindings/sound/atmel-ssc-dai.txt    |   15 +
 arch/arm/mach-at91/at91sam9260.c                   |    2 +-
 arch/arm/mach-at91/at91sam9260_devices.c           |    5 +-
 arch/arm/mach-at91/board-sam9g20ek.c               |    6 -
 sound/soc/atmel/Kconfig                            |    3 +-
 sound/soc/atmel/atmel-pcm.c                        |   23 +-
 sound/soc/atmel/atmel-pcm.h                        |    3 +
 sound/soc/atmel/atmel_ssc_dai.c                    |  319 +++++++++-----------
 sound/soc/atmel/sam9g20_wm8731.c                   |    4 +-
 9 files changed, 175 insertions(+), 205 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-ssc-dai.txt

diff --git a/Documentation/devicetree/bindings/sound/atmel-ssc-dai.txt b/Documentation/devicetree/bindings/sound/atmel-ssc-dai.txt
new file mode 100644
index 0000000..48ec22a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel-ssc-dai.txt
@@ -0,0 +1,15 @@
+* Atmel SSC audio driver.
+
+Required properties:
+- compatible: "atmel,at91rm9200-ssc-dai" or "atmel,at91sam9g45-ssc-dai"
+	- atmel,at91rm9200-ssc-dai: support pdc transfer
+	- atmel,at91sam9g45-ssc-dai: support dma transfer
+- reg: Should contain SSC registers location and length
+- interrupts: Should contain SSC interrupt
+
+Example:
+ssc0: ssc at fffbc000 {
+	compatible = "atmel,at91rm9200-ssc-dai";
+	reg = <0xfffbc000 0x4000>;
+	interrupts = <14 4 5>;
+};
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 54d4aea..859526d 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -210,7 +210,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.1", &tc3_clk),
 	CLKDEV_CON_DEV_ID("t1_clk", "atmel_tcb.1", &tc4_clk),
 	CLKDEV_CON_DEV_ID("t2_clk", "atmel_tcb.1", &tc5_clk),
-	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc.0", &ssc_clk),
+	CLKDEV_CON_DEV_ID("pclk", "at91rm9200_ssc_dai.0", &ssc_clk),
 	CLKDEV_CON_DEV_ID("pclk", "fffbc000.ssc", &ssc_clk),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91sam9260", &twi_clk),
 	CLKDEV_CON_DEV_ID(NULL, "i2c-at91sam9g20", &twi_clk),
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 9cfdc3f..c7ad6ee 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -725,7 +725,8 @@ static void __init at91_add_device_watchdog(void) {}
  *  SSC -- Synchronous Serial Controller
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_ATMEL_SSC) || defined(CONFIG_ATMEL_SSC_MODULE)
+#if defined(CONFIG_ATMEL_SSC) || defined(CONFIG_ATMEL_SSC_MODULE) || \
+	defined(CONFIG_SND_ATMEL_SOC) || defined(CONFIG_SND_ATMEL_SOC_MODULE)
 static u64 ssc_dmamask = DMA_BIT_MASK(32);
 
 static struct resource ssc_resources[] = {
@@ -742,7 +743,7 @@ static struct resource ssc_resources[] = {
 };
 
 static struct platform_device at91sam9260_ssc_device = {
-	.name	= "at91rm9200_ssc",
+	.name	= "at91rm9200_ssc_dai",
 	.id	= 0,
 	.dev	= {
 		.dma_mask		= &ssc_dmamask,
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 5b6a6f9..ebdbf42 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -353,11 +353,6 @@ static struct i2c_board_info __initdata ek_i2c_devices[] = {
         },
 };
 
-static struct platform_device sam9g20ek_pcm_device = {
-	.name	= "atmel-pcm-audio",
-	.id = -1,
-};
-
 static struct platform_device sam9g20ek_audio_device = {
 	.name   = "at91sam9g20ek-audio",
 	.id     = -1,
@@ -365,7 +360,6 @@ static struct platform_device sam9g20ek_audio_device = {
 
 static void __init ek_add_device_audio(void)
 {
-	platform_device_register(&sam9g20ek_pcm_device);
 	platform_device_register(&sam9g20ek_audio_device);
 }
 
diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 72b09cf..b51ba54 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -16,8 +16,7 @@ config SND_ATMEL_SOC_SSC
 
 config SND_AT91_SOC_SAM9G20_WM8731
 	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
-	depends on ATMEL_SSC && ARCH_AT91SAM9G20 && SND_ATMEL_SOC && \
-                   AT91_PROGRAMMABLE_CLOCKS
+	depends on SND_ATMEL_SOC && AT91_PROGRAMMABLE_CLOCKS
 	select SND_ATMEL_SOC_SSC
 	select SND_SOC_WM8731
 	help
diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
index 9b84f98..1e9cd2c 100644
--- a/sound/soc/atmel/atmel-pcm.c
+++ b/sound/soc/atmel/atmel-pcm.c
@@ -473,28 +473,17 @@ static struct snd_soc_platform_driver atmel_soc_platform = {
 	.resume		= atmel_pcm_resume,
 };
 
-static int __devinit atmel_soc_platform_probe(struct platform_device *pdev)
+int __devinit atmel_pcm_platform_register(struct device *dev)
 {
-	return snd_soc_register_platform(&pdev->dev, &atmel_soc_platform);
+	return snd_soc_register_platform(dev, &atmel_soc_platform);
 }
+EXPORT_SYMBOL(atmel_pcm_platform_register);
 
-static int __devexit atmel_soc_platform_remove(struct platform_device *pdev)
+void __devexit atmel_pcm_platform_unregister(struct device *dev)
 {
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
+	snd_soc_unregister_platform(dev);
 }
-
-static struct platform_driver atmel_pcm_driver = {
-	.driver = {
-			.name = "atmel-pcm-audio",
-			.owner = THIS_MODULE,
-	},
-
-	.probe = atmel_soc_platform_probe,
-	.remove = __devexit_p(atmel_soc_platform_remove),
-};
-
-module_platform_driver(atmel_pcm_driver);
+EXPORT_SYMBOL(atmel_pcm_platform_unregister);
 
 MODULE_AUTHOR("Sedji Gaouaou <sedji.gaouaou@atmel.com>");
 MODULE_DESCRIPTION("Atmel PCM module");
diff --git a/sound/soc/atmel/atmel-pcm.h b/sound/soc/atmel/atmel-pcm.h
index 5e0a95e..e6d67b3 100644
--- a/sound/soc/atmel/atmel-pcm.h
+++ b/sound/soc/atmel/atmel-pcm.h
@@ -80,4 +80,7 @@ struct atmel_pcm_dma_params {
 #define ssc_readx(base, reg)            (__raw_readl((base) + (reg)))
 #define ssc_writex(base, reg, value)    __raw_writel((value), (base) + (reg))
 
+int atmel_pcm_platform_register(struct device *dev);
+void atmel_pcm_platform_unregister(struct device *dev);
+
 #endif /* _ATMEL_PCM_H */
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 354341e..81e3604 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -42,18 +42,13 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
+#include <linux/of.h>
+
 #include <mach/hardware.h>
 
 #include "atmel-pcm.h"
 #include "atmel_ssc_dai.h"
 
-
-#if defined(CONFIG_ARCH_AT91SAM9260) || defined(CONFIG_ARCH_AT91SAM9G20)
-#define NUM_SSC_DEVICES		1
-#else
-#define NUM_SSC_DEVICES		3
-#endif
-
 /*
  * SSC PDC registers required by the PCM DMA engine.
  */
@@ -96,63 +91,24 @@ static struct atmel_ssc_mask ssc_rx_mask = {
 /*
  * DMA parameters.
  */
-static struct atmel_pcm_dma_params ssc_dma_params[NUM_SSC_DEVICES][2] = {
-	{{
-	.name		= "SSC0 PCM out",
-	.pdc		= &pdc_tx_reg,
-	.mask		= &ssc_tx_mask,
-	},
+static struct atmel_pcm_dma_params ssc_dma_params[2] = {
 	{
-	.name		= "SSC0 PCM in",
-	.pdc		= &pdc_rx_reg,
-	.mask		= &ssc_rx_mask,
-	} },
-#if NUM_SSC_DEVICES == 3
-	{{
-	.name		= "SSC1 PCM out",
+	.name		= "SSC PCM out",
 	.pdc		= &pdc_tx_reg,
 	.mask		= &ssc_tx_mask,
 	},
 	{
-	.name		= "SSC1 PCM in",
+	.name		= "SSC PCM in",
 	.pdc		= &pdc_rx_reg,
 	.mask		= &ssc_rx_mask,
-	} },
-	{{
-	.name		= "SSC2 PCM out",
-	.pdc		= &pdc_tx_reg,
-	.mask		= &ssc_tx_mask,
 	},
-	{
-	.name		= "SSC2 PCM in",
-	.pdc		= &pdc_rx_reg,
-	.mask		= &ssc_rx_mask,
-	} },
-#endif
 };
 
-
-static struct atmel_ssc_info ssc_info[NUM_SSC_DEVICES] = {
-	{
-	.name		= "ssc0",
-	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[0].lock),
+static struct atmel_ssc_info ssc_info = {
+	.name		= "ssc",
+	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info.lock),
 	.dir_mask	= SSC_DIR_MASK_UNUSED,
 	.initialized	= 0,
-	},
-#if NUM_SSC_DEVICES == 3
-	{
-	.name		= "ssc1",
-	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[1].lock),
-	.dir_mask	= SSC_DIR_MASK_UNUSED,
-	.initialized	= 0,
-	},
-	{
-	.name		= "ssc2",
-	.lock		= __SPIN_LOCK_UNLOCKED(ssc_info[2].lock),
-	.dir_mask	= SSC_DIR_MASK_UNUSED,
-	.initialized	= 0,
-	},
-#endif
 };
 
 
@@ -205,7 +161,7 @@ static irqreturn_t atmel_ssc_interrupt(int irq, void *dev_id)
 static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
+	struct atmel_ssc_info *ssc_p = &ssc_info;
 	int dir_mask;
 
 	pr_debug("atmel_ssc_startup: SSC_SR=0x%u\n",
@@ -234,7 +190,7 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
+	struct atmel_ssc_info *ssc_p = &ssc_info;
 	struct atmel_pcm_dma_params *dma_params;
 	int dir, dir_mask;
 
@@ -285,7 +241,7 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
 static int atmel_ssc_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
+	struct atmel_ssc_info *ssc_p = &ssc_info;
 
 	ssc_p->daifmt = fmt;
 	return 0;
@@ -297,7 +253,7 @@ static int atmel_ssc_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 static int atmel_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
 	int div_id, int div)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
+	struct atmel_ssc_info *ssc_p = &ssc_info;
 
 	switch (div_id) {
 	case ATMEL_SSC_CMR_DIV:
@@ -336,8 +292,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
-	int id = dai->id;
-	struct atmel_ssc_info *ssc_p = &ssc_info[id];
+	struct atmel_ssc_info *ssc_p = &ssc_info;
 	struct atmel_pcm_dma_params *dma_params;
 	int dir, channels, bits;
 	u32 tfmr, rfmr, tcmr, rcmr;
@@ -354,7 +309,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	else
 		dir = 1;
 
-	dma_params = &ssc_dma_params[id][dir];
+	dma_params = &ssc_dma_params[dir];
 	dma_params->ssc = ssc_p->ssc;
 	dma_params->substream = substream;
 
@@ -603,7 +558,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 static int atmel_ssc_prepare(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
+	struct atmel_ssc_info *ssc_p = &ssc_info;
 	struct atmel_pcm_dma_params *dma_params;
 	int dir;
 
@@ -631,7 +586,7 @@ static int atmel_ssc_suspend(struct snd_soc_dai *cpu_dai)
 	if (!cpu_dai->active)
 		return 0;
 
-	ssc_p = &ssc_info[cpu_dai->id];
+	ssc_p = &ssc_info;
 
 	/* Save the status register before disabling transmit and receive */
 	ssc_p->ssc_state.ssc_sr = ssc_readl(ssc_p->ssc->regs, SR);
@@ -660,7 +615,7 @@ static int atmel_ssc_resume(struct snd_soc_dai *cpu_dai)
 	if (!cpu_dai->active)
 		return 0;
 
-	ssc_p = &ssc_info[cpu_dai->id];
+	ssc_p = &ssc_info;
 
 	/* restore SSC register settings */
 	ssc_writel(ssc_p->ssc->regs, TFMR, ssc_p->ssc_state.ssc_tfmr);
@@ -689,28 +644,10 @@ static int atmel_ssc_resume(struct snd_soc_dai *cpu_dai)
 
 static int atmel_ssc_probe(struct snd_soc_dai *dai)
 {
-	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
-	int ret = 0;
+	struct atmel_ssc_info *ssc_p = &ssc_info;
 
 	snd_soc_dai_set_drvdata(dai, ssc_p);
 
-	/*
-	 * Request SSC device
-	 */
-	ssc_p->ssc = ssc_request(dai->id);
-	if (IS_ERR(ssc_p->ssc)) {
-		printk(KERN_ERR "ASoC: Failed to request SSC %d\n", dai->id);
-		ret = PTR_ERR(ssc_p->ssc);
-	}
-
-	return ret;
-}
-
-static int atmel_ssc_remove(struct snd_soc_dai *dai)
-{
-	struct atmel_ssc_info *ssc_p = snd_soc_dai_get_drvdata(dai);
-
-	ssc_free(ssc_p->ssc);
 	return 0;
 }
 
@@ -728,11 +665,8 @@ static const struct snd_soc_dai_ops atmel_ssc_dai_ops = {
 	.set_clkdiv	= atmel_ssc_set_dai_clkdiv,
 };
 
-static struct snd_soc_dai_driver atmel_ssc_dai[NUM_SSC_DEVICES] = {
-	{
-		.name = "atmel-ssc-dai.0",
+static struct snd_soc_dai_driver atmel_ssc_dai = {
 		.probe = atmel_ssc_probe,
-		.remove = atmel_ssc_remove,
 		.suspend = atmel_ssc_suspend,
 		.resume = atmel_ssc_resume,
 		.playback = {
@@ -746,118 +680,153 @@ static struct snd_soc_dai_driver atmel_ssc_dai[NUM_SSC_DEVICES] = {
 			.rates = ATMEL_SSC_RATES,
 			.formats = ATMEL_SSC_FORMATS,},
 		.ops = &atmel_ssc_dai_ops,
-	},
-#if NUM_SSC_DEVICES == 3
-	{
-		.name = "atmel-ssc-dai.1",
-		.probe = atmel_ssc_probe,
-		.remove = atmel_ssc_remove,
-		.suspend = atmel_ssc_suspend,
-		.resume = atmel_ssc_resume,
-		.playback = {
-			.channels_min = 1,
-			.channels_max = 2,
-			.rates = ATMEL_SSC_RATES,
-			.formats = ATMEL_SSC_FORMATS,},
-		.capture = {
-			.channels_min = 1,
-			.channels_max = 2,
-			.rates = ATMEL_SSC_RATES,
-			.formats = ATMEL_SSC_FORMATS,},
-		.ops = &atmel_ssc_dai_ops,
-	},
+};
+
+static struct atmel_ssc_platform_data at91rm9200_config = {
+	.use_dma = 0,
+};
+
+static struct atmel_ssc_platform_data at91sam9g45_config = {
+	.use_dma = 1,
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id atmel_ssc_dai_dt_ids[] = {
 	{
-		.name = "atmel-ssc-dai.2",
-		.probe = atmel_ssc_probe,
-		.remove = atmel_ssc_remove,
-		.suspend = atmel_ssc_suspend,
-		.resume = atmel_ssc_resume,
-		.playback = {
-			.channels_min = 1,
-			.channels_max = 2,
-			.rates = ATMEL_SSC_RATES,
-			.formats = ATMEL_SSC_FORMATS,},
-		.capture = {
-			.channels_min = 1,
-			.channels_max = 2,
-			.rates = ATMEL_SSC_RATES,
-			.formats = ATMEL_SSC_FORMATS,},
-		.ops = &atmel_ssc_dai_ops,
-	},
-#endif
+		.compatible = "atmel,at91rm9200-ssc-dai",
+		.data = &at91rm9200_config,
+	}, {
+		.compatible = "atmel,at91sam9g45-ssc-dai",
+		.data = &at91sam9g45_config,
+	}, {
+		/* sentinel */
+	}
 };
+MODULE_DEVICE_TABLE(of, atmel_ssc_dai_dt_ids);
+#endif
 
-static __devinit int asoc_ssc_probe(struct platform_device *pdev)
+static inline const struct atmel_ssc_platform_data * __init
+	atmel_ssc_get_driver_data(struct platform_device *pdev)
 {
-	BUG_ON(pdev->id < 0);
-	BUG_ON(pdev->id >= ARRAY_SIZE(atmel_ssc_dai));
-	return snd_soc_register_dai(&pdev->dev, &atmel_ssc_dai[pdev->id]);
-}
+	if (pdev->dev.of_node) {
+		const struct of_device_id *match;
+		match = of_match_node(atmel_ssc_dai_dt_ids,
+			pdev->dev.of_node);
+		if (match == NULL)
+			return NULL;
+		return match->data;
+	}
 
-static int __devexit asoc_ssc_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_dai(&pdev->dev);
-	return 0;
+	return (struct atmel_ssc_platform_data *)
+		platform_get_device_id(pdev)->driver_data;
 }
 
-static struct platform_driver asoc_ssc_driver = {
-	.driver = {
-			.name = "atmel-ssc-dai",
-			.owner = THIS_MODULE,
-	},
-
-	.probe = asoc_ssc_probe,
-	.remove = __devexit_p(asoc_ssc_remove),
-};
-
-/**
- * atmel_ssc_set_audio - Allocate the specified SSC for audio use.
- */
-int atmel_ssc_set_audio(int ssc_id)
+static __devinit int asoc_ssc_probe(struct platform_device *pdev)
 {
 	struct ssc_device *ssc;
-	static struct platform_device *dma_pdev;
-	struct platform_device *ssc_pdev;
+	struct resource *regs;
+	const struct atmel_ssc_platform_data *pdata;
 	int ret;
 
-	if (ssc_id < 0 || ssc_id >= ARRAY_SIZE(atmel_ssc_dai))
+	ssc = devm_kzalloc(&pdev->dev, sizeof(ssc), GFP_KERNEL);
+	if (!ssc) {
+		dev_err(&pdev->dev, "out of memory\n");
+		return -ENOMEM;
+	}
+
+	ssc->pdev = pdev;
+
+	pdata = atmel_ssc_get_driver_data(pdev);
+	if (!pdata) {
+		dev_err(&pdev->dev, "no platform data\n");
+		return -ENODEV;
+	}
+	ssc->pdata = (struct atmel_ssc_platform_data *)pdata;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs) {
+		dev_err(&pdev->dev, "no mmio resource defined\n");
+		return -ENXIO;
+	}
+
+	ssc->regs = devm_request_and_ioremap(&pdev->dev, regs);
+	if (!ssc->regs) {
+		dev_err(&pdev->dev, "ioremap failed\n");
 		return -EINVAL;
+	}
 
-	/* Allocate a dummy device for DMA if we don't have one already */
-	if (!dma_pdev) {
-		dma_pdev = platform_device_alloc("atmel-pcm-audio", -1);
-		if (!dma_pdev)
-			return -ENOMEM;
+	ssc->clk = devm_clk_get(&pdev->dev, "pclk");
+	if (IS_ERR(ssc->clk)) {
+		dev_err(&pdev->dev, "no pclk clock defined\n");
+		return -EINVAL;
+	}
 
-		ret = platform_device_add(dma_pdev);
-		if (ret < 0) {
-			platform_device_put(dma_pdev);
-			dma_pdev = NULL;
-			return ret;
-		}
+	/* disable all interrupts */
+	clk_enable(ssc->clk);
+	ssc_writel(ssc->regs, IDR, ~0UL);
+	ssc_readl(ssc->regs, SR);
+	clk_disable(ssc->clk);
+
+	ssc->irq = platform_get_irq(pdev, 0);
+	if (!ssc->irq) {
+		dev_err(&pdev->dev, "could not get irq\n");
+		return -ENXIO;
 	}
 
-	ssc_pdev = platform_device_alloc("atmel-ssc-dai", ssc_id);
-	if (!ssc_pdev)
-		return -ENOMEM;
+	ssc_info.ssc = ssc;
 
-	/* If we can grab the SSC briefly to parent the DAI device off it */
-	ssc = ssc_request(ssc_id);
-	if (IS_ERR(ssc))
-		pr_warn("Unable to parent ASoC SSC DAI on SSC: %ld\n",
-			PTR_ERR(ssc));
-	else {
-		ssc_pdev->dev.parent = &(ssc->pdev->dev);
-		ssc_free(ssc);
+	platform_set_drvdata(pdev, ssc);
+
+	ret = snd_soc_register_dai(&pdev->dev, &atmel_ssc_dai);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not register DAI: %d\n", ret);
+		goto err_unregister_dai;
 	}
 
-	ret = platform_device_add(ssc_pdev);
-	if (ret < 0)
-		platform_device_put(ssc_pdev);
+	ret = atmel_pcm_platform_register(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not register PCM: %d\n", ret);
+		goto err;
+	};
+
+	return 0;
 
+err_unregister_dai:
+	snd_soc_unregister_dai(&pdev->dev);
+err:
 	return ret;
 }
-EXPORT_SYMBOL_GPL(atmel_ssc_set_audio);
+
+static int __devexit asoc_ssc_remove(struct platform_device *pdev)
+{
+	atmel_pcm_platform_unregister(&pdev->dev);
+	snd_soc_unregister_dai(&pdev->dev);
+
+	return 0;
+}
+
+static const struct platform_device_id atmel_ssc_dai_devtypes[] = {
+	{
+		.name = "at91rm9200_ssc_dai",
+		.driver_data = (unsigned long) &at91rm9200_config,
+	}, {
+		.name = "at91sam9g45_ssc_dai",
+		.driver_data = (unsigned long) &at91sam9g45_config,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver asoc_ssc_driver = {
+	.driver = {
+		.name		= "atmel-ssc-dai",
+		.owner		= THIS_MODULE,
+		.of_match_table	= of_match_ptr(atmel_ssc_dai_dt_ids),
+	},
+	.id_table = atmel_ssc_dai_devtypes,
+	.probe = asoc_ssc_probe,
+	.remove = __devexit_p(asoc_ssc_remove),
+};
 
 module_platform_driver(asoc_ssc_driver);
 
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index e5e27db..862cbcc 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -179,10 +179,10 @@ static int at91sam9g20ek_wm8731_init(struct snd_soc_pcm_runtime *rtd)
 static struct snd_soc_dai_link at91sam9g20ek_dai = {
 	.name = "WM8731",
 	.stream_name = "WM8731 PCM",
-	.cpu_dai_name = "atmel-ssc-dai.0",
+	.cpu_dai_name = "at91rm9200_ssc_dai.0",
 	.codec_dai_name = "wm8731-hifi",
 	.init = at91sam9g20ek_wm8731_init,
-	.platform_name = "atmel-pcm-audio",
+	.platform_name = "at91rm9200_ssc_dai.0",
 	.codec_name = "wm8731.0-001b",
 	.ops = &at91sam9g20ek_ops,
 };
-- 
1.7.9.5
