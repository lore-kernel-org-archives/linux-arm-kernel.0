From: rasmus.villemoes@prevas.dk (Rasmus Villemoes)
Date: Fri, 23 Feb 2018 14:31:14 +0100
Subject: [RFC PATCH] ARM: dts: ls1021a: add size-cells and address-cells to
 scfg and dcfg nodes
Message-ID: <20180223133114.7091-1-rasmus.villemoes@prevas.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A single u32 is sufficient to specify a register in the Device
Configuration Unit/Supplemental Configuration Unit. Moreover, they only
consist of 32 bit registers (for the DCFG we even have "These registers
only support 32-bit accesses." according to the reference manual), so no
size specification is needed.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
None of the in-tree .dts files using ls1021a.dtsi currently define a
subnode of either node. It is possible, though somewhat unlikely, that
some out-of-tree .dts file is built against the in-tree ls1021a.dtsi,
and I don't know if such files are treated the same as out-of-tree
modules (i.e., they get to fix the breakage).

The reason I'm proposing to add these is that I'm about to add a subnode
of scfg with a reg property, and if possible I'd like to avoid the
somewhat clumsy

  reg = <0 0x1ac 0 4>;

when reg = <0x1ac>; would convey the same information. But if the
#address-cells and #size-cells properties are set in stone once the
.dtsi is in mainline, I'll just accept the clumsiness.

arch/arm/boot/dts/ls1021a.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c31dad98f989..3c9fadcd611d 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -159,6 +159,8 @@
 		dcfg: dcfg at 1ee0000 {
 			compatible = "fsl,ls1021a-dcfg", "syscon";
 			reg = <0x0 0x1ee0000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			big-endian;
 		};
 
@@ -202,6 +204,8 @@
 		scfg: scfg at 1570000 {
 			compatible = "fsl,ls1021a-scfg", "syscon";
 			reg = <0x0 0x1570000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			big-endian;
 		};
 
-- 
2.15.1
