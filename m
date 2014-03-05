From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed,  5 Mar 2014 10:20:54 +0100
Subject: [PATCH v5 03/11] staging: imx-drm: Document updated imx-drm device
 tree bindings
In-Reply-To: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1394011262-16849-4-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the device tree binding documentation for i.MX IPU/display
nodes using the OF graph bindings documented in
Documentation/devicetree/bindings/media/video-interfaces.txt.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v4:
 - changed DT compatible string to 'fsl,imx-display-subsystem' instead
   of Linux specific 'fsl,imx-drm'
 - Changed DT node name from 'imx-drm' to 'display-subsystem'
---
 .../bindings/staging/imx-drm/fsl-imx-drm.txt       | 48 +++++++++++++++++++---
 .../devicetree/bindings/staging/imx-drm/ldb.txt    | 20 +++++++--
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
index b876d49..3be5ce7 100644
--- a/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
+++ b/Documentation/devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt
@@ -1,3 +1,22 @@
+Freescale i.MX DRM master device
+================================
+
+The freescale i.MX DRM master device is a virtual device needed to list all
+IPU or other display interface nodes that comprise the graphics subsystem.
+
+Required properties:
+- compatible: Should be "fsl,imx-display-subsystem"
+- ports: Should contain a list of phandles pointing to display interface ports
+  of IPU devices
+
+example:
+
+display-subsystem {
+	compatible = "fsl,display-subsystem";
+	ports = <&ipu_di0>;
+};
+
+
 Freescale i.MX IPUv3
 ====================
 
@@ -7,18 +26,31 @@ Required properties:
   datasheet
 - interrupts: Should contain sync interrupt and error interrupt,
   in this order.
-- #crtc-cells: 1, See below
 - resets: phandle pointing to the system reset controller and
           reset line index, see reset/fsl,imx-src.txt for details
+Optional properties:
+- port@[0-3]: Port nodes with endpoint definitions as defined in
+  Documentation/devicetree/bindings/media/video-interfaces.txt.
+  Ports 0 and 1 should correspond to CSI0 and CSI1,
+  ports 2 and 3 should correspond to DI0 and DI1, respectively.
 
 example:
 
 ipu: ipu at 18000000 {
-	#crtc-cells = <1>;
+	#address-cells = <1>;
+	#size-cells = <0>;
 	compatible = "fsl,imx53-ipu";
 	reg = <0x18000000 0x080000000>;
 	interrupts = <11 10>;
 	resets = <&src 2>;
+
+	ipu_di0: port at 2 {
+		reg = <2>;
+
+		ipu_di0_disp0: endpoint {
+			remote-endpoint = <&display_in>;
+		};
+	};
 };
 
 Parallel display support
@@ -26,19 +58,25 @@ Parallel display support
 
 Required properties:
 - compatible: Should be "fsl,imx-parallel-display"
-- crtc: the crtc this display is connected to, see below
 Optional properties:
 - interface_pix_fmt: How this display is connected to the
-  crtc. Currently supported types: "rgb24", "rgb565", "bgr666"
+  display interface. Currently supported types: "rgb24", "rgb565", "bgr666"
 - edid: verbatim EDID data block describing attached display.
 - ddc: phandle describing the i2c bus handling the display data
   channel
+- port: A port node with endpoint definitions as defined in
+  Documentation/devicetree/bindings/media/video-interfaces.txt.
 
 example:
 
 display at di0 {
 	compatible = "fsl,imx-parallel-display";
 	edid = [edid-data];
-	crtc = <&ipu 0>;
 	interface-pix-fmt = "rgb24";
+
+	port {
+		display_in: endpoint {
+			remote-endpoint = <&ipu_di0_disp0>;
+		};
+	};
 };
diff --git a/Documentation/devicetree/bindings/staging/imx-drm/ldb.txt b/Documentation/devicetree/bindings/staging/imx-drm/ldb.txt
index ed93778..578a1fc 100644
--- a/Documentation/devicetree/bindings/staging/imx-drm/ldb.txt
+++ b/Documentation/devicetree/bindings/staging/imx-drm/ldb.txt
@@ -50,12 +50,14 @@ have a look at Documentation/devicetree/bindings/video/display-timing.txt.
 
 Required properties:
  - reg : should be <0> or <1>
- - crtcs : a list of phandles with index pointing to the IPU display interfaces
-           that can be used as video source for this channel.
  - fsl,data-mapping : should be "spwg" or "jeida"
                       This describes how the color bits are laid out in the
                       serialized LVDS signal.
  - fsl,data-width : should be <18> or <24>
+ - port: A port node with endpoint definitions as defined in
+   Documentation/devicetree/bindings/media/video-interfaces.txt.
+   On i.MX6, there should be four ports (port@[0-3]) that correspond
+   to the four LVDS multiplexer inputs.
 
 example:
 
@@ -77,23 +79,33 @@ ldb: ldb at 53fa8008 {
 
 	lvds-channel at 0 {
 		reg = <0>;
-		crtcs = <&ipu 0>;
 		fsl,data-mapping = "spwg";
 		fsl,data-width = <24>;
 
 		display-timings {
 			/* ... */
 		};
+
+		port {
+			lvds0_in: endpoint {
+				remote-endpoint = <&ipu_di0_lvds0>;
+			};
+		};
 	};
 
 	lvds-channel at 1 {
 		reg = <1>;
-		crtcs = <&ipu 1>;
 		fsl,data-mapping = "spwg";
 		fsl,data-width = <24>;
 
 		display-timings {
 			/* ... */
 		};
+
+		port {
+			lvds1_in: endpoint {
+				remote-endpoint = <&ipu_di1_lvds1>;
+			};
+		};
 	};
 };
-- 
1.9.0.rc3
