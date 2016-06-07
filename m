From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 7 Jun 2016 17:14:57 +0530
Subject: [PATCH V2 2/2] ARM64: tegra: Add device node for system PMIC MAX77620
In-Reply-To: <1465299897-2491-1-git-send-email-ldewangan@nvidia.com>
References: <1465299897-2491-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1465299897-2491-2-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jetson-TX1 uses the Maxim MAX77620 as system Power management IC.
Add device node for the MAX77620 with following details:
- Add device max77620 with.
	- Add all pins configurations.
	- Configure FPS of the device.
	- Configure SD/DCDC and LDOs regulators.
- populate the bus expander on base board P2597.
- Populate all fixed voltage regulators controlled by GPIOs from Tegra,
  PMIC and bus expanders.

For the different details, jetson-CV device tree files are referred from
downstream.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes from V1:
- Rebase change and populated based on applied patches.

 .../boot/dts/nvidia/tegra210-p2180-spmic.dtsi      | 272 +++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts |   2 +
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     | 150 ++++++++++++
 3 files changed, 424 insertions(+)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-p2180-spmic.dtsi

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2180-spmic.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2180-spmic.dtsi
new file mode 100644
index 0000000..e1f9a17
--- /dev/null
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2180-spmic.dtsi
@@ -0,0 +1,272 @@
+/*
+ * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <dt-bindings/mfd/max77620.h>
+#include <dt-bindings/gpio/tegra-gpio.h>
+
+/ {
+	i2c at 7000d000 {
+		status = "okay";
+		spmic:system-pmic at 3c {
+			compatible = "maxim,max77620";
+			reg = <0x3c>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_NONE>;
+
+			#interrupt-cells = <2>;
+                        interrupt-controller;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&spmic_pin_defaults>;
+
+			spmic_pin_defaults: spmic_pin_defaults {
+				pin_gpio0 {
+					pins = "gpio0";
+					function = "gpio";
+				};
+
+				pin_gpio1 {
+					pins = "gpio1";
+					function = "fps-out";
+					drive-push-pull = <1>;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
+					maxim,active-fps-power-up-slot = <7>;
+					maxim,active-fps-power-down-slot = <0>;
+				};
+
+				pin_gpio2_3 {
+					pins = "gpio2", "gpio3";
+					function = "fps-out";
+					maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
+				};
+
+				pin_gpio4 {
+					pins = "gpio4";
+					function = "32k-out1";
+				};
+
+				pin_gpio5_6_7 {
+					pins = "gpio5", "gpio6", "gpio7";
+					function = "gpio";
+					drive-push-pull = <1>;
+				};
+			};
+
+			fps {
+				fps0 {
+					maxim,shutdown-fps-time-period-us =  <5120>;
+					maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN0>;
+				};
+
+				fps1 {
+					maxim,shutdown-fps-time-period-us = <5120>;
+					maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN1>;
+					maxim,device-state-on-disabled-event = <MAX77620_FPS_INACTIVE_STATE_SLEEP>;
+				};
+
+				fps2 {
+					maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN0>;
+				};
+			};
+
+			regulators {
+				in-ldo0-1-supply = <&spmic_sd2>;
+				in-ldo7-8-supply = <&spmic_sd2>;
+
+				spmic_sd0: sd0 {
+					regulator-name = "vdd_core";
+					regulator-min-microvolt = <600000>;
+					regulator-max-microvolt = <1400000>;
+					regulator-boot-on;
+					regulator-always-on;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
+					regulator-enable-ramp-delay = <146>;
+					regulator-ramp-delay = <9000>;
+					maxim,ramp-rate-setting = <27500>;
+				};
+
+				spmic_sd1: sd1 {
+					regulator-name = "vddio-ddr";
+					regulator-always-on;
+					regulator-boot-on;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
+					regulator-enable-ramp-delay = <130>;
+					regulator-ramp-delay = <9000>;
+					maxim,ramp-rate-setting = <27500>;
+				};
+
+				spmic_sd2: sd2 {
+					regulator-name = "vdd-pre-reg";
+					regulator-min-microvolt = <1350000>;
+					regulator-max-microvolt = <1350000>;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
+					regulator-enable-ramp-delay = <176>;
+					regulator-ramp-delay = <7800>;
+					maxim,ramp-rate-setting = <27500>;
+				};
+
+				spmic_sd3: sd3 {
+					regulator-name = "vdd-1v8";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
+					regulator-enable-ramp-delay = <242>;
+					regulator-ramp-delay = <7800>;
+					maxim,ramp-rate-setting = <27500>;
+				};
+
+				spmic_ldo0: ldo0 {
+					regulator-name = "avdd-sys";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-always-on;
+					regulator-boot-on;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+					regulator-enable-ramp-delay = <26>;
+					regulator-ramp-delay = <50000>;
+					maxim,ramp-rate-setting = <100000>;
+				};
+
+				spmic_ldo1: ldo1 {
+					regulator-name = "vdd-pex";
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1050000>;
+					regulator-always-on;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
+					regulator-enable-ramp-delay = <22>;
+					regulator-ramp-delay = <50000>;
+					maxim,ramp-rate-setting = <100000>;
+				};
+
+				spmic_ldo2: ldo2 {
+					regulator-name = "vddio-sdmmc1";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3300000>;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+					regulator-enable-ramp-delay = <62>;
+					regulator-ramp-delay = <50000>;
+					maxim,ramp-rate-setting = <100000>;
+				};
+
+				spmic_ldo3: ldo3 {
+					regulator-name = "vdd-cam-hv";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+					regulator-enable-ramp-delay = <50>;
+					regulator-ramp-delay = <50000>;
+					maxim,ramp-rate-setting = <100000>;
+				};
+
+				spmic_ldo4: ldo4 {
+					regulator-name = "vdd-rtc";
+					regulator-min-microvolt = <850000>;
+					regulator-max-microvolt = <850000>;
+					regulator-always-on;
+					regulator-boot-on;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
+					regulator-enable-ramp-delay = <22>;
+					regulator-ramp-delay = <100000>;
+					maxim,ramp-rate-setting = <100000>;
+				};
+
+				spmic_ldo5: ldo5 {
+					regulator-name = "avdd-ts-hv";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+					regulator-enable-ramp-delay = <62>;
+					regulator-ramp-delay = <50000>;
+					maxim,ramp-rate-setting = <100000>;
+				};
+
+				spmic_ldo6: ldo6 {
+					regulator-name = "vdd-ts";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+					maxim,active-fps-power-up-slot = <7>;
+					maxim,active-fps-power-down-slot = <0>;
+					regulator-enable-ramp-delay = <36>;
+					regulator-ramp-delay = <50000>;
+					maxim,ramp-rate-setting = <100000>;
+				};
+
+				spmic_ldo7: ldo7 {
+					regulator-name = "vdd-gen-pll-edp";
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1050000>;
+					regulator-always-on;
+					regulator-boot-on;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
+					regulator-enable-ramp-delay = <24>;
+					regulator-ramp-delay = <50000>;
+					maxim,ramp-rate-setting = <100000>;
+				};
+
+				spmic_ldo8: ldo8 {
+					regulator-name = "vdd-hdmi-dp";
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1050000>;
+					regulator-always-on;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
+					regulator-enable-ramp-delay = <22>;
+					regulator-ramp-delay = <50000>;
+					maxim,ramp-rate-setting = <100000>;
+				};
+			};
+		};
+	};
+
+	fixed-regulators {
+		compatible = "simple-bus";
+		device_type = "fixed-regulators";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		battery_reg: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "vdd-ac-bat";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+		};
+
+		vdd_3v3: regulator at 1 { /* SPMIC GPIO3 FPS controlled */
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "vdd-3v3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-enable-ramp-delay = <160>;
+		};
+
+		avdd_io_edp_1v05: regulator at 2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "avdd-io-edp-1v05";
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
+			regulator-boot-on;
+			gpio = <&spmic 7 0>;
+			enable-active-high;
+			regulator-enable-ramp-delay = <240>;
+			vin-supply = <&spmic_ldo7>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
index 683b339..e55c97e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
@@ -1,9 +1,11 @@
 /dts-v1/;
 
 #include "tegra210-p2180.dtsi"
+#include "tegra210-p2180-spmic.dtsi"
 #include "tegra210-p2597.dtsi"
 
 / {
 	model = "NVIDIA Jetson TX1 Developer Kit";
 	compatible = "nvidia,p2371-2180", "nvidia,tegra210";
+
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
index a2480c0..f911cc7 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@ -1261,6 +1261,26 @@
 		};
 	};
 
+	i2c at 7000c400 {
+		status = "okay";
+
+		gpio_tca9539_74: gpio at 74 {
+			compatible = "ti,tca9539";
+			reg = <0x74>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpio_tca9539_77: gpio at 77 {
+			compatible = "ti,tca9539";
+			reg = <0x77>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+	};
+
 	/* MMC/SD */
 	sdhci at 700b0000 {
 		status = "okay";
@@ -1293,4 +1313,134 @@
 			linux,code = <KEY_VOLUMEUP>;
 		};
 	};
+
+	fixed-regulators {
+		vdd_ts_1v8: regulator at 201 {
+			compatible = "regulator-fixed";
+			reg = <201>;
+			regulator-name = "vdd-ts-1v8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			gpio = <&gpio_tca9539_74 1 0>;
+			enable-active-high;
+		};
+
+		avdd_ts_dis: regulator at 202 {
+			compatible = "regulator-fixed";
+			reg = <202>;
+			regulator-name = "avdd-ts-dis";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio_tca9539_74 2 0>;
+			enable-active-high;
+		};
+
+		vdd_dis_3v3_lcd: regulator at 203 {
+			compatible = "regulator-fixed";
+			reg = <203>;
+			regulator-name = "vdd_dis_3v3_lcd";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+			gpio = <&gpio_tca9539_74 3 1>;
+			enable-active-high;
+		};
+
+		mdm_vdd_3v7: regulator at 204 {
+			compatible = "regulator-fixed";
+			reg = <204>;
+			regulator-name = "mdm-vdd-3v7";
+			regulator-min-microvol = <3700000>;
+			regulator-max-microvol = <3700000>;
+			gpio = <&gpio_tca9539_74 7 1>;
+			enable-active-high;
+		};
+
+		vdd_lcd_1v8_dis: regulator at 205 {
+			compatible = "regulator-fixed";
+			reg = <205>;
+			regulator-name = "vdd-lcd-1v8-dis";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
+			gpio = <&gpio_tca9539_74 9 1>;
+			enable-active-high;
+		};
+
+		vdd_hdmi_5v0: regulator at 206 {
+			compatible = "regulator-fixed";
+			reg = <206>;
+			regulator-name = "vdd-hdmi-5v0";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio_tca9539_74 12 1>;
+			enable-active-high;
+			vin-supply = <&vdd_3v3>;
+			regulator-enable-ramp-delay = <468>;
+		};
+
+		avdd_cam_2v8: regulator at 207 {
+			compatible = "regulator-fixed";
+			reg = <207>;
+			regulator-name = "avdd-cam-2v8";
+			regulator-min-microvol = <2800000>;
+			regulator-max-microvol = <2800000>;
+			gpio = <&gpio_tca9539_74 13 1>;
+			enable-active-high;
+		};
+
+		dvdd_cam_io_1v8: regulator at 208 {
+			compatible = "regulator-fixed";
+			reg = <208>;
+			regulator-name = "dvdd-dam-io-1v8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			gpio = <&gpio_tca9539_77 9 1>;
+			enable-active-high;
+		};
+
+		dvdd_cam_io_1v2: regulator at 209 {
+			compatible = "regulator-fixed";
+			reg = <209>;
+			regulator-name = "dvdd-dam-io-1v2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			gpio = <&gpio_tca9539_77 10 1>;
+			enable-active-high;
+		};
+
+		usb_vbus1: regulator at 210 {
+			compatible = "regulator-fixed";
+			reg = <210>;
+			regulator-name = "usb-vbus1";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio TEGRA_GPIO(CC, 4) 0>;
+			enable-active-high;
+			gpio-open-drain;
+		};
+
+		usb_vbus2: regulator at 211 {
+			compatible = "regulator-fixed";
+			reg = <211>;
+			regulator-name = "usb-vbus2";
+			regulator-min-microvol = <5000000>;
+			regulator-max-microvol = <5000000>;
+			gpio = <&gpio TEGRA_GPIO(CC, 5) 0>;
+			enable-active-high;
+			gpio-open-drain;
+		};
+
+		sd_card_sw_pwr: regulator at 212 {
+			compatible = "regulator-fixed";
+			reg = <212>;
+			regulator-name = "sd-card-sw-pwr";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			enable-active-high;
+			vin-supply = <&vdd_3v3>;
+			regulator-enable-ramp-delay = <472>;
+			gpio = <&gpio TEGRA_GPIO(Z, 3) 0>;
+		};
+	};
 };
-- 
2.1.4
