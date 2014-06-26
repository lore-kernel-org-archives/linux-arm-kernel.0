From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 26 Jun 2014 15:23:10 +0100
Subject: [PATCH 5/7] ASoC: kirkwood-i2s: fix pause handling some more
In-Reply-To: <20140626142231.GR32514@n2100.arm.linux.org.uk>
References: <20140626142231.GR32514@n2100.arm.linux.org.uk>
Message-ID: <E1X0AZy-0003iQ-EJ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We still see the occasional timeout waiting for busy to clear.  As the
spec is contradictory, and we know that the current implementation
doesn't work, try an alternative interpretation from the spec.  This
one appears to work - I have yet to find any issue with it during my
testing over several months.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index b601ad680d7b..e98650c01eba 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -238,7 +238,7 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 	uint32_t ctl, value;
 
 	ctl = readl(priv->io + KIRKWOOD_PLAYCTL);
-	if (ctl & KIRKWOOD_PLAYCTL_PAUSE) {
+	if ((ctl & KIRKWOOD_PLAYCTL_ENABLE_MASK) == 0) {
 		unsigned timeout = 5000;
 		/*
 		 * The Armada510 spec says that if we enter pause mode, the
-- 
1.8.3.1
