From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  9 Aug 2011 11:46:51 +0100
Subject: [RFC PATCH 09/12] ARM: smp_twd: remove support for non-standalone
	version
In-Reply-To: <1312886814-15627-1-git-send-email-marc.zyngier@arm.com>
References: <1312886814-15627-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1312886814-15627-10-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no in-tree platform using both CONFIG_LOCAL_TIMERS and
CONFIG_HAVE_ARM_TWD. As such, some code can be removed and some
exported function of smp_twd.c can be made static.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig                  |    1 -
 arch/arm/include/asm/localtimer.h |   10 ----------
 arch/arm/include/asm/smp_twd.h    |    5 -----
 arch/arm/kernel/smp_twd.c         |   10 +++-------
 4 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7ac28a3..12cbeba 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1438,7 +1438,6 @@ config LOCAL_TIMERS
 	bool "Use local timer interrupts"
 	depends on SMP && !ARM_SMP_TWD
 	default y
-	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index f5e1cec..af5c371 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -21,21 +21,11 @@ void percpu_timer_setup(void);
 
 #ifdef CONFIG_LOCAL_TIMERS
 
-#ifdef CONFIG_HAVE_ARM_TWD
-
-#include "smp_twd.h"
-
-#define local_timer_stop(c)	twd_timer_stop((c))
-
-#else
-
 /*
  * Stop the local timer
  */
 void local_timer_stop(struct clock_event_device *);
 
-#endif
-
 /*
  * Setup a local timer interrupt for a CPU.
  */
diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index 934f1bc..0da6438 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -18,13 +18,8 @@
 #define TWD_TIMER_CONTROL_PERIODIC	(1 << 1)
 #define TWD_TIMER_CONTROL_IT_ENABLE	(1 << 2)
 
-struct clock_event_device;
 struct resource;
 
-extern void __iomem *twd_base;
-
-void twd_timer_setup(struct clock_event_device *);
-void twd_timer_stop(struct clock_event_device *);
 #ifdef CONFIG_HAVE_ARM_TWD
 int twd_timer_register(struct resource *res, int res_nr);
 #else
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 5b6d99b..0a9106d 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -20,11 +20,9 @@
 #include <linux/io.h>
 
 #include <asm/smp_twd.h>
-#include <asm/localtimer.h>
 #include <asm/hardware/gic.h>
 
-/* set up by the platform code */
-void __iomem *twd_base;
+static void __iomem *twd_base;
 
 static unsigned long twd_timer_rate;
 
@@ -79,7 +77,7 @@ static irqreturn_t twd_timer_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-void twd_timer_stop(struct clock_event_device *clk)
+static void twd_timer_stop(struct clock_event_device *clk)
 {
 	twd_set_mode(CLOCK_EVT_MODE_UNUSED, clk);
 	gic_free_ppi(clk->irq, clk);
@@ -127,7 +125,7 @@ static void __cpuinit twd_calibrate_rate(void)
 /*
  * Setup the local clock events for a CPU.
  */
-void __cpuinit twd_timer_setup(struct clock_event_device *clk)
+static void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 {
 	int err;
 
@@ -152,7 +150,6 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 		       clk->name, clk->irq, smp_processor_id(), err);
 }
 
-#ifdef CONFIG_ARM_SMP_TWD
 static struct clock_event_device __percpu *twd_evt;
 static int twd_ppi;
 
@@ -223,4 +220,3 @@ int twd_timer_register(struct resource *res, int res_nr)
 
 	return 0;
 }
-#endif
-- 
1.7.0.4
