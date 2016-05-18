From: songjun.wu@atmel.com (Songjun Wu)
Date: Wed, 18 May 2016 15:46:29 +0800
Subject: [PATCH v2 2/2] [media] atmel-isc: DT binding for Image Sensor
 Controller driver
In-Reply-To: <1463557590-29318-1-git-send-email-songjun.wu@atmel.com>
References: <1463557590-29318-1-git-send-email-songjun.wu@atmel.com>
Message-ID: <1463557590-29318-3-git-send-email-songjun.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT binding documentation for ISC driver.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
---

Changes in v2:
- Remove the unit address of the endpoint.
- Add the unit address to the clock node.
- Avoid using underscores in node names.
- Drop the "0x" in the unit address of the i2c node.
- Modify the description of "atmel,sensor-preferred".
- Add the description for the ISC internal clock.

 .../devicetree/bindings/media/atmel-isc.txt        | 100 +++++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/atmel-isc.txt

diff --git a/Documentation/devicetree/bindings/media/atmel-isc.txt b/Documentation/devicetree/bindings/media/atmel-isc.txt
new file mode 100644
index 0000000..9e65395
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/atmel-isc.txt
@@ -0,0 +1,100 @@
+Atmel Image Sensor Controller (ISC)
+----------------------------------------------
+
+Required properties for ISC:
+- compatible
+	Must be "atmel,sama5d2-isc"
+- reg
+	Physical base address and length of the registers set for the device;
+- interrupts
+	Should contain IRQ line for the ISC;
+- clocks
+	List of clock specifiers, corresponding to entries in
+	the clock-names property;
+	Please refer to clock-bindings.txt.
+- clock-names
+	Required elements: "hclock", "ispck".
+- pinctrl-names, pinctrl-0
+	Please refer to pinctrl-bindings.txt.
+- clk-in-isc
+	ISC internal clock node, it includes two clock nodes,
+	isc-ispck and isc-mck.
+- atmel,sensor-preferred
+	ISC may convert the raw format to the specified format when the sensor
+	outputs the raw format, and the sensor may output the specified format
+	directly. If sensor is preferred to output the specified format
+	directly, the value should be 1 (1-preferred, 0-not).
+	The default value is 1.
+
+ISC supports a single port node with parallel bus. It should contain one
+'port' child node with child 'endpoint' node. Please refer to the bindings
+defined in Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+Required properties for the ISC internal clocks:
+- #address-cells
+	should be 1 (reg is used to encode clk id).
+- #size-cells
+	should be 0 (reg is used to encode clk id).
+- name
+	device tree node describing a ISC internal clock.
+	* #clock-cells: from common clock binding; should be set to 0.
+	* reg: clock id, there are two values,
+	       <0> is ISP clock, <1> is master clock.
+	* clocks: shall be the isc internal clock source phandles.
+		  e.g. clocks = <&isc_clk>, <&iscck>, <&isc_gclk>;
+
+Example:
+isc: isc at f0008000 {
+	compatible = "atmel,sama5d2-isc";
+	reg = <0xf0008000 0x4000>;
+	interrupts = <46 IRQ_TYPE_LEVEL_HIGH 5>;
+	clocks = <&isc_clk>, <&isc_ispck>;
+	clock-names = "hclock", "ispck";
+	atmel,sensor-preferred = <1>;
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		isc_0: endpoint {
+			remote-endpoint = <&ov7740_0>;
+			hsync-active = <1>;
+			vsync-active = <0>;
+			pclk-sample = <1>;
+		};
+	};
+
+	clk-in-isc {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		isc_ispck: isc-ispck at 0 {
+			#clock-cells = <0>;
+			reg = <0>;
+			clocks = <&isc_clk>, <&iscck>;
+		};
+
+		isc_mck: isc-mck at 1 {
+			#clock-cells = <0>;
+			reg = <1>;
+			clocks = <&isc_clk>, <&iscck>, <&isc_gclk>;
+		};
+	};
+};
+
+i2c1: i2c at fc028000 {
+	ov7740: camera at 21 {
+	compatible = "ovti,ov7740";
+	reg = <0x21>;
+
+	clocks = <&isc_mck>;
+	clock-names = "xvclk";
+	assigned-clocks = <&isc_mck>;
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
