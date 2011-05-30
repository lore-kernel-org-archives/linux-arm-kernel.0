From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 30 May 2011 11:04:44 +0100
Subject: [RFC PATCH v5 03/13] ARM: smp_twd: add support for remapped PPI
	interrupts
In-Reply-To: <1306749894-28749-1-git-send-email-marc.zyngier@arm.com>
References: <1306749894-28749-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1306749894-28749-4-git-send-email-marc.zyngier@arm.com>
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
 arch/arm/kernel/smp_twd.c |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 60636f4..773336e 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -15,16 +15,18 @@
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
 void __iomem *twd_base;
 
 static unsigned long twd_timer_rate;
+static DEFINE_PER_CPU(bool, irq_reqd);
 
 static void twd_set_mode(enum clock_event_mode mode,
 			struct clock_event_device *clk)
@@ -43,6 +45,10 @@ static void twd_set_mode(enum clock_event_mode mode,
 		ctrl = TWD_TIMER_CONTROL_IT_ENABLE | TWD_TIMER_CONTROL_ONESHOT;
 		break;
 	case CLOCK_EVT_MODE_UNUSED:
+#ifdef CONFIG_ARM_GIC_VPPI
+		disable_irq(clk->irq);
+		/* fall through */
+#endif
 	case CLOCK_EVT_MODE_SHUTDOWN:
 	default:
 		ctrl = 0;
@@ -124,6 +130,9 @@ static void __cpuinit twd_calibrate_rate(void)
  */
 void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 {
+	int err;
+	bool *reqd;
+
 	twd_calibrate_rate();
 
 	clk->name = "local_timer";
@@ -137,8 +146,25 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	clk->max_delta_ns = clockevent_delta2ns(0xffffffff, clk);
 	clk->min_delta_ns = clockevent_delta2ns(0xf, clk);
 
+#ifdef CONFIG_ARM_GIC_VPPI
+	reqd = &__get_cpu_var(irq_reqd);
+	if (!*reqd) {
+		err = request_irq(clk->irq, percpu_timer_handler,
+				  IRQF_PERCPU | IRQF_NOBALANCING | IRQF_TIMER,
+				  clk->name, clk);
+		if (err) {
+			pr_err("%s: can't register interrupt %d on cpu %d (%d)\n",
+			       clk->name, clk->irq, smp_processor_id(), err);
+			return;
+		}
+
+		*reqd = true;
+	} else
+		enable_irq(clk->irq);
+#else
 	/* Make sure our local interrupt controller has this enabled */
 	gic_enable_ppi(clk->irq);
+#endif
 
 	clockevents_register_device(clk);
 }
-- 
1.7.5.2
