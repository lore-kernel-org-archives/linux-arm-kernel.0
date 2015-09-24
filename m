From: agross@codeaurora.org (Andy Gross)
Date: Thu, 24 Sep 2015 14:18:50 -0500
Subject: [Patch v3 01/10] soc: qcom: documentation: Update SMD/RPM Docs
In-Reply-To: <1443122339-13917-1-git-send-email-agross@codeaurora.org>
References: <1443122339-13917-1-git-send-email-agross@codeaurora.org>
Message-ID: <1443122339-13917-2-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the qcom,smd-rpm.txt to the correct location and splits
out the smd and rpm documentation.  In addition, a smd-rpm-regulator
document is added.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 .../qcom,smd-rpm-regulator.txt}                    |   30 +++--------
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.txt  |   57 ++++++++++++++++++++
 2 files changed, 65 insertions(+), 22 deletions(-)
 rename Documentation/devicetree/bindings/soc/{qcom,smd-rpm.txt => qcom/qcom,smd-rpm-regulator.txt} (75%)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt

diff --git a/Documentation/devicetree/bindings/soc/qcom,smd-rpm.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt
similarity index 75%
rename from Documentation/devicetree/bindings/soc/qcom,smd-rpm.txt
rename to Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt
index e27f5c4..7084474 100644
--- a/Documentation/devicetree/bindings/soc/qcom,smd-rpm.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt
@@ -1,27 +1,14 @@
-Qualcomm Resource Power Manager (RPM) over SMD
+QCOM SMD RPM REGULATOR
 
-This driver is used to interface with the Resource Power Manager (RPM) found in
-various Qualcomm platforms. The RPM allows each component in the system to vote
-for state of the system resources, such as clocks, regulators and bus
-frequencies.
+The Qualcomm RPM over SMD regulator is modelled as a subdevice of the RPM.
+Because SMD is used as the communication transport mechanism, the RPM resides as
+a subnode of the SMD.  As such, the SMD-RPM regulator requires that the SMD and
+RPM nodes be present.
 
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-		    "qcom,rpm-msm8974"
+Please refer to the qcom,smd.txt for information pertaining to the SMD node.
+Please refer to the qcom,smd-rpm.txt for information regarding the RPM node.
 
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
+== Regulator
 
 Regulator nodes are identified by their compatible:
 
@@ -114,4 +101,3 @@ see regulator.txt.
 			};
 		};
 	};
-
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
new file mode 100644
index 0000000..003bedd
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
@@ -0,0 +1,57 @@
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
+	soc {
+		apcs: syscon at f9011000 {
+			compatible = "syscon";
+			reg = <0xf9011000 0x1000>;
+		};
+	};
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
+				...
+			};
+		};
+	};
+
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
