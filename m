From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 Jan 2013 12:15:35 +0000
Subject: [PATCHv5 12/16] arm64: move from arm_generic to arm_arch_timer
In-Reply-To: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
References: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1359634539-9580-13-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arch_timer driver supports a superset of the functionality of the
arm_generic driver, and is not tied to a particular arch.

This patch moves arm64 to use the arch_timer driver, gaining additional
functionality in doing so, and removes the (now unused) arm_generic
driver. Timer-related hooks specific to arm64 are moved into
arch/arm64/kernel/time.c.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm64/Kconfig                   |   1 +
 arch/arm64/include/asm/arch_timer.h  | 133 ++++++++++++++++++++
 arch/arm64/include/asm/arm_generic.h | 102 ---------------
 arch/arm64/kernel/time.c             |  29 ++++-
 drivers/clocksource/Kconfig          |   5 -
 drivers/clocksource/Makefile         |   1 -
 drivers/clocksource/arm_arch_timer.c |   1 +
 drivers/clocksource/arm_generic.c    | 232 -----------------------------------
 include/clocksource/arm_generic.h    |  21 ----
 9 files changed, 162 insertions(+), 363 deletions(-)
 create mode 100644 arch/arm64/include/asm/arch_timer.h
 delete mode 100644 arch/arm64/include/asm/arm_generic.h
 delete mode 100644 drivers/clocksource/arm_generic.c
 delete mode 100644 include/clocksource/arm_generic.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f8f362a..2b6cef6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -3,6 +3,7 @@ config ARM64
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARM_AMBA
+	select ARM_ARCH_TIMER
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
new file mode 100644
index 0000000..91e2a6a
--- /dev/null
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -0,0 +1,133 @@
+/*
+ * arch/arm64/include/asm/arch_timer.h
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
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
+#ifndef __ASM_ARCH_TIMER_H
+#define __ASM_ARCH_TIMER_H
+
+#include <asm/barrier.h>
+
+#include <linux/init.h>
+#include <linux/types.h>
+
+#include <clocksource/arm_arch_timer.h>
+
+static inline void arch_timer_reg_write(int access, int reg, u32 val)
+{
+	if (access == ARCH_TIMER_PHYS_ACCESS) {
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			asm volatile("msr cntp_ctl_el0,  %0" : : "r" (val));
+			break;
+		case ARCH_TIMER_REG_TVAL:
+			asm volatile("msr cntp_tval_el0, %0" : : "r" (val));
+			break;
+		default:
+			BUILD_BUG();
+		}
+	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			asm volatile("msr cntv_ctl_el0,  %0" : : "r" (val));
+			break;
+		case ARCH_TIMER_REG_TVAL:
+			asm volatile("msr cntv_tval_el0, %0" : : "r" (val));
+			break;
+		default:
+			BUILD_BUG();
+		}
+	} else {
+		BUILD_BUG();
+	}
+
+	isb();
+}
+
+static inline u32 arch_timer_reg_read(int access, int reg)
+{
+	u32 val;
+
+	if (access == ARCH_TIMER_PHYS_ACCESS) {
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			asm volatile("mrs %0,  cntp_ctl_el0" : "=r" (val));
+			break;
+		case ARCH_TIMER_REG_TVAL:
+			asm volatile("mrs %0, cntp_tval_el0" : "=r" (val));
+			break;
+		default:
+			BUILD_BUG();
+		}
+	} else if (access == ARCH_TIMER_VIRT_ACCESS) {
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			asm volatile("mrs %0,  cntv_ctl_el0" : "=r" (val));
+			break;
+		case ARCH_TIMER_REG_TVAL:
+			asm volatile("mrs %0, cntv_tval_el0" : "=r" (val));
+			break;
+		default:
+			BUILD_BUG();
+		}
+	} else {
+		BUILD_BUG();
+	}
+
+	return val;
+}
+
+static inline u32 arch_timer_get_cntfrq(void)
+{
+	u32 val;
+	asm volatile("mrs %0,   cntfrq_el0" : "=r" (val));
+	return val;
+}
+
+static inline void __cpuinit arch_counter_set_user_access(void)
+{
+	u32 cntkctl;
+
+	/* Disable user access to the timers and the physical counter. */
+	asm volatile("mrs	%0, cntkctl_el1" : "=r" (cntkctl));
+	cntkctl &= ~((3 << 8) | (1 << 0));
+
+	/* Enable user access to the virtual counter and frequency. */
+	cntkctl |= (1 << 1);
+	asm volatile("msr	cntkctl_el1, %0" : : "r" (cntkctl));
+}
+
+static inline u64 arch_counter_get_cntpct(void)
+{
+	u64 cval;
+
+	isb();
+	asm volatile("mrs %0, cntpct_el0" : "=r" (cval));
+
+	return cval;
+}
+
+static inline u64 arch_counter_get_cntvct(void)
+{
+	u64 cval;
+
+	isb();
+	asm volatile("mrs %0, cntvct_el0" : "=r" (cval));
+
+	return cval;
+}
+
+#endif
diff --git a/arch/arm64/include/asm/arm_generic.h b/arch/arm64/include/asm/arm_generic.h
deleted file mode 100644
index 6ece2f1..0000000
--- a/arch/arm64/include/asm/arm_generic.h
+++ /dev/null
@@ -1,102 +0,0 @@
-/*
- * arch/arm64/include/asm/arm_generic.h
- *
- * Copyright (C) 2012 ARM Ltd.
- * Author: Marc Zyngier <marc.zyngier@arm.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef __ASM_ARM_GENERIC_H
-#define __ASM_ARM_GENERIC_H
-
-#include <linux/clocksource.h>
-
-#define ARCH_TIMER_CTRL_ENABLE		(1 << 0)
-#define ARCH_TIMER_CTRL_IMASK		(1 << 1)
-#define ARCH_TIMER_CTRL_ISTATUS		(1 << 2)
-
-#define ARCH_TIMER_REG_CTRL		0
-#define ARCH_TIMER_REG_FREQ		1
-#define ARCH_TIMER_REG_TVAL		2
-
-static inline void arch_timer_reg_write(int reg, u32 val)
-{
-	switch (reg) {
-	case ARCH_TIMER_REG_CTRL:
-		asm volatile("msr cntp_ctl_el0,  %0" : : "r" (val));
-		break;
-	case ARCH_TIMER_REG_TVAL:
-		asm volatile("msr cntp_tval_el0, %0" : : "r" (val));
-		break;
-	default:
-		BUILD_BUG();
-	}
-
-	isb();
-}
-
-static inline u32 arch_timer_reg_read(int reg)
-{
-	u32 val;
-
-	switch (reg) {
-	case ARCH_TIMER_REG_CTRL:
-		asm volatile("mrs %0,  cntp_ctl_el0" : "=r" (val));
-		break;
-	case ARCH_TIMER_REG_FREQ:
-		asm volatile("mrs %0,   cntfrq_el0" : "=r" (val));
-		break;
-	case ARCH_TIMER_REG_TVAL:
-		asm volatile("mrs %0, cntp_tval_el0" : "=r" (val));
-		break;
-	default:
-		BUILD_BUG();
-	}
-
-	return val;
-}
-
-static inline void __cpuinit arch_counter_enable_user_access(void)
-{
-	u32 cntkctl;
-
-	/* Disable user access to the timers and the physical counter. */
-	asm volatile("mrs	%0, cntkctl_el1" : "=r" (cntkctl));
-	cntkctl &= ~((3 << 8) | (1 << 0));
-
-	/* Enable user access to the virtual counter and frequency. */
-	cntkctl |= (1 << 1);
-	asm volatile("msr	cntkctl_el1, %0" : : "r" (cntkctl));
-}
-
-static inline cycle_t arch_counter_get_cntpct(void)
-{
-	cycle_t cval;
-
-	isb();
-	asm volatile("mrs %0, cntpct_el0" : "=r" (cval));
-
-	return cval;
-}
-
-static inline cycle_t arch_counter_get_cntvct(void)
-{
-	cycle_t cval;
-
-	isb();
-	asm volatile("mrs %0, cntvct_el0" : "=r" (cval));
-
-	return cval;
-}
-
-#endif
diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
index 3b4b725..b0ef18d 100644
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -31,8 +31,9 @@
 #include <linux/syscore_ops.h>
 #include <linux/timer.h>
 #include <linux/irq.h>
+#include <linux/delay.h>
 
-#include <clocksource/arm_generic.h>
+#include <clocksource/arm_arch_timer.h>
 
 #include <asm/thread_info.h>
 #include <asm/stacktrace.h>
@@ -59,7 +60,31 @@ unsigned long profile_pc(struct pt_regs *regs)
 EXPORT_SYMBOL(profile_pc);
 #endif
 
+static u64 sched_clock_mult __read_mostly;
+
+unsigned long long notrace sched_clock(void)
+{
+	return arch_timer_read_counter() * sched_clock_mult;
+}
+
+int read_current_timer(unsigned long *timer_value)
+{
+	*timer_value = arch_timer_read_counter();
+	return 0;
+}
+
 void __init time_init(void)
 {
-	arm_generic_timer_init();
+	u32 arch_timer_rate;
+
+	if (arch_timer_init())
+		panic("Unable to initialise architected timer.\n");
+
+	arch_timer_rate = arch_timer_get_rate();
+
+	/* Cache the sched_clock multiplier to save a divide in the hot path. */
+	sched_clock_mult = NSEC_PER_SEC / arch_timer_rate;
+
+	/* Calibrate the delay loop directly */
+	lpj_fine = arch_timer_rate / HZ;
 }
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index dbb085a..6479842 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -54,10 +54,5 @@ config CLKSRC_DBX500_PRCMU_SCHED_CLOCK
 	help
 	  Use the always on PRCMU Timer as sched_clock
 
-config CLKSRC_ARM_GENERIC
-	def_bool y if ARM64
-	help
-	  This option enables support for the ARM generic timer.
-
 config ARM_ARCH_TIMER
 	bool
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 32f858c..e69511c 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -17,5 +17,4 @@ obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
 obj-$(CONFIG_SUNXI_TIMER)	+= sunxi_timer.o
 
-obj-$(CONFIG_CLKSRC_ARM_GENERIC)	+= arm_generic.o
 obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 3e4739d..ec30a73 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -338,6 +338,7 @@ out:
 
 static const struct of_device_id arch_timer_of_match[] __initconst = {
 	{ .compatible	= "arm,armv7-timer",	},
+	{ .compatible	= "arm,armv8-timer",	},
 	{},
 };
 
diff --git a/drivers/clocksource/arm_generic.c b/drivers/clocksource/arm_generic.c
deleted file mode 100644
index 8ae1a61..0000000
--- a/drivers/clocksource/arm_generic.c
+++ /dev/null
@@ -1,232 +0,0 @@
-/*
- * Generic timers support
- *
- * Copyright (C) 2012 ARM Ltd.
- * Author: Marc Zyngier <marc.zyngier@arm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/smp.h>
-#include <linux/cpu.h>
-#include <linux/jiffies.h>
-#include <linux/interrupt.h>
-#include <linux/clockchips.h>
-#include <linux/of_irq.h>
-#include <linux/io.h>
-
-#include <clocksource/arm_generic.h>
-
-#include <asm/arm_generic.h>
-
-static u32 arch_timer_rate;
-static u64 sched_clock_mult __read_mostly;
-static DEFINE_PER_CPU(struct clock_event_device, arch_timer_evt);
-static int arch_timer_ppi;
-
-static irqreturn_t arch_timer_handle_irq(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-	unsigned long ctrl;
-
-	ctrl = arch_timer_reg_read(ARCH_TIMER_REG_CTRL);
-	if (ctrl & ARCH_TIMER_CTRL_ISTATUS) {
-		ctrl |= ARCH_TIMER_CTRL_IMASK;
-		arch_timer_reg_write(ARCH_TIMER_REG_CTRL, ctrl);
-		evt->event_handler(evt);
-		return IRQ_HANDLED;
-	}
-
-	return IRQ_NONE;
-}
-
-static void arch_timer_stop(void)
-{
-	unsigned long ctrl;
-
-	ctrl = arch_timer_reg_read(ARCH_TIMER_REG_CTRL);
-	ctrl &= ~ARCH_TIMER_CTRL_ENABLE;
-	arch_timer_reg_write(ARCH_TIMER_REG_CTRL, ctrl);
-}
-
-static void arch_timer_set_mode(enum clock_event_mode mode,
-				struct clock_event_device *clk)
-{
-	switch (mode) {
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		arch_timer_stop();
-		break;
-	default:
-		break;
-	}
-}
-
-static int arch_timer_set_next_event(unsigned long evt,
-				     struct clock_event_device *unused)
-{
-	unsigned long ctrl;
-
-	ctrl = arch_timer_reg_read(ARCH_TIMER_REG_CTRL);
-	ctrl |= ARCH_TIMER_CTRL_ENABLE;
-	ctrl &= ~ARCH_TIMER_CTRL_IMASK;
-
-	arch_timer_reg_write(ARCH_TIMER_REG_TVAL, evt);
-	arch_timer_reg_write(ARCH_TIMER_REG_CTRL, ctrl);
-
-	return 0;
-}
-
-static void __cpuinit arch_timer_setup(struct clock_event_device *clk)
-{
-	/* Let's make sure the timer is off before doing anything else */
-	arch_timer_stop();
-
-	clk->features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP;
-	clk->name = "arch_sys_timer";
-	clk->rating = 400;
-	clk->set_mode = arch_timer_set_mode;
-	clk->set_next_event = arch_timer_set_next_event;
-	clk->irq = arch_timer_ppi;
-	clk->cpumask = cpumask_of(smp_processor_id());
-
-	clockevents_config_and_register(clk, arch_timer_rate,
-					0xf, 0x7fffffff);
-
-	enable_percpu_irq(clk->irq, 0);
-
-	/* Ensure the virtual counter is visible to userspace for the vDSO. */
-	arch_counter_enable_user_access();
-}
-
-static void __init arch_timer_calibrate(void)
-{
-	if (arch_timer_rate == 0) {
-		arch_timer_reg_write(ARCH_TIMER_REG_CTRL, 0);
-		arch_timer_rate = arch_timer_reg_read(ARCH_TIMER_REG_FREQ);
-
-		/* Check the timer frequency. */
-		if (arch_timer_rate == 0)
-			panic("Architected timer frequency is set to zero.\n"
-			      "You must set this in your .dts file\n");
-	}
-
-	/* Cache the sched_clock multiplier to save a divide in the hot path. */
-
-	sched_clock_mult = DIV_ROUND_CLOSEST(NSEC_PER_SEC, arch_timer_rate);
-
-	pr_info("Architected local timer running at %u.%02uMHz.\n",
-		 arch_timer_rate / 1000000, (arch_timer_rate / 10000) % 100);
-}
-
-static cycle_t arch_counter_read(struct clocksource *cs)
-{
-	return arch_counter_get_cntpct();
-}
-
-static struct clocksource clocksource_counter = {
-	.name	= "arch_sys_counter",
-	.rating	= 400,
-	.read	= arch_counter_read,
-	.mask	= CLOCKSOURCE_MASK(56),
-	.flags	= (CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_VALID_FOR_HRES),
-};
-
-int read_current_timer(unsigned long *timer_value)
-{
-	*timer_value = arch_counter_get_cntpct();
-	return 0;
-}
-
-unsigned long long notrace sched_clock(void)
-{
-	return arch_counter_get_cntvct() * sched_clock_mult;
-}
-
-static int __cpuinit arch_timer_cpu_notify(struct notifier_block *self,
-					   unsigned long action, void *hcpu)
-{
-	int cpu = (long)hcpu;
-	struct clock_event_device *clk = per_cpu_ptr(&arch_timer_evt, cpu);
-
-	switch(action) {
-	case CPU_STARTING:
-	case CPU_STARTING_FROZEN:
-		arch_timer_setup(clk);
-		break;
-
-	case CPU_DYING:
-	case CPU_DYING_FROZEN:
-		pr_debug("arch_timer_teardown disable IRQ%d cpu #%d\n",
-			 clk->irq, cpu);
-		disable_percpu_irq(clk->irq);
-		arch_timer_set_mode(CLOCK_EVT_MODE_UNUSED, clk);
-		break;
-	}
-
-	return NOTIFY_OK;
-}
-
-static struct notifier_block __cpuinitdata arch_timer_cpu_nb = {
-	.notifier_call = arch_timer_cpu_notify,
-};
-
-static const struct of_device_id arch_timer_of_match[] __initconst = {
-	{ .compatible = "arm,armv8-timer" },
-	{},
-};
-
-int __init arm_generic_timer_init(void)
-{
-	struct device_node *np;
-	int err;
-	u32 freq;
-
-	np = of_find_matching_node(NULL, arch_timer_of_match);
-	if (!np) {
-		pr_err("arch_timer: can't find DT node\n");
-		return -ENODEV;
-	}
-
-	/* Try to determine the frequency from the device tree or CNTFRQ */
-	if (!of_property_read_u32(np, "clock-frequency", &freq))
-		arch_timer_rate = freq;
-	arch_timer_calibrate();
-
-	arch_timer_ppi = irq_of_parse_and_map(np, 0);
-	pr_info("arch_timer: found %s irq %d\n", np->name, arch_timer_ppi);
-
-	err = request_percpu_irq(arch_timer_ppi, arch_timer_handle_irq,
-				 np->name, &arch_timer_evt);
-	if (err) {
-		pr_err("arch_timer: can't register interrupt %d (%d)\n",
-		       arch_timer_ppi, err);
-		return err;
-	}
-
-	clocksource_register_hz(&clocksource_counter, arch_timer_rate);
-
-	/* Calibrate the delay loop directly */
-	lpj_fine = DIV_ROUND_CLOSEST(arch_timer_rate, HZ);
-
-	/* Immediately configure the timer on the boot CPU */
-	arch_timer_setup(this_cpu_ptr(&arch_timer_evt));
-
-	register_cpu_notifier(&arch_timer_cpu_nb);
-
-	return 0;
-}
diff --git a/include/clocksource/arm_generic.h b/include/clocksource/arm_generic.h
deleted file mode 100644
index 5b41b0d..0000000
--- a/include/clocksource/arm_generic.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef __CLKSOURCE_ARM_GENERIC_H
-#define __CLKSOURCE_ARM_GENERIC_H
-
-extern int arm_generic_timer_init(void);
-
-#endif
-- 
1.8.1.1
