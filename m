From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 26 Mar 2013 19:05:13 +0100
Subject: [PATCH 1/2] ARM: kirkwood: fix a not initialized variable in the
 sound subsystem
Message-ID: <20130326190513.1671a3be@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the function kirkwood_set_rate, in case of a non dco supported rate
and no external clock, the clock source was set to an undefined value.
This patch just displays a message without changing the clock source.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/kirkwood/kirkwood-i2s.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index c74c890..afca1ec 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -118,6 +118,9 @@ static void kirkwood_set_rate(struct snd_soc_dai *dai,
 		clk_set_rate(priv->extclk, 256 * rate);
 
 		clks_ctrl = KIRKWOOD_MCLK_SOURCE_EXTCLK;
+	} else {
+		dev_err(dai->dev, "%s: no clock\n", __func__);
+		return;
 	}
 	writel(clks_ctrl, priv->io + KIRKWOOD_CLOCKS_CTRL);
 }
-- 
1.7.10.4

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
