From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  1 Nov 2013 15:08:58 -0700
Subject: [PATCH 10/11] ARM: dts: msm: Add nodes necessary for SMP boot
In-Reply-To: <1383343739-23080-1-git-send-email-sboyd@codeaurora.org>
References: <1383343739-23080-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1383343739-23080-11-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rohit Vaswani <rvaswani@codeaurora.org>

Add the necessary nodes to support SMP on MSM8960 and
MSM8974/APQ8074. While we're here also add in the error
interrupts for the krait cache error detection.

Signed-off-by: Rohit Vaswani <rvaswani@codeaurora.org>
[sboyd: Split into separate patch, add error interrupts]
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8960-cdp.dts | 32 ++++++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi    | 49 ++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
index 91efaec..0621037c 100644
--- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
+++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
@@ -9,6 +9,32 @@
 	compatible = "qcom,msm8960-cdp", "qcom,msm8960";
 	interrupt-parent = <&intc>;
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <1 14 0x304>;
+		compatible = "qcom,krait";
+		enable-method = "qcom,mmio";
+
+		cpu at 0 {
+			device_type = "cpu";
+			reg = <0>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			reg = <1>;
+			next-level-cache = <&L2>;
+		};
+
+		L2: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+			interrupts = <0 2 0x4>;
+		};
+	};
+
 	intc: interrupt-controller at 2000000 {
 		compatible = "qcom,msm-qgic2";
 		interrupt-controller;
@@ -53,6 +79,12 @@
 		#reset-cells = <1>;
 	};
 
+	clock-controller at 2008000 {
+		compatible = "qcom,kpss-acc-v1";
+		reg = <0x02008000 0x1000>;
+		cpu-offset = <0x80000>;
+	};
+
 	serial at 16440000 {
 		compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
 		reg = <0x16440000 0x1000>,
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 152879d..0eac2ea 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -9,6 +9,44 @@
 	compatible = "qcom,msm8974";
 	interrupt-parent = <&intc>;
 
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <1 9 0xf04>;
+		compatible = "qcom,krait";
+		enable-method = "qcom,mmio";
+
+		cpu at 0 {
+			device_type = "cpu";
+			reg = <0>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			reg = <1>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu at 2 {
+			device_type = "cpu";
+			reg = <2>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu at 3 {
+			device_type = "cpu";
+			reg = <3>;
+			next-level-cache = <&L2>;
+		};
+
+		L2: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+			interrupts = <0 2 0x4>;
+		};
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -91,6 +129,17 @@
 			};
 		};
 
+		regulator at f9012000 {
+			compatible = "qcom,l2-saw2", "qcom,saw2";
+			reg = <0xf9012000 0x1000>;
+		};
+
+		clock-controller at f9008000 {
+			compatible = "qcom,kpss-acc-v2";
+			reg = <0xf9008000 0x1000>;
+			cpu-offset = <0x80000>;
+		};
+
 		restart at fc4ab000 {
 			compatible = "qcom,pshold";
 			reg = <0xfc4ab000 0x4>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
