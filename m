From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 21 Feb 2018 09:55:36 +0100
Subject: [PATCH v4 1/6] dt-bindings: add bindings for USB physical connector
In-Reply-To: <20180221085541.14556-1-a.hajda@samsung.com>
References: <20180221085541.14556-1-a.hajda@samsung.com>
 <CGME20180221085604eucas1p11aa066a1e106d9f9850731a5171dce8b@eucas1p1.samsung.com>
Message-ID: <20180221085541.14556-2-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These bindings allow to describe most known standard USB connectors
and it should be possible to extend it if necessary.
USB connectors, beside USB can be used to route other protocols,
for example UART, Audio, MHL. In such case every device passing data
through the connector should have appropriate graph bindings.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
v4:
- improved 'type' description (Rob),
- improved description of 2nd example (Rob).
v3:
- removed MHL port (samsung connector will have separate bindings),
- added 2nd example for USB-C,
- improved formatting.
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
---
 .../bindings/connector/usb-connector.txt           | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
new file mode 100644
index 000000000000..e1463f14af38
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
@@ -0,0 +1,75 @@
+USB Connector
+=============
+
+USB connector node represents physical USB connector. It should be
+a child of USB interface controller.
+
+Required properties:
+- compatible: describes type of the connector, must be one of:
+    "usb-a-connector",
+    "usb-b-connector",
+    "usb-c-connector".
+
+Optional properties:
+- label: symbolic name for the connector,
+- type: size of the connector, should be specified in case of USB-A, USB-B
+  non-fullsize connectors: "mini", "micro".
+
+Required nodes:
+- any data bus to the connector should be modeled using the OF graph bindings
+  specified in bindings/graph.txt, unless the bus is between parent node and
+  the connector. Since single connector can have multpile data buses every bus
+  has assigned OF graph port number as follows:
+    0: High Speed (HS), present in all connectors,
+    1: Super Speed (SS), present in SS capable connectors,
+    2: Sideband use (SBU), present in USB-C.
+
+Examples
+--------
+
+1. Micro-USB connector with HS lines routed via controller (MUIC):
+
+muic-max77843 at 66 {
+	...
+	usb_con: connector {
+		compatible = "usb-b-connector";
+		label = "micro-USB";
+		type = "micro";
+	};
+};
+
+2. USB-C connector attached to CC controller (s2mm005), HS lines routed
+to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort.
+DisplayPort video lines are routed to the connector via SS mux in USB3 PHY.
+
+ccic: s2mm005 at 33 {
+	...
+	usb_con: connector {
+		compatible = "usb-c-connector";
+		label = "USB-C";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				usb_con_hs: endpoint {
+					remote-endpoint = <&max77865_usbc_hs>;
+				};
+			};
+			port at 1 {
+				reg = <1>;
+				usb_con_ss: endpoint {
+					remote-endpoint = <&usbdrd_phy_ss>;
+				};
+			};
+			port at 2 {
+				reg = <2>;
+				usb_con_sbu: endpoint {
+					remote-endpoint = <&dp_aux>;
+				};
+			};
+		};
+	};
+};
-- 
2.16.1
