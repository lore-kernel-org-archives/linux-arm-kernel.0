From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  3 Mar 2016 12:40:05 +0100
Subject: [PATCH 12/17] arm: Add new mach-oxnas
In-Reply-To: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1457005210-18485-13-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add mach-oxnas directory containing Kconfig and generic oxnas
handling for future SoC specific features like system reset.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-oxnas/Kconfig  | 24 ++++++++++++++++++++++++
 arch/arm/mach-oxnas/Makefile |  1 +
 arch/arm/mach-oxnas/oxnas.c  | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 arch/arm/mach-oxnas/Kconfig
 create mode 100644 arch/arm/mach-oxnas/Makefile
 create mode 100644 arch/arm/mach-oxnas/oxnas.c

diff --git a/arch/arm/mach-oxnas/Kconfig b/arch/arm/mach-oxnas/Kconfig
new file mode 100644
index 0000000..6a1f24c
--- /dev/null
+++ b/arch/arm/mach-oxnas/Kconfig
@@ -0,0 +1,24 @@
+menuconfig ARCH_OXNAS
+	bool "PLX Technology OXNAS Family SoCs"
+	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_HAS_RESET_CONTROLLER
+	select PINCTRL
+	depends on ARCH_MULTI_V5
+	help
+	  Support for OxNas SoC family developed by PLX Technology.
+	  (Formely Oxford Semiconductor)
+
+if ARCH_OXNAS
+
+config MACH_OX810SE
+	bool "Support OX810SE Based Products"
+	select CPU_ARM926T
+	select PLXTECH_RPS
+	select CLKSRC_RPS_TIMER
+	select RESET_OXNAS
+	select COMMON_CLK_OXNAS
+	select PINCTRL_OXNAS
+	help
+	  Include Support for the PLX Technology OX810SE SoC Based Products.
+
+endif
diff --git a/arch/arm/mach-oxnas/Makefile b/arch/arm/mach-oxnas/Makefile
new file mode 100644
index 0000000..c54bec7
--- /dev/null
+++ b/arch/arm/mach-oxnas/Makefile
@@ -0,0 +1 @@
+obj-y			:= oxnas.o
diff --git a/arch/arm/mach-oxnas/oxnas.c b/arch/arm/mach-oxnas/oxnas.c
new file mode 100644
index 0000000..ebdcd9d
--- /dev/null
+++ b/arch/arm/mach-oxnas/oxnas.c
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
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
+#include <linux/of.h>
+#include <linux/of_platform.h>
+
+static const char * const oxnas_dt_compat[] __initconst = {
+	"plxtech,ox810se",
+	NULL,
+};
+
+static void __init oxnas_init(void)
+{
+	pr_info("OXNAS Device Tree boot\n");
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+DT_MACHINE_START(OXNAS, "PLX Technology OXNAS Family")
+	.dt_compat	= oxnas_dt_compat,
+	.init_machine	= oxnas_init,
+MACHINE_END
-- 
1.9.1
