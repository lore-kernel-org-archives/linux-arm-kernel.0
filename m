From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 28 Oct 2013 06:37:04 +0800
Subject: [PATCH v2 2/6] ASoC: sirf: add I2S CPU DAI driver
Message-ID: <1382913424-28626-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <Rongjun.Ying@csr.com>

This patch adds I2S DAI driver for SiRFprima2 and SiRFatlas6. The hardware supports:
I2S bus specification compliant (Released by Philips Semiconductors in June, 1996)
Supports I2S master and I2S slave mode
Provides MCLK to I2S CODEC in I2S master mode
Supports 16-bit resolution playback
Supports 16-bit resolution record
Supports 2 channel record
Supports 2 channel and 6 channel mode playback
Frame length, left channel length and right channel length are all programmable
Supports two DMA channels for TXFIFO and RXFIFO
Supports floating mode (x_ac97_dout can be configured as input)

headfile sound/soc/sirf/sirf-audio.h will be shard by all I2S and soc-inner
DAIs.

Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 -v2:
 runtime pm enabled;
 fix wrong device_reset path in v1;
 other minor fixes according to Mark's comments

 sound/soc/sirf/Kconfig      |   3 +
 sound/soc/sirf/Makefile     |   2 +
 sound/soc/sirf/sirf-audio.h | 268 +++++++++++++++++++++++++
 sound/soc/sirf/sirf-i2s.c   | 464 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 737 insertions(+)
 create mode 100644 sound/soc/sirf/sirf-audio.h
 create mode 100644 sound/soc/sirf/sirf-i2s.c

diff --git a/sound/soc/sirf/Kconfig b/sound/soc/sirf/Kconfig
index 1637089..5064cfc 100644
--- a/sound/soc/sirf/Kconfig
+++ b/sound/soc/sirf/Kconfig
@@ -2,3 +2,6 @@ config SND_SIRF_SOC
 	tristate "Platform DMA driver for the SiRF SoC chips"
 	depends on ARCH_SIRF && SND_SOC
 	select SND_SOC_GENERIC_DMAENGINE_PCM
+
+config SND_SOC_SIRF_I2S
+	tristate
diff --git a/sound/soc/sirf/Makefile b/sound/soc/sirf/Makefile
index f268b83..9f754fe 100644
--- a/sound/soc/sirf/Makefile
+++ b/sound/soc/sirf/Makefile
@@ -1,3 +1,5 @@
 snd-soc-sirf-objs := sirf-pcm.o
+snd-soc-sirf-i2s-objs := sirf-i2s.o
 
 obj-$(CONFIG_SND_SIRF_SOC) += snd-soc-sirf.o
+obj-$(CONFIG_SND_SOC_SIRF_I2S) += snd-soc-sirf-i2s.o
diff --git a/sound/soc/sirf/sirf-audio.h b/sound/soc/sirf/sirf-audio.h
new file mode 100644
index 0000000..b6fdf06
--- /dev/null
+++ b/sound/soc/sirf/sirf-audio.h
@@ -0,0 +1,268 @@
+/*
+ * SiRF inner codec controllers define
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef _SIRF_INNER_AUDIO_CTRL_H
+#define _SIRF_INNER_AUDIO_CTRL_H
+
+#define AUDIO_CTRL_TX_FIFO_LEVEL_CHECK_MASK     0x3F
+#define AUDIO_CTRL_TX_FIFO_SC_OFFSET    0
+#define AUDIO_CTRL_TX_FIFO_LC_OFFSET    10
+#define AUDIO_CTRL_TX_FIFO_HC_OFFSET    20
+
+#define TX_FIFO_SC(x)           (((x) & AUDIO_CTRL_TX_FIFO_LEVEL_CHECK_MASK) \
+				<< AUDIO_CTRL_TX_FIFO_SC_OFFSET)
+#define TX_FIFO_LC(x)           (((x) & AUDIO_CTRL_TX_FIFO_LEVEL_CHECK_MASK) \
+				<< AUDIO_CTRL_TX_FIFO_LC_OFFSET)
+#define TX_FIFO_HC(x)           (((x) & AUDIO_CTRL_TX_FIFO_LEVEL_CHECK_MASK) \
+				<< AUDIO_CTRL_TX_FIFO_HC_OFFSET)
+
+#define AUDIO_CTRL_RX_FIFO_LEVEL_CHECK_MASK     0x0F
+#define AUDIO_CTRL_RX_FIFO_SC_OFFSET    0
+#define AUDIO_CTRL_RX_FIFO_LC_OFFSET    10
+#define AUDIO_CTRL_RX_FIFO_HC_OFFSET    20
+
+#define RX_FIFO_SC(x)           (((x) & AUDIO_CTRL_RX_FIFO_LEVEL_CHECK_MASK) \
+				<< AUDIO_CTRL_RX_FIFO_SC_OFFSET)
+#define RX_FIFO_LC(x)           (((x) & AUDIO_CTRL_RX_FIFO_LEVEL_CHECK_MASK) \
+				<< AUDIO_CTRL_RX_FIFO_LC_OFFSET)
+#define RX_FIFO_HC(x)           (((x) & AUDIO_CTRL_RX_FIFO_LEVEL_CHECK_MASK) \
+				<< AUDIO_CTRL_RX_FIFO_HC_OFFSET)
+
+#define AUDIO_CTRL_MODE_SEL			(0x0000)
+#define AUDIO_CTRL_AC97_CTRL			(0x0004)
+#define AUDIO_CTRL_AC97_CMD			(0x0008)
+#define AUDIO_CTRL_AC97_OP_STATUS		(0x000C)
+#define AUDIO_CTRL_AC97_RD_CODEC_REG		(0x0010)
+#define AUDIO_CTRL_TXSLOT_EN			(0x0014)
+#define AUDIO_CTRL_RXSLOT_EN			(0x0018)
+#define AUDIO_CTRL_AC97_AUX_SLOT_EN		(0x001c)
+#define AUDIO_CTRL_I2S_CTRL			(0x0020)
+#define AUDIO_CTRL_I2S_TX_RX_EN			(0x0024)
+
+#define AUDIO_CTRL_EXT_TXFIFO1_OP		(0x0040)
+#define AUDIO_CTRL_EXT_TXFIFO1_LEV_CHK		(0x0044)
+#define AUDIO_CTRL_EXT_TXFIFO1_STS		(0x0048)
+#define AUDIO_CTRL_EXT_TXFIFO1_INT		(0x004C)
+#define AUDIO_CTRL_EXT_TXFIFO1_INT_MSK		(0x0050)
+
+#define AUDIO_CTRL_EXT_TXFIFO2_OP		(0x0054)
+#define AUDIO_CTRL_EXT_TXFIFO2_LEV_CHK		(0x0058)
+#define AUDIO_CTRL_EXT_TXFIFO2_STS		(0x005C)
+#define AUDIO_CTRL_EXT_TXFIFO2_INT		(0x0060)
+#define AUDIO_CTRL_EXT_TXFIFO2_INT_MSK		(0x0064)
+
+#define AUDIO_CTRL_EXT_TXFIFO3_OP		(0x0068)
+#define AUDIO_CTRL_EXT_TXFIFO3_LEV_CHK		(0x006C)
+#define AUDIO_CTRL_EXT_TXFIFO3_STS		(0x0070)
+#define AUDIO_CTRL_EXT_TXFIFO3_INT		(0x0074)
+#define AUDIO_CTRL_EXT_TXFIFO3_INT_MSK		(0x0078)
+
+#define AUDIO_CTRL_EXT_TXFIFO4_OP		(0x007C)
+#define AUDIO_CTRL_EXT_TXFIFO4_LEV_CHK		(0x0080)
+#define AUDIO_CTRL_EXT_TXFIFO4_STS		(0x0084)
+#define AUDIO_CTRL_EXT_TXFIFO4_INT		(0x0088)
+#define AUDIO_CTRL_EXT_TXFIFO4_INT_MSK		(0x008C)
+
+#define AUDIO_CTRL_EXT_TXFIFO5_OP		(0x0090)
+#define AUDIO_CTRL_EXT_TXFIFO5_LEV_CHK		(0x0094)
+#define AUDIO_CTRL_EXT_TXFIFO5_STS		(0x0098)
+#define AUDIO_CTRL_EXT_TXFIFO5_INT		(0x009C)
+#define AUDIO_CTRL_EXT_TXFIFO5_INT_MSK		(0x00A0)
+
+#define AUDIO_CTRL_EXT_TXFIFO6_OP		(0x00A4)
+#define AUDIO_CTRL_EXT_TXFIFO6_LEV_CHK		(0x00A8)
+#define AUDIO_CTRL_EXT_TXFIFO6_STS		(0x00AC)
+#define AUDIO_CTRL_EXT_TXFIFO6_INT		(0x00B0)
+#define AUDIO_CTRL_EXT_TXFIFO6_INT_MSK		(0x00B4)
+
+#define AUDIO_CTRL_RXFIFO_OP			(0x00B8)
+#define AUDIO_CTRL_RXFIFO_LEV_CHK		(0x00BC)
+#define AUDIO_CTRL_RXFIFO_STS			(0x00C0)
+#define AUDIO_CTRL_RXFIFO_INT			(0x00C4)
+#define AUDIO_CTRL_RXFIFO_INT_MSK		(0x00C8)
+
+#define AUDIO_CTRL_AUXFIFO_OP			(0x00CC)
+#define AUDIO_CTRL_AUXFIFO_LEV_CHK		(0x00D0)
+#define AUDIO_CTRL_AUXFIFO_STS			(0x00D4)
+#define AUDIO_CTRL_AUXFIFO_INT			(0x00D8)
+#define AUDIO_CTRL_AUXFIFO_INT_MSK		(0x00DC)
+
+#define AUDIO_IC_CODEC_PWR			(0x00E0)
+#define AUDIO_IC_CODEC_CTRL0			(0x00E4)
+#define AUDIO_IC_CODEC_CTRL1			(0x00E8)
+#define AUDIO_IC_CODEC_CTRL2			(0x00EC)
+#define AUDIO_IC_CODEC_CTRL3			(0x00F0)
+
+#define AUDIO_CTRL_IC_CODEC_TX_CTRL		(0x00F4)
+#define AUDIO_CTRL_IC_CODEC_RX_CTRL		(0x00F8)
+
+#define AUDIO_CTRL_IC_TXFIFO_OP			(0x00FC)
+#define AUDIO_CTRL_IC_TXFIFO_LEV_CHK		(0x0100)
+#define AUDIO_CTRL_IC_TXFIFO_STS		(0x0104)
+#define AUDIO_CTRL_IC_TXFIFO_INT		(0x0108)
+#define AUDIO_CTRL_IC_TXFIFO_INT_MSK		(0x010C)
+
+#define AUDIO_CTRL_IC_RXFIFO_OP			(0x0110)
+#define AUDIO_CTRL_IC_RXFIFO_LEV_CHK		(0x0114)
+#define AUDIO_CTRL_IC_RXFIFO_STS		(0x0118)
+#define AUDIO_CTRL_IC_RXFIFO_INT		(0x011C)
+#define AUDIO_CTRL_IC_RXFIFO_INT_MSK		(0x0120)
+
+#define I2S_MODE				(1<<0)
+#define AC97_TX_SLOT3_WIDTH_MASK		(3<<1)
+#define AC97_TX_SLOT4_WIDTH_MASK		(3<<3)
+#define AC97_TX_SLOT6_WIDTH_MASK		(3<<5)
+#define AC97_TX_SLOT7_WIDTH_MASK		(3<<7)
+#define AC97_TX_SLOT8_WIDTH_MASK		(3<<9)
+#define AC97_TX_SLOT9_WIDTH_MASK		(3<<11)
+#define AC97_FIFO_SYNC_MASK			(3<<13)
+#define AC97_FIFO_SYNC_ALL			(1<<13)
+
+#define SYNC_START				(1<<0)
+#define AC97_START				(1<<1)
+#define WARM_WAKEUP				(1<<2)
+
+#define AC97_CMD_TYPE_MASK			(1<<7)
+#define AC97_CMD_ADDR_MASK			(0x7F)
+#define AC97_CMD_TYPE_WRITE			(0<<7)
+#define AC97_CMD_TYPE_READ			(1<<7)
+
+#define CMD_ISSUE_BIT				(1<<0)
+#define	RD_CMD_FINISH_BIT			(1<<1)
+#define	CODEC_READY_BIT				(1<<2)
+
+#define	AC97_RDBACK_ADDR_BITS			(0x7F)
+#define	AC97_RDBACK_DATA_BITS			(0xFF<<16)
+
+#define AC97_TX_SLOT3_EN			(1<<0)
+#define AC97_TX_SLOT4_EN			(1<<1)
+#define AC97_TX_SLOT6_EN			(1<<2)
+#define AC97_TX_SLOT7_EN			(1<<3)
+#define AC97_TX_SLOT8_EN			(1<<4)
+#define AC97_TX_SLOT9_EN			(1<<5)
+
+#define AC97_RX_SLOT3_EN			(1<<0)
+#define AC97_RX_SLOT4_EN			(1<<1)
+#define AC97_RX_SLOT5_EN			(1<<2)
+#define AC97_RX_SLOT6_EN			(1<<3)
+#define AC97_RX_SLOT7_EN			(1<<4)
+#define AC97_RX_SLOT8_EN			(1<<5)
+#define AC97_RX_SLOT9_EN			(1<<6)
+#define AC97_RX_SLOT10_EN			(1<<7)
+#define AC97_RX_SLOT11_EN			(1<<8)
+#define AC97_RX_SLOT12_EN			(1<<9)
+
+#define AC97_AUX_SLOT3_EN			(1<<0)
+#define AC97_AUX_SLOT4_EN			(1<<1)
+#define AC97_AUX_SLOT5_EN			(1<<2)
+#define AC97_AUX_SLOT6_EN			(1<<3)
+#define AC97_AUX_SLOT7_EN			(1<<4)
+#define AC97_AUX_SLOT8_EN			(1<<5)
+#define AC97_AUX_SLOT9_EN			(1<<6)
+#define AC97_AUX_SLOT10_EN			(1<<7)
+#define AC97_AUX_SLOT11_EN			(1<<8)
+#define AC97_AUX_SLOT12_EN			(1<<9)
+
+#define I2S_LOOP_BACK				(1<<3)
+#define	I2S_MCLK_DIV_SHIFT			15
+#define I2S_MCLK_DIV_MASK			(0x1FF<<I2S_MCLK_DIV_SHIFT)
+#define I2S_BITCLK_DIV_SHIFT			24
+#define I2S_BITCLK_DIV_MASK			(0xFF<<I2S_BITCLK_DIV_SHIFT)
+
+#define I2S_MCLK_EN				(1<<2)
+#define I2S_REF_CLK_SEL_EXT			(1<<3)
+#define I2S_DOUT_OE				(1<<4)
+#define i2s_R2X_LP_TO_TX0			(1<<30)
+#define i2s_R2X_LP_TO_TX1			(2<<30)
+#define i2s_R2X_LP_TO_TX2			(3<<30)
+
+#define AUDIO_FIFO_START		(1 << 0)
+#define AUDIO_FIFO_RESET		(1 << 1)
+
+#define AUDIO_FIFO_FULL			(1 << 0)
+#define AUDIO_FIFO_EMPTY		(1 << 1)
+#define AUDIO_FIFO_OFLOW		(1 << 2)
+#define AUDIO_FIFO_UFLOW		(1 << 3)
+
+#define I2S_RX_ENABLE			(1 << 0)
+#define I2S_TX_ENABLE			(1 << 1)
+
+/* Codec I2S Control Register defines */
+#define I2S_SLAVE_MODE			(1 << 0)
+#define I2S_SIX_CHANNELS		(1 << 1)
+#define I2S_L_CHAN_LEN_MASK		(0x1f << 4)
+#define I2S_FRAME_LEN_MASK		(0x3f << 9)
+
+#define AC97_WRITE_FRAME_VALID    0X10
+#define AC97_WRITE_SLOT1_VALID    0X08
+#define AC97_WRITE_SLOT2_VALID    0X04
+#define AC97_WRITE_SLOT3_VALID    0X02
+#define AC97_WRITE_SLOT4_VALID    0X01
+
+#define IC_TX_ENABLE		(0x03)
+#define IC_RX_ENABLE		(0x03)
+
+#define MICBIASEN		(1 << 3)
+
+#define IC_RDACEN		(1 << 0)
+#define IC_LDACEN		(1 << 1)
+#define IC_HSREN		(1 << 2)
+#define IC_HSLEN		(1 << 3)
+#define IC_SPEN			(1 << 4)
+#define IC_CPEN			(1 << 5)
+
+#define IC_HPRSELR		(1 << 6)
+#define IC_HPLSELR		(1 << 7)
+#define IC_HPRSELL		(1 << 8)
+#define IC_HPLSELL		(1 << 9)
+#define IC_SPSELR		(1 << 10)
+#define IC_SPSELL		(1 << 11)
+
+#define IC_MONOR		(1 << 12)
+#define IC_MONOL		(1 << 13)
+
+#define IC_RXOSRSEL		(1 << 28)
+#define IC_CPFREQ		(1 << 29)
+#define IC_HSINVEN		(1 << 30)
+
+#define IC_MICINREN		(1 << 0)
+#define IC_MICINLEN		(1 << 1)
+#define IC_MICIN1SEL		(1 << 2)
+#define IC_MICIN2SEL		(1 << 3)
+#define IC_MICDIFSEL		(1 << 4)
+#define	IC_LINEIN1SEL		(1 << 5)
+#define	IC_LINEIN2SEL		(1 << 6)
+#define	IC_RADCEN		(1 << 7)
+#define	IC_LADCEN		(1 << 8)
+#define	IC_ALM			(1 << 9)
+
+#define IC_DIGMICEN             (1 << 22)
+#define IC_DIGMICFREQ           (1 << 23)
+#define IC_ADC14B_12            (1 << 24)
+#define IC_FIRDAC_HSL_EN        (1 << 25)
+#define IC_FIRDAC_HSR_EN        (1 << 26)
+#define IC_FIRDAC_LOUT_EN       (1 << 27)
+#define IC_POR                  (1 << 28)
+#define IC_CODEC_CLK_EN         (1 << 29)
+#define IC_HP_3DB_BOOST         (1 << 30)
+
+#define IC_ADC_LEFT_GAIN_SHIFT	16
+#define IC_ADC_RIGHT_GAIN_SHIFT 10
+#define IC_ADC_GAIN_MASK	0x3F
+#define IC_MIC_MAX_GAIN		0x39
+
+#define IC_RXPGAR_MASK		0x3F
+#define IC_RXPGAR_SHIFT		14
+#define IC_RXPGAL_MASK		0x3F
+#define IC_RXPGAL_SHIFT		21
+#define IC_RXPGAR		0x7B
+#define IC_RXPGAL		0x7B
+
+#define SIRF_I2S_EXT_CLK	0x0
+#define SIRF_I2S_PWM_CLK	0x1
+#endif /*__SIRF_INNER_AUDIO_CTRL_H*/
diff --git a/sound/soc/sirf/sirf-i2s.c b/sound/soc/sirf/sirf-i2s.c
new file mode 100644
index 0000000..ae4102f
--- /dev/null
+++ b/sound/soc/sirf/sirf-i2s.c
@@ -0,0 +1,464 @@
+/*
+ * SiRF I2S driver
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/pm_runtime.h>
+#include <linux/clk.h>
+#include <linux/reset.h>
+
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+#include <sound/dmaengine_pcm.h>
+
+#include "sirf-audio.h"
+
+struct sirf_i2s {
+	void __iomem		*base;
+	struct clk		*clk;
+	u32			i2s_ctrl;
+	u32			i2s_ctrl_tx_rx_en;
+	spinlock_t		lock;
+	struct platform_device	*sirf_pcm_pdev;
+};
+
+static struct snd_dmaengine_dai_dma_data dma_data[2];
+
+static int sirf_i2s_dai_probe(struct snd_soc_dai *dai)
+{
+	dai->playback_dma_data = &dma_data[0];
+	dai->capture_dma_data = &dma_data[1];
+	return 0;
+}
+
+static int sirf_i2s_startup(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	pm_runtime_get_sync(dai->dev);
+	return 0;
+}
+
+static void sirf_i2s_shutdown(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	pm_runtime_put(dai->dev);
+}
+
+static int sirf_i2s_trigger(struct snd_pcm_substream *substream,
+		int cmd, struct snd_soc_dai *dai)
+{
+	struct sirf_i2s *si2s = snd_soc_dai_get_drvdata(dai);
+	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		spin_lock(&si2s->lock);
+
+		if (playback) {
+			/* First start the FIFO, then enable the tx/rx */
+			writel(AUDIO_FIFO_RESET,
+				si2s->base + AUDIO_CTRL_EXT_TXFIFO1_OP);
+			writel(AUDIO_FIFO_START,
+				si2s->base + AUDIO_CTRL_EXT_TXFIFO1_OP);
+
+			writel(readl(si2s->base+AUDIO_CTRL_I2S_TX_RX_EN)
+				| I2S_TX_ENABLE | I2S_DOUT_OE,
+				si2s->base + AUDIO_CTRL_I2S_TX_RX_EN);
+
+		} else {
+			/* First start the FIFO, then enable the tx/rx */
+			writel(AUDIO_FIFO_RESET,
+				si2s->base + AUDIO_CTRL_RXFIFO_OP);
+			writel(AUDIO_FIFO_START,
+				si2s->base + AUDIO_CTRL_RXFIFO_OP);
+
+			writel(readl(si2s->base+AUDIO_CTRL_I2S_TX_RX_EN)
+				| I2S_RX_ENABLE,
+				si2s->base + AUDIO_CTRL_I2S_TX_RX_EN);
+		}
+
+		spin_unlock(&si2s->lock);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		spin_lock(&si2s->lock);
+
+		if (playback) {
+			writel(readl(si2s->base + AUDIO_CTRL_I2S_TX_RX_EN)
+				& ~(I2S_TX_ENABLE | I2S_MCLK_EN),
+				si2s->base + AUDIO_CTRL_I2S_TX_RX_EN);
+			/* First disable the tx/rx, then stop the FIFO */
+			writel(0, si2s->base + AUDIO_CTRL_EXT_TXFIFO1_OP);
+		} else {
+			writel(readl(si2s->base + AUDIO_CTRL_I2S_TX_RX_EN)
+				& ~(I2S_RX_ENABLE | I2S_MCLK_EN),
+				si2s->base+AUDIO_CTRL_I2S_TX_RX_EN);
+
+			/* First disable the tx/rx, then stop the FIFO */
+			writel(0, si2s->base + AUDIO_CTRL_RXFIFO_OP);
+		}
+
+		spin_unlock(&si2s->lock);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int sirf_i2s_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct sirf_i2s *si2s = snd_soc_dai_get_drvdata(dai);
+	u32 i2s_ctrl = readl(si2s->base + AUDIO_CTRL_I2S_CTRL);
+	u32 left_len, frame_len;
+	int channels = params_channels(params);
+
+	/*
+	 * SiRFSoC I2S controller only support 2 and 6 channells output.
+	 * I2S_SIX_CHANNELS bit clear: select 2 channels mode.
+	 * I2S_SIX_CHANNELS bit set: select 6 channels mode.
+	 */
+	switch (channels) {
+	case 2:
+		i2s_ctrl &= ~I2S_SIX_CHANNELS;
+		break;
+	case 6:
+		i2s_ctrl |= I2S_SIX_CHANNELS;
+		break;
+	default:
+		dev_err(dai->dev, "%d channels unsupported\n", channels);
+		return -EINVAL;
+	}
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		left_len = 8;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		left_len = 16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		left_len = 24;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		left_len = 32;
+		break;
+	default:
+		dev_err(dai->dev, "Format unsupported\n");
+		return -EINVAL;
+	}
+
+	frame_len = left_len * 2;
+	i2s_ctrl &= ~(I2S_L_CHAN_LEN_MASK | I2S_FRAME_LEN_MASK);
+	/* Fill the actual len - 1 */
+	i2s_ctrl |= ((frame_len - 1) << 9) | ((left_len - 1) << 4)
+		| (0 << 15) | (3 << 24);
+	writel(i2s_ctrl, si2s->base + AUDIO_CTRL_I2S_CTRL);
+	return 0;
+}
+
+static int sirf_i2s_set_dai_fmt(struct snd_soc_dai *dai,
+		unsigned int fmt)
+{
+	struct sirf_i2s *si2s = snd_soc_dai_get_drvdata(dai);
+	u32 i2s_ctrl, i2s_tx_rx_ctrl;
+
+	i2s_ctrl = readl(si2s->base + AUDIO_CTRL_I2S_CTRL);
+	i2s_tx_rx_ctrl = readl(si2s->base + AUDIO_CTRL_I2S_TX_RX_EN);
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		i2s_ctrl |= I2S_SLAVE_MODE;
+		i2s_tx_rx_ctrl &= ~I2S_MCLK_EN;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		i2s_ctrl &= ~I2S_SLAVE_MODE;
+		i2s_tx_rx_ctrl |= I2S_MCLK_EN;
+		break;
+	default:
+		return -EINVAL;
+	}
+	writel(i2s_ctrl, si2s->base + AUDIO_CTRL_I2S_CTRL);
+	writel(i2s_tx_rx_ctrl, si2s->base + AUDIO_CTRL_I2S_TX_RX_EN);
+
+	/* interface format */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		writel(readl(si2s->base + AUDIO_CTRL_MODE_SEL)
+			| I2S_MODE,
+			si2s->base + AUDIO_CTRL_MODE_SEL);
+		break;
+	default:
+		dev_err(dai->dev, "Only I2S format supported\n");
+		return -EINVAL;
+	}
+
+	/* clock inversion */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	default:
+		dev_err(dai->dev, " Only normal bit clock, normal frame clock supported\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int sirf_i2s_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
+{
+	struct sirf_i2s *si2s = snd_soc_dai_get_drvdata(dai);
+	u32 val;
+	u32 bclk_div_coefficient;
+
+	if (div < 2 || div % 2) {
+		dev_err(dai->dev, "BITCLK divider must greater than 1,"
+			"And must is a multiple of 2\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Calculate the divider coefficient of I2S reference
+	 * clock frequency divider.
+	 */
+	bclk_div_coefficient = div / 2 - 1;
+
+	if (bclk_div_coefficient >= (1 << 9)) {
+		dev_err(dai->dev, "The BITCLK divider(%d) must less than "
+			"%d.\n", div, (1 << 9) * 2);
+		return -EINVAL;
+	}
+
+	val = readl(si2s->base + AUDIO_CTRL_I2S_TX_RX_EN);
+	switch (div_id) {
+	case SIRF_I2S_EXT_CLK:
+		val |= I2S_REF_CLK_SEL_EXT;
+		break;
+	case SIRF_I2S_PWM_CLK:
+		val &= ~I2S_REF_CLK_SEL_EXT;
+		break;
+	default:
+		return -EINVAL;
+	}
+	writel(val, si2s->base + AUDIO_CTRL_I2S_TX_RX_EN);
+
+	val = readl(si2s->base + AUDIO_CTRL_I2S_CTRL);
+	val |= (bclk_div_coefficient << 24);
+	/*
+	 * MCLK coefficient must set to 0, means
+	 * divide-by-two from reference clock.
+	 */
+	val &= ~(((1 << 10) - 1) << 15);
+	writel(val, si2s->base + AUDIO_CTRL_I2S_CTRL);
+
+	return 0;
+}
+
+struct snd_soc_dai_ops sirfsoc_i2s_dai_ops = {
+	.startup	= sirf_i2s_startup,
+	.shutdown	= sirf_i2s_shutdown,
+	.trigger	= sirf_i2s_trigger,
+	.hw_params	= sirf_i2s_hw_params,
+	.set_fmt	= sirf_i2s_set_dai_fmt,
+	.set_clkdiv	= sirf_i2s_set_clkdiv,
+};
+
+static struct snd_soc_dai_driver sirf_i2s_dai = {
+	.probe = sirf_i2s_dai_probe,
+	.name		= "sirf-i2s",
+	.id			= 0,
+	.playback = {
+		.stream_name = "SiRF I2S Playback",
+		.channels_min = 2,
+		.channels_max = 6,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = SNDRV_PCM_FMTBIT_S8 |
+			SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S24_LE |
+			SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.capture = {
+		.stream_name = "SiRF I2S Capture",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = SNDRV_PCM_FMTBIT_S8 |
+			SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S24_LE |
+			SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.ops = &sirfsoc_i2s_dai_ops,
+};
+#ifdef CONFIG_PM_RUNTIME
+static int sirf_i2s_runtime_suspend(struct device *dev)
+{
+	struct sirf_i2s *si2s = dev_get_drvdata(dev);
+	clk_disable_unprepare(si2s->clk);
+
+	return 0;
+}
+
+static int sirf_i2s_runtime_resume(struct device *dev)
+{
+	struct sirf_i2s *si2s = dev_get_drvdata(dev);
+	clk_prepare_enable(si2s->clk);
+	device_reset(dev);
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+static int sirf_i2s_suspend(struct device *dev)
+{
+	struct sirf_i2s *si2s = dev_get_drvdata(dev);
+
+	if (!pm_runtime_status_suspended(dev)) {
+		si2s->i2s_ctrl = readl(si2s->base + AUDIO_CTRL_I2S_CTRL);
+		si2s->i2s_ctrl_tx_rx_en =
+			readl(si2s->base + AUDIO_CTRL_I2S_TX_RX_EN);
+		sirf_i2s_runtime_suspend(dev);
+	}
+	return 0;
+}
+
+static int sirf_i2s_resume(struct device *dev)
+{
+	struct sirf_i2s *si2s = dev_get_drvdata(dev);
+	if (!pm_runtime_status_suspended(dev)) {
+		sirf_i2s_runtime_resume(dev);
+		writel(readl(si2s->base + AUDIO_CTRL_MODE_SEL)
+				| I2S_MODE,
+				si2s->base + AUDIO_CTRL_MODE_SEL);
+		writel(si2s->i2s_ctrl, si2s->base + AUDIO_CTRL_I2S_CTRL);
+		/*Restore MCLK enable and reference clock select bits.*/
+		writel(si2s->i2s_ctrl_tx_rx_en &
+			(I2S_MCLK_EN | I2S_REF_CLK_SEL_EXT),
+			si2s->base + AUDIO_CTRL_I2S_TX_RX_EN);
+
+		writel(0, si2s->base + AUDIO_CTRL_EXT_TXFIFO1_INT_MSK);
+		writel(0, si2s->base + AUDIO_CTRL_RXFIFO_INT_MSK);
+	}
+
+	return 0;
+}
+#endif
+
+static const struct snd_soc_component_driver sirf_i2s_component = {
+	.name       = "sirf-i2s",
+};
+
+static int sirf_i2s_probe(struct platform_device *pdev)
+{
+	struct sirf_i2s *si2s;
+	u32 rx_dma_ch, tx_dma_ch;
+	int ret;
+	struct resource mem_res;
+
+	si2s = devm_kzalloc(&pdev->dev, sizeof(struct sirf_i2s),
+			GFP_KERNEL);
+	if (!si2s)
+		return -ENOMEM;
+
+	si2s->sirf_pcm_pdev = platform_device_register_simple("sirf-pcm-audio",
+			0, NULL, 0);
+	if (IS_ERR(si2s->sirf_pcm_pdev))
+		return PTR_ERR(si2s->sirf_pcm_pdev);
+
+	platform_set_drvdata(pdev, si2s);
+
+	spin_lock_init(&si2s->lock);
+
+	ret = of_property_read_u32(pdev->dev.of_node,
+			"sirf,i2s-dma-rx-channel", &rx_dma_ch);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Unable to USP0 rx dma channel\n");
+		return ret;
+	}
+	ret = of_property_read_u32(pdev->dev.of_node,
+			"sirf,i2s-dma-tx-channel", &tx_dma_ch);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Unable to USP0 tx dma channel\n");
+		return ret;
+	}
+
+	dma_data[0].filter_data = (void *)tx_dma_ch;
+	dma_data[1].filter_data = (void *)rx_dma_ch;
+
+	ret = of_address_to_resource(pdev->dev.of_node, 0, &mem_res);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Unable to get i2s memory resource.\n");
+		return ret;
+	}
+	si2s->base = devm_ioremap(&pdev->dev, mem_res.start,
+		resource_size(&mem_res));
+	if (!si2s->base)
+		return -ENOMEM;
+
+	si2s->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(si2s->clk)) {
+		dev_err(&pdev->dev, "Get clock failed.\n");
+		ret = PTR_ERR(si2s->clk);
+		goto err;
+	}
+
+	ret = snd_soc_register_component(&pdev->dev, &sirf_i2s_component,
+			&sirf_i2s_dai, 1);
+	if (ret) {
+		dev_err(&pdev->dev, "Register Audio SoC dai failed.\n");
+		goto err;
+	}
+
+	pm_runtime_enable(&pdev->dev);
+	return 0;
+
+err:
+	return ret;
+}
+
+static int sirf_i2s_remove(struct platform_device *pdev)
+{
+	struct sirf_i2s *si2s = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_component(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	platform_device_unregister(si2s->sirf_pcm_pdev);
+	return 0;
+}
+
+static const struct of_device_id sirf_i2s_of_match[] = {
+	{ .compatible = "sirf,prima2-i2s", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sirf_i2s_of_match);
+
+static const struct dev_pm_ops sirf_i2s_pm_ops = {
+	SET_RUNTIME_PM_OPS(sirf_i2s_runtime_suspend, sirf_i2s_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(sirf_i2s_suspend, sirf_i2s_resume)
+};
+
+static struct platform_driver sirf_i2s_driver = {
+	.driver = {
+		.name = "sirf-i2s",
+		.owner = THIS_MODULE,
+		.of_match_table = sirf_i2s_of_match,
+		.pm = &sirf_i2s_pm_ops,
+	},
+	.probe = sirf_i2s_probe,
+	.remove = sirf_i2s_remove,
+};
+
+module_platform_driver(sirf_i2s_driver);
+
+MODULE_DESCRIPTION("SiRF SoC I2S driver");
+MODULE_AUTHOR("RongJun Ying <Rongjun.Ying@csr.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.8.2.3
