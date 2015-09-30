From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 30 Sep 2015 21:17:50 +0200
Subject: [PATCH 5/5] ARM: dts: rockchip: add rk3288-firefly iodomains
In-Reply-To: <1443640670-21104-1-git-send-email-heiko@sntech.de>
References: <1443640670-21104-1-git-send-email-heiko@sntech.de>
Message-ID: <1443640670-21104-6-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the iodomains node and reference the correct regulator for each
domain. This also includes adding the currently unused dvp regulators.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi | 47 +++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index a7b1972..105b175 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -48,6 +48,14 @@
 		reg = <0 0x80000000>;
 	};
 
+	dovdd_1v8: dovdd-1v8-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "dovdd_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc28_dvp>;
+	};
+
 	ext_gmac: external-gmac-clock {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -55,6 +63,22 @@
 		clock-output-names = "ext_gmac";
 	};
 
+	io_domains: io-domains {
+		compatible = "rockchip,rk3288-io-voltage-domain";
+		rockchip,grf = <&grf>;
+
+		audio-supply = <&vcca_33>;
+		bb-supply = <&vcc_io>;
+		dvp-supply = <&dovdd_1v8>;
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
 		pinctrl-names = "default";
@@ -160,6 +184,23 @@
 		regulator-always-on;
 		vin-supply = <&vcc_5v>;
 	};
+
+	/*
+	 * A TT8142 creates both dovdd_1v8 and vcc28_dvp, controlled
+	 * by the dvp_pwr pin.
+	 */
+	vcc28_dvp: vcc28-dvp-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 11 GPIO_ACTIVE_HIGH>;
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
@@ -377,6 +418,12 @@
 		};
 	};
 
+	dvp {
+		dvp_pwr: dvp-pwr {
+			rockchip,pins = <0 11 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	gmac {
 		phy_int: phy-int {
 			rockchip,pins = <0 9 RK_FUNC_GPIO &pcfg_pull_up>;
-- 
2.5.3
