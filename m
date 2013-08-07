From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed,  7 Aug 2013 12:43:33 +0100
Subject: [PATCH v3 3/3] cpuidle: big.LITTLE: vexpress-TC2 CPU idle driver
In-Reply-To: <1375875813-13358-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1375875813-13358-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1375875813-13358-4-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The big.LITTLE architecture is composed of two clusters of cpus. One cluster
contains less powerful but more energy efficient processors and the other
cluster groups the powerful but energy-intensive cpus.

The TC2 testchip implements two clusters of CPUs (A7 and A15 clusters in
a big.LITTLE configuration) connected through a CCI interconnect that manages
coherency of their respective L2 caches and intercluster distributed
virtual memory messages (DVM).

TC2 testchip integrates a power controller that manages cores resets, wake-up
IRQs and cluster low-power states. Power states are managed at cluster
level, which means that voltage is removed from a cluster iff all cores
in a cluster are in a wfi state. Single cores can enter a reset state
which is identical to wfi in terms of power consumption but simplifies the
way cluster states are entered.

This patch provides a multiple driver CPU idle implementation for TC2
which paves the way for a generic big.LITTLE idle driver for all
upcoming big.LITTLE based systems on chip.

The driver relies on the MCPM infrastructure to coordinate and manage
core power states; in particular MCPM allows to suspend specific cores
and hides the CPUs coordination required to shut-down clusters of CPUs.

Power down sequences for the respective clusters are implemented in the
MCPM TC2 backend, with all code needed to clean caches and exit coherency.

The multiple driver CPU idle infrastructure allows to define different
C-states for big and little cores, determined at boot by checking the
part id of the possible CPUs and initializing the respective logical
masks in the big and little drivers.

Current big.little systems are composed of A7 and A15 clusters, as
implemented in TC2, but in the future that may change and the driver
will have evolve to retrieve what is a 'big' cpu and what is a 'little'
cpu in order to build the correct topology.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Olof Johansson <olof@lixom.net>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 MAINTAINERS                          |   9 ++
 drivers/cpuidle/Kconfig              |  10 ++
 drivers/cpuidle/Makefile             |   1 +
 drivers/cpuidle/cpuidle-big_little.c | 210 +++++++++++++++++++++++++++++++++++
 4 files changed, 230 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-big_little.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bf61e04..01f1b3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2263,6 +2263,15 @@ F:	drivers/cpufreq/arm_big_little.h
 F:	drivers/cpufreq/arm_big_little.c
 F:	drivers/cpufreq/arm_big_little_dt.c
 
+CPUIDLE DRIVER - ARM BIG LITTLE
+M:      Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+M:      Daniel Lezcano <daniel.lezcano@linaro.org>
+L:      linux-pm at vger.kernel.org
+L:      linux-arm-kernel at lists.infradead.org
+T:      git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
+S:      Maintained
+F:      drivers/cpuidle/cpuidle-big_little.c
+
 CPUIDLE DRIVERS
 M:	Rafael J. Wysocki <rjw@sisk.pl>
 M:	Daniel Lezcano <daniel.lezcano@linaro.org>
diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 0e2cd5c..0f86587 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -42,6 +42,16 @@ config CPU_IDLE_ZYNQ
 	help
 	  Select this to enable cpuidle on Xilinx Zynq processors.
 
+config CPU_IDLE_BIG_LITTLE
+	bool "Support for ARM big.LITTLE processors"
+	depends on ARCH_VEXPRESS_TC2_PM
+	select ARM_CPU_SUSPEND
+	select CPU_IDLE_MULTIPLE_DRIVERS
+	help
+	  Select this option to enable CPU idle driver for big.LITTLE based
+	  ARM systems. Driver manages CPUs coordination through MCPM and
+	  define different C-states for little and big cores through the
+	  multiple CPU idle drivers infrastructure.
 endif
 
 config ARCH_NEEDS_CPU_IDLE_COUPLED
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 8767a7b..3b6445c 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 obj-$(CONFIG_CPU_IDLE_CALXEDA) += cpuidle-calxeda.o
 obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
 obj-$(CONFIG_CPU_IDLE_ZYNQ) += cpuidle-zynq.o
+obj-$(CONFIG_CPU_IDLE_BIG_LITTLE) += cpuidle-big_little.o
diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
new file mode 100644
index 0000000..7babf73
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -0,0 +1,210 @@
+/*
+ * Copyright (c) 2013 ARM/Linaro
+ *
+ * Authors: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *          Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ *          Nicolas Pitre <nicolas.pitre@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Maintainer: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ * Maintainer: Daniel Lezcano <daniel.lezcano@linaro.org>
+ */
+#include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+
+#include <asm/cpu.h>
+#include <asm/cputype.h>
+#include <asm/cpuidle.h>
+#include <asm/mcpm.h>
+#include <asm/smp_plat.h>
+#include <asm/suspend.h>
+
+static int bl_enter_powerdown(struct cpuidle_device *dev,
+			      struct cpuidle_driver *drv, int idx);
+
+/*
+ * NB: Owing to current menu governor behaviour big and LITTLE
+ * index 1 states have to define exit_latency and target_residency for
+ * cluster state since, when all CPUs in a cluster hit it, the cluster
+ * can be shutdown. This means that when a single CPU enters this state
+ * the exit_latency and target_residency values are somewhat overkill.
+ * There is no notion of cluster states in the menu governor, so CPUs
+ * have to define CPU states where possibly the cluster will be shutdown
+ * depending on the state of other CPUs. idle states entry and exit happen
+ * at random times; however the cluster state provides target_residency
+ * values as if all CPUs in a cluster enter the state at once; this is
+ * somewhat optimistic and behaviour should be fixed either in the governor
+ * or in the MCPM back-ends.
+ * To make this driver 100% generic the number of states and the exit_latency
+ * target_residency values must be obtained from device tree bindings.
+ *
+ * exit_latency: refers to the TC2 vexpress test chip and depends on the
+ * current cluster operating point. It is the time it takes to get the CPU
+ * up and running when the CPU is powered up on cluster wake-up from shutdown.
+ * Current values for big and LITTLE clusters are provided for clusters
+ * running at default operating points.
+ *
+ * target_residency: it is the minimum amount of time the cluster has
+ * to be down to break even in terms of power consumption. cluster
+ * shutdown has inherent dynamic power costs (L2 writebacks to DRAM
+ * being the main factor) that depend on the current operating points.
+ * The current values for both clusters are provided for a CPU whose half
+ * of L2 lines are dirty and require cleaning to DRAM, and takes into
+ * account leakage static power values related to the vexpress TC2 testchip.
+ */
+static struct cpuidle_driver bl_idle_little_driver = {
+	.name = "little_idle",
+	.owner = THIS_MODULE,
+	.states[0] = ARM_CPUIDLE_WFI_STATE,
+	.states[1] = {
+		.enter			= bl_enter_powerdown,
+		.exit_latency		= 700,
+		.target_residency	= 2500,
+		.flags			= CPUIDLE_FLAG_TIME_VALID |
+					  CPUIDLE_FLAG_TIMER_STOP,
+		.name			= "C1",
+		.desc			= "ARM little-cluster power down",
+	},
+	.state_count = 2,
+};
+
+static struct cpuidle_driver bl_idle_big_driver = {
+	.name = "big_idle",
+	.owner = THIS_MODULE,
+	.states[0] = ARM_CPUIDLE_WFI_STATE,
+	.states[1] = {
+		.enter			= bl_enter_powerdown,
+
+		.exit_latency		= 500,
+		.target_residency	= 2000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID |
+					  CPUIDLE_FLAG_TIMER_STOP,
+		.name			= "C1",
+		.desc			= "ARM big-cluster power down",
+	},
+	.state_count = 2,
+};
+
+/*
+ * notrace prevents trace shims from getting inserted where they
+ * should not. Global jumps and ldrex/strex must not be inserted
+ * in power down sequences where caches and MMU may be turned off.
+ */
+static int notrace bl_powerdown_finisher(unsigned long arg)
+{
+	/* MCPM works with HW CPU identifiers */
+	unsigned int mpidr = read_cpuid_mpidr();
+	unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	unsigned int cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+
+	mcpm_set_entry_vector(cpu, cluster, cpu_resume);
+
+	/*
+	 * Residency value passed to mcpm_cpu_suspend back-end
+	 * has to be given clear semantics. Set to 0 as a
+	 * temporary value.
+	 */
+	mcpm_cpu_suspend(0);
+
+	/* return value != 0 means failure */
+	return 1;
+}
+
+/**
+ * bl_enter_powerdown - Programs CPU to enter the specified state
+ * @dev: cpuidle device
+ * @drv: The target state to be programmed
+ * @idx: state index
+ *
+ * Called from the CPUidle framework to program the device to the
+ * specified target state selected by the governor.
+ */
+static int bl_enter_powerdown(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int idx)
+{
+	cpu_pm_enter();
+
+	cpu_suspend(0, bl_powerdown_finisher);
+
+	/* signals the MCPM core that CPU is out of low power state */
+	mcpm_cpu_powered_up();
+
+	cpu_pm_exit();
+
+	return idx;
+}
+
+static int __init bl_idle_driver_init(struct cpuidle_driver *drv, int cpu_id)
+{
+	struct cpuinfo_arm *cpu_info;
+	struct cpumask *cpumask;
+	unsigned long cpuid;
+	int cpu;
+
+	cpumask = kzalloc(cpumask_size(), GFP_KERNEL);
+	if (!cpumask)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		cpu_info = &per_cpu(cpu_data, cpu);
+		cpuid = is_smp() ? cpu_info->cpuid : read_cpuid_id();
+
+		/* read cpu id part number */
+		if ((cpuid & 0xFFF0) == cpu_id)
+			cpumask_set_cpu(cpu, cpumask);
+	}
+
+	drv->cpumask = cpumask;
+
+	return 0;
+}
+
+static int __init bl_idle_init(void)
+{
+	int ret;
+
+	/*
+	 * Initialize the driver just for a compliant set of machines
+	 */
+	if (!of_machine_is_compatible("arm,vexpress,v2p-ca15_a7"))
+		return -ENODEV;
+	/*
+	 * For now the differentiation between little and big cores
+	 * is based on the part number. A7 cores are considered little
+	 * cores, A15 are considered big cores. This distinction may
+	 * evolve in the future with a more generic matching approach.
+	 */
+	ret = bl_idle_driver_init(&bl_idle_little_driver,
+				  ARM_CPU_PART_CORTEX_A7);
+	if (ret)
+		return ret;
+
+	ret = bl_idle_driver_init(&bl_idle_big_driver, ARM_CPU_PART_CORTEX_A15);
+	if (ret)
+		goto out_uninit_little;
+
+	ret = cpuidle_register(&bl_idle_little_driver, NULL);
+	if (ret)
+		goto out_uninit_big;
+
+	ret = cpuidle_register(&bl_idle_big_driver, NULL);
+	if (ret)
+		goto out_unregister_little;
+
+	return 0;
+
+out_unregister_little:
+	cpuidle_unregister(&bl_idle_little_driver);
+out_uninit_big:
+	kfree(bl_idle_big_driver.cpumask);
+out_uninit_little:
+	kfree(bl_idle_little_driver.cpumask);
+
+	return ret;
+}
+device_initcall(bl_idle_init);
-- 
1.8.2.2
