From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 15:22:27 +0100
Subject: [PATCH v2 6/9] ARM: dove: switch to DT clock providers
In-Reply-To: <1353162150-522-1-git-send-email-andrew@lunn.ch>
References: <1353162150-522-1-git-send-email-andrew@lunn.ch>
Message-ID: <1353162150-522-7-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

With true DT clock providers available switch Dove clock setup in DT-
enabled boards. While AUXDATA can be removed completely from bus probing,
some devices still don't know about DT at all. Therefore, some clock
aliases are created until the devices also move to DT.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/Kconfig            |    1 +
 arch/arm/boot/dts/dove.dtsi |   20 ++++++++++++++
 arch/arm/mach-dove/Kconfig  |    2 ++
 arch/arm/mach-dove/common.c |   64 +++++++++++++++++++++++++++++++++----------
 4 files changed, 72 insertions(+), 15 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ade7e92..0590099 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -533,6 +533,7 @@ config ARCH_IXP4XX
 config ARCH_DOVE
 	bool "Marvell Dove"
 	select ARCH_REQUIRE_GPIOLIB
+	select COMMON_CLK_DOVE
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
 	select MIGHT_HAVE_PCI
diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 5a00022..8c8ab62 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -31,6 +31,19 @@
 			reg = <0x20204 0x04>, <0x20214 0x04>;
 		};
 
+		core_clk: core-clocks at d0214 {
+			compatible = "marvell,dove-core-clocks";
+			reg = <0xd0214 0x4>;
+			#clock-cells = <1>;
+		};
+
+		gate_clk: clock-gating-control at d0038 {
+			compatible = "marvell,dove-gating-clock";
+			reg = <0xd0038 0x4>;
+			clocks = <&core_clk 0>;
+			#clock-cells = <1>;
+		};
+
 		uart0: serial at 12000 {
 			compatible = "ns16550a";
 			reg = <0x12000 0x100>;
@@ -100,6 +113,7 @@
 			cell-index = <0>;
 			interrupts = <6>;
 			reg = <0x10600 0x28>;
+			clocks = <&core_clk 0>;
 			status = "disabled";
 		};
 
@@ -110,6 +124,7 @@
 			cell-index = <1>;
 			interrupts = <5>;
 			reg = <0x14600 0x28>;
+			clocks = <&core_clk 0>;
 			status = "disabled";
 		};
 
@@ -121,6 +136,7 @@
 			interrupts = <11>;
 			clock-frequency = <400000>;
 			timeout-ms = <1000>;
+			clocks = <&core_clk 0>;
 			status = "disabled";
 		};
 
@@ -128,6 +144,7 @@
 			compatible = "marvell,dove-sdhci";
 			reg = <0x92000 0x100>;
 			interrupts = <35>, <37>;
+			clocks = <&gate_clk 8>;
 			status = "disabled";
 		};
 
@@ -135,6 +152,7 @@
 			compatible = "marvell,dove-sdhci";
 			reg = <0x90000 0x100>;
 			interrupts = <36>, <38>;
+			clocks = <&gate_clk 9>;
 			status = "disabled";
 		};
 
@@ -142,6 +160,7 @@
 			compatible = "marvell,orion-sata";
 			reg = <0xa0000 0x2400>;
 			interrupts = <62>;
+			clocks = <&gate_clk 3>;
 			nr-ports = <1>;
 			status = "disabled";
 		};
@@ -152,6 +171,7 @@
 			      <0xc8000000 0x800>;
 			reg-names = "regs", "sram";
 			interrupts = <31>;
+			clocks = <&gate_clk 15>;
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/mach-dove/Kconfig b/arch/arm/mach-dove/Kconfig
index 00154e7..603c5fd 100644
--- a/arch/arm/mach-dove/Kconfig
+++ b/arch/arm/mach-dove/Kconfig
@@ -17,6 +17,8 @@ config MACH_CM_A510
 
 config MACH_DOVE_DT
 	bool "Marvell Dove Flattened Device Tree"
+	select MVEBU_CLK_CORE
+	select MVEBU_CLK_GATING
 	select USE_OF
 	help
 	  Say 'Y' here if you want your kernel to support the
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index f723fe1..4b09d12 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/pci.h>
 #include <linux/clk-provider.h>
+#include <linux/clk/mvebu.h>
 #include <linux/ata_platform.h>
 #include <linux/gpio.h>
 #include <linux/of.h>
@@ -376,19 +377,53 @@ void dove_restart(char mode, const char *cmd)
 
 #if defined(CONFIG_MACH_DOVE_DT)
 /*
- * Auxdata required until real OF clock provider
+ * There are still devices that doesn't even know about DT,
+ * get clock gates here and add a clock lookup.
  */
-struct of_dev_auxdata dove_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("marvell,orion-spi", 0xf1010600, "orion_spi.0", NULL),
-	OF_DEV_AUXDATA("marvell,orion-spi", 0xf1014600, "orion_spi.1", NULL),
-	OF_DEV_AUXDATA("marvell,orion-wdt", 0xf1020300, "orion_wdt", NULL),
-	OF_DEV_AUXDATA("marvell,mv64xxx-i2c", 0xf1011000, "mv64xxx_i2c.0",
-		       NULL),
-	OF_DEV_AUXDATA("marvell,orion-sata", 0xf10a0000, "sata_mv.0", NULL),
-	OF_DEV_AUXDATA("marvell,dove-sdhci", 0xf1092000, "sdhci-dove.0", NULL),
-	OF_DEV_AUXDATA("marvell,dove-sdhci", 0xf1090000, "sdhci-dove.1", NULL),
-	{},
-};
+static void __init dove_legacy_clk_init(void)
+{
+	struct device_node *np = of_find_compatible_node(NULL, NULL,
+					 "marvell,dove-gating-clock");
+	struct of_phandle_args clkspec;
+
+	clkspec.np = np;
+	clkspec.args_count = 1;
+
+	clkspec.args[0] = CLOCK_GATING_BIT_USB0;
+	orion_clkdev_add(NULL, "orion-ehci.0",
+			 of_clk_get_from_provider(&clkspec));
+
+	clkspec.args[0] = CLOCK_GATING_BIT_USB1;
+	orion_clkdev_add(NULL, "orion-ehci.1",
+			 of_clk_get_from_provider(&clkspec));
+
+	clkspec.args[0] = CLOCK_GATING_BIT_GBE;
+	orion_clkdev_add(NULL, "mv643xx_eth_port.0",
+			 of_clk_get_from_provider(&clkspec));
+
+	clkspec.args[0] = CLOCK_GATING_BIT_PCIE0;
+	orion_clkdev_add("0", "pcie",
+			 of_clk_get_from_provider(&clkspec));
+
+	clkspec.args[0] = CLOCK_GATING_BIT_PCIE1;
+	orion_clkdev_add("1", "pcie",
+			 of_clk_get_from_provider(&clkspec));
+
+	clkspec.args[0] = CLOCK_GATING_BIT_XOR0;
+	orion_clkdev_add(NULL, "mv_xor_shared.0",
+			 of_clk_get_from_provider(&clkspec));
+
+	clkspec.args[0] = CLOCK_GATING_BIT_XOR1;
+	orion_clkdev_add(NULL, "mv_xor_shared.1",
+			 of_clk_get_from_provider(&clkspec));
+}
+
+static void __init dove_of_clk_init(void)
+{
+	mvebu_clocks_init();
+	mvebu_clk_gating_init();
+	dove_legacy_clk_init();
+}
 
 static struct mv643xx_eth_platform_data dove_dt_ge00_data = {
 	.phy_addr = MV643XX_ETH_PHY_ADDR_DEFAULT,
@@ -405,7 +440,7 @@ static void __init dove_dt_init(void)
 	dove_setup_cpu_mbus();
 
 	/* Setup root of clk tree */
-	dove_clk_init();
+	dove_of_clk_init();
 
 	/* Internal devices not ported to DT yet */
 	dove_rtc_init();
@@ -417,8 +452,7 @@ static void __init dove_dt_init(void)
 	dove_ehci1_init();
 	dove_pcie_init(1, 1);
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     dove_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static const char * const dove_dt_board_compat[] = {
-- 
1.7.10.4
