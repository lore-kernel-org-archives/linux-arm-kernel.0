From: zhangfei.gao@marvell.com (Zhangfei Gao)
Date: Fri, 25 May 2012 15:11:02 +0800
Subject: [PATCH 3/4] ASOC: mmp: add sspa support
In-Reply-To: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
References: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <1337929863-31885-4-git-send-email-zhangfei.gao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SSPA is a configurable multi-channel audio serial (TDM) interface.
It's configurable at runtime to support up to 128 channels and the
number of bits per sample: 8, 12, 16, 20, 24 and 32 bits. It also
support stereo format: I2S, left-justified or right-justified.

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
Signed-off-by: Leo Yan <leoy@marvell.com>
---
 sound/soc/pxa/Kconfig    |    3 +
 sound/soc/pxa/Makefile   |    2 +
 sound/soc/pxa/mmp-sspa.c |  536 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/pxa/mmp-sspa.h |   92 ++++++++
 4 files changed, 633 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/pxa/mmp-sspa.c
 create mode 100644 sound/soc/pxa/mmp-sspa.h

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index a516068..39461ba 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -34,6 +34,9 @@ config SND_PXA_SOC_SSP
 	tristate
 	select PXA_SSP
 
+config SND_MMP_SOC_SSPA
+	tristate
+
 config SND_PXA2XX_SOC_CORGI
 	tristate "SoC Audio support for Sharp Zaurus SL-C7x0"
 	depends on SND_PXA2XX_SOC && PXA_SHARP_C7xx
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index f913e9b..07b8417 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -4,12 +4,14 @@ snd-soc-pxa2xx-ac97-objs := pxa2xx-ac97.o
 snd-soc-pxa2xx-i2s-objs := pxa2xx-i2s.o
 snd-soc-pxa-ssp-objs := pxa-ssp.o
 snd-soc-mmp-objs := mmp-pcm.o
+snd-soc-mmp-sspa-objs := mmp-sspa.o
 
 obj-$(CONFIG_SND_PXA2XX_SOC) += snd-soc-pxa2xx.o
 obj-$(CONFIG_SND_PXA2XX_SOC_AC97) += snd-soc-pxa2xx-ac97.o
 obj-$(CONFIG_SND_PXA2XX_SOC_I2S) += snd-soc-pxa2xx-i2s.o
 obj-$(CONFIG_SND_PXA_SOC_SSP) += snd-soc-pxa-ssp.o
 obj-$(CONFIG_SND_MMP_SOC) += snd-soc-mmp.o
+obj-$(CONFIG_SND_MMP_SOC_SSPA) += snd-soc-mmp-sspa.o
 
 # PXA Machine Support
 snd-soc-corgi-objs := corgi.o
diff --git a/sound/soc/pxa/mmp-sspa.c b/sound/soc/pxa/mmp-sspa.c
new file mode 100644
index 0000000..b78bf1e
--- /dev/null
+++ b/sound/soc/pxa/mmp-sspa.c
@@ -0,0 +1,536 @@
+/*
+ * linux/sound/soc/pxa/mmp-sspa.c
+ * Base on pxa2xx-ssp.c
+ *
+ * Copyright (C) 2011 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/slab.h>
+#include <linux/pxa2xx_ssp.h>
+#include <linux/io.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/pxa2xx-lib.h>
+#include "mmp-sspa.h"
+
+/*
+ * SSPA audio private data
+ */
+struct sspa_priv {
+	struct ssp_device *sspa;
+	struct pxa2xx_pcm_dma_params *dma_params;
+	int dai_fmt;
+	int running_cnt;
+};
+
+static struct clk *audio_clk;
+static struct clk *sysclk;
+
+static void mmp_sspa_write_reg(struct ssp_device *sspa, u32 reg, u32 val)
+{
+	__raw_writel(val, sspa->mmio_base + reg);
+}
+
+static u32 mmp_sspa_read_reg(struct ssp_device *sspa, u32 reg)
+{
+	return __raw_readl(sspa->mmio_base + reg);
+}
+
+static void mmp_sspa_tx_enable(struct ssp_device *sspa)
+{
+	unsigned int sspa_sp;
+
+	sspa_sp = mmp_sspa_read_reg(sspa, SSPA_TXSP);
+	sspa_sp |= SSPA_SP_S_EN;
+	sspa_sp |= SSPA_SP_WEN;
+	mmp_sspa_write_reg(sspa, SSPA_TXSP, sspa_sp);
+}
+
+static void mmp_sspa_tx_disable(struct ssp_device *sspa)
+{
+	unsigned int sspa_sp;
+
+	sspa_sp = mmp_sspa_read_reg(sspa, SSPA_TXSP);
+	sspa_sp &= ~SSPA_SP_S_EN;
+	sspa_sp |= SSPA_SP_WEN;
+	mmp_sspa_write_reg(sspa, SSPA_TXSP, sspa_sp);
+}
+
+static void mmp_sspa_rx_enable(struct ssp_device *sspa)
+{
+	unsigned int sspa_sp;
+
+	sspa_sp = mmp_sspa_read_reg(sspa, SSPA_RXSP);
+	sspa_sp |= SSPA_SP_S_EN;
+	sspa_sp |= SSPA_SP_WEN;
+	mmp_sspa_write_reg(sspa, SSPA_RXSP, sspa_sp);
+}
+
+static void mmp_sspa_rx_disable(struct ssp_device *sspa)
+{
+	unsigned int sspa_sp;
+
+	sspa_sp = mmp_sspa_read_reg(sspa, SSPA_RXSP);
+	sspa_sp &= ~SSPA_SP_S_EN;
+	sspa_sp |= SSPA_SP_WEN;
+	mmp_sspa_write_reg(sspa, SSPA_RXSP, sspa_sp);
+}
+
+static int mmp_sspa_startup(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct sspa_priv *sspa_priv = snd_soc_dai_get_drvdata(dai);
+	struct ssp_device *sspa = sspa_priv->sspa;
+	int ret = 0;
+
+	if (!cpu_dai->active) {
+		clk_enable(sysclk);
+		clk_enable(sspa->clk);
+	}
+
+	return ret;
+}
+
+static void mmp_sspa_shutdown(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct sspa_priv *sspa_priv = snd_soc_dai_get_drvdata(cpu_dai);
+	struct ssp_device *sspa = sspa_priv->sspa;
+
+	if (!cpu_dai->active) {
+		clk_disable(sspa->clk);
+		clk_disable(sysclk);
+	}
+
+	return;
+}
+
+/*
+ * Set the SSP ports SYSCLK.
+ */
+static int mmp_sspa_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
+				    int clk_id, unsigned int freq, int dir)
+{
+	int ret = 0;
+
+	switch (clk_id) {
+	case MMP_SSPA_CLK_AUDIO:
+		ret = clk_set_rate(audio_clk, freq);
+		if (ret)
+			return ret;
+		break;
+	case MMP_SSPA_CLK_PLL:
+	case MMP_SSPA_CLK_VCXO:
+		/* not support yet */
+		return -EINVAL;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mmp_sspa_set_dai_pll(struct snd_soc_dai *cpu_dai, int pll_id,
+				 int source, unsigned int freq_in,
+				 unsigned int freq_out)
+{
+	struct sspa_priv *sspa_priv = snd_soc_dai_get_drvdata(cpu_dai);
+	struct ssp_device *sspa = sspa_priv->sspa;
+
+	switch (pll_id) {
+	case MMP_SYSCLK:
+		clk_set_rate(sysclk, freq_out);
+		break;
+	case MMP_SSPA_CLK:
+		clk_set_rate(sspa->clk, freq_out);
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+/*
+ * Set up the sspa dai format. The sspa port must be inactive
+ * before calling this function as the physical
+ * interface format is changed.
+ */
+static int mmp_sspa_set_dai_fmt(struct snd_soc_dai *cpu_dai,
+				 unsigned int fmt)
+{
+	struct sspa_priv *sspa_priv = snd_soc_dai_get_drvdata(cpu_dai);
+	struct ssp_device *sspa = sspa_priv->sspa;
+	u32 sspa_sp, sspa_ctrl;
+
+	/* check if we need to change anything at all */
+	if (sspa_priv->dai_fmt == fmt)
+		return 0;
+
+	/* we can only change the settings if the port is not in use */
+	if ((mmp_sspa_read_reg(sspa, SSPA_TXSP) & SSPA_SP_S_EN) ||
+	    (mmp_sspa_read_reg(sspa, SSPA_RXSP) & SSPA_SP_S_EN)) {
+		dev_err(&sspa->pdev->dev,
+			"can't change hardware dai format: stream is in use\n");
+		return -EINVAL;
+	}
+
+	/* reset port settings */
+	sspa_sp   = SSPA_SP_WEN | SSPA_SP_S_RST | SSPA_SP_FFLUSH;
+	sspa_ctrl = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		sspa_sp |= SSPA_SP_MSL;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		sspa_sp |= SSPA_SP_FSP;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		sspa_sp |= SSPA_TXSP_FPER(63);
+		sspa_sp |= SSPA_SP_FWID(31);
+		sspa_ctrl |= SSPA_CTL_XDATDLY(1);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mmp_sspa_write_reg(sspa, SSPA_TXSP, sspa_sp);
+	mmp_sspa_write_reg(sspa, SSPA_RXSP, sspa_sp);
+
+	sspa_sp &= ~(SSPA_SP_S_RST | SSPA_SP_FFLUSH);
+	mmp_sspa_write_reg(sspa, SSPA_TXSP, sspa_sp);
+	mmp_sspa_write_reg(sspa, SSPA_RXSP, sspa_sp);
+
+	/*
+	 * FIXME: hw issue, for the tx serial port,
+	 * can not config the master/slave mode;
+	 * so must clean this bit.
+	 * The master/slave mode has been set in the
+	 * rx port.
+	 */
+	sspa_sp &= ~SSPA_SP_MSL;
+	mmp_sspa_write_reg(sspa, SSPA_TXSP, sspa_sp);
+
+	mmp_sspa_write_reg(sspa, SSPA_TXCTL, sspa_ctrl);
+	mmp_sspa_write_reg(sspa, SSPA_RXCTL, sspa_ctrl);
+
+	/* Since we are configuring the timings for the format by hand
+	 * we have to defer some things until hw_params() where we
+	 * know parameters like the sample size.
+	 */
+	sspa_priv->dai_fmt = fmt;
+	return 0;
+}
+
+/*
+ * Set the SSPA audio DMA parameters and sample size.
+ * Can be called multiple times by oss emulation.
+ */
+static int mmp_sspa_hw_params(struct snd_pcm_substream *substream,
+			       struct snd_pcm_hw_params *params,
+			       struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct sspa_priv *sspa_priv = snd_soc_dai_get_drvdata(dai);
+	struct ssp_device *sspa = sspa_priv->sspa;
+	struct pxa2xx_pcm_dma_params *dma_params;
+	u32 sspa_ctrl;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		sspa_ctrl = mmp_sspa_read_reg(sspa, SSPA_TXCTL);
+	else
+		sspa_ctrl = mmp_sspa_read_reg(sspa, SSPA_RXCTL);
+
+	sspa_ctrl &= ~SSPA_CTL_XFRLEN1_MASK;
+	sspa_ctrl |= SSPA_CTL_XFRLEN1(params_channels(params) - 1);
+	sspa_ctrl &= ~SSPA_CTL_XWDLEN1_MASK;
+	sspa_ctrl |= SSPA_CTL_XWDLEN1(SSPA_CTL_32_BITS);
+	sspa_ctrl &= ~SSPA_CTL_XSSZ1_MASK;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		sspa_ctrl |= SSPA_CTL_XSSZ1(SSPA_CTL_8_BITS);
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		sspa_ctrl |= SSPA_CTL_XSSZ1(SSPA_CTL_16_BITS);
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		sspa_ctrl |= SSPA_CTL_XSSZ1(SSPA_CTL_20_BITS);
+		break;
+	case SNDRV_PCM_FORMAT_S24_3LE:
+		sspa_ctrl |= SSPA_CTL_XSSZ1(SSPA_CTL_24_BITS);
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		sspa_ctrl |= SSPA_CTL_XSSZ1(SSPA_CTL_32_BITS);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		mmp_sspa_write_reg(sspa, SSPA_TXCTL, sspa_ctrl);
+		mmp_sspa_write_reg(sspa, SSPA_TXFIFO_LL, 0x1);
+	} else {
+		mmp_sspa_write_reg(sspa, SSPA_RXCTL, sspa_ctrl);
+		mmp_sspa_write_reg(sspa, SSPA_RXFIFO_UL, 0x0);
+	}
+
+	dma_params = &sspa_priv->dma_params[substream->stream];
+	dma_params->dev_addr = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+				(sspa->phys_base + SSPA_TXD) :
+				(sspa->phys_base + SSPA_RXD);
+	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_params);
+	return 0;
+}
+
+static int mmp_sspa_trigger(struct snd_pcm_substream *substream, int cmd,
+			     struct snd_soc_dai *dai)
+{
+	struct sspa_priv *sspa_priv = snd_soc_dai_get_drvdata(dai);
+	struct ssp_device *sspa = sspa_priv->sspa;
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		/*
+		 * whatever playback or capture, must enable rx.
+		 * this is a hw issue, so need check if rx has been
+		 * enabled or not; if has been enabled by another
+		 * stream, do not enable again.
+		 */
+		if (!sspa_priv->running_cnt)
+			mmp_sspa_rx_enable(sspa);
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			mmp_sspa_tx_enable(sspa);
+
+		sspa_priv->running_cnt++;
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		sspa_priv->running_cnt--;
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			mmp_sspa_tx_disable(sspa);
+
+		/* have no capture stream, disable rx port */
+		if (!sspa_priv->running_cnt)
+			mmp_sspa_rx_disable(sspa);
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int mmp_sspa_probe(struct snd_soc_dai *dai)
+{
+	struct sspa_priv *priv = dev_get_drvdata(dai->dev);
+
+	snd_soc_dai_set_drvdata(dai, priv);
+	return 0;
+
+}
+
+#define MMP_SSPA_RATES SNDRV_PCM_RATE_8000_192000
+#define MMP_SSPA_FORMATS (SNDRV_PCM_FMTBIT_S8 | \
+		SNDRV_PCM_FMTBIT_S16_LE | \
+		SNDRV_PCM_FMTBIT_S24_LE | \
+		SNDRV_PCM_FMTBIT_S24_LE | \
+		SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_ops mmp_sspa_dai_ops = {
+	.startup	= mmp_sspa_startup,
+	.shutdown	= mmp_sspa_shutdown,
+	.trigger	= mmp_sspa_trigger,
+	.hw_params	= mmp_sspa_hw_params,
+	.set_sysclk	= mmp_sspa_set_dai_sysclk,
+	.set_pll	= mmp_sspa_set_dai_pll,
+	.set_fmt	= mmp_sspa_set_dai_fmt,
+};
+
+struct snd_soc_dai_driver mmp_sspa_dai = {
+	.probe = mmp_sspa_probe,
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 128,
+		.rates = MMP_SSPA_RATES,
+		.formats = MMP_SSPA_FORMATS,
+	},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = MMP_SSPA_RATES,
+		.formats = MMP_SSPA_FORMATS,
+	},
+	.ops = &mmp_sspa_dai_ops,
+};
+
+static __devinit int asoc_mmp_sspa_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct sspa_priv *priv;
+	struct resource *res;
+
+	priv = devm_kzalloc(&pdev->dev,
+				sizeof(struct sspa_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->sspa = devm_kzalloc(&pdev->dev,
+				sizeof(struct ssp_device), GFP_KERNEL);
+	if (priv->sspa == NULL) {
+		ret = -ENOMEM;
+		goto err_priv_sspa;
+	}
+
+	priv->dma_params = devm_kzalloc(&pdev->dev,
+			2 * sizeof(struct pxa2xx_pcm_dma_params), GFP_KERNEL);
+	if (priv->dma_params == NULL) {
+		ret = -ENOMEM;
+		goto err_priv_dma_params;
+	}
+
+	priv->sspa->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->sspa->clk)) {
+		ret = PTR_ERR(priv->sspa->clk);
+		goto err_free_clk;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "no memory resource defined\n");
+		ret = -ENOMEM;
+		goto err_get_res;
+	}
+
+	res = request_mem_region(res->start, resource_size(res),
+			pdev->name);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "failed to request memory resource\n");
+		ret = -EBUSY;
+		goto err_get_res;
+	}
+
+	priv->sspa->mmio_base = ioremap(res->start, resource_size(res));
+	if (priv->sspa->mmio_base == NULL) {
+		dev_err(&pdev->dev, "failed to ioremap() registers\n");
+		ret = -ENODEV;
+		goto err_free_mem;
+	}
+
+	priv->dai_fmt = (unsigned int) -1;
+	platform_set_drvdata(pdev, priv);
+	return snd_soc_register_dai(&pdev->dev, &mmp_sspa_dai);
+
+err_free_mem:
+	release_mem_region(res->start, resource_size(res));
+err_get_res:
+	clk_put(priv->sspa->clk);
+err_free_clk:
+	devm_kfree(&pdev->dev, priv->dma_params);
+err_priv_dma_params:
+	devm_kfree(&pdev->dev, priv->sspa);
+err_priv_sspa:
+	devm_kfree(&pdev->dev, priv);
+	return ret;
+}
+
+static int __devexit asoc_mmp_sspa_remove(struct platform_device *pdev)
+{
+	struct sspa_priv *priv = platform_get_drvdata(pdev);
+	struct resource *res;
+
+	iounmap(priv->sspa->mmio_base);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, resource_size(res));
+	snd_soc_unregister_dai(&pdev->dev);
+	clk_put(priv->sspa->clk);
+	devm_kfree(&pdev->dev, priv->dma_params);
+	devm_kfree(&pdev->dev, priv->sspa);
+	devm_kfree(&pdev->dev, priv);
+	return 0;
+}
+
+static struct platform_driver asoc_mmp_sspa_driver = {
+	.driver = {
+		.name = "mmp-sspa-dai",
+		.owner = THIS_MODULE,
+	},
+	.probe = asoc_mmp_sspa_probe,
+	.remove = __devexit_p(asoc_mmp_sspa_remove),
+};
+
+
+static int __init mmp_sspa_modinit(void)
+{
+	audio_clk = clk_get(NULL, "mmp-audio");
+	if (IS_ERR(audio_clk))
+		return PTR_ERR(audio_clk);
+
+	sysclk = clk_get(NULL, "mmp-sysclk");
+	if (IS_ERR(sysclk))
+		return PTR_ERR(sysclk);
+	clk_enable(audio_clk);
+	return platform_driver_register(&asoc_mmp_sspa_driver);
+}
+module_init(mmp_sspa_modinit);
+
+static void __exit mmp_sspa_exit(void)
+{
+	clk_disable(audio_clk);
+	clk_put(sysclk);
+	clk_put(audio_clk);
+	platform_driver_unregister(&asoc_mmp_sspa_driver);
+}
+module_exit(mmp_sspa_exit);
+
+MODULE_AUTHOR("Leo Yan <leoy@marvell.com>");
+MODULE_DESCRIPTION("MMP SSPA SoC Interface");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/pxa/mmp-sspa.h b/sound/soc/pxa/mmp-sspa.h
new file mode 100644
index 0000000..ea365cb
--- /dev/null
+++ b/sound/soc/pxa/mmp-sspa.h
@@ -0,0 +1,92 @@
+/*
+ * linux/sound/soc/pxa/mmp-sspa.h
+ *
+ * Copyright (C) 2011 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+#ifndef _MMP_SSPA_H
+#define _MMP_SSPA_H
+
+/*
+ * SSPA Registers
+ */
+#define SSPA_RXD		(0x00)
+#define SSPA_RXID		(0x04)
+#define SSPA_RXCTL		(0x08)
+#define SSPA_RXSP		(0x0c)
+#define SSPA_RXFIFO_UL		(0x10)
+#define SSPA_RXINT_MASK		(0x14)
+#define SSPA_RXC		(0x18)
+#define SSPA_RXFIFO_NOFS	(0x1c)
+#define SSPA_RXFIFO_SIZE	(0x20)
+
+#define SSPA_TXD		(0x80)
+#define SSPA_TXID		(0x84)
+#define SSPA_TXCTL		(0x88)
+#define SSPA_TXSP		(0x8c)
+#define SSPA_TXFIFO_LL		(0x90)
+#define SSPA_TXINT_MASK		(0x94)
+#define SSPA_TXC		(0x98)
+#define SSPA_TXFIFO_NOFS	(0x9c)
+#define SSPA_TXFIFO_SIZE	(0xa0)
+
+/* SSPA Control Register */
+#define	SSPA_CTL_XPH		(1 << 31)	/* Read Phase */
+#define	SSPA_CTL_XFIG		(1 << 15)	/* Transmit Zeros when FIFO Empty */
+#define	SSPA_CTL_JST		(1 << 3)	/* Audio Sample Justification */
+#define	SSPA_CTL_XFRLEN2_MASK	(7 << 24)
+#define	SSPA_CTL_XFRLEN2(x)	((x) << 24)	/* Transmit Frame Length in Phase 2 */
+#define	SSPA_CTL_XWDLEN2_MASK	(7 << 21)
+#define	SSPA_CTL_XWDLEN2(x)	((x) << 21)	/* Transmit Word Length in Phase 2 */
+#define	SSPA_CTL_XDATDLY(x)	((x) << 19)	/* Tansmit Data Delay */
+#define	SSPA_CTL_XSSZ2_MASK	(7 << 16)
+#define	SSPA_CTL_XSSZ2(x)	((x) << 16)	/* Transmit Sample Audio Size */
+#define	SSPA_CTL_XFRLEN1_MASK	(7 << 8)
+#define	SSPA_CTL_XFRLEN1(x)	((x) << 8)	/* Transmit Frame Length in Phase 1 */
+#define	SSPA_CTL_XWDLEN1_MASK	(7 << 5)
+#define	SSPA_CTL_XWDLEN1(x)	((x) << 5)	/* Transmit Word Length in Phase 1 */
+#define	SSPA_CTL_XSSZ1_MASK	(7 << 0)
+#define	SSPA_CTL_XSSZ1(x)	((x) << 0)	/* XSSZ1 */
+
+#define SSPA_CTL_8_BITS		(0x0)		/* Sample Size */
+#define SSPA_CTL_12_BITS	(0x1)
+#define SSPA_CTL_16_BITS	(0x2)
+#define SSPA_CTL_20_BITS	(0x3)
+#define SSPA_CTL_24_BITS	(0x4)
+#define SSPA_CTL_32_BITS	(0x5)
+
+/* SSPA Serial Port Register */
+#define	SSPA_SP_WEN		(1 << 31)	/* Write Configuration Enable */
+#define	SSPA_SP_MSL		(1 << 18)	/* Master Slave Configuration */
+#define	SSPA_SP_CLKP		(1 << 17)	/* CLKP Polarity Clock Edge Select */
+#define	SSPA_SP_FSP		(1 << 16)	/* FSP Polarity Clock Edge Select */
+#define	SSPA_SP_FFLUSH		(1 << 2)	/* FIFO Flush */
+#define	SSPA_SP_S_RST		(1 << 1)	/* Active High Reset Signal */
+#define	SSPA_SP_S_EN		(1 << 0)	/* Serial Clock Domain Enable */
+#define	SSPA_SP_FWID(x)		((x) << 20)	/* Frame-Sync Width */
+#define	SSPA_TXSP_FPER(x)	((x) << 4)	/* Frame-Sync Active */
+
+/* sspa clock sources */
+#define MMP_SSPA_CLK_PLL	0
+#define MMP_SSPA_CLK_VCXO	1
+#define MMP_SSPA_CLK_AUDIO	3
+
+/* sspa pll id */
+#define MMP_SYSCLK		0
+#define MMP_SSPA_CLK		1
+
+#endif /* _MMP_SSPA_H */
-- 
1.7.1
