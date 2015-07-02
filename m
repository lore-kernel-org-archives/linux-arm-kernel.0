From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  2 Jul 2015 18:12:36 +0100
Subject: [PATCHv4 4/5] ARM: migrate to common PSCI client code
In-Reply-To: <1435857157-24952-1-git-send-email-mark.rutland@arm.com>
References: <1435857157-24952-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1435857157-24952-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the common PSCI client code has been factored out to
drivers/firmware, and made safe for 32-bit use, move the 32-bit ARM code
over to it. This results in a moderate reduction of duplicated lines,
and will prevent further duplication as the PSCI client code is updated
for PSCI 1.0 and beyond.

The two legacy platform users of the PSCI invocation code are updated to
account for interface changes. In both cases the power state parameter
(which is constant) is now generated using macros, so that the
pack/unpack logic can be killed in preparation for PSCI 1.0 power state
changes.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig                  |   1 +
 arch/arm/include/asm/psci.h       |  23 ---
 arch/arm/kernel/Makefile          |   2 +-
 arch/arm/kernel/psci.c            | 299 --------------------------------------
 arch/arm/kernel/psci_smp.c        |  29 +++-
 arch/arm/kernel/setup.c           |   3 +-
 arch/arm/mach-highbank/highbank.c |   2 +-
 arch/arm/mach-highbank/pm.c       |  16 +-
 drivers/cpuidle/cpuidle-calxeda.c |  15 +-
 9 files changed, 46 insertions(+), 344 deletions(-)
 delete mode 100644 arch/arm/kernel/psci.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a750c14..36516e4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1496,6 +1496,7 @@ config HOTPLUG_CPU
 config ARM_PSCI
 	bool "Support for the ARM Power State Coordination Interface (PSCI)"
 	depends on CPU_V7
+	select ARM_PSCI_FW
 	help
 	  Say Y here if you want Linux to communicate with system firmware
 	  implementing the PSCI specification for CPU-centric power
diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
index c25ef3e..68ee3ce 100644
--- a/arch/arm/include/asm/psci.h
+++ b/arch/arm/include/asm/psci.h
@@ -14,34 +14,11 @@
 #ifndef __ASM_ARM_PSCI_H
 #define __ASM_ARM_PSCI_H
 
-#define PSCI_POWER_STATE_TYPE_STANDBY		0
-#define PSCI_POWER_STATE_TYPE_POWER_DOWN	1
-
-struct psci_power_state {
-	u16	id;
-	u8	type;
-	u8	affinity_level;
-};
-
-struct psci_operations {
-	int (*cpu_suspend)(struct psci_power_state state,
-			   unsigned long entry_point);
-	int (*cpu_off)(struct psci_power_state state);
-	int (*cpu_on)(unsigned long cpuid, unsigned long entry_point);
-	int (*migrate)(unsigned long cpuid);
-	int (*affinity_info)(unsigned long target_affinity,
-			unsigned long lowest_affinity_level);
-	int (*migrate_info_type)(void);
-};
-
-extern struct psci_operations psci_ops;
 extern struct smp_operations psci_smp_ops;
 
 #ifdef CONFIG_ARM_PSCI
-int psci_init(void);
 bool psci_smp_available(void);
 #else
-static inline int psci_init(void) { return 0; }
 static inline bool psci_smp_available(void) { return false; }
 #endif
 
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index e69f7a1..3b995f5 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -89,7 +89,7 @@ obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-$(CONFIG_ARM_VIRT_EXT)	+= hyp-stub.o
 ifeq ($(CONFIG_ARM_PSCI),y)
-obj-y				+= psci.o psci-call.o
+obj-y				+= psci-call.o
 obj-$(CONFIG_SMP)		+= psci_smp.o
 endif
 
diff --git a/arch/arm/kernel/psci.c b/arch/arm/kernel/psci.c
deleted file mode 100644
index f90fdf4..0000000
--- a/arch/arm/kernel/psci.c
+++ /dev/null
@@ -1,299 +0,0 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * Copyright (C) 2012 ARM Limited
- *
- * Author: Will Deacon <will.deacon@arm.com>
- */
-
-#define pr_fmt(fmt) "psci: " fmt
-
-#include <linux/init.h>
-#include <linux/of.h>
-#include <linux/reboot.h>
-#include <linux/pm.h>
-#include <uapi/linux/psci.h>
-
-#include <asm/compiler.h>
-#include <asm/errno.h>
-#include <asm/psci.h>
-#include <asm/system_misc.h>
-
-struct psci_operations psci_ops;
-
-static int (*invoke_psci_fn)(u32, u32, u32, u32);
-typedef int (*psci_initcall_t)(const struct device_node *);
-
-asmlinkage int __invoke_psci_fn_hvc(u32, u32, u32, u32);
-asmlinkage int __invoke_psci_fn_smc(u32, u32, u32, u32);
-
-enum psci_function {
-	PSCI_FN_CPU_SUSPEND,
-	PSCI_FN_CPU_ON,
-	PSCI_FN_CPU_OFF,
-	PSCI_FN_MIGRATE,
-	PSCI_FN_AFFINITY_INFO,
-	PSCI_FN_MIGRATE_INFO_TYPE,
-	PSCI_FN_MAX,
-};
-
-static u32 psci_function_id[PSCI_FN_MAX];
-
-static int psci_to_linux_errno(int errno)
-{
-	switch (errno) {
-	case PSCI_RET_SUCCESS:
-		return 0;
-	case PSCI_RET_NOT_SUPPORTED:
-		return -EOPNOTSUPP;
-	case PSCI_RET_INVALID_PARAMS:
-		return -EINVAL;
-	case PSCI_RET_DENIED:
-		return -EPERM;
-	};
-
-	return -EINVAL;
-}
-
-static u32 psci_power_state_pack(struct psci_power_state state)
-{
-	return ((state.id << PSCI_0_2_POWER_STATE_ID_SHIFT)
-			& PSCI_0_2_POWER_STATE_ID_MASK) |
-		((state.type << PSCI_0_2_POWER_STATE_TYPE_SHIFT)
-		 & PSCI_0_2_POWER_STATE_TYPE_MASK) |
-		((state.affinity_level << PSCI_0_2_POWER_STATE_AFFL_SHIFT)
-		 & PSCI_0_2_POWER_STATE_AFFL_MASK);
-}
-
-static int psci_get_version(void)
-{
-	int err;
-
-	err = invoke_psci_fn(PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0);
-	return err;
-}
-
-static int psci_cpu_suspend(struct psci_power_state state,
-			    unsigned long entry_point)
-{
-	int err;
-	u32 fn, power_state;
-
-	fn = psci_function_id[PSCI_FN_CPU_SUSPEND];
-	power_state = psci_power_state_pack(state);
-	err = invoke_psci_fn(fn, power_state, entry_point, 0);
-	return psci_to_linux_errno(err);
-}
-
-static int psci_cpu_off(struct psci_power_state state)
-{
-	int err;
-	u32 fn, power_state;
-
-	fn = psci_function_id[PSCI_FN_CPU_OFF];
-	power_state = psci_power_state_pack(state);
-	err = invoke_psci_fn(fn, power_state, 0, 0);
-	return psci_to_linux_errno(err);
-}
-
-static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
-{
-	int err;
-	u32 fn;
-
-	fn = psci_function_id[PSCI_FN_CPU_ON];
-	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
-	return psci_to_linux_errno(err);
-}
-
-static int psci_migrate(unsigned long cpuid)
-{
-	int err;
-	u32 fn;
-
-	fn = psci_function_id[PSCI_FN_MIGRATE];
-	err = invoke_psci_fn(fn, cpuid, 0, 0);
-	return psci_to_linux_errno(err);
-}
-
-static int psci_affinity_info(unsigned long target_affinity,
-		unsigned long lowest_affinity_level)
-{
-	int err;
-	u32 fn;
-
-	fn = psci_function_id[PSCI_FN_AFFINITY_INFO];
-	err = invoke_psci_fn(fn, target_affinity, lowest_affinity_level, 0);
-	return err;
-}
-
-static int psci_migrate_info_type(void)
-{
-	int err;
-	u32 fn;
-
-	fn = psci_function_id[PSCI_FN_MIGRATE_INFO_TYPE];
-	err = invoke_psci_fn(fn, 0, 0, 0);
-	return err;
-}
-
-static int get_set_conduit_method(struct device_node *np)
-{
-	const char *method;
-
-	pr_info("probing for conduit method from DT.\n");
-
-	if (of_property_read_string(np, "method", &method)) {
-		pr_warn("missing \"method\" property\n");
-		return -ENXIO;
-	}
-
-	if (!strcmp("hvc", method)) {
-		invoke_psci_fn = __invoke_psci_fn_hvc;
-	} else if (!strcmp("smc", method)) {
-		invoke_psci_fn = __invoke_psci_fn_smc;
-	} else {
-		pr_warn("invalid \"method\" property: %s\n", method);
-		return -EINVAL;
-	}
-	return 0;
-}
-
-static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
-{
-	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
-}
-
-static void psci_sys_poweroff(void)
-{
-	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
-}
-
-/*
- * PSCI Function IDs for v0.2+ are well defined so use
- * standard values.
- */
-static int psci_0_2_init(struct device_node *np)
-{
-	int err, ver;
-
-	err = get_set_conduit_method(np);
-
-	if (err)
-		goto out_put_node;
-
-	ver = psci_get_version();
-
-	if (ver == PSCI_RET_NOT_SUPPORTED) {
-		/* PSCI v0.2 mandates implementation of PSCI_ID_VERSION. */
-		pr_err("PSCI firmware does not comply with the v0.2 spec.\n");
-		err = -EOPNOTSUPP;
-		goto out_put_node;
-	} else {
-		pr_info("PSCIv%d.%d detected in firmware.\n",
-				PSCI_VERSION_MAJOR(ver),
-				PSCI_VERSION_MINOR(ver));
-
-		if (PSCI_VERSION_MAJOR(ver) == 0 &&
-				PSCI_VERSION_MINOR(ver) < 2) {
-			err = -EINVAL;
-			pr_err("Conflicting PSCI version detected.\n");
-			goto out_put_node;
-		}
-	}
-
-	pr_info("Using standard PSCI v0.2 function IDs\n");
-	psci_function_id[PSCI_FN_CPU_SUSPEND] = PSCI_0_2_FN_CPU_SUSPEND;
-	psci_ops.cpu_suspend = psci_cpu_suspend;
-
-	psci_function_id[PSCI_FN_CPU_OFF] = PSCI_0_2_FN_CPU_OFF;
-	psci_ops.cpu_off = psci_cpu_off;
-
-	psci_function_id[PSCI_FN_CPU_ON] = PSCI_0_2_FN_CPU_ON;
-	psci_ops.cpu_on = psci_cpu_on;
-
-	psci_function_id[PSCI_FN_MIGRATE] = PSCI_0_2_FN_MIGRATE;
-	psci_ops.migrate = psci_migrate;
-
-	psci_function_id[PSCI_FN_AFFINITY_INFO] = PSCI_0_2_FN_AFFINITY_INFO;
-	psci_ops.affinity_info = psci_affinity_info;
-
-	psci_function_id[PSCI_FN_MIGRATE_INFO_TYPE] =
-		PSCI_0_2_FN_MIGRATE_INFO_TYPE;
-	psci_ops.migrate_info_type = psci_migrate_info_type;
-
-	arm_pm_restart = psci_sys_reset;
-
-	pm_power_off = psci_sys_poweroff;
-
-out_put_node:
-	of_node_put(np);
-	return err;
-}
-
-/*
- * PSCI < v0.2 get PSCI Function IDs via DT.
- */
-static int psci_0_1_init(struct device_node *np)
-{
-	u32 id;
-	int err;
-
-	err = get_set_conduit_method(np);
-
-	if (err)
-		goto out_put_node;
-
-	pr_info("Using PSCI v0.1 Function IDs from DT\n");
-
-	if (!of_property_read_u32(np, "cpu_suspend", &id)) {
-		psci_function_id[PSCI_FN_CPU_SUSPEND] = id;
-		psci_ops.cpu_suspend = psci_cpu_suspend;
-	}
-
-	if (!of_property_read_u32(np, "cpu_off", &id)) {
-		psci_function_id[PSCI_FN_CPU_OFF] = id;
-		psci_ops.cpu_off = psci_cpu_off;
-	}
-
-	if (!of_property_read_u32(np, "cpu_on", &id)) {
-		psci_function_id[PSCI_FN_CPU_ON] = id;
-		psci_ops.cpu_on = psci_cpu_on;
-	}
-
-	if (!of_property_read_u32(np, "migrate", &id)) {
-		psci_function_id[PSCI_FN_MIGRATE] = id;
-		psci_ops.migrate = psci_migrate;
-	}
-
-out_put_node:
-	of_node_put(np);
-	return err;
-}
-
-static const struct of_device_id psci_of_match[] __initconst = {
-	{ .compatible = "arm,psci", .data = psci_0_1_init},
-	{ .compatible = "arm,psci-0.2", .data = psci_0_2_init},
-	{},
-};
-
-int __init psci_init(void)
-{
-	struct device_node *np;
-	const struct of_device_id *matched_np;
-	psci_initcall_t init_fn;
-
-	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
-	if (!np)
-		return -ENODEV;
-
-	init_fn = (psci_initcall_t)matched_np->data;
-	return init_fn(np);
-}
diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
index 244aadd..61c04b0 100644
--- a/arch/arm/kernel/psci_smp.c
+++ b/arch/arm/kernel/psci_smp.c
@@ -17,6 +17,8 @@
 #include <linux/smp.h>
 #include <linux/of.h>
 #include <linux/delay.h>
+#include <linux/psci.h>
+
 #include <uapi/linux/psci.h>
 
 #include <asm/psci.h>
@@ -56,17 +58,29 @@ static int psci_boot_secondary(unsigned int cpu, struct task_struct *idle)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
+int psci_cpu_disable(unsigned int cpu)
+{
+	/* Fail early if we don't have CPU_OFF support */
+	if (!psci_ops.cpu_off)
+		return -EOPNOTSUPP;
+
+	/* Trusted OS will deny CPU_OFF */
+	if (psci_tos_resident_on(cpu))
+		return -EPERM;
+
+	return 0;
+}
+
 void __ref psci_cpu_die(unsigned int cpu)
 {
-       const struct psci_power_state ps = {
-               .type = PSCI_POWER_STATE_TYPE_POWER_DOWN,
-       };
+	u32 state = PSCI_POWER_STATE_TYPE_POWER_DOWN <<
+		    PSCI_0_2_POWER_STATE_TYPE_SHIFT;
 
-       if (psci_ops.cpu_off)
-               psci_ops.cpu_off(ps);
+	if (psci_ops.cpu_off)
+		psci_ops.cpu_off(state);
 
-       /* We should never return */
-       panic("psci: cpu %d failed to shutdown\n", cpu);
+	/* We should never return */
+	panic("psci: cpu %d failed to shutdown\n", cpu);
 }
 
 int __ref psci_cpu_kill(unsigned int cpu)
@@ -109,6 +123,7 @@ bool __init psci_smp_available(void)
 struct smp_operations __initdata psci_smp_ops = {
 	.smp_boot_secondary	= psci_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable		= psci_cpu_disable,
 	.cpu_die		= psci_cpu_die,
 	.cpu_kill		= psci_cpu_kill,
 #endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 36c18b7..9c38bd4 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -31,6 +31,7 @@
 #include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/sort.h>
+#include <linux/psci.h>
 
 #include <asm/unified.h>
 #include <asm/cp15.h>
@@ -972,7 +973,7 @@ void __init setup_arch(char **cmdline_p)
 	unflatten_device_tree();
 
 	arm_dt_init_cpu_maps();
-	psci_init();
+	psci_dt_init();
 	xen_early_init();
 #ifdef CONFIG_SMP
 	if (is_smp()) {
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 231fba0..6050a14 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -28,8 +28,8 @@
 #include <linux/reboot.h>
 #include <linux/amba/bus.h>
 #include <linux/platform_device.h>
+#include <linux/psci.h>
 
-#include <asm/psci.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-highbank/pm.c b/arch/arm/mach-highbank/pm.c
index 7f2bd85..4003116 100644
--- a/arch/arm/mach-highbank/pm.c
+++ b/arch/arm/mach-highbank/pm.c
@@ -16,19 +16,21 @@
 
 #include <linux/cpu_pm.h>
 #include <linux/init.h>
+#include <linux/psci.h>
 #include <linux/suspend.h>
 
 #include <asm/suspend.h>
-#include <asm/psci.h>
+
+#include <uapi/linux/psci.h>
+
+#define HIGHBANK_SUSPEND_PARAM \
+	((0 << PSCI_0_2_POWER_STATE_ID_SHIFT) | \
+	 (1 << PSCI_0_2_POWER_STATE_AFFL_SHIFT) | \
+	 (PSCI_POWER_STATE_TYPE_POWER_DOWN << PSCI_0_2_POWER_STATE_TYPE_SHIFT))
 
 static int highbank_suspend_finish(unsigned long val)
 {
-	const struct psci_power_state ps = {
-		.type = PSCI_POWER_STATE_TYPE_POWER_DOWN,
-		.affinity_level = 1,
-	};
-
-	return psci_ops.cpu_suspend(ps, __pa(cpu_resume));
+	return psci_ops.cpu_suspend(HIGHBANK_SUSPEND_PARAM, __pa(cpu_resume));
 }
 
 static int highbank_pm_enter(suspend_state_t state)
diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
index 9445e6c..1c3242c 100644
--- a/drivers/cpuidle/cpuidle-calxeda.c
+++ b/drivers/cpuidle/cpuidle-calxeda.c
@@ -25,16 +25,21 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/platform_device.h>
+#include <linux/psci.h>
+
 #include <asm/cpuidle.h>
 #include <asm/suspend.h>
-#include <asm/psci.h>
+
+#include <uapi/linux/psci.h>
+
+#define CALXEDA_IDLE_PARAM \
+	((0 << PSCI_0_2_POWER_STATE_ID_SHIFT) | \
+	 (0 << PSCI_0_2_POWER_STATE_AFFL_SHIFT) | \
+	 (PSCI_POWER_STATE_TYPE_POWER_DOWN << PSCI_0_2_POWER_STATE_TYPE_SHIFT))
 
 static int calxeda_idle_finish(unsigned long val)
 {
-	const struct psci_power_state ps = {
-		.type = PSCI_POWER_STATE_TYPE_POWER_DOWN,
-	};
-	return psci_ops.cpu_suspend(ps, __pa(cpu_resume));
+	return psci_ops.cpu_suspend(CALXEDA_IDLE_PARAM, __pa(cpu_resume));
 }
 
 static int calxeda_pwrdown_idle(struct cpuidle_device *dev,
-- 
1.9.1
