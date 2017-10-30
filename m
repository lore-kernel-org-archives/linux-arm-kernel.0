From: wenyou.yang@microchip.com (Wenyou Yang)
Date: Mon, 30 Oct 2017 09:44:31 +0800
Subject: [PATCH v3 2/3] media: ov7740: Document device tree bindings
In-Reply-To: <20171030014432.24025-1-wenyou.yang@microchip.com>
References: <20171030014432.24025-1-wenyou.yang@microchip.com>
Message-ID: <20171030014432.24025-3-wenyou.yang@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device tree binding documentation for the ov7740 sensor driver.

Signed-off-by: Wenyou Yang <wenyou.yang@microchip.com>
---

Changes in v3:
 - Explicitly document the "remote-endpoint" property.

Changes in v2: None

 .../devicetree/bindings/media/i2c/ov7740.txt       | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ov7740.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/ov7740.txt b/Documentation/devicetree/bindings/media/i2c/ov7740.txt
new file mode 100644
index 000000000000..af781c3a5f0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ov7740.txt
@@ -0,0 +1,47 @@
+* Omnivision OV7740 CMOS image sensor
+
+The Omnivision OV7740 image sensor supports multiple output image
+size, such as VGA, and QVGA, CIF and any size smaller. It also
+supports the RAW RGB and YUV output formats.
+
+The common video interfaces bindings (see video-interfaces.txt) should
+be used to specify link to the image data receiver. The OV7740 device
+node should contain one 'port' child node with an 'endpoint' subnode.
+
+Required Properties:
+- compatible:	"ovti,ov7740".
+- reg:		I2C slave address of the sensor.
+- clocks:	Reference to the xvclk input clock.
+- clock-names:	"xvclk".
+
+Optional Properties:
+- reset-gpios: Rreference to the GPIO connected to the reset_b pin,
+  if any. Active low with pull-ip resistor.
+- powerdown-gpios: Reference to the GPIO connected to the pwdn pin,
+  if any. Active high with pull-down resistor.
+
+Endpoint node mandatory properties:
+- remote-endpoint: A phandle to the bus receiver's endpoint node.
+
+Example:
+
+	i2c1: i2c at fc028000 {
+		ov7740: camera at 21 {
+			compatible = "ovti,ov7740";
+			reg = <0x21>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_sensor_power &pinctrl_sensor_reset>;
+			clocks = <&isc>;
+			clock-names = "xvclk";
+			assigned-clocks = <&isc>;
+			assigned-clock-rates = <24000000>;
+			reset-gpios = <&pioA 43 GPIO_ACTIVE_LOW>;
+			powerdown-gpios = <&pioA 44 GPIO_ACTIVE_HIGH>;
+
+			port {
+				ov7740_0: endpoint {
+					remote-endpoint = <&isc_0>;
+				};
+			};
+		};
+	};
-- 
2.13.0
