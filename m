From: mail@maciej.szmigiero.name (Maciej S. Szmigiero)
Date: Mon, 27 Nov 2017 23:22:28 +0100
Subject: [PATCH] ARM: dts: imx6qdl-udoo: add support for powering off
Message-ID: <475cb655-a88f-0cc2-2e00-405458f80433@maciej.szmigiero.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UDOO board has a possibility to disable most of imx6 SoC power supplies via
"EN_5V" signal, which is connected to "NANDF_D4" pad.

This reduces current consumption after shutdown from ~350 mA to ~40 mA and
prevents a SoC watchdog from starting it again on its own after the
watchdog timeout expires (previously it was not possible to shut down the
SoC permanently if its watchdog was ever enabled since it was still ticking
after the shutdown).

Unfortunately, this does not extinguish the "Power" LED (as it is powered
from an always-on voltage regulator).

To power the SoC up again press the power button (SW2, the one with a long
shaft).

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/arm/boot/dts/imx6qdl-udoo.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
index dd69e8397116..442a6d69ede8 100644
--- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
@@ -30,6 +30,13 @@
 		status = "disabled";
 	};
 
+	gpio-poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio2 4 0>;
+		pinctrl-0 = <&pinctrl_power_off>;
+		pinctrl-names = "default";
+	};
+
 	memory {
 		reg = <0x10000000 0x40000000>;
 	};
@@ -163,6 +170,12 @@
 			>;
 		};
 
+		pinctrl_power_off: poweroffgrp {
+			fsl,pins = <
+				MX6QDL_PAD_NANDF_D4__GPIO2_IO04		0x30
+			>;
+		};
+
 		pinctrl_touchscreenp7: touchscreenp7grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD2_DAT0__GPIO1_IO15		0x70
