From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 18 Oct 2013 20:35:55 +0200
Subject: [PATCH v3 2/2] ASoC: kirkwood: fix loss of external clock at probe
 time
Message-ID: <20131018203555.4d974251@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At probe time, when the clock driver is not yet initialized, the
external clock of the kirkwood sound device will not be usable.

This patch fixes this problem defering the device probe.

It also removes the test about same internal and external clocks which
can never occur.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
v3: remove the test of same internal and external clocks

The associated patch:
[PATCH v3 1/2] ASoC: kirkwood: clk: probe defer when clock not yet ready
is unchanged and not resent
---
 sound/soc/kirkwood/kirkwood-i2s.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 8ac89f5..2bbbab5 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -496,15 +496,13 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		return err;
 
 	priv->extclk = devm_clk_get(&pdev->dev, "extclk");
-	if (!IS_ERR(priv->extclk)) {
-		if (priv->extclk == priv->clk) {
-			devm_clk_put(&pdev->dev, priv->extclk);
-			priv->extclk = ERR_PTR(-EINVAL);
-		} else {
-			dev_info(&pdev->dev, "found external clock\n");
-			clk_prepare_enable(priv->extclk);
-			soc_dai = &kirkwood_i2s_dai_extclk;
-		}
+	if (IS_ERR(priv->extclk)) {
+		if (PTR_ERR(priv->extclk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+	} else {
+		dev_info(&pdev->dev, "found external clock\n");
+		clk_prepare_enable(priv->extclk);
+		soc_dai = kirkwood_i2s_dai_extclk;
 	}
 
 	/* Some sensible defaults - this reflects the powerup values */


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
