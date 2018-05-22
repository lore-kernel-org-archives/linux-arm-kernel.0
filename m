From: j-keerthy@ti.com (Keerthy)
Date: Tue, 22 May 2018 23:52:20 +0530
Subject: [PATCH v2] OMAP: CLK: CLKSRC: Add suspend resume hooks
Message-ID: <1527013340-8036-1-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the save and restore for clksrc as part of suspend and resume
so that it saves the counter value and restores. This is needed in
modes like rtc+ddr in self-refresh not doing this stalls the time.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * Instead of everytime looking up for clksrc hwmod doing it once during init
  * Tested on am437x-gp-evm

Probably too late for 4.18!

 arch/arm/mach-omap2/timer.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 5a70ab6..98ed5ac 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -70,6 +70,9 @@
 /* Clockevent hwmod for am335x and am437x suspend */
 static struct omap_hwmod *clockevent_gpt_hwmod;
 
+/* Clockesource hwmod for am437x suspend */
+static struct omap_hwmod *clocksource_gpt_hwmod;
+
 #ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
 static unsigned long arch_timer_freq;
 
@@ -478,6 +481,26 @@ static int __init __maybe_unused omap2_sync32k_clocksource_init(void)
 	return ret;
 }
 
+static unsigned int omap2_gptimer_clksrc_load;
+
+static void omap2_gptimer_clksrc_suspend(struct clocksource *unused)
+{
+	omap2_gptimer_clksrc_load =
+		__omap_dm_timer_read_counter(&clksrc, OMAP_TIMER_NONPOSTED);
+
+	omap_hwmod_idle(clocksource_gpt_hwmod);
+}
+
+static void omap2_gptimer_clksrc_resume(struct clocksource *unused)
+{
+	omap_hwmod_enable(clocksource_gpt_hwmod);
+
+	__omap_dm_timer_load_start(&clksrc,
+				   OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR,
+				   omap2_gptimer_clksrc_load,
+				   OMAP_TIMER_NONPOSTED);
+}
+
 static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 						  const char *fck_source,
 						  const char *property)
@@ -490,6 +513,15 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 	res = omap_dm_timer_init_one(&clksrc, fck_source, property,
 				     &clocksource_gpt.name,
 				     OMAP_TIMER_NONPOSTED);
+
+	if (soc_is_am43xx()) {
+		clocksource_gpt.suspend = omap2_gptimer_clksrc_suspend;
+		clocksource_gpt.resume = omap2_gptimer_clksrc_resume;
+
+		clocksource_gpt_hwmod =
+			omap_hwmod_lookup(clocksource_gpt.name);
+	}
+
 	BUG_ON(res);
 
 	__omap_dm_timer_load_start(&clksrc,
-- 
1.9.1
