From: mesihkilinc@gmail.com (Mesih Kilinc)
Date: Sun, 18 Nov 2018 17:17:02 +0300
Subject: [RFC PATCH v2 03/14] ARM: sunxi: add Allwinner ARMv5 SoCs
In-Reply-To: <cover.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
Message-ID: <8f07fac854eaaea63e199fe0e80cf20004dffbdf.1542546735.git.mesihkilinc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add option for Allwinner ARMv5 SoCs and SoC F1C100s (which has a die
used for many new F-series products, including F1C100A, F1C100s, F1C200s,
F1C500, F1C600).

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/mach-sunxi/Kconfig    | 14 +++++++++++++-
 arch/arm/mach-sunxi/Makefile   |  1 +
 arch/arm/mach-sunxi/sunxi_v5.c | 22 ++++++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-sunxi/sunxi_v5.c

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 5db17ec..066644c 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1,6 +1,6 @@
 menuconfig ARCH_SUNXI
 	bool "Allwinner SoCs"
-	depends on ARCH_MULTI_V7
+	depends on ARCH_MULTI_V5 || ARCH_MULTI_V7
 	select ARCH_HAS_RESET_CONTROLLER
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
@@ -64,4 +64,16 @@ config ARCH_SUNXI_MC_SMP
 
 endif
 
+if ARCH_MULTI_V5
+
+config ARCH_SUNXI_V5
+	bool
+	select SUN4I_TIMER
+
+config MACH_SUNIV
+	bool "Allwinner new F-series (suniv) SoCs support"
+	select ARCH_SUNXI_V5
+
+endif
+
 endif
diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index c9a83ab..fd17fdd 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -1,5 +1,6 @@
 CFLAGS_mc_smp.o	+= -march=armv7-a
 
 obj-$(CONFIG_ARCH_SUNXI_V7) += sunxi.o
+obj-$(CONFIG_ARCH_SUNXI_V5) += sunxi_v5.o
 obj-$(CONFIG_ARCH_SUNXI_MC_SMP) += mc_smp.o headsmp.o
 obj-$(CONFIG_SMP) += platsmp.o
diff --git a/arch/arm/mach-sunxi/sunxi_v5.c b/arch/arm/mach-sunxi/sunxi_v5.c
new file mode 100644
index 0000000..15f2d7a
--- /dev/null
+++ b/arch/arm/mach-sunxi/sunxi_v5.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree support for Allwinner F series SoCs
+ *
+ * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
+ * Copyright (C) 2018 Mesih Kilinc <mesihkilinc@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <asm/mach/arch.h>
+
+static const char * const suniv_board_dt_compat[] = {
+	"allwinner,suniv-f1c100s",
+	NULL,
+};
+
+DT_MACHINE_START(SUNXI_DT, "Allwinner suniv Family")
+	.dt_compat	= suniv_board_dt_compat,
+MACHINE_END
-- 
2.7.4
