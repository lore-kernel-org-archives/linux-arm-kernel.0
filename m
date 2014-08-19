From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 19 Aug 2014 16:31:13 +0400
Subject: [PATCH 1/3] ARM: clps711x: Switch CLPS711X subarch to use clk and
 clocksource driver
Message-ID: <1408451475-1140-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes old support for clk and clocksource support and
switches platform to use new drivers.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/common.c | 138 ++--------------------------------------
 arch/arm/mach-clps711x/common.h |   5 ++
 2 files changed, 9 insertions(+), 134 deletions(-)

diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index 2a6323b..671acc5a 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -19,29 +19,17 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-#include <linux/io.h>
+
 #include <linux/init.h>
 #include <linux/sizes.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/clk.h>
-#include <linux/clkdev.h>
-#include <linux/clockchips.h>
-#include <linux/clocksource.h>
-#include <linux/clk-provider.h>
-#include <linux/sched_clock.h>
 
 #include <asm/mach/map.h>
-#include <asm/mach/time.h>
 #include <asm/system_misc.h>
 
 #include <mach/hardware.h>
 
 #include "common.h"
 
-static struct clk *clk_pll, *clk_bus, *clk_uart, *clk_timerl, *clk_timerh,
-		  *clk_tint, *clk_spi;
-
 /*
  * This maps the generic CLPS711x registers
  */
@@ -64,129 +52,11 @@ void __init clps711x_init_irq(void)
 	clps711x_intc_init(CLPS711X_PHYS_BASE, SZ_16K);
 }
 
-static u64 notrace clps711x_sched_clock_read(void)
-{
-	return ~readw_relaxed(CLPS711X_VIRT_BASE + TC1D);
-}
-
-static void clps711x_clockevent_set_mode(enum clock_event_mode mode,
-					 struct clock_event_device *evt)
-{
-	disable_irq(IRQ_TC2OI);
-
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		enable_irq(IRQ_TC2OI);
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* Not supported */
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_RESUME:
-		/* Left event sources disabled, no more interrupts appear */
-		break;
-	}
-}
-
-static struct clock_event_device clockevent_clps711x = {
-	.name		= "clps711x-clockevent",
-	.rating		= 300,
-	.features	= CLOCK_EVT_FEAT_PERIODIC,
-	.set_mode	= clps711x_clockevent_set_mode,
-};
-
-static irqreturn_t clps711x_timer_interrupt(int irq, void *dev_id)
-{
-	clockevent_clps711x.event_handler(&clockevent_clps711x);
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction clps711x_timer_irq = {
-	.name		= "clps711x-timer",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= clps711x_timer_interrupt,
-};
-
-static void add_fixed_clk(struct clk *clk, const char *name, int rate)
-{
-	clk = clk_register_fixed_rate(NULL, name, NULL, CLK_IS_ROOT, rate);
-	clk_register_clkdev(clk, name, NULL);
-}
-
 void __init clps711x_timer_init(void)
 {
-	int osc, ext, pll, cpu, bus, timl, timh, uart, spi;
-	u32 tmp;
-
-	osc = 3686400;
-	ext = 13000000;
-
-	tmp = clps_readl(PLLR) >> 24;
-	if (tmp)
-		pll = (osc * tmp) / 2;
-	else
-		pll = 73728000; /* Default value */
-
-	tmp = clps_readl(SYSFLG2);
-	if (tmp & SYSFLG2_CKMODE) {
-		cpu = ext;
-		bus = cpu;
-		spi = 135400;
-		pll = 0;
-	} else {
-		cpu = pll;
-		if (cpu >= 36864000)
-			bus = cpu / 2;
-		else
-			bus = 36864000 / 2;
-		spi = cpu / 576;
-	}
-
-	uart = bus / 10;
-
-	if (tmp & SYSFLG2_CKMODE) {
-		tmp = clps_readl(SYSCON2);
-		if (tmp & SYSCON2_OSTB)
-			timh = ext / 26;
-		else
-			timh = 541440;
-	} else
-		timh = DIV_ROUND_CLOSEST(cpu, 144);
-
-	timl = DIV_ROUND_CLOSEST(timh, 256);
-
-	/* All clocks are fixed */
-	add_fixed_clk(clk_pll, "pll", pll);
-	add_fixed_clk(clk_bus, "bus", bus);
-	add_fixed_clk(clk_uart, "uart", uart);
-	add_fixed_clk(clk_timerl, "timer_lf", timl);
-	add_fixed_clk(clk_timerh, "timer_hf", timh);
-	add_fixed_clk(clk_tint, "tint", 64);
-	add_fixed_clk(clk_spi, "spi", spi);
-
-	pr_info("CPU frequency set at %i Hz.\n", cpu);
-
-	/* Start Timer1 in free running mode (Low frequency) */
-	tmp = clps_readl(SYSCON1) & ~(SYSCON1_TC1S | SYSCON1_TC1M);
-	clps_writel(tmp, SYSCON1);
-
-	sched_clock_register(clps711x_sched_clock_read, 16, timl);
-
-	clocksource_mmio_init(CLPS711X_VIRT_BASE + TC1D,
-			      "clps711x_clocksource", timl, 300, 16,
-			      clocksource_mmio_readw_down);
-
-	/* Set Timer2 prescaler */
-	clps_writew(DIV_ROUND_CLOSEST(timh, HZ), TC2D);
-
-	/* Start Timer2 in prescale mode (High frequency)*/
-	tmp = clps_readl(SYSCON1) | SYSCON1_TC2M | SYSCON1_TC2S;
-	clps_writel(tmp, SYSCON1);
-
-	clockevents_config_and_register(&clockevent_clps711x, timh, 0, 0);
-
-	setup_irq(IRQ_TC2OI, &clps711x_timer_irq);
+	clps711x_clk_init(CLPS711X_VIRT_BASE);
+	clps711x_clksrc_init(CLPS711X_VIRT_BASE + TC1D,
+			     CLPS711X_VIRT_BASE + TC2D, IRQ_TC2OI);
 }
 
 void clps711x_restart(enum reboot_mode mode, const char *cmd)
diff --git a/arch/arm/mach-clps711x/common.h b/arch/arm/mach-clps711x/common.h
index f881899..370200b 100644
--- a/arch/arm/mach-clps711x/common.h
+++ b/arch/arm/mach-clps711x/common.h
@@ -16,3 +16,8 @@ extern void clps711x_restart(enum reboot_mode mode, const char *cmd);
 
 /* drivers/irqchip/irq-clps711x.c */
 void clps711x_intc_init(phys_addr_t, resource_size_t);
+/* drivers/clk/clk-clps711x.c */
+void clps711x_clk_init(void __iomem *base);
+/* drivers/clocksource/clps711x-timer.c */
+void clps711x_clksrc_init(void __iomem *tc1_base, void __iomem *tc2_base,
+			  unsigned int irq);
-- 
1.8.5.5
