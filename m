From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 Jan 2013 12:15:33 +0000
Subject: [PATCHv5 10/16] arm: arch_timer: move core to drivers/clocksource
In-Reply-To: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
References: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1359634539-9580-11-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core functionality of the arch_timer driver is not directly tied to
anything under arch/arm, and can be split out.

This patch factors out the core of the arch_timer driver, so it can be
shared with other architectures. A couple of functions are added so
that architecture-specific code can interact with the driver without
needing to touch its internals.

The ARM_ARCH_TIMER config variable is moved out to
drivers/clocksource/Kconfig, existing uses in arch/arm are replaced with
HAVE_ARM_ARCH_TIMER, which selects it.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig                     |   3 +-
 arch/arm/include/asm/arch_timer.h    |  19 +-
 arch/arm/kernel/arch_timer.c         | 386 ++---------------------------------
 arch/arm/mach-omap2/Kconfig          |   2 +-
 drivers/clocksource/Kconfig          |   3 +
 drivers/clocksource/Makefile         |   1 +
 drivers/clocksource/arm_arch_timer.c | 385 ++++++++++++++++++++++++++++++++++
 include/clocksource/arm_arch_timer.h |  63 ++++++
 8 files changed, 476 insertions(+), 386 deletions(-)
 create mode 100644 drivers/clocksource/arm_arch_timer.c
 create mode 100644 include/clocksource/arm_arch_timer.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 67874b8..e1162f5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1572,9 +1572,10 @@ config HAVE_ARM_SCU
 	help
 	  This option enables support for the ARM system coherency unit
 
-config ARM_ARCH_TIMER
+config HAVE_ARM_ARCH_TIMER
 	bool "Architected timer support"
 	depends on CPU_V7
+	select ARM_ARCH_TIMER
 	help
 	  This option enables support for the ARM architected timer
 
diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 729f6d9..7ade91d 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -4,22 +4,14 @@
 #include <asm/barrier.h>
 #include <asm/errno.h>
 #include <linux/clocksource.h>
+#include <linux/init.h>
 #include <linux/types.h>
 
+#include <clocksource/arm_arch_timer.h>
+
 #ifdef CONFIG_ARM_ARCH_TIMER
 int arch_timer_of_register(void);
 int arch_timer_sched_clock_init(void);
-struct timecounter *arch_timer_get_timecounter(void);
-
-#define ARCH_TIMER_CTRL_ENABLE		(1 << 0)
-#define ARCH_TIMER_CTRL_IT_MASK		(1 << 1)
-#define ARCH_TIMER_CTRL_IT_STAT		(1 << 2)
-
-#define ARCH_TIMER_REG_CTRL		0
-#define ARCH_TIMER_REG_TVAL		1
-
-#define ARCH_TIMER_PHYS_ACCESS		0
-#define ARCH_TIMER_VIRT_ACCESS		1
 
 /*
  * These register accessors are marked inline so the compiler can
@@ -128,11 +120,6 @@ static inline int arch_timer_sched_clock_init(void)
 {
 	return -ENXIO;
 }
-
-static inline struct timecounter *arch_timer_get_timecounter(void)
-{
-	return NULL;
-}
 #endif
 
 #endif
diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index 94f5033..36ebcf4 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -9,402 +9,52 @@
  * published by the Free Software Foundation.
  */
 #include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/smp.h>
-#include <linux/cpu.h>
-#include <linux/jiffies.h>
-#include <linux/clockchips.h>
-#include <linux/interrupt.h>
-#include <linux/of_irq.h>
-#include <linux/io.h>
+#include <linux/types.h>
 
 #include <asm/delay.h>
-#include <asm/arch_timer.h>
 #include <asm/sched_clock.h>
 
-static u32 arch_timer_rate;
+#include <clocksource/arm_arch_timer.h>
 
-enum ppi_nr {
-	PHYS_SECURE_PPI,
-	PHYS_NONSECURE_PPI,
-	VIRT_PPI,
-	HYP_PPI,
-	MAX_TIMER_PPI
-};
-
-static int arch_timer_ppi[MAX_TIMER_PPI];
-
-static struct clock_event_device __percpu *arch_timer_evt;
-static struct delay_timer arch_delay_timer;
-
-static bool arch_timer_use_virtual = true;
-
-/*
- * Architected system timer support.
- */
-
-static irqreturn_t inline timer_handler(const int access,
-					struct clock_event_device *evt)
-{
-	unsigned long ctrl;
-	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL);
-	if (ctrl & ARCH_TIMER_CTRL_IT_STAT) {
-		ctrl |= ARCH_TIMER_CTRL_IT_MASK;
-		arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl);
-		evt->event_handler(evt);
-		return IRQ_HANDLED;
-	}
-
-	return IRQ_NONE;
-}
-
-static irqreturn_t arch_timer_handler_virt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-
-	return timer_handler(ARCH_TIMER_VIRT_ACCESS, evt);
-}
-
-static irqreturn_t arch_timer_handler_phys(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-
-	return timer_handler(ARCH_TIMER_PHYS_ACCESS, evt);
-}
-
-static inline void timer_set_mode(const int access, int mode)
-{
-	unsigned long ctrl;
-	switch (mode) {
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL);
-		ctrl &= ~ARCH_TIMER_CTRL_ENABLE;
-		arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl);
-		break;
-	default:
-		break;
-	}
-}
-
-static void arch_timer_set_mode_virt(enum clock_event_mode mode,
-				     struct clock_event_device *clk)
-{
-	timer_set_mode(ARCH_TIMER_VIRT_ACCESS, mode);
-}
-
-static void arch_timer_set_mode_phys(enum clock_event_mode mode,
-				     struct clock_event_device *clk)
-{
-	timer_set_mode(ARCH_TIMER_PHYS_ACCESS, mode);
-}
-
-static inline void set_next_event(const int access, unsigned long evt)
-{
-	unsigned long ctrl;
-	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL);
-	ctrl |= ARCH_TIMER_CTRL_ENABLE;
-	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
-	arch_timer_reg_write(access, ARCH_TIMER_REG_TVAL, evt);
-	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl);
-}
-
-static int arch_timer_set_next_event_virt(unsigned long evt,
-					  struct clock_event_device *unused)
-{
-	set_next_event(ARCH_TIMER_VIRT_ACCESS, evt);
-	return 0;
-}
-
-static int arch_timer_set_next_event_phys(unsigned long evt,
-					  struct clock_event_device *unused)
-{
-	set_next_event(ARCH_TIMER_PHYS_ACCESS, evt);
-	return 0;
-}
-
-static int __cpuinit arch_timer_setup(struct clock_event_device *clk)
-{
-	clk->features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP;
-	clk->name = "arch_sys_timer";
-	clk->rating = 450;
-	if (arch_timer_use_virtual) {
-		clk->irq = arch_timer_ppi[VIRT_PPI];
-		clk->set_mode = arch_timer_set_mode_virt;
-		clk->set_next_event = arch_timer_set_next_event_virt;
-	} else {
-		clk->irq = arch_timer_ppi[PHYS_SECURE_PPI];
-		clk->set_mode = arch_timer_set_mode_phys;
-		clk->set_next_event = arch_timer_set_next_event_phys;
-	}
-
-	clk->cpumask = cpumask_of(smp_processor_id());
-
-	clk->set_mode(CLOCK_EVT_MODE_SHUTDOWN, NULL);
-
-	clockevents_config_and_register(clk, arch_timer_rate,
-					0xf, 0x7fffffff);
-
-	if (arch_timer_use_virtual)
-		enable_percpu_irq(arch_timer_ppi[VIRT_PPI], 0);
-	else {
-		enable_percpu_irq(arch_timer_ppi[PHYS_SECURE_PPI], 0);
-		if (arch_timer_ppi[PHYS_NONSECURE_PPI])
-			enable_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI], 0);
-	}
-
-	arch_counter_set_user_access();
-
-	return 0;
-}
-
-static int arch_timer_available(void)
-{
-	u32 freq;
-
-	if (arch_timer_rate == 0) {
-		freq = arch_timer_get_cntfrq();
-
-		/* Check the timer frequency. */
-		if (freq == 0) {
-			pr_warn("Architected timer frequency not available\n");
-			return -EINVAL;
-		}
-
-		arch_timer_rate = freq;
-	}
-
-	pr_info_once("Architected local timer running at %lu.%02luMHz (%s).\n",
-		     (unsigned long)arch_timer_rate / 1000000,
-		     (unsigned long)(arch_timer_rate / 10000) % 100,
-		     arch_timer_use_virtual ? "virt" : "phys");
-	return 0;
-}
-
-/*
- * Some external users of arch_timer_read_counter (e.g. sched_clock) may try to
- * call it before it has been initialised. Rather than incur a performance
- * penalty checking for initialisation, provide a default implementation that
- * won't lead to time appearing to jump backwards.
- */
-static u64 arch_timer_read_zero(void)
-{
-	return 0;
-}
-
-u64 (*arch_timer_read_counter)(void) = arch_timer_read_zero;
-
-static u32 arch_timer_read_counter32(void)
-{
-	return arch_timer_read_counter();
-}
-
-static cycle_t arch_counter_read(struct clocksource *cs)
+static unsigned long arch_timer_read_counter_long(void)
 {
 	return arch_timer_read_counter();
 }
 
-static unsigned long arch_timer_read_current_timer(void)
+static u32 arch_timer_read_counter_u32(void)
 {
 	return arch_timer_read_counter();
 }
 
-static cycle_t arch_counter_read_cc(const struct cyclecounter *cc)
-{
-	return arch_timer_read_counter();
-}
-
-static struct clocksource clocksource_counter = {
-	.name	= "arch_sys_counter",
-	.rating	= 400,
-	.read	= arch_counter_read,
-	.mask	= CLOCKSOURCE_MASK(56),
-	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-static struct cyclecounter cyclecounter = {
-	.read	= arch_counter_read_cc,
-	.mask	= CLOCKSOURCE_MASK(56),
-};
-
-static struct timecounter timecounter;
-
-struct timecounter *arch_timer_get_timecounter(void)
-{
-	return &timecounter;
-}
-
-static void __cpuinit arch_timer_stop(struct clock_event_device *clk)
-{
-	pr_debug("arch_timer_teardown disable IRQ%d cpu #%d\n",
-		 clk->irq, smp_processor_id());
-
-	if (arch_timer_use_virtual)
-		disable_percpu_irq(arch_timer_ppi[VIRT_PPI]);
-	else {
-		disable_percpu_irq(arch_timer_ppi[PHYS_SECURE_PPI]);
-		if (arch_timer_ppi[PHYS_NONSECURE_PPI])
-			disable_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI]);
-	}
-
-	clk->set_mode(CLOCK_EVT_MODE_UNUSED, clk);
-}
-
-static int __cpuinit arch_timer_cpu_notify(struct notifier_block *self,
-					   unsigned long action, void *hcpu)
-{
-	struct clock_event_device *evt = this_cpu_ptr(arch_timer_evt);
-
-	switch (action & ~CPU_TASKS_FROZEN) {
-	case CPU_STARTING:
-		arch_timer_setup(evt);
-		break;
-	case CPU_DYING:
-		arch_timer_stop(evt);
-		break;
-	}
-
-	return NOTIFY_OK;
-}
-
-static struct notifier_block arch_timer_cpu_nb __cpuinitdata = {
-	.notifier_call = arch_timer_cpu_notify,
-};
+static struct delay_timer arch_delay_timer;
 
-static int __init arch_timer_register(void)
+static void __init arch_timer_delay_timer_register(void)
 {
-	int err;
-	int ppi;
-
-	err = arch_timer_available();
-	if (err)
-		goto out;
-
-	arch_timer_evt = alloc_percpu(struct clock_event_device);
-	if (!arch_timer_evt) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	clocksource_register_hz(&clocksource_counter, arch_timer_rate);
-	cyclecounter.mult = clocksource_counter.mult;
-	cyclecounter.shift = clocksource_counter.shift;
-	timecounter_init(&timecounter, &cyclecounter,
-			 arch_counter_get_cntpct());
-
-	if (arch_timer_use_virtual) {
-		ppi = arch_timer_ppi[VIRT_PPI];
-		err = request_percpu_irq(ppi, arch_timer_handler_virt,
-					 "arch_timer", arch_timer_evt);
-	} else {
-		ppi = arch_timer_ppi[PHYS_SECURE_PPI];
-		err = request_percpu_irq(ppi, arch_timer_handler_phys,
-					 "arch_timer", arch_timer_evt);
-		if (!err && arch_timer_ppi[PHYS_NONSECURE_PPI]) {
-			ppi = arch_timer_ppi[PHYS_NONSECURE_PPI];
-			err = request_percpu_irq(ppi, arch_timer_handler_phys,
-						 "arch_timer", arch_timer_evt);
-			if (err)
-				free_percpu_irq(arch_timer_ppi[PHYS_SECURE_PPI],
-						arch_timer_evt);
-		}
-	}
-
-	if (err) {
-		pr_err("arch_timer: can't register interrupt %d (%d)\n",
-		       ppi, err);
-		goto out_free;
-	}
-
-	err = register_cpu_notifier(&arch_timer_cpu_nb);
-	if (err)
-		goto out_free_irq;
-
-	/* Immediately configure the timer on the boot CPU */
-	arch_timer_setup(this_cpu_ptr(arch_timer_evt));
-
 	/* Use the architected timer for the delay loop. */
-	arch_delay_timer.read_current_timer = &arch_timer_read_current_timer;
-	arch_delay_timer.freq = arch_timer_rate;
+	arch_delay_timer.read_current_timer = arch_timer_read_counter_long;
+	arch_delay_timer.freq = arch_timer_get_rate();
 	register_current_timer_delay(&arch_delay_timer);
-	return 0;
-
-out_free_irq:
-	if (arch_timer_use_virtual)
-		free_percpu_irq(arch_timer_ppi[VIRT_PPI], arch_timer_evt);
-	else {
-		free_percpu_irq(arch_timer_ppi[PHYS_SECURE_PPI],
-				arch_timer_evt);
-		if (arch_timer_ppi[PHYS_NONSECURE_PPI])
-			free_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI],
-					arch_timer_evt);
-	}
-
-out_free:
-	free_percpu(arch_timer_evt);
-out:
-	return err;
 }
 
-static const struct of_device_id arch_timer_of_match[] __initconst = {
-	{ .compatible	= "arm,armv7-timer",	},
-	{},
-};
-
 int __init arch_timer_of_register(void)
 {
-	struct device_node *np;
-	u32 freq;
-	int i;
-
-	np = of_find_matching_node(NULL, arch_timer_of_match);
-	if (!np) {
-		pr_err("arch_timer: can't find DT node\n");
-		return -ENODEV;
-	}
+	int ret;
 
-	/* Try to determine the frequency from the device tree or CNTFRQ */
-	if (!of_property_read_u32(np, "clock-frequency", &freq))
-		arch_timer_rate = freq;
+	ret = arch_timer_init();
+	if (ret)
+		return ret;
 
-	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
-		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
+	arch_timer_delay_timer_register();
 
-	of_node_put(np);
-
-	/*
-	 * If no interrupt provided for virtual timer, we'll have to
-	 * stick to the physical timer. It'd better be accessible...
-	 */
-	if (!arch_timer_ppi[VIRT_PPI]) {
-		arch_timer_use_virtual = false;
-
-		if (!arch_timer_ppi[PHYS_SECURE_PPI] ||
-		    !arch_timer_ppi[PHYS_NONSECURE_PPI]) {
-			pr_warn("arch_timer: No interrupt available, giving up\n");
-			return -EINVAL;
-		}
-	}
-
-	if (arch_timer_use_virtual)
-		arch_timer_read_counter = arch_counter_get_cntvct;
-	else
-		arch_timer_read_counter = arch_counter_get_cntpct;
-
-	return arch_timer_register();
+	return 0;
 }
 
 int __init arch_timer_sched_clock_init(void)
 {
-	int err;
-
-	err = arch_timer_available();
-	if (err)
-		return err;
+	if (arch_timer_get_rate() == 0)
+		return -ENXIO;
 
-	setup_sched_clock(arch_timer_read_counter32,
-			  32, arch_timer_rate);
+	setup_sched_clock(arch_timer_read_counter_u32,
+			  32, arch_timer_get_rate());
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 41b581f..9d7909e 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -76,12 +76,12 @@ config ARCH_OMAP4
 
 config SOC_OMAP5
 	bool "TI OMAP5"
-	select ARM_ARCH_TIMER
 	select ARM_CPU_SUSPEND if PM
 	select ARM_GIC
 	select CPU_V7
 	select HAVE_SMP
 	select COMMON_CLK
+	select HAVE_ARM_ARCH_TIMER
 
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 7fdcbd3..dbb085a 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -58,3 +58,6 @@ config CLKSRC_ARM_GENERIC
 	def_bool y if ARM64
 	help
 	  This option enables support for the ARM generic timer.
+
+config ARM_ARCH_TIMER
+	bool
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index f93453d..32f858c 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
 obj-$(CONFIG_SUNXI_TIMER)	+= sunxi_timer.o
 
 obj-$(CONFIG_CLKSRC_ARM_GENERIC)	+= arm_generic.o
+obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
new file mode 100644
index 0000000..3e4739d
--- /dev/null
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -0,0 +1,385 @@
+/*
+ *  linux/drivers/clocksource/arm_arch_timer.c
+ *
+ *  Copyright (C) 2011 ARM Ltd.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/smp.h>
+#include <linux/cpu.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/of_irq.h>
+#include <linux/io.h>
+
+#include <asm/arch_timer.h>
+
+#include <clocksource/arm_arch_timer.h>
+
+static u32 arch_timer_rate;
+
+enum ppi_nr {
+	PHYS_SECURE_PPI,
+	PHYS_NONSECURE_PPI,
+	VIRT_PPI,
+	HYP_PPI,
+	MAX_TIMER_PPI
+};
+
+static int arch_timer_ppi[MAX_TIMER_PPI];
+
+static struct clock_event_device __percpu *arch_timer_evt;
+
+static bool arch_timer_use_virtual = true;
+
+/*
+ * Architected system timer support.
+ */
+
+static inline irqreturn_t timer_handler(const int access,
+					struct clock_event_device *evt)
+{
+	unsigned long ctrl;
+	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL);
+	if (ctrl & ARCH_TIMER_CTRL_IT_STAT) {
+		ctrl |= ARCH_TIMER_CTRL_IT_MASK;
+		arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl);
+		evt->event_handler(evt);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static irqreturn_t arch_timer_handler_virt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	return timer_handler(ARCH_TIMER_VIRT_ACCESS, evt);
+}
+
+static irqreturn_t arch_timer_handler_phys(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	return timer_handler(ARCH_TIMER_PHYS_ACCESS, evt);
+}
+
+static inline void timer_set_mode(const int access, int mode)
+{
+	unsigned long ctrl;
+	switch (mode) {
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL);
+		ctrl &= ~ARCH_TIMER_CTRL_ENABLE;
+		arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl);
+		break;
+	default:
+		break;
+	}
+}
+
+static void arch_timer_set_mode_virt(enum clock_event_mode mode,
+				     struct clock_event_device *clk)
+{
+	timer_set_mode(ARCH_TIMER_VIRT_ACCESS, mode);
+}
+
+static void arch_timer_set_mode_phys(enum clock_event_mode mode,
+				     struct clock_event_device *clk)
+{
+	timer_set_mode(ARCH_TIMER_PHYS_ACCESS, mode);
+}
+
+static inline void set_next_event(const int access, unsigned long evt)
+{
+	unsigned long ctrl;
+	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL);
+	ctrl |= ARCH_TIMER_CTRL_ENABLE;
+	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
+	arch_timer_reg_write(access, ARCH_TIMER_REG_TVAL, evt);
+	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl);
+}
+
+static int arch_timer_set_next_event_virt(unsigned long evt,
+					  struct clock_event_device *unused)
+{
+	set_next_event(ARCH_TIMER_VIRT_ACCESS, evt);
+	return 0;
+}
+
+static int arch_timer_set_next_event_phys(unsigned long evt,
+					  struct clock_event_device *unused)
+{
+	set_next_event(ARCH_TIMER_PHYS_ACCESS, evt);
+	return 0;
+}
+
+static int __cpuinit arch_timer_setup(struct clock_event_device *clk)
+{
+	clk->features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP;
+	clk->name = "arch_sys_timer";
+	clk->rating = 450;
+	if (arch_timer_use_virtual) {
+		clk->irq = arch_timer_ppi[VIRT_PPI];
+		clk->set_mode = arch_timer_set_mode_virt;
+		clk->set_next_event = arch_timer_set_next_event_virt;
+	} else {
+		clk->irq = arch_timer_ppi[PHYS_SECURE_PPI];
+		clk->set_mode = arch_timer_set_mode_phys;
+		clk->set_next_event = arch_timer_set_next_event_phys;
+	}
+
+	clk->cpumask = cpumask_of(smp_processor_id());
+
+	clk->set_mode(CLOCK_EVT_MODE_SHUTDOWN, NULL);
+
+	clockevents_config_and_register(clk, arch_timer_rate,
+					0xf, 0x7fffffff);
+
+	if (arch_timer_use_virtual)
+		enable_percpu_irq(arch_timer_ppi[VIRT_PPI], 0);
+	else {
+		enable_percpu_irq(arch_timer_ppi[PHYS_SECURE_PPI], 0);
+		if (arch_timer_ppi[PHYS_NONSECURE_PPI])
+			enable_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI], 0);
+	}
+
+	arch_counter_set_user_access();
+
+	return 0;
+}
+
+static int arch_timer_available(void)
+{
+	u32 freq;
+
+	if (arch_timer_rate == 0) {
+		freq = arch_timer_get_cntfrq();
+
+		/* Check the timer frequency. */
+		if (freq == 0) {
+			pr_warn("Architected timer frequency not available\n");
+			return -EINVAL;
+		}
+
+		arch_timer_rate = freq;
+	}
+
+	pr_info_once("Architected local timer running at %lu.%02luMHz (%s).\n",
+		     (unsigned long)arch_timer_rate / 1000000,
+		     (unsigned long)(arch_timer_rate / 10000) % 100,
+		     arch_timer_use_virtual ? "virt" : "phys");
+	return 0;
+}
+
+u32 arch_timer_get_rate(void)
+{
+	return arch_timer_rate;
+}
+
+/*
+ * Some external users of arch_timer_read_counter (e.g. sched_clock) may try to
+ * call it before it has been initialised. Rather than incur a performance
+ * penalty checking for initialisation, provide a default implementation that
+ * won't lead to time appearing to jump backwards.
+ */
+static u64 arch_timer_read_zero(void)
+{
+	return 0;
+}
+
+u64 (*arch_timer_read_counter)(void) = arch_timer_read_zero;
+
+static cycle_t arch_counter_read(struct clocksource *cs)
+{
+	return arch_timer_read_counter();
+}
+
+static cycle_t arch_counter_read_cc(const struct cyclecounter *cc)
+{
+	return arch_timer_read_counter();
+}
+
+static struct clocksource clocksource_counter = {
+	.name	= "arch_sys_counter",
+	.rating	= 400,
+	.read	= arch_counter_read,
+	.mask	= CLOCKSOURCE_MASK(56),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static struct cyclecounter cyclecounter = {
+	.read	= arch_counter_read_cc,
+	.mask	= CLOCKSOURCE_MASK(56),
+};
+
+static struct timecounter timecounter;
+
+struct timecounter *arch_timer_get_timecounter(void)
+{
+	return &timecounter;
+}
+
+static void __cpuinit arch_timer_stop(struct clock_event_device *clk)
+{
+	pr_debug("arch_timer_teardown disable IRQ%d cpu #%d\n",
+		 clk->irq, smp_processor_id());
+
+	if (arch_timer_use_virtual)
+		disable_percpu_irq(arch_timer_ppi[VIRT_PPI]);
+	else {
+		disable_percpu_irq(arch_timer_ppi[PHYS_SECURE_PPI]);
+		if (arch_timer_ppi[PHYS_NONSECURE_PPI])
+			disable_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI]);
+	}
+
+	clk->set_mode(CLOCK_EVT_MODE_UNUSED, clk);
+}
+
+static int __cpuinit arch_timer_cpu_notify(struct notifier_block *self,
+					   unsigned long action, void *hcpu)
+{
+	struct clock_event_device *evt = this_cpu_ptr(arch_timer_evt);
+
+	switch (action & ~CPU_TASKS_FROZEN) {
+	case CPU_STARTING:
+		arch_timer_setup(evt);
+		break;
+	case CPU_DYING:
+		arch_timer_stop(evt);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block arch_timer_cpu_nb __cpuinitdata = {
+	.notifier_call = arch_timer_cpu_notify,
+};
+
+static int __init arch_timer_register(void)
+{
+	int err;
+	int ppi;
+
+	err = arch_timer_available();
+	if (err)
+		goto out;
+
+	arch_timer_evt = alloc_percpu(struct clock_event_device);
+	if (!arch_timer_evt) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	clocksource_register_hz(&clocksource_counter, arch_timer_rate);
+	cyclecounter.mult = clocksource_counter.mult;
+	cyclecounter.shift = clocksource_counter.shift;
+	timecounter_init(&timecounter, &cyclecounter,
+			 arch_counter_get_cntpct());
+
+	if (arch_timer_use_virtual) {
+		ppi = arch_timer_ppi[VIRT_PPI];
+		err = request_percpu_irq(ppi, arch_timer_handler_virt,
+					 "arch_timer", arch_timer_evt);
+	} else {
+		ppi = arch_timer_ppi[PHYS_SECURE_PPI];
+		err = request_percpu_irq(ppi, arch_timer_handler_phys,
+					 "arch_timer", arch_timer_evt);
+		if (!err && arch_timer_ppi[PHYS_NONSECURE_PPI]) {
+			ppi = arch_timer_ppi[PHYS_NONSECURE_PPI];
+			err = request_percpu_irq(ppi, arch_timer_handler_phys,
+						 "arch_timer", arch_timer_evt);
+			if (err)
+				free_percpu_irq(arch_timer_ppi[PHYS_SECURE_PPI],
+						arch_timer_evt);
+		}
+	}
+
+	if (err) {
+		pr_err("arch_timer: can't register interrupt %d (%d)\n",
+		       ppi, err);
+		goto out_free;
+	}
+
+	err = register_cpu_notifier(&arch_timer_cpu_nb);
+	if (err)
+		goto out_free_irq;
+
+	/* Immediately configure the timer on the boot CPU */
+	arch_timer_setup(this_cpu_ptr(arch_timer_evt));
+
+	return 0;
+
+out_free_irq:
+	if (arch_timer_use_virtual)
+		free_percpu_irq(arch_timer_ppi[VIRT_PPI], arch_timer_evt);
+	else {
+		free_percpu_irq(arch_timer_ppi[PHYS_SECURE_PPI],
+				arch_timer_evt);
+		if (arch_timer_ppi[PHYS_NONSECURE_PPI])
+			free_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI],
+					arch_timer_evt);
+	}
+
+out_free:
+	free_percpu(arch_timer_evt);
+out:
+	return err;
+}
+
+static const struct of_device_id arch_timer_of_match[] __initconst = {
+	{ .compatible	= "arm,armv7-timer",	},
+	{},
+};
+
+int __init arch_timer_init(void)
+{
+	struct device_node *np;
+	u32 freq;
+	int i;
+
+	np = of_find_matching_node(NULL, arch_timer_of_match);
+	if (!np) {
+		pr_err("arch_timer: can't find DT node\n");
+		return -ENODEV;
+	}
+
+	/* Try to determine the frequency from the device tree or CNTFRQ */
+	if (!of_property_read_u32(np, "clock-frequency", &freq))
+		arch_timer_rate = freq;
+
+	for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
+		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
+
+	of_node_put(np);
+
+	/*
+	 * If no interrupt provided for virtual timer, we'll have to
+	 * stick to the physical timer. It'd better be accessible...
+	 */
+	if (!arch_timer_ppi[VIRT_PPI]) {
+		arch_timer_use_virtual = false;
+
+		if (!arch_timer_ppi[PHYS_SECURE_PPI] ||
+		    !arch_timer_ppi[PHYS_NONSECURE_PPI]) {
+			pr_warn("arch_timer: No interrupt available, giving up\n");
+			return -EINVAL;
+		}
+	}
+
+	if (arch_timer_use_virtual)
+		arch_timer_read_counter = arch_counter_get_cntvct;
+	else
+		arch_timer_read_counter = arch_counter_get_cntpct;
+
+	return arch_timer_register();
+}
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
new file mode 100644
index 0000000..b61f996
--- /dev/null
+++ b/include/clocksource/arm_arch_timer.h
@@ -0,0 +1,63 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __CLKSOURCE_ARM_ARCH_TIMER_H
+#define __CLKSOURCE_ARM_ARCH_TIMER_H
+
+#include <linux/clocksource.h>
+#include <linux/types.h>
+
+#define ARCH_TIMER_CTRL_ENABLE		(1 << 0)
+#define ARCH_TIMER_CTRL_IT_MASK		(1 << 1)
+#define ARCH_TIMER_CTRL_IT_STAT		(1 << 2)
+
+#define ARCH_TIMER_REG_CTRL		0
+#define ARCH_TIMER_REG_TVAL		1
+
+#define ARCH_TIMER_PHYS_ACCESS		0
+#define ARCH_TIMER_VIRT_ACCESS		1
+
+#ifdef CONFIG_ARM_ARCH_TIMER
+
+extern int arch_timer_init(void);
+extern u32 arch_timer_get_rate(void);
+extern u64 (*arch_timer_read_counter)(void);
+extern struct timecounter *arch_timer_get_timecounter(void);
+
+#else
+
+static inline int arch_timer_init(void)
+{
+	return -ENXIO;
+}
+
+static inline u32 arch_timer_get_rate(void)
+{
+	return 0;
+}
+
+static inline u64 arch_timer_read_counter(void)
+{
+	return 0;
+}
+
+static struct timecounter *arch_timer_get_timecounter(void)
+{
+	return NULL;
+}
+
+#endif
+
+#endif
-- 
1.8.1.1
