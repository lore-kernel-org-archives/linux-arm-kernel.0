From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Jun 2012 15:07:56 +0200
Subject: [RFC] i.MX DRM devicetree binding
Message-ID: <20120614130756.GS30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

The following is an attempt to come up with a devicetree binding for
DRM graphics on i.MX SoCs. I'm posting this seperate from the actual
code to not bury this in big patches.

The bindings should cover most of the problems we had while implementing
the possible IPU <-> (LVDS, HDMI, parallel) Display connections.

Contrary to some other devicetree bindings I have seen we decided not
to make the displays subnodes of the graphics unit because the (LVDS,
HDMI) encoders are outside the graphics units and also on i.MX6 there
are 2 IPUs and displays can be muxed between these IPUs.

Comments and suggestions welcome.

Sascha

8<--------------------------------------

DRM i.MX: Add devicetree binding documentation

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../devicetree/bindings/drm/fsl-imx-drm.txt        |  126 ++++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/drm/fsl-imx-drm.txt

diff --git a/Documentation/devicetree/bindings/drm/fsl-imx-drm.txt b/Documentation/devicetree/bindings/drm/fsl-imx-drm.txt
new file mode 100644
index 0000000..6766e03
--- /dev/null
+++ b/Documentation/devicetree/bindings/drm/fsl-imx-drm.txt
@@ -0,0 +1,126 @@
+Freescale i.MX IPUv3
+====================
+
+Required properties:
+- compatible: Should be "fsl,<chip>-ipu"
+- reg: should be register base and length as documented in the
+  datasheet
+- interrupts: Should contain sync interrupt and error interrupt,
+  in this order.
+- #crtc-cells: 1, See below
+
+example:
+
+ipu: ipu at 18000000 {
+	#crtc-cells = <1>;
+	compatible = "fsl,imx53-ipu";
+	reg = <0x18000000 0x080000000>;
+	interrupts = <11 10>;
+};
+
+Freescale i.MX LCDC controller
+==============================
+
+Required properties:
+- compatible: Should be "fsl,<chip>-lcdc"
+- reg: should be register base and length as documented in the
+  datasheet
+- interrupts: Should contain interrupt
+- #crtc-cells: 0, See below
+
+example:
+
+lcdc: lcdc at 10021000 {
+	#crtc-cells = <0>;
+	compatible = "fsl,imx27-lcdc", "fsl,imx21-lcdc";
+	reg = <0x10021000 0x4000>;
+	interrupts = <61>;
+};
+
+Parallel display support
+========================
+
+Required properties:
+- compatible: Should be "fsl,imx-parallel-display"
+- crtc: the crtc this display is connected to, see below
+Optional properties:
+- interface_pix_fmt: How this display is connected to the
+  crtc. Currently supported types: "rgb24", "rgb565"
+- edid: verbatim EDID data block describing attached display.
+- ddc: phandle describing the i2c bus handling the display data
+  channel
+
+example:
+
+display at di0 {
+	compatible = "fsl,imx-parallel-display";
+	edid = [edid-data];
+	crtc = <&ipu 0>;
+	interface_pix_fmt = "rgb24";
+};
+
+LVDS display bridge (LDB)
+=========================
+
+Required properties:
+- compatible: Should be "fsl,<chip>-ldb"
+- channel0-crtcs, channel1-crtcs: the crtcs the ldb is connected to, see
+  below
+Optional properties:
+- channel0-edid, channel1-edid: verbatim EDID data blocks describing the
+  displays attached to channel0 and channel1.
+- channel0-ddc, channel1-ddc: phandles describing the i2c busses handling
+  the display data channels for channel0 and channel1.
+
+lvds at 53fa8008 {
+	compatible = "fsl,imx6q-ldb";
+	channel0-edid = [edid-data];
+	channel1-ddc = <&i2c0>;
+	channel0-crtcs = <&ipu0 0>, <&ipu0 1>, <&ipu1 0>, <&ipu1 1>;
+	channel1-crtcs = <&ipu0 0>, <&ipu0 1>, <&ipu1 0>, <&ipu1 1>;
+};
+
+Specifying CRTCs connected to display output devices
+====================================================
+
+Display output device nodes should specify which CRTCs they can be
+connected to in their crtcs property, containing a 'crtc-list':
+
+	crtc-list ::= <single-crtc> [crtc-list]
+	single-crtc ::= <crtc-phandle> <crtc-specifier>
+	crtc-phandle : phandle to device node providing the crtc
+	crtc-specifier : Array of #crtc-cells specifying specific crtc
+			 (controller specific, 1 on imx-ipuv3)
+
+In the following example, two image processing units ipu0 and ipu1
+provide two CRTCs each, indexed with a single cell. The hdmi connector
+can be connected to either CRTC of ipu1, and the lvds connector is
+fixed to the second CRTC of ipu0.
+
+	ipu0: ipu0 {
+		#crtc-cells = <1>;
+	};
+	ipu1: ipu1 {
+		#crtc-cells = <1>;
+	};
+	[...]
+	hdmi: hdmi {
+		ddc = <&i2c2>;
+		crtcs = <&ipu1 0 &ipu1 1>;
+	};
+	lvds: lvds {
+		edid = [edid-data];
+		crtcs = <&ipu0 1>;
+	};
+
+Note that the crtc-specifier length is controller dependent. A simple
+lcdc controller with a single CRTC should use #crtc-cells = <0>:
+
+	lcdc: lcdc {
+		#crtc-cells = <0>;
+	};
+	[...]
+	parallel-display {
+		crtcs = <&lcdc>
+	};
+
-- 
1.7.10

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
