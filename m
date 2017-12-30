From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 30 Dec 2017 19:30:42 +0800
Subject: [PATCH v4 5/6] arm64: allwinner: a64: add simplefb for A64 SoC
In-Reply-To: <20171230113043.30237-1-icenowy@aosc.io>
References: <20171230113043.30237-1-icenowy@aosc.io>
Message-ID: <20171230113043.30237-6-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A64 SoC features two display pipelines, one has a LCD output, the
other has a HDMI output.

Add support for simplefb for these pipelines on A64 SoC.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v4:
- Dropped extra clocks.
- Added labels to the SimpleFB device tree nodes as boards may have
  extra regulator for display pipeline.

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index fb8ea7c414e1..d803c115d362 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -42,9 +42,11 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <dt-bindings/clock/sun8i-de2.h>
 #include <dt-bindings/clock/sun50i-a64-ccu.h>
 #include <dt-bindings/clock/sun8i-r-ccu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/sun8i-de2.h>
 #include <dt-bindings/reset/sun50i-a64-ccu.h>
 
 / {
@@ -52,6 +54,30 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		simplefb_lcd: framebuffer-lcd {
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
+			allwinner,pipeline = "mixer0-lcd0";
+			clocks = <&display_clocks CLK_MIXER0>,
+				 <&ccu CLK_TCON0>;
+			status = "disabled";
+		};
+
+		simplefb_hdmi: framebuffer-hdmi {
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
+			allwinner,pipeline = "mixer1-lcd1-hdmi";
+			clocks = <&display_clocks CLK_MIXER1>,
+				 <&ccu CLK_TCON1>, <&ccu CLK_HDMI>;
+			status = "disabled";
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.14.2
