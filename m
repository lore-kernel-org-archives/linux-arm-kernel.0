From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri,  6 Mar 2015 16:05:27 +0100
Subject: [PATCH v2 09/10] ARM: berlin: rework chip and system controller nodes
 for BG2CD
In-Reply-To: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1425654328-26298-10-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The chip and system controller nodes are now handled by the Berlin
controller mfd driver. Its sub-devices are then registered by the mfd
driver and let the drivers be probed properly, using their own
sub-nodes.

Rework the device tree to take this changes into account.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2cd.dtsi | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 81b670ac494a..4bca01ee94d6 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -84,7 +84,7 @@
 			compatible = "marvell,berlin2cd-usb-phy";
 			reg = <0xb74000 0x128>;
 			#phy-cells = <0>;
-			resets = <&chip 0x178 23>;
+			resets = <&chip_rst 0x178 23>;
 			status = "disabled";
 		};
 
@@ -92,7 +92,7 @@
 			compatible = "marvell,berlin2cd-usb-phy";
 			reg = <0xb78000 0x128>;
 			#phy-cells = <0>;
-			resets = <&chip 0x178 24>;
+			resets = <&chip_rst 0x178 24>;
 			status = "disabled";
 		};
 
@@ -294,17 +294,25 @@
 			};
 		};
 
-		chip: chip-control at ea0000 {
-			compatible = "marvell,berlin2cd-chip-ctrl";
-			#clock-cells = <1>;
-			#reset-cells = <2>;
+		chip: chip-controller at ea0000 {
+			compatible = "marvell,berlin2cd-chip-ctrl", "simple-mfd", "syscon";
 			reg = <0xea0000 0x400>;
+			#clock-cells = <1>;
 			clocks = <&refclk>;
 			clock-names = "refclk";
 
-			uart0_pmux: uart0-pmux {
-				groups = "G6";
-				function = "uart0";
+			soc_pinctrl: pin-controller {
+				compatible = "marvell,berlin2cd-soc-pinctrl";
+
+				uart0_pmux: uart0-pmux {
+					groups = "G6";
+					function = "uart0";
+				};
+			};
+
+			chip_rst: reset {
+				compatible = "marvell,berlin2-reset";
+				#reset-cells = <2>;
 			};
 		};
 
@@ -389,8 +397,12 @@
 			};
 
 			sysctrl: system-controller at d000 {
-				compatible = "marvell,berlin2cd-system-ctrl";
+				compatible = "marvell,berlin2cd-system-ctrl", "simple-mfd", "syscon";
 				reg = <0xd000 0x100>;
+
+				sys_pinctrl: pin-controller {
+					compatible = "marvell,berlin2cd-system-pinctrl";
+				};
 			};
 
 			sic: interrupt-controller at e000 {
-- 
2.3.1
