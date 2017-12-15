From: malat@debian.org (Mathieu Malaterre)
Date: Fri, 15 Dec 2017 13:46:21 +0100
Subject: [PATCH 01/25] arm: artpec: dts: Remove leading 0x and 0s from
 bindings notation
Message-ID: <20171215124621.29928-1-malat@debian.org>
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
 arch/arm/boot/dts/artpec6.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/artpec6.dtsi
index 2ed11773048d..71e0e75e986b 100644
--- a/arch/arm/boot/dts/artpec6.dtsi
+++ b/arch/arm/boot/dts/artpec6.dtsi
@@ -98,7 +98,7 @@
 		clock-frequency = <125000000>;
 	};
 
-	clkctrl: clkctrl at 0xf8000000 {
+	clkctrl: clkctrl at f8000000 {
 		#clock-cells = <1>;
 		compatible = "axis,artpec6-clkctrl";
 		reg = <0xf8000000 0x48>;
-- 
2.11.0
