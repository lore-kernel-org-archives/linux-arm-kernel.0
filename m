From: agross@codeaurora.org (Andy Gross)
Date: Wed, 23 Sep 2015 11:53:20 -0500
Subject: [Patch v2 01/10] soc: qcom: documentation: Update SMD/RPM Docs
In-Reply-To: <1443027209-19444-1-git-send-email-agross@codeaurora.org>
References: <1443027209-19444-1-git-send-email-agross@codeaurora.org>
Message-ID: <1443027209-19444-2-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the qcom,smd-rpm.txt to the correct location and splits
out the smd and rpm documentation.  In addition, a smd-rpm-regulator
document is added.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 .../devicetree/bindings/soc/qcom,smd-rpm.txt       |  117 --------------------
 .../bindings/soc/qcom/qcom,smd-rpm-regulator.txt   |  103 +++++++++++++++++
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.txt  |   55 +++++++++
 3 files changed, 158 insertions(+), 117 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/qcom,smd-rpm.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt

diff --git a/Documentation/devicetree/bindings/soc/qcom,smd-rpm.txt b/Documentation/devicetree/bindings/soc/qcom,smd-rpm.txt
deleted file mode 100644
index e27f5c4..0000000
--- a/Documentation/devicetree/bindings/soc/qcom,smd-rpm.txt
+++ /dev/null
@@ -1,117 +0,0 @@
-Qualcomm Resource Power Manager (RPM) over SMD
-
-This driver is used to interface with the Resource Power Manager (RPM) found in
-various Qualcomm platforms. The RPM allows each component in the system to vote
-for state of the system resources, such as clocks, regulators and bus
-frequencies.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-		    "qcom,rpm-msm8974"
-
-- qcom,smd-channels:
-	Usage: required
-	Value type: <stringlist>
-	Definition: Shared Memory channel used for communication with the RPM
-
-= SUBDEVICES
-
-The RPM exposes resources to its subnodes. The below bindings specify the set
-of valid subnodes that can operate on these resources.
-
-== Regulators
-
-Regulator nodes are identified by their compatible:
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-		    "qcom,rpm-pm8841-regulators"
-		    "qcom,rpm-pm8941-regulators"
-
-- vdd_s1-supply:
-- vdd_s2-supply:
-- vdd_s3-supply:
-- vdd_s4-supply:
-- vdd_s5-supply:
-- vdd_s6-supply:
-- vdd_s7-supply:
-- vdd_s8-supply:
-	Usage: optional (pm8841 only)
-	Value type: <phandle>
-	Definition: reference to regulator supplying the input pin, as
-		    described in the data sheet
-
-- vdd_s1-supply:
-- vdd_s2-supply:
-- vdd_s3-supply:
-- vdd_l1_l3-supply:
-- vdd_l2_lvs1_2_3-supply:
-- vdd_l4_l11-supply:
-- vdd_l5_l7-supply:
-- vdd_l6_l12_l14_l15-supply:
-- vdd_l8_l16_l18_l19-supply:
-- vdd_l9_l10_l17_l22-supply:
-- vdd_l13_l20_l23_l24-supply:
-- vdd_l21-supply:
-- vin_5vs-supply:
-	Usage: optional (pm8941 only)
-	Value type: <phandle>
-	Definition: reference to regulator supplying the input pin, as
-		    described in the data sheet
-
-The regulator node houses sub-nodes for each regulator within the device. Each
-sub-node is identified using the node's name, with valid values listed for each
-of the pmics below.
-
-pm8841:
-	s1, s2, s3, s4, s5, s6, s7, s8
-
-pm8941:
-	s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13,
-	l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24, lvs1, lvs2,
-	lvs3, 5vs1, 5vs2
-
-The content of each sub-node is defined by the standard binding for regulators -
-see regulator.txt.
-
-= EXAMPLE
-
-	smd {
-		compatible = "qcom,smd";
-
-		rpm {
-			interrupts = <0 168 1>;
-			qcom,ipc = <&apcs 8 0>;
-			qcom,smd-edge = <15>;
-
-			rpm_requests {
-				compatible = "qcom,rpm-msm8974";
-				qcom,smd-channels = "rpm_requests";
-
-				pm8941-regulators {
-					compatible = "qcom,rpm-pm8941-regulators";
-					vdd_l13_l20_l23_l24-supply = <&pm8941_boost>;
-
-					pm8941_s3: s3 {
-						regulator-min-microvolt = <1800000>;
-						regulator-max-microvolt = <1800000>;
-					};
-
-					pm8941_boost: s4 {
-						regulator-min-microvolt = <5000000>;
-						regulator-max-microvolt = <5000000>;
-					};
-
-					pm8941_l20: l20 {
-						regulator-min-microvolt = <2950000>;
-						regulator-max-microvolt = <2950000>;
-					};
-				};
-			};
-		};
-	};
-
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt
new file mode 100644
index 0000000..7084474
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt
@@ -0,0 +1,103 @@
+QCOM SMD RPM REGULATOR
+
+The Qualcomm RPM over SMD regulator is modelled as a subdevice of the RPM.
+Because SMD is used as the communication transport mechanism, the RPM resides as
+a subnode of the SMD.  As such, the SMD-RPM regulator requires that the SMD and
+RPM nodes be present.
+
+Please refer to the qcom,smd.txt for information pertaining to the SMD node.
+Please refer to the qcom,smd-rpm.txt for information regarding the RPM node.
+
+== Regulator
+
+Regulator nodes are identified by their compatible:
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be one of:
+		    "qcom,rpm-pm8841-regulators"
+		    "qcom,rpm-pm8941-regulators"
+
+- vdd_s1-supply:
+- vdd_s2-supply:
+- vdd_s3-supply:
+- vdd_s4-supply:
+- vdd_s5-supply:
+- vdd_s6-supply:
+- vdd_s7-supply:
+- vdd_s8-supply:
+	Usage: optional (pm8841 only)
+	Value type: <phandle>
+	Definition: reference to regulator supplying the input pin, as
+		    described in the data sheet
+
+- vdd_s1-supply:
+- vdd_s2-supply:
+- vdd_s3-supply:
+- vdd_l1_l3-supply:
+- vdd_l2_lvs1_2_3-supply:
+- vdd_l4_l11-supply:
+- vdd_l5_l7-supply:
+- vdd_l6_l12_l14_l15-supply:
+- vdd_l8_l16_l18_l19-supply:
+- vdd_l9_l10_l17_l22-supply:
+- vdd_l13_l20_l23_l24-supply:
+- vdd_l21-supply:
+- vin_5vs-supply:
+	Usage: optional (pm8941 only)
+	Value type: <phandle>
+	Definition: reference to regulator supplying the input pin, as
+		    described in the data sheet
+
+The regulator node houses sub-nodes for each regulator within the device. Each
+sub-node is identified using the node's name, with valid values listed for each
+of the pmics below.
+
+pm8841:
+	s1, s2, s3, s4, s5, s6, s7, s8
+
+pm8941:
+	s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13,
+	l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24, lvs1, lvs2,
+	lvs3, 5vs1, 5vs2
+
+The content of each sub-node is defined by the standard binding for regulators -
+see regulator.txt.
+
+= EXAMPLE
+
+	smd {
+		compatible = "qcom,smd";
+
+		rpm {
+			interrupts = <0 168 1>;
+			qcom,ipc = <&apcs 8 0>;
+			qcom,smd-edge = <15>;
+
+			rpm_requests {
+				compatible = "qcom,rpm-msm8974";
+				qcom,smd-channels = "rpm_requests";
+
+				pm8941-regulators {
+					compatible = "qcom,rpm-pm8941-regulators";
+					vdd_l13_l20_l23_l24-supply = <&pm8941_boost>;
+
+					pm8941_s3: s3 {
+						regulator-min-microvolt = <1800000>;
+						regulator-max-microvolt = <1800000>;
+					};
+
+					pm8941_boost: s4 {
+						regulator-min-microvolt = <5000000>;
+						regulator-max-microvolt = <5000000>;
+					};
+
+					pm8941_l20: l20 {
+						regulator-min-microvolt = <2950000>;
+						regulator-max-microvolt = <2950000>;
+					};
+				};
+			};
+		};
+	};
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
new file mode 100644
index 0000000..3710dd5
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
@@ -0,0 +1,55 @@
+Qualcomm Resource Power Manager (RPM) over SMD
+
+This driver is used to interface with the Resource Power Manager (RPM) found in
+various Qualcomm platforms. The RPM allows each component in the system to vote
+for state of the system resources, such as clocks, regulators and bus
+frequencies.
+
+The SMD information for the RPM edge should be filled out.  See qcom,smd.txt for
+the required edge properties.  All SMD related properties will reside within the
+RPM node itself.
+
+= SUBDEVICES
+
+The RPM exposes resources to its subnodes.  The rpm_requests node must be
+present and this subnode may contain children that designate regulator
+resources.
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be one of:
+		    "qcom,rpm-msm8974"
+
+- qcom,smd-channels:
+	Usage: required
+	Value type: <string>
+	Definition: must be "rpm_requests"
+
+Please refer to qcom,smd-rpm-regulator.txt for information on the regulator
+subnodes that can exist under the rpm_requests.
+
+Example:
+
+       apcs: syscon at f9011000 {
+                compatible = "syscon";
+                reg = <0xf9011000 0x1000>;
+        };
+
+        smd {
+                compatible = "qcom,smd";
+
+                rpm {
+                        interrupts = <0 168 1>;
+                        qcom,ipc = <&apcs 8 0>;
+                        qcom,smd-edge = <15>;
+
+                        rpm_requests {
+                                compatible = "qcom,rpm-msm8974";
+                                qcom,smd-channels = "rpm_requests";
+
+                                ...
+                        };
+                };
+        };
+
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
