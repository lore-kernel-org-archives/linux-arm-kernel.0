From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 30 Dec 2017 19:30:38 +0800
Subject: [PATCH v4 1/6] ARM: sunxi: h3/h5: add simplefb nodes
In-Reply-To: <20171230113043.30237-1-icenowy@aosc.io>
References: <20171230113043.30237-1-icenowy@aosc.io>
Message-ID: <20171230113043.30237-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The H3/H5 SoCs have a HDMI output and a TV Composite output.

Add simplefb nodes for these outputs.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v4:
- Dropped extra clocks (bus clocks and HDMI DDC clocks), only keep the
  clocks that are needed to display framebuffer to the monitor.

 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index fcb909658cf0..7a83b15225c7 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -53,6 +53,30 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		framebuffer-hdmi {
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
+			allwinner,pipeline = "mixer0-lcd0-hdmi";
+			clocks = <&display_clocks CLK_MIXER0>,
+				 <&ccu CLK_TCON0>, <&ccu CLK_HDMI>;
+			status = "disabled";
+		};
+
+		framebuffer-tve {
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
+			allwinner,pipeline = "mixer1-lcd1-tve";
+			clocks = <&display_clocks CLK_MIXER1>,
+				 <&ccu CLK_TVE>;
+			status = "disabled";
+		};
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.14.2
