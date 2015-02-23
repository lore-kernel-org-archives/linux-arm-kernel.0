From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 23 Feb 2015 07:55:27 +0000
Subject: [PATCH 05/12] ARM: dts: APQ8064: Add MDP support
In-Reply-To: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1424678127-13136-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Clark <robdclark@gmail.com>

This patch adds MDP node to APQ8064 dt.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 112 ++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index e65aff0..9c2e9b2 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -1,6 +1,7 @@
 /dts-v1/;
 
 #include "skeleton.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/qcom,gcc-msm8960.h>
 #include <dt-bindings/reset/qcom,gcc-msm8960.h>
 #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
@@ -94,6 +95,20 @@
 				};
 			};
 
+			hdmi_pinctrl: hdmi-pinctrl {
+				mux1 {
+					pins = "gpio69", "gpio70", "gpio71";
+					function = "hdmi";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+				mux2 {
+					pins = "gpio72";
+					function = "hdmi";
+					bias-pull-down;
+					drive-strength = <16>;
+				};
+			};
 			ps_hold: ps_hold {
 				mux {
 					pins = "gpio78";
@@ -228,6 +243,18 @@
 			};
 		};
 
+		ext_3p3v: regulator-fixed at 1 {
+			compatible = "regulator-fixed";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-name = "ext_3p3v";
+			regulator-type = "voltage";
+			startup-delay-us = <0>;
+			gpio = <&tlmm_pinmux 77 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			regulator-boot-on;
+		};
+
 		qcom,ssbi at 500000 {
 			compatible = "qcom,ssbi";
 			reg = <0x00500000 0x1000>;
@@ -426,6 +453,13 @@
 				reg		= <QCOM_RPM_PM8921_LDO27>;
 			};
 
+			pm8921_hdmi_mvs: pm8921-hdmi-mvs {
+				compatible	= "qcom,rpm-pm8921-switch";
+				reg		= <QCOM_RPM_HDMI_SWITCH>;
+				regulator-always-on;
+				bias-pull-down;
+			};
+
 			pm8921_l28: pm8921-l28 {
 				compatible	= "qcom,rpm-pm8921-nldo1200";
 				reg		= <QCOM_RPM_PM8921_LDO28>;
@@ -704,5 +738,83 @@
 				pinctrl-0 = <&sdc4_gpios>;
 			};
 		};
+
+		hdmi: qcom,hdmi-tx at 4a00000 {
+			compatible = "qcom,hdmi-tx-8960";
+			reg-names = "core_physical";
+			reg = <0x04a00000 0x1000>;
+			interrupts = <GIC_SPI 79 0>;
+			clock-names =
+			    "core_clk",
+			    "master_iface_clk",
+			    "slave_iface_clk";
+			clocks =
+			    <&mmcc HDMI_APP_CLK>,
+			    <&mmcc HDMI_M_AHB_CLK>,
+			    <&mmcc HDMI_S_AHB_CLK>;
+			qcom,hdmi-tx-ddc-clk = <&tlmm_pinmux 70
+						GPIO_ACTIVE_HIGH>;
+			qcom,hdmi-tx-ddc-data = <&tlmm_pinmux 71
+						GPIO_ACTIVE_HIGH>;
+			qcom,hdmi-tx-hpd = <&tlmm_pinmux 72
+						GPIO_ACTIVE_HIGH>;
+			core-vdda-supply = <&pm8921_hdmi_mvs>;
+			hdmi-mux-supply = <&ext_3p3v>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hdmi_pinctrl>;
+		};
+
+		gpu: qcom,adreno-3xx at 4300000 {
+			compatible = "qcom,adreno-3xx";
+			reg = <0x04300000 0x20000>;
+			reg-names = "kgsl_3d0_reg_memory";
+			interrupts = <GIC_SPI 80 0>;
+			interrupt-names = "kgsl_3d0_irq";
+			clock-names =
+			    "core_clk",
+			    "iface_clk",
+			    "mem_clk",
+			    "mem_iface_clk";
+			clocks =
+			    <&mmcc GFX3D_CLK>,
+			    <&mmcc GFX3D_AHB_CLK>,
+			    <&mmcc GFX3D_AXI_CLK>,
+			    <&mmcc MMSS_IMEM_AHB_CLK>;
+			qcom,chipid = <0x03020002>;
+			qcom,gpu-pwrlevels {
+				compatible = "qcom,gpu-pwrlevels";
+				qcom,gpu-pwrlevel at 0 {
+					qcom,gpu-freq = <450000000>;
+				};
+				qcom,gpu-pwrlevel at 1 {
+					qcom,gpu-freq = <27000000>;
+				};
+			};
+		};
+
+		mdp: qcom,mdp at 5100000 {
+			compatible = "qcom,mdp";
+			reg = <0x05100000 0xf0000>;
+			interrupts = <GIC_SPI 75 0>;
+			connectors = <&hdmi>;
+			gpus = <&gpu>;
+			clock-names =
+			    "core_clk",
+			    "iface_clk",
+			    "lut_clk",
+			    "src_clk",
+			    "hdmi_clk",
+			    "mdp_clk",
+			    "mdp_axi_clk";
+			clocks =
+			    <&mmcc MDP_CLK>,
+			    <&mmcc MDP_AHB_CLK>,
+			    <&mmcc MDP_LUT_CLK>,
+			    <&mmcc TV_SRC>,
+			    <&mmcc HDMI_TV_CLK>,
+			    <&mmcc MDP_TV_CLK>,
+			    <&mmcc MDP_AXI_CLK>;
+//			vdd-supply = <&footswitch_mdp>;
+		};
 	};
 };
-- 
1.9.1
