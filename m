From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 18 Jun 2015 17:11:32 -0700
Subject: [PATCH 3/7] soc: add stubs for brcmstb SoC's
In-Reply-To: <1434672696-13632-1-git-send-email-computersforpeace@gmail.com>
References: <1434672696-13632-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1434672696-13632-4-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Used on BCM7xxx Set-Top Box chips (e.g., BCM7445).

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 arch/arm/mach-bcm/Kconfig    |  1 +
 drivers/soc/Kconfig          |  1 +
 drivers/soc/Makefile         |  1 +
 drivers/soc/brcmstb/Kconfig  |  9 +++++++++
 drivers/soc/brcmstb/Makefile |  1 +
 drivers/soc/brcmstb/common.c | 33 +++++++++++++++++++++++++++++++++
 include/soc/brcmstb/common.h | 15 +++++++++++++++
 7 files changed, 61 insertions(+)
 create mode 100644 drivers/soc/brcmstb/Kconfig
 create mode 100644 drivers/soc/brcmstb/Makefile
 create mode 100644 drivers/soc/brcmstb/common.c
 create mode 100644 include/soc/brcmstb/common.h

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index e9184feffc4e..11cf1c97093f 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -146,6 +146,7 @@ config ARCH_BRCMSTB
 	select BRCMSTB_L2_IRQ
 	select BCM7120_L2_IRQ
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select SOC_BRCMSTB
 	help
 	  Say Y if you intend to run the kernel on a Broadcom ARM-based STB
 	  chipset.
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 96ddecb92254..c9c0fcce98a7 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -1,5 +1,6 @@
 menu "SOC (System On Chip) specific Drivers"
 
+source "drivers/soc/brcmstb/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/sunxi/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 7dc7c0d8a2c1..2706b1159e32 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the Linux Kernel SOC specific device drivers.
 #
 
+obj-$(CONFIG_SOC_BRCMSTB)	+= brcmstb/
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
diff --git a/drivers/soc/brcmstb/Kconfig b/drivers/soc/brcmstb/Kconfig
new file mode 100644
index 000000000000..39cab3bd544d
--- /dev/null
+++ b/drivers/soc/brcmstb/Kconfig
@@ -0,0 +1,9 @@
+menuconfig SOC_BRCMSTB
+	bool "Broadcom STB SoC drivers"
+	depends on ARM
+	help
+	  Enables drivers for the Broadcom Set-Top Box (STB) series of chips.
+	  This option alone enables only some support code, while the drivers
+	  can be enabled individually within this menu.
+
+	  If unsure, say N.
diff --git a/drivers/soc/brcmstb/Makefile b/drivers/soc/brcmstb/Makefile
new file mode 100644
index 000000000000..183280e39f80
--- /dev/null
+++ b/drivers/soc/brcmstb/Makefile
@@ -0,0 +1 @@
+obj-y				+= common.o
diff --git a/drivers/soc/brcmstb/common.c b/drivers/soc/brcmstb/common.c
new file mode 100644
index 000000000000..c262c029b1b8
--- /dev/null
+++ b/drivers/soc/brcmstb/common.c
@@ -0,0 +1,33 @@
+/*
+ * Copyright ? 2014 NVIDIA Corporation
+ * Copyright ? 2015 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/of.h>
+
+#include <soc/brcmstb/common.h>
+
+static const struct of_device_id brcmstb_machine_match[] = {
+	{ .compatible = "brcm,brcmstb", },
+	{ }
+};
+
+bool soc_is_brcmstb(void)
+{
+	struct device_node *root;
+
+	root = of_find_node_by_path("/");
+	if (!root)
+		return false;
+
+	return of_match_node(brcmstb_machine_match, root) != NULL;
+}
diff --git a/include/soc/brcmstb/common.h b/include/soc/brcmstb/common.h
new file mode 100644
index 000000000000..cfb5335f2a15
--- /dev/null
+++ b/include/soc/brcmstb/common.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright ? 2014 NVIDIA Corporation
+ * Copyright ? 2015 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __SOC_BRCMSTB_COMMON_H__
+#define __SOC_BRCMSTB_COMMON_H__
+
+bool soc_is_brcmstb(void);
+
+#endif /* __SOC_BRCMSTB_COMMON_H__ */
-- 
1.9.1
