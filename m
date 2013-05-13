From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 13 May 2013 21:07:32 +0400
Subject: [PATCH 10/15] ARM: clps711x: Add clocksource framework
In-Reply-To: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
References: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
Message-ID: <1368464857-5038-13-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/Kconfig                |  1 +
 arch/arm/mach-clps711x/common.c | 48 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 10cdfa9..2af27f7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -367,6 +367,7 @@ config ARCH_CLPS711X
 	select ARCH_REQUIRE_GPIOLIB
 	select AUTO_ZRELADDR
 	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
 	select COMMON_CLK
 	select CPU_ARM720T
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index 768d41c6..bd65839 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -27,12 +27,14 @@
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/clockchips.h>
+#include <linux/clocksource.h>
 #include <linux/clk-provider.h>
 
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
+#include <asm/sched_clock.h>
 #include <asm/system_misc.h>
 
 #include <mach/hardware.h>
@@ -251,13 +253,32 @@ asmlinkage void __exception_irq_entry clps711x_handle_irq(struct pt_regs *regs)
 		handle_IRQ(fls16(irqstat) + 16, regs);
 }
 
+static u32 notrace clps711x_sched_clock_read(void)
+{
+	return ~readw_relaxed(CLPS711X_VIRT_BASE + TC1D);
+}
+
 static void clps711x_clockevent_set_mode(enum clock_event_mode mode,
 					 struct clock_event_device *evt)
 {
+	disable_irq(IRQ_TC2OI);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		enable_irq(IRQ_TC2OI);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		/* Not supported */
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_RESUME:
+		/* Left event sources disabled, no more interrupts appear */
+		break;
+	}
 }
 
 static struct clock_event_device clockevent_clps711x = {
-	.name		= "CLPS711x Clockevents",
+	.name		= "clps711x-clockevent",
 	.rating		= 300,
 	.features	= CLOCK_EVT_FEAT_PERIODIC,
 	.set_mode	= clps711x_clockevent_set_mode,
@@ -271,8 +292,8 @@ static irqreturn_t clps711x_timer_interrupt(int irq, void *dev_id)
 }
 
 static struct irqaction clps711x_timer_irq = {
-	.name		= "CLPS711x Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.name		= "clps711x-timer",
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
 	.handler	= clps711x_timer_interrupt,
 };
 
@@ -320,9 +341,9 @@ void __init clps711x_timer_init(void)
 		else
 			timh = 541440;
 	} else
-		timh = cpu / 144;
+		timh = DIV_ROUND_CLOSEST(cpu, 144);
 
-	timl = timh / 256;
+	timl = DIV_ROUND_CLOSEST(timh, 256);
 
 	/* All clocks are fixed */
 	add_fixed_clk(clk_pll, "pll", pll);
@@ -335,13 +356,24 @@ void __init clps711x_timer_init(void)
 
 	pr_info("CPU frequency set at %i Hz.\n", cpu);
 
+	/* Start Timer1 in free running mode (Low frequency) */
+	tmp = clps_readl(SYSCON1) & ~(SYSCON1_TC1S | SYSCON1_TC1M);
+	clps_writel(tmp, SYSCON1);
+
+	setup_sched_clock(clps711x_sched_clock_read, 16, timl);
+
+	clocksource_mmio_init(CLPS711X_VIRT_BASE + TC1D,
+			      "clps711x_clocksource", timl, 300, 16,
+			      clocksource_mmio_readw_down);
+
+	/* Set Timer2 prescaler */
 	clps_writew(DIV_ROUND_CLOSEST(timh, HZ), TC2D);
 
-	tmp = clps_readl(SYSCON1);
-	tmp |= SYSCON1_TC2S | SYSCON1_TC2M;
+	/* Start Timer2 in prescale mode (High frequency)*/
+	tmp = clps_readl(SYSCON1) | SYSCON1_TC2M | SYSCON1_TC2S;
 	clps_writel(tmp, SYSCON1);
 
-	clockevents_config_and_register(&clockevent_clps711x, timh, 1, 0xffff);
+	clockevents_config_and_register(&clockevent_clps711x, timh, 0, 0);
 
 	setup_irq(IRQ_TC2OI, &clps711x_timer_irq);
 }
-- 
1.8.1.5
