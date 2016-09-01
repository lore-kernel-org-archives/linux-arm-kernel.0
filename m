From: jsarha@ti.com (Jyri Sarha)
Date: Thu, 1 Sep 2016 12:09:09 +0300
Subject: [PATCH v4 5/8] ARM: dts: am335x-boneblack: Add blue-and-red-wiring
 -property to LCDC node
In-Reply-To: <cover.1472719892.git.jsarha@ti.com>
References: <cover.1472719892.git.jsarha@ti.com>
Message-ID: <fad833a6a4368196f4fc131a54d90f5b90169393.1472719892.git.jsarha@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add blue-and-red-wiring -property to LCDC node. Also adds comments on
how to get support 24 bit RGB mode. After this patch am335x-boneblack
support RGB565, BGR888, and XBGR8888 color formats. See details in
Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt.

The BBB has straight color wiring from am335x to tda19988, however the
tda19988 can be configured to cross the blue and red wires. The
comments show how to do that with video-ports property of tda19988
node and how to tell LCDC that blue and red wires are crossed, with
blue-and-red-wiring LCDC node property. This changes supported color
formats from 16 bit RGB and 24 bit BGR to 16 bit BGR and 24 bit RGB.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/am335x-boneblack.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 528559b..a32d73a 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -90,6 +90,14 @@
 
 &lcdc {
 	status = "okay";
+
+	/* If you want to get 24 bit RGB and 16 BGR mode instead of
+	 * current 16 bit RGB and 24 BGR modes, set the propety
+	 * below to "crossed" and uncomment the video-ports -property
+	 * in tda19988 node.
+	 */
+	blue-and-red-wiring = "straight";
+
 	port {
 		lcdc_0: endpoint at 0 {
 			remote-endpoint = <&hdmi_0>;
@@ -106,6 +114,9 @@
 		pinctrl-0 = <&nxp_hdmi_bonelt_pins>;
 		pinctrl-1 = <&nxp_hdmi_bonelt_off_pins>;
 
+		/* Convert 24bit BGR to RGB, e.g. cross red and blue wiring */
+		/* video-ports = <0x234501>; */
+
 		#sound-dai-cells = <0>;
 		audio-ports = <	TDA998x_I2S	0x03>;
 
-- 
1.9.1
