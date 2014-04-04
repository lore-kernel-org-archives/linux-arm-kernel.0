From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  4 Apr 2014 12:57:30 -0700
Subject: [PATCH v6 5/5] ARM: dts: msm: Fix Krait CPU/L2 nodes
In-Reply-To: <1396641450-12854-1-git-send-email-sboyd@codeaurora.org>
References: <1396641450-12854-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1396641450-12854-6-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The error interrupt binding wasn't properly accepted when this
was originally written. Fix the dts to match the binding.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8960.dtsi | 29 +++++++++++++++-------
 arch/arm/boot/dts/qcom-msm8974.dtsi | 49 ++++++++++++++++++++++++++++---------
 2 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 997b7b94e117..66a6e8c4fdcf 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -12,30 +12,41 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		interrupts = <1 14 0x304>;
-		compatible = "qcom,krait";
 		enable-method = "qcom,kpss-acc-v1";
 
 		cpu at 0 {
+			compatible = "qcom,krait";
 			device_type = "cpu";
 			reg = <0>;
-			next-level-cache = <&L2>;
+			next-level-cache = <&L1_0>;
 			qcom,acc = <&acc0>;
 			qcom,saw = <&saw0>;
+
+			L1_0: l1-cache {
+				compatible = "qcom,arch-cache";
+				interrupts = <1 14 0x104>;
+				next-level-cache = <&L2>;
+			};
+
+			L2: l2-cache {
+				compatible = "qcom,arch-cache";
+				interrupts = <0 2 0x4>;
+			};
 		};
 
 		cpu at 1 {
+			compatible = "qcom,krait";
 			device_type = "cpu";
 			reg = <1>;
-			next-level-cache = <&L2>;
+			next-level-cache = <&L1_1>;
 			qcom,acc = <&acc1>;
 			qcom,saw = <&saw1>;
-		};
 
-		L2: l2-cache {
-			compatible = "cache";
-			cache-level = <2>;
-			interrupts = <0 2 0x4>;
+			L1_1: l1-cache {
+				compatible = "qcom,arch-cache";
+				interrupts = <1 14 0x104>;
+				next-level-cache = <&L2>;
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index f68723918b3f..b4ac497b7d76 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -12,43 +12,68 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		interrupts = <1 9 0xf04>;
-		compatible = "qcom,krait";
 		enable-method = "qcom,kpss-acc-v2";
 
 		cpu at 0 {
+			compatible = "qcom,krait";
 			device_type = "cpu";
 			reg = <0>;
-			next-level-cache = <&L2>;
+			next-level-cache = <&L1_0>;
 			qcom,acc = <&acc0>;
+
+			L1_0: l1-cache {
+				compatible = "qcom,arch-cache";
+				interrupts = <1 9 0x104>;
+				next-level-cache = <&L2>;
+			};
+
+			L2: l2-cache {
+				compatible = "qcom,arch-cache";
+				interrupts = <0 2 0x4>;
+				qcom,saw = <&saw_l2>;
+			};
 		};
 
 		cpu at 1 {
+			compatible = "qcom,krait";
 			device_type = "cpu";
 			reg = <1>;
-			next-level-cache = <&L2>;
+			next-level-cache = <&L1_1>;
 			qcom,acc = <&acc1>;
+
+			L1_1: l1-cache {
+				compatible = "qcom,arch-cache";
+				interrupts = <1 9 0x204>;
+				next-level-cache = <&L2>;
+			};
 		};
 
 		cpu at 2 {
+			compatible = "qcom,krait";
 			device_type = "cpu";
 			reg = <2>;
-			next-level-cache = <&L2>;
+			next-level-cache = <&L1_2>;
 			qcom,acc = <&acc2>;
+
+			L1_2: l1-cache {
+				compatible = "qcom,arch-cache";
+				interrupts = <1 9 0x404>;
+				next-level-cache = <&L2>;
+			};
 		};
 
 		cpu at 3 {
+			compatible = "qcom,krait";
 			device_type = "cpu";
 			reg = <3>;
-			next-level-cache = <&L2>;
+			next-level-cache = <&L1_3>;
 			qcom,acc = <&acc3>;
-		};
 
-		L2: l2-cache {
-			compatible = "cache";
-			cache-level = <2>;
-			interrupts = <0 2 0x4>;
-			qcom,saw = <&saw_l2>;
+			L1_3: l1-cache {
+				compatible = "qcom,arch-cache";
+				interrupts = <1 9 0x804>;
+				next-level-cache = <&L2>;
+			};
 		};
 	};
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
