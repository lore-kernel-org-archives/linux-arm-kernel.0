From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 21 Oct 2013 09:46:13 +0200
Subject: [PATCH] ASoC: kirkwood: cleanup the external clock probe
Message-ID: <20131021094613.2a07bd79@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch checks the return value of the clk_prepare_enable of the
external clock and removes the test about a same internal and external
clock which would quite never occur and won't work in most cases
it would occur.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
This patch applies against broonie/sound for-next.
---
 sound/soc/kirkwood/kirkwood-i2s.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c.old b/sound/soc/kirkwood/kirkwood-i2s.c.pat2
index d0504a2..c2433ea 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c.old
+++ b/sound/soc/kirkwood/kirkwood-i2s.c.pat2
@@ -500,14 +500,11 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		if (PTR_ERR(priv->extclk) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 	} else {
-		if (priv->extclk == priv->clk) {
-			devm_clk_put(&pdev->dev, priv->extclk);
-			priv->extclk = ERR_PTR(-EINVAL);
-		} else {
-			dev_info(&pdev->dev, "found external clock\n");
-			clk_prepare_enable(priv->extclk);
-			soc_dai = &kirkwood_i2s_dai_extclk;
-		}
+		dev_info(&pdev->dev, "found external clock\n");
+		ret = clk_prepare_enable(priv->extclk);
+		if (err < 0)
+			return err;
+		soc_dai = kirkwood_i2s_dai_extclk;
 	}
 
 	/* Some sensible defaults - this reflects the powerup values */

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
