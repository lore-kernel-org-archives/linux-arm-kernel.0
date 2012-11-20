From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 15:31:16 +0100
Subject: [PATCH 8/8] ARM: Kirkwood: switch to DT clock providers
In-Reply-To: <1353421876-13759-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353421876-13759-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353421876-13759-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

With true DT clock providers available switch Kirkwood clock setup in
DT- enabled boards. While AUXDATA can be removed completely from bus
probing, some devices still don't know about DT. Therefore, some clkdev
aliases are created until these devices also move to DT.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood.dtsi           |   22 +++++++++
 arch/arm/mach-kirkwood/Kconfig            |    2 +
 arch/arm/mach-kirkwood/board-dt.c         |   71 +++++++++++++++++++++++------
 arch/arm/plat-orion/include/plat/common.h |    1 +
 4 files changed, 83 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 4e5b815..7a9fac0 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -19,6 +19,12 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
+		core_clk: core-clocks at 10030 {
+			compatible = "marvell,kirkwood-core-clock";
+			reg = <0x10030 0x4>;
+	        	#clock-cells = <1>;
+		};
+
 		gpio0: gpio at 10100 {
 			compatible = "marvell,orion-gpio";
 			#gpio-cells = <2>;
@@ -42,6 +48,7 @@
 			reg = <0x12000 0x100>;
 			reg-shift = <2>;
 			interrupts = <33>;
+			clocks = <&gate_clk 7>;
 			/* set clock-frequency in board dts */
 			status = "disabled";
 		};
@@ -51,6 +58,7 @@
 			reg = <0x12100 0x100>;
 			reg-shift = <2>;
 			interrupts = <34>;
+			clocks = <&gate_clk 7>;
 			/* set clock-frequency in board dts */
 			status = "disabled";
 		};
@@ -68,12 +76,21 @@
 			cell-index = <0>;
 			interrupts = <23>;
 			reg = <0x10600 0x28>;
+			clocks = <&gate_clk 7>;
 			status = "disabled";
 		};
 
+		gate_clk: clock-gating-control at 2011c {
+			compatible = "marvell,kirkwood-gating-clock";
+			reg = <0x2011c 0x4>;
+			clocks = <&core_clk 0>;
+			#clock-cells = <1>;
+		};
+
 		wdt at 20300 {
 			compatible = "marvell,orion-wdt";
 			reg = <0x20300 0x28>;
+			clocks = <&gate_clk 7>;
 			status = "okay";
 		};
 
@@ -81,6 +98,8 @@
 			compatible = "marvell,orion-sata";
 			reg = <0x80000 0x5000>;
 			interrupts = <21>;
+			clocks = <&gate_clk 14>, <&gate_clk 15>;
+			clock-names = "0", "1";
 			status = "disabled";
 		};
 
@@ -94,6 +113,7 @@
 			reg = <0x3000000 0x400>;
 			chip-delay = <25>;
 			/* set partition map and/or chip-delay in board dts */
+			clocks = <&gate_clk 7>;
 			status = "disabled";
 		};
 
@@ -104,6 +124,7 @@
 			#size-cells = <0>;
 			interrupts = <29>;
 			clock-frequency = <100000>;
+			clocks = <&gate_clk 7>;
 			status = "disabled";
 		};
 
@@ -113,6 +134,7 @@
 			      <0xf5000000 0x800>;
 			reg-names = "regs", "sram";
 			interrupts = <22>;
+			clocks = <&gate_clk 17>;
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 50bca50..2833492 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -46,6 +46,8 @@ config MACH_GURUPLUG
 
 config ARCH_KIRKWOOD_DT
 	bool "Marvell Kirkwood Flattened Device Tree"
+	select MVEBU_CLK_CORE
+	select MVEBU_CLK_GATING
 	select USE_OF
 	help
 	  Say 'Y' here if you want your kernel to support the
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index d94872f..8bdfaa4 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -14,11 +14,15 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/clk-provider.h>
+#include <linux/clk/mvebu.h>
 #include <linux/kexec.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/bridge-regs.h>
+#include <linux/platform_data/usb-ehci-orion.h>
 #include <plat/irq.h>
+#include <plat/common.h>
 #include "common.h"
 
 static struct of_device_id kirkwood_dt_match_table[] __initdata = {
@@ -26,16 +30,58 @@ static struct of_device_id kirkwood_dt_match_table[] __initdata = {
 	{ }
 };
 
-struct of_dev_auxdata kirkwood_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("marvell,orion-spi", 0xf1010600, "orion_spi.0", NULL),
-	OF_DEV_AUXDATA("marvell,mv64xxx-i2c", 0xf1011000, "mv64xxx_i2c.0",
-		       NULL),
-	OF_DEV_AUXDATA("marvell,orion-wdt", 0xf1020300, "orion_wdt", NULL),
-	OF_DEV_AUXDATA("marvell,orion-sata", 0xf1080000, "sata_mv.0", NULL),
-	OF_DEV_AUXDATA("marvell,orion-nand", 0xf4000000, "orion_nand", NULL),
-	OF_DEV_AUXDATA("marvell,orion-crypto", 0xf1030000, "mv_crypto", NULL),
-	{},
-};
+/*
+ * There are still devices that doesn't know about DT yet.  Get clock
+ * gates here and add a clock lookup alias, so that old platform
+ * devices still work.
+*/
+
+static void __init kirkwood_legacy_clk_init(void)
+{
+
+	struct device_node *np = of_find_compatible_node(
+		NULL, NULL, "marvell,kirkwood-gating-clock");
+
+	struct of_phandle_args clkspec;
+
+	clkspec.np = np;
+	clkspec.args_count = 1;
+
+	clkspec.args[0] = CGC_BIT_GE0;
+	orion_clkdev_add(NULL, "mv643xx_eth_port.0",
+			 of_clk_get_from_provider(&clkspec));
+
+	clkspec.args[0] = CGC_BIT_PEX0;
+	orion_clkdev_add("0", "pcie",
+			 of_clk_get_from_provider(&clkspec));
+
+	clkspec.args[0] = CGC_BIT_USB0;
+	orion_clkdev_add(NULL, "orion-ehci.0",
+			 of_clk_get_from_provider(&clkspec));
+
+	clkspec.args[0] = CGC_BIT_XOR0;
+	orion_clkdev_add(NULL, "mv_xor_shared.0",
+			 of_clk_get_from_provider(&clkspec));
+
+	clkspec.args[0] = CGC_BIT_XOR1;
+	orion_clkdev_add(NULL, "mv_xor_shared.1",
+			 of_clk_get_from_provider(&clkspec));
+
+	clkspec.args[0] = CGC_BIT_PEX1;
+	orion_clkdev_add("1", "pcie",
+			 of_clk_get_from_provider(&clkspec));
+
+	clkspec.args[0] = CGC_BIT_GE1;
+	orion_clkdev_add(NULL, "mv643xx_eth_port.1",
+			 of_clk_get_from_provider(&clkspec));
+
+}
+
+static void __init kirkwood_of_clk_init(void)
+{
+	mvebu_clocks_init();
+	kirkwood_legacy_clk_init();
+}
 
 static void __init kirkwood_dt_init(void)
 {
@@ -54,7 +100,7 @@ static void __init kirkwood_dt_init(void)
 	kirkwood_l2_init();
 
 	/* Setup root of clk tree */
-	kirkwood_clk_init();
+	kirkwood_of_clk_init();
 
 	/* internal devices that every board has */
 	kirkwood_xor0_init();
@@ -94,8 +140,7 @@ static void __init kirkwood_dt_init(void)
 	if (of_machine_is_compatible("keymile,km_kirkwood"))
 		km_kirkwood_init();
 
-	of_platform_populate(NULL, kirkwood_dt_match_table,
-			     kirkwood_auxdata_lookup, NULL);
+	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
 }
 
 static const char *kirkwood_dt_board_compat[] = {
diff --git a/arch/arm/plat-orion/include/plat/common.h b/arch/arm/plat-orion/include/plat/common.h
index 6bbc3fe..e06fc5f 100644
--- a/arch/arm/plat-orion/include/plat/common.h
+++ b/arch/arm/plat-orion/include/plat/common.h
@@ -12,6 +12,7 @@
 #include <linux/mv643xx_eth.h>
 
 struct dsa_platform_data;
+struct mv_sata_platform_data;
 
 void __init orion_uart0_init(void __iomem *membase,
 			     resource_size_t mapbase,
-- 
1.7.9.5
