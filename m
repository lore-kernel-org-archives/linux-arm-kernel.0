From: leonid.s@variscite.com (Leonid Segal)
Date: Sun, 13 Aug 2017 12:42:59 +0300
Subject: [RESEND PATCH 1/1] arm64: dts: Add Variscite DART-SD410 Evaluation
 board dts
Message-ID: <014701d31418$8e419670$aac4c350$@variscite.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial device tree support for Variscite DART-SD410 Evalueation board.
This board is also known as VAR-SD410CustomBoard.

Signed-off-by: Leonid Segal <leonid.s@variscite.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../boot/dts/qcom/apq8016-var-dart-pmic-pins.dtsi  |  53 +++
 .../boot/dts/qcom/apq8016-var-dart-soc-pins.dtsi   |  88 ++++
 arch/arm64/boot/dts/qcom/apq8016-var-dart.dts      |  21 +
 arch/arm64/boot/dts/qcom/apq8016-var-dart.dtsi     | 525
+++++++++++++++++++++
 5 files changed, 688 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-var-dart-pmic-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-var-dart-soc-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-var-dart.dts
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-var-dart.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile
b/arch/arm64/boot/dts/qcom/Makefile
index cc0f02d9dd02..0cf2fa44d96a 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8992-bullhead-rev-101.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-angler-rev-101.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb
+dtb-$(CONFIG_ARCH_QCOM) += apq8016-var-dart.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/qcom/apq8016-var-dart-pmic-pins.dtsi
b/arch/arm64/boot/dts/qcom/apq8016-var-dart-pmic-pins.dtsi
new file mode 100644
index 000000000000..d94640812194
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/apq8016-var-dart-pmic-pins.dtsi
@@ -0,0 +1,53 @@
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
+
+&pm8916_gpios {
+
+	usb_hub_reset_pm: usb_hub_reset_pm {
+		pinconf {
+			pins = "gpio3";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			output-low;
+		};
+	};
+
+	usb_sw_sel_pm: usb_sw_sel_pm {
+		pinconf {
+			pins = "gpio4";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			power-source = <PM8916_GPIO_VPH>;
+			input-disable;
+		};
+	};
+
+	pm8916_gpios_leds: pm8916_gpios_leds {
+		pinconf {
+			pins = "gpio1", "gpio2";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			output-low;
+		};
+	};
+};
+
+&pm8916_mpps {
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&ls_exp_gpio_f>;
+
+	ls_exp_gpio_f: pm8916_mpp4 {
+		pinconf {
+			pins = "mpp4";
+			function = "digital";
+			output-low;
+			power-source = <PM8916_MPP_L5>;	// 1.8V
+		};
+	};
+
+	pm8916_mpps_leds: pm8916_mpps_leds {
+		pinconf {
+			pins = "mpp2", "mpp3";
+			function = "digital";
+			output-low;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/apq8016-var-dart-soc-pins.dtsi
b/arch/arm64/boot/dts/qcom/apq8016-var-dart-soc-pins.dtsi
new file mode 100644
index 000000000000..185388de914c
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/apq8016-var-dart-soc-pins.dtsi
@@ -0,0 +1,88 @@
+
+#include <dt-bindings/gpio/gpio.h>
+
+&msmgpio {
+
+	msmgpio_leds: msmgpio_leds {
+		pinconf {
+			pins = "gpio21", "gpio120";
+			function = "gpio";
+			output-low;
+		};
+	};
+
+	usb_id_default: usb-id-default {
+		pinmux {
+			function = "gpio";
+			pins = "gpio121";
+		};
+
+		pinconf {
+			pins = "gpio121";
+			drive-strength = <8>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
+
+	adv7533_int_active: adv533_int_active {
+		pinmux {
+			function = "gpio";
+			pins = "gpio31";
+		};
+		pinconf {
+			pins = "gpio31";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	adv7533_int_suspend: adv7533_int_suspend {
+		pinmux {
+			function = "gpio";
+			pins = "gpio31";
+		};
+		pinconf {
+			pins = "gpio31";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	adv7533_switch_active: adv7533_switch_active {
+		pinmux {
+			function = "gpio";
+			pins = "gpio32";
+		};
+		pinconf {
+			pins = "gpio32";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	adv7533_switch_suspend: adv7533_switch_suspend {
+		pinmux {
+			function = "gpio";
+			pins = "gpio32";
+		};
+		pinconf {
+			pins = "gpio32";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	msm_key_volp_n_default: msm_key_volp_n_default {
+		pinmux {
+			function = "gpio";
+			pins = "gpio107";
+		};
+		pinconf {
+			pins = "gpio107";
+			drive-strength = <8>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/apq8016-var-dart.dts
b/arch/arm64/boot/dts/qcom/apq8016-var-dart.dts
new file mode 100644
index 000000000000..7ea8eaa2754a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/apq8016-var-dart.dts
@@ -0,0 +1,21 @@
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/dts-v1/;
+
+#include "apq8016-var-dart.dtsi"
+
+/ {
+	model = "Variscite LTD. VAR-DART410";
+	compatible = "qcom,apq8016-dart", "qcom,apq8016", "qcom,dart";
+};
diff --git a/arch/arm64/boot/dts/qcom/apq8016-var-dart.dtsi
b/arch/arm64/boot/dts/qcom/apq8016-var-dart.dtsi
new file mode 100644
index 000000000000..f214d0b101a4
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/apq8016-var-dart.dtsi
@@ -0,0 +1,525 @@
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "msm8916.dtsi"
+#include "pm8916.dtsi"
+#include "apq8016-var-dart-soc-pins.dtsi"
+#include "apq8016-var-dart-pmic-pins.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/apq8016-lpass.h>
+
+/ {
+	aliases {
+		serial0 = &blsp1_uart2;
+		serial1 = &blsp1_uart1;
+		usid0 = &pm8916_0;
+		i2c0	= &blsp_i2c2;
+		i2c1	= &blsp_i2c6;
+		i2c3	= &blsp_i2c4;
+		spi0	= &blsp_spi5;
+		spi1	= &blsp_spi3;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	soc {
+		dma at 7884000 {
+			status = "okay";
+		};
+
+		serial at 78af000 {
+			label = "LS-UART0";
+			status = "okay";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_uart1_default>;
+			pinctrl-1 = <&blsp1_uart1_sleep>;
+		};
+
+		serial at 78b0000 {
+			label = "LS-UART1";
+			status = "okay";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_uart2_default>;
+			pinctrl-1 = <&blsp1_uart2_sleep>;
+		};
+
+		i2c at 78b6000 {
+		/* On Low speed expansion */
+			label = "LS-I2C0";
+			status = "okay";
+		};
+
+		i2c at 78b8000 {
+		/* On High speed expansion */
+			label = "HS-I2C2";
+			status = "okay";
+
+			adv_bridge: bridge at 39 {
+				status = "okay";
+
+				compatible = "adi,adv7533";
+				reg = <0x39>;
+
+				interrupt-parent = <&msmgpio>;
+				interrupts = <31 2>;
+
+				adi,dsi-lanes = <4>;
+
+				pd-gpios = <&msmgpio 32 0>;
+
+				avdd-supply = <&pm8916_l6>;
+				v1p2-supply = <&pm8916_l6>;
+				v3p3-supply = <&pm8916_l17>;
+
+				pinctrl-names = "default","sleep";
+				pinctrl-0 = <&adv7533_int_active>,
+					    <&adv7533_switch_active>;
+				pinctrl-1 = <&adv7533_int_suspend>,
+					    <&adv7533_switch_suspend>;
+				#sound-dai-cells = <1>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port at 0 {
+						reg = <0>;
+						adv7533_in: endpoint {
+							remote-endpoint =
<&dsi0_out>;
+						};
+					};
+
+					port at 1 {
+						reg = <1>;
+						adv7533_out: endpoint {
+							remote-endpoint =
<&hdmi_con>;
+						};
+					};
+				};
+			};
+		};
+
+		i2c at 78ba000 {
+		/* On Low speed expansion */
+			label = "LS-I2C1";
+			status = "okay";
+		};
+
+		spi at 78b7000 {
+		/* On High speed expansion */
+			label = "HS-SPI1";
+			status = "okay";
+		};
+
+		spi at 78b9000 {
+		/* On Low speed expansion */
+			label = "LS-SPI0";
+			status = "okay";
+		};
+
+		leds {
+			pinctrl-names = "default";
+			pinctrl-0 = <&msmgpio_leds>,
+				    <&pm8916_gpios_leds>,
+				    <&pm8916_mpps_leds>;
+
+			compatible = "gpio-leds";
+
+			led at 1 {
+				label = "apq8016-sbc:green:user1";
+				gpios = <&msmgpio 21 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "heartbeat";
+				default-state = "off";
+			};
+
+			led at 2 {
+				label = "apq8016-sbc:green:user2";
+				gpios = <&msmgpio 120 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "mmc0";
+				default-state = "off";
+			};
+
+			led at 3 {
+				label = "apq8016-sbc:green:user3";
+				gpios = <&pm8916_gpios 1 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "mmc1";
+				default-state = "off";
+			};
+
+			led at 4 {
+				label = "apq8016-sbc:green:user4";
+				gpios = <&pm8916_gpios 2 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "none";
+				default-state = "off";
+			};
+
+			led at 5 {
+				label = "apq8016-sbc:yellow:wlan";
+				gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "phy0rx";
+				default-state = "off";
+			};
+
+			led at 6 {
+				label = "apq8016-sbc:blue:bt";
+				gpios = <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "hci0-power";
+				default-state = "off";
+			};
+		};
+
+		sdhci at 07824000 {
+			vmmc-supply = <&pm8916_l8>;
+			vqmmc-supply = <&pm8916_l5>;
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdc1_clk_on>,
+				    <&sdc1_cmd_on>,
+				    <&sdc1_data_on>;
+			pinctrl-1 = <&sdc1_clk_off>,
+				    <&sdc1_cmd_off>,
+				    <&sdc1_data_off>;
+			status = "okay";
+		};
+
+		sdhci at 07864000 {
+			vmmc-supply = <&pm8916_l11>;
+			vqmmc-supply = <&pm8916_l12>;
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdc2_clk_on>,
+				    <&sdc2_cmd_on>,
+				    <&sdc2_data_on>,
+				    <&sdc2_cd_on>;
+			pinctrl-1 = <&sdc2_clk_off>,
+				    <&sdc2_cmd_off>,
+				    <&sdc2_data_off>,
+				    <&sdc2_cd_off>;
+
+			cd-gpios = <&msmgpio 38 0x1>;
+			status = "okay";
+		};
+
+		usb at 78d9000 {
+			extcon = <&usb_id>, <&usb_id>;
+			status = "okay";
+		};
+
+		ehci at 78d9000 {
+			status = "okay";
+		};
+
+		phy at 78d9000 {
+			v1p8-supply = <&pm8916_l7>;
+			v3p3-supply = <&pm8916_l13>;
+			vddcx-supply = <&pm8916_s1>;
+			extcon = <&usb_id>, <&usb_id>;
+			dr_mode = "otg";
+			status = "okay";
+			switch-gpio = <&pm8916_gpios 4 GPIO_ACTIVE_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&usb_sw_sel_pm>;
+		};
+
+		lpass at 07708000 {
+			status = "okay";
+		};
+
+		mdss at 1a00000 {
+			status = "okay";
+
+			mdp at 1a01000 {
+				status = "okay";
+			};
+
+			dsi at 1a98000 {
+				status = "okay";
+
+				vdda-supply = <&pm8916_l2>;
+				vddio-supply = <&pm8916_l6>;
+
+				ports {
+					port at 1 {
+						endpoint {
+							remote-endpoint =
<&adv7533_in>;
+							data-lanes = <0 1 2
3>;
+						};
+					};
+				};
+			};
+
+			dsi-phy at 1a98300 {
+				status = "okay";
+
+				vddio-supply = <&pm8916_l6>;
+			};
+		};
+
+		lpass_codec: codec{
+			status = "okay";
+		};
+
+		sound: sound {
+			compatible = "qcom,apq8016-sbc-sndcard";
+			reg = <0x07702000 0x4>, <0x07702004 0x4>;
+			reg-names = "mic-iomux", "spkr-iomux";
+
+			status = "okay";
+			pinctrl-0 = <&cdc_pdm_lines_act>,
+				    <&ext_sec_tlmm_lines_act>,
+				    <&ext_mclk_tlmm_lines_act>;
+			pinctrl-1 = <&cdc_pdm_lines_sus>,
+				    <&ext_sec_tlmm_lines_sus>,
+				    <&ext_mclk_tlmm_lines_sus>;
+			pinctrl-names = "default", "sleep";
+			qcom,model = "DB410c";
+			qcom,audio-routing =
+				"AMIC2", "MIC BIAS Internal2",
+				"AMIC3", "MIC BIAS External1";
+			external-dai-link at 0 {
+				link-name = "ADV7533";
+				cpu { /* QUAT */
+					sound-dai = <&lpass
MI2S_QUATERNARY>;
+				};
+				codec {
+					sound-dai = <&adv_bridge 0>;
+				};
+			};
+
+			/* I2S - Internal codec */
+			internal-codec-playback-dai-link at 0 {
+				link-name = "WCD";
+				cpu { /* PRIMARY */
+					sound-dai = <&lpass MI2S_PRIMARY>;
+				};
+				codec {
+					sound-dai = <&lpass_codec 0>,
+						    <&wcd_codec 0>;
+				};
+			};
+
+			/* I2S - Internal codec */
+			internal-codec-capture-dai-link at 0 {
+				link-name = "WCD-Capture";
+				cpu { /* PRIMARY */
+					sound-dai = <&lpass MI2S_TERTIARY>;
+				};
+				codec {
+					sound-dai = <&lpass_codec 1>,
+						    <&wcd_codec 1>;
+				};
+			};
+		};
+
+		wcnss at a21b000 {
+			status = "okay";
+		};
+
+		camera_vdddo_1v8: fixedregulator at 0 {
+			compatible = "regulator-fixed";
+			regulator-name = "camera_vdddo";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		camera_vdda_2v8: fixedregulator at 1 {
+			compatible = "regulator-fixed";
+			regulator-name = "camera_vdda";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-always-on;
+		};
+
+		camera_vddd_1v5: fixedregulator at 2 {
+			compatible = "regulator-fixed";
+			regulator-name = "camera_vddd";
+			regulator-min-microvolt = <1500000>;
+			regulator-max-microvolt = <1500000>;
+			regulator-always-on;
+		};
+	};
+
+	usb2513 {
+		compatible = "smsc,usb3503";
+		reset-gpios = <&pm8916_gpios 3 GPIO_ACTIVE_LOW>;
+		initial-mode = <1>;
+	};
+
+	usb_id: usb-id {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpio = <&msmgpio 121 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_id_default>;
+	};
+
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&adv7533_out>;
+			};
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&msm_key_volp_n_default>;
+
+		button at 0 {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&msmgpio 107 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&blsp_i2c6 {
+	status = "ok";
+};
+
+&wcd_codec {
+	status = "okay";
+	clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
+	clock-names = "mclk";
+};
+
+&smd_rpm_regulators {
+	vdd_l1_l2_l3-supply = <&pm8916_s3>;
+	vdd_l5-supply = <&pm8916_s3>;
+	vdd_l4_l5_l6-supply = <&pm8916_s4>;
+	vdd_l7-supply = <&pm8916_s4>;
+
+	s1 {
+		regulator-min-microvolt = <375000>;
+		regulator-max-microvolt = <1562000>;
+	};
+
+	s3 {
+		regulator-min-microvolt = <375000>;
+		regulator-max-microvolt = <1562000>;
+	};
+
+	s4 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	l1 {
+		regulator-min-microvolt = <375000>;
+		regulator-max-microvolt = <1525000>;
+	};
+
+	l2 {
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+	};
+
+	l3 {
+		regulator-min-microvolt = <375000>;
+		regulator-max-microvolt = <1525000>;
+	};
+
+	l4 {
+		regulator-min-microvolt = <1750000>;
+		regulator-max-microvolt = <3337000>;
+	};
+
+	l5 {
+		regulator-min-microvolt = <1750000>;
+		regulator-max-microvolt = <3337000>;
+	};
+
+	l6 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	l7 {
+		regulator-min-microvolt = <1750000>;
+		regulator-max-microvolt = <3337000>;
+	};
+
+	l8 {
+		regulator-min-microvolt = <1750000>;
+		regulator-max-microvolt = <3337000>;
+	};
+
+	l9 {
+		regulator-min-microvolt = <1750000>;
+		regulator-max-microvolt = <3337000>;
+	};
+
+	l10 {
+		regulator-min-microvolt = <1750000>;
+		regulator-max-microvolt = <3337000>;
+	};
+
+	l11 {
+		regulator-min-microvolt = <1750000>;
+		regulator-max-microvolt = <3337000>;
+	};
+
+	l12 {
+		regulator-min-microvolt = <1750000>;
+		regulator-max-microvolt = <3337000>;
+	};
+
+	l13 {
+		regulator-min-microvolt = <1750000>;
+		regulator-max-microvolt = <3337000>;
+	};
+
+	l14 {
+		regulator-min-microvolt = <1750000>;
+		regulator-max-microvolt = <3337000>;
+	};
+
+	/**
+	 * 1.8v required on LS expansion
+	 * for mezzanine boards
+	 */
+	l15 {
+		regulator-min-microvolt = <1750000>;
+		regulator-max-microvolt = <3337000>;
+		regulator-always-on;
+	};
+
+	l16 {
+		regulator-min-microvolt = <1750000>;
+		regulator-max-microvolt = <3337000>;
+	};
+
+	l17 {
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	l18 {
+		regulator-min-microvolt = <1750000>;
+		regulator-max-microvolt = <3337000>;
+	};
+};
-- 
2.13.0
