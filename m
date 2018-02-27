From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 27 Feb 2018 08:11:30 +0100
Subject: [PATCH v5 2/6] dt-bindings: add bindings for Samsung micro-USB
 11-pin connector
In-Reply-To: <20180227071134.28063-1-a.hajda@samsung.com>
References: <20180227071134.28063-1-a.hajda@samsung.com>
 <CGME20180227071139eucas1p125ee35ada221fbed1dc85b7fc250f9ca@eucas1p1.samsung.com>
Message-ID: <20180227071134.28063-3-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samsung micro-USB 11-pin connector beside standard micro-USB pins,
has pins dedicated to route MHL traffic.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v4:
- removed description of property inherited from usb-connector (Rob),
- fixed example description.
---
 .../connector/samsung,usb-connector-11pin.txt      | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt

diff --git a/Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt b/Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
new file mode 100644
index 000000000000..22256e295a7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
@@ -0,0 +1,49 @@
+Samsung micro-USB 11-pin connector
+==================================
+
+Samsung micro-USB 11-pin connector is an extension of micro-USB connector.
+It is present in multiple Samsung mobile devices.
+It has additional pins to route MHL traffic simultanously with USB.
+
+The bindings are superset of usb-connector bindings for micro-USB connector[1].
+
+Required properties:
+- compatible: must be: "samsung,usb-connector-11pin", "usb-b-connector",
+- type: must be "micro".
+
+Required nodes:
+- any data bus to the connector should be modeled using the OF graph bindings
+  specified in bindings/graph.txt, unless the bus is between parent node and
+  the connector. Since single connector can have multpile data buses every bus
+  has assigned OF graph port number as follows:
+    0: High Speed (HS),
+    3: Mobile High-Definition Link (MHL), specific to 11-pin Samsung micro-USB.
+
+[1]: bindings/connector/usb-connector.txt
+
+Example
+-------
+
+Micro-USB connector with HS lines routed via controller (MUIC) and MHL lines
+connected to HDMI-MHL bridge (sii8620):
+
+muic-max77843 at 66 {
+	...
+	usb_con: connector {
+		compatible = "samsung,usb-connector-11pin", "usb-b-connector";
+		label = "micro-USB";
+		type = "micro";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 3 {
+				reg = <3>;
+				usb_con_mhl: endpoint {
+					remote-endpoint = <&sii8620_mhl>;
+				};
+			};
+		};
+	};
+};
-- 
2.16.2
