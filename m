From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 31 Jan 2018 14:44:31 +0100
Subject: [RFC PATCH v2 1/5] dt-bindings: add bindings for USB physical
 connector
In-Reply-To: <20180131134435.12216-1-a.hajda@samsung.com>
References: <20180131134435.12216-1-a.hajda@samsung.com>
 <CGME20180131134457eucas1p128394aef86e0d76cfc6ccb72ee22d4b1@eucas1p1.samsung.com>
Message-ID: <20180131134435.12216-2-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These bindings allow to describe most known standard USB connectors
and it should be possible to extend it if necessary.
USB connectors, beside USB can be used to route other protocols,
for example UART, Audio, MHL. In such case every device passing data
through the connector should have appropriate graph bindings.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
v2:
- moved connector type(A,B,C) to compatible string (Rob),
- renamed size property to type (Rob),
- changed type description to be less confusing (Laurent),
- removed vendor specific compatibles (implied by graph port number),
- added requirement of connector being a child of IC (Rob),
- removed max-mode (subtly suggested by Rob, it should be detected anyway
  by USB Controller in runtime, downside is that device is not able to
  report its real capabilities, maybe better would be to make it optional(?)),
- assigned port numbers to data buses (Rob).

Regards
Andrzej

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 .../bindings/connector/usb-connector.txt           | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
new file mode 100644
index 000000000000..02020f5d760a
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
@@ -0,0 +1,48 @@
+USB Connector
+=============
+
+USB connector node represents physical USB connector. It should be
+a child of USB interface controller.
+
+Required properties:
+- compatible: describes type of the connector, must be one of:
+    "usb-a-connector", "usb-b-connector", "usb-c-connector",
+
+Optional properties:
+- label: symbolic name for the connector
+- type: size of the connector, should be specified in case of USB-A, USB-B
+  non-standard (large) connector sizes: "mini", "micro"
+
+Required nodes:
+- any data bus to the connector should be modeled using the OF graph bindings
+  specified in bindings/graph.txt, unless the bus is between parent node and
+  the connector. Since single connector can have multpile data buses every bus
+  has assigned OF graph port number as follows:
+    0: High Speed (HS), present in all connectors,
+    1: Super Speed (SS), present in SS capable connectors,
+    2: Sideband use (SBU), present in USB-C,
+    3: Mobile High-Definition Link (MHL), present in 11-pin Samsung micro-USB
+
+Example
+-------
+
+muic_max77843 at 66 {
+	...
+	musb_con: connector {
+		compatible = "usb-b-connector";
+		label = "micro-USB";
+		type = "micro";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 3 {
+				reg = <3>;
+				musb_con_mhl_in: endpoint {
+					remote-endpoint = <&mhl_out>;
+				};
+			};
+		};
+	};
+};
-- 
2.15.1
