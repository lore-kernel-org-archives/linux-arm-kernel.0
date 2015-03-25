From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed, 25 Mar 2015 14:25:27 -0600
Subject: [PATCH v18 02/11] devicetree: bindings: Update qcom,
 saw2 node bindings
In-Reply-To: <1427315136-44321-1-git-send-email-lina.iyer@linaro.org>
References: <1427315136-44321-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1427315136-44321-3-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update qcom,saw2 node bindings with compatible strings to identify nodes
that provides cpuidle functionality for a particular SoC. Remove
unused compatible strings.

Update examples for different SAW nodes.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 .../devicetree/bindings/arm/msm/qcom,saw2.txt      | 40 +++++++++++++++++-----
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
index 1505fb8..ae4afc6 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
@@ -2,22 +2,31 @@ SPM AVS Wrapper 2 (SAW2)
 
 The SAW2 is a wrapper around the Subsystem Power Manager (SPM) and the
 Adaptive Voltage Scaling (AVS) hardware. The SPM is a programmable
-micro-controller that transitions a piece of hardware (like a processor or
+power-controller that transitions a piece of hardware (like a processor or
 subsystem) into and out of low power modes via a direct connection to
 the PMIC. It can also be wired up to interact with other processors in the
 system, notifying them when a low power state is entered or exited.
 
+Multiple revisions of the SAW hardware are supported using these Device Nodes.
+SAW2 revisions differ in the register offset and configuration data. Also, the
+same revision of the SAW in different SoCs may have different configuration
+data due the the differences in hardware capabilities. Hence the SoC name, the
+version of the SAW hardware in that SoC and the distinction between cpu (big
+or Little) or cache, may be needed to uniquely identify the SAW register
+configuration and initialization data. The compatible string is used to
+indicate this parameter.
+
 PROPERTIES
 
 - compatible:
 	Usage: required
 	Value type: <string>
-	Definition: shall contain "qcom,saw2". A more specific value should be
-		    one of:
-			 "qcom,saw2-v1"
-			 "qcom,saw2-v1.1"
-			 "qcom,saw2-v2"
-			 "qcom,saw2-v2.1"
+	Definition: Must have
+			"qcom,saw2"
+		    A more specific value could be one of:
+			"qcom,apq8064-saw2-v1.1-cpu"
+			"qcom,msm8974-saw2-v2.1-cpu"
+			"qcom,apq8084-saw2-v2.1-cpu"
 
 - reg:
 	Usage: required
@@ -26,10 +35,23 @@ PROPERTIES
 		    the register region. An optional second element specifies
 		    the base address and size of the alias register region.
 
+- regulator:
+	Usage: optional
+	Value type: boolean
+	Definition: Indicates that this SPM device acts as a regulator device
+			device for the core (CPU or Cache) the SPM is attached
+			to.
 
-Example:
+Example 1:
 
-	regulator at 2099000 {
+	power-controller at 2099000 {
 		compatible = "qcom,saw2";
 		reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
+		regulator;
+	};
+
+Example 2:
+	saw0: power-controller at f9089000 {
+		compatible = "qcom,apq8084-saw2-v2.1-cpu", "qcom,saw2";
+		reg = <0xf9089000 0x1000>, <0xf9009000 0x1000>;
 	};
-- 
2.1.0
