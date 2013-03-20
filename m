From: richard.genoud@gmail.com (Richard Genoud)
Date: Wed, 20 Mar 2013 12:23:40 +0100
Subject: [PATCH] DTS at91sam9x5cm: add 1-wire chip on CM board
Message-ID: <1363778620-5213-1-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This add the 1-wire chip present on the CM board to the DTS.
As the pin is also used by leds, tt's disabled by default.
If the board really wants it, it can be enabled in the board DTS.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 arch/arm/boot/dts/at91sam9x5cm.dtsi |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5cm.dtsi b/arch/arm/boot/dts/at91sam9x5cm.dtsi
index 4027ac7..347a74a 100644
--- a/arch/arm/boot/dts/at91sam9x5cm.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5cm.dtsi
@@ -24,6 +24,16 @@
 	};
 
 	ahb {
+		apb {
+			pinctrl at fffff400 {
+				1wire_cm {
+					pinctrl_1wire_cm: 1wire_cm-0 {
+						atmel,pins = <1 18 0x0 0x2>; /* PB18 multidrive, conflicts with led */
+					};
+				};
+			};
+		};
+
 		nand0: nand at 40000000 {
 			nand-bus-width = <8>;
 			nand-ecc-mode = "hw";
@@ -74,4 +84,14 @@
 			gpios = <&pioD 21 0>;
 		};
 	};
+
+	1wire_cm {
+		compatible = "w1-gpio";
+		gpios = <&pioB 18 0>;
+		linux,open-drain;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_1wire_cm>;
+		status = "okay";
+	};
+
 };
-- 
1.7.2.5
