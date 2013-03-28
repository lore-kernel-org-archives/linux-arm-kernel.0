From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 28 Mar 2013 17:12:25 +0100
Subject: [PATCH iv2] ARM: kirkwood: fix a compilation warning
Message-ID: <20130328171225.131d3739@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the function kirkwood_set_rate, when the rate cannot be satisfied
by the internal nor by an extern clock, the clock source could be set
to an undefined value.

As the ALSA subsystem should never gives such a rate, this patch removes
the check of the external clock pointer.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
v2
  - this patch replaces the previous
	[PATCH 1/2] ARM: kirkwood: fix a not initialized variable in the sound subsystem
  - no error message and don't check the external clock pointer (from Russell King)
---
 sound/soc/kirkwood/kirkwood-i2s.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index c74c890..9ca1321 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -111,7 +111,7 @@ static void kirkwood_set_rate(struct snd_soc_dai *dai,
 		kirkwood_set_dco(priv->io, rate);
 
 		clks_ctrl = KIRKWOOD_MCLK_SOURCE_DCO;
-	} else if (!IS_ERR(priv->extclk)) {
+	} else {
 		/* use optional external clk for other rates */
 		dev_dbg(dai->dev, "%s: extclk set rate = %lu -> %lu\n",
 			__func__, rate, 256 * rate);
-- 
1.7.10.4


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
