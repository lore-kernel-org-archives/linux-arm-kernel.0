From: songjun.wu@atmel.com (Songjun Wu)
Date: Tue, 31 May 2016 14:58:23 +0800
Subject: [PATCH v3 2/2] [media] atmel-isc: DT binding for Image Sensor
 Controller driver
In-Reply-To: <1464677903-28412-1-git-send-email-songjun.wu@atmel.com>
References: <1464677903-28412-1-git-send-email-songjun.wu@atmel.com>
Message-ID: <1464677903-28412-3-git-send-email-songjun.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT binding documentation for ISC driver.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
---

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

 .../devicetree/bindings/media/atmel-isc.txt        | 88 ++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/atmel-isc.txt

diff --git a/Documentation/devicetree/bindings/media/atmel-isc.txt b/Documentation/devicetree/bindings/media/atmel-isc.txt
new file mode 100644
index 0000000..2ae1d60
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/atmel-isc.txt
@@ -0,0 +1,88 @@
+Atmel Image Sensor Controller (ISC)
+----------------------------------------------
+
+Required properties for ISC:
+- compatible
+	Must be "atmel,sama5d2-isc"
+- reg
+	Physical base address and length of the registers set for the device;
+- interrupts
+	Should contain IRQ line for the ISI;
+- clocks
+	List of clock specifiers, corresponding to entries in
+	the clock-names property;
+	Please refer to clock-bindings.txt.
+- clock-names
+	Required elements: "hclock", "ispck".
+- pinctrl-names, pinctrl-0
+	Please refer to pinctrl-bindings.txt.
+- isc-ispck
+	The clock for the ISC digital pipeline.
+	- compatible
+		Must be "atmel,sama5d2-isc-ispck".
+	- clock-cells
+		From common clock binding; should be set to 0.
+	- clocks
+		The clock source phandles.
+- isc-mck
+	The clock for the image sensor.
+	- compatible
+		Must be "atmel,sama5d2-isc-mck".
+	- clock-cells
+		From common clock binding; should be set to 0.
+	- clocks
+		The clock source phandles.
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
+	clocks = <&isc_clk>, <&isc_ispck>;
+	clock-names = "hclock", "ispck";
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
+	isc_ispck: isc-ispck at 0 {
+		compatible = "atmel,sama5d2-isc-ispck";
+		#clock-cells = <0>;
+		clocks = <&isc_clk>, <&iscck>;
+	};
+
+	isc_mck: isc-mck at 1 {
+		compatible = "atmel,sama5d2-isc-mck";
+		#clock-cells = <0>;
+		clocks = <&isc_clk>, <&iscck>, <&isc_gclk>;
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
