From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 15 Feb 2018 11:39:16 +0100
Subject: [RFC PATCH v2 2/6] dt-bindings: add bindings for Samsung micro-USB
 11-pin connector
In-Reply-To: <20180215103920.32017-1-a.hajda@samsung.com>
References: <20180215103920.32017-1-a.hajda@samsung.com>
 <CGME20180215103926eucas1p2f13dcf5aa4e102e7f0145c976a60bc72@eucas1p2.samsung.com>
Message-ID: <20180215103920.32017-3-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samsung micro-USB 11-pin connector beside standard micro-USB pins,
has pins dedicated to route MHL traffic.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 .../connector/samsung,usb-connector-11pin.txt      | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt

diff --git a/Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt b/Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
new file mode 100644
index 000000000000..c8ef1ad6732f
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
@@ -0,0 +1,51 @@
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
+Optional properties:
+- label: symbolic name for the connector.
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
+Micro-USB connector with HS lines routed via controller (MUIC) and :
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
2.16.1
