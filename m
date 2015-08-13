From: eric@anholt.net (Eric Anholt)
Date: Wed, 12 Aug 2015 17:56:14 -0700
Subject: [PATCH 1/7] drm/vc4: Add devicetree bindings for VC4.
In-Reply-To: <1439427380-2436-1-git-send-email-eric@anholt.net>
References: <1439427380-2436-1-git-send-email-eric@anholt.net>
Message-ID: <1439427380-2436-2-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../devicetree/bindings/gpu/brcm,bcm-vc4.txt       | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt

diff --git a/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt b/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt
new file mode 100644
index 0000000..2b13e61
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt
@@ -0,0 +1,83 @@
+Broadcom VC4 GPU
+
+The VC4 device present on the Raspberry Pi includes a display system
+with HDMI output and the HVS scaler for compositing display planes.
+
+Required properties for VC4:
+- compatible:	Should be "brcm,vc4"
+- crtcs:	List of references to pixelvalve scanout engines
+- hvss:		List of references to HVS video scalers
+- encoders:	List of references to output encoders (HDMI, SDTV)
+
+Required properties for Pixel Valve:
+- compatible:	Should be "brcm,vc4-pixelvalve"
+- reg:		Physical base address and length of the PV's registers
+- interrupts:	The interrupt number
+		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
+
+Required properties for HVS:
+- compatible:	Should be "brcm,vc4-hvs"
+- reg:		Physical base address and length of the HVS's registers
+- interrupts:	The interrupt number
+		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
+
+Required properties for HDMI
+- compatible:	Should be "brcm,vc4-hdmi"
+- reg:		Physical base address and length of the two register ranges
+		  ("HDMI" and "HD")
+- interrupts:	The interrupt numbers
+		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
+- ddc:		phandle of the I2C controller used for DDC EDID probing
+- crtc:		phandle to the pixelvalve CRTC the HDMI encoder is attached to
+
+Optional properties for HDMI:
+- hpd-gpio:	The GPIO pin for HDMI hotplug detect (if it doesn't appear
+		  as an interrupt/status bit in the HDMI controller
+		  itself).  See bindings/pinctrl/brcm,bcm2835-gpio.txt
+
+Example:
+/ {
+	soc {
+		pv0: brcm,vc4-pixelvalve at 7e206000 {
+			compatible = "brcm,vc4-pixelvalve";
+			reg = <0x7e206000 0x100>;
+			interrupts = <2 13>; /* pwa2 */
+		};
+
+		pv1: brcm,vc4-pixelvalve at 7e207000 {
+			compatible = "brcm,vc4-pixelvalve";
+			reg = <0x7e207000 0x100>;
+			interrupts = <2 14>; /* pwa1 */
+		};
+
+		pv2: brcm,vc4-pixelvalve at 7e807000 {
+			compatible = "brcm,vc4-pixelvalve";
+			reg = <0x7e807000 0x100>;
+			interrupts = <2 10>; /* pixelvalve */
+		};
+
+		hvs: brcm,hvs at 7e400000 {
+			compatible = "brcm,vc4-hvs";
+			reg = <0x7e400000 0x6000>;
+			interrupts = <2 1>;
+		};
+
+		hdmi: brcm,vc4-hdmi at 7e902000 {
+			compatible = "brcm,vc4-hdmi";
+			reg = <0x7e902000 0x600>,
+			      <0x7e808000 0x100>;
+			interrupts = <2 8>, <2 9>;
+			ddc = <&i2c2>;
+			hpd-gpio = <&gpio 46 GPIO_ACTIVE_HIGH>;
+			crtc = <&pv2>;
+		};
+
+		vc4: vc4 at 0x7e4c0000 {
+			compatible = "brcm,vc4";
+
+			crtcs = <&pv0>, <&pv1>, <&pv2>;
+			encoders = <&hdmi>;
+			hvss = <&hvs>;
+		};
+	};
+};
-- 
2.1.4
