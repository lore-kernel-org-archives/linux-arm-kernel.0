From: elder@linaro.org (Alex Elder)
Date: Tue,  6 Nov 2018 18:32:39 -0600
Subject: [RFC PATCH 01/12] dt-bindings: soc: qcom: add IPA bindings
In-Reply-To: <20181107003250.5832-1-elder@linaro.org>
References: <20181107003250.5832-1-elder@linaro.org>
Message-ID: <20181107003250.5832-2-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the binding definitions for the "qcom,ipa" and "qcom,rmnet-ipa"
device tree nodes.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 .../devicetree/bindings/soc/qcom/qcom,ipa.txt | 136 ++++++++++++++++++
 .../bindings/soc/qcom/qcom,rmnet-ipa.txt      |  15 ++
 2 files changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
new file mode 100644
index 000000000000..d4d3d37df029
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
@@ -0,0 +1,136 @@
+Qualcomm IPA (IP Accelerator) Driver
+
+This binding describes the Qualcomm IPA.  The IPA is capable of offloading
+certain network processing tasks (e.g. filtering, routing, and NAT) from
+the main processor.  The IPA currently serves only as a network interface,
+providing access to an LTE network available via a modem.
+
+The IPA sits between multiple independent "execution environments,"
+including the AP subsystem (APSS) and the modem.  The IPA presents
+a Generic Software Interface (GSI) to each execution environment.
+The GSI is an integral part of the IPA, but it is logically isolated
+and has a distinct interrupt and a separately-defined address space.
+
+    ----------   -------------   ---------
+    |        |   |G|       |G|   |       |
+    |  APSS  |===|S|  IPA  |S|===| Modem |
+    |        |   |I|       |I|   |       |
+    ----------   -------------   ---------
+
+See also:
+  bindings/interrupt-controller/interrupts.txt
+  bindings/interconnect/interconnect.txt
+  bindings/soc/qcom/qcom,smp2p.txt
+  bindings/reserved-memory/reserved-memory.txt
+  bindings/clock/clock-bindings.txt
+
+All properties defined below are required.
+
+- compatible:
+	Must be one of the following compatible strings:
+		"qcom,ipa-sdm845-modem_init"
+		"qcom,ipa-sdm845-tz_init"
+
+-reg:
+	Resources specyfing the physical address spaces of the IPA and GSI.
+
+-reg-names:
+	The names of the address space ranges defined by the "reg" property.
+	Must be "ipa" and "gsi".
+
+- interrupts-extended:
+	Specifies the IRQs used by the IPA.  Four cells are required,
+	specifying: the IPA IRQ; the GSI IRQ; the clock query interrupt
+	from the modem; and the "ready for stage 2 initialization"
+	interrupt from the modem.  The first two are hardware IRQs; the
+	third and fourth are SMP2P input interrupts.
+
+- interrupt-names:
+	The names of the interrupts defined by the "interrupts-extended"
+	property.  Must be "ipa", "gsi", "ipa-clock-query", and
+	"ipa-post-init".
+
+- clocks:
+	Resource that defines the IPA core clock.
+
+- clock-names:
+	The name used for the IPA core clock.  Must be "core".
+
+- interconnects:
+	Specifies the interconnects used by the IPA.  Three cells are
+	required, specifying:  the path from the IPA to memory; from
+	IPA to internal (SoC resident) memory; and between the AP
+	subsystem and IPA for register access.
+
+- interconnect-names:
+	The names of the interconnects defined by the "interconnects"
+	property.  Must be "memory", "imem", and "config".
+
+- qcom,smem-states
+	The state bits used for SMP2P output.  Two cells must be specified.
+	The first indicates whether the value in the second bit is valid
+	(1 means valid).  The second, if valid, defines whether the IPA
+	clock is enabled (1 means enabled).
+
+- qcom,smem-state-names
+	The names of the state bits used for SMP2P output.  These must be
+	"ipa-clock-enabled-valid" and "ipa-clock-enabled".
+
+- memory-region
+	A phandle for a reserved memory area that holds the firmware passed
+	to Trust Zone for authentication.  (Note, this is required
+	only for "qcom,ipa-sdm845-tz_init".)
+
+= EXAMPLE
+
+The following example represents the IPA present in the SDM845 SoC.  It
+shows portions of the "modem-smp2p" node to indicate its relationship
+with the interrupts and SMEM states used by the IPA.
+
+	modem-smp2p {
+		compatible = "qcom,smp2p";
+		. . .
+		ipa_smp2p_out: ipa-ap-to-modem {
+			qcom,entry-name = "ipa";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		ipa_smp2p_in: ipa-modem-to-ap {
+			qcom,entry-name = "ipa";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	ipa at 1e00000 {
+		compatible = "qcom,ipa-sdm845-modem_init";
+
+		reg = <0x1e40000 0x34000>,
+		      <0x1e04000 0x2c000>;
+		reg-names = "ipa",
+			    "gsi";
+
+		interrupts-extended = <&intc 0 311 IRQ_TYPE_LEVEL_HIGH>,
+				      <&intc 0 432 IRQ_TYPE_LEVEL_HIGH>,
+				      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "ipa",
+				  "gsi",
+				  "ipa-clock-query",
+				  "ipa-post-init";
+
+		clocks = <&rpmhcc RPMH_IPA_CLK>;
+		clock-names = "core";
+
+		interconnects = <&qnoc MASTER_IPA &qnoc SLAVE_EBI1>,
+			        <&qnoc MASTER_IPA &qnoc SLAVE_IMEM>,
+			        <&qnoc MASTER_APPSS_PROC &qnoc SLAVE_IPA_CFG>;
+		interconnect-names = "memory",
+				     "imem",
+				     "config";
+
+		qcom,smem-states = <&ipa_smp2p_out 0>,
+				   <&ipa_smp2p_out 1>;
+		qcom,smem-state-names = "ipa-clock-enabled-valid",
+					"ipa-clock-enabled";
+	};
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt
new file mode 100644
index 000000000000..3d0b2aabefc7
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt
@@ -0,0 +1,15 @@
+Qualcomm IPA RMNet Driver
+
+This binding describes the IPA RMNet driver, which is used to
+represent virtual interfaces available on the modem accessed via
+the IPA.  Other than the compatible string there are no properties
+associated with this device.
+
+- compatible:
+	Must be "qcom,rmnet-ipa".
+
+= EXAMPLE
+
+	qcom,rmnet-ipa {
+		compatible = "qcom,rmnet-ipa";
+	};
-- 
2.17.1
