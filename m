From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 7 Nov 2012 13:01:29 -0600
Subject: [PATCH V2 13/14] ARM: OMAP: Remove unnecessary call to clk_get()
In-Reply-To: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1352314890-22224-14-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whenever we call the function omap_dm_timer_set_source() to set the clock
source of a dmtimer we look-up the dmtimer functional clock source by
calling clk_get(). This is not necessary because on requesting a dmtimer
we look-up the functional clock source and store it in the omap_dm_timer
structure. So instead of looking up the clock again used the clock handle
that stored in the omap_dm_timer structure.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 508a38e..191d5e5 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -503,7 +503,7 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 {
 	int ret;
 	char *parent_name = NULL;
-	struct clk *fclk, *parent;
+	struct clk *parent;
 	struct dmtimer_platform_data *pdata;
 
 	if (unlikely(!timer))
@@ -522,11 +522,8 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	if (pdata && pdata->set_timer_src)
 		return pdata->set_timer_src(timer->pdev, source);
 
-	fclk = clk_get(&timer->pdev->dev, "fck");
-	if (IS_ERR_OR_NULL(fclk)) {
-		pr_err("%s: fck not found\n", __func__);
+	if (!timer->fclk)
 		return -EINVAL;
-	}
 
 	switch (source) {
 	case OMAP_TIMER_SRC_SYS_CLK:
@@ -545,18 +542,15 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	parent = clk_get(&timer->pdev->dev, parent_name);
 	if (IS_ERR_OR_NULL(parent)) {
 		pr_err("%s: %s not found\n", __func__, parent_name);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
-	ret = clk_set_parent(fclk, parent);
+	ret = clk_set_parent(timer->fclk, parent);
 	if (IS_ERR_VALUE(ret))
 		pr_err("%s: failed to set %s as parent\n", __func__,
 			parent_name);
 
 	clk_put(parent);
-out:
-	clk_put(fclk);
 
 	return ret;
 }
-- 
1.7.9.5
