From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Feb 2014 18:23:18 +0100
Subject: [PATCH 07/11] ARM: mvebu: add initial support for the Armada 380/385
 SOCs
In-Reply-To: <1392053002-19831-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392053002-19831-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392053002-19831-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the basic support for the Armada 380 and Armada 385
SOCs. These SoCs share most of their IP with the Armada 370/XP
SoCs. The main difference is the use of a Cortex A9 CPU instead of the
PJ4B CPU. The Armada 380 is a single core Cortex-A9, while the Armada
385 is a dual-core Cortex-A9.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/arm/armada-38x.txt         | 10 ++++++
 arch/arm/mach-mvebu/Kconfig                        | 15 ++++++++
 arch/arm/mach-mvebu/Makefile                       |  1 +
 arch/arm/mach-mvebu/armada-38x.c                   | 42 ++++++++++++++++++++++
 4 files changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-38x.txt
 create mode 100644 arch/arm/mach-mvebu/armada-38x.c

diff --git a/Documentation/devicetree/bindings/arm/armada-38x.txt b/Documentation/devicetree/bindings/arm/armada-38x.txt
new file mode 100644
index 0000000..11f2330
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/armada-38x.txt
@@ -0,0 +1,10 @@
+Marvell Armada 38x Platforms Device Tree Bindings
+-------------------------------------------------
+
+Boards with a SoC of the Marvell Armada 38x family shall have the
+following property:
+
+Required root node property:
+
+ - compatible: must contain either "marvell,armada380" or
+   "marvell,armada385" depending on the variant of the SoC being used.
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 3aefdcd..7d01583 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -52,6 +52,21 @@ config MACH_ARMADA_375
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Armada 375 SoC with device tree.
 
+config MACH_ARMADA_380
+	bool "Marvell Armada 380/385 boards"
+	select ARM_ERRATA_720789
+	select ARM_ERRATA_753970
+	select ARM_GIC
+	select ARMADA_370_XP_TIMER
+	select ARMADA_38X_CLK
+	select CACHE_L2X0
+	select CPU_V7
+	select NEON
+	select PINCTRL_ARMADA_38X
+	help
+	  Say 'Y' here if you want your kernel to support boards based
+	  on the Marvell Armada 380/385 SoC with device tree.
+
 config MACH_ARMADA_XP
 	bool "Marvell Armada XP boards"
 	select ARMADA_XP_CLK
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 9862e0f..7a439f9 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -6,6 +6,7 @@ AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
 obj-y				 += system-controller.o mvebu-soc-id.o
 obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o
 obj-$(CONFIG_MACH_ARMADA_375)    += armada-375.o
+obj-$(CONFIG_MACH_ARMADA_380)    += armada-38x.o
 obj-$(CONFIG_ARCH_MVEBU)	 += coherency.o coherency_ll.o pmsu.o
 obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
diff --git a/arch/arm/mach-mvebu/armada-38x.c b/arch/arm/mach-mvebu/armada-38x.c
new file mode 100644
index 0000000..936f606
--- /dev/null
+++ b/arch/arm/mach-mvebu/armada-38x.c
@@ -0,0 +1,42 @@
+/*
+ * Device Tree support for Armada 380/385 platforms.
+ *
+ * Copyright (C) 2014 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/clocksource.h>
+#include <linux/clk-provider.h>
+#include <linux/mbus.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/mach/arch.h>
+#include "common.h"
+
+static void __init armada_380_timer_and_clk_init(void)
+{
+	of_clk_init(NULL);
+	clocksource_of_init();
+	BUG_ON(mvebu_mbus_dt_init());
+	l2x0_of_init(0, ~0UL);
+}
+
+static const char * const armada_380_dt_compat[] = {
+	"marvell,armada380",
+	"marvell,armada385",
+	NULL,
+};
+
+DT_MACHINE_START(ARMADA_XP_DT, "Marvell Armada 380/385 (Device Tree)")
+	.init_time	= armada_380_timer_and_clk_init,
+	.restart	= mvebu_restart,
+	.dt_compat	= armada_380_dt_compat,
+MACHINE_END
-- 
1.8.3.2
