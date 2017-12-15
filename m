From: malat@debian.org (Mathieu Malaterre)
Date: Fri, 15 Dec 2017 13:46:48 +0100
Subject: [PATCH 16/25] arm: zx: dts: Remove leading 0x and 0s from bindings
 notation
Message-ID: <20171215124649.30692-1-malat@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Improve the DTS files by removing all the leading "0x" and zeros to fix the
following dtc warnings:

Warning (unit_address_format): Node /XXX unit name should not have leading "0x"

and

Warning (unit_address_format): Node /XXX unit name should not have leading 0s

Converted using the following command:

find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed -i -e "s/@\([0-9a-fA-FxX\.;:#]+\)\s*{/@\L\1 {/g" -e "s/@0x\(.*\) {/@\1 {/g" -e "s/@0+\(.*\) {/@\1 {/g" {} +^C

For simplicity, two sed expressions were used to solve each warnings separately.

To make the regex expression more robust a few other issues were resolved,
namely setting unit-address to lower case, and adding a whitespace before the
the opening curly brace:

https://elinux.org/Device_Tree_Linux#Linux_conventions

This will solve as a side effect warning:

Warning (simple_bus_reg): Node /XXX@<UPPER> simple-bus unit address format error, expected "<lower>"

This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")

Reported-by: David Daney <ddaney@caviumnetworks.com>
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/arm/boot/dts/zx296702.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/zx296702.dtsi b/arch/arm/boot/dts/zx296702.dtsi
index 8a74efdb6360..240e7a23d81f 100644
--- a/arch/arm/boot/dts/zx296702.dtsi
+++ b/arch/arm/boot/dts/zx296702.dtsi
@@ -56,7 +56,7 @@
 			clocks = <&topclk ZX296702_A9_PERIPHCLK>;
 		};
 
-		l2cc: l2-cache-controller at 0x00c00000 {
+		l2cc: l2-cache-controller at c00000 {
 			compatible = "arm,pl310-cache";
 			reg = <0x00c00000 0x1000>;
 			cache-unified;
@@ -67,30 +67,30 @@
 			arm,double-linefill-incr = <0>;
 		};
 
-		pcu: pcu at 0xa0008000 {
+		pcu: pcu at a0008000 {
 			compatible = "zte,zx296702-pcu";
 			reg = <0xa0008000 0x1000>;
 		};
 
-		topclk: topclk at 0x09800000 {
+		topclk: topclk at 9800000 {
 			compatible = "zte,zx296702-topcrm-clk";
 			reg = <0x09800000 0x1000>;
 			#clock-cells = <1>;
 		};
 
-		lsp1clk: lsp1clk at 0x09400000 {
+		lsp1clk: lsp1clk at 9400000 {
 			compatible = "zte,zx296702-lsp1crpm-clk";
 			reg = <0x09400000 0x1000>;
 			#clock-cells = <1>;
 		};
 
-		lsp0clk: lsp0clk at 0x0b000000 {
+		lsp0clk: lsp0clk at b000000 {
 			compatible = "zte,zx296702-lsp0crpm-clk";
 			reg = <0x0b000000 0x1000>;
 			#clock-cells = <1>;
 		};
 
-		uart0: serial at 0x09405000 {
+		uart0: serial at 9405000 {
 			compatible = "zte,zx296702-uart";
 			reg = <0x09405000 0x1000>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
@@ -98,7 +98,7 @@
 			status = "disabled";
 		};
 
-		uart1: serial at 0x09406000 {
+		uart1: serial at 9406000 {
 			compatible = "zte,zx296702-uart";
 			reg = <0x09406000 0x1000>;
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
@@ -106,7 +106,7 @@
 			status = "disabled";
 		};
 
-		mmc0: mmc at 0x09408000 {
+		mmc0: mmc at 9408000 {
 			compatible = "snps,dw-mshc";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -119,7 +119,7 @@
 			status = "disabled";
 		};
 
-		mmc1: mmc at 0x0b003000 {
+		mmc1: mmc at b003000 {
 			compatible = "snps,dw-mshc";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -132,7 +132,7 @@
 			status = "disabled";
 		};
 
-		sysctrl: sysctrl at 0xa0007000 {
+		sysctrl: sysctrl at a0007000 {
 			compatible = "zte,sysctrl", "syscon";
 			reg = <0xa0007000 0x1000>;
 		};
-- 
2.11.0
