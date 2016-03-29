From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 28 Mar 2016 20:36:57 -0700
Subject: [PATCH v2 1/9] dt-binding: remoteproc: Introduce Qualcomm WCNSS
 loader binding
In-Reply-To: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
References: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1459222625-11440-2-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@sonymobile.com>

The document defines the binding for a component that loads firmware for
and boots the Qualcomm WCNSS core.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Dropped non-variable properties (crash reason, firmware name)
- Split wcnss and iris definitions into separate nodes
- Dropped qcom, prefix of regulator supplies (standard binding)
- Interrupts and stop-state is made optional to support 8064

 .../bindings/remoteproc/qcom,wcnss-pil.txt         | 117 +++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt
new file mode 100644
index 000000000000..e317731ec0c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt
@@ -0,0 +1,117 @@
+Qualcomm WCNSS Peripheral Image Loader
+
+This document defines the binding for a component that loads and boots firmware
+on the Qualcomm WCNSS core.
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be one of:
+		    "qcom,riva-pil",
+		    "qcom,pronto-v1-pil",
+		    "qcom,pronto-v2-pil"
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: base address and size of riva/pronto PMU registers
+
+- interrupts-extended:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: must list the watchdog and fatal IRQs and may specify the
+		    ready, handover and stop-ack IRQs
+
+- interrupt-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: should be "wdog", "fatal", optionally followed by "ready",
+		    "handover", "stop-ack"
+
+- vddmx-supply:
+- vddcx-supply:
+- vddpx-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to the regulators to be held on behalf of the
+		    booting of the WCNSS core
+
+- qcom,state:
+	Usage: optional
+	Value type: <prop-encoded-array>
+	Definition: reference to the SMEM state used to indicate to WCNSS that
+		    it should shut down
+
+- qcom,state-names:
+	Usage: optional
+	Value type: <stringlist>
+	Definition: should be "stop"
+
+= SUBNODES
+A single subnode of the WCNSS PIL describes the attached rf module and its
+resource dependencies.
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be one of:
+		    "qcom,wcn3620",
+		    "qcom,wcn3660",
+		    "qcom,wcn3680"
+
+- clocks:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: should specify the xo clock and optionally the rf clock
+
+- clock-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: should be "xo", optionally followed by "rf"
+
+- vddxo-supply:
+- vddrfa-supply:
+- vddpa-supply:
+- vdddig-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to the regulators to be held on behalf of the
+		    booting of the WCNSS core
+
+= EXAMPLE
+The following example describes the resources needed to boot control the WCNSS,
+with attached WCN3680, as it is commonly found on MSM8974 boards.
+
+pronto at fb21b000 {
+	compatible = "qcom,pronto-v2-pil";
+	reg = <0xfb21b000 0x3000>;
+
+	interrupts-extended = <&intc 0 149 1>,
+			      <&wcnss_smp2p_slave 0 0>,
+			      <&wcnss_smp2p_slave 1 0>,
+			      <&wcnss_smp2p_slave 2 0>,
+			      <&wcnss_smp2p_slave 3 0>;
+	interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
+
+	vddmx-supply = <&pm8841_s1>;
+	vddcx-supply = <&pm8841_s2>;
+	vddpx-supply = <&pm8941_s3>;
+
+	qcom,state = <&wcnss_smp2p_out 0>;
+	qcom,state-names = "stop";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&wcnss_pin_a>;
+
+	iris {
+		compatible = "qcom,wcn3680";
+
+		clocks = <&rpmcc RPM_CXO_CLK_SRC>, <&rpmcc RPM_CXO_A2>;
+		clock-names = "xo", "rf";
+
+		vddxo-supply = <&pm8941_l6>;
+		vddrfa-supply = <&pm8941_l11>;
+		vddpa-supply = <&pm8941_l19>;
+		vdddig-supply = <&pm8941_s3>;
+	};
+};
-- 
2.5.0
