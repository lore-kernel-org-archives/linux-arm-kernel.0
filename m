From: olivier.moysan@st.com (olivier moysan)
Date: Fri, 16 Jun 2017 14:15:32 +0200
Subject: [PATCH 5/7] ASoC: stm32: sai: change stop sequence
In-Reply-To: <1497615334-7156-1-git-send-email-olivier.moysan@st.com>
References: <1497615334-7156-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1497615334-7156-6-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable SAI before stopping DMA data transfers.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai_sub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 24b8874..97b69a3 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -629,12 +629,12 @@ static int stm32_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 		dev_dbg(cpu_dai->dev, "Disable DMA and SAI\n");
 
 		regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX,
-				   SAI_XCR1_DMAEN,
-				   (unsigned int)~SAI_XCR1_DMAEN);
+				   SAI_XCR1_SAIEN,
+				   (unsigned int)~SAI_XCR1_SAIEN);
 
 		ret = regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX,
-					 SAI_XCR1_SAIEN,
-					 (unsigned int)~SAI_XCR1_SAIEN);
+					 SAI_XCR1_DMAEN,
+					 (unsigned int)~SAI_XCR1_DMAEN);
 		if (ret < 0)
 			dev_err(cpu_dai->dev, "Failed to update CR1 register\n");
 		break;
-- 
1.9.1
