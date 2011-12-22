From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Dec 2011 17:27:31 +0000
Subject: [PATCH v2 01/15] ARM: local timers: allow smp_twd to be used
 standalone
In-Reply-To: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1324574865-5367-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow smp_twd to be built in a "standalone" version,
without relying on the CONFIG_LOCAL_TIMER infrastructure.
It mainly relies on a CPU notifier block to stop or start
the timer on the right CPU.

The CONFIG_ARM_SMP_TWD option selects the new behaviour.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig               |    6 +++-
 arch/arm/include/asm/smp_twd.h |    9 +++++
 arch/arm/kernel/smp_twd.c      |   79 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6f3e186..c37410a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1522,6 +1522,10 @@ config HAVE_ARM_TWD
 	help
 	  This options enables support for the ARM timer and watchdog unit
 
+config ARM_SMP_TWD
+	bool
+	select HAVE_ARM_TWD if SMP
+
 choice
 	prompt "Memory split"
 	default VMSPLIT_3G
@@ -1560,7 +1564,7 @@ config HOTPLUG_CPU
 
 config LOCAL_TIMERS
 	bool "Use local timer interrupts"
-	depends on SMP
+	depends on SMP && !ARM_SMP_TWD
 	default y
 	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
 	help
diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index ef9ffba9..934f1bc 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -19,10 +19,19 @@
 #define TWD_TIMER_CONTROL_IT_ENABLE	(1 << 2)
 
 struct clock_event_device;
+struct resource;
 
 extern void __iomem *twd_base;
 
 void twd_timer_setup(struct clock_event_device *);
 void twd_timer_stop(struct clock_event_device *);
+#ifdef CONFIG_HAVE_ARM_TWD
+int twd_timer_register(struct resource *res, int res_nr);
+#else
+static inline int twd_timer_register(struct resource *res, int res_nr)
+{
+	return 0;
+}
+#endif
 
 #endif
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 2442bbb..dedbdb4 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -13,11 +13,13 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/smp.h>
+#include <linux/cpu.h>
 #include <linux/jiffies.h>
 #include <linux/clockchips.h>
 #include <linux/irq.h>
 #include <linux/io.h>
 
+#include <asm/smp_plat.h>
 #include <asm/smp_twd.h>
 #include <asm/localtimer.h>
 #include <asm/hardware/gic.h>
@@ -172,7 +174,7 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	clk->name = "local_timer";
 	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
 			CLOCK_EVT_FEAT_C3STOP;
-	clk->rating = 350;
+	clk->rating = 450;	/* Make sure this is higher than broadcast */
 	clk->set_mode = twd_set_mode;
 	clk->set_next_event = twd_set_next_event;
 	clk->shift = 20;
@@ -187,3 +189,78 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 
 	enable_percpu_irq(clk->irq, 0);
 }
+
+#ifdef CONFIG_ARM_SMP_TWD
+static struct clock_event_device __percpu *twd_clock_event;
+static int twd_ppi;
+
+static void __cpuinit twd_setup(struct clock_event_device *clk)
+{
+	clk->cpumask = cpumask_of(smp_processor_id());
+	clk->irq = twd_ppi;
+	twd_timer_setup(clk);
+}
+
+static void __cpuinit twd_teardown(void *data)
+{
+	struct clock_event_device *clk = data;
+	twd_timer_stop(clk);
+}
+
+static int __cpuinit twd_cpu_notify(struct notifier_block *self,
+				    unsigned long action, void *data)
+{
+	int cpu = (int)data;
+	struct clock_event_device *clk = per_cpu_ptr(twd_clock_event, cpu);
+
+	switch (action) {
+	case CPU_STARTING:
+	case CPU_STARTING_FROZEN:
+		twd_setup(clk);
+		break;
+
+	case CPU_DOWN_PREPARE:
+	case CPU_DOWN_PREPARE_FROZEN:
+		smp_call_function_single(cpu, twd_teardown, clk, 1);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __cpuinitdata twd_cpu_nb = {
+	.notifier_call = twd_cpu_notify,
+};
+
+int __init twd_timer_register(struct resource *res, int res_nr)
+{
+	struct clock_event_device *clk;
+
+	if (!is_smp())
+		return -ENODEV;
+
+	if (res_nr != 2 || res[1].start < 0)
+		return -EINVAL;
+
+	if (twd_base)
+		return -EBUSY;
+
+	twd_ppi		= res[1].start;
+	twd_base	= ioremap(res[0].start, resource_size(&res[0]));
+	twd_clock_event	= alloc_percpu(struct clock_event_device);
+	if (!twd_base || !twd_clock_event) {
+		iounmap(twd_base);
+		twd_base = NULL;
+		free_percpu(twd_clock_event);
+		return -ENOMEM;
+	}
+
+	/* Immediately configure the timer on the boot CPU */
+	clk = per_cpu_ptr(twd_clock_event, smp_processor_id());
+	twd_setup(clk);
+
+	register_cpu_notifier(&twd_cpu_nb);
+
+	return 0;
+}
+#endif
-- 
1.7.7.1
