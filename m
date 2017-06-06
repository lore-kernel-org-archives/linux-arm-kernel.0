From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  6 Jun 2017 02:54:04 +0200
Subject: [PATCH v4 06/28] ARM: Prepare Actions Semi S500
In-Reply-To: <20170606005426.26446-1-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
Message-ID: <20170606005426.26446-7-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ARCH_ACTIONS and mach-actions/owl.c for "actions,s500".

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3 -> v4: Unchanged
 
 v2 -> v3:
 * Selected AMBA, global timer, TWD drivers
 * Fixed copy&paste in machine definition (Alberto)
 
 v1 -> v2:
 * Renamed ARCH_OWL to ARCH_ACTION (Arnd)
 * Renamed mach-owl to mach-actions, leaving owl.c
 * Adopted "actions" vendor prefix
 * Selected new clocksource driver
 
 arch/arm/Kconfig               |  2 ++
 arch/arm/Makefile              |  1 +
 arch/arm/mach-actions/Kconfig  | 15 +++++++++++++++
 arch/arm/mach-actions/Makefile |  1 +
 arch/arm/mach-actions/owl.c    | 28 ++++++++++++++++++++++++++++
 5 files changed, 47 insertions(+)
 create mode 100644 arch/arm/mach-actions/Kconfig
 create mode 100644 arch/arm/mach-actions/Makefile
 create mode 100644 arch/arm/mach-actions/owl.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4a5876ff38bf..763700e74030 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -712,6 +712,8 @@ config ARCH_VIRT
 #
 source "arch/arm/mach-mvebu/Kconfig"
 
+source "arch/arm/mach-actions/Kconfig"
+
 source "arch/arm/mach-alpine/Kconfig"
 
 source "arch/arm/mach-artpec/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 65f4e2a4eb94..47d3a1ab08d2 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -151,6 +151,7 @@ textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
 
 # Machine directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
+machine-$(CONFIG_ARCH_ACTIONS)		+= actions
 machine-$(CONFIG_ARCH_ALPINE)		+= alpine
 machine-$(CONFIG_ARCH_ARTPEC)		+= artpec
 machine-$(CONFIG_ARCH_AT91)		+= at91
diff --git a/arch/arm/mach-actions/Kconfig b/arch/arm/mach-actions/Kconfig
new file mode 100644
index 000000000000..717adc1630a1
--- /dev/null
+++ b/arch/arm/mach-actions/Kconfig
@@ -0,0 +1,15 @@
+menuconfig ARCH_ACTIONS
+	bool "Actions Semi SoCs"
+	depends on ARCH_MULTI_V7
+	select ARM_AMBA
+	select ARM_GIC
+	select ARM_GLOBAL_TIMER
+	select CACHE_L2X0
+	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
+	select COMMON_CLK
+	select GENERIC_IRQ_CHIP
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
+	select OWL_TIMER
+	help
+	  This enables support for the Actions Semiconductor S500 SoC family.
diff --git a/arch/arm/mach-actions/Makefile b/arch/arm/mach-actions/Makefile
new file mode 100644
index 000000000000..524c3817bcb3
--- /dev/null
+++ b/arch/arm/mach-actions/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ARCH_ACTIONS) += owl.o
diff --git a/arch/arm/mach-actions/owl.c b/arch/arm/mach-actions/owl.c
new file mode 100644
index 000000000000..4ac4a860f3d6
--- /dev/null
+++ b/arch/arm/mach-actions/owl.c
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C) 2017 Andreas F?rber
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+
+static const char * const owl_dt_compat[] = {
+	"actions,s500",
+	NULL
+};
+
+DT_MACHINE_START(OWL, "Actions Semi Owl platform")
+	.dt_compat	= owl_dt_compat,
+	.l2c_aux_val	= 0,
+	.l2c_aux_mask	= ~0,
+MACHINE_END
-- 
2.12.3
