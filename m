From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 28 May 2014 13:27:23 -0500
Subject: [PATCH] ARM: dts: qcom: Update msm8960 device trees
Message-ID: <1401301643-20191-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Move SoC peripherals into an SoC container node
* Move serial enabling into board file (qcom-msm8960-cdp.dts)
* Cleanup cpu node to match binding spec, enable-method and compatible
  should be per cpu, not part of the container
* Drop interrupts property from l2-cache node as its not part of the
  binding spec

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8960-cdp.dts |   6 ++
 arch/arm/boot/dts/qcom-msm8960.dtsi    | 165 +++++++++++++++++----------------
 2 files changed, 93 insertions(+), 78 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
index a58fb88..8e77ed7 100644
--- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
+++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
@@ -3,4 +3,10 @@
 / {
 	model = "Qualcomm MSM8960 CDP";
 	compatible = "qcom,msm8960-cdp", "qcom,msm8960";
+
+	soc {
+		serial at 16440000 {
+			status = "ok";
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 997b7b9..c38e54c 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -13,10 +13,10 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		interrupts = <1 14 0x304>;
-		compatible = "qcom,krait";
-		enable-method = "qcom,kpss-acc-v1";
 
 		cpu at 0 {
+			compatible = "qcom,krait";
+			enable-method = "qcom,kpss-acc-v1";
 			device_type = "cpu";
 			reg = <0>;
 			next-level-cache = <&L2>;
@@ -25,6 +25,8 @@
 		};
 
 		cpu at 1 {
+			compatible = "qcom,krait";
+			enable-method = "qcom,kpss-acc-v1";
 			device_type = "cpu";
 			reg = <1>;
 			next-level-cache = <&L2>;
@@ -35,7 +37,6 @@
 		L2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
-			interrupts = <0 2 0x4>;
 		};
 	};
 
@@ -45,91 +46,99 @@
 		qcom,no-pc-write;
 	};
 
-	intc: interrupt-controller at 2000000 {
-		compatible = "qcom,msm-qgic2";
-		interrupt-controller;
-		#interrupt-cells = <3>;
-		reg = < 0x02000000 0x1000 >,
-		      < 0x02002000 0x1000 >;
-	};
+	soc: soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		compatible = "simple-bus";
+
+		intc: interrupt-controller at 2000000 {
+			compatible = "qcom,msm-qgic2";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0x02000000 0x1000>,
+			      <0x02002000 0x1000>;
+		};
 
-	timer at 200a000 {
-		compatible = "qcom,kpss-timer", "qcom,msm-timer";
-		interrupts = <1 1 0x301>,
-			     <1 2 0x301>,
-			     <1 3 0x301>;
-		reg = <0x0200a000 0x100>;
-		clock-frequency = <27000000>,
-				  <32768>;
-		cpu-offset = <0x80000>;
-	};
+		timer at 200a000 {
+			compatible = "qcom,kpss-timer", "qcom,msm-timer";
+			interrupts = <1 1 0x301>,
+				     <1 2 0x301>,
+				     <1 3 0x301>;
+			reg = <0x0200a000 0x100>;
+			clock-frequency = <27000000>,
+					  <32768>;
+			cpu-offset = <0x80000>;
+		};
 
-	msmgpio: gpio at 800000 {
-		compatible = "qcom,msm-gpio";
-		gpio-controller;
-		#gpio-cells = <2>;
-		ngpio = <150>;
-		interrupts = <0 16 0x4>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		reg = <0x800000 0x4000>;
-	};
+		msmgpio: gpio at 800000 {
+			compatible = "qcom,msm-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+			ngpio = <150>;
+			interrupts = <0 16 0x4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x800000 0x4000>;
+		};
 
-	gcc: clock-controller at 900000 {
-		compatible = "qcom,gcc-msm8960";
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-		reg = <0x900000 0x4000>;
-	};
+		gcc: clock-controller at 900000 {
+			compatible = "qcom,gcc-msm8960";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			reg = <0x900000 0x4000>;
+		};
 
-	clock-controller at 4000000 {
-		compatible = "qcom,mmcc-msm8960";
-		reg = <0x4000000 0x1000>;
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
+		clock-controller at 4000000 {
+			compatible = "qcom,mmcc-msm8960";
+			reg = <0x4000000 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
 
-	acc0: clock-controller at 2088000 {
-		compatible = "qcom,kpss-acc-v1";
-		reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
-	};
+		acc0: clock-controller at 2088000 {
+			compatible = "qcom,kpss-acc-v1";
+			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
+		};
 
-	acc1: clock-controller at 2098000 {
-		compatible = "qcom,kpss-acc-v1";
-		reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
-	};
+		acc1: clock-controller at 2098000 {
+			compatible = "qcom,kpss-acc-v1";
+			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
+		};
 
-	saw0: regulator at 2089000 {
-		compatible = "qcom,saw2";
-		reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
-		regulator;
-	};
+		saw0: regulator at 2089000 {
+			compatible = "qcom,saw2";
+			reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
+			regulator;
+		};
 
-	saw1: regulator at 2099000 {
-		compatible = "qcom,saw2";
-		reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
-		regulator;
-	};
+		saw1: regulator at 2099000 {
+			compatible = "qcom,saw2";
+			reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
+			regulator;
+		};
 
-	serial at 16440000 {
-		compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
-		reg = <0x16440000 0x1000>,
-		      <0x16400000 0x1000>;
-		interrupts = <0 154 0x0>;
-		clocks = <&gcc GSBI5_UART_CLK>, <&gcc GSBI5_H_CLK>;
-		clock-names = "core", "iface";
-	};
+		serial at 16440000 {
+			compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
+			reg = <0x16440000 0x1000>,
+			      <0x16400000 0x1000>;
+			interrupts = <0 154 0x0>;
+			clocks = <&gcc GSBI5_UART_CLK>, <&gcc GSBI5_H_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
 
-	qcom,ssbi at 500000 {
-		compatible = "qcom,ssbi";
-		reg = <0x500000 0x1000>;
-		qcom,controller-type = "pmic-arbiter";
-	};
+		qcom,ssbi at 500000 {
+			compatible = "qcom,ssbi";
+			reg = <0x500000 0x1000>;
+			qcom,controller-type = "pmic-arbiter";
+		};
 
-	rng at 1a500000 {
-		compatible = "qcom,prng";
-		reg = <0x1a500000 0x200>;
-		clocks = <&gcc PRNG_CLK>;
-		clock-names = "core";
+		rng at 1a500000 {
+			compatible = "qcom,prng";
+			reg = <0x1a500000 0x200>;
+			clocks = <&gcc PRNG_CLK>;
+			clock-names = "core";
+		};
 	};
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
