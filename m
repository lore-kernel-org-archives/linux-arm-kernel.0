From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 14 Dec 2015 22:34:05 +0200
Subject: [PATCH 1/2] ARM: OMAP: am43xx: enable GENERIC_CLOCKEVENTS_BROADCAST
In-Reply-To: <1450125246-17249-1-git-send-email-grygorii.strashko@ti.com>
References: <1450125246-17249-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1450125246-17249-2-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

System will misbehave in the following case:
- AM43XX only build (UP);
- CONFIG_CPU_IDLE=y
- ARM TWD timer enabled and selected as clockevent device.

In the above case, It's expected that broadcast timer will be used as
backup timer when CPUIdle will put MPU in low power states where ARM
TWD will stop and lose its context. But, the CONFIG_SMP might not be
selected when kernel is built for AM43XX SoC only and, as result,
GENERIC_CLOCKEVENTS_BROADCAST option will not be selected also. This
will break CPUIdle and System will stuck in low power states.

Hence, fix it by selecting GENERIC_CLOCKEVENTS_BROADCAST option for
AM43XX SoCs always and add empty tick_broadcast() function
implementation - no need to send any IPI on UP. After this change
timer1 will be selected as broadcast timer the same way as for SMP,
and CPUIdle will work properly.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/mach-omap2/Kconfig | 1 +
 arch/arm/mach-omap2/timer.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 4b4371d..32a0086 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -65,6 +65,7 @@ config SOC_AM43XX
 	select MACH_OMAP_GENERIC
 	select MIGHT_HAVE_CACHE_L2X0
 	select HAVE_ARM_SCU
+	select GENERIC_CLOCKEVENTS_BROADCAST
 
 config SOC_DRA7XX
 	bool "TI DRA7XX"
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 3bfde44..f34a809 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -320,6 +320,12 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	return r;
 }
 
+#if !defined(CONFIG_SMP) && defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST)
+void tick_broadcast(const struct cpumask *mask)
+{
+}
+#endif
+
 static void __init omap2_gp_clockevent_init(int gptimer_id,
 						const char *fck_source,
 						const char *property)
-- 
2.6.4
