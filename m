From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri,  9 Mar 2018 11:14:43 +0100
Subject: [PATCH 7/9] ARM: dts: sun5i: Use video-engine node
In-Reply-To: <20180309100933.15922-3-paul.kocialkowski@bootlin.com>
References: <20180309100933.15922-3-paul.kocialkowski@bootlin.com>
Message-ID: <20180309101445.16190-5-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florent Revest <florent.revest@free-electrons.com>

Now that we have a driver matching "allwinner,sun4i-a10-video-engine" we
can load it.

The "video-engine" node depends on the new sunxi-ng's CCU clock and
reset bindings. This patch also includes a ve_reserved DMA pool for
videobuf2 buffer allocations in sunxi-cedrus.

Signed-off-by: Florent Revest <florent.revest@free-electrons.com>
[Icenowy: beautify the node name]
Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun5i-a13.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 4e830f5cb7f1..18bc8d739cd0 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -51,6 +51,19 @@
 / {
 	interrupt-parent = <&intc>;
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		ve_reserved: cma {
+			compatible = "shared-dma-pool";
+			reg = <0x43d00000 0x9000000>;
+			no-map;
+			linux,cma-default;
+		};
+	};
+
 	thermal-zones {
 		cpu_thermal {
 			/* milliseconds */
@@ -97,6 +110,23 @@
 			status = "disabled";
 		};
 
+		ve: video-engine at 01c0e000 {
+			compatible = "allwinner,sun4i-a10-video-engine";
+			memory-region = <&ve_reserved>;
+
+			clocks = <&ccu CLK_AHB_VE>, <&ccu CLK_VE>,
+				 <&ccu CLK_DRAM_VE>;
+			clock-names = "ahb", "mod", "ram";
+
+			assigned-clocks = <&ccu CLK_VE>;
+			assigned-clock-rates = <320000000>;
+
+			resets = <&ccu RST_VE>;
+
+			interrupts = <53>;
+
+			reg = <0x01c0e000 0x1000>;
+		};
 	};
 };
 
-- 
2.16.2
