From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 11 May 2010 16:47:07 -0700
Subject: [PATCH 2/6] OMAP3: PM: Add milliseconds interface to suspend wakeup
	timer
In-Reply-To: <1273621631-9148-1-git-send-email-khilman@deeprootsystems.com>
References: <1273621631-9148-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273621631-9148-3-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ari Kauppi <Ext-Ari.Kauppi@nokia.com>

Millisecond resolution is possible and there are use cases for it
(automatic testing).

Seconds-based interface is preserved for compatibility.

Signed-off-by: Ari Kauppi <Ext-Ari.Kauppi@nokia.com>
Reviewed-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm-debug.c |    3 +++
 arch/arm/mach-omap2/pm.h       |    1 +
 arch/arm/mach-omap2/pm34xx.c   |   17 ++++++++++-------
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 6cac981..723b44e 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -548,6 +548,9 @@ static int option_set(void *data, u64 val)
 {
 	u32 *option = data;
 
+	if (option == &wakeup_timer_milliseconds && val >= 1000)
+		return -EINVAL;
+
 	*option = val;
 
 	if (option == &enable_off_mode)
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index bd6466a..3de6ece 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -43,6 +43,7 @@ extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 
 extern u32 wakeup_timer_seconds;
+extern u32 wakeup_timer_milliseconds;
 extern struct omap_dm_timer *gptimer_wakeup;
 
 #ifdef CONFIG_PM_DEBUG
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a15aa92..e76af5b 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -58,6 +58,7 @@
 u32 enable_off_mode;
 u32 sleep_while_idle;
 u32 wakeup_timer_seconds;
+u32 wakeup_timer_milliseconds;
 
 struct power_state {
 	struct powerdomain *pwrdm;
@@ -555,20 +556,21 @@ out:
 #ifdef CONFIG_SUSPEND
 static suspend_state_t suspend_state;
 
-static void omap2_pm_wakeup_on_timer(u32 seconds)
+static void omap2_pm_wakeup_on_timer(u32 seconds, u32 milliseconds)
 {
 	u32 tick_rate, cycles;
 
-	if (!seconds)
+	if (!seconds && !milliseconds)
 		return;
 
 	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer_wakeup));
-	cycles = tick_rate * seconds;
+	cycles = tick_rate * seconds + tick_rate * milliseconds / 1000;
 	omap_dm_timer_stop(gptimer_wakeup);
 	omap_dm_timer_set_load_start(gptimer_wakeup, 0, 0xffffffff - cycles);
 
-	pr_info("PM: Resume timer in %d secs (%d ticks at %d ticks/sec.)\n",
-		seconds, cycles, tick_rate);
+	pr_info("PM: Resume timer in %u.%03u secs"
+		" (%d ticks at %d ticks/sec.)\n",
+		seconds, milliseconds, cycles, tick_rate);
 }
 
 static int omap3_pm_prepare(void)
@@ -582,8 +584,9 @@ static int omap3_pm_suspend(void)
 	struct power_state *pwrst;
 	int state, ret = 0;
 
-	if (wakeup_timer_seconds)
-		omap2_pm_wakeup_on_timer(wakeup_timer_seconds);
+	if (wakeup_timer_seconds || wakeup_timer_milliseconds)
+		omap2_pm_wakeup_on_timer(wakeup_timer_seconds,
+					 wakeup_timer_milliseconds);
 
 	/* Read current next_pwrsts */
 	list_for_each_entry(pwrst, &pwrst_list, node)
-- 
1.7.0.2
