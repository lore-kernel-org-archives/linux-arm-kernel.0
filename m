From: jbe@pengutronix.de (Juergen Borleis)
Date: Fri,  3 Jul 2015 12:39:36 +0200
Subject: [PATCH] ASoC: fsl-ssi: Fix bitclock calculation for master mode
Message-ID: <1435919976-1667-1-git-send-email-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the datasheet 'pm', 'psr' and 'div2' should never be all 0.
Since commit 541b03ad6cfe ("ASoC: fsl_ssi: Fix the incorrect limitation of
the bit clock rate") this can happen, because for some bitclock rates
'pm' = 0 seems to be a valid choice but does not work due to hardware
restrictions. This results into a bad hardware behaviour (slow audio for
example). Feature tested on a i.MX25.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c7647e0..c0b940e 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -633,7 +633,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 		sub *= 100000;
 		do_div(sub, freq);
 
-		if (sub < savesub) {
+		if (sub < savesub && !(i == 0 && psr == 0 && div2 == 0)) {
 			baudrate = tmprate;
 			savesub = sub;
 			pm = i;
-- 
2.1.4
