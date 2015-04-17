From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 17 Apr 2015 15:33:52 -0700
Subject: [PATCH 7/7] ARM: BCM63xx: Add SMP support for BCM63138
In-Reply-To: <1429310032-19402-1-git-send-email-f.fainelli@gmail.com>
References: <1429310032-19402-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1429310032-19402-8-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for booting the secondary CPU on BCM63138, this involves:

- locating the bootlut to write the reset vector
- powering up the second CPU when we need to using the DT-supplied PMB
  references
- disabling VFP when enabled such that we can keep having SMP

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-bcm/Makefile          |   7 +-
 arch/arm/mach-bcm/bcm63xx_headsmp.S |  23 +++++
 arch/arm/mach-bcm/bcm63xx_smp.c     | 171 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-bcm/bcm63xx_smp.h     |   9 ++
 4 files changed, 209 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-bcm/bcm63xx_headsmp.S
 create mode 100644 arch/arm/mach-bcm/bcm63xx_smp.c
 create mode 100644 arch/arm/mach-bcm/bcm63xx_smp.h

diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index 4c38674c73ec..647f43f0bace 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -38,7 +38,12 @@ obj-$(CONFIG_ARCH_BCM2835)	+= board_bcm2835.o
 obj-$(CONFIG_ARCH_BCM_5301X)	+= bcm_5301x.o
 
 # BCM63XXx
-obj-$(CONFIG_ARCH_BCM_63XX)	:= bcm63xx.o
+ifeq ($(CONFIG_ARCH_BCM_63XX),y)
+obj-y				+= bcm63xx.o
+CFLAGS_bcm63xx_headsmp.o	+= -march=armv7-a
+obj-$(CONFIG_SMP)		+= bcm63xx_smp.o bcm63xx_headsmp.o \
+				   bcm63xx_pmb.o
+endif
 
 ifeq ($(CONFIG_ARCH_BRCMSTB),y)
 CFLAGS_platsmp-brcmstb.o	+= -march=armv7-a
diff --git a/arch/arm/mach-bcm/bcm63xx_headsmp.S b/arch/arm/mach-bcm/bcm63xx_headsmp.S
new file mode 100644
index 000000000000..c7af397c7f14
--- /dev/null
+++ b/arch/arm/mach-bcm/bcm63xx_headsmp.S
@@ -0,0 +1,23 @@
+/*
+ *  Copyright (C) 2015, Broadcom Corporation
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/linkage.h>
+#include <linux/init.h>
+#include <asm/assembler.h>
+
+ENTRY(bcm63138_secondary_startup)
+ ARM_BE8(setend	be)
+	/*
+	 * L1 cache does have unpredictable contents at power-up clean its
+	 * contents without flushing
+	 */
+	bl      v7_invalidate_l1
+	nop
+
+	b	secondary_startup
+ENDPROC(bcm63138_secondary_startup)
diff --git a/arch/arm/mach-bcm/bcm63xx_smp.c b/arch/arm/mach-bcm/bcm63xx_smp.c
new file mode 100644
index 000000000000..44fe96eda2b0
--- /dev/null
+++ b/arch/arm/mach-bcm/bcm63xx_smp.c
@@ -0,0 +1,171 @@
+/*
+ * Broadcom BCM63138 DSL SoCs SMP support code
+ *
+ * Copyright (C) 2015, Broadcom Corporation
+ *
+ * Licensed under the terms of the GPLv2
+ */
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/bcm63xx_pmb.h>
+
+#include <asm/cacheflush.h>
+#include <asm/smp_scu.h>
+#include <asm/smp_plat.h>
+
+#include "bcm63xx_smp.h"
+
+/* Size of mapped Cortex A9 SCU address space */
+#define CORTEX_A9_SCU_SIZE	0x58
+
+extern unsigned int VFP_arch;
+
+/*
+ * Enable the Cortex A9 Snoop Control Unit
+ *
+ * By the time this is called we already know there are multiple
+ * cores present.  We assume we're running on a Cortex A9 processor,
+ * so any trouble getting the base address register or getting the
+ * SCU base is a problem.
+ *
+ * Return 0 if successful or an error code otherwise.
+ */
+static int __init scu_a9_enable(void)
+{
+	unsigned long config_base;
+	void __iomem *scu_base;
+	unsigned int i, ncores;
+
+	if (!scu_a9_has_base()) {
+		pr_err("no configuration base address register!\n");
+		return -ENXIO;
+	}
+
+	/* Config base address register value is zero for uniprocessor */
+	config_base = scu_a9_get_base();
+	if (!config_base) {
+		pr_err("hardware reports only one core\n");
+		return -ENOENT;
+	}
+
+	scu_base = ioremap((phys_addr_t)config_base, CORTEX_A9_SCU_SIZE);
+	if (!scu_base) {
+		pr_err("failed to remap config base (%lu/%u) for SCU\n",
+			config_base, CORTEX_A9_SCU_SIZE);
+		return -ENOMEM;
+	}
+
+	scu_enable(scu_base);
+
+	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
+
+	if (ncores > nr_cpu_ids) {
+		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
+				ncores, nr_cpu_ids);
+		ncores = nr_cpu_ids;
+	}
+
+	/* The BCM63138 SoC has two Cortex-A9 CPUs, CPU0 features a complete
+	 * and fully functional VFP unit that can be used, but CPU1 does not.
+	 * Since we will not be able to trap kernel-mode NEON to force
+	 * migration to CPU0, just do not advertise VFP support at all.
+	 *
+	 * This will make vfp_init bail out and do not attempt to use VFP at
+	 * all, for kernel-mode NEON, we do not want to introduce any
+	 * conditionals in hot-paths, so we just restrict the system to UP.
+	 */
+#ifdef CONFIG_VFP
+	if (ncores > 1) {
+		pr_warn("SMP: secondary CPUs lack VFP unit, disabling VFP\n");
+		VFP_arch = 1;
+
+#ifdef CONFIG_KERNEL_MODE_NEON
+		WARN(1, "SMP: kernel-mode NEON enabled, restricting to UP\n");
+		ncores = 1;
+#endif
+	}
+#endif
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+
+	iounmap(scu_base);	/* That's the last we'll need of this */
+
+	return 0;
+}
+
+static const struct of_device_id bcm63138_bootlut_ids[] = {
+	{ .compatible = "brcm,bcm63138-bootlut", },
+	{ /* sentinel */ },
+};
+
+#define BOOTLUT_RESET_VECT	0x20
+
+static int bcm63138_smp_boot_secondary(unsigned int cpu,
+				       struct task_struct *idle)
+{
+	void __iomem *bootlut_base;
+	struct device_node *dn;
+	int ret = 0;
+	u32 val;
+
+	dn = of_find_matching_node(NULL, bcm63138_bootlut_ids);
+	if (!dn) {
+		pr_err("SMP: unable to find bcm63138 boot LUT node\n");
+		return -ENODEV;
+	}
+
+	bootlut_base = of_iomap(dn, 0);
+	of_node_put(dn);
+
+	if (!bootlut_base) {
+		pr_err("SMP: unable to remap boot LUT base register\n");
+		return -ENOMEM;
+	}
+
+	/* Locate the secondary CPU node */
+	dn = of_get_cpu_node(cpu_logical_map(cpu), NULL);
+	if (!dn) {
+		pr_err("SMP: failed to locate secondary CPU%d node\n", cpu);
+		ret = -ENODEV;
+		goto out;
+	}
+
+	/* Write the secondary init routine to the BootLUT reset vector */
+	val = virt_to_phys(bcm63138_secondary_startup);
+	writel_relaxed(val, bootlut_base + BOOTLUT_RESET_VECT);
+
+	/* Power up the core, will jump straight to its reset vector when we
+	 * return
+	 */
+	ret = bcm63xx_pmb_power_on_cpu(dn);
+	if (ret)
+		goto out;
+out:
+	iounmap(bootlut_base);
+
+	return ret;
+}
+
+static void __init bcm63138_smp_prepare_cpus(unsigned int max_cpus)
+{
+	int ret;
+
+	ret = scu_a9_enable();
+	if (ret) {
+		pr_warn("SMP: Cortex-A9 SCU setup failed\n");
+		return;
+	}
+}
+
+struct smp_operations bcm63138_smp_ops __initdata = {
+	.smp_prepare_cpus	= bcm63138_smp_prepare_cpus,
+	.smp_boot_secondary	= bcm63138_smp_boot_secondary,
+};
+
+CPU_METHOD_OF_DECLARE(bcm63138_smp, "brcm,bcm63138", &bcm63138_smp_ops);
diff --git a/arch/arm/mach-bcm/bcm63xx_smp.h b/arch/arm/mach-bcm/bcm63xx_smp.h
new file mode 100644
index 000000000000..50b76044536e
--- /dev/null
+++ b/arch/arm/mach-bcm/bcm63xx_smp.h
@@ -0,0 +1,9 @@
+#ifndef __BCM63XX_SMP_H
+#define __BCM63XX_SMP_H
+
+struct device_node;
+
+extern void bcm63138_secondary_startup(void);
+extern int bcm63xx_pmb_power_on_cpu(struct device_node *dn);
+
+#endif /* __BCM63XX_SMP_H */
-- 
2.1.0
