From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Feb 2014 18:23:13 +0100
Subject: [PATCH 02/11] ARM: mvebu: add initial support for the Armada 375 SOCs
In-Reply-To: <1392053002-19831-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392053002-19831-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392053002-19831-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

This commit adds the basic support for the Armada 375 SOCs. These SoCs
share most of their IP with the Armada 370/XP SoCs. The main
difference is the use of a Cortex A9 CPU instead of the PJ4B CPU. The
interrupt controller and the L2 cache controller are also different
they are respectively the GIC and the PL310.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/arm/armada-375.txt         |  9 +++++
 arch/arm/mach-mvebu/Kconfig                        | 15 ++++++++
 arch/arm/mach-mvebu/Makefile                       |  1 +
 arch/arm/mach-mvebu/armada-375.c                   | 44 ++++++++++++++++++++++
 4 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-375.txt
 create mode 100644 arch/arm/mach-mvebu/armada-375.c

diff --git a/Documentation/devicetree/bindings/arm/armada-375.txt b/Documentation/devicetree/bindings/arm/armada-375.txt
new file mode 100644
index 0000000..867d0b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/armada-375.txt
@@ -0,0 +1,9 @@
+Marvell Armada 375 Platforms Device Tree Bindings
+-------------------------------------------------
+
+Boards with a SoC of the Marvell Armada 375 family shall have the
+following property:
+
+Required root node property:
+
+compatible: must contain "marvell,armada375"
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 5e269d7..3aefdcd 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -37,6 +37,21 @@ config MACH_ARMADA_370
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Armada 370 SoC with device tree.
 
+config MACH_ARMADA_375
+	bool "Marvell Armada 375 boards"
+	select ARM_ERRATA_720789
+	select ARM_ERRATA_753970
+	select ARM_GIC
+	select ARMADA_370_XP_TIMER
+	select ARMADA_375_CLK
+	select CACHE_L2X0
+	select CPU_V7
+	select NEON
+	select PINCTRL_ARMADA_375
+	help
+	  Say 'Y' here if you want your kernel to support boards based
+	  on the Marvell Armada 375 SoC with device tree.
+
 config MACH_ARMADA_XP
 	bool "Marvell Armada XP boards"
 	select ARMADA_XP_CLK
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 878aebe..9862e0f 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -5,6 +5,7 @@ AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
 
 obj-y				 += system-controller.o mvebu-soc-id.o
 obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o
+obj-$(CONFIG_MACH_ARMADA_375)    += armada-375.o
 obj-$(CONFIG_ARCH_MVEBU)	 += coherency.o coherency_ll.o pmsu.o
 obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
diff --git a/arch/arm/mach-mvebu/armada-375.c b/arch/arm/mach-mvebu/armada-375.c
new file mode 100644
index 0000000..f13c9de
--- /dev/null
+++ b/arch/arm/mach-mvebu/armada-375.c
@@ -0,0 +1,44 @@
+/*
+ * Device Tree support for Armada 375 platforms.
+ *
+ * Copyright (C) 2014 Marvell
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
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/clocksource.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/mbus.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/mach/arch.h>
+#include "common.h"
+
+static void __init armada_375_timer_and_clk_init(void)
+{
+	of_clk_init(NULL);
+	clocksource_of_init();
+	BUG_ON(mvebu_mbus_dt_init());
+	l2x0_of_init(0, ~0UL);
+}
+
+static const char * const armada_375_dt_compat[] = {
+	"marvell,armada375",
+	NULL,
+};
+
+DT_MACHINE_START(ARMADA_375_DT, "Marvell Armada 375 (Device Tree)")
+	.init_time	= armada_375_timer_and_clk_init,
+	.restart	= mvebu_restart,
+	.dt_compat	= armada_375_dt_compat,
+MACHINE_END
-- 
1.8.3.2
