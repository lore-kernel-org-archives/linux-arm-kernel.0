From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 14 Nov 2018 15:59:34 +0100
Subject: [PATCH v2 4/4] [DO NOT MERGE] ARM: dts: sun8i: Add CAM500B camera
 module to the Nano Pi M1+
In-Reply-To: <20181114145934.26855-1-maxime.ripard@bootlin.com>
References: <20181114145934.26855-1-maxime.ripard@bootlin.com>
Message-ID: <20181114145934.26855-5-maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Myl?ne Josserand <mylene.josserand@bootlin.com>

The Nano Pi M1+ comes with an optional sensor based on the ov5640 from
Omnivision. Enable the support for it in the DT.

Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
index 06010a9afba0..2ac62d109285 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
@@ -52,6 +52,37 @@
 		ethernet1 = &sdio_wifi;
 	};
 
+	cam_xclk: cam-xclk {
+                #clock-cells = <0>;
+                compatible = "fixed-clock";
+                clock-frequency = <24000000>;
+                clock-output-names = "cam-xclk";
+        };
+
+        reg_cam_avdd: cam-avdd {
+                compatible = "regulator-fixed";
+                regulator-name = "cam500b-avdd";
+                regulator-min-microvolt = <2800000>;
+                regulator-max-microvolt = <2800000>;
+                vin-supply = <&reg_vcc3v3>;
+        };
+
+        reg_cam_dovdd: cam-dovdd {
+                compatible = "regulator-fixed";
+                regulator-name = "cam500b-dovdd";
+                regulator-min-microvolt = <1800000>;
+                regulator-max-microvolt = <1800000>;
+                vin-supply = <&reg_vcc3v3>;
+        };
+
+        reg_cam_dvdd: cam-dvdd {
+                compatible = "regulator-fixed";
+                regulator-name = "cam500b-dvdd";
+                regulator-min-microvolt = <1500000>;
+                regulator-max-microvolt = <1500000>;
+                vin-supply = <&reg_vcc3v3>;
+        };
+
 	reg_gmac_3v3: gmac-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "gmac-3v3";
@@ -69,6 +100,26 @@
 	};
 };
 
+&csi {
+        status = "okay";
+
+        port {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                /* Parallel bus endpoint */
+                csi_from_ov5640: endpoint {
+                        remote-endpoint = <&ov5640_to_csi>;
+                        bus-width = <8>;
+                        data-shift = <2>;
+                        hsync-active = <1>; /* Active high */
+                        vsync-active = <0>; /* Active low */
+                        data-active = <1>;  /* Active high */
+                        pclk-sample = <1>;  /* Rising */
+                };
+        };
+};
+
 &ehci1 {
 	status = "okay";
 };
@@ -94,6 +145,40 @@
 	};
 };
 
+&i2c2 {
+	status = "okay";
+
+	ov5640: camera at 3c {
+                compatible = "ovti,ov5640";
+                reg = <0x3c>;
+                clocks = <&cam_xclk>;
+                clock-names = "xclk";
+
+                reset-gpios = <&pio 4 14 GPIO_ACTIVE_LOW>;
+                powerdown-gpios = <&pio 4 15 GPIO_ACTIVE_HIGH>;
+                AVDD-supply = <&reg_cam_avdd>;
+                DOVDD-supply = <&reg_cam_dovdd>;
+                DVDD-supply = <&reg_cam_dvdd>;
+
+                port {
+                        ov5640_to_csi: endpoint {
+                                remote-endpoint = <&csi_from_ov5640>;
+                                bus-width = <8>;
+                                data-shift = <2>;
+                                hsync-active = <1>; /* Active high */
+                                vsync-active = <0>; /* Active low */
+                                data-active = <1>;  /* Active high */
+                                pclk-sample = <1>;  /* Rising */
+                        };
+                };
+        };
+
+};
+
+&i2c2_pins {
+	bias-pull-up;
+};
+
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ir_pins_a>;
-- 
2.19.1
