From: gregory.clement@free-electrons.com (Gregory Clement)
Date: Wed, 27 Jun 2012 15:54:44 +0200
Subject: [PATCH v5 3/9] arm: mach-mvebu: add source files
In-Reply-To: <1340805290-9051-1-git-send-email-gregory.clement@free-electrons.com>
References: <1340805290-9051-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1340805290-9051-4-git-send-email-gregory.clement@free-electrons.com>
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
 arch/arm/mach-mvebu/common.h            |   20 +++++++
 arch/arm/mach-mvebu/system-controller.c |  100 +++++++++++++++++++++++++++++++
 5 files changed, 129 insertions(+)
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
index 0000000..14331ba
--- /dev/null
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -0,0 +1,100 @@
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
+struct mvebu_system_controller {
+	u32 rstoutn_mask_offset;
+	u32 system_soft_reset_offset;
+
+	u32 rstoutn_mask_reset_out_en;
+	u32 system_soft_reset;
+};
+static struct mvebu_system_controller *mvebu_sc;
+
+const struct mvebu_system_controller armada_370_xp_system_controller = {
+	.rstoutn_mask_offset = 0x60,
+	.system_soft_reset_offset = 0x64,
+	.rstoutn_mask_reset_out_en = 0x1,
+	.system_soft_reset = 0x1,
+};
+
+const struct mvebu_system_controller orion_system_controller = {
+	.rstoutn_mask_offset = 0x108,
+	.system_soft_reset_offset = 0x10c,
+	.rstoutn_mask_reset_out_en = 0x4,
+	.system_soft_reset = 0x1,
+};
+
+static struct of_device_id of_system_controller_table[] = {
+	{.compatible = "marvell,orion-system-controller",
+	 .data = (void *) &orion_system_controller},
+	{.compatible = "marvell,armada-370-xp-system-controller",
+	 .data = (void *) &armada_370_xp_system_controller},
+	{ /* end of list */ },
+};
+
+void mvebu_restart(char mode, const char *cmd)
+{
+	if (!system_controller_base) {
+		pr_warn("Cannot restart, system-controller not available\n");
+	} else {
+		/*
+		 * Enable soft reset to assert RSTOUTn.
+		 */
+		writel(mvebu_sc->rstoutn_mask_reset_out_en,
+			system_controller_base +
+			mvebu_sc->rstoutn_mask_offset);
+		/*
+		 * Assert soft reset.
+		 */
+		writel(mvebu_sc->system_soft_reset,
+			system_controller_base +
+			mvebu_sc->system_soft_reset_offset);
+	}
+	while (1)
+		;
+}
+
+static int __init mvebu_system_controller_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, of_system_controller_table);
+	if (np) {
+		const struct of_device_id *match =
+		    of_match_node(of_system_controller_table, np);
+		system_controller_base = of_iomap(np, 0);
+		mvebu_sc = (struct mvebu_system_controller *)match->data;
+	}
+
+	return 0;
+}
+
+arch_initcall(mvebu_system_controller_init);
-- 
1.7.9.5
