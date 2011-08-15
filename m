From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Aug 2011 13:13:12 +0100
Subject: [PATCH v11 0/4] Consolidating GIC per-cpu interrupts
In-Reply-To: <1312883802-15022-1-git-send-email-marc.zyngier@arm.com>
References: <1312883802-15022-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110815121312.GF26827@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

Could you _please_ look Marcs patch series and give an opinion on it.
I've also attached my patch to this reply too, which is an alternative
approach to Marcs.

On Tue, Aug 09, 2011 at 10:56:38AM +0100, Marc Zyngier wrote:
> The current GIC per-cpu interrupts (aka PPIs) suffer from a number of
> problems:
> 
> - They use a completely separate scheme to handle the interrupts,
>   mostly because the PPI concept doesn't really match the kernel view
>   of an interrupt.
> - PPIs can only be used by the timer code, unless we add more low-level
>   assembly code.
> - The local timer code can only be used by devices generating PPIs,
>   and not SPIs.
> - At least one platform (msm) has started implementing its own
>   alternative scheme.
> - Some low-level code gets duplicated, as usual...
> 
> As the previous solution which tried to map PPIs to normal interrupts
> has been proved to be buggy, I've opted to a much simpler scheme
> (based on Russell's input).
> 
> The proposed solution is to handle the interrupt using the same path
> as SPIs, with a common handler for all PPIs. Each PPI can be requested
> using gic_request_ppi(), similar to request_irq(). The local timer
> code is updated to reflect these changes.
> 
> Patches against v3.1-rc1 + Will Deacon's TWD patch ("ARM: twd:
> register clockevents device before enabling PPI"). Tested on PB11MP,
> VE, OMAP4 (Panda) and Tegra (Harmony). As this patch series is quite
> different from the previous one, I've dropped all previous acks from
> platform maintainers.
> 
> >From v10:
> - Fixed exynos4 compilation
> 
> >From v9:
> - Fixed PPI request in the MSM timer code
> - Fixed UP/non-local-timer build
> - Moved some bits and pieces from patch 1 to patch 2
> 
> Marc Zyngier (4):
>   ARM: gic: consolidate PPI handling
>   ARM: gic: Add PPI registration interface
>   ARM: local timers: drop local_timer_ack()
>   ARM: gic: add compute_irqnr macro for exynos4
> 
>  arch/arm/common/gic.c                             |  153 +++++++++++++++++++--
>  arch/arm/include/asm/entry-macro-multi.S          |    7 -
>  arch/arm/include/asm/hardirq.h                    |    3 -
>  arch/arm/include/asm/hardware/entry-macro-gic.S   |   22 +---
>  arch/arm/include/asm/hardware/gic.h               |    5 +-
>  arch/arm/include/asm/localtimer.h                 |   19 ++--
>  arch/arm/include/asm/smp.h                        |    5 -
>  arch/arm/include/asm/smp_twd.h                    |    2 +-
>  arch/arm/kernel/irq.c                             |    3 -
>  arch/arm/kernel/smp.c                             |   33 +-----
>  arch/arm/kernel/smp_twd.c                         |   30 +++--
>  arch/arm/mach-exynos4/include/mach/entry-macro.S  |   67 +--------
>  arch/arm/mach-exynos4/mct.c                       |    6 -
>  arch/arm/mach-msm/board-msm8x60.c                 |   11 --
>  arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   73 +----------
>  arch/arm/mach-msm/timer.c                         |   56 ++++----
>  arch/arm/mach-omap2/include/mach/entry-macro.S    |   14 +--
>  arch/arm/mach-shmobile/entry-intc.S               |    3 -
>  arch/arm/mach-shmobile/include/mach/entry-macro.S |    3 -
>  19 files changed, 214 insertions(+), 301 deletions(-)
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
 arch/arm/common/gic.c                             |   70 ++++++++++++++++++++-
 arch/arm/include/asm/entry-macro-multi.S          |    5 +-
 arch/arm/include/asm/hardware/entry-macro-gic.S   |   17 +++--
 arch/arm/include/asm/hardware/gic.h               |    5 +-
 arch/arm/include/asm/localtimer.h                 |   14 +----
 arch/arm/include/asm/smp_twd.h                    |    2 +-
 arch/arm/kernel/smp.c                             |   18 +-----
 arch/arm/kernel/smp_twd.c                         |   41 +++++++-----
 arch/arm/mach-exynos4/include/mach/entry-macro.S  |    8 +-
 arch/arm/mach-msm/include/mach/entry-macro-qgic.S |   14 ++--
 arch/arm/mach-msm/timer.c                         |   20 +++++-
 arch/arm/mach-omap2/include/mach/entry-macro.S    |    9 +--
 arch/arm/mach-shmobile/entry-intc.S               |    2 +-
 arch/arm/mach-shmobile/include/mach/entry-macro.S |    2 +-
 14 files changed, 144 insertions(+), 83 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 4ddd0a6..148367d 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -27,12 +27,16 @@
 #include <linux/list.h>
 #include <linux/smp.h>
 #include <linux/cpumask.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 #include <asm/hardware/gic.h>
 
+#define GIC_FIRST_PPI	16
+#define NR_PPI		16
+
 static DEFINE_SPINLOCK(irq_controller_lock);
 
 /* Address of GIC 0 CPU interface */
@@ -376,14 +380,74 @@ void __cpuinit gic_secondary_init(unsigned int gic_nr)
 	gic_cpu_init(&gic_data[gic_nr]);
 }
 
-void __cpuinit gic_enable_ppi(unsigned int irq)
+struct gic_action {
+	irq_handler_t handler;
+	void *data;
+};
+
+static DEFINE_PER_CPU(struct gic_action[NR_PPI], gic_ppi_action);
+
+asmlinkage void __exception_irq_entry gic_call_ppi(unsigned int irq,
+	struct pt_regs *regs)
+{
+	unsigned int ppi = irq - GIC_FIRST_PPI;
+	struct gic_action *act;
+
+	act = &__get_cpu_var(gic_ppi_action)[ppi];
+	if (act->handler) {
+		struct pt_regs *old_regs = set_irq_regs(regs);
+
+		/* FIXME: need to deal with PPI IRQ stats better.. */
+		__inc_irq_stat(smp_processor_id(), local_timer_irqs);
+
+		irq_enter();
+		act->handler(irq, act->data);
+		irq_exit();
+
+		set_irq_regs(old_regs);
+	}
+}
+
+int gic_request_ppi(unsigned int irq, irq_handler_t handler, void *data)
 {
+	struct gic_action *act;
 	unsigned long flags;
+	unsigned int ppi = irq - GIC_FIRST_PPI;
+	int ret = -EBUSY;
+
+	if (ppi >= NR_PPI)
+		return -EINVAL;
 
 	local_irq_save(flags);
-	irq_set_status_flags(irq, IRQ_NOPROBE);
-	gic_unmask_irq(irq_get_irq_data(irq));
+	act = &__get_cpu_var(gic_ppi_action)[ppi];
+	if (!act->handler) {
+		act->handler = handler;
+		act->data = data;
+
+		irq_set_status_flags(irq, IRQ_NOPROBE);
+		gic_unmask_irq(irq_get_irq_data(irq));
+	}
 	local_irq_restore(flags);
+
+	return ret;
+}
+
+void gic_free_ppi(unsigned int irq, void *data)
+{
+	struct gic_action *act;
+	unsigned long flags;
+	unsigned int ppi = irq - GIC_FIRST_PPI;
+
+	if (ppi < NR_PPI) {
+		local_irq_save(flags);
+		act = &__get_cpu_var(gic_ppi_action)[ppi];
+		if (act->data == data) {
+			gic_mask_irq(irq_get_irq_data(irq));
+			act->handler = NULL;
+			act->data = NULL;
+		}
+		local_irq_restore(flags);
+	}
 }
 
 #ifdef CONFIG_SMP
diff --git a/arch/arm/include/asm/entry-macro-multi.S b/arch/arm/include/asm/entry-macro-multi.S
index 2f1e209..f1ee1e6 100644
--- a/arch/arm/include/asm/entry-macro-multi.S
+++ b/arch/arm/include/asm/entry-macro-multi.S
@@ -27,10 +27,7 @@
 	bne	do_IPI
 
 #ifdef CONFIG_LOCAL_TIMERS
-	test_for_ltirq r0, r2, r6, lr
-	movne	r0, sp
-	adrne	lr, BSYM(1b)
-	bne	do_local_timer
+	test_for_ppi r0, r2, r6, lr, sp, BSYM(1b)
 #endif
 #endif
 9997:
diff --git a/arch/arm/include/asm/hardware/entry-macro-gic.S b/arch/arm/include/asm/hardware/entry-macro-gic.S
index c115b82..a74990f 100644
--- a/arch/arm/include/asm/hardware/entry-macro-gic.S
+++ b/arch/arm/include/asm/hardware/entry-macro-gic.S
@@ -63,13 +63,16 @@
 	cmpcs	\irqnr, \irqnr
 	.endm
 
-/* As above, this assumes that irqstat and base are preserved.. */
+/*
+ * We will have checked for normal IRQs (32+) and IPIs (0-15) so only
+ * PPIs are left here.
+ */
 
-	.macro test_for_ltirq, irqnr, irqstat, base, tmp
+	.macro test_for_ppi, irqnr, irqstat, base, tmp, regs, sym
 	bic	\irqnr, \irqstat, #0x1c00
-	mov 	\tmp, #0
-	cmp	\irqnr, #29
-	moveq	\tmp, #1
-	streq	\irqstat, [\base, #GIC_CPU_EOI]
-	cmp	\tmp, #0
+	cmp	\irqnr, #32
+	strcc	\irqstat, [\base, #GIC_CPU_EOI]
+	movcc	r1, \regs
+	adrcc	lr, \sym
+	bcc	gic_call_ppi
 	.endm
diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
index 0691f9d..768521d4 100644
--- a/arch/arm/include/asm/hardware/gic.h
+++ b/arch/arm/include/asm/hardware/gic.h
@@ -33,6 +33,8 @@
 #define GIC_DIST_SOFTINT		0xf00
 
 #ifndef __ASSEMBLY__
+#include <linux/interrupt.h>
+
 extern void __iomem *gic_cpu_base_addr;
 extern struct irq_chip gic_arch_extn;
 
@@ -40,7 +42,8 @@ void gic_init(unsigned int, unsigned int, void __iomem *, void __iomem *);
 void gic_secondary_init(unsigned int);
 void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
 void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
-void gic_enable_ppi(unsigned int);
+int gic_request_ppi(unsigned int, irq_handler_t, void *);
+void gic_free_ppi(unsigned int, void *);
 #endif
 
 #endif
diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index 080d74f..42a842f 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -17,27 +17,17 @@ struct clock_event_device;
  */
 void percpu_timer_setup(void);
 
-/*
- * Called from assembly, this is the local timer IRQ handler
- */
-asmlinkage void do_local_timer(struct pt_regs *);
-
-
 #ifdef CONFIG_LOCAL_TIMERS
 
 #ifdef CONFIG_HAVE_ARM_TWD
 
 #include "smp_twd.h"
 
-#define local_timer_ack()	twd_timer_ack()
+#define local_timer_stop twd_timer_stop
 
 #else
 
-/*
- * Platform provides this to acknowledge a local timer IRQ.
- * Returns true if the local timer IRQ is to be processed.
- */
-int local_timer_ack(void);
+int local_timer_stop(struct clock_event_device *);
 
 #endif
 
diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index fed9981..ef9ffba9 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -22,7 +22,7 @@ struct clock_event_device;
 
 extern void __iomem *twd_base;
 
-int twd_timer_ack(void);
 void twd_timer_setup(struct clock_event_device *);
+void twd_timer_stop(struct clock_event_device *);
 
 #endif
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 167e3cb..f83ef5e 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -458,19 +458,6 @@ static void ipi_timer(void)
 }
 
 #ifdef CONFIG_LOCAL_TIMERS
-asmlinkage void __exception_irq_entry do_local_timer(struct pt_regs *regs)
-{
-	struct pt_regs *old_regs = set_irq_regs(regs);
-	int cpu = smp_processor_id();
-
-	if (local_timer_ack()) {
-		__inc_irq_stat(cpu, local_timer_irqs);
-		ipi_timer();
-	}
-
-	set_irq_regs(old_regs);
-}
-
 void show_local_irqs(struct seq_file *p, int prec)
 {
 	unsigned int cpu;
@@ -531,10 +518,7 @@ void __cpuinit percpu_timer_setup(void)
  */
 static void percpu_timer_stop(void)
 {
-	unsigned int cpu = smp_processor_id();
-	struct clock_event_device *evt = &per_cpu(percpu_clockevent, cpu);
-
-	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
+	local_timer_stop(&per_cpu(percpu_clockevent, smp_processor_id()));
 }
 #endif
 
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 2c277d4..5f1e124 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -26,6 +26,18 @@ void __iomem *twd_base;
 
 static unsigned long twd_timer_rate;
 
+static irqreturn_t twd_irq(int irq, void *data)
+{
+	struct clock_event_device *evt = data;
+
+	if (__raw_readl(twd_base + TWD_TIMER_INTSTAT)) {
+		__raw_writel(1, twd_base + TWD_TIMER_INTSTAT);
+		evt->event_handler(evt);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static void twd_set_mode(enum clock_event_mode mode,
 			struct clock_event_device *clk)
 {
@@ -64,22 +76,6 @@ static int twd_set_next_event(unsigned long evt,
 	return 0;
 }
 
-/*
- * local_timer_ack: checks for a local timer interrupt.
- *
- * If a local timer interrupt has occurred, acknowledge and return 1.
- * Otherwise, return 0.
- */
-int twd_timer_ack(void)
-{
-	if (__raw_readl(twd_base + TWD_TIMER_INTSTAT)) {
-		__raw_writel(1, twd_base + TWD_TIMER_INTSTAT);
-		return 1;
-	}
-
-	return 0;
-}
-
 static void __cpuinit twd_calibrate_rate(void)
 {
 	unsigned long count;
@@ -124,6 +120,8 @@ static void __cpuinit twd_calibrate_rate(void)
  */
 void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 {
+	int ret;
+
 	twd_calibrate_rate();
 
 	clk->name = "local_timer";
@@ -138,7 +136,16 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	clk->min_delta_ns = clockevent_delta2ns(0xf, clk);
 
 	/* Make sure our local interrupt controller has this enabled */
-	gic_enable_ppi(clk->irq);
+	ret = gic_request_ppi(clk->irq, twd_irq, clk);
+	if (ret)
+		pr_err("CPU%u: unable to request TWD interrupt\n",
+			smp_processor_id());
 
 	clockevents_register_device(clk);
 }
+
+void twd_timer_stop(struct clock_event_device *clk)
+{
+	clk->set_mode(CLOCK_EVT_MODE_UNUSED, clk);
+	gic_free_ppi(clk->irq, clk);
+}
diff --git a/arch/arm/mach-exynos4/include/mach/entry-macro.S b/arch/arm/mach-exynos4/include/mach/entry-macro.S
index d8f38c2..fdb24bb 100644
--- a/arch/arm/mach-exynos4/include/mach/entry-macro.S
+++ b/arch/arm/mach-exynos4/include/mach/entry-macro.S
@@ -74,11 +74,11 @@
 
 		/* As above, this assumes that irqstat and base are preserved.. */
 
-		.macro test_for_ltirq, irqnr, irqstat, base, tmp
+		.macro test_for_ppi, irqnr, irqstat, base, tmp, regs, sym
 		bic	\irqnr, \irqstat, #0x1c00
-		mov	\tmp, #0
 		cmp	\irqnr, #29
-		moveq	\tmp, #1
 		streq	\irqstat, [\base, #GIC_CPU_EOI]
-		cmp	\tmp, #0
+		moveq	r1, \regs
+		adreq	lr, \sym
+		bcc	gic_call_ppi
 		.endm
diff --git a/arch/arm/mach-msm/include/mach/entry-macro-qgic.S b/arch/arm/mach-msm/include/mach/entry-macro-qgic.S
index 1246715..b3ebb06 100644
--- a/arch/arm/mach-msm/include/mach/entry-macro-qgic.S
+++ b/arch/arm/mach-msm/include/mach/entry-macro-qgic.S
@@ -78,11 +78,11 @@
 
 	/* As above, this assumes that irqstat and base are preserved.. */
 
-	.macro test_for_ltirq, irqnr, irqstat, base, tmp
-    bic \irqnr, \irqstat, #0x1c00
-    mov     \tmp, #0
-    cmp \irqnr, #16
-    moveq   \tmp, #1
-    streq   \irqstat, [\base, #GIC_CPU_EOI]
-    cmp \tmp, #0
+	.macro test_for_ppi, irqnr, irqstat, base, tmp, regs, sym
+	bic	\irqnr, \irqstat, #0x1c00
+	cmp	\irqnr, #16
+	streq	\irqstat, [\base, #GIC_CPU_EOI]
+	moveq	r1, \regs
+	adreq	lr, \sym
+	beq	gic_call_ppi
 	.endm
diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 63621f1..b553a14 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -271,9 +271,19 @@ static void __init msm_timer_init(void)
 }
 
 #ifdef CONFIG_SMP
+static irqreturn_t local_timer_irq(int irq, void *data)
+{
+	struct clock_event_device *evt = data;
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
 int __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
 	struct msm_clock *clock = &msm_clocks[MSM_GLOBAL_TIMER];
+	int ret;
 
 	/* Use existing clock_event for cpu 0 */
 	if (!smp_processor_id())
@@ -300,15 +310,19 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
 
 	local_clock_event = evt;
 
-	gic_enable_ppi(clock->irq.irq);
+	ret = gic_request_ppi(evt->irq, local_timer_irq, evt);
+	if (ret)
+		pr_err("CPU%u: unable to request local timer interrupt\n",
+			smp_processor_id());
 
 	clockevents_register_device(evt);
 	return 0;
 }
 
-inline int local_timer_ack(void)
+void local_timer_stop(struct clock_event_device *evt)
 {
-	return 1;
+	clk->set_mode(CLOCK_EVT_MODE_UNUSED, clk);
+	gic_free_ppi(clk->irq, clk);
 }
 
 #endif
diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index ceb8b7e..66329f4 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -104,14 +104,13 @@
 
 		/* As above, this assumes that irqstat and base are preserved */
 
-		.macro test_for_ltirq, irqnr, irqstat, base, tmp
+		.macro test_for_ppi, irqnr, irqstat, base, tmp, regs, sym
 		bic	\irqnr, \irqstat, #0x1c00
-		mov 	\tmp, #0
 		cmp	\irqnr, #29
-		itt	eq
-		moveq	\tmp, #1
 		streq	\irqstat, [\base, #GIC_CPU_EOI]
-		cmp	\tmp, #0
+		moveq	r1, \regs
+		adreq	lr, \sym
+		beq	gic_call_ppi
 		.endm
 #endif	/* CONFIG_SMP */
 
diff --git a/arch/arm/mach-shmobile/entry-intc.S b/arch/arm/mach-shmobile/entry-intc.S
index cac0a7a..b4ece8e 100644
--- a/arch/arm/mach-shmobile/entry-intc.S
+++ b/arch/arm/mach-shmobile/entry-intc.S
@@ -51,7 +51,7 @@
 	.macro  test_for_ipi, irqnr, irqstat, base, tmp
 	.endm
 
-	.macro  test_for_ltirq, irqnr, irqstat, base, tmp
+	.macro  test_for_ppi, irqnr, irqstat, base, tmp, regs, sym
 	.endm
 
 	arch_irq_handler shmobile_handle_irq_intc
diff --git a/arch/arm/mach-shmobile/include/mach/entry-macro.S b/arch/arm/mach-shmobile/include/mach/entry-macro.S
index d791f10..e6dcafd 100644
--- a/arch/arm/mach-shmobile/include/mach/entry-macro.S
+++ b/arch/arm/mach-shmobile/include/mach/entry-macro.S
@@ -27,7 +27,7 @@
 	.macro  test_for_ipi, irqnr, irqstat, base, tmp
 	.endm
 
-	.macro  test_for_ltirq, irqnr, irqstat, base, tmp
+	.macro  test_for_ppi, irqnr, irqstat, base, tmp, regs, sym
 	.endm
 
 	.macro  arch_ret_to_user, tmp1, tmp2
