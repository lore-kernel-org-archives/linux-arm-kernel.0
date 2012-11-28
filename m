From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 27 Nov 2012 20:15:13 -0600
Subject: [PATCH 1/3] ARM: OMAP2+: Fix realtime_counter_init warning in timer.c
In-Reply-To: <1354068915-3378-1-git-send-email-jon-hunter@ti.com>
References: <1354068915-3378-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1354068915-3378-2-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit fa6d79d (ARM: OMAP: Add initialisation for the real-time
counter), the function realtime_counter_init() was added. However, if
the kernel configuration option CONFIG_SOC_OMAP5 is not selected then
the following compiler warning is observed.

  CC      arch/arm/mach-omap2/timer.o
  arch/arm/mach-omap2/timer.c:489:20: warning: ?realtime_counter_init?
  defined but not used [-Wunused-function]

Commit fa6d79d also introduced the kernel configuration option
CONFIG_SOC_HAS_REALTIME_COUNTER. If this option is not selected then the
a stub function for realtime_counter_init() is defined.

The option CONFIG_SOC_HAS_REALTIME_COUNTER and stub function are not
really needed because ...

1. For non-OMAP5 devices, there is no realtime counter and so
   realtime_counter_init() function is not used.
2. For OMAP5 devices, CONFIG_SOC_HAS_REALTIME_COUNTER is always selected
   and cannot be disabled, so the stub function for realtime_counter_init()
   is never used.

Fix this warning by removing the kernel configuration option
CONFIG_SOC_HAS_REALTIME_COUNTER and stub function, and only include
the function realtime_counter_init() if CONFIG_SOC_OMAP5 is selected.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    4 ----
 arch/arm/mach-omap2/timer.c |    7 ++-----
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 813c267..ea88b7d 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -24,9 +24,6 @@ config ARCH_OMAP2PLUS_TYPICAL
 config SOC_HAS_OMAP2_SDRC
 	bool "OMAP2 SDRAM Controller support"
 
-config SOC_HAS_REALTIME_COUNTER
-	bool "Real time free running counter"
-
 config ARCH_OMAP2
 	bool "TI OMAP2"
 	depends on ARCH_OMAP2PLUS
@@ -79,7 +76,6 @@ config SOC_OMAP5
 	select ARM_GIC
 	select CPU_V7
 	select HAVE_SMP
-	select SOC_HAS_REALTIME_COUNTER
 	select COMMON_CLK
 
 comment "OMAP Core Type"
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index b9cff72..a9f99e3 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -476,7 +476,7 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 			gptimer_id, clksrc.rate);
 }
 
-#ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
+#ifdef CONFIG_SOC_OMAP5
 /*
  * The realtime counter also called master counter, is a free-running
  * counter, which is related to real time. It produces the count used
@@ -549,10 +549,7 @@ static void __init realtime_counter_init(void)
 
 	iounmap(base);
 }
-#else
-static inline void __init realtime_counter_init(void)
-{}
-#endif
+#endif /* CONFIG_SOC_OMAP5 */
 
 #define OMAP_SYS_GP_TIMER_INIT(name, clkev_nr, clkev_src, clkev_prop,	\
 			       clksrc_nr, clksrc_src)			\
-- 
1.7.10.4
