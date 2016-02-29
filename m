From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 29 Feb 2016 18:36:51 +0530
Subject: [PATCH 2/2] arm64: tegra: Jetson-TX1: Add DT entry for system PMIC
 MAX77620
In-Reply-To: <1456751211-14341-1-git-send-email-ldewangan@nvidia.com>
References: <1456751211-14341-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456751211-14341-2-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NVIDIA's Tegra210 platform Jetson-TX1 uses the Maxim Semiconductor's
PMIC MAX77620 as system PMIC.

Add DT entry for this device which enabled core registration,
GPIO, pin control, power sequencing and regulator functionalities.

This patch is created based on downstream data and new DT properties.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
The patches for drivers of MFD/GPIO/Pincontrol are in flight.

 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 205 +++++++++++++++++++++
 1 file changed, 205 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
index 18147eb..1f0788b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
@@ -2,12 +2,217 @@
 
 #include "tegra210-p2180.dtsi"
 #include "tegra210-p2597.dtsi"
+#include <dt-bindings/mfd/max77620.h>
 #include <dt-bindings/input/input.h>
 
 / {
 	model = "NVIDIA Jetson TX1 Developer Kit";
 	compatible = "nvidia,p2371-2180", "nvidia,tegra210";
 
+	i2c at 0,7000d000 {
+		status = "okay";
+		system-pmic at 3c {
+			compatible = "maxim,max77620";
+			reg = <0x3c>;
+			interrupts = <0 86 IRQ_TYPE_NONE>;
+
+			#interrupt-cells = <2>;
+			interrupt-controller;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&system_pmic_default>;
+
+			in-ldo0-1-supply = <&spmic_sd2>;
+			in-ldo7-8-supply = <&spmic_sd2>;
+
+			system_pmic_default: default {
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
+					drive-open-drain = <1>;
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
+					maxim,suspend-fps-time-period-us = <1280>;
+					maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN0>;
+				};
+
+				fps1 {
+					maxim,suspend-fps-time-period-us = <1280>;
+					maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN1>;
+				};
+
+				fps2 {
+					maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN0>;
+				};
+			};
+
+			regulators {
+				sd0 {
+					regulator-name = "vdd-core";
+					regulator-min-microvolt = <600000>;
+					regulator-max-microvolt = <1400000>;
+					regulator-boot-on;
+					regulator-always-on;
+					regulator-enable-ramp-delay = <146>;
+					regulator-ramp-delay = <27500>;
+					maxim,fps-source = <MAX77620_FPS_SRC_1>;
+				};
+
+				sd1 {
+					regulator-name = "vddio-ddr";
+					regulator-always-on;
+					regulator-boot-on;
+					regulator-enable-ramp-delay = <130>;
+					regulator-ramp-delay = <27500>;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
+				};
+
+				spmic_sd2: sd2 {
+					regulator-name = "vdd-pre-reg";
+					regulator-min-microvolt = <1350000>;
+					regulator-max-microvolt = <1350000>;
+					regulator-enable-ramp-delay = <176>;
+					regulator-ramp-delay = <27500>;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
+				};
+
+				sd3 {
+					regulator-name = "vdd-1v8";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+					regulator-enable-ramp-delay = <242>;
+					regulator-ramp-delay = <27500>;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
+				};
+
+				ldo0 {
+					regulator-name = "avdd-sys";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-always-on;
+					regulator-boot-on;
+					regulator-enable-ramp-delay = <26>;
+					regulator-ramp-delay = <100000>;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+				};
+
+				ldo1 {
+					regulator-name = "vdd-pex";
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1050000>;
+					regulator-always-on;
+					regulator-enable-ramp-delay = <22>;
+					regulator-ramp-delay = <100000>;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
+				};
+
+				ldo2 {
+					regulator-name = "vddio-sdmmc1";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-enable-ramp-delay = <62>;
+					regulator-ramp-delay = <100000>;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+				};
+
+				ldo3 {
+					regulator-name = "vdd-cam-hv";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+					regulator-enable-ramp-delay = <50>;
+					regulator-ramp-delay = <100000>;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+				};
+
+				ldo4 {
+					regulator-name = "vdd-rtc";
+					regulator-min-microvolt = <850000>;
+					regulator-max-microvolt = <850000>;
+					regulator-always-on;
+					regulator-boot-on;
+					regulator-enable-ramp-delay = <22>;
+					regulator-ramp-delay = <100000>;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
+				};
+
+				ldo5 {
+					regulator-name = "avdd-ts-hv";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-enable-ramp-delay = <62>;
+					regulator-ramp-delay = <100000>;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_NONE>;
+				};
+
+				ldo6 {
+					regulator-name = "vdd-ts";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-enable-ramp-delay = <36>;
+					regulator-ramp-delay = <100000>;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
+					maxim,active-fps-power-up-slot = <7>;
+					maxim,active-fps-power-down-slot = <0>;
+				};
+
+				ldo7 {
+					regulator-name = "vdd-gen-pll-edp";
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1050000>;
+					regulator-always-on;
+					regulator-boot-on;
+					regulator-enable-ramp-delay = <24>;
+					regulator-ramp-delay = <100000>;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
+				};
+
+				ldo8 {
+					regulator-name = "vdd-hdmi-dp";
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1050000>;
+					regulator-always-on;
+					regulator-enable-ramp-delay = <22>;
+					regulator-ramp-delay = <100000>;
+					maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
+				};
+			};
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		label = "gpio-keys";
-- 
2.1.4
