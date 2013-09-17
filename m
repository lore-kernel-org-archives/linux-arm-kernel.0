From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 17 Sep 2013 12:43:09 -0600
Subject: [PATCH 2/3] ARM: kirkwood: Move the crypto node under the mbus node
Message-ID: <20130917184309.GE21230@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There should be no nodes that are not children of the mbus. Move
the crypto node under the mbus.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 arch/arm/boot/dts/kirkwood.dtsi | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

[oops, ARM: kirkwood - Remove kirkwood_setup_wins and rely on
 the DT binding was 1/3]

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index d1bbe95..76b1627 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -35,13 +35,22 @@
 		controller = <&mbusc>;
 		pcie-mem-aperture = <0xe0000000 0x10000000>; /* 256 MiB memory space */
 		pcie-io-aperture  = <0xf2000000 0x100000>;   /*   1 MiB    I/O space */
+
+		crypto at 0301 {
+			compatible = "marvell,orion-crypto";
+			reg = <MBUS_ID(0xf0, 0x01) 0x30000 0x10000>,
+			      <MBUS_ID(0x03, 0x01) 0 0x800>;
+			reg-names = "regs", "sram";
+			interrupts = <22>;
+			clocks = <&gate_clk 17>;
+			status = "okay";
+		};
 	};
 
 	ocp at f1000000 {
 		compatible = "simple-bus";
 		ranges = <0x00000000 0xf1000000 0x0100000
-		          0xf4000000 0xf4000000 0x0000400
-		          0xf5000000 0xf5000000 0x0000400>;
+		          0xf4000000 0xf4000000 0x0000400>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 
@@ -222,16 +231,6 @@
 			status = "disabled";
 		};
 
-		crypto at 30000 {
-			compatible = "marvell,orion-crypto";
-			reg = <0x30000 0x10000>,
-			      <0xf5000000 0x800>;
-			reg-names = "regs", "sram";
-			interrupts = <22>;
-			clocks = <&gate_clk 17>;
-			status = "okay";
-		};
-
 		mdio: mdio-bus at 72004 {
 			compatible = "marvell,orion-mdio";
 			#address-cells = <1>;
-- 
1.8.1.2
