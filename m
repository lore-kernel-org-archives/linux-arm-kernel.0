From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 04 Jul 2014 19:48:08 +0200
Subject: [PATCH 08/19] ARM: s5pv210: Add board file for boot using Device Tree
In-Reply-To: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
Message-ID: <1404496099-26708-9-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>

This patch adds board file that will be used to boot S5PV210/S5PC110-based
boards using Device Tree.

Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
[t.figa: Rebased and cleaned-up a bit.]
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig   | 14 +++++++++
 arch/arm/mach-s5pv210/Makefile  |  2 +-
 arch/arm/mach-s5pv210/s5pv210.c | 68 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-s5pv210/s5pv210.c

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index f60f286..ed492cf 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -194,6 +194,20 @@ config MACH_TORBRECK
 	help
 	  Machine support for aESOP Torbreck
 
+config MACH_S5PV210_DT
+	bool "Samsung S5PV210/S5PC110 machine using Device Tree"
+	select CLKSRC_OF
+	select CPU_S5PV210
+	select PINCTRL
+	select PINCTRL_EXYNOS
+	select USE_OF
+	help
+	  Machine support for Samsung S5PV210/S5PC110 machines with Device Tree
+	  enabled.
+	  Select this if a fdt blob is available for your S5PV210 SoC based
+	  board.
+	  Note: This is under development and not all peripherals can be
+	  supported with this machine file.
 endmenu
 
 endif
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 08358bb..8d87b10 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -24,7 +24,7 @@ obj-$(CONFIG_MACH_GONI)		+= mach-goni.o
 obj-$(CONFIG_MACH_SMDKC110)	+= mach-smdkc110.o
 obj-$(CONFIG_MACH_SMDKV210)	+= mach-smdkv210.o
 obj-$(CONFIG_MACH_TORBRECK)	+= mach-torbreck.o
-
+obj-$(CONFIG_MACH_S5PV210_DT)	+= s5pv210.o
 # device support
 
 obj-y				+= dev-audio.o
diff --git a/arch/arm/mach-s5pv210/s5pv210.c b/arch/arm/mach-s5pv210/s5pv210.c
new file mode 100644
index 0000000..c244ccb
--- /dev/null
+++ b/arch/arm/mach-s5pv210/s5pv210.c
@@ -0,0 +1,68 @@
+/*
+ * Samsung's S5PC110/S5PV210 flattened device tree enabled machine.
+ *
+ * Copyright (c) 2013-2014 Samsung Electronics Co., Ltd.
+ * Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
+ * Tomasz Figa <t.figa@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/of_fdt.h>
+#include <linux/of_platform.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/system_misc.h>
+
+#include <plat/map-base.h>
+#include <mach/regs-clock.h>
+
+static int __init s5pv210_fdt_map_sys(unsigned long node, const char *uname,
+					int depth, void *data)
+{
+	struct map_desc iodesc;
+	const __be32 *reg;
+	int len;
+
+	if (!of_flat_dt_is_compatible(node, "samsung,s5pv210-clock"))
+		return 0;
+
+	reg = of_get_flat_dt_prop(node, "reg", &len);
+	if (reg == NULL || len != (sizeof(unsigned long) * 2))
+		return 0;
+
+	iodesc.pfn = __phys_to_pfn(be32_to_cpu(reg[0]));
+	iodesc.length = be32_to_cpu(reg[1]) - 1;
+	iodesc.virtual = (unsigned long)S3C_VA_SYS;
+	iodesc.type = MT_DEVICE;
+	iotable_init(&iodesc, 1);
+
+	return 1;
+}
+
+static void __init s5pv210_dt_map_io(void)
+{
+	debug_ll_io_init();
+
+	of_scan_flat_dt(s5pv210_fdt_map_sys, NULL);
+}
+
+static void s5pv210_dt_restart(enum reboot_mode mode, const char *cmd)
+{
+	__raw_writel(0x1, S5P_SWRESET);
+}
+
+static char const *s5pv210_dt_compat[] __initconst = {
+	"samsung,s5pc110",
+	"samsung,s5pv210",
+	NULL
+};
+
+DT_MACHINE_START(S5PV210_DT, "Samsung S5PC110/S5PV210-based board")
+	.dt_compat = s5pv210_dt_compat,
+	.map_io = s5pv210_dt_map_io,
+	.restart = s5pv210_dt_restart,
+MACHINE_END
-- 
1.9.3
