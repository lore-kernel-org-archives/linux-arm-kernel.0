From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 28 Feb 2017 17:51:14 +0100
Subject: [PATCH v3 1/6] dt-bindings: iio: introduce trigger providers,
 consumers
In-Reply-To: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com>
References: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1488300679-3259-2-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document iio provider and consumer bindings.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 .../devicetree/bindings/iio/iio-bindings.txt       | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
index 68d6f8c..01765e9 100644
--- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
+++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
@@ -95,3 +95,41 @@ vdd channel is connected to output 0 of the &ref device.
 		io-channels = <&adc 10>, <&adc 11>;
 		io-channel-names = "adc1", "adc2";
 	};
+
+==IIO trigger providers==
+Sources of IIO triggers can be represented by any node in the device
+tree. Those nodes are designated as IIO trigger providers. IIO trigger
+consumer uses a phandle and an IIO trigger specifier to connect to an
+IIO trigger provider.
+An IIO trigger specifier is an array of one or more cells identifying
+the IIO trigger output on a device. The length of an IIO trigger
+specifier is defined by the value of a #io-trigger-cells property in
+the IIO trigger provider node.
+
+Required properties:
+#io-trigger-cells:
+		Number of cells in an IIO trigger specifier; Typically
+		0 for nodes with a simple IIO trigger output.
+
+Example:
+	trig0: interrupt-trigger0 {
+		#io-trigger-cells = <0>;
+		compatible = "interrupt-trigger";
+		interrupts = <11 0>;
+		interrupt-parent = <&gpioa>;
+	}
+
+==IIO trigger consumers==
+Required properties:
+- io-triggers:	List of phandle representing the IIO trigger specifier.
+
+Optional properties:
+- io-trigger-names :
+		List of IIO trigger name strings that matches elements
+		in 'io-triggers' list property.
+
+Example:
+	some_trigger_consumer {
+		io-triggers = <&trig0>;
+		io-trigger-names = "mytrig";
+	}
-- 
1.9.1
