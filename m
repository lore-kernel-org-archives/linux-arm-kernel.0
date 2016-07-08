From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri,  8 Jul 2016 18:07:57 +0100
Subject: [PATCH v9 6/7] arm64: add support for ACPI Low Power Idle(LPI)
In-Reply-To: <1467997678-7107-1-git-send-email-sudeep.holla@arm.com>
References: <1467997678-7107-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1467997678-7107-7-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds appropriate callbacks to support ACPI Low Power Idle
(LPI) on ARM64.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kernel/cpuidle.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index 06786fdaadeb..75a0f8acef66 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -9,6 +9,9 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/acpi.h>
+#include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 
@@ -39,3 +42,18 @@ int arm_cpuidle_suspend(int index)
 
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
+	return CPU_PM_CPU_IDLE_ENTER(arm_cpuidle_suspend, lpi->index);
+}
+#endif
-- 
2.7.4
