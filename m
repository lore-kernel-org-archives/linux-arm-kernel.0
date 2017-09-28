From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 28 Sep 2017 15:07:27 +0200
Subject: [RFC PATCH 1/4] dt-bindings: add bindings for USB physical connector
In-Reply-To: <20170928130730.8747-1-a.hajda@samsung.com>
References: <20170928130730.8747-1-a.hajda@samsung.com>
 <CGME20170928130735eucas1p1da4f062b6948350289bba9c8bc911dd7@eucas1p1.samsung.com>
Message-ID: <20170928130730.8747-2-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These bindings allows to describe most known standard USB connectors
and it should be possible to extend it if necessary.
USB connectors, beside USB can be used to route other protocols,
for example UART, Audio, MHL. In such case every device passing data
through the connector should have appropriate graph bindings.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
There are few things for discussion (IMO):
1. vendor specific connectors, I have added them here, but maybe better is
   to place them in separate files.
2. physical connector description - I have split it to three properties:
   type(a,b,ab,c), max-mode(ls,fs,hs,ss,ss+), size(mini,micro,powered).
   This tripled is able to describe all USB-standard connectors, but there
   are also impossible combinations, for example(c, *, micro). Maybe better
   would be to just enumerate all possible connectors in include file.
3. Numbering of port/remote nodes, currently only 0 is assigned for Interface
   Controller. Maybe other functions should be also assigned:
   HS, SS, CC, SBU, ... whatever. Maybe functions should be described
   as an additional property of remote node?
...

Regards
Andrzej
---
 .../bindings/connector/usb-connector.txt           | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
new file mode 100644
index 000000000000..f3a4e85122d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
@@ -0,0 +1,49 @@
+USB Connector
+=============
+
+Required properties:
+- compatible: "usb-connector"
+  connectors with vendor specific extensions can add one of additional
+  compatibles:
+    "samsung,usb-connector-11pin": 11-pin Samsung micro-USB connector
+- type: the USB connector type: "a", "b", "ab", "c"
+- max-mode: max USB speed mode supported by the connector:
+  "ls", "fs", "hs", "ss", "ss+"
+
+Optional properties:
+- label: a symbolic name for the connector
+- size: size of the connector, should be specified in case of
+  non-standard USB connectors: "mini", "micro", "powered"
+
+Required nodes:
+- any data bus to the connector should be modeled using the
+  OF graph bindings specified in bindings/graph.txt.
+  There should be exactly one port with at least one endpoint to
+  different device nodes. The first endpoint (reg = <0>) should
+  point to USB Interface Controller.
+
+Example
+-------
+
+musb_con: connector {
+	compatible = "samsung,usb-connector-11pin", "usb-connector";
+	label = "usb";
+	type = "b";
+	size = "micro";
+	max-mode = "hs";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		musb_con_usb_in: endpoint at 0 {
+			reg = <0>;
+			remote-endpoint = <&muic_usb_out>;
+		};
+
+		musb_con_mhl_in: endpoint at 1 {
+			reg = <1>;
+			remote-endpoint = <&mhl_out>;
+		};
+	};
+};
-- 
2.14.1
