From: linux@prisktech.co.nz (Tony Prisk)
Date: Fri, 12 Apr 2013 07:00:29 +1200
Subject: [PATCH] arm: vt8500: Add SDHC support to WM8505 DT
Message-ID: <1365706829-9626-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the required node for the SDHC controller on WM8505 SoCs.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
Arnd,

Any chance you can apply this for 3.10

Regards
Ton yP
 arch/arm/boot/dts/wm8505.dtsi |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/wm8505.dtsi b/arch/arm/boot/dts/wm8505.dtsi
index e74a1c0..388f26d 100644
--- a/arch/arm/boot/dts/wm8505.dtsi
+++ b/arch/arm/boot/dts/wm8505.dtsi
@@ -60,6 +60,19 @@
 					clock-frequency = <24000000>;
 				};
 
+				ref25: ref25M {
+					#clock-cells = <0>;
+					compatible = "fixed-clock";
+					clock-frequency = <25000000>;
+				};
+
+				pllb: pllb {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-pll-clock";
+					clocks = <&ref25>;
+					reg = <0x204>;
+				};
+
 				clkuart0: uart0 {
 					#clock-cells = <0>;
 					compatible = "via,vt8500-device-clock";
@@ -107,6 +120,16 @@
 					enable-reg = <0x250>;
 					enable-bit = <23>;
 				};
+
+				clksdhc: sdhc {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&pllb>;
+					divisor-reg = <0x328>;
+					divisor-mask = <0x3f>;
+					enable-reg = <0x254>;
+					enable-bit = <18>;
+				};
 			};
 		};
 
@@ -187,5 +210,13 @@
 			reg = <0xd8100000 0x10000>;
 			interrupts = <48>;
 		};
+
+		sdhc at d800a000 {
+			compatible = "wm,wm8505-sdhc";
+			reg = <0xd800a000 0x1000>;
+			interrupts = <20 21>;
+			clocks = <&clksdhc>;
+			bus-width = <4>;
+		};
 	};
 };
-- 
1.7.9.5
