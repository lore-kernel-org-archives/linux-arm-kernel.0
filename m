From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Wed, 18 Jul 2018 12:13:10 +0530
Subject: [PATCH v8 4/7] arm64: dts: msm8996: thermal: Initialise via DT and
 add second controller
In-Reply-To: <cover.1531895128.git.amit.kucheria@linaro.org>
References: <cover.1531895128.git.amit.kucheria@linaro.org>
Message-ID: <540bcdb06d3e032de903748545076327ebc04026.1531895128.git.amit.kucheria@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We also split up the regmap address space into two, for the TM and SROT
registers. This was required to deal with different address offsets for the
TM and SROT registers across different SoC families.

8996 has two TSENS IP blocks, initialise the second one too.

Since tsens-common.c/init_common() currently only registers one address
space, the order is important (TM before SROT). This is OK since the code
doesn't really use the SROT functionality yet.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 8c7f9ca..688e752 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -459,9 +459,19 @@
 			status = "disabled";
 		};
 
-		tsens0: thermal-sensor at 4a8000 {
+		tsens0: thermal-sensor at 4a9000 {
 			compatible = "qcom,msm8996-tsens";
-			reg = <0x4a8000 0x2000>;
+			reg = <0x4a9000 0x1000>, /* TM */
+			      <0x4a8000 0x1000>; /* SROT */
+			#qcom,sensors = <13>;
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens1: thermal-sensor at 4ad000 {
+			compatible = "qcom,msm8996-tsens";
+			reg = <0x4ad000 0x1000>, /* TM */
+			      <0x4ac000 0x1000>; /* SROT */
+			#qcom,sensors = <8>;
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.7.4
