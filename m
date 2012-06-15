From: gregory.clement@free-electrons.com (Gregory Clement)
Date: Fri, 15 Jun 2012 09:44:04 +0200
Subject: [PATCH v3 3/9] arm: mach-mvebu: add source files
In-Reply-To: <1339746250-26650-1-git-send-email-gregory.clement@free-electrons.com>
References: <1339746250-26650-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1339746250-26650-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
---
 arch/arm/mach-mvebu/Kconfig             |    7 +++
 arch/arm/mach-mvebu/Makefile            |    1 +
 arch/arm/mach-mvebu/Makefile.boot       |    1 +
 arch/arm/mach-mvebu/common.h            |   20 ++++++++
 arch/arm/mach-mvebu/system-controller.c |   78 +++++++++++++++++++++++++++++++
 5 files changed, 107 insertions(+)
 create mode 100644 arch/arm/mach-mvebu/Kconfig
 create mode 100644 arch/arm/mach-mvebu/Makefile
 create mode 100644 arch/arm/mach-mvebu/Makefile.boot
 create mode 100644 arch/arm/mach-mvebu/common.h
 create mode 100644 arch/arm/mach-mvebu/system-controller.c

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
new file mode 100644
index 0000000..72d39e5
--- /dev/null
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -0,0 +1,7 @@
+if ARCH_MVEBU
+
+menu "Marvell SOC with device tree"
+
+endmenu
+
+endif
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
new file mode 100644
index 0000000..7366ae7
--- /dev/null
+++ b/arch/arm/mach-mvebu/Makefile
@@ -0,0 +1 @@
+obj-y += system-controller.o
diff --git a/arch/arm/mach-mvebu/Makefile.boot b/arch/arm/mach-mvebu/Makefile.boot
new file mode 100644
index 0000000..b327175
--- /dev/null
+++ b/arch/arm/mach-mvebu/Makefile.boot
@@ -0,0 +1 @@
+zreladdr-y := 0x00008000
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
new file mode 100644
index 0000000..f0eaa21
--- /dev/null
+++ b/arch/arm/mach-mvebu/common.h
@@ -0,0 +1,20 @@
+/*
+ * Core functions for Marvell System On Chip
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ARCH_MVEBU_COMMON_H
+#define __ARCH_MVEBU_COMMON_H
+
+void mvebu_restart(char mode, const char *cmd);
+
+#endif
diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
new file mode 100644
index 0000000..bd6f28f
--- /dev/null
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -0,0 +1,78 @@
+/*
+ * System controller support for Armada 370 and XP platforms.
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * The Armada 370 and Armada XP SoCs both have a range of
+ * miscellaneous registers, that do not belong to a particular device,
+ * but rather provide system-level features. This basic
+ * system-controller driver provides a device tree binding for those
+ * registers, and implements utility functions offering various
+ * features related to those registers.
+ *
+ * For now, the feature set is limited to restarting the platform by a
+ * soft-reset, but it might be extended in the future.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_address.h>
+#include <linux/io.h>
+
+static void __iomem *system_controller_base;
+
+/* System controller registers */
+#define MVEBU_RSTOUTN_MASK_OFFSET	  0x60
+#define   MVEBU_RSTOUTN_MASK_RESET_OUT_EN  0x1
+#define MVEBU_SYSTEM_SOFT_RESET_OFFSET	  0x64
+#define   MVEBU_SYSTEM_SOFT_RESET          0x1
+
+void mvebu_restart(char mode, const char *cmd)
+{
+	if (!system_controller_base) {
+		pr_warn("Cannot restart, system-controller not available\n");
+		return;
+	}
+
+	/*
+	* Enable soft reset to assert RSTOUTn.
+	*/
+	writel(MVEBU_RSTOUTN_MASK_RESET_OUT_EN, system_controller_base +
+	       MVEBU_RSTOUTN_MASK_OFFSET);
+	/*
+	* Assert soft reset.
+	*/
+	writel(MVEBU_SYSTEM_SOFT_RESET, system_controller_base +
+	       MVEBU_SYSTEM_SOFT_RESET_OFFSET);
+	while (1)
+		;
+}
+
+static int __init mvebu_system_controller_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "marvell,system-controller");
+	if (!np) {
+		pr_warn("No marvell,system-controller found\n");
+		return -ENODEV;
+	}
+
+	system_controller_base = of_iomap(np, 0);
+	if (!system_controller_base) {
+		pr_warn("Cannot remap system-controller\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+arch_initcall(mvebu_system_controller_init);
-- 
1.7.9.5
