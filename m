From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 20 Oct 2016 15:30:23 +0800
Subject: [PATCH v3 1/3] dt-bindings: add bindings doc for ZTE VOU display
 controller
In-Reply-To: <1476948625-8521-1-git-send-email-shawn.guo@linaro.org>
References: <1476948625-8521-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1476948625-8521-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds initial bindings doc for ZTE VOU display controller.  HDMI is
the only supported output device right now.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/display/zte,vou.txt        | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/zte,vou.txt

diff --git a/Documentation/devicetree/bindings/display/zte,vou.txt b/Documentation/devicetree/bindings/display/zte,vou.txt
new file mode 100644
index 000000000000..740e5bd2e4f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/zte,vou.txt
@@ -0,0 +1,84 @@
+ZTE VOU Display Controller
+
+This is a display controller found on ZTE ZX296718 SoC.  It includes multiple
+Graphic Layer (GL) and Video Layer (VL), two Mixers/Channels, and a few blocks
+handling scaling, color space conversion etc.  VOU also integrates the support
+for typical output devices, like HDMI, TV Encoder, VGA, and RGB LCD.
+
+* Master VOU node
+
+It must be the parent node of all the sub-device nodes.
+
+Required properties:
+ - compatible: should be "zte,zx296718-vou"
+ - #address-cells: should be <1>
+ - #size-cells: should be <1>
+ - ranges: list of address translations between VOU and sub-devices
+
+* VOU DPC device
+
+Required properties:
+ - compatible: should be "zte,zx296718-dpc"
+ - reg: Physical base address and length of DPC register regions, one for each
+   entry in 'reg-names'
+ - reg-names: The names of register regions. The following regions are required:
+	"osd"
+	"timing_ctrl"
+	"dtrc"
+	"vou_ctrl"
+	"otfppu"
+ - interrupts: VOU DPC interrupt number to CPU
+ - clocks: A list of phandle + clock-specifier pairs, one for each entry
+   in 'clock-names'
+ - clock-names: A list of clock names.  The following clocks are required:
+	"aclk"
+	"ppu_wclk"
+	"main_wclk"
+	"aux_wclk"
+
+* HDMI output device
+
+Required properties:
+ - compatible: should be "zte,zx296718-hdmi"
+ - reg: Physical base address and length of the HDMI device IO region
+ - interrupts : HDMI interrupt number to CPU
+ - clocks: A list of phandle + clock-specifier pairs, one for each entry
+   in 'clock-names'
+ - clock-names: A list of clock names.  The following clocks are required:
+	"osc_cec"
+	"osc_clk"
+	"xclk"
+
+Example:
+
+vou: vou at 1440000 {
+	compatible = "zte,zx296718-vou";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0 0x1440000 0x10000>;
+
+	dpc: dpc at 0 {
+		compatible = "zte,zx296718-dpc";
+		reg = <0x0000 0x1000>, <0x1000 0x1000>,
+		      <0x5000 0x1000>, <0x6000 0x1000>,
+		      <0xa000 0x1000>;
+		reg-names = "osd", "timing_ctrl",
+			    "dtrc", "vou_ctrl",
+			    "otfppu";
+		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&topcrm VOU_ACLK>, <&topcrm VOU_PPU_WCLK>,
+			 <&topcrm VOU_MAIN_WCLK>, <&topcrm VOU_AUX_WCLK>;
+		clock-names = "aclk", "ppu_wclk",
+			      "main_wclk", "aux_wclk";
+	};
+
+	hdmi: hdmi at c000 {
+		compatible = "zte,zx296718-hdmi";
+		reg = <0xc000 0x4000>;
+		interrupts = <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&topcrm HDMI_OSC_CEC>,
+			 <&topcrm HDMI_OSC_CLK>,
+			 <&topcrm HDMI_XCLK>;
+		clock-names = "osc_cec", "osc_clk", "xclk";
+	};
+};
-- 
1.9.1
