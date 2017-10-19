From: olivier.moysan@st.com (Olivier Moysan)
Date: Thu, 19 Oct 2017 15:03:21 +0200
Subject: [INTERNAL][PATCH 5/7] ASoC: stm32: sai: Remove spurious IRQs on stop
In-Reply-To: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
References: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1508418203-16840-6-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clear IRQ mask on stream stop to avoid spurious IRQs.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai_sub.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 815ef10..fd7dc77 100644
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
1.9.1
