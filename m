From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Feb 2014 12:04:31 +0100
Subject: [PATCH v3 09/13] ARM: mvebu: add initial support for the Armada
 380/385 SOCs
In-Reply-To: <1392289475-8902-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392289475-8902-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392289475-8902-10-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the basic support for the Armada 380 and Armada 385
SOCs. These SoCs share most of their IP with the Armada 370/XP
SoCs. The main difference is the use of a Cortex A9 CPU instead of the
PJ4B CPU. The Armada 380 is a single core Cortex-A9, while the Armada
385 is a dual-core Cortex-A9.

The support is introduced in armada-mvebu.c, together with Armada
370/XP, but a separate DT structure is added, because Armada 38x will
need a different set of SMP operations when the SMP support is
introduced.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/armada-38x.txt | 10 ++++++++++
 arch/arm/mach-mvebu/Kconfig                          | 14 ++++++++++++++
 arch/arm/mach-mvebu/armada-mvebu.c                   | 12 ++++++++++++
 3 files changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-38x.txt

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
index 3e228af..57f4bde 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -51,6 +51,20 @@ config MACH_ARMADA_375
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Armada 375 SoC with device tree.
 
+config MACH_ARMADA_38X
+	bool "Marvell Armada 380/385 boards"
+	select ARM_ERRATA_720789
+	select ARM_ERRATA_753970
+	select ARM_GIC
+	select ARMADA_38X_CLK
+	select CPU_V7
+	select MACH_ARMADA_MVEBU
+	select NEON
+	select PINCTRL_ARMADA_38X
+	help
+	  Say 'Y' here if you want your kernel to support boards based
+	  on the Marvell Armada 380/385 SoC with device tree.
+
 config MACH_ARMADA_XP
 	bool "Marvell Armada XP boards"
 	select ARMADA_XP_CLK
diff --git a/arch/arm/mach-mvebu/armada-mvebu.c b/arch/arm/mach-mvebu/armada-mvebu.c
index 7e50464..fcf4091 100644
--- a/arch/arm/mach-mvebu/armada-mvebu.c
+++ b/arch/arm/mach-mvebu/armada-mvebu.c
@@ -131,3 +131,15 @@ DT_MACHINE_START(ARMADA_375_DT, "Marvell Armada 375 (Device Tree)")
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
+	.init_time	= armada_mvebu_timer_and_clk_init,
+	.restart	= mvebu_restart,
+	.dt_compat	= armada_38x_dt_compat,
+MACHINE_END
-- 
1.8.3.2
