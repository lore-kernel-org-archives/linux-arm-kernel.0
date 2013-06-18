From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 18 Jun 2013 12:31:19 -0300
Subject: [PATCH] ARM: Kirkwood: Fix the internal register ranges translation
Message-ID: <1371569479-31498-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although the internal register window size is 1 MiB, the previous
ranges translation for the internal register space had a size of
0x4000000. This was done to allow the crypto and nand node to access
the corresponding 'sram' and 'nand' decoding windows.

In order to describe the hardware more accurately, we declare the
real 1 MiB internal register space in the ranges, and add a translation
entry for the nand node to access the 'nand' window.

This commit will make future improvements on the MBus DT binding easier.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
Tested on Plathome Openblocks A6 board.

 arch/arm/boot/dts/kirkwood.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 8a1e3bb..910fabc 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -38,7 +38,8 @@
 
 	ocp at f1000000 {
 		compatible = "simple-bus";
-		ranges = <0x00000000 0xf1000000 0x4000000
+		ranges = <0x00000000 0xf1000000 0x0100000
+		          0xf4000000 0xf4000000 0x0000400
 		          0xf5000000 0xf5000000 0x0000400>;
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -171,7 +172,7 @@
 			ale = <1>;
 			bank-width = <1>;
 			compatible = "marvell,orion-nand";
-			reg = <0x3000000 0x400>;
+			reg = <0xf4000000 0x400>;
 			chip-delay = <25>;
 			/* set partition map and/or chip-delay in board dts */
 			clocks = <&gate_clk 7>;
-- 
1.8.1.5
