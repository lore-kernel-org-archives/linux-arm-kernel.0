From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 28 May 2014 13:27:39 -0500
Subject: [PATCH] ARM: dts: qcom: Update msm8660 device trees
Message-ID: <1401301659-20235-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Move SoC peripherals into an SoC container node
* Move serial enabling into board file (qcom-msm8660-surf.dts)
* Cleanup cpu node to match binding spec, enable-method and compatible
  should be per cpu, not part of the container

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8660-surf.dts |   6 ++
 arch/arm/boot/dts/qcom-msm8660.dtsi     | 104 +++++++++++++++++---------------
 2 files changed, 63 insertions(+), 47 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8660-surf.dts b/arch/arm/boot/dts/qcom-msm8660-surf.dts
index 169bad9..13f5a78 100644
--- a/arch/arm/boot/dts/qcom-msm8660-surf.dts
+++ b/arch/arm/boot/dts/qcom-msm8660-surf.dts
@@ -3,4 +3,10 @@
 / {
 	model = "Qualcomm MSM8660 SURF";
 	compatible = "qcom,msm8660-surf", "qcom,msm8660";
+
+	soc {
+		serial at 19c40000 {
+			status = "ok";
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index c52a9e9..41bc38b 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -12,16 +12,18 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "qcom,scorpion";
-		enable-method = "qcom,gcc-msm8660";
 
 		cpu at 0 {
+			compatible = "qcom,scorpion";
+			enable-method = "qcom,gcc-msm8660";
 			device_type = "cpu";
 			reg = <0>;
 			next-level-cache = <&L2>;
 		};
 
 		cpu at 1 {
+			compatible = "qcom,scorpion";
+			enable-method = "qcom,gcc-msm8660";
 			device_type = "cpu";
 			reg = <1>;
 			next-level-cache = <&L2>;
@@ -33,55 +35,63 @@
 		};
 	};
 
-	intc: interrupt-controller at 2080000 {
-		compatible = "qcom,msm-8660-qgic";
-		interrupt-controller;
-		#interrupt-cells = <3>;
-		reg = < 0x02080000 0x1000 >,
-		      < 0x02081000 0x1000 >;
-	};
+	soc: soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		compatible = "simple-bus";
 
-	timer at 2000000 {
-		compatible = "qcom,scss-timer", "qcom,msm-timer";
-		interrupts = <1 0 0x301>,
-			     <1 1 0x301>,
-			     <1 2 0x301>;
-		reg = <0x02000000 0x100>;
-		clock-frequency = <27000000>,
-				  <32768>;
-		cpu-offset = <0x40000>;
-	};
+		intc: interrupt-controller at 2080000 {
+			compatible = "qcom,msm-8660-qgic";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = < 0x02080000 0x1000 >,
+			      < 0x02081000 0x1000 >;
+		};
 
-	msmgpio: gpio at 800000 {
-		compatible = "qcom,msm-gpio";
-		reg = <0x00800000 0x4000>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		ngpio = <173>;
-		interrupts = <0 16 0x4>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
+		timer at 2000000 {
+			compatible = "qcom,scss-timer", "qcom,msm-timer";
+			interrupts = <1 0 0x301>,
+				     <1 1 0x301>,
+				     <1 2 0x301>;
+			reg = <0x02000000 0x100>;
+			clock-frequency = <27000000>,
+					  <32768>;
+			cpu-offset = <0x40000>;
+		};
 
-	gcc: clock-controller at 900000 {
-		compatible = "qcom,gcc-msm8660";
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-		reg = <0x900000 0x4000>;
-	};
+		msmgpio: gpio at 800000 {
+			compatible = "qcom,msm-gpio";
+			reg = <0x00800000 0x4000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			ngpio = <173>;
+			interrupts = <0 16 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 
-	serial at 19c40000 {
-		compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
-		reg = <0x19c40000 0x1000>,
-		      <0x19c00000 0x1000>;
-		interrupts = <0 195 0x0>;
-		clocks = <&gcc GSBI12_UART_CLK>, <&gcc GSBI12_H_CLK>;
-		clock-names = "core", "iface";
-	};
+		gcc: clock-controller at 900000 {
+			compatible = "qcom,gcc-msm8660";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			reg = <0x900000 0x4000>;
+		};
 
-	qcom,ssbi at 500000 {
-		compatible = "qcom,ssbi";
-		reg = <0x500000 0x1000>;
-		qcom,controller-type = "pmic-arbiter";
+		serial at 19c40000 {
+			compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
+			reg = <0x19c40000 0x1000>,
+			      <0x19c00000 0x1000>;
+			interrupts = <0 195 0x0>;
+			clocks = <&gcc GSBI12_UART_CLK>, <&gcc GSBI12_H_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		qcom,ssbi at 500000 {
+			compatible = "qcom,ssbi";
+			reg = <0x500000 0x1000>;
+			qcom,controller-type = "pmic-arbiter";
+		};
 	};
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
