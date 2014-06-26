From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 26 Jun 2014 15:23:05 +0100
Subject: [PATCH 4/7] ASoC: kirkwood-i2s: fix mute handling
In-Reply-To: <20140626142231.GR32514@n2100.arm.linux.org.uk>
References: <20140626142231.GR32514@n2100.arm.linux.org.uk>
Message-ID: <E1X0AZt-0003iM-B0@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spec requires that the mute bits must be set while the channel
is disabled.  Ensure that this is the case by providing a helper
which ensures that the appropriate mute bit is set while the enable
bit is clear.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-i2s.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index ef1a164d8703..b601ad680d7b 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -222,6 +222,15 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static unsigned kirkwood_i2s_play_mute(unsigned ctl)
+{
+	if (!(ctl & KIRKWOOD_PLAYCTL_I2S_EN))
+		ctl |= KIRKWOOD_PLAYCTL_I2S_MUTE;
+	if (!(ctl & KIRKWOOD_PLAYCTL_SPDIF_EN))
+		ctl |= KIRKWOOD_PLAYCTL_SPDIF_MUTE;
+	return ctl;
+}
+
 static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 				int cmd, struct snd_soc_dai *dai)
 {
@@ -257,7 +266,7 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 			ctl &= ~KIRKWOOD_PLAYCTL_SPDIF_EN;	/* i2s */
 		else
 			ctl &= ~KIRKWOOD_PLAYCTL_I2S_EN;	/* spdif */
-
+		ctl = kirkwood_i2s_play_mute(ctl);
 		value = ctl & ~KIRKWOOD_PLAYCTL_ENABLE_MASK;
 		writel(value, priv->io + KIRKWOOD_PLAYCTL);
 
@@ -296,6 +305,7 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		ctl &= ~(KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE |
 				KIRKWOOD_PLAYCTL_SPDIF_MUTE);
+		ctl = kirkwood_i2s_play_mute(ctl);
 		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
 		break;
 
-- 
1.8.3.1
