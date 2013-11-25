From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 25 Nov 2013 20:19:05 +0100
Subject: [PATCH] ASoC: kirkwood: Fix erroneous double output while playing
Message-ID: <20131125201905.0d009921@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the setting of the register KIRKWOOD_PLAYCTL which did
always streaming on both I2S and SPDIF, ignoring the DAI ID.

The bug was introduced by the commit 75b9b65ee5a
 "ASoC: kirkwood: add S/PDIF support"

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/kirkwood/kirkwood-i2s.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index d34d917..b27f826 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -244,15 +244,15 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 				   ctl);
 	}
 
-	if (dai->id == 0)
-		ctl &= ~KIRKWOOD_PLAYCTL_SPDIF_EN;	/* i2s */
-	else
-		ctl &= ~KIRKWOOD_PLAYCTL_I2S_EN;	/* spdif */
-
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		/* configure */
 		ctl = priv->ctl_play;
+		if (dai->id == 0)
+			ctl &= ~KIRKWOOD_PLAYCTL_SPDIF_EN;	/* i2s */
+		else
+			ctl &= ~KIRKWOOD_PLAYCTL_I2S_EN;	/* spdif */
+
 		value = ctl & ~KIRKWOOD_PLAYCTL_ENABLE_MASK;
 		writel(value, priv->io + KIRKWOOD_PLAYCTL);
 

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
