From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu,  8 Oct 2015 12:19:28 +0100
Subject: [PATCH 2/4] arm64: dts: qcom: Add msm8916 I2C nodes.
In-Reply-To: <1444303124-32402-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1444303124-32402-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1444303168-32490-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing support for i2c0 and i2c6, this support is
required to connect the i2c slaves on LS expansion on DB410c.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 48 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi      | 31 +++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index a6105d7..49ec55a 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -265,6 +265,30 @@
 		};
 	};
 
+	i2c2_default: i2c2_default {
+		pinmux {
+			function = "blsp_i2c2";
+			pins = "gpio6", "gpio7";
+		};
+		pinconf {
+			pins = "gpio6", "gpio7";
+			drive-strength = <2>;
+			bias-disable = <0>;
+		};
+	};
+
+	i2c2_sleep: i2c2_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio6", "gpio7";
+		};
+		pinconf {
+			pins = "gpio6", "gpio7";
+			drive-strength = <2>;
+			bias-disable = <0>;
+		};
+	};
+
 	i2c4_default: i2c4_default {
 		pinmux {
 			function = "blsp_i2c4";
@@ -289,6 +313,30 @@
 		};
 	};
 
+	i2c6_default: i2c6_default {
+		pinmux {
+			function = "blsp_i2c6";
+			pins = "gpio22", "gpio23";
+		};
+		pinconf {
+			pins = "gpio22", "gpio23";
+			drive-strength = <2>;
+			bias-disable = <0>;
+		};
+	};
+
+	i2c6_sleep: i2c6_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio22", "gpio23";
+		};
+		pinconf {
+			pins = "gpio22", "gpio23";
+			drive-strength = <2>;
+			bias-disable = <0>;
+		};
+	};
+
 	sdhc2_cd_pin {
 		sdc2_cd_on: cd_on {
 			pinmux {
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 85f7bee..d49ac37 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -233,6 +233,22 @@
 			status = "disabled";
 		};
 
+		/* BLSP1 QUP2 */
+		blsp_i2c2: i2c at 78b6000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x78b6000 0x1000>;
+			interrupts = <GIC_SPI 96 0>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				<&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&i2c2_default>;
+			pinctrl-1 = <&i2c2_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		blsp_i2c4: i2c at 78b8000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
 			reg = <0x78b8000 0x1000>;
@@ -248,6 +264,21 @@
 			status = "disabled";
 		};
 
+		blsp_i2c6: i2c at 78ba000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x78ba000 0x1000>;
+			interrupts = <GIC_SPI 100 0>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				<&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&i2c6_default>;
+			pinctrl-1 = <&i2c6_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		sdhc_1: sdhci at 07824000 {
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0x07824900 0x11c>, <0x07824000 0x800>;
-- 
1.9.1
