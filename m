From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 16 Jun 2015 13:31:13 -0700
Subject: [PATCH 2/5] ARM: dts: qcom: Add MSM8960 RPM and RPM regulator nodes
In-Reply-To: <1434486676-21812-1-git-send-email-sboyd@codeaurora.org>
References: <1434486676-21812-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1434486676-21812-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the basic RPM and RPM regulator nodes that boards can fill in
with their board specific details.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8960.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 1ae3fe828e59..fcf4bb5f9c3f 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -4,6 +4,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8960.h>
+#include <dt-bindings/mfd/qcom-rpm.h>
 #include <dt-bindings/soc/qcom,gsbi.h>
 
 / {
@@ -104,6 +105,24 @@
 			#reset-cells = <1>;
 		};
 
+		l2cc: clock-controller at 2011000 {
+			compatible	= "syscon";
+			reg		= <0x2011000 0x1000>;
+		};
+
+		rpm at 108000 {
+			compatible	= "qcom,rpm-msm8960";
+			reg		= <0x108000 0x1000>;
+			qcom,ipc	= <&l2cc 0x8 2>;
+
+			interrupts	= <0 19 0>, <0 21 0>, <0 22 0>;
+			interrupt-names	= "ack", "err", "wakeup";
+
+			regulators {
+				compatible = "qcom,rpm-pm8921-regulators";
+			};
+		};
+
 		acc0: clock-controller at 2088000 {
 			compatible = "qcom,kpss-acc-v1";
 			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
