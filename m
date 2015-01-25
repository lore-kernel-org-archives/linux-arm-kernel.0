From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Sun, 25 Jan 2015 20:30:56 +0200
Subject: [PATCH 3/4] ARM: Alpine: smp support
Message-ID: <54c53660.F+mWFCmG+/oPpFS5%tsahee@annapurnalabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces support for waking up secondary CPU cores on
Alpine platform.

Signed-off-by: Barak Wasserstrom <barak@annapurnalabs.com>
Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
---
 arch/arm/mach-alpine/Kconfig             |  1 +
 arch/arm/mach-alpine/Makefile            |  1 +
 arch/arm/mach-alpine/alpine_cpu_pm.c     | 68 ++++++++++++++++++++++++++++++++
 arch/arm/mach-alpine/alpine_cpu_pm.h     | 26 ++++++++++++
 arch/arm/mach-alpine/alpine_cpu_resume.h | 38 ++++++++++++++++++
 arch/arm/mach-alpine/platsmp.c           | 48 ++++++++++++++++++++++
 6 files changed, 182 insertions(+)
 create mode 100644 arch/arm/mach-alpine/alpine_cpu_pm.c
 create mode 100644 arch/arm/mach-alpine/alpine_cpu_pm.h
 create mode 100644 arch/arm/mach-alpine/alpine_cpu_resume.h
 create mode 100644 arch/arm/mach-alpine/platsmp.c

diff --git a/arch/arm/mach-alpine/Kconfig b/arch/arm/mach-alpine/Kconfig
index 937cad2..2cb163d 100644
--- a/arch/arm/mach-alpine/Kconfig
+++ b/arch/arm/mach-alpine/Kconfig
@@ -4,5 +4,6 @@ config ARCH_ALPINE
 	select GENERIC_IRQ_CHIP
 	select HAVE_ARM_ARCH_TIMER
 	select ARM_GIC
+	select HAVE_SMP
 	help
 	  This enables support for the Annapurna Labs Alpine V1 boards.
diff --git a/arch/arm/mach-alpine/Makefile b/arch/arm/mach-alpine/Makefile
index 8ba9e99..fad7a68 100644
--- a/arch/arm/mach-alpine/Makefile
+++ b/arch/arm/mach-alpine/Makefile
@@ -3,3 +3,4 @@
 #
 
 obj-y				+= alpine_machine.o
+obj-$(CONFIG_SMP)		+= platsmp.o alpine_cpu_pm.o
diff --git a/arch/arm/mach-alpine/alpine_cpu_pm.c b/arch/arm/mach-alpine/alpine_cpu_pm.c
new file mode 100644
index 0000000..25c82cd
--- /dev/null
+++ b/arch/arm/mach-alpine/alpine_cpu_pm.c
@@ -0,0 +1,68 @@
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
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include <asm/io.h>
+
+#include "alpine_cpu_pm.h"
+#include "alpine_cpu_resume.h"
+
+/* NB registers */
+#define AL_SYSFAB_POWER_CONTROL_OFFSET(cpu)	(0x2000 + (cpu)*0x100 + 0x20)
+
+static void __iomem *al_sysfabric_service_base;
+static struct al_cpu_resume_regs __iomem *al_cpu_resume_regs;
+static int wakeup_supported;
+
+int alpine_cpu_wakeup(unsigned int cpu, uint32_t phys_resume_addr)
+{
+	if (!wakeup_supported)
+		return -ENOSYS;
+
+	/* Set CPU resume address */
+	writel(phys_resume_addr, &al_cpu_resume_regs->per_cpu[cpu].resume_addr);
+
+	/* Power-up the CPU */
+	writel(0, (al_sysfabric_service_base + AL_SYSFAB_POWER_CONTROL_OFFSET(cpu)));
+
+	return 0;
+}
+
+void __init alpine_cpu_pm_init(void)
+{
+	struct device_node *np;
+	uint32_t watermark;
+
+	np = of_find_compatible_node(
+		NULL, NULL, "annapurna-labs,al-sysfabric-service");
+	al_sysfabric_service_base = of_iomap(np, 0);
+
+	np = of_find_compatible_node(
+		NULL, NULL, "annapurna-labs,al-cpu-resume");
+	al_cpu_resume_regs =
+			(struct al_cpu_resume_regs __iomem *)of_iomap(np, 0);
+
+	wakeup_supported = al_sysfabric_service_base && al_cpu_resume_regs;
+
+	if (wakeup_supported) {
+		watermark = readl(&al_cpu_resume_regs->watermark);
+		wakeup_supported =
+			((watermark & AL_CPU_RESUME_MAGIC_NUM_MASK)
+					== AL_CPU_RESUME_MAGIC_NUM);
+	}
+}
diff --git a/arch/arm/mach-alpine/alpine_cpu_pm.h b/arch/arm/mach-alpine/alpine_cpu_pm.h
new file mode 100644
index 0000000..62a5f0a
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
+void __init alpine_cpu_pm_init(void);
+
+/* Wake-up a CPU */
+int alpine_cpu_wakeup(unsigned int cpu, uint32_t phys_resume_addr);
+
+#endif /* __ALPINE_CPU_PM_H__ */
diff --git a/arch/arm/mach-alpine/alpine_cpu_resume.h b/arch/arm/mach-alpine/alpine_cpu_resume.h
new file mode 100644
index 0000000..e6fe1a3
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
index 0000000..d0a279e
--- /dev/null
+++ b/arch/arm/mach-alpine/platsmp.c
@@ -0,0 +1,48 @@
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
+#include "alpine_cpu_pm.h"
+
+int __cpuinit alpine_boot_secondary(unsigned int cpu
+				, struct task_struct *idle)
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
+	return alpine_cpu_wakeup(cpu, (uint32_t)addr);
+}
+
+void __init alpine_smp_prepare_cpus(unsigned int max_cpus)
+{
+	alpine_cpu_pm_init();
+}
+
+struct smp_operations __initdata alpine_smp_ops = {
+	.smp_prepare_cpus	= alpine_smp_prepare_cpus,
+	.smp_boot_secondary	= alpine_boot_secondary,
+};
+CPU_METHOD_OF_DECLARE(alpine_smp, "annapurna-labs,alpine-smp", &alpine_smp_ops);
-- 
1.9.1
