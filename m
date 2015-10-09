From: eric@anholt.net (Eric Anholt)
Date: Fri,  9 Oct 2015 14:27:42 -0700
Subject: [PATCH v3 1/7] drm/vc4: Add devicetree bindings for VC4.
In-Reply-To: <1444426068-15817-1-git-send-email-eric@anholt.net>
References: <1444426068-15817-1-git-send-email-eric@anholt.net>
Message-ID: <1444426068-15817-2-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VC4 is the GPU (display and 3D) subsystem present on the 2835 and some
other Broadcom SoCs.

This binding follows the model of msm, imx, sti, and others, where
there is a subsystem node for the whole GPU, with nodes for the
individual HW components within it.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: Extend the commit message, fix several nits from Stephen Warren.
v3: Rename the compatibility strings, clean up node names, drop the
    unnecessary lists of components.  Use compatibility strings for
    choosing CRTC HVS channel numbers.  Document the HDMI clock usage.

 .../devicetree/bindings/gpu/brcm,bcm-vc4.txt       | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt

diff --git a/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt b/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt
new file mode 100644
index 0000000..175bcde
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/brcm,bcm-vc4.txt
@@ -0,0 +1,64 @@
+Broadcom VC4 GPU
+
+The VC4 device present on the Raspberry Pi includes a display system
+with HDMI output and the HVS scaler for compositing display planes.
+
+Required properties for VC4:
+- compatible:	Should be "brcm,bcm2835-vc4"
+
+Required properties for Pixel Valve:
+- compatible:	Should be one of "brcm,bcm2835-pixelvalve0",
+		"brcm,bcm2835-pixelvalve1", or "brcm,bcm2835-pixelvalve2"
+- reg:		Physical base address and length of the PV's registers
+- interrupts:	The interrupt number
+		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
+
+Required properties for HVS:
+- compatible:	Should be "brcm,bcm2835-hvs"
+- reg:		Physical base address and length of the HVS's registers
+- interrupts:	The interrupt number
+		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
+
+Required properties for HDMI
+- compatible:	Should be "brcm,bcm2835-hdmi"
+- reg:		Physical base address and length of the two register ranges
+		  ("HDMI" and "HD", in that order)
+- interrupts:	The interrupt numbers
+		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
+- ddc:		phandle of the I2C controller used for DDC EDID probing
+- clocks:	a) hdmi: The HDMI state machine clock
+		b) pixel: The pixel clock.
+
+Optional properties for HDMI:
+- hpd-gpio:	The GPIO pin for HDMI hotplug detect (if it doesn't appear
+		  as an interrupt/status bit in the HDMI controller
+		  itself).  See bindings/pinctrl/brcm,bcm2835-gpio.txt
+
+Example:
+pixelvalve at 7e807000 {
+	compatible = "brcm,bcm2835-pixelvalve2";
+	reg = <0x7e807000 0x100>;
+	interrupts = <2 10>; /* pixelvalve */
+};
+
+hvs at 7e400000 {
+	compatible = "brcm,bcm2835-hvs";
+	reg = <0x7e400000 0x6000>;
+	interrupts = <2 1>;
+};
+
+hdmi: hdmi at 7e902000 {
+	compatible = "brcm,bcm2835-hdmi";
+	reg = <0x7e902000 0x600>,
+	      <0x7e808000 0x100>;
+	interrupts = <2 8>, <2 9>;
+	ddc = <&i2c2>;
+	hpd-gpio = <&gpio 46 GPIO_ACTIVE_HIGH>;
+	clocks = <&clocks BCM2835_PLLH_PIX>,
+		 <&clocks BCM2835_CLOCK_HSM>;
+	clock-names = "pixel", "hdmi";
+};
+
+vc4: gpu at 7e4c0000 {
+	compatible = "brcm,bcm2835-vc4";
+};
-- 
2.1.4
