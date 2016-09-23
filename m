From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 23 Sep 2016 15:24:08 +0800
Subject: [PATCH 1/2] dt-bindings: add bindings doc for ZTE VOU display
 controller
Message-ID: <1474615449-16893-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds initial bindings doc for ZTE VOU display controller.  HDMI is
the only supported output device right now.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/display/zte,vou.txt        | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/zte,vou.txt

diff --git a/Documentation/devicetree/bindings/display/zte,vou.txt b/Documentation/devicetree/bindings/display/zte,vou.txt
new file mode 100644
index 000000000000..b7407219cfa1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/zte,vou.txt
@@ -0,0 +1,67 @@
+ZTE VOU Display Controller
+
+This is a display controller found on ZTE ZX296718 SoC.  It includes multiple
+Graphic Layer (GL) and Video Layer (VL), two Mixers/Channels, and a few blocks
+handling scaling, color space conversion etc.  VOU also integrates the support
+for typical output devices, like HDMI, TV Encoder, VGA, and RGB LCD.
+
+* Master display-subsystem node
+
+It must be the parent node of all the sub-device nodes.
+
+Required properties:
+ - compatible: should be "zte,zx-display-subsystem"
+ - #address-cells: should be <1>
+ - #size-cells: should be <1>
+ - ranges: to allow probing of sub-devices
+
+* VOU controller device
+
+Required properties:
+ - compatible: should be "zte,zx296718-vou"
+ - reg: Physical base address and length of the whole VOU IO region
+ - interrupts: VOU interrupt number to the CPU
+ - clocks: A list of phandle + clock-specifier pairs, one for each entry
+   in 'clock-names'
+ - clock-names: A list of clock names.  It should contain: "aclk", "ppu_wclk",
+   "main_wclk" and "aux_wclk".
+
+* HDMI output device
+
+Required properties:
+ - compatible: should be "zte,zx296718-hdmi"
+ - reg: Physical base address and length of the HDMI device IO region
+ - interrupts : HDMI interrupt number to the CPU
+ - clocks: A list of phandle + clock-specifier pairs, one for each entry
+   in 'clock-names'
+ - clock-names: A list of clock names.  It should contain: "osc_cec", "osc_clk"
+   and "xclk".
+
+Example:
+
+display-subsystem {
+	compatible = "zte,zx-display-subsystem";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+
+	vou: vou at 1440000 {
+		compatible = "zte,zx296718-vou";
+		reg = <0x1440000 0x10000>;
+		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&topcrm VOU_ACLK>, <&topcrm VOU_PPU_WCLK>,
+			 <&topcrm VOU_MAIN_WCLK>, <&topcrm VOU_AUX_WCLK>;
+		clock-names = "aclk", "ppu_wclk",
+			      "main_wclk", "aux_wclk";
+	};
+
+	hdmi: hdmi at 144c000 {
+		compatible = "zte,zx296718-hdmi";
+		reg = <0x144c000 0x4000>;
+		interrupts = <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&topcrm HDMI_OSC_CEC>,
+			 <&topcrm HDMI_OSC_CLK>,
+			 <&topcrm HDMI_XCLK>;
+		clock-names = "osc_cec", "osc_clk", "xclk";
+	};
+};
-- 
1.9.1
