From: songjun.wu@atmel.com (Songjun Wu)
Date: Fri, 17 Jun 2016 16:57:14 +0800
Subject: [PATCH v5 2/2] [media] atmel-isc: DT binding for Image Sensor
 Controller driver
In-Reply-To: <1466153854-30272-1-git-send-email-songjun.wu@atmel.com>
References: <1466153854-30272-1-git-send-email-songjun.wu@atmel.com>
Message-ID: <1466153854-30272-3-git-send-email-songjun.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT binding documentation for ISC driver.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
---

Changes in v5:
- Add clock names.

Changes in v4:
- Remove the isc clock nodes.

Changes in v3:
- Remove the 'atmel,sensor-preferred'.
- Modify the isc clock node according to the Rob's remarks.

Changes in v2:
- Remove the unit address of the endpoint.
- Add the unit address to the clock node.
- Avoid using underscores in node names.
- Drop the "0x" in the unit address of the i2c node.
- Modify the description of 'atmel,sensor-preferred'.
- Add the description for the ISC internal clock.

 .../devicetree/bindings/media/atmel-isc.txt        | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/atmel-isc.txt

diff --git a/Documentation/devicetree/bindings/media/atmel-isc.txt b/Documentation/devicetree/bindings/media/atmel-isc.txt
new file mode 100644
index 0000000..9558a77
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/atmel-isc.txt
@@ -0,0 +1,64 @@
+Atmel Image Sensor Controller (ISC)
+----------------------------------------------
+
+Required properties for ISC:
+- compatible
+	Must be "atmel,sama5d2-isc".
+- reg
+	Physical base address and length of the registers set for the device.
+- interrupts
+	Should contain IRQ line for the ISC.
+- clocks
+	List of clock specifiers, corresponding to entries in
+	the clock-names property;
+	Please refer to clock-bindings.txt.
+- clock-names
+	Required elements: "hclock".
+- #clock-cells
+	Should be 0.
+- clock-output-names
+	Should contain the name of the clock driving the sensor master clock.
+- pinctrl-names, pinctrl-0
+	Please refer to pinctrl-bindings.txt.
+
+ISC supports a single port node with parallel bus. It should contain one
+'port' child node with child 'endpoint' node. Please refer to the bindings
+defined in Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+Example:
+isc: isc at f0008000 {
+	compatible = "atmel,sama5d2-isc";
+	reg = <0xf0008000 0x4000>;
+	interrupts = <46 IRQ_TYPE_LEVEL_HIGH 5>;
+	clocks = <&isc_clk>, <&iscck>, <&isc_gclk>;
+	clock-names = "hclock", "iscck", "gck";
+	#clock-cells = <0>;
+	clock-output-names = "isc-mck";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_isc_base &pinctrl_isc_data_8bit &pinctrl_isc_data_9_10 &pinctrl_isc_data_11_12>;
+
+	port {
+		isc_0: endpoint {
+			remote-endpoint = <&ov7740_0>;
+			hsync-active = <1>;
+			vsync-active = <0>;
+			pclk-sample = <1>;
+		};
+	};
+};
+
+i2c1: i2c at fc028000 {
+	ov7740: camera at 21 {
+	compatible = "ovti,ov7740";
+	reg = <0x21>;
+	clocks = <&isc>;
+	clock-names = "xvclk";
+	assigned-clocks = <&isc>;
+	assigned-clock-rates = <24000000>;
+
+	port {
+		ov7740_0: endpoint {
+			remote-endpoint = <&isc_0>;
+		};
+	};
+};
-- 
2.7.4
