From: ayaka@soulik.info (Randy Li)
Date: Sun, 14 Aug 2016 19:27:24 +0800
Subject: [PATCH 2/2] ARM: dts: rockchip: add missing regulators for firefly
 reload board
In-Reply-To: <1471174044-26003-1-git-send-email-ayaka@soulik.info>
References: <522097f6-8b5c-ee6d-c1b1-a63840228a0e@rock-chips.com>
 <1471174044-26003-1-git-send-email-ayaka@soulik.info>
Message-ID: <1471174044-26003-3-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are many regulators are missed in previous commit, this
commit complete most of them. It also fix some mistakes in the
regulator properties.

It also fix the wrong properties for audio in io-domains,  the supply
connected to APIO4_VDD is different to firefly release version.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi | 29 +---------
 arch/arm/boot/dts/rk3288-firefly-reload.dts       | 64 ++++++++++++++++++++---
 2 files changed, 59 insertions(+), 34 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
index 5e5a348..33999d3 100644
--- a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
@@ -50,14 +50,6 @@
 		reg = <0 0x80000000>;
 	};
 
-	dovdd_1v8: dovdd-1v8-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "dovdd_1v8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&vcc28_dvp>;
-	};
-
 	ext_gmac: external-gmac-clock {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -65,14 +57,6 @@
 		clock-output-names = "ext_gmac";
 	};
 
-	vbat_wl: vcc_sys: vsys-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_sys";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
 
 	vcc_flash: flash-regulator {
 		compatible = "regulator-fixed";
@@ -81,17 +65,6 @@
 		regulator-max-microvolt = <1800000>;
 		vin-supply = <&vcc_io>;
 	};
-
-	vcc_5v: usb-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_5v";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc_sys>;
-	};
-
 };
 
 &cpu0 {
@@ -326,7 +299,7 @@
 &io_domains {
 	status = "okay";
 
-	audio-supply = <&vcca_33>;
+	audio-supply = <&vccio_wl>;
 	bb-supply = <&vcc_io>;
 	dvp-supply = <&dovdd_1v8>;
 	flash0-supply = <&vcc_flash>;
diff --git a/arch/arm/boot/dts/rk3288-firefly-reload.dts b/arch/arm/boot/dts/rk3288-firefly-reload.dts
index a2b1f14..0f5a7c1 100644
--- a/arch/arm/boot/dts/rk3288-firefly-reload.dts
+++ b/arch/arm/boot/dts/rk3288-firefly-reload.dts
@@ -67,7 +67,16 @@
 			pinctrl-0 = <&work_led>;
 		};
 	};
-	
+
+	vcc_5v: vcc_sys: vsys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	vcc_sd: sdmmc-regulator {
 		compatible = "regulator-fixed";
 		gpio = <&gpio7 11 GPIO_ACTIVE_LOW>;
@@ -115,10 +124,18 @@
 		vin-supply = <&vcc_5v>;
 	};
 
-	/*
-	 * A TT8142 creates both dovdd_1v8 and vcc28_dvp, controlled
-	 * by the dvp_pwr pin.
-	 */
+	dovdd_1v8: dovdd-1v8-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 11 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&dvp_pwr>;
+		regulator-name = "dovdd_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_io>;
+	};
+
 	vcc28_dvp: vcc28-dvp-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -128,7 +145,38 @@
 		regulator-name = "vcc28_dvp";
 		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
-		regulator-always-on;
+		vin-supply = <&vcc_io>;
+	};
+
+	af_28: af_28-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 11 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&dvp_pwr>;
+		regulator-name = "af_28";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		vin-supply = <&vcc_io>;
+	};
+
+	dvdd_1v2: af_28-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cif_pwr>;
+		regulator-name = "dvdd_1v2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		vin-supply = <&vcc_io>;
+	};
+
+	vbat_wl: wifi-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vbat_wl";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vcc_io>;
 	};
 
@@ -278,6 +326,10 @@
 		dvp_pwr: dvp-pwr {
 			rockchip,pins = <0 11 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+
+		cif_pwr: cif-pwr {
+			rockchip,pins = <7 12 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 
 	hym8563 {
-- 
2.7.4
