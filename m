From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 Jun 2011 15:15:53 +0100
Subject: [PATCH v6 09/14] ARM: msm: use remapped PPI interrupts for local timer
In-Reply-To: <1307110558-29710-1-git-send-email-marc.zyngier@arm.com>
References: <1307110558-29710-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1307110558-29710-10-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the normal interrupt scheme for the local timers by using
a remapped PPI interrupt.

MSM already had a very similar scheme, though still mixing both
GIC-specific and generic APIs.

Fixes and ideas courtesy of Stephen Boyd.

Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Reviewed-and-Tested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-msm/Kconfig                         |    2 +
 arch/arm/mach-msm/board-msm8x60.c                 |   11 ---
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   73 +--------------------
 arch/arm/mach-msm/timer.c                         |   59 +++++++++--------
 4 files changed, 33 insertions(+), 112 deletions(-)

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index 1516896..1ea7d6f 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -42,6 +42,7 @@ config ARCH_MSM8X60
 				  && !MACH_MSM8X60_FFA)
 	select ARCH_MSM_SCORPIONMP
 	select ARM_GIC
+	select ARM_GIC_VPPI
 	select CPU_V7
 	select MSM_V2_TLMM
 	select MSM_GPIOMUX
@@ -52,6 +53,7 @@ config ARCH_MSM8960
 	select ARCH_MSM_SCORPIONMP
 	select MACH_MSM8960_SIM if (!MACH_MSM8960_RUMI3)
 	select ARM_GIC
+	select ARM_GIC_VPPI
 	select CPU_V7
 	select MSM_V2_TLMM
 	select MSM_GPIOMUX
diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
index 1163b6f..d70a2f6 100644
--- a/arch/arm/mach-msm/board-msm8x60.c
+++ b/arch/arm/mach-msm/board-msm8x60.c
@@ -36,8 +36,6 @@ static void __init msm8x60_map_io(void)
 
 static void __init msm8x60_init_irq(void)
 {
-	unsigned int i;
-
 	gic_init(0, GIC_PPI_START, MSM_QGIC_DIST_BASE,
 		 (void *)MSM_QGIC_CPU_BASE);
 
@@ -49,15 +47,6 @@ static void __init msm8x60_init_irq(void)
 	 */
 	if (!machine_is_msm8x60_sim())
 		writel(0x0000FFFF, MSM_QGIC_DIST_BASE + GIC_DIST_ENABLE_SET);
-
-	/* FIXME: Not installing AVS_SVICINT and AVS_SVICINTSWDONE yet
-	 * as they are configured as level, which does not play nice with
-	 * handle_percpu_irq.
-	 */
-	for (i = GIC_PPI_START; i < GIC_SPI_START; i++) {
-		if (i != AVS_SVICINT && i != AVS_SVICINTSWDONE)
-			irq_set_handler(i, handle_percpu_irq);
-	}
 }
 
 static void __init msm8x60_init(void)
diff --git a/arch/arm/mach-msm/include/mach/entry-macro-qgic.S b/arch/arm/mach-msm/include/mach/entry-macro-qgic.S
index 1246715..717076f 100644
--- a/arch/arm/mach-msm/include/mach/entry-macro-qgic.S
+++ b/arch/arm/mach-msm/include/mach/entry-macro-qgic.S
@@ -8,81 +8,10 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <mach/hardware.h>
-#include <asm/hardware/gic.h>
+#include <asm/hardware/entry-macro-gic.S>
 
 	.macro	disable_fiq
 	.endm
 
-	.macro  get_irqnr_preamble, base, tmp
-	ldr	\base, =gic_cpu_base_addr
-	ldr	\base, [\base]
-	.endm
-
 	.macro  arch_ret_to_user, tmp1, tmp2
 	.endm
-
-	/*
-	 * The interrupt numbering scheme is defined in the
-	 * interrupt controller spec.  To wit:
-	 *
-	 * Migrated the code from ARM MP port to be more consistent
-	 * with interrupt processing , the following still holds true
-	 * however, all interrupts are treated the same regardless of
-	 * if they are local IPI or PPI
-	 *
-	 * Interrupts 0-15 are IPI
-	 * 16-31 are PPI
-	 *   (16-18 are the timers)
-	 * 32-1020 are global
-	 * 1021-1022 are reserved
-	 * 1023 is "spurious" (no interrupt)
-	 *
-	 * A simple read from the controller will tell us the number of the
-	 * highest priority enabled interrupt.  We then just need to check
-	 * whether it is in the valid range for an IRQ (0-1020 inclusive).
-	 *
-	 * Base ARM code assumes that the local (private) peripheral interrupts
-	 * are not valid, we treat them differently, in that the privates are
-	 * handled like normal shared interrupts with the exception that only
-	 * one processor can register the interrupt and the handler must be
-	 * the same for all processors.
-	 */
-
-	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-
-	ldr  \irqstat, [\base, #GIC_CPU_INTACK] /* bits 12-10 =srcCPU,
-						   9-0 =int # */
-
-	bic     \irqnr, \irqstat, #0x1c00	@mask src
-	cmp     \irqnr, #15
-	ldr		\tmp, =1021
-	cmpcc	\irqnr, \irqnr
-	cmpne	\irqnr, \tmp
-	cmpcs	\irqnr, \irqnr
-
-	.endm
-
-	/* We assume that irqstat (the raw value of the IRQ acknowledge
-	 * register) is preserved from the macro above.
-	 * If there is an IPI, we immediately signal end of interrupt on the
-	 * controller, since this requires the original irqstat value which
-	 * we won't easily be able to recreate later.
-	 */
-	.macro test_for_ipi, irqnr, irqstat, base, tmp
-    bic \irqnr, \irqstat, #0x1c00
-    cmp \irqnr, #16
-    strcc   \irqstat, [\base, #GIC_CPU_EOI]
-    cmpcs   \irqnr, \irqnr
-	.endm
-
-	/* As above, this assumes that irqstat and base are preserved.. */
-
-	.macro test_for_ltirq, irqnr, irqstat, base, tmp
-    bic \irqnr, \irqstat, #0x1c00
-    mov     \tmp, #0
-    cmp \irqnr, #16
-    moveq   \tmp, #1
-    streq   \irqstat, [\base, #GIC_CPU_EOI]
-    cmp \tmp, #0
-	.endm
diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 38b95e9..b2747cc 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 
 #include <asm/mach/time.h>
+#include <asm/hardware/gic.h>
 #include <mach/msm_iomap.h>
 #include <mach/cpu.h>
 
@@ -67,7 +68,7 @@ enum timer_location {
 struct msm_clock {
 	struct clock_event_device   clockevent;
 	struct clocksource          clocksource;
-	struct irqaction            irq;
+	unsigned int		    irq;
 	void __iomem                *regbase;
 	uint32_t                    freq;
 	uint32_t                    shift;
@@ -83,13 +84,10 @@ enum {
 
 
 static struct msm_clock msm_clocks[];
-static struct clock_event_device *local_clock_event;
 
 static irqreturn_t msm_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = dev_id;
-	if (smp_processor_id() != 0)
-		evt = local_clock_event;
 	if (evt->event_handler == NULL)
 		return IRQ_HANDLED;
 	evt->event_handler(evt);
@@ -140,6 +138,8 @@ static void msm_timer_set_mode(enum clock_event_mode mode,
 		writel(TIMER_ENABLE_EN, clock->regbase + TIMER_ENABLE);
 		break;
 	case CLOCK_EVT_MODE_UNUSED:
+		disable_irq(evt->irq);
+		/* fall through */
 	case CLOCK_EVT_MODE_SHUTDOWN:
 		writel(0, clock->regbase + TIMER_ENABLE);
 		break;
@@ -163,13 +163,7 @@ static struct msm_clock msm_clocks[] = {
 			.mask           = CLOCKSOURCE_MASK(32),
 			.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
 		},
-		.irq = {
-			.name    = "gp_timer",
-			.flags   = IRQF_DISABLED | IRQF_TIMER | IRQF_TRIGGER_RISING,
-			.handler = msm_timer_interrupt,
-			.dev_id  = &msm_clocks[0].clockevent,
-			.irq     = INT_GP_TIMER_EXP
-		},
+		.irq = INT_GP_TIMER_EXP,
 		.freq = GPT_HZ,
 	},
 	[MSM_CLOCK_DGT] = {
@@ -188,13 +182,7 @@ static struct msm_clock msm_clocks[] = {
 			.mask           = CLOCKSOURCE_MASK((32 - MSM_DGT_SHIFT)),
 			.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
 		},
-		.irq = {
-			.name    = "dg_timer",
-			.flags   = IRQF_DISABLED | IRQF_TIMER | IRQF_TRIGGER_RISING,
-			.handler = msm_timer_interrupt,
-			.dev_id  = &msm_clocks[1].clockevent,
-			.irq     = INT_DEBUG_TIMER_EXP
-		},
+		.irq = INT_DEBUG_TIMER_EXP,
 		.freq = DGT_HZ >> MSM_DGT_SHIFT,
 		.shift = MSM_DGT_SHIFT,
 	}
@@ -253,10 +241,13 @@ static void __init msm_timer_init(void)
 			printk(KERN_ERR "msm_timer_init: clocksource_register "
 			       "failed for %s\n", cs->name);
 
-		res = setup_irq(clock->irq.irq, &clock->irq);
+		ce->irq = gic_ppi_to_vppi(clock->irq);
+		res = request_irq(ce->irq, msm_timer_interrupt,
+				  IRQF_TIMER | IRQF_NOBALANCING | IRQF_TRIGGER_RISING,
+				  ce->name, ce);
 		if (res)
-			printk(KERN_ERR "msm_timer_init: setup_irq "
-			       "failed for %s\n", cs->name);
+			pr_err("msm_timer_init: request_irq failed for %s\n",
+			       ce->name);
 
 		clockevents_register_device(ce);
 	}
@@ -265,7 +256,9 @@ static void __init msm_timer_init(void)
 #ifdef CONFIG_SMP
 int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
+	static bool local_timer_inited;
 	struct msm_clock *clock = &msm_clocks[MSM_GLOBAL_TIMER];
+	int res;
 
 	/* Use existing clock_event for cpu 0 */
 	if (!smp_processor_id())
@@ -273,12 +266,7 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
 
 	writel(DGT_CLK_CTL_DIV_4, MSM_TMR_BASE + DGT_CLK_CTL);
 
-	if (!local_clock_event) {
-		writel(0, clock->regbase  + TIMER_ENABLE);
-		writel(0, clock->regbase + TIMER_CLEAR);
-		writel(~0, clock->regbase + TIMER_MATCH_VAL);
-	}
-	evt->irq = clock->irq.irq;
+	evt->irq = gic_ppi_to_vppi(clock->irq);
 	evt->name = "local_timer";
 	evt->features = CLOCK_EVT_FEAT_ONESHOT;
 	evt->rating = clock->clockevent.rating;
@@ -290,9 +278,22 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
 		clockevent_delta2ns(0xf0000000 >> clock->shift, evt);
 	evt->min_delta_ns = clockevent_delta2ns(4, evt);
 
-	local_clock_event = evt;
+	if (!local_timer_inited) {
+		writel(0, clock->regbase  + TIMER_ENABLE);
+		writel(0, clock->regbase + TIMER_CLEAR);
+		writel(~0, clock->regbase + TIMER_MATCH_VAL);
 
-	gic_enable_ppi(clock->irq.irq);
+		res = request_irq(evt->irq, msm_timer_interrupt,
+				  IRQF_TIMER | IRQF_NOBALANCING | IRQF_TRIGGER_RISING,
+				  clock->clockevent.name, evt);
+		if (res) {
+			pr_err("local_timer_setup: request_irq failed for %s\n",
+			       clock->clockevent.name);
+			return res;
+		}
+		local_timer_inited = true;
+	} else
+		enable_irq(evt->irq);
 
 	clockevents_register_device(evt);
 	return 0;
-- 
1.7.0.4
