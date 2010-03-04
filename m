From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: Integrator: convert to generic time support
References: <git-1267729916-ba63a72aebef1bae1a2e1f7b7f0cd58805108927@rmk-PC>
Message-ID: <git-1267729916-b61fd4926d11e56bef313c0c427a7933a43621c9@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig                         |    1 +
 arch/arm/mach-integrator/common.h        |    1 -
 arch/arm/mach-integrator/core.c          |   62 ++++++++++++++---------------
 arch/arm/mach-integrator/integrator_ap.c |    1 -
 arch/arm/mach-integrator/integrator_cp.c |    1 -
 5 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c33ca8..d656dec 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -223,6 +223,7 @@ config ARCH_INTEGRATOR
 	select HAVE_CLK
 	select COMMON_CLKDEV
 	select ICST525
+	select GENERIC_TIME
 	help
 	  Support for ARM's Integrator platform.
 
diff --git a/arch/arm/mach-integrator/common.h b/arch/arm/mach-integrator/common.h
index 609c49d..7dc24bb 100644
--- a/arch/arm/mach-integrator/common.h
+++ b/arch/arm/mach-integrator/common.h
@@ -1,2 +1 @@
 extern void integrator_time_init(unsigned long, unsigned int);
-extern unsigned long integrator_gettimeoffset(void);
diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index 096f899..87c6f98 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -19,6 +19,7 @@
 #include <linux/termios.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/serial.h>
+#include <linux/clocksource.h>
 #include <linux/io.h>
 
 #include <asm/clkdev.h>
@@ -225,7 +226,6 @@ EXPORT_SYMBOL(cm_control);
 #define TIMER0_VA_BASE (IO_ADDRESS(INTEGRATOR_CT_BASE)+0x00000000)
 #define TIMER1_VA_BASE (IO_ADDRESS(INTEGRATOR_CT_BASE)+0x00000100)
 #define TIMER2_VA_BASE (IO_ADDRESS(INTEGRATOR_CT_BASE)+0x00000200)
-#define VA_IC_BASE     IO_ADDRESS(INTEGRATOR_IC_BASE) 
 
 /*
  * How long is the timer interval?
@@ -241,42 +241,38 @@ EXPORT_SYMBOL(cm_control);
 
 static unsigned long timer_reload;
 
-/*
- * Returns number of ms since last clock interrupt.  Note that interrupts
- * will have been disabled by do_gettimeoffset()
- */
-unsigned long integrator_gettimeoffset(void)
+static void __iomem * const clksrc_base = (void __iomem *)TIMER2_VA_BASE;
+
+static cycle_t timersp_read(struct clocksource *cs)
 {
-	unsigned long ticks1, ticks2, status;
+	return ~(readl(clksrc_base + TIMER_VALUE) & 0xffff);
+}
 
-	/*
-	 * Get the current number of ticks.  Note that there is a race
-	 * condition between us reading the timer and checking for
-	 * an interrupt.  We get around this by ensuring that the
-	 * counter has not reloaded between our two reads.
-	 */
-	ticks2 = readl(TIMER1_VA_BASE + TIMER_VALUE) & 0xffff;
-	do {
-		ticks1 = ticks2;
-		status = __raw_readl(VA_IC_BASE + IRQ_RAW_STATUS);
-		ticks2 = readl(TIMER1_VA_BASE + TIMER_VALUE) & 0xffff;
-	} while (ticks2 > ticks1);
+static struct clocksource clocksource_timersp = {
+	.name		= "timer2",
+	.rating		= 200,
+	.read		= timersp_read,
+	.mask		= CLOCKSOURCE_MASK(16),
+	.shift		= 16,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
 
-	/*
-	 * Number of ticks since last interrupt.
-	 */
-	ticks1 = timer_reload - ticks2;
+static void integrator_clocksource_init(u32 khz)
+{
+	struct clocksource *cs = &clocksource_timersp;
+	void __iomem *base = clksrc_base;
+	u32 ctrl = TIMER_CTRL_ENABLE;
 
-	/*
-	 * Interrupt pending?  If so, we've reloaded once already.
-	 */
-	if (status & (1 << IRQ_TIMERINT1))
-		ticks1 += timer_reload;
+	if (khz >= 1500) {
+		khz /= 16;
+		ctrl = TIMER_CTRL_DIV16;
+	}
 
-	/*
-	 * Convert the ticks to usecs
-	 */
-	return TICKS2USECS(ticks1);
+	writel(ctrl, base + TIMER_CTRL);
+	writel(0xffff, base + TIMER_LOAD);
+
+	cs->mult = clocksource_khz2mult(khz, cs->shift);
+	clocksource_register(cs);
 }
 
 /*
@@ -308,6 +304,8 @@ void __init integrator_time_init(unsigned long reload, unsigned int ctrl)
 {
 	unsigned int timer_ctrl = TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC;
 
+	integrator_clocksource_init(reload * HZ / 1000);
+
 	timer_reload = reload;
 	timer_ctrl |= ctrl;
 
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 018c32d..cfb718f 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -342,7 +342,6 @@ static void __init ap_init_timer(void)
 
 static struct sys_timer ap_timer = {
 	.init		= ap_init_timer,
-	.offset		= integrator_gettimeoffset,
 };
 
 MACHINE_START(INTEGRATOR, "ARM-Integrator")
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index c66e8fa..3e84732 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -577,7 +577,6 @@ static void __init intcp_timer_init(void)
 
 static struct sys_timer cp_timer = {
 	.init		= intcp_timer_init,
-	.offset		= integrator_gettimeoffset,
 };
 
 MACHINE_START(CINTEGRATOR, "ARM-IntegratorCP")
