From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 20 Jul 2018 16:56:10 +0200
Subject: [PATCH RESEND 7/7] ARM: dts: sun5i: Add the MBUS controller
In-Reply-To: <cover.d2aafc48da035aed80793da89079e5da269b45b4.1532098561.git-series.maxime.ripard@bootlin.com>
References: <cover.d2aafc48da035aed80793da89079e5da269b45b4.1532098561.git-series.maxime.ripard@bootlin.com>
Message-ID: <b4278acafe16d9aba046298f196a8e6bc310956c.1532098561.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MBUS (and its associated controller) is the bus in the Allwinner SoCs
that DMA devices use in the system to access the memory.

Among other things (and depending on the SoC generation), it can also
enforce priorities or report bandwidth usages on a per-master basis.

One of the most notable thing is that instead of having the same mapping
for the RAM than the CPU, it maps it at address 0, which means we'll have
to do address translation thanks to the dma-ranges property.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 07f2248ed5f8..acb24e537e0b 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -112,6 +112,7 @@
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
+		dma-ranges;
 		ranges;
 
 		sram-controller at 1c00000 {
@@ -150,6 +151,14 @@
 			};
 		};
 
+		mbus: dram-controller at 1c01000 {
+			compatible = "allwinner,sun5i-a13-mbus";
+			reg = <0x01c01000 0x1000>;
+			clocks = <&ccu CLK_MBUS>;
+			dma-ranges = <0x00000000 0x40000000 0x20000000>;
+			#dma-parent-cells = <1>;
+		};
+
 		dma: dma-controller at 1c02000 {
 			compatible = "allwinner,sun4i-a10-dma";
 			reg = <0x01c02000 0x1000>;
@@ -677,6 +686,7 @@
 			clock-names = "ahb", "mod",
 				      "ram";
 			resets = <&ccu RST_DE_FE>;
+			dma-parent = <&mbus 19>;
 			status = "disabled";
 
 			ports {
@@ -705,6 +715,7 @@
 			clock-names = "ahb", "mod",
 				      "ram";
 			resets = <&ccu RST_DE_BE>;
+			dma-parent = <&mbus 18>;
 			status = "disabled";
 
 			assigned-clocks = <&ccu CLK_DE_BE>;
-- 
git-series 0.9.1
