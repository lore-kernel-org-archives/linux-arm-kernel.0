From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 19 Apr 2016 13:30:12 +0100
Subject: [PATCH v4 4/5] arm64: add support for ACPI Low Power Idle(LPI)
In-Reply-To: <1461069013-13292-1-git-send-email-sudeep.holla@arm.com>
References: <1461069013-13292-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1461069013-13292-5-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds appropriate callbacks to support ACPI Low Power Idle
(LPI) on ARM64.

It also selects ARCH_SUPPORTS_ACPI_PROCESSOR_LPI if ACPI is enabled
on ARM64.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/Kconfig       |  1 +
 arch/arm64/kernel/acpi.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/firmware/psci.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4f436220384f..e7536540387d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -10,6 +10,7 @@ config ARM64
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_SUPPORTS_ACPI_PROCESSOR_LPI if ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index d1ce8e2f98b9..3c05ad5957be 100644
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
@@ -25,9 +26,11 @@
 #include <linux/of_fdt.h>
 #include <linux/smp.h>
 
+#include <asm/cpuidle.h>
 #include <asm/cputype.h>
 #include <asm/cpu_ops.h>
 #include <asm/smp_plat.h>
+#include <acpi/processor.h>
 
 #ifdef CONFIG_ACPI_APEI
 # include <linux/efi.h>
@@ -211,6 +214,37 @@ void __init acpi_boot_table_init(void)
 	}
 }
 
+int acpi_processor_ffh_lpi_probe(unsigned int cpu)
+{
+	return arm_cpuidle_init(cpu);
+}
+
+struct acpi_processor_lpi *lpi;
+int acpi_processor_ffh_lpi_enter(struct acpi_processor_lpi *lpi, int idx)
+{
+	int ret;
+
+	if (!idx) {
+		cpu_do_idle();
+		return idx;
+	}
+
+	/* TODO cpu_pm_{enter,exit} can be done in generic code ? */
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
+
 #ifdef CONFIG_ACPI_APEI
 pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 {
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index af6c5c839568..70cf2a500d4b 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -24,6 +24,7 @@
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
+#include <linux/acpi.h>
 
 #include <uapi/linux/psci.h>
 
@@ -32,6 +33,7 @@
 #include <asm/system_misc.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
+#include <acpi/processor.h>
 
 /*
  * While a 64-bit OS can make calls with SMC32 calling conventions, for some
@@ -316,8 +318,54 @@ static int psci_dt_cpu_init_idle(unsigned int cpu)
 	return ret;
 }
 
+static int __maybe_unused psci_acpi_cpu_init_idle(unsigned int cpu)
+{
+	int i, count;
+	u32 *psci_states;
+	struct acpi_processor *pr;
+	struct acpi_processor_lpi *lpi;
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
+
 int psci_cpu_init_idle(unsigned int cpu)
 {
+	if (!acpi_disabled)
+		return psci_acpi_cpu_init_idle(cpu);
+
 	return psci_dt_cpu_init_idle(cpu);
 }
 
-- 
1.9.1
