From: m.purski@samsung.com (Maciej Purski)
Date: Mon, 28 May 2018 11:47:11 +0200
Subject: [PATCH 07/12] dt-bindings: tc358754: add DT bindings
In-Reply-To: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
References: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
 <CGME20180528094727eucas1p153b8116120cd2195b15b74776f171cbe@eucas1p1.samsung.com>
Message-ID: <1527500833-16005-8-git-send-email-m.purski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds bindings to Toshiba DSI/LVDS bridge TC358764.
Bindings describe power supplies, reset gpio and video interfaces.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 .../bindings/display/bridge/toshiba,tc358764.txt   | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
new file mode 100644
index 0000000..d09bdc2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
@@ -0,0 +1,42 @@
+TC358764 MIPI-DSI to LVDS panel bridge
+
+Required properties:
+  - compatible: "toshiba,tc358764"
+  - reg: the virtual channel number of a DSI peripheral
+  - vddc-supply: core voltage supply
+  - vddio-supply: I/O voltage supply
+  - vddmipi-supply: MIPI voltage supply
+  - vddlvds133-supply: LVDS1 3.3V voltage supply
+  - vddlvds112-supply: LVDS1 1.2V voltage supply
+  - reset-gpios: a GPIO spec for the reset pin
+
+The device node can contain zero to two 'port' child nodes, each with one
+child
+'endpoint' node, according to the bindings defined in [1].
+The following are properties specific to those nodes.
+
+port:
+  - reg: (required) can be 0 for DSI port or 1 for LVDS port;
+
+[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
+
+Example:
+
+	bridge at 0 {
+		reg = <0>;
+		compatible = "toshiba,tc358764";
+		vddc-supply = <&vcc_1v2_reg>;
+		vddio-supply = <&vcc_1v8_reg>;
+		vddmipi-supply = <&vcc_1v2_reg>;
+		vddlvds133-supply = <&vcc_3v3_reg>;
+		vddlvds112-supply = <&vcc_1v2_reg>;
+		reset-gpios = <&gpd1 6 GPIO_ACTIVE_LOW>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		port at 1 {
+			reg = <1>;
+			lvds_ep: endpoint {
+				remote-endpoint = <&panel_ep>;
+			};
+		};
+	};
-- 
2.7.4
