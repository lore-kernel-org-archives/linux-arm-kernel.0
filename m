From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 20 Apr 2011 20:08:17 +0100
Subject: [RFC PATCH 08/12] ARM: msm: use remapped PPI interrupts for local
	timer
In-Reply-To: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>
References: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1303326501-15664-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the normal interrupt scheme for the local timers by using
a remapped PPI interrupt.

MSM already had a very similar scheme, though still mixing both
GIC-specific and generic APIs.

Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-msm/Kconfig                         |    2 +
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   73 +--------------------
 arch/arm/mach-msm/timer.c                         |   38 ++++++------
 3 files changed, 22 insertions(+), 91 deletions(-)

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
index 38b95e9..68eab51 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 
 #include <asm/mach/time.h>
+#include <asm/hardware/gic.h>
 #include <mach/msm_iomap.h>
 #include <mach/cpu.h>
 
@@ -67,8 +68,8 @@ enum timer_location {
 struct msm_clock {
 	struct clock_event_device   clockevent;
 	struct clocksource          clocksource;
-	struct irqaction            irq;
 	void __iomem                *regbase;
+	unsigned int		    irq;
 	uint32_t                    freq;
 	uint32_t                    shift;
 	void __iomem                *global_counter;
@@ -163,13 +164,7 @@ static struct msm_clock msm_clocks[] = {
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
@@ -188,13 +183,7 @@ static struct msm_clock msm_clocks[] = {
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
@@ -232,6 +221,7 @@ static void __init msm_timer_init(void)
 		struct msm_clock *clock = &msm_clocks[i];
 		struct clock_event_device *ce = &clock->clockevent;
 		struct clocksource *cs = &clock->clocksource;
+		int irq;
 
 		clock->local_counter = clock->regbase + TIMER_COUNT_VAL;
 		clock->global_counter = clock->local_counter + global_offset;
@@ -253,10 +243,13 @@ static void __init msm_timer_init(void)
 			printk(KERN_ERR "msm_timer_init: clocksource_register "
 			       "failed for %s\n", cs->name);
 
-		res = setup_irq(clock->irq.irq, &clock->irq);
+		irq = gic_ppi_to_vppi(clock->irq);
+		res = request_irq(irq, msm_timer_interrupt,
+				  IRQF_TIMER | IRQF_NOBALANCING | IRQF_TRIGGER_RISING,
+				  clock->name, &clock->clockevent);
 		if (res)
-			printk(KERN_ERR "msm_timer_init: setup_irq "
-			       "failed for %s\n", cs->name);
+			pr_err("msm_timer_init: request_irq failed for %s\n",
+			       clock->name);
 
 		clockevents_register_device(ce);
 	}
@@ -292,7 +285,14 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
 
 	local_clock_event = evt;
 
-	gic_enable_ppi(clock->irq.irq);
+	res = request_irq(gic_ppi_to_vppi(irq), msm_timer_interrupt,
+			  IRQF_TIMER | IRQF_NOBALANCING | IRQF_TRIGGER_RISING,
+			  clock->name, &clock->clockevent);
+	if (res) {
+		pr_err("local_timer_setup: request_irq failed for %s\n",
+		       clock->name);
+		return err;
+	}
 
 	clockevents_register_device(evt);
 	return 0;
-- 
1.7.0.4
