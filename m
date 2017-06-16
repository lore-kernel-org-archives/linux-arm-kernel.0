From: broonie@kernel.org (Mark Brown)
Date: Fri, 16 Jun 2017 18:49:58 +0100
Subject: Applied "ASoC: stm32: sai: change stop sequence" to the asoc tree
In-Reply-To: <1497615334-7156-6-git-send-email-olivier.moysan@st.com>
Message-ID: <E1dLvNe-0005e2-LO@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: stm32: sai: change stop sequence

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

>From 1d3d9735cf08c5aa06c142222a05e9c7e473cc5d Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan@st.com>
Date: Fri, 16 Jun 2017 14:15:32 +0200
Subject: [PATCH] ASoC: stm32: sai: change stop sequence

Disable SAI before stopping DMA data transfers.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 24b8874cfe5f..97b69a3ab46e 100644
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
2.11.0
