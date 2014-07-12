From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 12 Jul 2014 21:29:55 +0200
Subject: [PATCH 4/7] ARM: dts: rk3188-radxarock: enable sd-card slot
In-Reply-To: <16344051.ZPa9bzz4Fj@diego>
References: <16344051.ZPa9bzz4Fj@diego>
Message-ID: <1714076.jNfxIcBree@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Radxa Rock contains one sd-card slot. Add the supplying regulator
and enable its dw_mmc node.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3188-radxarock.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index d4d9f94..f277237 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -42,6 +42,16 @@
 			status = "okay";
 		};
 
+		vcc_sd0: sdmmc-regulator {
+			compatible = "regulator-fixed";
+			regulator-name = "sdmmc-supply";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio3 1 GPIO_ACTIVE_LOW>;
+			startup-delay-us = <100000>;
+			vin-supply = <&vcc_io>;
+		};
+
 		gpio-keys {
 			compatible = "gpio-keys";
 			#address-cells = <1>;
@@ -77,6 +87,21 @@
 			};
 		};
 
+		dwmmc at 10214000 {
+			num-slots = <1>;
+			status = "okay";
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4>;
+			vmmc-supply = <&vcc_sd0>;
+
+			slot at 0 {
+				reg = <0>;
+				bus-width = <4>;
+				disable-wp;
+			};
+		};
+
 		pinctrl at 20008000 {
 			pcfg_output_low: pcfg_output_low {
 				output-low;
-- 
1.9.0
