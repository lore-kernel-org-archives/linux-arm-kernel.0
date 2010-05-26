From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 26 May 2010 17:09:46 +1200
Subject: [RFC PATCH v2 1/3] ep93xx i2s audio driver
In-Reply-To: <1274850588-30460-1-git-send-email-ryan@bluewatersys.com>
References: <1274850588-30460-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <1274850588-30460-2-git-send-email-ryan@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ep93xx i2s audio driver

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---
 sound/soc/Kconfig             |    1 +
 sound/soc/Makefile            |    1 +
 sound/soc/ep93xx/Kconfig      |    9 +
 sound/soc/ep93xx/Makefile     |    8 +
 sound/soc/ep93xx/ep93xx-i2s.c |  489 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/ep93xx/ep93xx-i2s.h |   25 ++
 sound/soc/ep93xx/ep93xx-pcm.c |  323 +++++++++++++++++++++++++++
 sound/soc/ep93xx/ep93xx-pcm.h |   22 ++
 8 files changed, 878 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/ep93xx/Kconfig
 create mode 100644 sound/soc/ep93xx/Makefile
 create mode 100644 sound/soc/ep93xx/ep93xx-i2s.c
 create mode 100644 sound/soc/ep93xx/ep93xx-i2s.h
 create mode 100644 sound/soc/ep93xx/ep93xx-pcm.c
 create mode 100644 sound/soc/ep93xx/ep93xx-pcm.h

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index b1749bc..f7cb451 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -28,6 +28,7 @@ source "sound/soc/atmel/Kconfig"
 source "sound/soc/au1x/Kconfig"
 source "sound/soc/blackfin/Kconfig"
 source "sound/soc/davinci/Kconfig"
+source "sound/soc/ep93xx/Kconfig"
 source "sound/soc/fsl/Kconfig"
 source "sound/soc/imx/Kconfig"
 source "sound/soc/omap/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 1470141..55b711a 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_SND_SOC)	+= atmel/
 obj-$(CONFIG_SND_SOC)	+= au1x/
 obj-$(CONFIG_SND_SOC)	+= blackfin/
 obj-$(CONFIG_SND_SOC)	+= davinci/
+obj-$(CONFIG_SND_SOC)	+= ep93xx/
 obj-$(CONFIG_SND_SOC)	+= fsl/
 obj-$(CONFIG_SND_SOC)   += imx/
 obj-$(CONFIG_SND_SOC)	+= omap/
diff --git a/sound/soc/ep93xx/Kconfig b/sound/soc/ep93xx/Kconfig
new file mode 100644
index 0000000..ba66ac8
--- /dev/null
+++ b/sound/soc/ep93xx/Kconfig
@@ -0,0 +1,9 @@
+config SND_EP93XX_SOC
+	tristate "SoC Audio support for the Cirrus Logic EP93xx series"
+	depends on ARCH_EP93XX && SND_SOC
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the EP93xx I2S interface.
+
+config SND_EP93XX_SOC_I2S
+	tristate
diff --git a/sound/soc/ep93xx/Makefile b/sound/soc/ep93xx/Makefile
new file mode 100644
index 0000000..0239da3
--- /dev/null
+++ b/sound/soc/ep93xx/Makefile
@@ -0,0 +1,8 @@
+# EP93xx Platform Support
+snd-soc-ep93xx-objs				:= ep93xx-pcm.o
+snd-soc-ep93xx-i2s-objs	 			:= ep93xx-i2s.o
+
+obj-$(CONFIG_SND_EP93XX_SOC)			+= snd-soc-ep93xx.o
+obj-$(CONFIG_SND_EP93XX_SOC_I2S)		+= snd-soc-ep93xx-i2s.o
+
+# EP93XX Machine Support
diff --git a/sound/soc/ep93xx/ep93xx-i2s.c b/sound/soc/ep93xx/ep93xx-i2s.c
new file mode 100644
index 0000000..be67a51
--- /dev/null
+++ b/sound/soc/ep93xx/ep93xx-i2s.c
@@ -0,0 +1,489 @@
+/*
+ * linux/sound/soc/ep93xx-i2s.c
+ * EP93xx I2S driver
+ *
+ * Copyright (C) 2010 Ryan Mallon <ryan@bluewatersys.com>
+ * 
+ * Based on the original driver by:
+ *   Copyright (C) 2007 Chase Douglas <chasedouglas@gmail>
+ *   Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include <mach/hardware.h>
+#include <mach/ep93xx-regs.h>
+#include <mach/dma.h>
+
+#include "ep93xx-pcm.h"
+#include "ep93xx-i2s.h"
+
+#define EP93XX_I2S_TXCLKCFG		0x00
+#define EP93XX_I2S_RXCLKCFG		0x04
+#define EP93XX_I2S_GLSTS		0x08
+#define EP93XX_I2S_GLCTRL		0x0C
+
+#define EP93XX_I2S_TX0LFT		0x10
+#define EP93XX_I2S_TX0RT		0x14
+#define EP93XX_I2S_TX1LFT		0x18
+#define EP93XX_I2S_TX1RT		0x1C
+#define EP93XX_I2S_TX2LFT		0x20
+#define EP93XX_I2S_TX2RT		0x24
+#define EP93XX_I2S_TXLINCTRLDATA	0x28
+#define EP93XX_I2S_TXCTRL		0x2C
+#define EP93XX_I2S_TXWRDLEN		0x30
+#define EP93XX_I2S_TX0EN		0x34
+#define EP93XX_I2S_TX1EN		0x38
+#define EP93XX_I2S_TX2EN		0x3C
+
+#define EP93XX_I2S_RX0LFT		0x40
+#define EP93XX_I2S_RX0RT		0x44
+#define EP93XX_I2S_RX1LFT		0x48
+#define EP93XX_I2S_RX1RT		0x4C
+#define EP93XX_I2S_RX2LFT		0x50
+#define EP93XX_I2S_RX2RT		0x54
+
+#define EP93XX_I2S_RXLINCTRLDATA	0x58
+#define EP93XX_I2S_RXCTRL		0x5C
+#define EP93XX_I2S_RXWRDLEN		0x60
+#define EP93XX_I2S_RX0EN		0x64
+#define EP93XX_I2S_RX1EN		0x68
+#define EP93XX_I2S_RX2EN		0x6C
+
+#define EP93XX_I2S_WRDLEN_16		(0 << 0)
+#define EP93XX_I2S_WRDLEN_24		(1 << 0)
+#define EP93XX_I2S_WRDLEN_32		(2 << 0)
+
+#define EP93XX_I2S_LINCTRLDATA_R_JUST	(1 << 2) /* Right justify */
+
+#define EP93XX_I2S_CLKCFG_LRS		(1 << 0) /* lrclk polarity */
+#define EP93XX_I2S_CLKCFG_CKP		(1 << 1) /* Bit clock polarity */
+#define EP93XX_I2S_CLKCFG_REL		(1 << 2) /* First bit transition */
+#define EP93XX_I2S_CLKCFG_MASTER	(1 << 3) /* Master mode */
+#define EP93XX_I2S_CLKCFG_NBCG		(1 << 4) /* Not bit clock gating */
+
+struct ep93xx_i2s_info {
+	struct clk			*mclk;
+	struct clk			*sclk;
+	struct clk			*lrclk;
+	struct ep93xx_pcm_dma_params	*dma_params[2];
+	struct resource			*mem;
+	void __iomem			*regs;
+};
+
+static struct ep93xx_pcm_dma_params ep93xx_i2s_pcm_out = {
+	.name		= "i2s-pcm-out",
+	.dma_port	= EP93XX_DMA_M2P_PORT_I2S1,
+};
+
+static struct ep93xx_pcm_dma_params ep93xx_i2s_pcm_in = {
+	.name		= "i2s-pcm-in",
+	.dma_port	= EP93XX_DMA_M2P_PORT_I2S1,
+};
+
+static inline void ep93xx_i2s_write_reg(struct ep93xx_i2s_info *info,
+					unsigned reg, unsigned val)
+{
+	__raw_writel(val, info->regs + reg);
+}
+
+static inline unsigned ep93xx_i2s_read_reg(struct ep93xx_i2s_info *info,
+					   unsigned reg)
+{
+	return __raw_readl(info->regs + reg);
+}
+
+static void ep93xx_i2s_enable(struct ep93xx_i2s_info *info)
+{
+	int i;
+
+	/* Enable clocks */
+	clk_enable(info->mclk);
+	clk_enable(info->sclk);
+	clk_enable(info->lrclk);
+
+	/* Enable i2s */
+	ep93xx_i2s_write_reg(info, EP93XX_I2S_GLCTRL, 1);
+
+	/* Enable fifos */
+	for (i = 0; i < 3; i++) {
+		ep93xx_i2s_write_reg(info, EP93XX_I2S_RX0EN + (i * 4), 1);
+		ep93xx_i2s_write_reg(info, EP93XX_I2S_TX0EN + (i * 4), 1);
+	}	
+}
+
+static void ep93xx_i2s_disable(struct ep93xx_i2s_info *info)
+{
+	int i;
+
+	/* Disable fifos */
+	for (i = 0; i < 3; i++) {
+		ep93xx_i2s_write_reg(info, EP93XX_I2S_RX0EN + (i * 4), 0);
+		ep93xx_i2s_write_reg(info, EP93XX_I2S_TX0EN + (i * 4), 0);
+	}
+	
+	/* Disable i2s */
+	ep93xx_i2s_write_reg(info, EP93XX_I2S_GLCTRL, 0);
+
+	/* Disable clocks */
+	clk_disable(info->lrclk);
+	clk_disable(info->sclk);
+	clk_disable(info->mclk);
+}
+
+static int ep93xx_i2s_startup(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{	
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct ep93xx_i2s_info *info = rtd->dai->cpu_dai->private_data;
+	
+	snd_soc_dai_set_dma_data(cpu_dai, substream, 
+				 info->dma_params[substream->stream]);
+	return 0;
+}
+
+static void ep93xx_i2s_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct ep93xx_i2s_info *info = rtd->dai->cpu_dai->private_data;
+
+	ep93xx_i2s_disable(info);
+}
+
+static int ep93xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
+				  unsigned int fmt)
+{
+	struct ep93xx_i2s_info *info = cpu_dai->private_data;
+	unsigned int clk_cfg, lin_ctrl;
+	
+	clk_cfg  = ep93xx_i2s_read_reg(info, EP93XX_I2S_RXCLKCFG);
+	lin_ctrl = ep93xx_i2s_read_reg(info, EP93XX_I2S_RXLINCTRLDATA);
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		clk_cfg |= EP93XX_I2S_CLKCFG_REL;
+		lin_ctrl &= ~EP93XX_I2S_LINCTRLDATA_R_JUST;
+		break;
+		
+	case SND_SOC_DAIFMT_LEFT_J:
+		clk_cfg &= ~EP93XX_I2S_CLKCFG_REL;
+		lin_ctrl &= ~EP93XX_I2S_LINCTRLDATA_R_JUST;
+		break;
+		
+	case SND_SOC_DAIFMT_RIGHT_J:
+		clk_cfg &= ~EP93XX_I2S_CLKCFG_REL;
+		lin_ctrl |= EP93XX_I2S_LINCTRLDATA_R_JUST;	
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		/* CPU is master */
+		clk_cfg |= EP93XX_I2S_CLKCFG_MASTER;
+		break;
+
+	case SND_SOC_DAIFMT_CBM_CFM:
+		/* Codec is master */
+		clk_cfg &= ~EP93XX_I2S_CLKCFG_MASTER;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		/* Negative bit clock, lrclk low on left word */
+		clk_cfg &= ~(EP93XX_I2S_CLKCFG_CKP | EP93XX_I2S_CLKCFG_REL);
+		break;
+
+	case SND_SOC_DAIFMT_NB_IF:
+		/* Negative bit clock, lrclk low on right word */
+		clk_cfg &= ~EP93XX_I2S_CLKCFG_CKP;
+		clk_cfg |= EP93XX_I2S_CLKCFG_REL;
+		break;
+		
+	case SND_SOC_DAIFMT_IB_NF:
+		/* Positive bit clock, lrclk low on left word */
+		clk_cfg |= EP93XX_I2S_CLKCFG_CKP;
+		clk_cfg &= ~EP93XX_I2S_CLKCFG_REL;
+		break;
+
+	case SND_SOC_DAIFMT_IB_IF:
+		/* Positive bit clock, lrclk low on right word */
+		clk_cfg |= EP93XX_I2S_CLKCFG_CKP | EP93XX_I2S_CLKCFG_REL;
+		break;
+	}
+
+	/* Write new register values */
+	ep93xx_i2s_write_reg(info, EP93XX_I2S_RXCLKCFG, clk_cfg);
+	ep93xx_i2s_write_reg(info, EP93XX_I2S_TXCLKCFG, clk_cfg);
+	ep93xx_i2s_write_reg(info, EP93XX_I2S_RXLINCTRLDATA, lin_ctrl);
+	ep93xx_i2s_write_reg(info, EP93XX_I2S_TXLINCTRLDATA, lin_ctrl);
+	return 0;
+}
+
+static int ep93xx_i2s_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct ep93xx_i2s_info *info = cpu_dai->private_data;
+	unsigned word_len, div, sdiv, lrdiv;
+	int found = 0, err;
+	
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		word_len = EP93XX_I2S_WRDLEN_16;
+		break;
+
+	case SNDRV_PCM_FORMAT_S24_LE:
+		word_len = EP93XX_I2S_WRDLEN_24;
+		break;
+
+	case SNDRV_PCM_FORMAT_S32_LE:
+		word_len = EP93XX_I2S_WRDLEN_32;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+	
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ep93xx_i2s_write_reg(info, EP93XX_I2S_TXWRDLEN, word_len);
+	else
+		ep93xx_i2s_write_reg(info, EP93XX_I2S_RXWRDLEN, word_len);
+
+	/* 
+	 * Calculate the sdiv (bit clock) and lrdiv (left/right clock) values. 
+	 * If the lrclk is pulse length is larger than the word size, then the
+	 * bit clock will be gated for the unused bits.
+	 */
+	div = (clk_get_rate(info->mclk) / params_rate(params)) * 
+		params_channels(params);
+	for (sdiv = 2; !found && sdiv <= 4; sdiv += 2)
+		for (lrdiv = 32; !found && lrdiv <= 128; lrdiv <<= 1)
+			if (sdiv * lrdiv == div)
+				found = 1;
+	if (!found)
+		return -EINVAL;
+
+	err = clk_set_rate(info->sclk, clk_get_rate(info->mclk) / sdiv);
+	if (err)
+		return err;
+	
+	err = clk_set_rate(info->lrclk, clk_get_rate(info->sclk) / lrdiv);
+	if (err)
+		return err;
+
+	ep93xx_i2s_enable(info);
+	return 0;
+}
+
+static int ep93xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai, int clk_id,
+				 unsigned int freq, int dir)
+{
+	struct ep93xx_i2s_info *info = cpu_dai->private_data;
+
+	if (dir == SND_SOC_CLOCK_IN || clk_id != 0)
+		return -EINVAL;
+
+	return clk_set_rate(info->mclk, freq);
+}
+
+#ifdef CONFIG_PM
+static int ep93xx_i2s_suspend(struct snd_soc_dai *dai)
+{
+	struct ep93xx_i2s_info *info = dai->private_data;
+
+	if (!dai->active)
+		return;
+	
+	ep93xx_i2s_enable(info, 0);
+}
+
+static int ep93xx_i2s_resume(struct snd_soc_dai *dai)
+{
+	struct ep93xx_i2s_info *info = dai->private_data;
+
+	if (!dai->active)
+		return;
+
+	ep93xx_i2s_enable(info, 1);
+}
+#else
+#define ep93xx_i2s_suspend	NULL
+#define ep93xx_i2s_resume	NULL
+#endif
+
+static struct snd_soc_dai_ops ep93xx_i2s_dai_ops = {
+	.startup	= ep93xx_i2s_startup,
+	.shutdown	= ep93xx_i2s_shutdown,
+	.hw_params	= ep93xx_i2s_hw_params,
+	.set_sysclk	= ep93xx_i2s_set_sysclk,
+	.set_fmt	= ep93xx_i2s_set_dai_fmt,
+};
+
+#define EP93XX_I2S_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
+			    SNDRV_PCM_FMTBIT_S24_LE | \
+			    SNDRV_PCM_FMTBIT_S32_LE)
+
+struct snd_soc_dai ep93xx_i2s_dai = {
+	.name		= "ep93xx-i2s",
+	.id		= 0,
+	.suspend	= ep93xx_i2s_suspend,
+	.resume		= ep93xx_i2s_resume,
+	.playback	= {
+		.channels_min	= 2,
+		.channels_max	= 2,
+		.rates		= SNDRV_PCM_RATE_8000_48000,
+		.formats	= EP93XX_I2S_FORMATS,
+	},
+	.capture	= {
+		 .channels_min	= 2,
+		 .channels_max	= 2,
+		 .rates		= SNDRV_PCM_RATE_8000_48000,
+		 .formats	= EP93XX_I2S_FORMATS,
+	},
+	.ops		= &ep93xx_i2s_dai_ops,
+};
+EXPORT_SYMBOL_GPL(ep93xx_i2s_dai);
+
+static int ep93xx_i2s_probe(struct platform_device *pdev)
+{
+	struct ep93xx_i2s_info *info;
+	struct resource *res;
+	int err;
+	
+	info = kzalloc(sizeof(struct ep93xx_i2s_info), GFP_KERNEL);
+	if (!info) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	ep93xx_i2s_dai.dev = &pdev->dev;
+	ep93xx_i2s_dai.private_data = info;
+	
+	info->dma_params[SNDRV_PCM_STREAM_PLAYBACK] = &ep93xx_i2s_pcm_out;
+	info->dma_params[SNDRV_PCM_STREAM_CAPTURE]  = &ep93xx_i2s_pcm_in;
+	
+	err = snd_soc_register_dai(&ep93xx_i2s_dai);
+	if (err)
+		goto fail_free_info;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		err = -ENODEV;
+		goto fail_unregister_dai;
+	}
+		
+	info->mem = request_mem_region(res->start, resource_size(res), 
+				       pdev->name);
+	if (!info->mem) {		
+		err = -EBUSY;
+		goto fail_free_info;
+	}
+	
+	info->regs = ioremap(info->mem->start, resource_size(info->mem));
+	if (!info->regs) {
+		err = -ENXIO;
+		goto fail_release_mem;
+	}
+
+	info->mclk = clk_get(&pdev->dev, "mclk");
+	if (IS_ERR(info->mclk)) {
+		err = PTR_ERR(info->mclk);
+		goto fail_unmap_mem;
+	}
+
+	info->sclk = clk_get(&pdev->dev, "sclk");
+	if (IS_ERR(info->sclk)) {
+		err = PTR_ERR(info->sclk);
+		goto fail_put_mclk;
+	}
+
+	info->lrclk = clk_get(&pdev->dev, "lrclk");
+	if (IS_ERR(info->lrclk)) {
+		err = PTR_ERR(info->lrclk);
+		goto fail_put_sclk;
+	}
+	
+	return 0;
+
+fail_put_sclk:
+	clk_put(info->sclk);
+fail_put_mclk:
+	clk_put(info->mclk);
+fail_unmap_mem:	
+	iounmap(info->regs);
+fail_release_mem:
+	release_mem_region(info->mem->start, resource_size(info->mem));
+fail_unregister_dai:
+	snd_soc_unregister_dai(&ep93xx_i2s_dai);
+fail_free_info:
+	kfree(info);
+fail:
+	return err;
+}
+
+static int __devexit ep93xx_i2s_remove(struct platform_device *pdev)
+{
+	struct ep93xx_i2s_info *info = ep93xx_i2s_dai.private_data;
+	
+	clk_put(info->lrclk);
+	clk_put(info->sclk);
+	clk_put(info->mclk);
+	iounmap(info->regs);
+	release_mem_region(info->mem->start, resource_size(info->mem));
+	snd_soc_unregister_dai(&ep93xx_i2s_dai);
+	kfree(info);
+	return 0;
+}
+
+static struct platform_driver ep93xx_i2s_driver = {
+	.probe	= ep93xx_i2s_probe,
+	.remove	= __devexit_p(ep93xx_i2s_remove),
+	.driver	= {
+		.name	= "ep93xx-i2s",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init ep93xx_i2s_init(void)
+{
+	return platform_driver_register(&ep93xx_i2s_driver);
+}
+
+static void __exit ep93xx_i2s_exit(void)
+{
+	platform_driver_unregister(&ep93xx_i2s_driver);
+}
+
+module_init(ep93xx_i2s_init);
+module_exit(ep93xx_i2s_exit);
+
+MODULE_ALIAS("platform:ep93xx-i2s");
+MODULE_AUTHOR("Ryan Mallon <ryan@bluewatersys.com>");
+MODULE_DESCRIPTION("EP93XX I2S driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/ep93xx/ep93xx-i2s.h b/sound/soc/ep93xx/ep93xx-i2s.h
new file mode 100644
index 0000000..830c793
--- /dev/null
+++ b/sound/soc/ep93xx/ep93xx-i2s.h
@@ -0,0 +1,25 @@
+/*
+ * linux/sound/soc/ep93xx-i2s.h
+ * EP93xx I2S driver
+ *
+ * Copyright (C) 2010 Ryan Mallon <ryan@bluewatersys.com>
+ *  
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef _EP93XX_SND_SOC_I2S_H
+#define _EP93XX_SND_SOC_I2S_H
+
+/*
+ * These are the offsets for the LRDIV and SDIV fields in the syscon i2sclkdiv
+ * register.
+ */
+#define EP93XX_I2S_LRDIV	17
+#define EP93XX_I2S_SDIV		16
+
+extern struct snd_soc_dai ep93xx_i2s_dai;
+
+#endif /* _EP93XX_SND_SOC_I2S_H */
diff --git a/sound/soc/ep93xx/ep93xx-pcm.c b/sound/soc/ep93xx/ep93xx-pcm.c
new file mode 100644
index 0000000..0e0baab
--- /dev/null
+++ b/sound/soc/ep93xx/ep93xx-pcm.c
@@ -0,0 +1,323 @@
+/*
+ * linux/sound/arm/ep93xx-pcm.c - EP93xx ALSA PCM interface
+ *
+ * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
+ * Copyright (C) 2006 Applied Data Systems
+ *
+ * Rewritten for the SoC audio subsystem (Based on PXA2xx code):
+ *   Copyright (c) 2008 Ryan Mallon <ryan@bluewatersys.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include <mach/dma.h>
+#include <mach/hardware.h>
+#include <mach/ep93xx-regs.h>
+
+#include "ep93xx-pcm.h"
+
+static const struct snd_pcm_hardware ep93xx_pcm_hardware = {
+	.info			= (SNDRV_PCM_INFO_MMAP		|
+				   SNDRV_PCM_INFO_MMAP_VALID	|
+				   SNDRV_PCM_INFO_INTERLEAVED	|
+				   SNDRV_PCM_INFO_BLOCK_TRANSFER),
+				   
+	.rates			= SNDRV_PCM_RATE_8000_48000,
+	.rate_min		= SNDRV_PCM_RATE_8000,
+	.rate_max		= SNDRV_PCM_RATE_48000,
+	
+	.formats		= (SNDRV_PCM_FMTBIT_S16_LE |
+				   SNDRV_PCM_FMTBIT_S24_LE |
+				   SNDRV_PCM_FMTBIT_S32_LE),
+	
+	.buffer_bytes_max	= 131072,
+	.period_bytes_min	= 32,
+	.period_bytes_max	= 32768,
+	.periods_min		= 1,
+	.periods_max		= 32,
+	.fifo_size		= 32,
+};
+
+struct ep93xx_runtime_data
+{
+	struct ep93xx_dma_m2p_client	cl;
+	struct ep93xx_pcm_dma_params	*params;
+	int				pointer_bytes;
+	struct tasklet_struct		period_tasklet;
+	int				periods;
+	struct ep93xx_dma_buffer	buf[32];
+};
+
+static void ep93xx_pcm_period_elapsed(unsigned long data)
+{
+	struct snd_pcm_substream *substream = (struct snd_pcm_substream *)data;
+	snd_pcm_period_elapsed(substream);
+}
+
+static void ep93xx_pcm_buffer_started(void *cookie,
+				      struct ep93xx_dma_buffer *buf)
+{
+}
+
+static void ep93xx_pcm_buffer_finished(void *cookie, 
+				       struct ep93xx_dma_buffer *buf, 
+				       int bytes, int error)
+{
+	struct snd_pcm_substream *substream = cookie;
+	struct ep93xx_runtime_data *rtd = substream->runtime->private_data;
+
+	if (buf == rtd->buf + rtd->periods - 1)
+		rtd->pointer_bytes = 0;
+	else
+		rtd->pointer_bytes += buf->size;
+
+	if (!error) {
+		ep93xx_dma_m2p_submit_recursive(&rtd->cl, buf);
+		tasklet_schedule(&rtd->period_tasklet);
+	} else {
+		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+	}
+}
+
+static int ep93xx_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *soc_rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = soc_rtd->dai->cpu_dai;
+	struct ep93xx_pcm_dma_params *dma_params;
+	struct ep93xx_runtime_data *rtd;    
+	int ret;
+
+	dma_params = snd_soc_dai_get_dma_data(cpu_dai, substream);
+	snd_soc_set_runtime_hwparams(substream, &ep93xx_pcm_hardware);
+
+	rtd = kmalloc(sizeof(*rtd), GFP_KERNEL);
+	if (!rtd) 
+		return -ENOMEM;
+
+	memset(&rtd->period_tasklet, 0, sizeof(rtd->period_tasklet));
+	rtd->period_tasklet.func = ep93xx_pcm_period_elapsed;
+	rtd->period_tasklet.data = (unsigned long)substream;
+
+	rtd->cl.name = dma_params->name;
+	rtd->cl.flags = dma_params->dma_port | EP93XX_DMA_M2P_IGNORE_ERROR |
+		((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+		 EP93XX_DMA_M2P_TX : EP93XX_DMA_M2P_RX);
+	rtd->cl.cookie = substream;
+	rtd->cl.buffer_started = ep93xx_pcm_buffer_started;
+	rtd->cl.buffer_finished = ep93xx_pcm_buffer_finished;
+	ret = ep93xx_dma_m2p_client_register(&rtd->cl);
+	if (ret < 0) {
+		kfree(rtd);
+		return ret;
+	}
+	
+	substream->runtime->private_data = rtd;
+	return 0;
+}
+
+static int ep93xx_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct ep93xx_runtime_data *rtd = substream->runtime->private_data;
+
+	ep93xx_dma_m2p_client_unregister(&rtd->cl);
+	kfree(rtd);
+	return 0;
+}
+
+static int ep93xx_pcm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ep93xx_runtime_data *rtd = runtime->private_data;
+	size_t totsize = params_buffer_bytes(params);
+	size_t period = params_period_bytes(params);
+	int i;
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+	runtime->dma_bytes = totsize;
+
+	rtd->periods = (totsize + period - 1) / period;
+	for (i = 0; i < rtd->periods; i++) {
+		rtd->buf[i].bus_addr = runtime->dma_addr + (i * period);
+		rtd->buf[i].size = period;
+		if ((i + 1) * period > totsize)
+			rtd->buf[i].size = totsize - (i * period);
+	}
+
+	return 0;
+}
+
+static int ep93xx_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	snd_pcm_set_runtime_buffer(substream, NULL);
+	return 0;
+}
+
+static int ep93xx_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static int ep93xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct ep93xx_runtime_data *rtd = substream->runtime->private_data;
+	int ret;
+	int i;
+
+	ret = 0;
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		rtd->pointer_bytes = 0;
+		for (i = 0; i < rtd->periods; i++)
+			ep93xx_dma_m2p_submit(&rtd->cl, rtd->buf + i);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		ep93xx_dma_m2p_flush(&rtd->cl);
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static snd_pcm_uframes_t ep93xx_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ep93xx_runtime_data *rtd = substream->runtime->private_data;
+
+	/* FIXME: implement this with sub-period granularity */
+	return bytes_to_frames(runtime, rtd->pointer_bytes);
+}
+
+static int ep93xx_pcm_mmap(struct snd_pcm_substream *substream,
+			   struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
+				     runtime->dma_area,
+				     runtime->dma_addr,
+				     runtime->dma_bytes);
+}
+
+static struct snd_pcm_ops ep93xx_pcm_ops = {
+	.open		= ep93xx_pcm_open,
+	.close		= ep93xx_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= ep93xx_pcm_hw_params,
+	.hw_free	= ep93xx_pcm_hw_free,
+	.prepare	= ep93xx_pcm_prepare,
+	.trigger	= ep93xx_pcm_trigger,
+	.pointer	= ep93xx_pcm_pointer,
+	.mmap		= ep93xx_pcm_mmap,
+};
+
+static int ep93xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	size_t size = ep93xx_pcm_hardware.buffer_bytes_max;
+
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
+					   &buf->addr, GFP_KERNEL);
+	buf->bytes = size;
+
+	return (buf->area == NULL) ? -ENOMEM : 0;
+}
+
+static void ep93xx_pcm_free_dma_buffers(struct snd_pcm *pcm)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_dma_buffer *buf;
+	int stream;
+
+	for (stream = 0; stream < 2; stream++) {		
+		substream = pcm->streams[stream].substream;
+		if (!substream)
+			continue;
+		
+		buf = &substream->dma_buffer;
+		if (!buf->area)
+			continue;
+
+		dma_free_writecombine(pcm->card->dev, buf->bytes, buf->area,
+				      buf->addr);
+		buf->area = NULL;
+	}
+}
+
+static u64 ep93xx_pcm_dmamask = 0xffffffff;
+
+static int ep93xx_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
+			  struct snd_pcm *pcm)
+{
+	int ret = 0;
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &ep93xx_pcm_dmamask;
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = 0xffffffff;
+
+	if (dai->playback.channels_min) {
+		ret = ep93xx_pcm_preallocate_dma_buffer(pcm,
+					SNDRV_PCM_STREAM_PLAYBACK);
+		if (ret)
+			return ret;
+
+		ret = ep93xx_pcm_preallocate_dma_buffer(pcm,
+					SNDRV_PCM_STREAM_CAPTURE);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+struct snd_soc_platform ep93xx_soc_platform = {
+	.name		= "ep93xx-audio",
+	.pcm_ops	= &ep93xx_pcm_ops,
+	.pcm_new	= &ep93xx_pcm_new,
+	.pcm_free	= &ep93xx_pcm_free_dma_buffers,
+};
+EXPORT_SYMBOL_GPL(ep93xx_soc_platform);
+
+static int __init ep93xx_soc_platform_init(void)
+{
+	return snd_soc_register_platform(&ep93xx_soc_platform);
+}
+
+static void __exit ep93xx_soc_platform_exit(void)
+{
+	snd_soc_unregister_platform(&ep93xx_soc_platform);
+}
+
+module_init(ep93xx_soc_platform_init);
+module_exit(ep93xx_soc_platform_exit);
+
+MODULE_AUTHOR("Ryan Mallon <ryan@bluewatersys.com>");
+MODULE_DESCRIPTION("EP93xx ALSA PCM interface");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/ep93xx/ep93xx-pcm.h b/sound/soc/ep93xx/ep93xx-pcm.h
new file mode 100644
index 0000000..4ffdd3f
--- /dev/null
+++ b/sound/soc/ep93xx/ep93xx-pcm.h
@@ -0,0 +1,22 @@
+/*
+ * sound/soc/ep93xx/ep93xx-pcm.h - EP93xx ALSA PCM interface
+ *
+ * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
+ * Copyright (C) 2006 Applied Data Systems
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _EP93XX_SND_SOC_PCM_H
+#define _EP93XX_SND_SOC_PCM_H
+
+struct ep93xx_pcm_dma_params {
+	char	*name;
+	int	dma_port;
+};
+
+extern struct snd_soc_platform ep93xx_soc_platform;
+
+#endif /* _EP93XX_SND_SOC_PCM_H */
-- 
1.5.5.1
