From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 13 Nov 2012 12:13:19 -0600
Subject: [PATCH 4/8] ARM: OMAP2+: Remove unnecessary local variable in timer
 code
In-Reply-To: <1352830403-1706-1-git-send-email-jon-hunter@ti.com>
References: <1352830403-1706-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1352830403-1706-5-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function omap_dm_timer_init_one() declares two local variables of
type int that are used to store the return value of functions called.
One such local variable is sufficient and so remove one of these local
variables.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index e9fcc5f..1a662df 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -246,8 +246,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	struct device_node *np;
 	struct omap_hwmod *oh;
 	struct resource irq, mem;
-	int res = 0;
-	int r;
+	int r = 0;
 
 	if (of_have_populated_dt()) {
 		np = omap_get_timer_dt(omap_timer_match, NULL);
@@ -307,10 +306,10 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 
 		src = clk_get(NULL, fck_source);
 		if (IS_ERR(src)) {
-			res = -EINVAL;
+			r = -EINVAL;
 		} else {
-			res = clk_set_parent(timer->fclk, src);
-			if (IS_ERR_VALUE(res))
+			r = clk_set_parent(timer->fclk, src);
+			if (IS_ERR_VALUE(r))
 				pr_warn("%s: %s cannot set source\n",
 					__func__, oh->name);
 			clk_put(src);
@@ -331,7 +330,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	timer->rate = clk_get_rate(timer->fclk);
 	timer->reserved = 1;
 
-	return res;
+	return r;
 }
 
 static void __init omap2_gp_clockevent_init(int gptimer_id,
-- 
1.7.9.5
