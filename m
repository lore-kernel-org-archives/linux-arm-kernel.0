From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 26 Jun 2014 15:23:00 +0100
Subject: [PATCH 3/7] ASoC: kirkwood-i2s: fix RECCTL masking
In-Reply-To: <20140626142231.GR32514@n2100.arm.linux.org.uk>
References: <20140626142231.GR32514@n2100.arm.linux.org.uk>
Message-ID: <E1X0AZo-0003iI-7d@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we wish to disable capture inputs for some formats, we need to
ensure that we clear the enable bits in our cached record control
register.  This seems to have been missed, resulting in the register
only accumulating enable bits.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-i2s.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 55af6c8e4603..ef1a164d8703 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -212,7 +212,8 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
 				    KIRKWOOD_PLAYCTL_SIZE_MASK);
 		priv->ctl_play |= ctl_play;
 	} else {
-		priv->ctl_rec &= ~KIRKWOOD_RECCTL_SIZE_MASK;
+		priv->ctl_rec &= ~(KIRKWOOD_RECCTL_ENABLE_MASK |
+				   KIRKWOOD_RECCTL_SIZE_MASK);
 		priv->ctl_rec |= ctl_rec;
 	}
 
-- 
1.8.3.1
