From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 27 Mar 2014 14:38:00 +0100
Subject: [PATCH 1/6] ARM: mvebu: introduce CPU reset code
In-Reply-To: <1395927485-11842-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1395927485-11842-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1395927485-11842-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 and Armada XP have registers that allow to reset the
CPUs, which is particularly useful to take the secondary CPUs out of
reset in the context of the SMP support.

Unfortunately, an implementation mistake was originally made and the
support for these registers was integrated into the PMSU driver, which
is in fact completely unrelated. And it turns out that the Armada 375
has the same CPU reset registers, but does not have the PMSU
registers.

Therefore, this commit creates a small CPU reset driver. All it does
is provide a simple mvebu_cpu_reset_deassert() function that the SMP
support code can call to take secondary CPUs out of reset. As of this
commit, the driver isn't being used, it will be used through changes
in the following commits.

Note that we initially planned to use the 'reset controller'
framework, but it requires the addition of "resets" properties in the
Device Tree, which are causing too many problems if we want to keep
the Device Tree backward compatibility. Moreover, the 'reset
controller' framework is mainly useful when a device driver needs to
request a reset of its device from a separate reset controller. In our
case, the CPU reset handling and the SMP core code are both located in
arch/arm/mach-mvebu/ and are tightly linked together, so there's no
real benefit in going through a separate framework.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/arm/armada-cpu-reset.txt   | 17 +++++
 arch/arm/mach-mvebu/Makefile                       |  2 +-
 arch/arm/mach-mvebu/armada-370-xp.h                |  3 +-
 arch/arm/mach-mvebu/common.h                       |  1 +
 arch/arm/mach-mvebu/cpu-reset.c                    | 89 ++++++++++++++++++++++
 5 files changed, 110 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-cpu-reset.txt
 create mode 100644 arch/arm/mach-mvebu/cpu-reset.c

diff --git a/Documentation/devicetree/bindings/arm/armada-cpu-reset.txt b/Documentation/devicetree/bindings/arm/armada-cpu-reset.txt
new file mode 100644
index 0000000..384cbf8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/armada-cpu-reset.txt
@@ -0,0 +1,17 @@
+Marvell Armada CPU reset controller
+===================================
+
+Required properties:
+
+- compatible: Should be "marvell,armada-<chip>-cpu-reset". Supported
+  values are:
+    marvell,armada-370-cpu-reset
+    marvell,armada-xp-cpu-reset
+
+- reg: should be register base and length as documented in the
+  datasheet for the CPU reset registers
+
+cpurst: cpurst at 20800 {
+       compatible = "marvell,armada-xp-cpu-reset";
+       reg = <0x20800 0x20>;
+};
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 2c1db29..0e0eab5 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -3,7 +3,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 
 AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
 
-obj-y				 += system-controller.o mvebu-soc-id.o
+obj-y				 += system-controller.o mvebu-soc-id.o cpu-reset.o
 obj-$(CONFIG_MACH_MVEBU_V7)      += board-v7.o
 obj-$(CONFIG_ARCH_MVEBU)	 += coherency.o coherency_ll.o pmsu.o
 obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
diff --git a/arch/arm/mach-mvebu/armada-370-xp.h b/arch/arm/mach-mvebu/armada-370-xp.h
index 237c86b..991ab32 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.h
+++ b/arch/arm/mach-mvebu/armada-370-xp.h
@@ -18,7 +18,8 @@
 #ifdef CONFIG_SMP
 #include <linux/cpumask.h>
 
-#define ARMADA_XP_MAX_CPUS 4
+#define ARMADA_370_MAX_CPUS 1
+#define ARMADA_XP_MAX_CPUS  4
 
 void armada_mpic_send_doorbell(const struct cpumask *mask, unsigned int irq);
 void armada_xp_mpic_smp_cpu_init(void);
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index 55449c4..cfb129b 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -18,6 +18,7 @@
 #include <linux/reboot.h>
 
 void mvebu_restart(enum reboot_mode mode, const char *cmd);
+int mvebu_cpu_reset_deassert(int cpu);
 
 void armada_xp_cpu_die(unsigned int cpu);
 
diff --git a/arch/arm/mach-mvebu/cpu-reset.c b/arch/arm/mach-mvebu/cpu-reset.c
new file mode 100644
index 0000000..2819887
--- /dev/null
+++ b/arch/arm/mach-mvebu/cpu-reset.c
@@ -0,0 +1,89 @@
+/*
+ * Copyright (C) 2013 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#define pr_fmt(fmt) "mvebu-cpureset: " fmt
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_address.h>
+#include <linux/io.h>
+#include <linux/resource.h>
+#include "armada-370-xp.h"
+
+static struct of_device_id of_cpu_reset_table[] = {
+	{.compatible = "marvell,armada-370-cpu-reset", .data = (void*) ARMADA_370_MAX_CPUS },
+	{.compatible = "marvell,armada-xp-cpu-reset",  .data = (void*) ARMADA_XP_MAX_CPUS },
+	{ /* end of list */ },
+};
+
+static void __iomem *cpu_reset_base;
+static int ncpus;
+
+#define CPU_RESET_OFFSET(cpu) (cpu * 0x8)
+#define CPU_RESET_ASSERT      BIT(0)
+
+int mvebu_cpu_reset_deassert(int cpu)
+{
+	u32 reg;
+
+	if (cpu >= ncpus)
+		return -EINVAL;
+
+	if (!cpu_reset_base)
+		return -ENODEV;
+
+	reg = readl(cpu_reset_base + CPU_RESET_OFFSET(cpu));
+	reg &= ~CPU_RESET_ASSERT;
+	writel(reg, cpu_reset_base + CPU_RESET_OFFSET(cpu));
+
+	return 0;
+}
+
+static int __init mvebu_cpu_reset_init(void)
+{
+	struct device_node *np;
+	const struct of_device_id *match;
+	struct resource res;
+	int ret = 0;
+
+	np = of_find_matching_node_and_match(NULL, of_cpu_reset_table,
+					     &match);
+	if (!np)
+		return 0;
+
+	if (of_address_to_resource(np, 0, &res)) {
+		pr_err("unable to get resource\n");
+		ret = -ENOENT;
+		goto out;
+	}
+
+	if (!request_mem_region(res.start, resource_size(&res),
+				np->full_name)) {
+		pr_err("unable to request region\n");
+		ret = -EBUSY;
+		goto out;
+	}
+
+	cpu_reset_base = ioremap(res.start, resource_size(&res));
+	if (!cpu_reset_base) {
+		pr_err("unable to map registers\n");
+		release_mem_region(res.start, resource_size(&res));
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ncpus = (int) match->data;
+
+out:
+	of_node_put(np);
+	return ret;
+}
+
+early_initcall(mvebu_cpu_reset_init);
-- 
1.8.3.2
