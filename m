From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon,  1 Sep 2014 16:28:42 +0100
Subject: [PATCH v8 6/8] drivers: cpuidle: CPU idle ARM64 driver
In-Reply-To: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1409585324-3678-7-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements a generic CPU idle driver for ARM64 machines.

It relies on the DT idle states infrastructure to initialize idle
states count and respective parameters. Current code assumes the driver
is managing idle states on all possible CPUs but can be easily
generalized to support heterogenous systems and build cpumasks at
runtime using MIDRs or DT cpu nodes compatible properties.

The driver relies on the arm64 CPU operations to call the idle
initialization hook used to parse and save suspend back-end specific
idle states information upon probing.

Idle state index 0 is always initialized as a simple wfi state, ie always
considered present and functional on all ARM64 platforms.

Idle state indices higher than 0 trigger idle state entry by calling
the cpu_suspend function, that triggers the suspend operation through
the CPU operations suspend back-end hook. cpu_suspend passes the idle
state index as a parameter so that the CPU operations suspend back-end
can retrieve the required idle state data by using the idle state
index to execute a look-up on its internal data structures.

Reviewed-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/cpuidle/Kconfig         |   5 ++
 drivers/cpuidle/Kconfig.arm64   |  14 +++++
 drivers/cpuidle/Makefile        |   4 ++
 drivers/cpuidle/cpuidle-arm64.c | 121 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 144 insertions(+)
 create mode 100644 drivers/cpuidle/Kconfig.arm64
 create mode 100644 drivers/cpuidle/cpuidle-arm64.c

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 8deb934..c5029c1 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -33,6 +33,11 @@ depends on ARM
 source "drivers/cpuidle/Kconfig.arm"
 endmenu
 
+menu "ARM64 CPU Idle Drivers"
+depends on ARM64
+source "drivers/cpuidle/Kconfig.arm64"
+endmenu
+
 menu "MIPS CPU Idle Drivers"
 depends on MIPS
 source "drivers/cpuidle/Kconfig.mips"
diff --git a/drivers/cpuidle/Kconfig.arm64 b/drivers/cpuidle/Kconfig.arm64
new file mode 100644
index 0000000..d0a08ed
--- /dev/null
+++ b/drivers/cpuidle/Kconfig.arm64
@@ -0,0 +1,14 @@
+#
+# ARM64 CPU Idle drivers
+#
+
+config ARM64_CPUIDLE
+	bool "Generic ARM64 CPU idle Driver"
+	select ARM64_CPU_SUSPEND
+	select DT_IDLE_STATES
+	help
+	  Select this to enable generic cpuidle driver for ARM64.
+	  It provides a generic idle driver whose idle states are configured
+	  at run-time through DT nodes. The CPUidle suspend backend is
+	  initialized by calling the CPU operations init idle hook
+	  provided by architecture code.
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 002b653..4d177b9 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -23,6 +23,10 @@ obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
 obj-$(CONFIG_MIPS_CPS_CPUIDLE)		+= cpuidle-cps.o
 
 ###############################################################################
+# ARM64 drivers
+obj-$(CONFIG_ARM64_CPUIDLE)		+= cpuidle-arm64.o
+
+###############################################################################
 # POWERPC drivers
 obj-$(CONFIG_PSERIES_CPUIDLE)		+= cpuidle-pseries.o
 obj-$(CONFIG_POWERNV_CPUIDLE)		+= cpuidle-powernv.o
diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
new file mode 100644
index 0000000..d25fe6f
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-arm64.c
@@ -0,0 +1,121 @@
+/*
+ * ARM64 generic CPU idle driver.
+ *
+ * Copyright (C) 2014 ARM Ltd.
+ * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt) "CPUidle arm64: " fmt
+
+#include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/cpu_pm.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include <asm/cpuidle.h>
+#include <asm/suspend.h>
+
+#include "dt_idle_states.h"
+
+/*
+ * arm64_enter_idle_state - Programs CPU to enter the specified state
+ *
+ * dev: cpuidle device
+ * drv: cpuidle driver
+ * idx: state index
+ *
+ * Called from the CPUidle framework to program the device to the
+ * specified target state selected by the governor.
+ */
+static int arm64_enter_idle_state(struct cpuidle_device *dev,
+				  struct cpuidle_driver *drv, int idx)
+{
+	int ret;
+
+	if (!idx) {
+		cpu_do_idle();
+		return idx;
+	}
+
+	ret = cpu_pm_enter();
+	if (!ret) {
+		/*
+		 * Pass idle state index to cpu_suspend which in turn will
+		 * call the CPU ops suspend protocol with idle index as a
+		 * parameter.
+		 */
+		ret = cpu_suspend(idx);
+
+		cpu_pm_exit();
+	}
+
+	return ret ? -1 : idx;
+}
+
+static struct cpuidle_driver arm64_idle_driver = {
+	.name = "arm64_idle",
+	.owner = THIS_MODULE,
+	/*
+	 * State at index 0 is standby wfi and considered standard
+	 * on all ARM platforms. If in some platforms simple wfi
+	 * can't be used as "state 0", DT bindings must be implemented
+	 * to work around this issue and allow installing a special
+	 * handler for idle state index 0.
+	 */
+	.states[0] = {
+		.enter                  = arm64_enter_idle_state,
+		.exit_latency           = 1,
+		.target_residency       = 1,
+		.power_usage		= UINT_MAX,
+		.flags                  = CPUIDLE_FLAG_TIME_VALID,
+		.name                   = "WFI",
+		.desc                   = "ARM64 WFI",
+	}
+};
+
+static const struct of_device_id arm64_idle_state_match[] __initconst = {
+	{ .compatible = "arm,idle-state",
+	  .data = arm64_enter_idle_state },
+	{ },
+};
+
+/*
+ * arm64_idle_init
+ *
+ * Registers the arm64 specific cpuidle driver with the cpuidle
+ * framework. It relies on core code to parse the idle states
+ * and initialize them using driver data structures accordingly.
+ */
+static int __init arm64_idle_init(void)
+{
+	int cpu, ret;
+	struct cpuidle_driver *drv = &arm64_idle_driver;
+
+	/*
+	 * Initialize idle states data, starting at index 1.
+	 * This driver is DT only, if no DT idle states are detected (ret == 0)
+	 * let the driver initialization fail accordingly since there is no
+	 * reason to initialize the idle driver if only wfi is supported.
+	 */
+	ret = dt_init_idle_driver(drv, arm64_idle_state_match, 1);
+	if (ret <= 0)
+		return ret;
+	/*
+	 * Call arch CPU operations in order to initialize
+	 * idle states suspend back-end specific data
+	 */
+	for_each_possible_cpu(cpu) {
+		ret = cpu_init_idle(cpu);
+		if (ret)
+			return ret;
+	}
+
+	return cpuidle_register(drv, NULL);
+}
+device_initcall(arm64_idle_init);
-- 
1.9.1
