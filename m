From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 04 Aug 2013 20:23:03 +0100
Subject: [PATCH RFC 02/13] ASoC: kirkwood: use devm_clk_get() for the
 external clock
In-Reply-To: <20130804192136.GK23006@n2100.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
Message-ID: <E1V63tP-0004lH-4Q@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_clk_get() to simplify the error path for the external clock.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-i2s.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 4c9dad3..ee27981 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -498,10 +498,10 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
-	priv->extclk = clk_get(&pdev->dev, "extclk");
+	priv->extclk = devm_clk_get(&pdev->dev, "extclk");
 	if (!IS_ERR(priv->extclk)) {
 		if (priv->extclk == priv->clk) {
-			clk_put(priv->extclk);
+			devm_clk_put(&pdev->dev, priv->extclk);
 			priv->extclk = ERR_PTR(-EINVAL);
 		} else {
 			dev_info(&pdev->dev, "found external clock\n");
@@ -529,10 +529,8 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		return 0;
 	dev_err(&pdev->dev, "snd_soc_register_component failed\n");
 
-	if (!IS_ERR(priv->extclk)) {
+	if (!IS_ERR(priv->extclk))
 		clk_disable_unprepare(priv->extclk);
-		clk_put(priv->extclk);
-	}
 	clk_disable_unprepare(priv->clk);
 
 	return err;
@@ -544,10 +542,8 @@ static int kirkwood_i2s_dev_remove(struct platform_device *pdev)
 
 	snd_soc_unregister_component(&pdev->dev);
 
-	if (!IS_ERR(priv->extclk)) {
+	if (!IS_ERR(priv->extclk))
 		clk_disable_unprepare(priv->extclk);
-		clk_put(priv->extclk);
-	}
 	clk_disable_unprepare(priv->clk);
 
 	return 0;
-- 
1.7.4.4
