From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 23 Aug 2016 21:55:46 +0800
Subject: [PATCH] ARM: dts: sun8i: add NAND controller node for A23/A33
Message-ID: <20160823135546.60179-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A23/A33 has a NAND controller which can now be used properly.

Add a device node for it.

The DMA function cannot work because of changed DMA IP block, so it's
temporarily removed in the device node. However, with PIO mode it can still
work.

Tested on an Aoson M751s tablet with Boris Brezillon's "mtd: nand: allow
vendor specific detection/initialization" patchset, which is needed for the
large-block MLC chip to be recognized correctly.
( http://lists.infradead.org/pipermail/linux-mtd/2016-June/068198.html )

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 89ea479..17e3dec 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -239,6 +239,14 @@
 					     "mmc2_sample";
 		};
 
+		nand_clk: clk at 01c20080 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c20080 0x4>;
+			clocks = <&osc24M>, <&pll6 1>;
+			clock-output-names = "nand";
+		};
+
 		usb_clk: clk at 01c200cc {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -322,6 +330,19 @@
 			#size-cells = <0>;
 		};
 
+		nfc: nand at 01c03000 {
+			compatible = "allwinner,sun4i-a10-nand";
+			reg = <0x01c03000 0x1000>;
+			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ahb1_gates 13>, <&nand_clk>;
+			clock-names = "ahb", "mod";
+			resets = <&ahb1_rst 13>;
+			reset-names = "ahb";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		ehci0: usb at 01c1a000 {
 			compatible = "allwinner,sun8i-a23-ehci", "generic-ehci";
 			reg = <0x01c1a000 0x100>;
-- 
2.9.3
