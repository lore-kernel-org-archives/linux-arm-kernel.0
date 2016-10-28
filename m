From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 28 Oct 2016 18:11:12 +0200
Subject: [PATCH] ASoC: samsung: Drop AC97 drivers
Message-ID: <1477671072-742-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AC97 drivers are broken and it seems these have not been used
for a long time.  This patch removes the unused code, i.e. Samsung
SoC AC97 controller driver and related machine drivers:
ln2440sbc_alc650, smdk2443_wm9710, smdk_wm9713.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/Kconfig            |  32 ---
 sound/soc/samsung/Makefile           |   2 -
 sound/soc/samsung/ac97.c             | 437 -----------------------------------
 sound/soc/samsung/ln2440sbc_alc650.c |  72 ------
 sound/soc/samsung/regs-ac97.h        |  66 ------
 sound/soc/samsung/smdk2443_wm9710.c  |  68 ------
 sound/soc/samsung/smdk_wm9713.c      | 108 ---------
 7 files changed, 785 deletions(-)
 delete mode 100644 sound/soc/samsung/ac97.c
 delete mode 100644 sound/soc/samsung/ln2440sbc_alc650.c
 delete mode 100644 sound/soc/samsung/regs-ac97.h
 delete mode 100644 sound/soc/samsung/smdk2443_wm9710.c
 delete mode 100644 sound/soc/samsung/smdk_wm9713.c

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index f6023b4..1d2ef4c 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -22,10 +22,6 @@ config SND_S3C2412_SOC_I2S
 config SND_SAMSUNG_PCM
 	tristate "Samsung PCM interface support"
 
-config SND_SAMSUNG_AC97
-	tristate
-	select SND_SOC_AC97_BUS
-
 config SND_SAMSUNG_SPDIF
 	tristate "Samsung SPDIF transmitter support"
 	select SND_SOC_SPDIF
@@ -69,26 +65,6 @@ config SND_SOC_SAMSUNG_SMDK_WM8994
 	help
 		Say Y if you want to add support for SoC audio on the SMDKs.
 
-config SND_SOC_SAMSUNG_SMDK2443_WM9710
-	tristate "SoC AC97 Audio support for SMDK2443 - WM9710"
-	depends on MACH_SMDK2443
-	select AC97_BUS
-	select SND_SOC_AC97_CODEC
-	select SND_SAMSUNG_AC97
-	help
-	  Say Y if you want to add support for SoC audio on smdk2443
-	  with the WM9710.
-
-config SND_SOC_SAMSUNG_LN2440SBC_ALC650
-	tristate "SoC AC97 Audio support for LN2440SBC - ALC650"
-	depends on ARCH_S3C24XX
-	select AC97_BUS
-	select SND_SOC_AC97_CODEC
-	select SND_SAMSUNG_AC97
-	help
-	  Say Y if you want to add support for SoC audio on ln2440sbc
-	  with the ALC650.
-
 config SND_SOC_SAMSUNG_S3C24XX_UDA134X
 	tristate "SoC I2S Audio support UDA134X wired to a S3C24XX"
 	depends on ARCH_S3C24XX
@@ -131,14 +107,6 @@ config SND_SOC_SAMSUNG_RX1950_UDA1380
 	help
 	  This driver provides audio support for HP iPAQ RX1950 PDA.
 
-config SND_SOC_SAMSUNG_SMDK_WM9713
-	tristate "SoC AC97 Audio support for SMDK with WM9713"
-	depends on MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110
-	select SND_SOC_WM9713
-	select SND_SAMSUNG_AC97
-	help
-	  Say Y if you want to add support for SoC audio on the SMDK.
-
 config SND_SOC_SMARTQ
 	tristate "SoC I2S Audio support for SmartQ board"
 	depends on MACH_SMARTQ && I2C
diff --git a/sound/soc/samsung/Makefile b/sound/soc/samsung/Makefile
index 5d03f5c..f3f4a32 100644
--- a/sound/soc/samsung/Makefile
+++ b/sound/soc/samsung/Makefile
@@ -3,7 +3,6 @@ snd-soc-s3c-dma-objs := dmaengine.o
 snd-soc-idma-objs := idma.o
 snd-soc-s3c24xx-i2s-objs := s3c24xx-i2s.o
 snd-soc-s3c2412-i2s-objs := s3c2412-i2s.o
-snd-soc-ac97-objs := ac97.o
 snd-soc-s3c-i2s-v2-objs := s3c-i2s-v2.o
 snd-soc-samsung-spdif-objs := spdif.o
 snd-soc-pcm-objs := pcm.o
@@ -11,7 +10,6 @@ snd-soc-i2s-objs := i2s.o
 
 obj-$(CONFIG_SND_SOC_SAMSUNG) += snd-soc-s3c-dma.o
 obj-$(CONFIG_SND_S3C24XX_I2S) += snd-soc-s3c24xx-i2s.o
-obj-$(CONFIG_SND_SAMSUNG_AC97) += snd-soc-ac97.o
 obj-$(CONFIG_SND_S3C2412_SOC_I2S) += snd-soc-s3c2412-i2s.o
 obj-$(CONFIG_SND_S3C_I2SV2_SOC) += snd-soc-s3c-i2s-v2.o
 obj-$(CONFIG_SND_SAMSUNG_SPDIF) += snd-soc-samsung-spdif.o
diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
deleted file mode 100644
index 97d6700..0000000
--- a/sound/soc/samsung/ac97.c
+++ /dev/null
@@ -1,437 +0,0 @@
-/* sound/soc/samsung/ac97.c
- *
- * ALSA SoC Audio Layer - S3C AC97 Controller driver
- * 	Evolved from s3c2443-ac97.c
- *
- * Copyright (c) 2010 Samsung Electronics Co. Ltd
- *	Author: Jaswinder Singh <jassisinghbrar@gmail.com>
- * 	Credits: Graeme Gregory, Sean Choi
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/io.h>
-#include <linux/delay.h>
-#include <linux/clk.h>
-#include <linux/module.h>
-
-#include <sound/soc.h>
-
-#include "regs-ac97.h"
-#include <linux/platform_data/asoc-s3c.h>
-
-#include "dma.h"
-
-#define AC_CMD_ADDR(x) (x << 16)
-#define AC_CMD_DATA(x) (x & 0xffff)
-
-#define S3C_AC97_DAI_PCM 0
-#define S3C_AC97_DAI_MIC 1
-
-struct s3c_ac97_info {
-	struct clk         *ac97_clk;
-	void __iomem	   *regs;
-	struct mutex       lock;
-	struct completion  done;
-};
-static struct s3c_ac97_info s3c_ac97;
-
-static struct snd_dmaengine_dai_dma_data s3c_ac97_pcm_out = {
-	.addr_width	= 4,
-};
-
-static struct snd_dmaengine_dai_dma_data s3c_ac97_pcm_in = {
-	.addr_width	= 4,
-};
-
-static struct snd_dmaengine_dai_dma_data s3c_ac97_mic_in = {
-	.addr_width	= 4,
-};
-
-static void s3c_ac97_activate(struct snd_ac97 *ac97)
-{
-	u32 ac_glbctrl, stat;
-
-	stat = readl(s3c_ac97.regs + S3C_AC97_GLBSTAT) & 0x7;
-	if (stat == S3C_AC97_GLBSTAT_MAINSTATE_ACTIVE)
-		return; /* Return if already active */
-
-	reinit_completion(&s3c_ac97.done);
-
-	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	ac_glbctrl = S3C_AC97_GLBCTRL_ACLINKON;
-	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	msleep(1);
-
-	ac_glbctrl |= S3C_AC97_GLBCTRL_TRANSFERDATAENABLE;
-	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	msleep(1);
-
-	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	ac_glbctrl |= S3C_AC97_GLBCTRL_CODECREADYIE;
-	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-
-	if (!wait_for_completion_timeout(&s3c_ac97.done, HZ))
-		pr_err("AC97: Unable to activate!\n");
-}
-
-static unsigned short s3c_ac97_read(struct snd_ac97 *ac97,
-	unsigned short reg)
-{
-	u32 ac_glbctrl, ac_codec_cmd;
-	u32 stat, addr, data;
-
-	mutex_lock(&s3c_ac97.lock);
-
-	s3c_ac97_activate(ac97);
-
-	reinit_completion(&s3c_ac97.done);
-
-	ac_codec_cmd = readl(s3c_ac97.regs + S3C_AC97_CODEC_CMD);
-	ac_codec_cmd = S3C_AC97_CODEC_CMD_READ | AC_CMD_ADDR(reg);
-	writel(ac_codec_cmd, s3c_ac97.regs + S3C_AC97_CODEC_CMD);
-
-	udelay(50);
-
-	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	ac_glbctrl |= S3C_AC97_GLBCTRL_CODECREADYIE;
-	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-
-	if (!wait_for_completion_timeout(&s3c_ac97.done, HZ))
-		pr_err("AC97: Unable to read!\n");
-
-	stat = readl(s3c_ac97.regs + S3C_AC97_STAT);
-	addr = (stat >> 16) & 0x7f;
-	data = (stat & 0xffff);
-
-	if (addr != reg)
-		pr_err("ac97: req addr = %02x, rep addr = %02x\n",
-			reg, addr);
-
-	mutex_unlock(&s3c_ac97.lock);
-
-	return (unsigned short)data;
-}
-
-static void s3c_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
-	unsigned short val)
-{
-	u32 ac_glbctrl, ac_codec_cmd;
-
-	mutex_lock(&s3c_ac97.lock);
-
-	s3c_ac97_activate(ac97);
-
-	reinit_completion(&s3c_ac97.done);
-
-	ac_codec_cmd = readl(s3c_ac97.regs + S3C_AC97_CODEC_CMD);
-	ac_codec_cmd = AC_CMD_ADDR(reg) | AC_CMD_DATA(val);
-	writel(ac_codec_cmd, s3c_ac97.regs + S3C_AC97_CODEC_CMD);
-
-	udelay(50);
-
-	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	ac_glbctrl |= S3C_AC97_GLBCTRL_CODECREADYIE;
-	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-
-	if (!wait_for_completion_timeout(&s3c_ac97.done, HZ))
-		pr_err("AC97: Unable to write!\n");
-
-	ac_codec_cmd = readl(s3c_ac97.regs + S3C_AC97_CODEC_CMD);
-	ac_codec_cmd |= S3C_AC97_CODEC_CMD_READ;
-	writel(ac_codec_cmd, s3c_ac97.regs + S3C_AC97_CODEC_CMD);
-
-	mutex_unlock(&s3c_ac97.lock);
-}
-
-static void s3c_ac97_cold_reset(struct snd_ac97 *ac97)
-{
-	pr_debug("AC97: Cold reset\n");
-	writel(S3C_AC97_GLBCTRL_COLDRESET,
-			s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	msleep(1);
-
-	writel(0, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	msleep(1);
-}
-
-static void s3c_ac97_warm_reset(struct snd_ac97 *ac97)
-{
-	u32 stat;
-
-	stat = readl(s3c_ac97.regs + S3C_AC97_GLBSTAT) & 0x7;
-	if (stat == S3C_AC97_GLBSTAT_MAINSTATE_ACTIVE)
-		return; /* Return if already active */
-
-	pr_debug("AC97: Warm reset\n");
-
-	writel(S3C_AC97_GLBCTRL_WARMRESET, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	msleep(1);
-
-	writel(0, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	msleep(1);
-
-	s3c_ac97_activate(ac97);
-}
-
-static irqreturn_t s3c_ac97_irq(int irq, void *dev_id)
-{
-	u32 ac_glbctrl, ac_glbstat;
-
-	ac_glbstat = readl(s3c_ac97.regs + S3C_AC97_GLBSTAT);
-
-	if (ac_glbstat & S3C_AC97_GLBSTAT_CODECREADY) {
-
-		ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
-		ac_glbctrl &= ~S3C_AC97_GLBCTRL_CODECREADYIE;
-		writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-
-		complete(&s3c_ac97.done);
-	}
-
-	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	ac_glbctrl |= (1<<30); /* Clear interrupt */
-	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-
-	return IRQ_HANDLED;
-}
-
-static struct snd_ac97_bus_ops s3c_ac97_ops = {
-	.read       = s3c_ac97_read,
-	.write      = s3c_ac97_write,
-	.warm_reset = s3c_ac97_warm_reset,
-	.reset      = s3c_ac97_cold_reset,
-};
-
-static int s3c_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
-				struct snd_soc_dai *dai)
-{
-	u32 ac_glbctrl;
-
-	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		ac_glbctrl &= ~S3C_AC97_GLBCTRL_PCMINTM_MASK;
-	else
-		ac_glbctrl &= ~S3C_AC97_GLBCTRL_PCMOUTTM_MASK;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-			ac_glbctrl |= S3C_AC97_GLBCTRL_PCMINTM_DMA;
-		else
-			ac_glbctrl |= S3C_AC97_GLBCTRL_PCMOUTTM_DMA;
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		break;
-	}
-
-	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-
-	return 0;
-}
-
-static int s3c_ac97_mic_trigger(struct snd_pcm_substream *substream,
-				    int cmd, struct snd_soc_dai *dai)
-{
-	u32 ac_glbctrl;
-
-	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
-	ac_glbctrl &= ~S3C_AC97_GLBCTRL_MICINTM_MASK;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		ac_glbctrl |= S3C_AC97_GLBCTRL_MICINTM_DMA;
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		break;
-	}
-
-	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
-
-	return 0;
-}
-
-static const struct snd_soc_dai_ops s3c_ac97_dai_ops = {
-	.trigger	= s3c_ac97_trigger,
-};
-
-static const struct snd_soc_dai_ops s3c_ac97_mic_dai_ops = {
-	.trigger	= s3c_ac97_mic_trigger,
-};
-
-static int s3c_ac97_dai_probe(struct snd_soc_dai *dai)
-{
-	snd_soc_dai_init_dma_data(dai, &s3c_ac97_pcm_out, &s3c_ac97_pcm_in);
-
-	return 0;
-}
-
-static int s3c_ac97_mic_dai_probe(struct snd_soc_dai *dai)
-{
-	snd_soc_dai_init_dma_data(dai, NULL, &s3c_ac97_mic_in);
-
-	return 0;
-}
-
-static struct snd_soc_dai_driver s3c_ac97_dai[] = {
-	[S3C_AC97_DAI_PCM] = {
-		.name =	"samsung-ac97",
-		.bus_control = true,
-		.playback = {
-			.stream_name = "AC97 Playback",
-			.channels_min = 2,
-			.channels_max = 2,
-			.rates = SNDRV_PCM_RATE_8000_48000,
-			.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-		.capture = {
-			.stream_name = "AC97 Capture",
-			.channels_min = 2,
-			.channels_max = 2,
-			.rates = SNDRV_PCM_RATE_8000_48000,
-			.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-		.probe = s3c_ac97_dai_probe,
-		.ops = &s3c_ac97_dai_ops,
-	},
-	[S3C_AC97_DAI_MIC] = {
-		.name = "samsung-ac97-mic",
-		.bus_control = true,
-		.capture = {
-			.stream_name = "AC97 Mic Capture",
-			.channels_min = 1,
-			.channels_max = 1,
-			.rates = SNDRV_PCM_RATE_8000_48000,
-			.formats = SNDRV_PCM_FMTBIT_S16_LE,},
-		.probe = s3c_ac97_mic_dai_probe,
-		.ops = &s3c_ac97_mic_dai_ops,
-	},
-};
-
-static const struct snd_soc_component_driver s3c_ac97_component = {
-	.name		= "s3c-ac97",
-};
-
-static int s3c_ac97_probe(struct platform_device *pdev)
-{
-	struct resource *mem_res, *irq_res;
-	struct s3c_audio_pdata *ac97_pdata;
-	int ret;
-
-	ac97_pdata = pdev->dev.platform_data;
-	if (!ac97_pdata || !ac97_pdata->cfg_gpio) {
-		dev_err(&pdev->dev, "cfg_gpio callback not provided!\n");
-		return -EINVAL;
-	}
-
-	/* Check for availability of necessary resource */
-	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq_res) {
-		dev_err(&pdev->dev, "AC97 IRQ not provided!\n");
-		return -ENXIO;
-	}
-
-	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	s3c_ac97.regs = devm_ioremap_resource(&pdev->dev, mem_res);
-	if (IS_ERR(s3c_ac97.regs))
-		return PTR_ERR(s3c_ac97.regs);
-
-	s3c_ac97_pcm_out.filter_data = ac97_pdata->dma_playback;
-	s3c_ac97_pcm_out.addr = mem_res->start + S3C_AC97_PCM_DATA;
-	s3c_ac97_pcm_in.filter_data = ac97_pdata->dma_capture;
-	s3c_ac97_pcm_in.addr = mem_res->start + S3C_AC97_PCM_DATA;
-	s3c_ac97_mic_in.filter_data = ac97_pdata->dma_capture_mic;
-	s3c_ac97_mic_in.addr = mem_res->start + S3C_AC97_MIC_DATA;
-
-	init_completion(&s3c_ac97.done);
-	mutex_init(&s3c_ac97.lock);
-
-	s3c_ac97.ac97_clk = devm_clk_get(&pdev->dev, "ac97");
-	if (IS_ERR(s3c_ac97.ac97_clk)) {
-		dev_err(&pdev->dev, "ac97 failed to get ac97_clock\n");
-		ret = -ENODEV;
-		goto err2;
-	}
-	clk_prepare_enable(s3c_ac97.ac97_clk);
-
-	if (ac97_pdata->cfg_gpio(pdev)) {
-		dev_err(&pdev->dev, "Unable to configure gpio\n");
-		ret = -EINVAL;
-		goto err3;
-	}
-
-	ret = request_irq(irq_res->start, s3c_ac97_irq,
-					0, "AC97", NULL);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "ac97: interrupt request failed.\n");
-		goto err4;
-	}
-
-	ret = snd_soc_set_ac97_ops(&s3c_ac97_ops);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "Failed to set AC'97 ops: %d\n", ret);
-		goto err4;
-	}
-
-	ret = devm_snd_soc_register_component(&pdev->dev, &s3c_ac97_component,
-					 s3c_ac97_dai, ARRAY_SIZE(s3c_ac97_dai));
-	if (ret)
-		goto err5;
-
-	ret = samsung_asoc_dma_platform_register(&pdev->dev,
-						 ac97_pdata->dma_filter,
-						 NULL, NULL);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to get register DMA: %d\n", ret);
-		goto err5;
-	}
-
-	return 0;
-err5:
-	free_irq(irq_res->start, NULL);
-err4:
-err3:
-	clk_disable_unprepare(s3c_ac97.ac97_clk);
-err2:
-	snd_soc_set_ac97_ops(NULL);
-	return ret;
-}
-
-static int s3c_ac97_remove(struct platform_device *pdev)
-{
-	struct resource *irq_res;
-
-	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (irq_res)
-		free_irq(irq_res->start, NULL);
-
-	clk_disable_unprepare(s3c_ac97.ac97_clk);
-	snd_soc_set_ac97_ops(NULL);
-
-	return 0;
-}
-
-static struct platform_driver s3c_ac97_driver = {
-	.probe  = s3c_ac97_probe,
-	.remove = s3c_ac97_remove,
-	.driver = {
-		.name = "samsung-ac97",
-	},
-};
-
-module_platform_driver(s3c_ac97_driver);
-
-MODULE_AUTHOR("Jaswinder Singh, <jassisinghbrar@gmail.com>");
-MODULE_DESCRIPTION("AC97 driver for the Samsung SoC");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:samsung-ac97");
diff --git a/sound/soc/samsung/ln2440sbc_alc650.c b/sound/soc/samsung/ln2440sbc_alc650.c
deleted file mode 100644
index 9342fc2..0000000
--- a/sound/soc/samsung/ln2440sbc_alc650.c
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- * SoC audio for ln2440sbc
- *
- * Copyright 2007 KonekTel, a.s.
- * Author: Ivan Kuten
- *         ivan.kuten at promwad.com
- *
- * Heavily based on smdk2443_wm9710.c
- * Copyright 2007 Wolfson Microelectronics PLC.
- * Author: Graeme Gregory
- *         graeme.gregory at wolfsonmicro.com or linux at wolfsonmicro.com
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- */
-
-#include <linux/module.h>
-#include <sound/soc.h>
-
-static struct snd_soc_card ln2440sbc;
-
-static struct snd_soc_dai_link ln2440sbc_dai[] = {
-{
-	.name = "AC97",
-	.stream_name = "AC97 HiFi",
-	.cpu_dai_name = "samsung-ac97",
-	.codec_dai_name = "ac97-hifi",
-	.codec_name = "ac97-codec",
-	.platform_name = "samsung-ac97",
-},
-};
-
-static struct snd_soc_card ln2440sbc = {
-	.name = "LN2440SBC",
-	.owner = THIS_MODULE,
-	.dai_link = ln2440sbc_dai,
-	.num_links = ARRAY_SIZE(ln2440sbc_dai),
-};
-
-static struct platform_device *ln2440sbc_snd_ac97_device;
-
-static int __init ln2440sbc_init(void)
-{
-	int ret;
-
-	ln2440sbc_snd_ac97_device = platform_device_alloc("soc-audio", -1);
-	if (!ln2440sbc_snd_ac97_device)
-		return -ENOMEM;
-
-	platform_set_drvdata(ln2440sbc_snd_ac97_device, &ln2440sbc);
-	ret = platform_device_add(ln2440sbc_snd_ac97_device);
-
-	if (ret)
-		platform_device_put(ln2440sbc_snd_ac97_device);
-
-	return ret;
-}
-
-static void __exit ln2440sbc_exit(void)
-{
-	platform_device_unregister(ln2440sbc_snd_ac97_device);
-}
-
-module_init(ln2440sbc_init);
-module_exit(ln2440sbc_exit);
-
-/* Module information */
-MODULE_AUTHOR("Ivan Kuten");
-MODULE_DESCRIPTION("ALSA SoC ALC650 LN2440SBC");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/regs-ac97.h b/sound/soc/samsung/regs-ac97.h
deleted file mode 100644
index a71be45..0000000
--- a/sound/soc/samsung/regs-ac97.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
- * Copyright (c) 2006 Simtec Electronics <linux@simtec.co.uk>
- *		http://www.simtec.co.uk/products/SWLINUX/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C2440 AC97 Controller
-*/
-
-#ifndef __SAMSUNG_REGS_AC97_H__
-#define __SAMSUNG_REGS_AC97_H__
-
-#define S3C_AC97_GLBCTRL				(0x00)
-
-#define S3C_AC97_GLBCTRL_CODECREADYIE			(1<<22)
-#define S3C_AC97_GLBCTRL_PCMOUTURIE			(1<<21)
-#define S3C_AC97_GLBCTRL_PCMINORIE			(1<<20)
-#define S3C_AC97_GLBCTRL_MICINORIE			(1<<19)
-#define S3C_AC97_GLBCTRL_PCMOUTTIE			(1<<18)
-#define S3C_AC97_GLBCTRL_PCMINTIE			(1<<17)
-#define S3C_AC97_GLBCTRL_MICINTIE			(1<<16)
-#define S3C_AC97_GLBCTRL_PCMOUTTM_OFF			(0<<12)
-#define S3C_AC97_GLBCTRL_PCMOUTTM_PIO			(1<<12)
-#define S3C_AC97_GLBCTRL_PCMOUTTM_DMA			(2<<12)
-#define S3C_AC97_GLBCTRL_PCMOUTTM_MASK			(3<<12)
-#define S3C_AC97_GLBCTRL_PCMINTM_OFF			(0<<10)
-#define S3C_AC97_GLBCTRL_PCMINTM_PIO			(1<<10)
-#define S3C_AC97_GLBCTRL_PCMINTM_DMA			(2<<10)
-#define S3C_AC97_GLBCTRL_PCMINTM_MASK			(3<<10)
-#define S3C_AC97_GLBCTRL_MICINTM_OFF			(0<<8)
-#define S3C_AC97_GLBCTRL_MICINTM_PIO			(1<<8)
-#define S3C_AC97_GLBCTRL_MICINTM_DMA			(2<<8)
-#define S3C_AC97_GLBCTRL_MICINTM_MASK			(3<<8)
-#define S3C_AC97_GLBCTRL_TRANSFERDATAENABLE		(1<<3)
-#define S3C_AC97_GLBCTRL_ACLINKON			(1<<2)
-#define S3C_AC97_GLBCTRL_WARMRESET			(1<<1)
-#define S3C_AC97_GLBCTRL_COLDRESET			(1<<0)
-
-#define S3C_AC97_GLBSTAT				(0x04)
-
-#define S3C_AC97_GLBSTAT_CODECREADY			(1<<22)
-#define S3C_AC97_GLBSTAT_PCMOUTUR			(1<<21)
-#define S3C_AC97_GLBSTAT_PCMINORI			(1<<20)
-#define S3C_AC97_GLBSTAT_MICINORI			(1<<19)
-#define S3C_AC97_GLBSTAT_PCMOUTTI			(1<<18)
-#define S3C_AC97_GLBSTAT_PCMINTI			(1<<17)
-#define S3C_AC97_GLBSTAT_MICINTI			(1<<16)
-#define S3C_AC97_GLBSTAT_MAINSTATE_IDLE			(0<<0)
-#define S3C_AC97_GLBSTAT_MAINSTATE_INIT			(1<<0)
-#define S3C_AC97_GLBSTAT_MAINSTATE_READY		(2<<0)
-#define S3C_AC97_GLBSTAT_MAINSTATE_ACTIVE		(3<<0)
-#define S3C_AC97_GLBSTAT_MAINSTATE_LP			(4<<0)
-#define S3C_AC97_GLBSTAT_MAINSTATE_WARM			(5<<0)
-
-#define S3C_AC97_CODEC_CMD				(0x08)
-
-#define S3C_AC97_CODEC_CMD_READ				(1<<23)
-
-#define S3C_AC97_STAT					(0x0c)
-#define S3C_AC97_PCM_ADDR				(0x10)
-#define S3C_AC97_PCM_DATA				(0x18)
-#define S3C_AC97_MIC_DATA				(0x1C)
-
-#endif /* __SAMSUNG_REGS_AC97_H__ */
diff --git a/sound/soc/samsung/smdk2443_wm9710.c b/sound/soc/samsung/smdk2443_wm9710.c
deleted file mode 100644
index c390aad6..0000000
--- a/sound/soc/samsung/smdk2443_wm9710.c
+++ /dev/null
@@ -1,68 +0,0 @@
-/*
- * smdk2443_wm9710.c  --  SoC audio for smdk2443
- *
- * Copyright 2007 Wolfson Microelectronics PLC.
- * Author: Graeme Gregory
- *         graeme.gregory at wolfsonmicro.com or linux@wolfsonmicro.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
-
-#include <linux/module.h>
-#include <sound/soc.h>
-
-static struct snd_soc_card smdk2443;
-
-static struct snd_soc_dai_link smdk2443_dai[] = {
-{
-	.name = "AC97",
-	.stream_name = "AC97 HiFi",
-	.cpu_dai_name = "samsung-ac97",
-	.codec_dai_name = "ac97-hifi",
-	.codec_name = "ac97-codec",
-	.platform_name = "samsung-ac97",
-},
-};
-
-static struct snd_soc_card smdk2443 = {
-	.name = "SMDK2443",
-	.owner = THIS_MODULE,
-	.dai_link = smdk2443_dai,
-	.num_links = ARRAY_SIZE(smdk2443_dai),
-};
-
-static struct platform_device *smdk2443_snd_ac97_device;
-
-static int __init smdk2443_init(void)
-{
-	int ret;
-
-	smdk2443_snd_ac97_device = platform_device_alloc("soc-audio", -1);
-	if (!smdk2443_snd_ac97_device)
-		return -ENOMEM;
-
-	platform_set_drvdata(smdk2443_snd_ac97_device, &smdk2443);
-	ret = platform_device_add(smdk2443_snd_ac97_device);
-
-	if (ret)
-		platform_device_put(smdk2443_snd_ac97_device);
-
-	return ret;
-}
-
-static void __exit smdk2443_exit(void)
-{
-	platform_device_unregister(smdk2443_snd_ac97_device);
-}
-
-module_init(smdk2443_init);
-module_exit(smdk2443_exit);
-
-/* Module information */
-MODULE_AUTHOR("Graeme Gregory, graeme.gregory at wolfsonmicro.com, www.wolfsonmicro.com");
-MODULE_DESCRIPTION("ALSA SoC WM9710 SMDK2443");
-MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/smdk_wm9713.c b/sound/soc/samsung/smdk_wm9713.c
deleted file mode 100644
index 0d20e4e..0000000
--- a/sound/soc/samsung/smdk_wm9713.c
+++ /dev/null
@@ -1,108 +0,0 @@
-/*
- * smdk_wm9713.c  --  SoC audio for SMDK
- *
- * Copyright 2010 Samsung Electronics Co. Ltd.
- * Author: Jaswinder Singh Brar <jassisinghbrar@gmail.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- */
-
-#include <linux/module.h>
-#include <sound/soc.h>
-
-static struct snd_soc_card smdk;
-
-/*
- * Default CFG switch settings to use this driver:
- *
- *   SMDK6410: Set CFG1 1-3 On, CFG2 1-4 Off
- *   SMDKC100: Set CFG6 1-3 On, CFG7 1   On
- *   SMDKC110: Set CFGB10 1-2 Off, CFGB12 1-3 On
- *   SMDKV210: Set CFGB10 1-2 Off, CFGB12 1-3 On
- *   SMDKV310: Set CFG2 1-2 Off, CFG4 All On, CFG7 All Off, CFG8 1-On
- */
-
-/*
- Playback (HeadPhone):-
-	$ amixer sset 'Headphone' unmute
-	$ amixer sset 'Right Headphone Out Mux' 'Headphone'
-	$ amixer sset 'Left Headphone Out Mux' 'Headphone'
-	$ amixer sset 'Right HP Mixer PCM' unmute
-	$ amixer sset 'Left HP Mixer PCM' unmute
-
- Capture (LineIn):-
-	$ amixer sset 'Right Capture Source' 'Line'
-	$ amixer sset 'Left Capture Source' 'Line'
-*/
-
-static struct snd_soc_dai_link smdk_dai = {
-	.name = "AC97",
-	.stream_name = "AC97 PCM",
-	.platform_name = "samsung-ac97",
-	.cpu_dai_name = "samsung-ac97",
-	.codec_dai_name = "wm9713-hifi",
-	.codec_name = "wm9713-codec",
-};
-
-static struct snd_soc_card smdk = {
-	.name = "SMDK WM9713",
-	.owner = THIS_MODULE,
-	.dai_link = &smdk_dai,
-	.num_links = 1,
-};
-
-static struct platform_device *smdk_snd_wm9713_device;
-static struct platform_device *smdk_snd_ac97_device;
-
-static int __init smdk_init(void)
-{
-	int ret;
-
-	smdk_snd_wm9713_device = platform_device_alloc("wm9713-codec", -1);
-	if (!smdk_snd_wm9713_device)
-		return -ENOMEM;
-
-	ret = platform_device_add(smdk_snd_wm9713_device);
-	if (ret)
-		goto err1;
-
-	smdk_snd_ac97_device = platform_device_alloc("soc-audio", -1);
-	if (!smdk_snd_ac97_device) {
-		ret = -ENOMEM;
-		goto err2;
-	}
-
-	platform_set_drvdata(smdk_snd_ac97_device, &smdk);
-
-	ret = platform_device_add(smdk_snd_ac97_device);
-	if (ret)
-		goto err3;
-
-	return 0;
-
-err3:
-	platform_device_put(smdk_snd_ac97_device);
-err2:
-	platform_device_del(smdk_snd_wm9713_device);
-err1:
-	platform_device_put(smdk_snd_wm9713_device);
-	return ret;
-}
-
-static void __exit smdk_exit(void)
-{
-	platform_device_unregister(smdk_snd_ac97_device);
-	platform_device_unregister(smdk_snd_wm9713_device);
-}
-
-module_init(smdk_init);
-module_exit(smdk_exit);
-
-/* Module information */
-MODULE_AUTHOR("Jaswinder Singh Brar, jassisinghbrar at gmail.com");
-MODULE_DESCRIPTION("ALSA SoC SMDK+WM9713");
-MODULE_LICENSE("GPL");
-- 
1.9.1
