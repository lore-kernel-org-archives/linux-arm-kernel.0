From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 22 Apr 2014 23:26:24 +0200
Subject: [PATCH v2 20/38] ARM: orion5x: switch to use the clock driver for DT
 platforms
In-Reply-To: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1398202002-28530-21-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit moves the Orion5x platforms using the Device Tree to use
the recently introduced clock driver for Orion5x. To achieve that, it:

 * Adds the necessary DT description of the clock.

 * Selects ORION_CLK to enable the compilation of the clock driver.

 * Call of_clk_init() instead of the Orion5x-specific clock
   initialization function.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/boot/dts/orion5x-mv88f5182.dtsi | 6 ++++++
 arch/arm/mach-orion5x/Kconfig            | 1 +
 arch/arm/mach-orion5x/board-dt.c         | 5 ++---
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/orion5x-mv88f5182.dtsi b/arch/arm/boot/dts/orion5x-mv88f5182.dtsi
index ddfb4d1..a56f9c8 100644
--- a/arch/arm/boot/dts/orion5x-mv88f5182.dtsi
+++ b/arch/arm/boot/dts/orion5x-mv88f5182.dtsi
@@ -15,6 +15,12 @@
 		compatible = "marvell,orion5x-88f5182-mbus", "simple-bus";
 
 		internal-regs {
+			core_clk: core-clocks at 10030 {
+				compatible = "marvell,mv88f5182-core-clock";
+				reg = <0x10010 0x4>;
+				#clock-cells = <1>;
+			};
+
 			mbusc: mbus-controller at 20000 {
 				compatible = "marvell,mbus-controller";
 				reg = <0x20000 0x100>, <0x1500 0x20>;
diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
index 14f2cae..4f51132 100644
--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -5,6 +5,7 @@ menu "Orion Implementations"
 config ARCH_ORION5X_DT
 	bool "Marvell Orion5x Flattened Device Tree"
 	select USE_OF
+	select ORION_CLK
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell Orion5x using flattened device tree.
diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
index 7f00897..34286ef 100644
--- a/arch/arm/mach-orion5x/board-dt.c
+++ b/arch/arm/mach-orion5x/board-dt.c
@@ -16,6 +16,7 @@
 #include <linux/of_platform.h>
 #include <linux/cpu.h>
 #include <linux/mbus.h>
+#include <linux/clk-provider.h>
 #include <asm/system_misc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -43,6 +44,7 @@ static void orion5x_dt_init_early(void)
 static void orion5x_dt_init_time(void)
 {
 	orion5x_timer_init();
+	of_clk_init(NULL);
 }
 
 static void __init orion5x_dt_init(void)
@@ -60,9 +62,6 @@ static void __init orion5x_dt_init(void)
 	 */
 	orion5x_setup_wins();
 
-	/* Setup root of clk tree */
-	clk_init();
-
 	/*
 	 * Don't issue "Wait for Interrupt" instruction if we are
 	 * running on D0 5281 silicon.
-- 
1.9.2
