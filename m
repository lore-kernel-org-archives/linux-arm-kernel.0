From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 28 Oct 2013 06:56:16 +0800
Subject: [PATCH v2 3/6] ASoC: usp-pcm: add CPU DAI driver for PCM simulated
 from USP
Message-ID: <1382914576-4785-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <Rongjun.Ying@csr.com>

Universal Serial Ports (USP) can be used as PCM. this patch
adds support for this functionality.

The USP provides 128-byte data FIFO which supports DMA and I/O
modes. Here we use the common DMA driver.

Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 -v2:
 check the validation of div_id and rate for usp_pcm_divider;
 runtime PM enabled;
 use devm_clk_get instead of clk_get

 sound/soc/sirf/Kconfig    |   3 +
 sound/soc/sirf/Makefile   |   2 +
 sound/soc/sirf/sirf-usp.c | 481 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/sirf/sirf-usp.h | 277 ++++++++++++++++++++++++++
 4 files changed, 763 insertions(+)
 create mode 100644 sound/soc/sirf/sirf-usp.c
 create mode 100644 sound/soc/sirf/sirf-usp.h

diff --git a/sound/soc/sirf/Kconfig b/sound/soc/sirf/Kconfig
index 5064cfc..5e395d3 100644
--- a/sound/soc/sirf/Kconfig
+++ b/sound/soc/sirf/Kconfig
@@ -5,3 +5,6 @@ config SND_SIRF_SOC
 
 config SND_SOC_SIRF_I2S
 	tristate
+
+config SND_SOC_SIRF_USP
+	tristate
diff --git a/sound/soc/sirf/Makefile b/sound/soc/sirf/Makefile
index 9f754fe..630c9be 100644
--- a/sound/soc/sirf/Makefile
+++ b/sound/soc/sirf/Makefile
@@ -1,5 +1,7 @@
 snd-soc-sirf-objs := sirf-pcm.o
 snd-soc-sirf-i2s-objs := sirf-i2s.o
+snd-soc-sirf-usp-objs := sirf-usp.o
 
 obj-$(CONFIG_SND_SIRF_SOC) += snd-soc-sirf.o
 obj-$(CONFIG_SND_SOC_SIRF_I2S) += snd-soc-sirf-i2s.o
+obj-$(CONFIG_SND_SOC_SIRF_USP) += snd-soc-sirf-usp.o
diff --git a/sound/soc/sirf/sirf-usp.c b/sound/soc/sirf/sirf-usp.c
new file mode 100644
index 0000000..da377e5
--- /dev/null
+++ b/sound/soc/sirf/sirf-usp.c
@@ -0,0 +1,481 @@
+/*
+ * SiRF USP audio transfer interface like I2S
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/clk.h>
+#include <linux/pm_runtime.h>
+#include <sound/soc.h>
+#include <sound/dmaengine_pcm.h>
+
+#include "sirf-usp.h"
+
+#define FIFO_RESET  0
+#define FIFO_START	1
+#define FIFO_STOP	2
+
+#define AUDIO_WORD_SIZE 16
+
+struct sirf_usp {
+	void __iomem *base;
+	struct clk *clk;
+	u32 mode1_reg;
+	u32 mode2_reg;
+	struct platform_device *sirf_pcm_pdev;
+};
+
+static struct snd_dmaengine_dai_dma_data dma_data[2];
+
+static void sirf_usp_tx_fifo_op(struct sirf_usp *susp, int cmd)
+{
+	switch (cmd) {
+	case FIFO_RESET:
+		writel(USP_TX_FIFO_RESET, susp->base + USP_TX_FIFO_OP);
+		writel(0, susp->base + USP_TX_FIFO_OP);
+		break;
+	case FIFO_START:
+		writel(USP_TX_FIFO_START, susp->base + USP_TX_FIFO_OP);
+		break;
+	case FIFO_STOP:
+		writel(0, susp->base + USP_TX_FIFO_OP);
+		break;
+	}
+}
+
+static void sirf_usp_rx_fifo_op(struct sirf_usp *susp, int cmd)
+{
+	switch (cmd) {
+	case FIFO_RESET:
+		writel(USP_RX_FIFO_RESET, susp->base + USP_RX_FIFO_OP);
+		writel(0, susp->base + USP_RX_FIFO_OP);
+		break;
+	case FIFO_START:
+		writel(USP_RX_FIFO_START, susp->base + USP_RX_FIFO_OP);
+		break;
+	case FIFO_STOP:
+		writel(0, susp->base + USP_RX_FIFO_OP);
+		break;
+	}
+}
+
+static inline void sirf_usp_tx_enable(struct sirf_usp *susp)
+{
+	writel(readl(susp->base + USP_TX_RX_ENABLE) | USP_TX_ENA,
+			susp->base + USP_TX_RX_ENABLE);
+}
+
+static inline void sirf_usp_tx_disable(struct sirf_usp *susp)
+{
+	writel(readl(susp->base + USP_TX_RX_ENABLE) & ~USP_TX_ENA,
+			susp->base + USP_TX_RX_ENABLE);
+}
+
+static inline void sirf_usp_rx_enable(struct sirf_usp *susp)
+{
+	writel(readl(susp->base + USP_TX_RX_ENABLE) | USP_RX_ENA,
+			susp->base + USP_TX_RX_ENABLE);
+}
+
+static inline void sirf_usp_rx_disable(struct sirf_usp *susp)
+{
+	writel(readl(susp->base + USP_TX_RX_ENABLE) & ~USP_RX_ENA,
+			susp->base + USP_TX_RX_ENABLE);
+}
+
+static int sirf_usp_pcm_dai_probe(struct snd_soc_dai *dai)
+{
+	dai->playback_dma_data = &dma_data[0];
+	dai->capture_dma_data = &dma_data[1];
+	return 0;
+}
+
+static int sirf_usp_pcm_startup(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	pm_runtime_get_sync(dai->dev);
+	return 0;
+}
+
+static void sirf_usp_pcm_shutdown(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	pm_runtime_put(dai->dev);
+}
+
+static int sirf_usp_pcm_set_dai_fmt(struct snd_soc_dai *dai,
+		unsigned int fmt)
+{
+	struct sirf_usp *susp = snd_soc_dai_get_drvdata(dai);
+	u32 val = readl(susp->base + USP_MODE2);
+	u32 val1 = readl(susp->base + USP_MODE1);
+
+	/* set master/slave audio interface */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		val1 &= ~USP_CLOCK_MODE_SLAVE;
+		val &= ~USP_TFS_CLK_SLAVE_MODE;
+		val &= ~USP_RFS_CLK_SLAVE_MODE;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		val1 |= USP_CLOCK_MODE_SLAVE;
+		val |= USP_TFS_CLK_SLAVE_MODE;
+		val |= USP_RFS_CLK_SLAVE_MODE;
+		break;
+	default:
+		return -EINVAL;
+	}
+	writel(val1, susp->base + USP_MODE1);
+	writel(val, susp->base + USP_MODE2);
+
+	return 0;
+}
+
+static int sirf_usp_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
+				struct snd_soc_dai *dai)
+{
+	int playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
+	struct sirf_usp *susp = snd_soc_dai_get_drvdata(dai);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (playback) {
+			sirf_usp_tx_fifo_op(susp, FIFO_RESET);
+			sirf_usp_tx_fifo_op(susp, FIFO_START);
+			sirf_usp_tx_enable(susp);
+		} else {
+			sirf_usp_rx_fifo_op(susp, FIFO_RESET);
+			sirf_usp_rx_fifo_op(susp, FIFO_START);
+			sirf_usp_rx_enable(susp);
+		}
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (playback) {
+			sirf_usp_tx_disable(susp);
+			sirf_usp_tx_fifo_op(susp, FIFO_STOP);
+		} else {
+			sirf_usp_rx_disable(susp);
+			sirf_usp_rx_fifo_op(susp, FIFO_STOP);
+		}
+		break;
+	}
+
+	return 0;
+}
+
+static int sirf_usp_pcm_divider(struct snd_soc_dai *dai, int div_id, int rate)
+{
+	struct sirf_usp *susp = snd_soc_dai_get_drvdata(dai);
+	u32 clk_rate, clk_div, clk_div_hi, clk_div_lo;
+
+	if (div_id != SIRF_USP_DIV_MCLK)
+		return -EINVAL;
+
+	clk_rate = clk_get_rate(susp->clk);
+	if (clk_rate < rate * 2) {
+		dev_err(dai->dev, "Can't get rate(%d) by need.\n", rate);
+		return -EINVAL;
+	}
+
+	clk_div = (clk_rate / (2 * rate)) - 1;
+	clk_div_hi = (clk_div & 0xC00) >> 10;
+	clk_div_lo = (clk_div & 0x3FF);
+
+	writel((clk_div_lo << 21) | readl(susp->base + USP_MODE2),
+		susp->base + USP_MODE2);
+	writel((clk_div_hi << 30) | readl(susp->base + USP_TX_FRAME_CTRL),
+		susp->base + USP_TX_FRAME_CTRL);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops sirf_usp_pcm_dai_ops = {
+	.startup = sirf_usp_pcm_startup,
+	.trigger = sirf_usp_pcm_trigger,
+	.set_fmt = sirf_usp_pcm_set_dai_fmt,
+	.set_clkdiv = sirf_usp_pcm_divider,
+	.shutdown = sirf_usp_pcm_shutdown,
+};
+
+static struct snd_soc_dai_driver sirf_usp_pcm_dai = {
+	.probe = sirf_usp_pcm_dai_probe,
+	.name		= "sirf-usp-pcm",
+	.id			= 0,
+	.playback = {
+		.stream_name = "SiRF USP PCM Playback",
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = SNDRV_PCM_RATE_48000
+			| SNDRV_PCM_RATE_44100
+			| SNDRV_PCM_RATE_32000
+			| SNDRV_PCM_RATE_22050
+			| SNDRV_PCM_RATE_16000
+			| SNDRV_PCM_RATE_11025
+			| SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.stream_name = "SiRF USP PCM Capture",
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = SNDRV_PCM_RATE_48000
+			| SNDRV_PCM_RATE_44100
+			| SNDRV_PCM_RATE_32000
+			| SNDRV_PCM_RATE_22050
+			| SNDRV_PCM_RATE_16000
+			| SNDRV_PCM_RATE_11025
+			| SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.ops = &sirf_usp_pcm_dai_ops,
+};
+
+static void sirf_usp_controller_init(struct sirf_usp *susp)
+{
+	u32 val;
+
+	/* Configure RISC mode */
+	writel(readl(susp->base + USP_RISC_DSP_MODE) & ~USP_RISC_DSP_SEL,
+		susp->base + USP_RISC_DSP_MODE);
+
+	/* Disable all interrupts status */
+	writel(readl(susp->base + USP_INT_STATUS), susp->base + USP_INT_STATUS);
+
+	/* Configure DMA IO Length register */
+	writel(0, susp->base + USP_TX_DMA_IO_LEN);
+	writel(0, susp->base + USP_RX_DMA_IO_LEN);
+
+	/* Configure RX Frame Control */
+	val = (AUDIO_WORD_SIZE * 2 - 1) << USP_RXC_DATA_LEN_OFFSET;
+	val |= (AUDIO_WORD_SIZE * 2 - 1) << USP_RXC_FRAME_LEN_OFFSET;
+	val |= (AUDIO_WORD_SIZE * 2 - 1) << USP_RXC_SHIFTER_LEN_OFFSET;
+	val |= USP_SINGLE_SYNC_MODE;
+	writel(val, susp->base + USP_RX_FRAME_CTRL);
+
+	/* Configure TX Frame Control */
+	val = (AUDIO_WORD_SIZE * 2 - 1) << USP_TXC_DATA_LEN_OFFSET;
+	val |= 0 << USP_TXC_SYNC_LEN_OFFSET;
+	val |= (AUDIO_WORD_SIZE * 2 - 1) << USP_TXC_FRAME_LEN_OFFSET;
+	val |= (AUDIO_WORD_SIZE * 2 - 1) << USP_TXC_SHIFTER_LEN_OFFSET;
+	val |= USP_TXC_SLAVE_CLK_SAMPLE;
+	writel(val, susp->base + USP_TX_FRAME_CTRL);
+
+	/* Configure Mode2 register */
+	val = (1 << USP_RXD_DELAY_LEN_OFFSET) | (0 << USP_TXD_DELAY_LEN_OFFSET);
+	val &= ~USP_ENA_CTRL_MODE;
+	val &= ~USP_FRAME_CTRL_MODE;
+	val &= ~USP_TFS_SOURCE_MODE;
+	writel(val, susp->base + USP_MODE2);
+
+	/* Configure Mode1 register */
+	val = 0;
+	val |= USP_SYNC_MODE;
+	val |= USP_ENDIAN_CTRL_LSBF;
+	val |= USP_EN;
+	val |= USP_RXD_ACT_EDGE_FALLING;
+	val &= ~USP_TXD_ACT_EDGE_FALLING;
+	val |= USP_RFS_ACT_LEVEL_LOGIC1;
+	val |= USP_TFS_ACT_LEVEL_LOGIC1;
+	val |= USP_SCLK_IDLE_MODE_TOGGLE;
+	val |= USP_SCLK_IDLE_LEVEL_LOGIC1;
+	val &= ~USP_SCLK_PIN_MODE_IO;
+	val &= ~USP_RFS_PIN_MODE_IO;
+	val &= ~USP_TFS_PIN_MODE_IO;
+	val &= ~USP_RXD_PIN_MODE_IO;
+	val &= ~USP_TXD_PIN_MODE_IO;
+	val |= USP_TX_UFLOW_REPEAT_ZERO;
+	writel(val, susp->base + USP_MODE1);
+
+	/* Configure RX DMA IO Control register */
+	writel(0x0, susp->base + USP_RX_DMA_IO_CTRL);
+
+	/* Congiure RX FIFO Control register */
+	writel((USP_RX_FIFO_THRESHOLD << USP_RX_FIFO_THD_OFFSET) |
+		(USP_TX_RX_FIFO_WIDTH_DWORD << USP_RX_FIFO_WIDTH_OFFSET),
+		susp->base + USP_RX_FIFO_CTRL);
+
+	/* Congiure RX FIFO Level Check register */
+	writel(RX_FIFO_SC(0x04) | RX_FIFO_LC(0x0E) | RX_FIFO_HC(0x1B),
+		susp->base + USP_RX_FIFO_LEVEL_CHK);
+
+	/* Configure TX DMA IO Control register*/
+	writel(0x0, susp->base + USP_TX_DMA_IO_CTRL);
+
+	/* Configure TX FIFO Control register */
+	writel((USP_TX_FIFO_THRESHOLD << USP_TX_FIFO_THD_OFFSET) |
+		(USP_TX_RX_FIFO_WIDTH_DWORD << USP_TX_FIFO_WIDTH_OFFSET),
+		susp->base + USP_TX_FIFO_CTRL);
+
+	/* Congiure TX FIFO Level Check register */
+	writel(TX_FIFO_SC(0x1B) | TX_FIFO_LC(0x0E) | TX_FIFO_HC(0x04),
+		susp->base + USP_TX_FIFO_LEVEL_CHK);
+
+	/* Configure RX FIFO */
+	writel(USP_RX_FIFO_RESET, susp->base + USP_RX_FIFO_OP);
+	writel(0, susp->base + USP_RX_FIFO_OP);
+
+	/* Configure TX FIFO */
+	writel(USP_TX_FIFO_RESET, susp->base + USP_TX_FIFO_OP);
+	writel(0, susp->base + USP_TX_FIFO_OP);
+}
+
+static void sirf_usp_controller_uninit(struct sirf_usp *susp)
+{
+	/* Disable RX/TX */
+	writel(0, susp->base + USP_INT_ENABLE);
+	writel(0, susp->base + USP_TX_RX_ENABLE);
+}
+
+#ifdef CONFIG_PM_RUNTIME
+static int sirf_usp_pcm_runtime_suspend(struct device *dev)
+{
+	struct sirf_usp *susp = dev_get_drvdata(dev);
+	sirf_usp_controller_uninit(susp);
+	clk_disable_unprepare(susp->clk);
+	return 0;
+}
+
+static int sirf_usp_pcm_runtime_resume(struct device *dev)
+{
+	struct sirf_usp *susp = dev_get_drvdata(dev);
+	clk_prepare_enable(susp->clk);
+	sirf_usp_controller_init(susp);
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+static int sirf_usp_pcm_suspend(struct device *dev)
+{
+	struct sirf_usp *susp = dev_get_drvdata(dev);
+
+	if (!pm_runtime_status_suspended(dev)) {
+		susp->mode1_reg = readl(susp->base + USP_MODE1);
+		susp->mode2_reg = readl(susp->base + USP_MODE2);
+		sirf_usp_pcm_runtime_suspend(dev);
+	}
+	return 0;
+}
+
+static int sirf_usp_pcm_resume(struct device *dev)
+{
+	struct sirf_usp *susp = dev_get_drvdata(dev);
+
+	if (!pm_runtime_status_suspended(dev)) {
+		sirf_usp_pcm_runtime_resume(dev);
+		writel(susp->mode1_reg, susp->base + USP_MODE1);
+		writel(susp->mode2_reg, susp->base + USP_MODE2);
+	}
+	return 0;
+}
+#endif
+
+static const struct snd_soc_component_driver sirf_usp_component = {
+	.name		= "sirf-usp",
+};
+
+static int sirf_usp_pcm_probe(struct platform_device *pdev)
+{
+	struct sirf_usp *susp;
+	u32 rx_dma_ch, tx_dma_ch;
+	int ret;
+	struct resource *mem_res;
+
+	susp = devm_kzalloc(&pdev->dev, sizeof(struct sirf_usp),
+			GFP_KERNEL);
+	if (!susp)
+		return -ENOMEM;
+
+	susp->sirf_pcm_pdev = platform_device_register_simple("sirf-pcm-audio",
+			2, NULL, 0);
+	if (IS_ERR(susp->sirf_pcm_pdev))
+		return PTR_ERR(susp->sirf_pcm_pdev);
+
+	platform_set_drvdata(pdev, susp);
+
+	ret = of_property_read_u32(pdev->dev.of_node,
+			"sirf,usp-dma-rx-channel", &rx_dma_ch);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Unable to USP0 rx dma channel\n");
+		return ret;
+	}
+	ret = of_property_read_u32(pdev->dev.of_node,
+			"sirf,usp-dma-tx-channel", &tx_dma_ch);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Unable to USP0 tx dma channel\n");
+		return ret;
+	}
+
+	dma_data[0].filter_data = (void *)tx_dma_ch;
+	dma_data[1].filter_data = (void *)rx_dma_ch;
+
+	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	susp->base = devm_ioremap_resource(&pdev->dev, mem_res);
+	if (susp->base == NULL)
+		return -ENOMEM;
+
+	susp->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(susp->clk)) {
+		dev_err(&pdev->dev, "Get clock failed.\n");
+		return PTR_ERR(susp->clk);
+	}
+	clk_prepare_enable(susp->clk);
+
+	ret = snd_soc_register_component(&pdev->dev, &sirf_usp_component,
+		&sirf_usp_pcm_dai, 1);
+	if (ret) {
+		dev_err(&pdev->dev, "Register Audio SoC dai failed.\n");
+		goto err;
+	}
+	pm_runtime_enable(&pdev->dev);
+	return 0;
+
+err:
+	return ret;
+}
+
+static int sirf_usp_pcm_remove(struct platform_device *pdev)
+{
+	struct sirf_usp *susp = platform_get_drvdata(pdev);
+	snd_soc_unregister_component(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	platform_device_unregister(susp->sirf_pcm_pdev);
+
+	return 0;
+}
+
+static const struct of_device_id sirf_usp_pcm_of_match[] = {
+	{ .compatible = "sirf,prima2-usp-pcm", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sirf_usp_pcm_of_match);
+
+static const struct dev_pm_ops sirf_usp_pcm_pm_ops = {
+	SET_RUNTIME_PM_OPS(sirf_usp_pcm_runtime_suspend, sirf_usp_pcm_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(sirf_usp_pcm_suspend, sirf_usp_pcm_resume)
+};
+
+static struct platform_driver sirf_usp_pcm_driver = {
+	.driver = {
+		.name = "sirf-usp-pcm",
+		.owner = THIS_MODULE,
+		.of_match_table = sirf_usp_pcm_of_match,
+		.pm = &sirf_usp_pcm_pm_ops,
+	},
+	.probe = sirf_usp_pcm_probe,
+	.remove = sirf_usp_pcm_remove,
+};
+
+module_platform_driver(sirf_usp_pcm_driver);
+
+MODULE_DESCRIPTION("SiRF SoC USP PCM bus driver");
+MODULE_AUTHOR("RongJun Ying <Rongjun.Ying@csr.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/sirf/sirf-usp.h b/sound/soc/sirf/sirf-usp.h
new file mode 100644
index 0000000..62afc0d
--- /dev/null
+++ b/sound/soc/sirf/sirf-usp.h
@@ -0,0 +1,277 @@
+/*
+ * arch/arm/mach-prima2/include/mach/sirfsoc_usp.h
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __SIRFSOC_USP__
+#define __SIRFSOC_USP__
+
+/* USP Registers */
+#define USP_MODE1		0x00
+#define USP_MODE2 		0x04
+#define USP_TX_FRAME_CTRL  	0x08
+#define USP_RX_FRAME_CTRL	0x0C
+#define USP_TX_RX_ENABLE	0x10
+#define USP_INT_ENABLE		0x14
+#define USP_INT_STATUS		0x18
+#define USP_PIN_IO_DATA		0x1C
+#define USP_RISC_DSP_MODE	0x20
+#define USP_AYSNC_PARAM_REG	0x24
+#define USP_IRDA_X_MODE_DIV	0x28
+#define USP_SM_CFG		0x2C
+#define USP_TX_DMA_IO_CTRL	0x100
+#define USP_TX_DMA_IO_LEN	0x104
+#define USP_TX_FIFO_CTRL	0x108
+#define USP_TX_FIFO_LEVEL_CHK	0x10C
+#define USP_TX_FIFO_OP		0x110
+#define USP_TX_FIFO_STATUS	0x114
+#define USP_TX_FIFO_DATA	0x118
+#define USP_RX_DMA_IO_CTRL	0x120
+#define USP_RX_DMA_IO_LEN	0x124
+#define USP_RX_FIFO_CTRL	0x128
+#define USP_RX_FIFO_LEVEL_CHK	0x12C
+#define USP_RX_FIFO_OP		0x130
+#define USP_RX_FIFO_STATUS	0x134
+#define USP_RX_FIFO_DATA	0x138
+
+/* USP MODE register-1 */
+#define USP_SYNC_MODE 			0x00000001
+#define USP_CLOCK_MODE_SLAVE 		0x00000002
+#define USP_LOOP_BACK_EN		0x00000004
+#define USP_HPSIR_EN			0x00000008
+#define USP_ENDIAN_CTRL_LSBF		0x00000010
+#define USP_EN				0x00000020
+#define USP_RXD_ACT_EDGE_FALLING	0x00000040
+#define USP_TXD_ACT_EDGE_FALLING	0x00000080
+#define USP_RFS_ACT_LEVEL_LOGIC1	0x00000100
+#define USP_TFS_ACT_LEVEL_LOGIC1	0x00000200
+#define USP_SCLK_IDLE_MODE_TOGGLE	0x00000400
+#define USP_SCLK_IDLE_LEVEL_LOGIC1	0x00000800
+#define USP_SCLK_PIN_MODE_IO	0x00001000
+#define USP_RFS_PIN_MODE_IO	0x00002000
+#define USP_TFS_PIN_MODE_IO	0x00004000
+#define USP_RXD_PIN_MODE_IO	0x00008000
+#define USP_TXD_PIN_MODE_IO	0x00010000
+#define USP_SCLK_IO_MODE_INPUT	0x00020000
+#define USP_RFS_IO_MODE_INPUT	0x00040000
+#define USP_TFS_IO_MODE_INPUT	0x00080000
+#define USP_RXD_IO_MODE_INPUT	0x00100000
+#define USP_TXD_IO_MODE_INPUT	0x00200000
+#define USP_IRDA_WIDTH_DIV_MASK	0x3FC00000
+#define USP_IRDA_WIDTH_DIV_OFFSET	0
+#define USP_IRDA_IDLE_LEVEL_HIGH	0x40000000
+#define USP_TX_UFLOW_REPEAT_ZERO	0x80000000
+#define USP_TX_ENDIAN_MODE		0x00000020
+#define USP_RX_ENDIAN_MODE		0x00000020
+
+/* USP Mode Register-2 */
+#define USP_RXD_DELAY_LEN_MASK		0x000000FF
+#define USP_RXD_DELAY_LEN_OFFSET	0
+
+#define USP_TXD_DELAY_LEN_MASK		0x0000FF00
+#define USP_TXD_DELAY_LEN_OFFSET	8
+
+#define USP_ENA_CTRL_MODE		0x00010000
+#define USP_FRAME_CTRL_MODE		0x00020000
+#define USP_TFS_SOURCE_MODE             0x00040000
+#define USP_TFS_MS_MODE                 0x00080000
+#define USP_CLK_DIVISOR_MASK		0x7FE00000
+#define USP_CLK_DIVISOR_OFFSET 		21
+
+#define USP_TFS_CLK_SLAVE_MODE		(1<<20)
+#define USP_RFS_CLK_SLAVE_MODE		(1<<19)
+
+#define USP_IRDA_DATA_WIDTH		0x80000000
+
+/* USP Transmit Frame Control Register */
+
+#define USP_TXC_DATA_LEN_MASK		0x000000FF
+#define USP_TXC_DATA_LEN_OFFSET		0
+
+#define USP_TXC_SYNC_LEN_MASK		0x0000FF00
+#define USP_TXC_SYNC_LEN_OFFSET		8
+
+#define USP_TXC_FRAME_LEN_MASK		0x00FF0000
+#define USP_TXC_FRAME_LEN_OFFSET 	16
+
+#define USP_TXC_SHIFTER_LEN_MASK	0x1F000000
+#define USP_TXC_SHIFTER_LEN_OFFSET	24
+
+#define USP_TXC_SLAVE_CLK_SAMPLE 	0x20000000
+
+#define USP_TXC_CLK_DIVISOR_MASK  	0xC0000000
+#define USP_TXC_CLK_DIVISOR_OFFSET 	30
+
+/* USP Receive Frame Control Register */
+
+#define USP_RXC_DATA_LEN_MASK 		0x000000FF
+#define USP_RXC_DATA_LEN_OFFSET		0
+
+#define USP_RXC_FRAME_LEN_MASK		0x0000FF00
+#define USP_RXC_FRAME_LEN_OFFSET  	8
+
+#define USP_RXC_SHIFTER_LEN_MASK 	0x001F0000
+#define USP_RXC_SHIFTER_LEN_OFFSET 	16
+
+#define USP_I2S_SYNC_CHG		0x00200000
+
+#define USP_RXC_CLK_DIVISOR_MASK  	0x0F000000
+#define USP_RXC_CLK_DIVISOR_OFFSET 	24
+#define USP_SINGLE_SYNC_MODE		0x00400000
+
+/* Tx - RX Enable Register */
+
+#define USP_RX_ENA		0x00000001
+#define USP_TX_ENA		0x00000002
+
+/* USP Interrupt Enable and status Register */
+#define USP_RX_DONE_INT			0x00000001
+#define USP_TX_DONE_INT			0x00000002
+#define USP_RX_OFLOW_INT		0x00000004
+#define USP_TX_UFLOW_INT		0x00000008
+#define USP_RX_IO_DMA_INT		0x00000010
+#define USP_TX_IO_DMA_INT		0x00000020
+#define USP_RXFIFO_FULL_INT		0x00000040
+#define USP_TXFIFO_EMPTY_INT		0x00000080
+#define USP_RXFIFO_THD_INT		0x00000100
+#define USP_TXFIFO_THD_INT		0x00000200
+#define USP_UART_FRM_ERR_INT		0x00000400
+#define USP_RX_TIMEOUT_INT 		0x00000800
+#define USP_TX_ALLOUT_INT  		0x00001000
+#define USP_RXD_BREAK_INT		0x00008000
+
+/* All possible TX interruots */
+#define USP_TX_INTERRUPT		(USP_TX_DONE_INT|USP_TX_UFLOW_INT|USP_TX_IO_DMA_INT|\
+					USP_TXFIFO_EMPTY_INT|USP_TXFIFO_THD_INT)
+/* All possible RX interruots */
+#define USP_RX_INTERRUPT		(USP_RX_DONE_INT|USP_RX_OFLOW_INT|USP_RX_IO_DMA_INT|\
+					USP_RXFIFO_FULL_INT|USP_RXFIFO_THD_INT|USP_RXFIFO_THD_INT|USP_RX_TIMEOUT_INT)
+
+#define USP_INT_ALL        0x1FFF
+
+/* USP Pin I/O Data Register */
+
+#define USP_RFS_PIN_VALUE_MASK	0x00000001
+#define USP_TFS_PIN_VALUE_MASK	0x00000002
+#define USP_RXD_PIN_VALUE_MASK	0x00000004
+#define USP_TXD_PIN_VALUE_MASK	0x00000008
+#define USP_SCLK_PIN_VALUE_MASK	0x00000010
+
+/* USP RISC/DSP Mode Register */
+#define USP_RISC_DSP_SEL	0x00000001
+
+/* USP ASYNC PARAMETER Register*/
+
+#define USP_ASYNC_TIMEOUT_MASK 	0x0000FFFF
+#define USP_ASYNC_TIMEOUT_OFFSET	0
+#define USP_ASYNC_TIMEOUT(x)	(((x)&USP_ASYNC_TIMEOUT_MASK)<<USP_ASYNC_TIMEOUT_OFFSET)
+
+#define USP_ASYNC_DIV2_MASK		0x003F0000
+#define USP_ASYNC_DIV2_OFFSET		16
+
+/* USP TX DMA I/O MODE Register */
+#define USP_TX_MODE_IO			0x00000001
+
+/* USP TX DMA I/O Length Register */
+#define USP_TX_DATA_LEN_MASK		0xFFFFFFFF
+#define USP_TX_DATA_LEN_OFFSET		0
+
+/* USP TX FIFO Control Register */
+#define USP_TX_FIFO_WIDTH_MASK		0x00000003
+#define USP_TX_FIFO_WIDTH_OFFSET	0
+
+#define USP_TX_FIFO_THD_MASK		0x000001FC
+#define USP_TX_FIFO_THD_OFFSET		2
+
+/* USP TX FIFO Level Check Register */
+#define USP_TX_FIFO_LEVEL_CHECK_MASK	0x1F
+#define USP_TX_FIFO_SC_OFFSET	0
+#define USP_TX_FIFO_LC_OFFSET	10
+#define USP_TX_FIFO_HC_OFFSET	20
+
+#define TX_FIFO_SC(x)		(((x) & USP_TX_FIFO_LEVEL_CHECK_MASK) << USP_TX_FIFO_SC_OFFSET)
+#define TX_FIFO_LC(x)		(((x) & USP_TX_FIFO_LEVEL_CHECK_MASK) << USP_TX_FIFO_LC_OFFSET)
+#define TX_FIFO_HC(x)		(((x) & USP_TX_FIFO_LEVEL_CHECK_MASK) << USP_TX_FIFO_HC_OFFSET)
+
+/* USP TX FIFO Operation Register */
+#define USP_TX_FIFO_RESET		0x00000001
+#define USP_TX_FIFO_START		0x00000002
+
+/* USP TX FIFO Status Register */
+#define USP_TX_FIFO_LEVEL_MASK		0x0000007F
+#define USP_TX_FIFO_LEVEL_OFFSET	0
+
+#define USP_TX_FIFO_FULL 		0x00000080
+#define USP_TX_FIFO_EMPTY		0x00000100
+
+/* USP TX FIFO Data Register */
+#define USP_TX_FIFO_DATA_MASK		0xFFFFFFFF
+#define USP_TX_FIFO_DATA_OFFSET		0
+
+/* USP RX DMA I/O MODE Register */
+#define USP_RX_MODE_IO			0x00000001
+#define USP_RX_DMA_FLUSH		0x00000004
+
+/* USP RX DMA I/O Length Register */
+#define USP_RX_DATA_LEN_MASK		0xFFFFFFFF
+#define USP_RX_DATA_LEN_OFFSET		0
+
+/* USP RX FIFO Control Register */
+#define USP_RX_FIFO_WIDTH_MASK		0x00000003
+#define USP_RX_FIFO_WIDTH_OFFSET	0
+
+#define USP_RX_FIFO_THD_MASK		0x000001FC
+#define USP_RX_FIFO_THD_OFFSET		2
+
+/* USP RX FIFO Level Check Register */
+
+#define USP_RX_FIFO_LEVEL_CHECK_MASK	0x1F
+#define USP_RX_FIFO_SC_OFFSET	0
+#define USP_RX_FIFO_LC_OFFSET	10
+#define USP_RX_FIFO_HC_OFFSET	20
+
+#define RX_FIFO_SC(x)		(((x) & USP_RX_FIFO_LEVEL_CHECK_MASK) << USP_RX_FIFO_SC_OFFSET)
+#define RX_FIFO_LC(x)		(((x) & USP_RX_FIFO_LEVEL_CHECK_MASK) << USP_RX_FIFO_LC_OFFSET)
+#define RX_FIFO_HC(x)		(((x) & USP_RX_FIFO_LEVEL_CHECK_MASK) << USP_RX_FIFO_HC_OFFSET)
+
+/* USP RX FIFO Operation Register */
+#define USP_RX_FIFO_RESET		0x00000001
+#define USP_RX_FIFO_START		0x00000002
+
+/* USP RX FIFO Status Register */
+
+#define USP_RX_FIFO_LEVEL_MASK		0x0000007F
+#define USP_RX_FIFO_LEVEL_OFFSET	0
+
+#define USP_RX_FIFO_FULL		0x00000080
+#define USP_RX_FIFO_EMPTY		0x00000100
+
+/* USP RX FIFO Data Register */
+
+#define USP_RX_FIFO_DATA_MASK		0xFFFFFFFF
+#define USP_RX_FIFO_DATA_OFFSET		0
+
+/*
+ * When rx thd irq occur, sender just disable tx empty irq,
+ * Remaining data in tx fifo wil also be sent out.
+ */
+#define USP_FIFO_SIZE           	128
+#define USP_TX_FIFO_THRESHOLD		(USP_FIFO_SIZE/2)
+#define USP_RX_FIFO_THRESHOLD		(USP_FIFO_SIZE/2)
+
+/* FIFO_WIDTH for the USP_TX_FIFO_CTRL and USP_RX_FIFO_CTRL registers */
+#define USP_FIFO_WIDTH_BYTE  0x00
+#define USP_FIFO_WIDTH_WORD  0x01
+#define USP_FIFO_WIDTH_DWORD 0x02
+
+#define USP_ASYNC_DIV2          16
+
+#define USP_PLUGOUT_RETRY_CNT	2
+
+#define USP_TX_RX_FIFO_WIDTH_DWORD    2
+
+#define SIRF_USP_DIV_MCLK	0
+#endif
-- 
1.8.2.3
