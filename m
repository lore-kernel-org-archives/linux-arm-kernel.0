From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 12 Jul 2014 21:28:55 +0200
Subject: [PATCH 2/7] ARM: dts: rockchip: add tps65910 regulator for bqcurie2
In-Reply-To: <16344051.ZPa9bzz4Fj@diego>
References: <16344051.ZPa9bzz4Fj@diego>
Message-ID: <1964418.AtfHtuR7W0@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Curie2 uses a tps659102 as its main pmic, so add the i2c1 and tps65910
node as well as define the used voltages and regulator-names according to
the schematics.

Also fix the supply of the sd0 regulator, as it is supplied by the vio reg.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a-bqcurie2.dts | 93 ++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
index afb3273..4174ff8 100644
--- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
+++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
@@ -50,6 +50,7 @@
 			regulator-max-microvolt = <3000000>;
 			gpio = <&gpio3 7 GPIO_ACTIVE_LOW>;
 			startup-delay-us = <100000>;
+			vin-supply = <&vio_reg>;
 		};
 
 		dwmmc at 10214000 { /* sdmmc */
@@ -108,3 +109,95 @@
 		};
 	};
 };
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	tps: tps at 2d {
+		reg = <0x2d>;
+
+		interrupt-parent = <&gpio6>;
+		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+#include "tps65910.dtsi"
+
+&tps {
+	vcc5-supply = <&vio_reg>;
+	vcc6-supply = <&vio_reg>;
+
+	regulators {
+		vrtc_reg: regulator at 0 {
+			regulator-name = "vcc_rtc";
+			regulator-always-on;
+		};
+
+		vio_reg: regulator at 1 {
+			regulator-name = "vcc_io";
+			regulator-always-on;
+		};
+
+		vdd1_reg: regulator at 2 {
+			regulator-name = "vdd_arm";
+			regulator-min-microvolt = <600000>;
+			regulator-max-microvolt = <1500000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		vdd2_reg: regulator at 3 {
+			regulator-name = "vcc_ddr";
+			regulator-min-microvolt = <600000>;
+			regulator-max-microvolt = <1500000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		/* vdd3_reg is not connected */
+
+		vdig1_reg: regulator at 5 {
+			regulator-name = "vcc18_cif";
+			regulator-always-on;
+		};
+
+		vdig2_reg: regulator at 6 {
+			regulator-name = "vdd_11";
+			regulator-always-on;
+		};
+
+		vpll_reg: regulator at 7 {
+			regulator-name = "vcc_25";
+			regulator-always-on;
+		};
+
+		vdac_reg: regulator at 8 {
+			regulator-name = "vcc_18";
+			regulator-always-on;
+		};
+
+		vaux1_reg: regulator at 9 {
+			regulator-name = "vcc25_hdmi";
+			regulator-always-on;
+		};
+
+		vaux2_reg: regulator at 10 {
+			regulator-name = "vcca_33";
+			regulator-always-on;
+		};
+
+		vaux33_reg: regulator at 11 {
+			regulator-name = "vcc_tp";
+			regulator-always-on;
+		};
+
+		vmmc_reg: regulator at 12 {
+			regulator-name = "vcc28_cif";
+			regulator-always-on;
+		};
+	};
+};
-- 
1.9.0
