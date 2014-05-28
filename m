From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 28 May 2014 13:32:56 -0500
Subject: [PATCH v2] ARM: dts: qcom: Update msm8974/apq8074 device trees
Message-ID: <1401301976-22506-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Move SoC peripherals into an SoC container node
* Move serial enabling into board file (qcom-apq8074-dragonboard.dts)
* Move spi pinctrl into board file
* Cleanup cpu node to match binding spec, enable-method and compatible
  should be per cpu, not part of the container
* Drop interrupts property from l2-cache node as its not part of the
  binding spec
* Move timer node out of SoC container

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
v2:
* Move timer node out of SoC container

 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts | 28 ++++++++++++++-
 arch/arm/boot/dts/qcom-msm8974.dtsi            | 49 ++++++++++----------------
 2 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
index 92320c4..b4dfb01 100644
--- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
@@ -4,7 +4,11 @@
 	model = "Qualcomm APQ8074 Dragonboard";
 	compatible = "qcom,apq8074-dragonboard", "qcom,apq8074";
 
-	soc: soc {
+	soc {
+		serial at f991e000 {
+			status = "ok";
+		};
+
 		sdhci at f9824900 {
 			bus-width = <8>;
 			non-removable;
@@ -15,5 +19,27 @@
 			cd-gpios = <&msmgpio 62 0x1>;
 			bus-width = <4>;
 		};
+
+
+		pinctrl at fd510000 {
+			spi8_default: spi8_default {
+				mosi {
+					pins = "gpio45";
+					function = "blsp_spi8";
+				};
+				miso {
+					pins = "gpio46";
+					function = "blsp_spi8";
+				};
+				cs {
+					pins = "gpio47";
+					function = "blsp_spi8";
+				};
+				clk {
+					pins = "gpio48";
+					function = "blsp_spi8";
+				};
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index c530a33..69dca2a 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -13,10 +13,10 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		interrupts = <1 9 0xf04>;
-		compatible = "qcom,krait";
-		enable-method = "qcom,kpss-acc-v2";
 
 		cpu at 0 {
+			compatible = "qcom,krait";
+			enable-method = "qcom,kpss-acc-v2";
 			device_type = "cpu";
 			reg = <0>;
 			next-level-cache = <&L2>;
@@ -24,6 +24,8 @@
 		};
 
 		cpu at 1 {
+			compatible = "qcom,krait";
+			enable-method = "qcom,kpss-acc-v2";
 			device_type = "cpu";
 			reg = <1>;
 			next-level-cache = <&L2>;
@@ -31,6 +33,8 @@
 		};
 
 		cpu at 2 {
+			compatible = "qcom,krait";
+			enable-method = "qcom,kpss-acc-v2";
 			device_type = "cpu";
 			reg = <2>;
 			next-level-cache = <&L2>;
@@ -38,6 +42,8 @@
 		};
 
 		cpu at 3 {
+			compatible = "qcom,krait";
+			enable-method = "qcom,kpss-acc-v2";
 			device_type = "cpu";
 			reg = <3>;
 			next-level-cache = <&L2>;
@@ -47,7 +53,6 @@
 		L2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
-			interrupts = <0 2 0x4>;
 			qcom,saw = <&saw_l2>;
 		};
 	};
@@ -57,6 +62,15 @@
 		interrupts = <1 7 0xf04>;
 	};
 
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <1 2 0xf08>,
+			     <1 3 0xf08>,
+			     <1 4 0xf08>,
+			     <1 1 0xf08>;
+		clock-frequency = <19200000>;
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -71,15 +85,6 @@
 			      <0xf9002000 0x1000>;
 		};
 
-		timer {
-			compatible = "arm,armv7-timer";
-			interrupts = <1 2 0xf08>,
-				     <1 3 0xf08>,
-				     <1 4 0xf08>,
-				     <1 1 0xf08>;
-			clock-frequency = <19200000>;
-		};
-
 		timer at f9020000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -190,6 +195,7 @@
 			interrupts = <0 108 0x0>;
 			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
+			status = "disabled";
 		};
 
 		sdhci at f9824900 {
@@ -229,25 +235,6 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			interrupts = <0 208 0>;
-
-			spi8_default: spi8_default {
-				mosi {
-					pins = "gpio45";
-					function = "blsp_spi8";
-				};
-				miso {
-					pins = "gpio46";
-					function = "blsp_spi8";
-				};
-				cs {
-					pins = "gpio47";
-					function = "blsp_spi8";
-				};
-				clk {
-					pins = "gpio48";
-					function = "blsp_spi8";
-				};
-			};
 		};
 	};
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
