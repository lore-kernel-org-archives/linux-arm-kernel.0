From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Sat, 28 Apr 2018 22:51:42 +0200
Subject: [PATCH 5/5] ASoC: cirrus: i2s: IRQ-based stream watchdog
In-Reply-To: <20180428205142.31921-1-alexander.sverdlin@gmail.com>
References: <20180428205142.31921-1-alexander.sverdlin@gmail.com>
Message-ID: <20180428205142.31921-6-alexander.sverdlin@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I2S controller on EP93xx seems to have undocumented HW issue. According to
"EP93xx User?s Guide", controller can handle underflow and either transmit
last sample or zeroes in such case until FIFO is filled again. In reality
undeflow conditions seem to confuse internal state machine from time to
time and the whole stream gets shifted by one byte (as captured by logic
analyser on the I2S outputs). One could only hear noise instead of original
stream and this continues until the FIFO is disabled and enabled again.

Work this around by watching underflow interrupt and resetting I2S TX
channel + fill FIFO with zero samples until DMA catches up again. This is
a nasty workaround, but it works. Hence, Kconfig option to disable it in
case of problems.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 sound/soc/cirrus/Kconfig      | 17 +++++++++++
 sound/soc/cirrus/ep93xx-i2s.c | 68 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/sound/soc/cirrus/Kconfig b/sound/soc/cirrus/Kconfig
index c7cd60f009e9..e09199124c36 100644
--- a/sound/soc/cirrus/Kconfig
+++ b/sound/soc/cirrus/Kconfig
@@ -9,6 +9,23 @@ config SND_EP93XX_SOC
 config SND_EP93XX_SOC_I2S
 	tristate
 
+if SND_EP93XX_SOC_I2S
+
+config SND_EP93XX_SOC_I2S_WATCHDOG
+	bool "IRQ based underflow watchdog workaround"
+	default y
+	help
+	  I2S controller on EP93xx seems to have undocumented HW issue.
+	  Underflow of internal I2S controller FIFO could confuse the
+	  state machine and the whole stream can be shifted by one byte
+	  until I2S is disabled. This option enables IRQ based watchdog
+	  which disables and re-enables I2S in case of underflow and
+	  fills FIFO with zeroes.
+
+	  If you are unsure how to answer this question, answer Y.
+
+endif # if SND_EP93XX_SOC_I2S
+
 config SND_EP93XX_SOC_AC97
 	tristate
 	select AC97_BUS
diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 42cc6d22baac..0918c5da575a 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -35,8 +35,12 @@
 
 #define EP93XX_I2S_TXCLKCFG		0x00
 #define EP93XX_I2S_RXCLKCFG		0x04
+#define EP93XX_I2S_GLSTS		0x08
 #define EP93XX_I2S_GLCTRL		0x0C
 
+#define EP93XX_I2S_I2STX0LFT		0x10
+#define EP93XX_I2S_I2STX0RT		0x14
+
 #define EP93XX_I2S_TXLINCTRLDATA	0x28
 #define EP93XX_I2S_TXCTRL		0x2C
 #define EP93XX_I2S_TXWRDLEN		0x30
@@ -55,12 +59,22 @@
 
 #define EP93XX_I2S_TXLINCTRLDATA_R_JUST	BIT(2) /* Right justify */
 
+/*
+ * Transmit empty interrupt level select:
+ * 0 - Generate interrupt when FIFO is half empty
+ * 1 - Generate interrupt when FIFO is empty
+ */
+#define EP93XX_I2S_TXCTRL_TXEMPTY_LVL	BIT(0)
+#define EP93XX_I2S_TXCTRL_TXUFIE	BIT(1) /* Transmit interrupt enable */
+
 #define EP93XX_I2S_CLKCFG_LRS		(1 << 0) /* lrclk polarity */
 #define EP93XX_I2S_CLKCFG_CKP		(1 << 1) /* Bit clock polarity */
 #define EP93XX_I2S_CLKCFG_REL		(1 << 2) /* First bit transition */
 #define EP93XX_I2S_CLKCFG_MASTER	(1 << 3) /* Master mode */
 #define EP93XX_I2S_CLKCFG_NBCG		(1 << 4) /* Not bit clock gating */
 
+#define EP93XX_I2S_GLSTS_TX0_FIFO_FULL	BIT(12)
+
 struct ep93xx_i2s_info {
 	struct clk			*mclk;
 	struct clk			*sclk;
@@ -116,12 +130,24 @@ static void ep93xx_i2s_enable(struct ep93xx_i2s_info *info, int stream)
 	else
 		base_reg = EP93XX_I2S_RX0EN;
 	ep93xx_i2s_write_reg(info, base_reg, 1);
+
+	/* Enable TX IRQs (FIFO empty or underflow) */
+	if (IS_ENABLED(CONFIG_SND_EP93XX_SOC_I2S_WATCHDOG) &&
+	    stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ep93xx_i2s_write_reg(info, EP93XX_I2S_TXCTRL,
+				     EP93XX_I2S_TXCTRL_TXEMPTY_LVL |
+				     EP93XX_I2S_TXCTRL_TXUFIE);
 }
 
 static void ep93xx_i2s_disable(struct ep93xx_i2s_info *info, int stream)
 {
 	unsigned base_reg;
 
+	/* Disable IRQs */
+	if (IS_ENABLED(CONFIG_SND_EP93XX_SOC_I2S_WATCHDOG) &&
+	    stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ep93xx_i2s_write_reg(info, EP93XX_I2S_TXCTRL, 0);
+
 	/* Disable fifo */
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 		base_reg = EP93XX_I2S_TX0EN;
@@ -141,6 +167,37 @@ static void ep93xx_i2s_disable(struct ep93xx_i2s_info *info, int stream)
 	}
 }
 
+/*
+ * According to documentation I2S controller can handle underflow conditions
+ * just fine, but in reality the state machine is sometimes confused so that
+ * the whole stream is shifted by one byte. The watchdog below disables the TX
+ * FIFO, fills the buffer with zeroes and re-enables the FIFO. State machine
+ * is being reset and by filling the buffer we get some time before next
+ * underflow happens.
+ */
+static irqreturn_t ep93xx_i2s_interrupt(int irq, void *dev_id)
+{
+	struct ep93xx_i2s_info *info = dev_id;
+
+	/* Disable FIFO */
+	ep93xx_i2s_write_reg(info, EP93XX_I2S_TX0EN, 0);
+	/*
+	 * Fill TX FIFO with zeroes, this way we can defer next IRQs as much as
+	 * possible and get more time for DMA to catch up. Actually there are
+	 * only 8 samples in this FIFO, so even on 8kHz maximum deferral here is
+	 * 1ms.
+	 */
+	while (!(ep93xx_i2s_read_reg(info, EP93XX_I2S_GLSTS) &
+		 EP93XX_I2S_GLSTS_TX0_FIFO_FULL)) {
+		ep93xx_i2s_write_reg(info, EP93XX_I2S_I2STX0LFT, 0);
+		ep93xx_i2s_write_reg(info, EP93XX_I2S_I2STX0RT, 0);
+	}
+	/* Re-enable FIFO */
+	ep93xx_i2s_write_reg(info, EP93XX_I2S_TX0EN, 1);
+
+	return IRQ_HANDLED;
+}
+
 static int ep93xx_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
@@ -390,6 +447,17 @@ static int ep93xx_i2s_probe(struct platform_device *pdev)
 	if (IS_ERR(info->regs))
 		return PTR_ERR(info->regs);
 
+	if (IS_ENABLED(CONFIG_SND_EP93XX_SOC_I2S_WATCHDOG)) {
+		int irq = platform_get_irq(pdev, 0);
+		if (irq <= 0)
+			return irq < 0 ? irq : -ENODEV;
+
+		err = devm_request_irq(&pdev->dev, irq, ep93xx_i2s_interrupt, 0,
+				       pdev->name, info);
+		if (err)
+			return err;
+	}
+
 	info->mclk = clk_get(&pdev->dev, "mclk");
 	if (IS_ERR(info->mclk)) {
 		err = PTR_ERR(info->mclk);
-- 
2.16.2
