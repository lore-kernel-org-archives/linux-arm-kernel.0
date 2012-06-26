From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Tue, 26 Jun 2012 19:25:11 +0530
Subject: [PATCH V3 1/1] ASoC: tlv320aic3x: Fix codec pll configure bug
Message-ID: <1340718911-9325-1-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In sound/soc/codecs/tlv320aic3x.c

        data = snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
        snd_soc_write(codec, AIC3X_PLL_PROGA_REG,
                      data | (pll_p << PLLP_SHIFT));

In the above code, pll-p value is OR'ed with previous value without
clearing it. Bug is not seen if pll-p value doesn't change across
Sampling frequency.

However on some platforms (like AM335x EVM-SK), pll-p may have different
values across different sampling frequencies. In such case, above code
configures the pll with a wrong value.
Because of this bug, when a audio stream is played with pll value
different from previous stream, audio is heard as differently(like its
stretched).

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
---
chnages in V2:
	modify subject to indicate ASOC and codec as tlv320aic3x

changes in V3:
	use snd_soc_update_bits() instead of read-mask-write

 sound/soc/codecs/tlv320aic3x.c |    4 +---
 sound/soc/codecs/tlv320aic3x.h |    1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 64d2a4f..e9b62b5 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -935,9 +935,7 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 	}
 
 found:
-	data = snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
-	snd_soc_write(codec, AIC3X_PLL_PROGA_REG,
-		      data | (pll_p << PLLP_SHIFT));
+	snd_soc_update_bits(codec, AIC3X_PLL_PROGA_REG, PLLP_MASK, pll_p);
 	snd_soc_write(codec, AIC3X_OVRF_STATUS_AND_PLLR_REG,
 		      pll_r << PLLR_SHIFT);
 	snd_soc_write(codec, AIC3X_PLL_PROGB_REG, pll_j << PLLJ_SHIFT);
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index 6f097fb..08c7f66 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -166,6 +166,7 @@
 
 /* PLL registers bitfields */
 #define PLLP_SHIFT		0
+#define PLLP_MASK		7
 #define PLLQ_SHIFT		3
 #define PLLR_SHIFT		0
 #define PLLJ_SHIFT		2
-- 
1.7.1
