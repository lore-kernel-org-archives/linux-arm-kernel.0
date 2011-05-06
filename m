From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  6 May 2011 11:33:07 +0100
Subject: [RFC PATCH v2 02/12] ARM: smp_twd: add support for remapped PPI
	interrupts
In-Reply-To: <1304677997-26947-1-git-send-email-marc.zyngier@arm.com>
References: <1304677997-26947-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1304677997-26947-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_ARM_GIC_VPPI is enabled, let smp_twd request interrupts
the normal way (ie using request_irq()).

This involves letting PPIs go via the same code path as SPIs and
having normal interrupt handler for the local timer code.

The previous ad-hoc code is still supported when CONFIG_ARM_GIC_VPPI
is not defined.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/localtimer.h |    6 ++++++
 arch/arm/kernel/smp.c             |   12 ++++++++++++
 arch/arm/kernel/smp_twd.c         |   20 +++++++++++++++++++-
 3 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index 080d74f..bef44b3 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -10,6 +10,8 @@
 #ifndef __ASM_ARM_LOCALTIMER_H
 #define __ASM_ARM_LOCALTIMER_H
 
+#include <linux/interrupt.h>
+
 struct clock_event_device;
 
 /*
@@ -22,6 +24,10 @@ void percpu_timer_setup(void);
  */
 asmlinkage void do_local_timer(struct pt_regs *);
 
+/*
+ * Per-cpu timer IRQ handler
+ */
+irqreturn_t percpu_timer_handler(int irq, void *dev_id);
 
 #ifdef CONFIG_LOCAL_TIMERS
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index f29b8a2..30201a0 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -452,6 +452,18 @@ asmlinkage void __exception_irq_entry do_local_timer(struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
+irqreturn_t percpu_timer_handler(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	if (local_timer_ack()) {
+		evt->event_handler(evt);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
 void show_local_irqs(struct seq_file *p, int prec)
 {
 	unsigned int cpu;
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 60636f4..2256360 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -15,10 +15,11 @@
 #include <linux/smp.h>
 #include <linux/jiffies.h>
 #include <linux/clockchips.h>
-#include <linux/irq.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 
 #include <asm/smp_twd.h>
+#include <asm/localtimer.h>
 #include <asm/hardware/gic.h>
 
 /* set up by the platform code */
@@ -43,6 +44,10 @@ static void twd_set_mode(enum clock_event_mode mode,
 		ctrl = TWD_TIMER_CONTROL_IT_ENABLE | TWD_TIMER_CONTROL_ONESHOT;
 		break;
 	case CLOCK_EVT_MODE_UNUSED:
+#ifdef CONFIG_ARM_GIC_VPPI
+		free_irq(clk->irq, clk);
+		/* fall through */
+#endif
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	default:
 		ctrl = 0;
@@ -124,6 +129,8 @@ static void __cpuinit twd_calibrate_rate(void)
  */
 void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 {
+	int err;
+
 	twd_calibrate_rate();
 
 	clk->name = "local_timer";
@@ -137,8 +144,19 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	clk->max_delta_ns = clockevent_delta2ns(0xffffffff, clk);
 	clk->min_delta_ns = clockevent_delta2ns(0xf, clk);
 
+#ifdef CONFIG_ARM_GIC_VPPI
+	err = request_irq(clk->irq, percpu_timer_handler,
+			  IRQF_PERCPU | IRQF_NOBALANCING | IRQF_TIMER,
+			  clk->name, clk);
+	if (err) {
+		pr_err("%s: can't register interrupt %d on cpu %d (%d)\n",
+		       clk->name, clk->irq, smp_processor_id(), err);
+		return;
+	}
+#else
 	/* Make sure our local interrupt controller has this enabled */
 	gic_enable_ppi(clk->irq);
+#endif
 
 	clockevents_register_device(clk);
 }
-- 
1.7.0.4
