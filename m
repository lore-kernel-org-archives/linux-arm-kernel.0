From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  4 Apr 2014 11:45:36 -0700
Subject: [PATCH 4/4] devicetree: bindings: qcom,mmcc: Document GDSC binding
In-Reply-To: <1396637136-29974-1-git-send-email-sboyd@codeaurora.org>
References: <1396637136-29974-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1396637136-29974-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the GDSC nodes present within the multimedia clock
controller.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,mmcc.txt        | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,mmcc.txt b/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
index d572e9964c54..695f86ad94ea 100644
--- a/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,mmcc.txt
@@ -19,3 +19,45 @@ Example:
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 	};
+
+Qualcomm Global Distributed Switch Controller (GDSC) Binding
+------------------------------------------------------------
+
+The GDSC is responsible for safely collapsing and restoring power to
+peripheral cores on chipsets like msm8974 for power savings.
+
+Required properties:
+ - regulator-name:  A string used as a descriptive name for regulator outputs
+
+Optional properties:
+ - parent-supply:   phandle to the parent supply/regulator node
+ - qcom,retain-mem:  Presence denotes a hardware requirement to leave the
+		     forced core memory retention signals in the core's clock
+		     branch control registers asserted.
+ - qcom,retain-periph: Presence denotes a hardware requirement to leave the
+		     forced periph memory retention signal in the core's clock
+		     branch control registers asserted.
+ - qcom,skip-logic-collapse: Presence denotes a requirement to leave power to
+                             the core's logic enabled.
+ - qcom,support-hw-trigger: Presence denotes a hardware feature to switch
+			    on/off this regulator based on internal HW signals
+			    to save more power.
+
+Example:
+	clock-controller at 4000000 {
+		compatible = "qcom,mmcc-msm8974";
+		reg = <0x4000000 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+
+		regulators {
+			gdsc_oxili_gx: gdsc_oxili_gx {
+				regulator-name = "gdsc_oxili_gx";
+				parent-supply = <&pm8841_s4>;
+				qcom,retain-mem;
+				qcom,retain-periph;
+				qcom,skip-logic-collapse;
+				qcom,support-hw-trigger;
+			};
+		};
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
