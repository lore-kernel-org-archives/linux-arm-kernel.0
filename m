From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Thu, 12 Mar 2015 13:53:00 +0200
Subject: [PATCH v6 1/6] ARM: Alpine: Initial support for Alpine platform
Message-ID: <55017e1c.ae2j4LOAfljYtvOr%tsahee@annapurnalabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces initial architecture and device-tree support.

Signed-off-by: Saeed Bishara <saeed@annapurnalabs.com>
Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                      |  2 ++
 arch/arm/Makefile                     |  1 +
 arch/arm/mach-alpine/Kconfig          |  8 ++++++++
 arch/arm/mach-alpine/Makefile         |  1 +
 arch/arm/mach-alpine/alpine_machine.c | 28 ++++++++++++++++++++++++++++
 5 files changed, 40 insertions(+)
 create mode 100644 arch/arm/mach-alpine/Kconfig
 create mode 100644 arch/arm/mach-alpine/Makefile
 create mode 100644 arch/arm/mach-alpine/alpine_machine.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 55f1d9b..877380b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -843,6 +843,8 @@ config ARCH_VIRT
 #
 source "arch/arm/mach-mvebu/Kconfig"
 
+source "arch/arm/mach-alpine/Kconfig"
+
 source "arch/arm/mach-asm9260/Kconfig"
 
 source "arch/arm/mach-at91/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index eb7bb51..ef4da73 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -143,6 +143,7 @@ textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
 
 # Machine directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
+machine-$(CONFIG_ARCH_ALPINE)		+= alpine
 machine-$(CONFIG_ARCH_AT91)		+= at91
 machine-$(CONFIG_ARCH_AXXIA)		+= axxia
 machine-$(CONFIG_ARCH_BCM)		+= bcm
diff --git a/arch/arm/mach-alpine/Kconfig b/arch/arm/mach-alpine/Kconfig
new file mode 100644
index 0000000..44b9a8f
--- /dev/null
+++ b/arch/arm/mach-alpine/Kconfig
@@ -0,0 +1,8 @@
+config ARCH_ALPINE
+	bool "Annapurna Labs Alpine platform" if ARCH_MULTI_V7
+	select ARM_AMBA
+	select ARM_GIC
+	select GENERIC_IRQ_CHIP
+	select HAVE_ARM_ARCH_TIMER
+	help
+	  This enables support for the Annapurna Labs Alpine V1 boards.
diff --git a/arch/arm/mach-alpine/Makefile b/arch/arm/mach-alpine/Makefile
new file mode 100644
index 0000000..b7dbb12
--- /dev/null
+++ b/arch/arm/mach-alpine/Makefile
@@ -0,0 +1 @@
+obj-y				+= alpine_machine.o
diff --git a/arch/arm/mach-alpine/alpine_machine.c b/arch/arm/mach-alpine/alpine_machine.c
new file mode 100644
index 0000000..b8e2145
--- /dev/null
+++ b/arch/arm/mach-alpine/alpine_machine.c
@@ -0,0 +1,28 @@
+/*
+ * Machine declaration for Alpine platforms.
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
+#include <linux/of_platform.h>
+
+#include <asm/mach/arch.h>
+
+static const char * const al_match[] __initconst = {
+	"al,alpine",
+	NULL,
+};
+
+DT_MACHINE_START(AL_DT, "Annapurna Labs Alpine")
+	.dt_compat	= al_match,
+MACHINE_END
-- 
1.9.1
