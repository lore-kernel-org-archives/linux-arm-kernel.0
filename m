From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 14 Jun 2016 15:48:38 +0100
Subject: [PATCH v6 4/5] arm64: add support for ACPI Low Power Idle(LPI)
In-Reply-To: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com>
References: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1465915719-8409-5-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds appropriate callbacks to support ACPI Low Power Idle
(LPI) on ARM64.

Now that arm_enter_idle_state is exactly same in both generic ARM{32,64}
CPUIdle driver and ARM64 backend for ACPI processor idle driver, we can
unify it and move to cpuidle-arm.h header.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kernel/cpuidle.c   | 17 +++++++++++++
 drivers/cpuidle/cpuidle-arm.c | 23 ++----------------
 drivers/firmware/psci.c       | 56 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/cpuidle-arm.h   | 30 +++++++++++++++++++++++
 4 files changed, 105 insertions(+), 21 deletions(-)
 create mode 100644 include/linux/cpuidle-arm.h

diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index 06786fdaadeb..6874d01531ae 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -9,6 +9,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/acpi.h>
+#include <linux/cpuidle-arm.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 
@@ -39,3 +41,18 @@ int arm_cpuidle_suspend(int index)
 
 	return cpu_ops[cpu]->cpu_suspend(index);
 }
+
+#ifdef CONFIG_ACPI
+
+#include <acpi/processor.h>
+
+int acpi_processor_ffh_lpi_probe(unsigned int cpu)
+{
+	return arm_cpuidle_init(cpu);
+}
+
+int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
+{
+	return arm_generic_enter_idle_state(lpi->index);
+}
+#endif
diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index e342565e8715..75178ba4a1b2 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -12,8 +12,8 @@
 #define pr_fmt(fmt) "CPUidle arm: " fmt
 
 #include <linux/cpuidle.h>
+#include <linux/cpuidle-arm.h>
 #include <linux/cpumask.h>
-#include <linux/cpu_pm.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -36,26 +36,7 @@
 static int arm_enter_idle_state(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int idx)
 {
-	int ret;
-
-	if (!idx) {
-		cpu_do_idle();
-		return idx;
-	}
-
-	ret = cpu_pm_enter();
-	if (!ret) {
-		/*
-		 * Pass idle state index to cpu_suspend which in turn will
-		 * call the CPU ops suspend protocol with idle index as a
-		 * parameter.
-		 */
-		ret = arm_cpuidle_suspend(idx);
-
-		cpu_pm_exit();
-	}
-
-	return ret ? -1 : idx;
+	return arm_generic_enter_idle_state(idx);
 }
 
 static struct cpuidle_driver arm_idle_driver = {
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 03e04582791c..c6caa863d156 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -13,6 +13,7 @@
 
 #define pr_fmt(fmt) "psci: " fmt
 
+#include <linux/acpi.h>
 #include <linux/arm-smccc.h>
 #include <linux/cpuidle.h>
 #include <linux/errno.h>
@@ -310,11 +311,66 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 	return ret;
 }
 
+#ifdef CONFIG_ACPI
+#include <acpi/processor.h>
+
+static int __maybe_unused psci_acpi_cpu_init_idle(unsigned int cpu)
+{
+	int i, count;
+	u32 *psci_states;
+	struct acpi_processor *pr;
+	struct acpi_lpi_state *lpi;
+
+	pr = per_cpu(processors, cpu);
+	if (unlikely(!pr || !pr->flags.has_lpi))
+		return -EINVAL;
+
+	/*
+	 * If the PSCI cpu_suspend function hook has not been initialized
+	 * idle states must not be enabled, so bail out
+	 */
+	if (!psci_ops.cpu_suspend)
+		return -EOPNOTSUPP;
+
+	count = pr->power.count - 1;
+	if (count <= 0)
+		return -ENODEV;
+
+	psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
+	if (!psci_states)
+		return -ENOMEM;
+
+	for (i = 0; i < count; i++) {
+		u32 state;
+
+		lpi = &pr->power.lpi_states[i + 1];
+		state = lpi->address & 0xFFFFFFFF;
+		if (!psci_power_state_is_valid(state)) {
+			pr_warn("Invalid PSCI power state %#x\n", state);
+			kfree(psci_states);
+			return -EINVAL;
+		}
+		psci_states[i] = state;
+	}
+	/* Idle states parsed correctly, initialize per-cpu pointer */
+	per_cpu(psci_power_state, cpu) = psci_states;
+	return 0;
+}
+#else
+static int __maybe_unused psci_acpi_cpu_init_idle(unsigned int cpu)
+{
+	return -EINVAL;
+}
+#endif
+
 int psci_cpu_init_idle(unsigned int cpu)
 {
 	struct device_node *cpu_node;
 	int ret;
 
+	if (!acpi_disabled)
+		return psci_acpi_cpu_init_idle(cpu);
+
 	cpu_node = of_get_cpu_node(cpu, NULL);
 	if (!cpu_node)
 		return -ENODEV;
diff --git a/include/linux/cpuidle-arm.h b/include/linux/cpuidle-arm.h
new file mode 100644
index 000000000000..b99bcb3f43dd
--- /dev/null
+++ b/include/linux/cpuidle-arm.h
@@ -0,0 +1,30 @@
+#include <linux/cpu_pm.h>
+
+#include <asm/cpuidle.h>
+
+/*
+ * arm_enter_idle_state - Programs CPU to enter the specified state
+ */
+static int arm_generic_enter_idle_state(int idx)
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
+		ret = arm_cpuidle_suspend(idx);
+
+		cpu_pm_exit();
+	}
+
+	return ret ? -1 : idx;
+}
-- 
2.7.4
