From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed, 24 May 2017 17:29:18 -0700
Subject: [PATCH v7 03/34] [media] dt/bindings: Add bindings for OV5640
In-Reply-To: <1495672189-29164-1-git-send-email-steve_longerbeam@mentor.com>
References: <1495672189-29164-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1495672189-29164-4-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree binding documentation for the OV5640 camera sensor.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/media/i2c/ov5640.txt       | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ov5640.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/ov5640.txt b/Documentation/devicetree/bindings/media/i2c/ov5640.txt
new file mode 100644
index 0000000..540b36c
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ov5640.txt
@@ -0,0 +1,45 @@
+* Omnivision OV5640 MIPI CSI-2 sensor
+
+Required Properties:
+- compatible: should be "ovti,ov5640"
+- clocks: reference to the xclk input clock.
+- clock-names: should be "xclk".
+- DOVDD-supply: Digital I/O voltage supply, 1.8 volts
+- AVDD-supply: Analog voltage supply, 2.8 volts
+- DVDD-supply: Digital core voltage supply, 1.5 volts
+
+Optional Properties:
+- reset-gpios: reference to the GPIO connected to the reset pin, if any.
+	       This is an active low signal to the OV5640.
+- powerdown-gpios: reference to the GPIO connected to the powerdown pin,
+		   if any. This is an active high signal to the OV5640.
+
+The device node must contain one 'port' child node for its digital output
+video port, in accordance with the video interface bindings defined in
+Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+Example:
+
+&i2c1 {
+	ov5640: camera at 3c {
+		compatible = "ovti,ov5640";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ov5640>;
+		reg = <0x3c>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		clock-names = "xclk";
+		DOVDD-supply = <&vgen4_reg>; /* 1.8v */
+		AVDD-supply = <&vgen3_reg>;  /* 2.8v */
+		DVDD-supply = <&vgen2_reg>;  /* 1.5v */
+		powerdown-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
+
+		port {
+			ov5640_to_mipi_csi2: endpoint {
+				remote-endpoint = <&mipi_csi2_from_ov5640>;
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
-- 
2.7.4
