From: broonie@kernel.org (Mark Brown)
Date: Fri, 19 May 2017 18:37:17 +0100
Subject: Applied "ASoC: stm32: Add full duplex support to i2s" to the asoc tree
In-Reply-To: <1494495904-18898-4-git-send-email-olivier.moysan@st.com>
Message-ID: <E1dBlq1-00054J-37@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: stm32: Add full duplex support to i2s

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e7cc49b8adf25e7bae6acaeb37036ef8726b902c Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan@st.com>
Date: Thu, 18 May 2017 17:19:53 +0200
Subject: [PATCH] ASoC: stm32: Add full duplex support to i2s

This patch allows to use i2s interface either as single
audio path (rx or tx), or bidirectional audio path.
This patch is added separately, as the driver does not
follow recommended use of the interface, to support this
configuration.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 87 +++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 41 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 22152a1ca733..8052629a89df 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -489,7 +489,6 @@ static int stm32_i2s_configure(struct snd_soc_dai *cpu_dai,
 	struct stm32_i2s_data *i2s = snd_soc_dai_get_drvdata(cpu_dai);
 	int format = params_width(params);
 	u32 cfgr, cfgr_mask, cfg1, cfg1_mask;
-	bool playback_flg = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 	unsigned int fthlv;
 	int ret;
 
@@ -515,19 +514,13 @@ static int stm32_i2s_configure(struct snd_soc_dai *cpu_dai,
 	}
 
 	if (STM32_I2S_IS_SLAVE(i2s)) {
-		if (playback_flg)
-			cfgr |= I2S_CGFR_I2SCFG_SET(I2S_I2SMOD_TX_SLAVE);
-		else
-			cfgr |= I2S_CGFR_I2SCFG_SET(I2S_I2SMOD_RX_SLAVE);
+		cfgr |= I2S_CGFR_I2SCFG_SET(I2S_I2SMOD_FD_SLAVE);
 
 		/* As data length is either 16 or 32 bits, fixch always set */
 		cfgr |= I2S_CGFR_FIXCH;
 		cfgr_mask |= I2S_CGFR_FIXCH;
 	} else {
-		if (playback_flg)
-			cfgr |= I2S_CGFR_I2SCFG_SET(I2S_I2SMOD_TX_MASTER);
-		else
-			cfgr |= I2S_CGFR_I2SCFG_SET(I2S_I2SMOD_RX_MASTER);
+		cfgr |= I2S_CGFR_I2SCFG_SET(I2S_I2SMOD_FD_MASTER);
 	}
 	cfgr_mask |= I2S_CGFR_I2SCFG_MASK;
 
@@ -536,9 +529,7 @@ static int stm32_i2s_configure(struct snd_soc_dai *cpu_dai,
 	if (ret < 0)
 		return ret;
 
-	cfg1 = I2S_CFG1_RXDMAEN;
-	if (playback_flg)
-		cfg1 = I2S_CFG1_TXDMAEN;
+	cfg1 = I2S_CFG1_RXDMAEN | I2S_CFG1_TXDMAEN;
 	cfg1_mask = cfg1;
 
 	fthlv = STM32_I2S_FIFO_SIZE * I2S_FIFO_TH_ONE_QUARTER / 4;
@@ -553,32 +544,15 @@ static int stm32_i2s_startup(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_i2s_data *i2s = snd_soc_dai_get_drvdata(cpu_dai);
-	int ret, ier;
 
 	i2s->substream = substream;
 
 	spin_lock(&i2s->lock_fd);
-	if (i2s->refcount) {
-		dev_err(cpu_dai->dev, "%s stream already started\n",
-			(substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
-			"Capture" : "Playback"));
-		spin_unlock(&i2s->lock_fd);
-		return -EBUSY;
-	}
-	i2s->refcount = 1;
+	i2s->refcount++;
 	spin_unlock(&i2s->lock_fd);
 
-	ret = regmap_update_bits(i2s->regmap, STM32_I2S_IFCR_REG,
-				 I2S_IFCR_MASK, I2S_IFCR_MASK);
-	if (ret < 0)
-		return ret;
-
-	/* Enable ITs */
-	ier = I2S_IER_OVRIE | I2S_IER_UDRIE;
-	if (STM32_I2S_IS_SLAVE(i2s))
-		ier |= I2S_IER_TIFREIE;
-
-	return regmap_update_bits(i2s->regmap, STM32_I2S_IER_REG, ier, ier);
+	return regmap_update_bits(i2s->regmap, STM32_I2S_IFCR_REG,
+				  I2S_IFCR_MASK, I2S_IFCR_MASK);
 }
 
 static int stm32_i2s_hw_params(struct snd_pcm_substream *substream,
@@ -605,7 +579,7 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct stm32_i2s_data *i2s = snd_soc_dai_get_drvdata(cpu_dai);
 	bool playback_flg = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
-	u32 cfg1_mask;
+	u32 cfg1_mask, ier;
 	int ret;
 
 	switch (cmd) {
@@ -628,10 +602,48 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			dev_err(cpu_dai->dev, "Error %d starting I2S\n", ret);
 			return ret;
 		}
+
+		regmap_update_bits(i2s->regmap, STM32_I2S_IFCR_REG,
+				   I2S_IFCR_MASK, I2S_IFCR_MASK);
+
+		if (playback_flg) {
+			ier = I2S_IER_UDRIE;
+		} else {
+			ier = I2S_IER_OVRIE;
+
+			spin_lock(&i2s->lock_fd);
+			if (i2s->refcount == 1)
+				/* dummy write to trigger capture */
+				regmap_write(i2s->regmap,
+					     STM32_I2S_TXDR_REG, 0);
+			spin_unlock(&i2s->lock_fd);
+		}
+
+		if (STM32_I2S_IS_SLAVE(i2s))
+			ier |= I2S_IER_TIFREIE;
+
+		regmap_update_bits(i2s->regmap, STM32_I2S_IER_REG, ier, ier);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (playback_flg)
+			regmap_update_bits(i2s->regmap, STM32_I2S_IER_REG,
+					   I2S_IER_UDRIE,
+					   (unsigned int)~I2S_IER_UDRIE);
+		else
+			regmap_update_bits(i2s->regmap, STM32_I2S_IER_REG,
+					   I2S_IER_OVRIE,
+					   (unsigned int)~I2S_IER_OVRIE);
+
+		spin_lock(&i2s->lock_fd);
+		i2s->refcount--;
+		if (i2s->refcount) {
+			spin_unlock(&i2s->lock_fd);
+			break;
+		}
+		spin_unlock(&i2s->lock_fd);
+
 		dev_dbg(cpu_dai->dev, "stop I2S\n");
 
 		ret = regmap_update_bits(i2s->regmap, STM32_I2S_CR1_REG,
@@ -641,10 +653,7 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 			return ret;
 		}
 
-		cfg1_mask = I2S_CFG1_RXDMAEN;
-		if (playback_flg)
-			cfg1_mask = I2S_CFG1_TXDMAEN;
-
+		cfg1_mask = I2S_CFG1_RXDMAEN | I2S_CFG1_TXDMAEN;
 		regmap_update_bits(i2s->regmap, STM32_I2S_CFG1_REG,
 				   cfg1_mask, 0);
 		break;
@@ -662,10 +671,6 @@ static void stm32_i2s_shutdown(struct snd_pcm_substream *substream,
 
 	i2s->substream = NULL;
 
-	spin_lock(&i2s->lock_fd);
-	i2s->refcount = 0;
-	spin_unlock(&i2s->lock_fd);
-
 	regmap_update_bits(i2s->regmap, STM32_I2S_CGFR_REG,
 			   I2S_CGFR_MCKOE, (unsigned int)~I2S_CGFR_MCKOE);
 }
-- 
2.11.0
