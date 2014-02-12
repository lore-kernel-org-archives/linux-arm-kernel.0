From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 12 Feb 2014 11:23:35 +0100
Subject: [PATCH v2 06/10] ARM: mvebu: add initial support for the Armada
 380/385 SOCs
In-Reply-To: <1392200619-3141-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392200619-3141-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392200619-3141-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the basic support for the Armada 380 and Armada 385
SOCs. These SoCs share most of their IP with the Armada 370/XP
SoCs. The main difference is the use of a Cortex A9 CPU instead of the
PJ4B CPU. The Armada 380 is a single core Cortex-A9, while the Armada
385 is a dual-core Cortex-A9.

Instead of create a separate file that would be highly similar, we
re-use the existing armada-375.c file, rename it armada-375-38x.c and
extend it to cover Armada 380/385. We keep separate DT_MACHINE_START
structures for two reasons:

 1/ To have a different string shown at kernel boot time to identify
    the SoC.

 2/ Because the SMP operations will likely be different for both SOCs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/armada-38x.txt | 10 ++++++++++
 arch/arm/mach-mvebu/Kconfig                          | 20 ++++++++++++++++++++
 arch/arm/mach-mvebu/Makefile                         |  2 +-
 .../mach-mvebu/{armada-375.c => armada-375-38x.c}    | 20 +++++++++++++++++---
 4 files changed, 48 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-38x.txt
 rename arch/arm/mach-mvebu/{armada-375.c => armada-375-38x.c} (76%)

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
index 3aefdcd..f51b530 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -37,6 +37,9 @@ config MACH_ARMADA_370
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Armada 370 SoC with device tree.
 
+config MACH_ARMADA_375_38X
+	bool
+
 config MACH_ARMADA_375
 	bool "Marvell Armada 375 boards"
 	select ARM_ERRATA_720789
@@ -46,12 +49,29 @@ config MACH_ARMADA_375
 	select ARMADA_375_CLK
 	select CACHE_L2X0
 	select CPU_V7
+	select MACH_ARMADA_375_38X
 	select NEON
 	select PINCTRL_ARMADA_375
 	help
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Armada 375 SoC with device tree.
 
+config MACH_ARMADA_38X
+	bool "Marvell Armada 380/385 boards"
+	select ARM_ERRATA_720789
+	select ARM_ERRATA_753970
+	select ARM_GIC
+	select ARMADA_370_XP_TIMER
+	select ARMADA_38X_CLK
+	select CACHE_L2X0
+	select CPU_V7
+	select MACH_ARMADA_375_38X
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
index 9862e0f..69c66af 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -5,7 +5,7 @@ AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
 
 obj-y				 += system-controller.o mvebu-soc-id.o
 obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o
-obj-$(CONFIG_MACH_ARMADA_375)    += armada-375.o
+obj-$(CONFIG_MACH_ARMADA_375_38X) += armada-375-38x.o
 obj-$(CONFIG_ARCH_MVEBU)	 += coherency.o coherency_ll.o pmsu.o
 obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
diff --git a/arch/arm/mach-mvebu/armada-375.c b/arch/arm/mach-mvebu/armada-375-38x.c
similarity index 76%
rename from arch/arm/mach-mvebu/armada-375.c
rename to arch/arm/mach-mvebu/armada-375-38x.c
index d772ae2..4b09e80 100644
--- a/arch/arm/mach-mvebu/armada-375.c
+++ b/arch/arm/mach-mvebu/armada-375-38x.c
@@ -1,5 +1,5 @@
 /*
- * Device Tree support for Armada 375 platforms.
+ * Device Tree support for Armada 375/38x platforms.
  *
  * Copyright (C) 2014 Marvell
  *
@@ -51,8 +51,10 @@ static void __init armada_375_timer_and_clk_init(void)
 	clocksource_of_init();
 	BUG_ON(mvebu_mbus_dt_init());
 	l2x0_of_init(0, ~0UL);
-	hook_fault_code(16 + 6, armada_375_external_abort_wa, SIGBUS, 0,
-			"imprecise external abort");
+
+	if (of_machine_is_compatible("marvell,armada375"))
+		hook_fault_code(16 + 6, armada_375_external_abort_wa, SIGBUS, 0,
+				"imprecise external abort");
 }
 
 static const char * const armada_375_dt_compat[] = {
@@ -65,3 +67,15 @@ DT_MACHINE_START(ARMADA_375_DT, "Marvell Armada 375 (Device Tree)")
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_375_dt_compat,
 MACHINE_END
+
+static const char * const armada_38x_dt_compat[] = {
+	"marvell,armada380",
+	"marvell,armada385",
+	NULL,
+};
+
+DT_MACHINE_START(ARMADA_38X_DT, "Marvell Armada 380/385 (Device Tree)")
+	.init_time	= armada_375_timer_and_clk_init,
+	.restart	= mvebu_restart,
+	.dt_compat	= armada_38x_dt_compat,
+MACHINE_END
-- 
1.8.3.2
