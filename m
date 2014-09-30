From: carlo@caione.org (Carlo Caione)
Date: Tue, 30 Sep 2014 10:43:54 +0200
Subject: [PATCH 2/3] ARM: Meson6: Add SMP support for Amlogic Meson6
In-Reply-To: <1412066635-5298-1-git-send-email-carlo@caione.org>
References: <1412066635-5298-1-git-send-email-carlo@caione.org>
Message-ID: <1412066635-5298-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amlogic Meson6 is a dual core Cortex-A9. This patch adds the logic to
boot up the second CPU.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/mach-meson/Kconfig   |  1 +
 arch/arm/mach-meson/Makefile  |  1 +
 arch/arm/mach-meson/headsmp.S |  7 ++++
 arch/arm/mach-meson/platsmp.c | 80 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+)
 create mode 100644 arch/arm/mach-meson/headsmp.S
 create mode 100644 arch/arm/mach-meson/platsmp.c

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 2c1154e..4e96de4 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -2,6 +2,7 @@ menuconfig ARCH_MESON
 	bool "Amlogic Meson SoCs" if ARCH_MULTI_V7
 	select GENERIC_IRQ_CHIP
 	select ARM_GIC
+	select HAVE_ARM_SCU if SMP
 
 if ARCH_MESON
 
diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
index 9d7380e..4691966 100644
--- a/arch/arm/mach-meson/Makefile
+++ b/arch/arm/mach-meson/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_ARCH_MESON) += meson.o
+obj-$(CONFIG_SMP) += platsmp.o headsmp.o
diff --git a/arch/arm/mach-meson/headsmp.S b/arch/arm/mach-meson/headsmp.S
new file mode 100644
index 0000000..3347d88
--- /dev/null
+++ b/arch/arm/mach-meson/headsmp.S
@@ -0,0 +1,7 @@
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+ENTRY(meson_secondary_startup)
+        bl	v7_invalidate_l1
+        b       secondary_startup
+ENDPROC(meson_secondary_startup)
diff --git a/arch/arm/mach-meson/platsmp.c b/arch/arm/mach-meson/platsmp.c
new file mode 100644
index 0000000..3d4d0cd
--- /dev/null
+++ b/arch/arm/mach-meson/platsmp.c
@@ -0,0 +1,80 @@
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/delay.h>
+#include <asm/smp_scu.h>
+#include <asm/smp_plat.h>
+#include <asm/cacheflush.h>
+
+#define MESON_CPU_CONTROL_REG		0x0
+#define MESON_CPU1_CONTROL_ADDR_REG	0x4
+
+#define MESON_CPU_CONTROL_ID(cpu)	((1 << (cpu)) | 1)
+
+static void __iomem *cpucfg_membase;
+static void __iomem *scu_membase;
+
+static DEFINE_SPINLOCK(cpu_lock);
+
+extern void meson_secondary_startup(void);
+
+static void __init meson6_smp_prepare_cpus(unsigned int max_cpus)
+{
+	struct device_node *node;
+
+	node = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
+	if (!node) {
+		pr_err("Missing Meson6 SCU node\n");
+		return;
+	}
+
+	scu_membase = of_iomap(node, 0);
+	if (!scu_membase) {
+		pr_err("Couln't map Meson6 SCU registers\n");
+		return;
+	}
+
+	node = of_find_compatible_node(NULL, NULL, "amlogic,meson6-cpuconfig");
+	if (!node) {
+		pr_err("Missing Meson6 CPU config node\n");
+		return;
+	}
+
+	cpucfg_membase = of_iomap(node, 0);
+	if (!cpucfg_membase) {
+		pr_err("Couldn't map Meson6 CPU config registers\n");
+		return;
+	}
+
+	scu_enable(scu_membase);
+}
+
+static int meson6_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	if (!cpucfg_membase)
+		return -EFAULT;
+
+	spin_lock(&cpu_lock);
+
+	writel(virt_to_phys(meson_secondary_startup), cpucfg_membase +
+		MESON_CPU1_CONTROL_ADDR_REG);
+	writel(MESON_CPU_CONTROL_ID(cpu), cpucfg_membase +
+		MESON_CPU_CONTROL_REG);
+
+	smp_wmb();
+
+	dsb_sev();
+
+	spin_unlock(&cpu_lock);
+
+	return 0;
+}
+
+static struct smp_operations meson6_smp_ops __initdata = {
+	.smp_prepare_cpus	= meson6_smp_prepare_cpus,
+	.smp_boot_secondary	= meson6_smp_boot_secondary,
+};
+
+CPU_METHOD_OF_DECLARE(meson6_smp, "amlogic,meson6-smp", &meson6_smp_ops);
-- 
1.9.1
