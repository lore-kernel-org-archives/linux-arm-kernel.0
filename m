From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 15:54:05 +0200
Subject: [PATCH v3 08/11] ARM: mvebu: add SMP support for Armada 375 and
 Armada 38x
In-Reply-To: <1397483648-26611-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397483648-26611-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397483648-26611-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

This commit adds the SMP support for Armada 375 and Armada 38x. It
turns out that the SMP logic for both of these SOCs are fairly
similar, the only differences being:

 * A different method to set the secondary CPU boot address

 * An Armada 375 specific workaround needed for the early Z1 stepping,
   added by the following patch.

Other than that, the patch is fairly straightforward and adds the
usual platsmp and headsmp code, defining the smp_operations structure
that is referenced from the DT_MACHINE structures.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt |  2 +
 arch/arm/mach-mvebu/Kconfig                    |  4 ++
 arch/arm/mach-mvebu/Makefile                   |  2 +-
 arch/arm/mach-mvebu/headsmp-a9.S               | 22 +++++++++
 arch/arm/mach-mvebu/platsmp-a9.c               | 68 ++++++++++++++++++++++++++
 5 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-mvebu/headsmp-a9.S
 create mode 100644 arch/arm/mach-mvebu/platsmp-a9.c

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 0dc59c3..4bbcf4f 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -185,6 +185,8 @@ nodes to be present and contain the properties described below.
 			    "qcom,gcc-msm8660"
 			    "qcom,kpss-acc-v1"
 			    "qcom,kpss-acc-v2"
+			    "marvell,armada-375-smp"
+			    "marvell,armada-380-smp"
 			    "marvell,armada-xp-smp"
 
 	- cpu-release-addr
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 45e5714..9d1c84c 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -40,6 +40,8 @@ config MACH_ARMADA_375
 	select ARMADA_375_CLK
 	select CPU_V7
 	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD
+	select HAVE_SMP
 	select MACH_MVEBU_V7
 	select PINCTRL_ARMADA_375
 	help
@@ -54,6 +56,8 @@ config MACH_ARMADA_38X
 	select ARMADA_38X_CLK
 	select CPU_V7
 	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD
+	select HAVE_SMP
 	select MACH_MVEBU_V7
 	select PINCTRL_ARMADA_38X
 	help
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index f9cfab0..02b5389 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -7,7 +7,7 @@ obj-y				 += system-controller.o mvebu-soc-id.o cpu-reset.o
 obj-$(CONFIG_MACH_MVEBU_V7)      += board-v7.o
 obj-$(CONFIG_MACH_DOVE)		 += dove.o
 obj-$(CONFIG_ARCH_MVEBU)	 += coherency.o coherency_ll.o pmsu.o
-obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
+obj-$(CONFIG_SMP)                += platsmp.o headsmp.o platsmp-a9.o headsmp-a9.o
 obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
 obj-$(CONFIG_MACH_KIRKWOOD)	 += kirkwood.o kirkwood-pm.o
 obj-$(CONFIG_MACH_T5325)	 += board-t5325.o
diff --git a/arch/arm/mach-mvebu/headsmp-a9.S b/arch/arm/mach-mvebu/headsmp-a9.S
new file mode 100644
index 0000000..78e66c9
--- /dev/null
+++ b/arch/arm/mach-mvebu/headsmp-a9.S
@@ -0,0 +1,22 @@
+/*
+ * SMP support: Entry point for secondary CPUs of Marvell EBU
+ * Cortex-A9 based SOCs (Armada 375 and Armada 38x).
+ *
+ * Copyright (C) 2014 Marvell
+ *
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+	__CPUINIT
+ENTRY(mvebu_cortex_a9_secondary_startup)
+	bl      v7_invalidate_l1
+	b	secondary_startup
+ENDPROC(mvebu_cortex_a9_secondary_startup)
diff --git a/arch/arm/mach-mvebu/platsmp-a9.c b/arch/arm/mach-mvebu/platsmp-a9.c
new file mode 100644
index 0000000..27dacfc
--- /dev/null
+++ b/arch/arm/mach-mvebu/platsmp-a9.c
@@ -0,0 +1,68 @@
+/*
+ * Symmetric Multi Processing (SMP) support for Marvell EBU Cortex-A9
+ * based SOCs (Armada 375/38x).
+ *
+ * Copyright (C) 2014 Marvell
+ *
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/smp.h>
+#include <asm/smp_scu.h>
+#include <asm/smp_plat.h>
+#include "common.h"
+#include "pmsu.h"
+
+extern void mvebu_cortex_a9_secondary_startup(void);
+
+static int __cpuinit mvebu_cortex_a9_boot_secondary(unsigned int cpu,
+						    struct task_struct *idle)
+{
+	int ret, hw_cpu;
+
+	pr_info("Booting CPU %d\n", cpu);
+
+	/*
+	 * Write the address of secondary startup into the system-wide
+	 * flags register. The boot monitor waits until it receives a
+	 * soft interrupt, and then the secondary CPU branches to this
+	 * address.
+	 */
+	hw_cpu = cpu_logical_map(cpu);
+
+	if (of_machine_is_compatible("marvell,armada375"))
+		mvebu_system_controller_set_cpu_boot_addr(mvebu_cortex_a9_secondary_startup);
+	else
+		mvebu_pmsu_set_cpu_boot_addr(hw_cpu,
+					     mvebu_cortex_a9_secondary_startup);
+
+	smp_wmb();
+	ret = mvebu_cpu_reset_deassert(hw_cpu);
+	if (ret) {
+		pr_err("Could not start the secondary CPU: %d\n", ret);
+		return ret;
+	}
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+
+	return 0;
+}
+
+static struct smp_operations mvebu_cortex_a9_smp_ops __initdata = {
+	.smp_boot_secondary	= mvebu_cortex_a9_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= armada_xp_cpu_die,
+#endif
+};
+
+CPU_METHOD_OF_DECLARE(mvebu_armada_375_smp, "marvell,armada-375-smp",
+		      &mvebu_cortex_a9_smp_ops);
+CPU_METHOD_OF_DECLARE(mvebu_armada_380_smp, "marvell,armada-380-smp",
+		      &mvebu_cortex_a9_smp_ops);
-- 
1.8.3.2
