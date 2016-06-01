From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:13 -0700
Subject: [PATCH 14/34] clk: cs2000: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-15-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-cs2000-cp.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk-cs2000-cp.c b/drivers/clk/clk-cs2000-cp.c
index 7379de8dc894..021f3daf34e1 100644
--- a/drivers/clk/clk-cs2000-cp.c
+++ b/drivers/clk/clk-cs2000-cp.c
@@ -59,7 +59,6 @@ struct cs2000_priv {
 	struct i2c_client *client;
 	struct clk *clk_in;
 	struct clk *ref_clk;
-	struct clk *clk_out;
 };
 
 static const struct of_device_id cs2000_of_match[] = {
@@ -371,7 +370,6 @@ static int cs2000_clk_register(struct cs2000_priv *priv)
 	struct device_node *np = dev->of_node;
 	struct clk_init_data init;
 	const char *name = np->name;
-	struct clk *clk;
 	static const char *parent_names[CLK_MAX];
 	int ch = 0; /* it uses ch0 only at this point */
 	int rate;
@@ -400,18 +398,16 @@ static int cs2000_clk_register(struct cs2000_priv *priv)
 
 	priv->hw.init = &init;
 
-	clk = clk_register(dev, &priv->hw);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	ret = clk_hw_register(dev, &priv->hw);
+	if (ret)
+		return ret;
 
-	ret = of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, &priv->hw);
 	if (ret < 0) {
-		clk_unregister(clk);
+		clk_hw_unregister(&priv->hw);
 		return ret;
 	}
 
-	priv->clk_out = clk;
-
 	return 0;
 }
 
@@ -454,7 +450,7 @@ static int cs2000_remove(struct i2c_client *client)
 
 	of_clk_del_provider(np);
 
-	clk_unregister(priv->clk_out);
+	clk_hw_unregister(&priv->hw);
 
 	return 0;
 }
-- 
2.7.4
