From: flatmax@flatmax.org (Matt Flax)
Date: Wed,  8 Mar 2017 21:58:54 +1100
Subject: [PATCH] ASoC: bcm_2835: Simplify mono guard by returning error on mono
Message-ID: <1488970734-6596-1-git-send-email-flatmax@flatmax.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch simplifies the bcm2835_i2s.c code when the driver returns
error on mono channel requests. It does this by testing for mono
instead of using a switch statement to test for stereo.

The bcm2835_i2s driver can only work in stereo mode. Whilst leaving
the driver entirel compliant with the I2S protocol, it simplifies the
code by removing a few redundant lines of code.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
---
 sound/soc/bcm/bcm2835-i2s.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index 6ba2049..1e6a1da 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -310,15 +310,16 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 	ch1pos = data_delay;
 	ch2pos = bclk_ratio / 2 + data_delay;
 
-	switch (params_channels(params)) {
-	case 2:
-		format = BCM2835_I2S_CH1(format) | BCM2835_I2S_CH2(format);
-		format |= BCM2835_I2S_CH1(BCM2835_I2S_CHPOS(ch1pos));
-		format |= BCM2835_I2S_CH2(BCM2835_I2S_CHPOS(ch2pos));
-		break;
-	default:
+	/* C
+	 * Check we aren't setting channel 2 on a mono stream.
+	 * We currently only support stereo
+	 */
+	if (params_channels(params) == 1)
 		return -EINVAL;
-	}
+
+	format = BCM2835_I2S_CH1(format) | BCM2835_I2S_CH2(format);
+	format |= BCM2835_I2S_CH1(BCM2835_I2S_CHPOS(ch1pos));
+	format |= BCM2835_I2S_CH2(BCM2835_I2S_CHPOS(ch2pos));
 
 	/*
 	 * Set format for both streams.
-- 
2.7.4
