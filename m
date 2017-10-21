From: broonie@kernel.org (Mark Brown)
Date: Sat, 21 Oct 2017 11:31:45 +0100 (BST)
Subject: Applied "ASoC: stm32: sai: Remove spurious IRQs on stop" to the asoc
 tree
In-Reply-To: <1508418203-16840-6-git-send-email-olivier.moysan@st.com>
Message-ID: <20171021103145.807AF440057@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: stm32: sai: Remove spurious IRQs on stop

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

>From 47a8907d7c73fad81030655f09832fbb4446a2f5 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Thu, 19 Oct 2017 15:03:21 +0200
Subject: [PATCH] ASoC: stm32: sai: Remove spurious IRQs on stop

Clear IRQ mask on stream stop to avoid spurious IRQs.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 815ef1036199..fd7dc7760f58 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -419,8 +419,6 @@ static int stm32_sai_startup(struct snd_pcm_substream *substream,
 	}
 
 	/* Enable ITs */
-	regmap_update_bits(sai->regmap, STM_SAI_SR_REGX,
-			   SAI_XSR_MASK, (unsigned int)~SAI_XSR_MASK);
 
 	regmap_update_bits(sai->regmap, STM_SAI_CLRFR_REGX,
 			   SAI_XCLRFR_MASK, SAI_XCLRFR_MASK);
@@ -693,6 +691,9 @@ static int stm32_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_STOP:
 		dev_dbg(cpu_dai->dev, "Disable DMA and SAI\n");
 
+		regmap_update_bits(sai->regmap, STM_SAI_IMR_REGX,
+				   SAI_XIMR_MASK, 0);
+
 		regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX,
 				   SAI_XCR1_SAIEN,
 				   (unsigned int)~SAI_XCR1_SAIEN);
-- 
2.14.1
