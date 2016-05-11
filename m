From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 11 May 2016 16:37:41 +0100
Subject: [PATCH v5 4/5] arm64: add support for ACPI Low Power Idle(LPI)
In-Reply-To: <1462981062-24909-1-git-send-email-sudeep.holla@arm.com>
References: <1462981062-24909-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1462981062-24909-5-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds appropriate callbacks to support ACPI Low Power Idle
(LPI) on ARM64.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kernel/acpi.c | 48 +++++++++++++++++++++++++++++++++++++++++
 drivers/firmware/psci.c  | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index d1ce8e2f98b9..bf82ce5c8fce 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -18,6 +18,7 @@
 #include <linux/acpi.h>
 #include <linux/bootmem.h>
 #include <linux/cpumask.h>
+#include <linux/cpu_pm.h>
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
@@ -25,6 +26,9 @@
 #include <linux/of_fdt.h>
 #include <linux/smp.h>
 
+#include <acpi/processor.h>
+
+#include <asm/cpuidle.h>
 #include <asm/cputype.h>
 #include <asm/cpu_ops.h>
 #include <asm/smp_plat.h>
@@ -211,6 +215,50 @@ void __init acpi_boot_table_init(void)
 	}
 }
 
+int acpi_processor_ffh_lpi_probe(unsigned int cpu)
+{
+	return arm_cpuidle_init(cpu);
+}
+
+#define ACPI_FFH_LPI_ARM_FLAGS_CORE_CONTEXT	BIT(0)
+#define ACPI_FFH_LPI_ARM_FLAGS_TRACE_CONTEXT	BIT(1)
+#define ACPI_FFH_LPI_ARM_FLAGS_GICR_CONTEXT	BIT(2)
+#define ACPI_FFH_LPI_ARM_FLAGS_GICD_CONTEXT	BIT(3)
+#define ACPI_FFH_LPI_ARM_FLAGS_ALL_CONTEXT	\
+	(ACPI_FFH_LPI_ARM_FLAGS_CORE_CONTEXT |	\
+	 ACPI_FFH_LPI_ARM_FLAGS_TRACE_CONTEXT |	\
+	 ACPI_FFH_LPI_ARM_FLAGS_GICR_CONTEXT |	\
+	 ACPI_FFH_LPI_ARM_FLAGS_GICD_CONTEXT)
+
+struct acpi_lpi_state *lpi;
+int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi, int idx)
+{
+	int ret = 0;
+	bool save_ctx = lpi->arch_flags & ACPI_FFH_LPI_ARM_FLAGS_ALL_CONTEXT;
+
+	if (!idx) {
+		cpu_do_idle();
+		return idx;
+	}
+
+	/* TODO cpu_pm_{enter,exit} can be done in generic code ? */
+	if (save_ctx)
+		ret = cpu_pm_enter();
+	if (!ret) {
+		/*
+		 * Pass idle state index to cpu_suspend which in turn will
+		 * call the CPU ops suspend protocol with idle index as a
+		 * parameter.
+		 */
+		ret = arm_cpuidle_suspend(idx);
+
+		if (save_ctx)
+			cpu_pm_exit();
+	}
+
+	return ret ? -1 : idx;
+}
+
 #ifdef CONFIG_ACPI_APEI
 pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 {
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index fa4ea22ca12e..e06bfee68e1d 100644
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
+	if (!count)
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
-- 
1.9.1
