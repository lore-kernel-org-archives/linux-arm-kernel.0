From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed,  1 Aug 2018 09:09:07 +0530
Subject: [PATCH v2 02/10] arm64: dts: actions: Convert Owl SoCs
 clock-controller nodes to syscon
In-Reply-To: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
References: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180801033915.15880-3-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since clock and reset management units are sharing the same memory map,
Owl SoCs clock-controller nodes needs to be converted to syscon so that
the corresponding reset drivers can also reuse the same memory region.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 12 ++++++++----
 arch/arm64/boot/dts/actions/s900.dtsi | 12 ++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 59d29e4ca404..a57f54587164 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -160,11 +160,15 @@
 			status = "disabled";
 		};
 
-		cmu: clock-controller at e0168000 {
-			compatible = "actions,s700-cmu";
+		sysctrl: system-controller at e0168000 {
+			compatible = "syscon", "simple-mfd";
 			reg = <0x0 0xe0168000 0x0 0x1000>;
-			clocks = <&hosc>, <&losc>;
-			#clock-cells = <1>;
+
+			cmu: clock-controller {
+				compatible = "actions,s700-cmu";
+				clocks = <&hosc>, <&losc>;
+				#clock-cells = <1>;
+			};
 		};
 
 		sps: power-controller at e01b0100 {
diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index aa3a49b0d646..d239033f9599 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -167,11 +167,15 @@
 			status = "disabled";
 		};
 
-		cmu: clock-controller at e0160000 {
-			compatible = "actions,s900-cmu";
+		sysctrl: system-controller at e0160000 {
+			compatible = "syscon", "simple-mfd";
 			reg = <0x0 0xe0160000 0x0 0x1000>;
-			clocks = <&hosc>, <&losc>;
-			#clock-cells = <1>;
+
+			cmu: clock-controller {
+				compatible = "actions,s900-cmu";
+				clocks = <&hosc>, <&losc>;
+				#clock-cells = <1>;
+			};
 		};
 
 		pinctrl: pinctrl at e01b0000 {
-- 
2.17.1
