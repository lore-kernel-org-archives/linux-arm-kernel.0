From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Feb 2014 12:04:27 +0100
Subject: [PATCH v3 05/13] ARM: mvebu: add initial support for the Armada 375
 SOCs
In-Reply-To: <1392289475-8902-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392289475-8902-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392289475-8902-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

This commit adds the basic support for the Armada 375 SOCs. These SoCs
share most of their IP with the Armada 370/XP SoCs. The main
difference is the use of a Cortex A9 CPU instead of the PJ4B CPU. The
interrupt controller and the L2 cache controller are also different
they are respectively the GIC and the PL310.

The support is introduced in armada-mvebu.c, together with Armada
370/XP, but a separate DT structure is added, because Armada 375 will
need a different set of SMP operations when the SMP support is
introduced.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/armada-375.txt |  9 +++++++++
 arch/arm/mach-mvebu/Kconfig                          | 14 ++++++++++++++
 arch/arm/mach-mvebu/armada-mvebu.c                   | 11 +++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-375.txt

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
index c934f92..3e228af 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -37,6 +37,20 @@ config MACH_ARMADA_370
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Armada 370 SoC with device tree.
 
+config MACH_ARMADA_375
+	bool "Marvell Armada 375 boards"
+	select ARM_ERRATA_720789
+	select ARM_ERRATA_753970
+	select ARM_GIC
+	select ARMADA_375_CLK
+	select CPU_V7
+	select MACH_ARMADA_MVEBU
+	select NEON
+	select PINCTRL_ARMADA_375
+	help
+	  Say 'Y' here if you want your kernel to support boards based
+	  on the Marvell Armada 375 SoC with device tree.
+
 config MACH_ARMADA_XP
 	bool "Marvell Armada XP boards"
 	select ARMADA_XP_CLK
diff --git a/arch/arm/mach-mvebu/armada-mvebu.c b/arch/arm/mach-mvebu/armada-mvebu.c
index 18fbb32..7d1687a 100644
--- a/arch/arm/mach-mvebu/armada-mvebu.c
+++ b/arch/arm/mach-mvebu/armada-mvebu.c
@@ -95,3 +95,14 @@ DT_MACHINE_START(ARMADA_370_XP_DT, "Marvell Armada 370/XP (Device Tree)")
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_370_xp_dt_compat,
 MACHINE_END
+
+static const char * const armada_375_dt_compat[] = {
+	"marvell,armada375",
+	NULL,
+};
+
+DT_MACHINE_START(ARMADA_375_DT, "Marvell Armada 375 (Device Tree)")
+	.init_time	= armada_mvebu_timer_and_clk_init,
+	.restart	= mvebu_restart,
+	.dt_compat	= armada_375_dt_compat,
+MACHINE_END
-- 
1.8.3.2
