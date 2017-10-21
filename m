From: broonie@kernel.org (Mark Brown)
Date: Sat, 21 Oct 2017 11:32:16 +0100 (BST)
Subject: Applied "ASoC: stm32: sai: fix stop management in isr" to the asoc
 tree
In-Reply-To: <1508418203-16840-5-git-send-email-olivier.moysan@st.com>
Message-ID: <20171021103216.CAC29440057@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: stm32: sai: fix stop management in isr

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

>From d807cdfb48c4d925b269f5b0f818864766e17389 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Thu, 19 Oct 2017 15:03:20 +0200
Subject: [PATCH] ASoC: stm32: sai: fix stop management in isr

Add check on substream validity.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 90d439613899..5e66bf310351 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -184,7 +184,6 @@ static const struct regmap_config stm32_sai_sub_regmap_config_h7 = {
 static irqreturn_t stm32_sai_isr(int irq, void *devid)
 {
 	struct stm32_sai_sub_data *sai = (struct stm32_sai_sub_data *)devid;
-	struct snd_pcm_substream *substream = sai->substream;
 	struct platform_device *pdev = sai->pdev;
 	unsigned int sr, imr, flags;
 	snd_pcm_state_t status = SNDRV_PCM_STATE_RUNNING;
@@ -199,6 +198,11 @@ static irqreturn_t stm32_sai_isr(int irq, void *devid)
 	regmap_update_bits(sai->regmap, STM_SAI_CLRFR_REGX, SAI_XCLRFR_MASK,
 			   SAI_XCLRFR_MASK);
 
+	if (!sai->substream) {
+		dev_err(&pdev->dev, "Device stopped. Spurious IRQ 0x%x\n", sr);
+		return IRQ_NONE;
+	}
+
 	if (flags & SAI_XIMR_OVRUDRIE) {
 		dev_err(&pdev->dev, "IRQ %s\n",
 			STM_SAI_IS_PLAYBACK(sai) ? "underrun" : "overrun");
@@ -227,9 +231,9 @@ static irqreturn_t stm32_sai_isr(int irq, void *devid)
 	}
 
 	if (status != SNDRV_PCM_STATE_RUNNING) {
-		snd_pcm_stream_lock(substream);
-		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
-		snd_pcm_stream_unlock(substream);
+		snd_pcm_stream_lock(sai->substream);
+		snd_pcm_stop(sai->substream, SNDRV_PCM_STATE_XRUN);
+		snd_pcm_stream_unlock(sai->substream);
 	}
 
 	return IRQ_HANDLED;
-- 
2.14.1
