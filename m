From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 24 Sep 2013 20:12:35 +0200
Subject: [PATCH] ASoC: kirkwood: simplify clock handling
In-Reply-To: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1380046355-7920-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to not use extclk if it is identical to the main clk.
The main motivation for this patch is dropping devm_clk_put which is
used in a wrong way by all other users.

While at it also extend the comments.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

there might be some further optimisations possible. I only note them
here because I don't have the hardware to test:

 - only enable extclk if it a clock rate used that makes use of the
   external clock. Not sure if that works; hardware docs reading
   necessary.
 - only provide extclk if it's != the internal clock.
 - The code uses:

	priv->clk = devm_clk_get(&pdev->dev, np ? "internal" : NULL);

   i.e. provides a con_id in the dt-case. I think that using NULL
   unconditionally should also work, i.e. return the first clk
   associated to the device. OTOH the current code might make things
   clearer because it's more explicit.

Best regards
Uwe
---
 sound/soc/kirkwood/kirkwood-i2s.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 0f3d73d..8224f93 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -104,16 +104,25 @@ static void kirkwood_set_rate(struct snd_soc_dai *dai,
 	uint32_t clks_ctrl;
 
 	if (rate == 44100 || rate == 48000 || rate == 96000) {
-		/* use internal dco for the supported rates
-		 * defined in kirkwood_i2s_dai */
+		/*
+		 * use internal dco for the supported rates
+		 * defined in kirkwood_i2s_dai
+		 * Note: For these specific rates the dco is also used if
+		 * kirkwood_i2s_dai_extclk is in use.
+		 */
 		dev_dbg(dai->dev, "%s: dco set rate = %lu\n",
 			__func__, rate);
 		kirkwood_set_dco(priv->io, rate);
 
 		clks_ctrl = KIRKWOOD_MCLK_SOURCE_DCO;
 	} else {
-		/* use the external clock for the other rates
-		 * defined in kirkwood_i2s_dai_extclk */
+		/*
+		 * use the external clock for the other rates
+		 * defined in kirkwood_i2s_dai_extclk
+		 * This case isn't reached if kirkwood_i2s_dai is in use (and so
+		 * extclk isn't valid) because it only supports the three rates
+		 * above.
+		 */
 		dev_dbg(dai->dev, "%s: extclk set rate = %lu -> %lu\n",
 			__func__, rate, 256 * rate);
 		clk_set_rate(priv->extclk, 256 * rate);
@@ -497,12 +506,9 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 
 	priv->extclk = devm_clk_get(&pdev->dev, "extclk");
 	if (!IS_ERR(priv->extclk)) {
-		if (priv->extclk == priv->clk) {
-			devm_clk_put(&pdev->dev, priv->extclk);
-			priv->extclk = ERR_PTR(-EINVAL);
-		} else {
+		clk_prepare_enable(priv->extclk);
+		if (priv->extclk != priv->clk) {
 			dev_info(&pdev->dev, "found external clock\n");
-			clk_prepare_enable(priv->extclk);
 			soc_dai = &kirkwood_i2s_dai_extclk;
 		}
 	}
-- 
1.8.4.rc3
