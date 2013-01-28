From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 28 Jan 2013 16:54:08 +0100
Subject: [PATCH] ARM: Dove: convert usb host controller to DT
Message-ID: <1359388448-14370-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With DT support for orion-ehci also convert Dove to it and
remove the legacy calls and clock aliases.

This patch is based on "ARM: Dove: split legacy and DT setup"
applied to mvebu/boards recently.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/dove.dtsi   |   16 ++++++++++++++++
 arch/arm/mach-dove/board-dt.c |   10 ----------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 42eac1f..02769a8 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -154,6 +154,22 @@
 			status = "disabled";
 		};
 
+		ehci0: usb-host at 50000 {
+			compatible = "marvell,orion-ehci";
+			reg = <0x50000 0x1000>;
+			interrupts = <24>;
+			clocks = <&gate_clk 0>;
+			status = "okay";
+		};
+
+		ehci1: usb-host at 51000 {
+			compatible = "marvell,orion-ehci";
+			reg = <0x51000 0x1000>;
+			interrupts = <25>;
+			clocks = <&gate_clk 1>;
+			status = "okay";
+		};
+
 		sdio0: sdio at 92000 {
 			compatible = "marvell,dove-sdhci";
 			reg = <0x92000 0x100>;
diff --git a/arch/arm/mach-dove/board-dt.c b/arch/arm/mach-dove/board-dt.c
index 2310f55..ee11b31 100644
--- a/arch/arm/mach-dove/board-dt.c
+++ b/arch/arm/mach-dove/board-dt.c
@@ -34,14 +34,6 @@ static void __init dove_legacy_clk_init(void)
 	clkspec.np = np;
 	clkspec.args_count = 1;
 
-	clkspec.args[0] = CLOCK_GATING_BIT_USB0;
-	orion_clkdev_add(NULL, "orion-ehci.0",
-			 of_clk_get_from_provider(&clkspec));
-
-	clkspec.args[0] = CLOCK_GATING_BIT_USB1;
-	orion_clkdev_add(NULL, "orion-ehci.1",
-			 of_clk_get_from_provider(&clkspec));
-
 	clkspec.args[0] = CLOCK_GATING_BIT_GBE;
 	orion_clkdev_add(NULL, "mv643xx_eth_port.0",
 			 of_clk_get_from_provider(&clkspec));
@@ -79,8 +71,6 @@ static void __init dove_dt_init(void)
 
 	/* Internal devices not ported to DT yet */
 	dove_ge00_init(&dove_dt_ge00_data);
-	dove_ehci0_init();
-	dove_ehci1_init();
 	dove_pcie_init(1, 1);
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-- 
1.7.10.4
