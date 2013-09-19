From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 19 Sep 2013 11:49:57 +0200
Subject: [PATCH] ASoC: kirkwood: fix loss of external clock at probe time
Message-ID: <20130919114957.1fede091@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At probe time, when the clock driver is not yet initialized, the
external clock of the kirkwood sound device will not be usable.

This patch fixes this problem defering the device probe.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/kirkwood/kirkwood-i2s.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 0f3d73d..14f32d9 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -496,7 +496,10 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		return err;
 
 	priv->extclk = devm_clk_get(&pdev->dev, "extclk");
-	if (!IS_ERR(priv->extclk)) {
+	if (IS_ERR(priv->extclk)) {
+		if (np && of_property_match_string(np, "clock-names", "extclk") >= 0)
+			return -EPROBE_DEFER;
+	} else {
 		if (priv->extclk == priv->clk) {
 			devm_clk_put(&pdev->dev, priv->extclk);
 			priv->extclk = ERR_PTR(-EINVAL);


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
