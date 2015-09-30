From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 30 Sep 2015 21:17:48 +0200
Subject: [PATCH 3/5] ARM: dts: rockchip: add rk3288-popmetal iodomains
In-Reply-To: <1443640670-21104-1-git-send-email-heiko@sntech.de>
References: <1443640670-21104-1-git-send-email-heiko@sntech.de>
Message-ID: <1443640670-21104-4-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the iodomains node and reference the correct regulator for each
domain. This also includes adding the currently unused dvp regulators
and fixing up two regulators to follow the naming in the schematics.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-popmetal.dts | 55 ++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
index b677611..65c4756 100644
--- a/arch/arm/boot/dts/rk3288-popmetal.dts
+++ b/arch/arm/boot/dts/rk3288-popmetal.dts
@@ -79,6 +79,22 @@
 		};
 	};
 
+	io_domains: io-domains {
+		compatible = "rockchip,rk3288-io-voltage-domain";
+		rockchip,grf = <&grf>;
+
+		audio-supply = <&vcca_33>;
+		bb-supply = <&vcc_io>;
+		dvp-supply = <&vcc18_dvp>;
+		flash0-supply = <&vcc_flash>;
+		flash1-supply = <&vcc_lan>;
+		gpio30-supply = <&vcc_io>;
+		gpio1830-supply = <&vcc_io>;
+		lcdc-supply = <&vcc_io>;
+		sdcard-supply = <&vccio_sd>;
+		wifi-supply = <&vccio_wl>;
+	};
+
 	ir: ir-receiver {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
@@ -114,6 +130,31 @@
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	/*
+	 * A PT5128 creates both dovdd_1v8 and vcc28_dvp, controlled
+	 * by the dvp_pwr pin.
+	 */
+	vcc18_dvp: vcc18-dvp-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc18-dvp";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc28_dvp>;
+	};
+
+	vcc28_dvp: vcc28-dvp-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 17 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&dvp_pwr>;
+		regulator-name = "vcc28_dvp";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		regulator-always-on;
+		vin-supply = <&vcc_io>;
+	};
 };
 
 &cpu0 {
@@ -321,22 +362,22 @@
 				};
 			};
 
-			vcca_codec: LDO_REG8 {
+			vcca_33: LDO_REG8 {
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcca_codec";
+				regulator-name = "vcca_33";
 				regulator-state-mem {
 					regulator-on-in-suspend;
 					regulator-suspend-microvolt = <3300000>;
 				};
 			};
 
-			vcc_wl: SWITCH_REG1 {
+			vccio_wl: SWITCH_REG1 {
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-name = "vcc_wl";
+				regulator-name = "vccio_wl";
 				regulator-state-mem {
 					regulator-on-in-suspend;
 				};
@@ -412,6 +453,12 @@
 		};
 	};
 
+	dvp {
+		dvp_pwr: dvp-pwr {
+			rockchip,pins = <0 17 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	ir {
 		ir_int: ir-int {
 			rockchip,pins = <0 6 RK_FUNC_GPIO &pcfg_pull_up>;
-- 
2.5.3
