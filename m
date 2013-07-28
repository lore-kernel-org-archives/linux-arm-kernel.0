From: robherring2@gmail.com (Rob Herring)
Date: Sun, 28 Jul 2013 16:56:34 -0500
Subject: [PATCH 3/7] ARM: PSCI: add ops for system restart and power off
In-Reply-To: <1375048598-15637-1-git-send-email-robherring2@gmail.com>
References: <1375048598-15637-1-git-send-email-robherring2@gmail.com>
Message-ID: <1375048598-15637-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In PSCI v0.2 spec, operations for system level restart and power off are
added. This adds kernel support for those operations. The behavior for
picking restart function matches the psci_smp_ops such that the PSCI
restart function will be used when present even if a platform defines
a mdesc->restart entry. As pm_power_off depends on platform init code to
setup, using the PSCI version relies on the platform code to not override
it.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/include/asm/psci.h |  2 ++
 arch/arm/kernel/psci.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
index c4ae171..04ee1b2 100644
--- a/arch/arm/include/asm/psci.h
+++ b/arch/arm/include/asm/psci.h
@@ -29,6 +29,8 @@ struct psci_operations {
 	int (*cpu_off)(struct psci_power_state state);
 	int (*cpu_on)(unsigned long cpuid, unsigned long entry_point);
 	int (*migrate)(unsigned long cpuid);
+	void (*system_off)(void);
+	void (*system_reset)(void);
 };
 
 extern struct psci_operations psci_ops;
diff --git a/arch/arm/kernel/psci.c b/arch/arm/kernel/psci.c
index 4693188..ffc4a7c 100644
--- a/arch/arm/kernel/psci.c
+++ b/arch/arm/kernel/psci.c
@@ -17,12 +17,14 @@
 
 #include <linux/init.h>
 #include <linux/of.h>
+#include <linux/pm.h>
 
 #include <asm/compiler.h>
 #include <asm/errno.h>
 #include <asm/opcodes-sec.h>
 #include <asm/opcodes-virt.h>
 #include <asm/psci.h>
+#include <asm/system_misc.h>
 
 struct psci_operations psci_ops;
 
@@ -33,6 +35,8 @@ enum psci_function {
 	PSCI_FN_CPU_ON,
 	PSCI_FN_CPU_OFF,
 	PSCI_FN_MIGRATE,
+	PSCI_FN_SYS_OFF,
+	PSCI_FN_SYS_RESET,
 	PSCI_FN_MAX,
 };
 
@@ -153,6 +157,30 @@ static int psci_migrate(unsigned long cpuid)
 	return psci_to_linux_errno(err);
 }
 
+static void psci_system_off(void)
+{
+	u32 fn = psci_function_id[PSCI_FN_SYS_OFF];
+	invoke_psci_fn(fn, 0, 0, 0);
+}
+
+static void psci_system_reset(void)
+{
+	u32 fn = psci_function_id[PSCI_FN_SYS_RESET];
+	invoke_psci_fn(fn, 0, 0, 0);
+}
+
+void psci_pm_power_off(void)
+{
+	if (psci_ops.system_off)
+		psci_ops.system_off();
+}
+
+void psci_restart(enum reboot_mode reboot_mode, const char *cmd)
+{
+	if (psci_ops.system_off)
+		psci_ops.system_reset();
+}
+
 static const struct of_device_id psci_of_match[] __initconst = {
 	{ .compatible = "arm,psci",	},
 	{},
@@ -204,6 +232,18 @@ void __init psci_init(void)
 		psci_ops.migrate = psci_migrate;
 	}
 
+	if (!of_property_read_u32(np, "system_off", &id)) {
+		psci_function_id[PSCI_FN_SYS_OFF] = id;
+		psci_ops.system_off = psci_system_off;
+		pm_power_off = psci_pm_power_off;
+	}
+
+	if (!of_property_read_u32(np, "system_reset", &id)) {
+		psci_function_id[PSCI_FN_SYS_RESET] = id;
+		psci_ops.system_reset = psci_system_reset;
+		arm_pm_restart = psci_restart;
+	}
+
 out_put_node:
 	of_node_put(np);
 	return;
-- 
1.8.1.2
