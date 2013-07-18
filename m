From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu, 18 Jul 2013 22:35:00 +0400
Subject: [PATCH 09/10] ARM: clps711x: Migrate CLPS711X subarch to the new
 basic drivers
In-Reply-To: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
Message-ID: <1374172501-26796-10-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch remove old code and migrate Cirrus Logic CLPS711X subarch
to the new basic drivers: clk, clocksource, irqchip and cpuidle.
This change brings this subarch for use in multiplatform build.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/board-autcpu12.c |   3 -
 arch/arm/mach-clps711x/board-cdb89712.c |   3 -
 arch/arm/mach-clps711x/board-clep7312.c |   3 -
 arch/arm/mach-clps711x/board-edb7211.c  |   3 -
 arch/arm/mach-clps711x/board-p720t.c    |   3 -
 arch/arm/mach-clps711x/common.c         | 345 +-------------------------------
 arch/arm/mach-clps711x/common.h         |   3 -
 arch/arm/mach-clps711x/devices.c        |  10 +
 8 files changed, 16 insertions(+), 357 deletions(-)

diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
index f8d71a8..b1c77ad 100644
--- a/arch/arm/mach-clps711x/board-autcpu12.c
+++ b/arch/arm/mach-clps711x/board-autcpu12.c
@@ -265,14 +265,11 @@ static void __init autcpu12_init_late(void)
 MACHINE_START(AUTCPU12, "autronix autcpu12")
 	/* Maintainer: Thomas Gleixner */
 	.atag_offset	= 0x20000,
-	.nr_irqs	= CLPS711X_NR_IRQS,
 	.map_io		= clps711x_map_io,
-	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.init_machine	= autcpu12_init,
 	.init_late	= autcpu12_init_late,
-	.handle_irq	= clps711x_handle_irq,
 	.restart	= clps711x_restart,
 MACHINE_END
 
diff --git a/arch/arm/mach-clps711x/board-cdb89712.c b/arch/arm/mach-clps711x/board-cdb89712.c
index a9e38c6..1ec378c 100644
--- a/arch/arm/mach-clps711x/board-cdb89712.c
+++ b/arch/arm/mach-clps711x/board-cdb89712.c
@@ -139,12 +139,9 @@ static void __init cdb89712_init(void)
 MACHINE_START(CDB89712, "Cirrus-CDB89712")
 	/* Maintainer: Ray Lehtiniemi */
 	.atag_offset	= 0x100,
-	.nr_irqs	= CLPS711X_NR_IRQS,
 	.map_io		= clps711x_map_io,
-	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.init_machine	= cdb89712_init,
-	.handle_irq	= clps711x_handle_irq,
 	.restart	= clps711x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/board-clep7312.c b/arch/arm/mach-clps711x/board-clep7312.c
index b476424..1f3b403 100644
--- a/arch/arm/mach-clps711x/board-clep7312.c
+++ b/arch/arm/mach-clps711x/board-clep7312.c
@@ -36,12 +36,9 @@ fixup_clep7312(struct tag *tags, char **cmdline, struct meminfo *mi)
 MACHINE_START(CLEP7212, "Cirrus Logic 7212/7312")
 	/* Maintainer: Nobody */
 	.atag_offset	= 0x0100,
-	.nr_irqs	= CLPS711X_NR_IRQS,
 	.fixup		= fixup_clep7312,
 	.map_io		= clps711x_map_io,
-	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
-	.handle_irq	= clps711x_handle_irq,
 	.restart	= clps711x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/board-edb7211.c b/arch/arm/mach-clps711x/board-edb7211.c
index fe6184e..fa4580f 100644
--- a/arch/arm/mach-clps711x/board-edb7211.c
+++ b/arch/arm/mach-clps711x/board-edb7211.c
@@ -177,15 +177,12 @@ static void __init edb7211_init_late(void)
 MACHINE_START(EDB7211, "CL-EDB7211 (EP7211 eval board)")
 	/* Maintainer: Jon McClintock */
 	.atag_offset	= VIDEORAM_SIZE + 0x100,
-	.nr_irqs	= CLPS711X_NR_IRQS,
 	.fixup		= fixup_edb7211,
 	.reserve	= edb7211_reserve,
 	.map_io		= clps711x_map_io,
-	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.init_machine	= edb7211_init,
 	.init_late	= edb7211_init_late,
-	.handle_irq	= clps711x_handle_irq,
 	.restart	= clps711x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/board-p720t.c b/arch/arm/mach-clps711x/board-p720t.c
index dd81b06..4a2ec28 100644
--- a/arch/arm/mach-clps711x/board-p720t.c
+++ b/arch/arm/mach-clps711x/board-p720t.c
@@ -363,14 +363,11 @@ static void __init p720t_init_late(void)
 MACHINE_START(P720T, "ARM-Prospector720T")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.atag_offset	= 0x100,
-	.nr_irqs	= CLPS711X_NR_IRQS,
 	.fixup		= fixup_p720t,
 	.map_io		= clps711x_map_io,
-	.init_early	= clps711x_init_early,
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.init_machine	= p720t_init,
 	.init_late	= p720t_init_late,
-	.handle_irq	= clps711x_handle_irq,
 	.restart	= clps711x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index 4ca2f3c..d226609 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -22,26 +22,14 @@
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/sizes.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/clk.h>
-#include <linux/clkdev.h>
-#include <linux/clockchips.h>
 #include <linux/clocksource.h>
 #include <linux/clk-provider.h>
 
-#include <asm/exception.h>
-#include <asm/mach/irq.h>
 #include <asm/mach/map.h>
-#include <asm/mach/time.h>
-#include <asm/sched_clock.h>
 #include <asm/system_misc.h>
 
 #include <mach/hardware.h>
 
-static struct clk *clk_pll, *clk_bus, *clk_uart, *clk_timerl, *clk_timerh,
-		  *clk_tint, *clk_spi;
-
 /*
  * This maps the generic CLPS711x registers
  */
@@ -59,344 +47,23 @@ void __init clps711x_map_io(void)
 	iotable_init(clps711x_io_desc, ARRAY_SIZE(clps711x_io_desc));
 }
 
-static void int1_mask(struct irq_data *d)
-{
-	u32 intmr1;
-
-	intmr1 = clps_readl(INTMR1);
-	intmr1 &= ~(1 << d->irq);
-	clps_writel(intmr1, INTMR1);
-}
-
-static void int1_eoi(struct irq_data *d)
-{
-	switch (d->irq) {
-	case IRQ_CSINT:  clps_writel(0, COEOI);  break;
-	case IRQ_TC1OI:  clps_writel(0, TC1EOI); break;
-	case IRQ_TC2OI:  clps_writel(0, TC2EOI); break;
-	case IRQ_RTCMI:  clps_writel(0, RTCEOI); break;
-	case IRQ_TINT:   clps_writel(0, TEOI);   break;
-	case IRQ_UMSINT: clps_writel(0, UMSEOI); break;
-	}
-}
-
-static void int1_unmask(struct irq_data *d)
-{
-	u32 intmr1;
-
-	intmr1 = clps_readl(INTMR1);
-	intmr1 |= 1 << d->irq;
-	clps_writel(intmr1, INTMR1);
-}
-
-static struct irq_chip int1_chip = {
-	.name		= "Interrupt Vector 1",
-	.irq_eoi	= int1_eoi,
-	.irq_mask	= int1_mask,
-	.irq_unmask	= int1_unmask,
-};
-
-static void int2_mask(struct irq_data *d)
-{
-	u32 intmr2;
-
-	intmr2 = clps_readl(INTMR2);
-	intmr2 &= ~(1 << (d->irq - 16));
-	clps_writel(intmr2, INTMR2);
-}
-
-static void int2_eoi(struct irq_data *d)
-{
-	switch (d->irq) {
-	case IRQ_KBDINT: clps_writel(0, KBDEOI); break;
-	}
-}
-
-static void int2_unmask(struct irq_data *d)
-{
-	u32 intmr2;
-
-	intmr2 = clps_readl(INTMR2);
-	intmr2 |= 1 << (d->irq - 16);
-	clps_writel(intmr2, INTMR2);
-}
-
-static struct irq_chip int2_chip = {
-	.name		= "Interrupt Vector 2",
-	.irq_eoi	= int2_eoi,
-	.irq_mask	= int2_mask,
-	.irq_unmask	= int2_unmask,
-};
-
-static void int3_mask(struct irq_data *d)
-{
-	u32 intmr3;
-
-	intmr3 = clps_readl(INTMR3);
-	intmr3 &= ~(1 << (d->irq - 32));
-	clps_writel(intmr3, INTMR3);
-}
-
-static void int3_unmask(struct irq_data *d)
-{
-	u32 intmr3;
-
-	intmr3 = clps_readl(INTMR3);
-	intmr3 |= 1 << (d->irq - 32);
-	clps_writel(intmr3, INTMR3);
-}
-
-static struct irq_chip int3_chip = {
-	.name		= "Interrupt Vector 3",
-	.irq_mask	= int3_mask,
-	.irq_unmask	= int3_unmask,
-};
-
-static struct {
-	int			nr;
-	struct irq_chip		*chip;
-	irq_flow_handler_t	handle;
-} clps711x_irqdescs[] __initdata = {
-	{ IRQ_CSINT,	&int1_chip,	handle_fasteoi_irq,	},
-	{ IRQ_EINT1,	&int1_chip,	handle_level_irq,	},
-	{ IRQ_EINT2,	&int1_chip,	handle_level_irq,	},
-	{ IRQ_EINT3,	&int1_chip,	handle_level_irq,	},
-	{ IRQ_TC1OI,	&int1_chip,	handle_fasteoi_irq,	},
-	{ IRQ_TC2OI,	&int1_chip,	handle_fasteoi_irq,	},
-	{ IRQ_RTCMI,	&int1_chip,	handle_fasteoi_irq,	},
-	{ IRQ_TINT,	&int1_chip,	handle_fasteoi_irq,	},
-	{ IRQ_UTXINT1,	&int1_chip,	handle_level_irq,	},
-	{ IRQ_URXINT1,	&int1_chip,	handle_level_irq,	},
-	{ IRQ_UMSINT,	&int1_chip,	handle_fasteoi_irq,	},
-	{ IRQ_SSEOTI,	&int1_chip,	handle_level_irq,	},
-	{ IRQ_KBDINT,	&int2_chip,	handle_fasteoi_irq,	},
-	{ IRQ_SS2RX,	&int2_chip,	handle_level_irq,	},
-	{ IRQ_SS2TX,	&int2_chip,	handle_level_irq,	},
-	{ IRQ_UTXINT2,	&int2_chip,	handle_level_irq,	},
-	{ IRQ_URXINT2,	&int2_chip,	handle_level_irq,	},
-};
-
 void __init clps711x_init_irq(void)
 {
-	unsigned int i;
-
-	/* Disable interrupts */
-	clps_writel(0, INTMR1);
-	clps_writel(0, INTMR2);
-	clps_writel(0, INTMR3);
-
-	/* Clear down any pending interrupts */
-	clps_writel(0, BLEOI);
-	clps_writel(0, MCEOI);
-	clps_writel(0, COEOI);
-	clps_writel(0, TC1EOI);
-	clps_writel(0, TC2EOI);
-	clps_writel(0, RTCEOI);
-	clps_writel(0, TEOI);
-	clps_writel(0, UMSEOI);
-	clps_writel(0, KBDEOI);
-	clps_writel(0, SRXEOF);
-	clps_writel(0xffffffff, DAISR);
-
-	for (i = 0; i < ARRAY_SIZE(clps711x_irqdescs); i++) {
-		irq_set_chip_and_handler(clps711x_irqdescs[i].nr,
-					 clps711x_irqdescs[i].chip,
-					 clps711x_irqdescs[i].handle);
-		set_irq_flags(clps711x_irqdescs[i].nr,
-			      IRQF_VALID | IRQF_PROBE);
-	}
-
-	if (IS_ENABLED(CONFIG_FIQ)) {
-		init_FIQ(0);
-		irq_set_chip_and_handler(IRQ_DAIINT, &int3_chip,
-					 handle_bad_irq);
-		set_irq_flags(IRQ_DAIINT,
-			      IRQF_VALID | IRQF_PROBE | IRQF_NOAUTOEN);
-	}
-}
-
-static inline u32 fls16(u32 x)
-{
-	u32 r = 15;
+	extern void clps711x_intc_init(phys_addr_t);
 
-	if (!(x & 0xff00)) {
-		x <<= 8;
-		r -= 8;
-	}
-	if (!(x & 0xf000)) {
-		x <<= 4;
-		r -= 4;
-	}
-	if (!(x & 0xc000)) {
-		x <<= 2;
-		r -= 2;
-	}
-	if (!(x & 0x8000))
-		r--;
-
-	return r;
-}
-
-asmlinkage void __exception_irq_entry clps711x_handle_irq(struct pt_regs *regs)
-{
-	do {
-		u32 irqstat;
-		void __iomem *base = CLPS711X_VIRT_BASE;
-
-		irqstat = readw_relaxed(base + INTSR1) &
-			  readw_relaxed(base + INTMR1);
-		if (irqstat)
-			handle_IRQ(fls16(irqstat), regs);
-
-		irqstat = readw_relaxed(base + INTSR2) &
-			  readw_relaxed(base + INTMR2);
-		if (irqstat) {
-			handle_IRQ(fls16(irqstat) + 16, regs);
-			continue;
-		}
-
-		break;
-	} while (1);
-}
-
-static u32 notrace clps711x_sched_clock_read(void)
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
+	clps711x_intc_init(CLPS711X_PHYS_BASE);
 }
 
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
+	extern void clps711x_clk_init(phys_addr_t);
+	extern void clps711x_clksrc_init(phys_addr_t, int);
 
-	/* Start Timer1 in free running mode (Low frequency) */
-	tmp = clps_readl(SYSCON1) & ~(SYSCON1_TC1S | SYSCON1_TC1M);
-	clps_writel(tmp, SYSCON1);
-
-	setup_sched_clock(clps711x_sched_clock_read, 16, timl);
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
+	clps711x_clk_init(CLPS711X_PHYS_BASE);
+	clps711x_clksrc_init(CLPS711X_PHYS_BASE, IRQ_TC2OI);
 }
 
 void clps711x_restart(enum reboot_mode mode, const char *cmd)
 {
 	soft_restart(0);
 }
-
-static void clps711x_idle(void)
-{
-	clps_writel(1, HALT);
-	asm("mov r0, r0");
-	asm("mov r0, r0");
-}
-
-void __init clps711x_init_early(void)
-{
-	arm_pm_idle = clps711x_idle;
-}
diff --git a/arch/arm/mach-clps711x/common.h b/arch/arm/mach-clps711x/common.h
index 9a6767b..77f3130 100644
--- a/arch/arm/mach-clps711x/common.h
+++ b/arch/arm/mach-clps711x/common.h
@@ -6,13 +6,10 @@
 
 #include <linux/reboot.h>
 
-#define CLPS711X_NR_IRQS	(33)
 #define CLPS711X_NR_GPIO	(4 * 8 + 3)
 #define CLPS711X_GPIO(prt, bit)	((prt) * 8 + (bit))
 
 extern void clps711x_map_io(void);
 extern void clps711x_init_irq(void);
 extern void clps711x_timer_init(void);
-extern void clps711x_handle_irq(struct pt_regs *regs);
 extern void clps711x_restart(enum reboot_mode mode, const char *cmd);
-extern void clps711x_init_early(void);
diff --git a/arch/arm/mach-clps711x/devices.c b/arch/arm/mach-clps711x/devices.c
index fb77d14..aa24dc4 100644
--- a/arch/arm/mach-clps711x/devices.c
+++ b/arch/arm/mach-clps711x/devices.c
@@ -14,6 +14,15 @@
 
 #include <mach/hardware.h>
 
+static const struct resource clps711x_cpuidle_res __initconst =
+	DEFINE_RES_MEM(CLPS711X_PHYS_BASE + HALT, SZ_4);
+
+static void __init clps711x_add_cpuidle(void)
+{
+	platform_device_register_simple("clps711x-cpuidle", PLATFORM_DEVID_NONE,
+					&clps711x_cpuidle_res, 1);
+}
+
 static const phys_addr_t clps711x_gpios[][2] __initconst = {
 	{ PADR, PADDR },
 	{ PBDR, PBDDR },
@@ -63,6 +72,7 @@ static void __init clps711x_add_syscon(void)
 
 void __init clps711x_devices_init(void)
 {
+	clps711x_add_cpuidle();
 	clps711x_add_gpio();
 	clps711x_add_syscon();
 }
-- 
1.8.1.5
