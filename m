From: ladis@linux-mips.org (Ladislav Michl)
Date: Fri, 23 Feb 2018 11:14:22 +0100
Subject: [PATCH 2/6] clocksource: timer-ti-dm: Consolidate set source
In-Reply-To: <20180223101254.GA5746@lenoch>
References: <20180223101254.GA5746@lenoch>
Message-ID: <20180223101422.GC5746@lenoch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reorder omap_dm_timer_set_source internals to get
source verification more straightforward.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/clocksource/timer-ti-dm.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index e4d75a8eaa91..4d645d6c6c31 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -166,17 +166,28 @@ static int omap_dm_timer_of_set_source(struct omap_dm_timer *timer)
 static int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 {
 	int ret;
-	char *parent_name = NULL;
+	const char *parent_name;
 	struct clk *parent;
 	struct dmtimer_platform_data *pdata;
 
-	if (unlikely(!timer))
+	if (unlikely(!timer) || IS_ERR(timer->fclk))
 		return -EINVAL;
 
-	pdata = timer->pdev->dev.platform_data;
-
-	if (source < 0 || source >= 3)
+	switch (source) {
+	case OMAP_TIMER_SRC_SYS_CLK:
+		parent_name = "timer_sys_ck";
+		break;
+	case OMAP_TIMER_SRC_32_KHZ:
+		parent_name = "timer_32k_ck";
+		break;
+	case OMAP_TIMER_SRC_EXT_CLK:
+		parent_name = "timer_ext_ck";
+		break;
+	default:
 		return -EINVAL;
+	}
+
+	pdata = timer->pdev->dev.platform_data;
 
 	/*
 	 * FIXME: Used for OMAP1 devices only because they do not currently
@@ -186,29 +197,12 @@ static int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	if (pdata && pdata->set_timer_src)
 		return pdata->set_timer_src(timer->pdev, source);
 
-	if (IS_ERR(timer->fclk))
-		return -EINVAL;
-
 #if defined(CONFIG_COMMON_CLK)
 	/* Check if the clock has configurable parents */
 	if (clk_hw_get_num_parents(__clk_get_hw(timer->fclk)) < 2)
 		return 0;
 #endif
 
-	switch (source) {
-	case OMAP_TIMER_SRC_SYS_CLK:
-		parent_name = "timer_sys_ck";
-		break;
-
-	case OMAP_TIMER_SRC_32_KHZ:
-		parent_name = "timer_32k_ck";
-		break;
-
-	case OMAP_TIMER_SRC_EXT_CLK:
-		parent_name = "timer_ext_ck";
-		break;
-	}
-
 	parent = clk_get(&timer->pdev->dev, parent_name);
 	if (IS_ERR(parent)) {
 		pr_err("%s: %s not found\n", __func__, parent_name);
-- 
2.16.1
