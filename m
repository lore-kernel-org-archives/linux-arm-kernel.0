From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 15:50:28 +0200
Subject: [PATCH v3 1/6] ARM: mvebu: introduce CPU reset code
In-Reply-To: <1397483433-25836-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397483433-25836-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397483433-25836-2-git-send-email-thomas.petazzoni@free-electrons.com>
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
 .../devicetree/bindings/arm/armada-cpu-reset.txt   | 14 ++++
 arch/arm/mach-mvebu/Makefile                       |  2 +-
 arch/arm/mach-mvebu/common.h                       |  1 +
 arch/arm/mach-mvebu/cpu-reset.c                    | 82 ++++++++++++++++++++++
 4 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-cpu-reset.txt
 create mode 100644 arch/arm/mach-mvebu/cpu-reset.c

diff --git a/Documentation/devicetree/bindings/arm/armada-cpu-reset.txt b/Documentation/devicetree/bindings/arm/armada-cpu-reset.txt
new file mode 100644
index 0000000..b63a7b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/armada-cpu-reset.txt
@@ -0,0 +1,14 @@
+Marvell Armada CPU reset controller
+===================================
+
+Required properties:
+
+- compatible: Should be "marvell,armada-370-cpu-reset".
+
+- reg: should be register base and length as documented in the
+  datasheet for the CPU reset registers
+
+cpurst: cpurst at 20800 {
+       compatible = "marvell,armada-370-cpu-reset";
+       reg = <0x20800 0x20>;
+};
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index a63e43b..f9cfab0 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -3,7 +3,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 
 AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
 
-obj-y				 += system-controller.o mvebu-soc-id.o
+obj-y				 += system-controller.o mvebu-soc-id.o cpu-reset.o
 obj-$(CONFIG_MACH_MVEBU_V7)      += board-v7.o
 obj-$(CONFIG_MACH_DOVE)		 += dove.o
 obj-$(CONFIG_ARCH_MVEBU)	 += coherency.o coherency_ll.o pmsu.o
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
index 0000000..4ff4ce7
--- /dev/null
+++ b/arch/arm/mach-mvebu/cpu-reset.c
@@ -0,0 +1,82 @@
+/*
+ * Copyright (C) 2014 Marvell
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
+static void __iomem *cpu_reset_base;
+static size_t cpu_reset_size;
+
+#define CPU_RESET_OFFSET(cpu) (cpu * 0x8)
+#define CPU_RESET_ASSERT      BIT(0)
+
+int mvebu_cpu_reset_deassert(int cpu)
+{
+	u32 reg;
+
+	if (!cpu_reset_base)
+		return -ENODEV;
+
+	if (CPU_RESET_OFFSET(cpu) >= cpu_reset_size)
+		return -EINVAL;
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
+	struct resource res;
+	int ret = 0;
+
+	np = of_find_compatible_node(NULL, NULL,
+				     "marvell,armada-370-cpu-reset");
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
+	cpu_reset_size = resource_size(&res);
+
+out:
+	of_node_put(np);
+	return ret;
+}
+
+early_initcall(mvebu_cpu_reset_init);
-- 
1.8.3.2
