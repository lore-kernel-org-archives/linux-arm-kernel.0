From: gregory.clement@free-electrons.com (Gregory Clement)
Date: Tue, 26 Jun 2012 10:28:27 +0200
Subject: [PATCH v4 3/9] arm: mach-mvebu: add source files
In-Reply-To: <1340699313-29331-1-git-send-email-gregory.clement@free-electrons.com>
References: <1340699313-29331-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1340699313-29331-4-git-send-email-gregory.clement@free-electrons.com>
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
 arch/arm/mach-mvebu/common.h            |   20 ++++++
 arch/arm/mach-mvebu/system-controller.c |  103 +++++++++++++++++++++++++++++++
 5 files changed, 132 insertions(+)
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
index 0000000..2e98cd4
--- /dev/null
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -0,0 +1,103 @@
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
+static void __iomem *reset_base;
+static unsigned long rstoutn_mask_reset_out_en;
+
+/* System controller registers */
+#define ARMADA_370_XP_RESET_OFFSET		  0x60
+#define OTHER_MVEBU_RESET_OFFSET		 0x108
+#define MVEBU_RSTOUTN_MASK_OFFSET		   0x0
+#define   OTHER_MVEBU_RSTOUTN_MASK_RESET_OUT_EN	   0x4
+#define   ARMADA_370_XP_RSTOUTN_MASK_RESET_OUT_EN  0x1
+#define MVEBU_SYSTEM_SOFT_RESET_OFFSET		   0x4
+#define   MVEBU_SYSTEM_SOFT_RESET		   0x1
+
+#define OTHER_MVEBU_VARIANT	1
+#define ARMADA_370_XP_VARIANT	2
+
+void mvebu_restart(char mode, const char *cmd)
+{
+	if (!system_controller_base) {
+		pr_warn("Cannot restart, system-controller not available\n");
+		return;
+	}
+	/*
+	 * Enable soft reset to assert RSTOUTn.
+	 */
+	writel(rstoutn_mask_reset_out_en, reset_base +
+	       MVEBU_RSTOUTN_MASK_OFFSET);
+
+	/*
+	 * Assert soft reset.
+	 */
+	writel(MVEBU_SYSTEM_SOFT_RESET, reset_base +
+	       MVEBU_SYSTEM_SOFT_RESET_OFFSET);
+
+	while (1)
+		;
+}
+
+static struct of_device_id of_system_controller_table[] = {
+	{.compatible = "marvell,mvebu-other-system-controller",
+	 .data = (void *)OTHER_MVEBU_VARIANT},
+	{.compatible = "marvell,armada-370-xp-system-controller",
+	 .data = (void *)ARMADA_370_XP_VARIANT},
+	{ /* end of list */ },
+};
+
+static int __init mvebu_system_controller_init(void)
+{
+	struct device_node *np;
+	int type;
+
+	np = of_find_matching_node(NULL, of_system_controller_table);
+	if (np) {
+		struct of_device_id *match =
+		    of_match_node(of_system_controller_table, np);
+		system_controller_base = of_iomap(np, 0);
+		type = (int)match->data;
+		if (type == ARMADA_370_XP_VARIANT) {
+			reset_base =
+			    system_controller_base + ARMADA_370_XP_RESET_OFFSET;
+			rstoutn_mask_reset_out_en =
+			    ARMADA_370_XP_RSTOUTN_MASK_RESET_OUT_EN;
+		} else {
+			reset_base =
+			    system_controller_base + OTHER_MVEBU_RESET_OFFSET;
+			rstoutn_mask_reset_out_en =
+			    OTHER_MVEBU_RSTOUTN_MASK_RESET_OUT_EN;
+		}
+	}
+
+	return 0;
+}
+
+arch_initcall(mvebu_system_controller_init);
-- 
1.7.9.5
