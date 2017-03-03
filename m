From: peter.senna@collabora.com (Peter Senna Tschudin)
Date: Fri,  3 Mar 2017 16:57:07 +0100
Subject: [PATCH V3 1/4] dt-bindings: display: megachips-stdpxxxx-ge-b850v3-fw
In-Reply-To: <cover.1488555615.git.peter.senna@collabora.com>
References: <cover.1488555615.git.peter.senna@collabora.com>
Message-ID: <c2712336226c5170cfdc45103527fb2338d3d6cf.1488555615.git.peter.senna@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Devicetree binding documentation for the second video output
of the GE B850v3:
   STDP4028-ge-b850v3-fw bridges (LVDS-DP)
   STDP2690-ge-b850v3-fw bridges (DP-DP++)

Added entry for MegaChips at:
 Documentation/devicetree/bindings/vendor-prefixes.txt

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Martyn Welch <martyn.welch@collabora.co.uk>
Cc: Martin Donnelly <martin.donnelly@ge.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
---
Changes from V3:
 Added Acked-by: Rob Herring <robh@kernel.org>

Changes from V1:
 - New subject
 - Moved binding documentation from bindings/video/ to bindings/display/bridge/
 - Reworded to describe hardware instead of the driver
 - Reformated the bindings to have one set of required properties per device
 - Updated reg description
 - Defined number of ports and what they are for

 .../bridge/megachips-stdpxxxx-ge-b850v3-fw.txt     | 94 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 2 files changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt b/Documentation/devicetree/bindings/display/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
new file mode 100644
index 0000000..7baa658
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
@@ -0,0 +1,94 @@
+Drivers for the second video output of the GE B850v3:
+   STDP4028-ge-b850v3-fw bridges (LVDS-DP)
+   STDP2690-ge-b850v3-fw bridges (DP-DP++)
+
+The video processing pipeline on the second output on the GE B850v3:
+
+   Host -> LVDS|--(STDP4028)--|DP -> DP|--(STDP2690)--|DP++ -> Video output
+
+Each bridge has a dedicated flash containing firmware for supporting the custom
+design. The result is that, in this design, neither the STDP4028 nor the
+STDP2690 behave as the stock bridges would. The compatible strings include the
+suffix "-ge-b850v3-fw" to make it clear that the driver is for the bridges with
+the firmware specific for the GE B850v3.
+
+The hardware do not provide control over the video processing pipeline, as the
+two bridges behaves as a single one. The only interfaces exposed by the
+hardware are EDID, HPD, and interrupts.
+
+stdp4028-ge-b850v3-fw required properties:
+  - compatible : "megachips,stdp4028-ge-b850v3-fw"
+  - reg : I2C bus address
+  - interrupt-parent : phandle of the interrupt controller that services
+    interrupts to the device
+  - interrupts : one interrupt should be described here, as in
+    <0 IRQ_TYPE_LEVEL_HIGH>
+  - ports : One input port(reg = <0>) and one output port(reg = <1>)
+
+stdp2690-ge-b850v3-fw required properties:
+    compatible : "megachips,stdp2690-ge-b850v3-fw"
+  - reg : I2C bus address
+  - ports : One input port(reg = <0>) and one output port(reg = <1>)
+
+Example:
+
+&mux2_i2c2 {
+	status = "okay";
+	clock-frequency = <100000>;
+
+	stdp4028 at 73 {
+		compatible = "megachips,stdp4028-ge-b850v3-fw";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg = <0x73>;
+
+		interrupt-parent = <&gpio2>;
+		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				stdp4028_in: endpoint {
+					remote-endpoint = <&lvds0_out>;
+				};
+			};
+			port at 1 {
+				reg = <1>;
+				stdp4028_out: endpoint {
+					remote-endpoint = <&stdp2690_in>;
+				};
+			};
+		};
+	};
+
+	stdp2690 at 72 {
+		compatible = "megachips,stdp2690-ge-b850v3-fw";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg = <0x72>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				stdp2690_in: endpoint {
+					remote-endpoint = <&stdp4028_out>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+				stdp2690_out: endpoint {
+					/* Connector for external display */
+				};
+			};
+		};
+	};
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index ec0bfb9..4686f4b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -178,6 +178,7 @@ maxim	Maxim Integrated Products
 mcube	mCube
 meas	Measurement Specialties
 mediatek	MediaTek Inc.
+megachips	MegaChips
 melexis	Melexis N.V.
 melfas	MELFAS Inc.
 memsic	MEMSIC Inc.
-- 
2.9.3
