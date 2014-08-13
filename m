From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 13 Aug 2014 16:52:02 +0100
Subject: [PATCH v7 3/8] drivers: cpuidle: implement DT based idle states
 infrastructure
In-Reply-To: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1407945127-27554-4-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On most common ARM systems, the low-power states a CPU can be put into are
not discoverable in HW and require device tree bindings to describe
power down suspend operations and idle states parameters.

In order to enable DT based idle states and configure idle drivers, this
patch implements the bulk infrastructure required to parse the device tree
idle states bindings and initialize the corresponding CPUidle driver states
data.

The parsing API accepts a start index that defines the first idle state
that should be initialized by the parsing code in order to give new and
legacy driver flexibility over which states should be parsed using the
new DT mechanism.

The idle states list is obtained from the first cpu in the driver
cpumask, which implicitly means the parsing code expects idle states
(and related list of phandles) to be the same for all CPUs in the
CPUidle driver mask. The kernel does not check this assumption, it must
be enforced by the bootloader to ensure correct system behaviour.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/cpuidle/Kconfig          |   3 +
 drivers/cpuidle/Makefile         |   1 +
 drivers/cpuidle/dt_idle_states.c | 140 +++++++++++++++++++++++++++++++++++++++
 drivers/cpuidle/dt_idle_states.h |   5 ++
 4 files changed, 149 insertions(+)
 create mode 100644 drivers/cpuidle/dt_idle_states.c
 create mode 100644 drivers/cpuidle/dt_idle_states.h

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 32748c3..8deb934 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -25,6 +25,9 @@ config CPU_IDLE_GOV_MENU
 	bool "Menu governor (for tickless system)"
 	default y
 
+config DT_IDLE_STATES
+	bool
+
 menu "ARM CPU Idle Drivers"
 depends on ARM
 source "drivers/cpuidle/Kconfig.arm"
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 11edb31..002b653 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -4,6 +4,7 @@
 
 obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
 obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
+obj-$(CONFIG_DT_IDLE_STATES)		  += dt_idle_states.o
 
 ##################################################################################
 # ARM SoC drivers
diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
new file mode 100644
index 0000000..207f8f7
--- /dev/null
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -0,0 +1,140 @@
+/*
+ * DT idle states parsing code.
+ *
+ * Copyright (C) 2014 ARM Ltd.
+ * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt) "DT idle-states: " fmt
+
+#include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#include "dt_idle_states.h"
+
+static int init_state_node(struct cpuidle_state *idle_state,
+			   struct device_node *state_node)
+{
+	int err;
+
+	err = of_property_read_u32(state_node, "wakeup-latency-us",
+				   &idle_state->exit_latency);
+	if (err) {
+		u32 entry_latency, exit_latency;
+
+		err = of_property_read_u32(state_node, "entry-latency-us",
+					   &entry_latency);
+		if (err) {
+			pr_debug(" * %s missing entry-latency-us property\n",
+				 state_node->full_name);
+			return -EINVAL;
+		}
+
+		err = of_property_read_u32(state_node, "exit-latency-us",
+					   &exit_latency);
+		if (err) {
+			pr_debug(" * %s missing exit-latency-us property\n",
+				 state_node->full_name);
+			return -EINVAL;
+		}
+		/*
+		 * If wakeup-latency-us is missing, default to entry+exit
+		 * latencies as defined in idle states bindings
+		 */
+		idle_state->exit_latency = entry_latency + exit_latency;
+	}
+
+	err = of_property_read_u32(state_node, "min-residency-us",
+				   &idle_state->target_residency);
+	if (err) {
+		pr_debug(" * %s missing min-residency-us property\n",
+			     state_node->full_name);
+		return -EINVAL;
+	}
+
+	idle_state->flags = CPUIDLE_FLAG_TIME_VALID;
+	if (of_property_read_bool(state_node, "local-timer-stop"))
+		idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
+	/*
+	 * TODO:
+	 *	replace with kstrdup and pointer assignment when name
+	 *	and desc become string pointers
+	 */
+	strncpy(idle_state->name, state_node->name, CPUIDLE_NAME_LEN - 1);
+	strncpy(idle_state->desc, state_node->name, CPUIDLE_DESC_LEN - 1);
+	return 0;
+}
+
+/**
+ * dt_init_idle_driver() - Parse the DT idle states and initialize the
+ *			   idle driver states array
+ * @drv:	  Pointer to CPU idle driver to be initialized
+ * @start_idx:    First idle state index to be initialized
+ *
+ * If DT idle states are detected and are valid the state count and states
+ * array entries in the cpuidle driver are initialized accordingly starting
+ * from index start_idx.
+ *
+ * Return: number of valid DT idle states parsed, <0 on failure
+ */
+int dt_init_idle_driver(struct cpuidle_driver *drv, unsigned int start_idx)
+{
+	struct cpuidle_state *idle_state;
+	struct device_node *state_node, *cpu_node;
+	int i;
+	unsigned int state_idx = start_idx;
+
+	if (state_idx >= CPUIDLE_STATE_MAX)
+		return -EINVAL;
+	/*
+	 * We get the idle states for the first logical cpu in the
+	 * driver mask. The kernel does not check idle states on all
+	 * cpus in the driver mask, they are assumed to be the same
+	 * by default.
+	 */
+	cpu_node = of_cpu_device_node_get(cpumask_first(drv->cpumask));
+
+	for (i = 0; ; i++) {
+		int err;
+
+		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		if (!state_node)
+			break;
+
+		if (state_idx == CPUIDLE_STATE_MAX) {
+			pr_warn("State index reached static CPU idle driver states array size\n");
+			break;
+		}
+
+		idle_state = &drv->states[state_idx++];
+		err = init_state_node(idle_state, state_node);
+		if (err) {
+			pr_err("Parsing idle state node %s failed with err %d\n",
+			       state_node->full_name, err);
+			return err;
+		}
+	}
+	/*
+	 * Update the driver state count only if some valid DT idle states
+	 * were detected
+	 */
+	if (i)
+		drv->state_count = state_idx;
+
+	/*
+	 * Return the number of present and valid DT idle states, which can
+	 * also be 0 on platforms with missing DT idle states or legacy DT
+	 * configuration predating the DT idle states bindings.
+	 */
+	return i;
+}
+EXPORT_SYMBOL_GPL(dt_init_idle_driver);
diff --git a/drivers/cpuidle/dt_idle_states.h b/drivers/cpuidle/dt_idle_states.h
new file mode 100644
index 0000000..728c37c
--- /dev/null
+++ b/drivers/cpuidle/dt_idle_states.h
@@ -0,0 +1,5 @@
+#ifndef __DT_IDLE_STATES
+#define __DT_IDLE_STATES
+
+int dt_init_idle_driver(struct cpuidle_driver *drv, unsigned int start_idx);
+#endif
-- 
1.9.1
