From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 19 Jul 2016 18:52:57 +0100
Subject: [PATCH v10 5/7] drivers: firmware: psci: initialise idle states using
 ACPI LPI
In-Reply-To: <1468950779-21745-1-git-send-email-sudeep.holla@arm.com>
References: <1468950779-21745-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1468950779-21745-6-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for initialisation of PSCI CPUIdle states
from Low Power Idle(_LPI) entries in the ACPI tables when acpi is
enabled.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/psci.c | 66 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 03e04582791c..8263429e21b8 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -13,6 +13,7 @@
 
 #define pr_fmt(fmt) "psci: " fmt
 
+#include <linux/acpi.h>
 #include <linux/arm-smccc.h>
 #include <linux/cpuidle.h>
 #include <linux/errno.h>
@@ -256,13 +257,6 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 	u32 *psci_states;
 	struct device_node *state_node;
 
-	/*
-	 * If the PSCI cpu_suspend function hook has not been initialized
-	 * idle states must not be enabled, so bail out
-	 */
-	if (!psci_ops.cpu_suspend)
-		return -EOPNOTSUPP;
-
 	/* Count idle states */
 	while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
 					      count))) {
@@ -310,11 +304,69 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 	return ret;
 }
 
+#ifdef CONFIG_ACPI
+#include <acpi/processor.h>
+
+static int __maybe_unused psci_acpi_cpu_init_idle(unsigned int cpu)
+{
+	int i, count;
+	u32 *psci_states;
+	struct acpi_lpi_state *lpi;
+	struct acpi_processor *pr = per_cpu(processors, cpu);
+
+	if (unlikely(!pr || !pr->flags.has_lpi))
+		return -EINVAL;
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
+		/*
+		 * Only bits[31:0] represent a PSCI power_state while
+		 * bits[63:32] must be 0x0 as per ARM ACPI FFH Specification
+		 */
+		state = lpi->address;
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
 
+	/*
+	 * If the PSCI cpu_suspend function hook has not been initialized
+	 * idle states must not be enabled, so bail out
+	 */
+	if (!psci_ops.cpu_suspend)
+		return -EOPNOTSUPP;
+
+	if (!acpi_disabled)
+		return psci_acpi_cpu_init_idle(cpu);
+
 	cpu_node = of_get_cpu_node(cpu, NULL);
 	if (!cpu_node)
 		return -ENODEV;
-- 
2.7.4
