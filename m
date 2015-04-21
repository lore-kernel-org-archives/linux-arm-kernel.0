From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 21 Apr 2015 16:21:27 +0900
Subject: [PATCH v4 1/4] ARM: UniPhier: add basic support for UniPhier
 architecture
In-Reply-To: <1429600890-26713-1-git-send-email-yamada.masahiro@socionext.com>
References: <1429600890-26713-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1429600890-26713-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initial commit for a new SoC family, UniPhier, developed by
Socionext Inc. (formerly, System LSI Business Division of
Panasonic Corporation).

This commit includes a minimal set of components for booting the
kernel, including SMP support.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v4:
  - Access to SMP register with base + offset(0x1208).

Changes in v3:
  - Replace <asm/io.h> with <linux/io.h>
  - Rename uniphier_board_dt_compat to uniphier_dt_compat
  - Move uniphier_secondary_startup into platsmp.c as __naked function
  - Add return before "err:" label (bug fix)
  - Use syscon driver rather than hard-coded register address

Changes in v2:
  - Fix SoC compatible string
    "socionext,ph1-proxstream2" -> "socionext,proxstream2"

 arch/arm/Kconfig                  |  2 +
 arch/arm/Makefile                 |  1 +
 arch/arm/mach-uniphier/Kconfig    | 11 +++++
 arch/arm/mach-uniphier/Makefile   |  2 +
 arch/arm/mach-uniphier/platsmp.c  | 85 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-uniphier/uniphier.c | 30 ++++++++++++++
 6 files changed, 131 insertions(+)
 create mode 100644 arch/arm/mach-uniphier/Kconfig
 create mode 100644 arch/arm/mach-uniphier/Makefile
 create mode 100644 arch/arm/mach-uniphier/platsmp.c
 create mode 100644 arch/arm/mach-uniphier/uniphier.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 392e7ae..c332b98 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -963,6 +963,8 @@ source "arch/arm/mach-tegra/Kconfig"
 
 source "arch/arm/mach-u300/Kconfig"
 
+source "arch/arm/mach-uniphier/Kconfig"
+
 source "arch/arm/mach-ux500/Kconfig"
 
 source "arch/arm/mach-versatile/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 5575d9f..9de6aa6 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -201,6 +201,7 @@ machine-$(CONFIG_ARCH_SUNXI)		+= sunxi
 machine-$(CONFIG_ARCH_TEGRA)		+= tegra
 machine-$(CONFIG_ARCH_U300)		+= u300
 machine-$(CONFIG_ARCH_U8500)		+= ux500
+machine-$(CONFIG_ARCH_UNIPHIER)		+= uniphier
 machine-$(CONFIG_ARCH_VERSATILE)	+= versatile
 machine-$(CONFIG_ARCH_VEXPRESS)		+= vexpress
 machine-$(CONFIG_ARCH_VT8500)		+= vt8500
diff --git a/arch/arm/mach-uniphier/Kconfig b/arch/arm/mach-uniphier/Kconfig
new file mode 100644
index 0000000..a017b1d
--- /dev/null
+++ b/arch/arm/mach-uniphier/Kconfig
@@ -0,0 +1,11 @@
+config ARCH_UNIPHIER
+	bool "Socionext UniPhier SoCs"
+	depends on ARCH_MULTI_V7
+	select ARM_AMBA
+	select ARM_GLOBAL_TIMER
+	select ARM_GIC
+	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD
+	help
+	  Support for UniPhier SoC family developed by Socionext Inc.
+	  (formerly, System LSI Business Division of Panasonic Corporation)
diff --git a/arch/arm/mach-uniphier/Makefile b/arch/arm/mach-uniphier/Makefile
new file mode 100644
index 0000000..60bd226
--- /dev/null
+++ b/arch/arm/mach-uniphier/Makefile
@@ -0,0 +1,2 @@
+obj-y			:= uniphier.o
+obj-$(CONFIG_SMP)	+= platsmp.o
diff --git a/arch/arm/mach-uniphier/platsmp.c b/arch/arm/mach-uniphier/platsmp.c
new file mode 100644
index 0000000..6004fef
--- /dev/null
+++ b/arch/arm/mach-uniphier/platsmp.c
@@ -0,0 +1,85 @@
+/*
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
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
+#include <linux/sizes.h>
+#include <linux/compiler.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <asm/smp.h>
+#include <asm/smp_scu.h>
+
+static void __init uniphier_smp_prepare_cpus(unsigned int max_cpus)
+{
+	static cpumask_t only_cpu_0 = { CPU_BITS_CPU0 };
+	unsigned long scu_base_phys = 0;
+	void __iomem *scu_base;
+
+	if (scu_a9_has_base())
+		scu_base_phys = scu_a9_get_base();
+
+	if (!scu_base_phys) {
+		pr_err("failed to get scu base\n");
+		goto err;
+	}
+
+	scu_base = ioremap(scu_base_phys, SZ_128);
+	if (!scu_base) {
+		pr_err("failed to remap scu base (0x%08lx)\n", scu_base_phys);
+		goto err;
+	}
+
+	scu_enable(scu_base);
+	iounmap(scu_base);
+
+	return;
+err:
+	pr_warn("disabling SMP\n");
+	init_cpu_present(&only_cpu_0);
+}
+
+static void __naked uniphier_secondary_startup(void)
+{
+	asm("bl		v7_invalidate_l1\n"
+	    "b		secondary_startup\n");
+};
+
+static int uniphier_boot_secondary(unsigned int cpu,
+				   struct task_struct *idle)
+{
+	struct regmap *sbcm_regmap;
+	int ret;
+
+	sbcm_regmap = syscon_regmap_lookup_by_compatible(
+			"socionext,uniphier-system-bus-controller-misc");
+	if (IS_ERR(sbcm_regmap)) {
+		pr_err("failed to regmap system-bus-controller-misc\n");
+		return PTR_ERR(sbcm_regmap);
+	}
+
+	ret = regmap_write(sbcm_regmap, 0x1208,
+			   virt_to_phys(uniphier_secondary_startup));
+	if (!ret)
+		asm("sev"); /* wake up secondary CPU */
+
+	return ret;
+}
+
+struct smp_operations uniphier_smp_ops __initdata = {
+	.smp_prepare_cpus	= uniphier_smp_prepare_cpus,
+	.smp_boot_secondary	= uniphier_boot_secondary,
+};
+CPU_METHOD_OF_DECLARE(uniphier_smp, "socionext,uniphier-smp",
+		      &uniphier_smp_ops);
diff --git a/arch/arm/mach-uniphier/uniphier.c b/arch/arm/mach-uniphier/uniphier.c
new file mode 100644
index 0000000..9be10ef
--- /dev/null
+++ b/arch/arm/mach-uniphier/uniphier.c
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
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
+#include <asm/mach/arch.h>
+
+static const char * const uniphier_dt_compat[] __initconst = {
+	"socionext,ph1-sld3",
+	"socionext,ph1-ld4",
+	"socionext,ph1-pro4",
+	"socionext,ph1-sld8",
+	"socionext,ph1-pro5",
+	"socionext,proxstream2",
+	"socionext,ph1-ld6b",
+	NULL,
+};
+
+DT_MACHINE_START(UNIPHIER, "Socionext UniPhier")
+	.dt_compat	= uniphier_dt_compat,
+MACHINE_END
-- 
1.9.1
