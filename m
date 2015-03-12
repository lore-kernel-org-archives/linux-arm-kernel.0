From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Thu, 12 Mar 2015 13:53:06 +0200
Subject: [PATCH v6 3/6] ARM: Alpine: smp support
Message-ID: <55017e22.8Db9BZtCPLrEwcVP%tsahee@annapurnalabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces support for waking up secondary CPU cores on
Alpine platform.

Signed-off-by: Barak Wasserstrom <barak@annapurnalabs.com>
Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-alpine/Kconfig             |  2 +
 arch/arm/mach-alpine/Makefile            |  1 +
 arch/arm/mach-alpine/alpine_cpu_pm.c     | 70 ++++++++++++++++++++++++++++++++
 arch/arm/mach-alpine/alpine_cpu_pm.h     | 26 ++++++++++++
 arch/arm/mach-alpine/alpine_cpu_resume.h | 38 +++++++++++++++++
 arch/arm/mach-alpine/platsmp.c           | 49 ++++++++++++++++++++++
 6 files changed, 186 insertions(+)
 create mode 100644 arch/arm/mach-alpine/alpine_cpu_pm.c
 create mode 100644 arch/arm/mach-alpine/alpine_cpu_pm.h
 create mode 100644 arch/arm/mach-alpine/alpine_cpu_resume.h
 create mode 100644 arch/arm/mach-alpine/platsmp.c

diff --git a/arch/arm/mach-alpine/Kconfig b/arch/arm/mach-alpine/Kconfig
index 44b9a8f..79b2649 100644
--- a/arch/arm/mach-alpine/Kconfig
+++ b/arch/arm/mach-alpine/Kconfig
@@ -4,5 +4,7 @@ config ARCH_ALPINE
 	select ARM_GIC
 	select GENERIC_IRQ_CHIP
 	select HAVE_ARM_ARCH_TIMER
+	select HAVE_SMP
+	select MFD_SYSCON
 	help
 	  This enables support for the Annapurna Labs Alpine V1 boards.
diff --git a/arch/arm/mach-alpine/Makefile b/arch/arm/mach-alpine/Makefile
index b7dbb12..b667489 100644
--- a/arch/arm/mach-alpine/Makefile
+++ b/arch/arm/mach-alpine/Makefile
@@ -1 +1,2 @@
 obj-y				+= alpine_machine.o
+obj-$(CONFIG_SMP)		+= platsmp.o alpine_cpu_pm.o
diff --git a/arch/arm/mach-alpine/alpine_cpu_pm.c b/arch/arm/mach-alpine/alpine_cpu_pm.c
new file mode 100644
index 0000000..121c77c
--- /dev/null
+++ b/arch/arm/mach-alpine/alpine_cpu_pm.c
@@ -0,0 +1,70 @@
+/*
+ * Low-level power-management support for Alpine platform.
+ *
+ * Copyright (C) 2015 Annapurna Labs Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+
+#include "alpine_cpu_pm.h"
+#include "alpine_cpu_resume.h"
+
+/* NB registers */
+#define AL_SYSFAB_POWER_CONTROL(cpu)	(0x2000 + (cpu)*0x100 + 0x20)
+
+static struct regmap *al_sysfabric;
+static struct al_cpu_resume_regs __iomem *al_cpu_resume_regs;
+static int wakeup_supported;
+
+int alpine_cpu_wakeup(unsigned int phys_cpu, uint32_t phys_resume_addr)
+{
+	if (!wakeup_supported)
+		return -ENOSYS;
+
+	/*
+	 * Set CPU resume address -
+	 * secure firmware running on boot will jump to this address
+	 * after setting proper CPU mode, and initialiing e.g. secure
+	 * regs (the same mode all CPUs are booted to - usually HYP)
+	 */
+	writel(phys_resume_addr,
+	       &al_cpu_resume_regs->per_cpu[phys_cpu].resume_addr);
+
+	/* Power-up the CPU */
+	regmap_write(al_sysfabric, AL_SYSFAB_POWER_CONTROL(phys_cpu), 0);
+
+	return 0;
+}
+
+void __init alpine_cpu_pm_init(void)
+{
+	struct device_node *np;
+	uint32_t watermark;
+
+	al_sysfabric = syscon_regmap_lookup_by_compatible("al,alpine-sysfabric-service");
+
+	np = of_find_compatible_node(NULL, NULL, "al,alpine-cpu-resume");
+	al_cpu_resume_regs = of_iomap(np, 0);
+
+	wakeup_supported = !IS_ERR(al_sysfabric) && al_cpu_resume_regs;
+
+	if (wakeup_supported) {
+		watermark = readl(&al_cpu_resume_regs->watermark);
+		wakeup_supported = (watermark & AL_CPU_RESUME_MAGIC_NUM_MASK)
+				    == AL_CPU_RESUME_MAGIC_NUM;
+	}
+}
diff --git a/arch/arm/mach-alpine/alpine_cpu_pm.h b/arch/arm/mach-alpine/alpine_cpu_pm.h
new file mode 100644
index 0000000..5179e69
--- /dev/null
+++ b/arch/arm/mach-alpine/alpine_cpu_pm.h
@@ -0,0 +1,26 @@
+/*
+ * Low-level power-management support for Alpine platform.
+ *
+ * Copyright (C) 2015 Annapurna Labs Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ALPINE_CPU_PM_H__
+#define __ALPINE_CPU_PM_H__
+
+/* Alpine CPU Power Management Services Initialization */
+void alpine_cpu_pm_init(void);
+
+/* Wake-up a CPU */
+int alpine_cpu_wakeup(unsigned int phys_cpu, uint32_t phys_resume_addr);
+
+#endif /* __ALPINE_CPU_PM_H__ */
diff --git a/arch/arm/mach-alpine/alpine_cpu_resume.h b/arch/arm/mach-alpine/alpine_cpu_resume.h
new file mode 100644
index 0000000..c80150c
--- /dev/null
+++ b/arch/arm/mach-alpine/alpine_cpu_resume.h
@@ -0,0 +1,38 @@
+/*
+ * Annapurna labs cpu-resume register structure.
+ *
+ * Copyright (C) 2015 Annapurna Labs Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef ALPINE_CPU_RESUME_H_
+#define ALPINE_CPU_RESUME_H_
+
+/* Per-cpu regs */
+struct al_cpu_resume_regs_per_cpu {
+	uint32_t	flags;
+	uint32_t	resume_addr;
+};
+
+/* general regs */
+struct al_cpu_resume_regs {
+	/* Watermark for validating the CPU resume struct */
+	uint32_t watermark;
+	uint32_t flags;
+	struct al_cpu_resume_regs_per_cpu per_cpu[];
+};
+
+/* The expected magic number for validating the resume addresses */
+#define AL_CPU_RESUME_MAGIC_NUM		0xf0e1d200
+#define AL_CPU_RESUME_MAGIC_NUM_MASK	0xffffff00
+
+#endif /* ALPINE_CPU_RESUME_H_ */
diff --git a/arch/arm/mach-alpine/platsmp.c b/arch/arm/mach-alpine/platsmp.c
new file mode 100644
index 0000000..f78429f
--- /dev/null
+++ b/arch/arm/mach-alpine/platsmp.c
@@ -0,0 +1,49 @@
+/*
+ * SMP operations for Alpine platform.
+ *
+ * Copyright (C) 2015 Annapurna Labs Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/of.h>
+
+#include <asm/smp_plat.h>
+
+#include "alpine_cpu_pm.h"
+
+static int alpine_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	phys_addr_t addr;
+
+	addr = virt_to_phys(secondary_startup);
+
+	if (addr > (phys_addr_t)(uint32_t)(-1)) {
+		pr_err("FAIL: resume address over 32bit (%pa)", &addr);
+		return -EINVAL;
+	}
+
+	return alpine_cpu_wakeup(cpu_logical_map(cpu), (uint32_t)addr);
+}
+
+static void __init alpine_smp_prepare_cpus(unsigned int max_cpus)
+{
+	alpine_cpu_pm_init();
+}
+
+static struct smp_operations alpine_smp_ops __initdata = {
+	.smp_prepare_cpus	= alpine_smp_prepare_cpus,
+	.smp_boot_secondary	= alpine_boot_secondary,
+};
+CPU_METHOD_OF_DECLARE(alpine_smp, "al,alpine-smp", &alpine_smp_ops);
-- 
1.9.1
