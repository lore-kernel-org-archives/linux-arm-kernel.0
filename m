From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue,  9 Sep 2014 16:06:51 +0200
Subject: [PATCH v10 8/9] clk: Take the prepare lock when updating the per-user
 constraints
In-Reply-To: <1410271612-27389-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1410271329-26637-1-git-send-email-tomeu.vizoso@collabora.com>
 <1410271612-27389-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1410271612-27389-6-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/clk/clk.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f283dcc..1ad8cb7 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1734,15 +1734,25 @@ EXPORT_SYMBOL_GPL(clk_set_rate);
 int clk_set_floor_rate(struct clk *clk_user, unsigned long rate)
 {
 	struct clk_core *clk = clk_to_clk_core(clk_user);
+	int ret;
+
+	clk_prepare_lock();
 
 	clk_user->floor_constraint = rate;
-	return clk_provider_set_rate(clk, clk_provider_get_rate(clk));
+	ret = clk_provider_set_rate(clk, clk_provider_get_rate(clk));
+
+	clk_prepare_unlock();
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(clk_set_floor_rate);
 
 int clk_set_ceiling_rate(struct clk *clk_user, unsigned long rate)
 {
 	struct clk_core *clk = clk_to_clk_core(clk_user);
+	int ret;
+
+	clk_prepare_lock();
 
 	WARN(rate > 0 && rate < clk_user->floor_constraint,
 	     "clk %s dev %s con %s: new ceiling %lu lower than existing floor %lu\n",
@@ -1750,7 +1760,11 @@ int clk_set_ceiling_rate(struct clk *clk_user, unsigned long rate)
 	     clk_user->floor_constraint);
 
 	clk_user->ceiling_constraint = rate;
-	return clk_provider_set_rate(clk, clk_provider_get_rate(clk));
+	ret = clk_provider_set_rate(clk, clk_provider_get_rate(clk));
+
+	clk_prepare_unlock();
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(clk_set_ceiling_rate);
 
-- 
1.9.3
