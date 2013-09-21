From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 21 Sep 2013 12:00:06 +0200
Subject: [PATCH v2 1/2] ASoC: kirkwood: clk: probe defer when clock not yet
 ready
Message-ID: <20130921120006.47b00fe7@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At probe time, a clock device may not be ready when some other device
wants to use it. 

This patch lets the functions clk_get/devm_clk_get return a probe defer
when the clock is defined in the DT but not yet available.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/clk/clk.c    | 2 +-
 drivers/clk/clkdev.c | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index a004769..582abc8 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2181,7 +2181,7 @@ EXPORT_SYMBOL_GPL(of_clk_del_provider);
 struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
 {
 	struct of_clk_provider *provider;
-	struct clk *clk = ERR_PTR(-ENOENT);
+	struct clk *clk = ERR_PTR(-EPROBE_DEFER);
 
 	/* Check if we have such a provider in our array */
 	mutex_lock(&of_clk_lock);
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 442a313..f8b28d9 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -157,8 +157,13 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 
 	if (dev) {
 		clk = of_clk_get_by_name(dev->of_node, con_id);
-		if (!IS_ERR(clk) && __clk_get(clk))
-			return clk;
+		if (!IS_ERR(clk)) {
+			if (__clk_get(clk))
+				return clk;
+		} else {
+			if (PTR_ERR(clk) == -EPROBE_DEFER)
+				return clk;
+		}
 	}
 
 	return clk_get_sys(dev_id, con_id);


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
