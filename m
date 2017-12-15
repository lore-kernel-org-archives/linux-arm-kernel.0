From: malat@debian.org (Mathieu Malaterre)
Date: Fri, 15 Dec 2017 13:46:28 +0100
Subject: [PATCH 03/25] arm: bcm: dts: Remove leading 0x and 0s from bindings
 notation
Message-ID: <20171215124628.30029-1-malat@debian.org>
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
 arch/arm/boot/dts/bcm11351.dtsi | 2 +-
 arch/arm/boot/dts/bcm21664.dtsi | 2 +-
 arch/arm/boot/dts/bcm283x.dtsi  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 18045c38bcf1..db7cded1b7ad 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -55,7 +55,7 @@
 		      <0x3ff00100 0x100>;
 	};
 
-	smc at 0x3404c000 {
+	smc at 3404c000 {
 		compatible = "brcm,bcm11351-smc", "brcm,kona-smc";
 		reg = <0x3404c000 0x400>; /* 1 KiB in SRAM */
 	};
diff --git a/arch/arm/boot/dts/bcm21664.dtsi b/arch/arm/boot/dts/bcm21664.dtsi
index 6dde95f21cef..266f2611dc22 100644
--- a/arch/arm/boot/dts/bcm21664.dtsi
+++ b/arch/arm/boot/dts/bcm21664.dtsi
@@ -55,7 +55,7 @@
 		      <0x3ff00100 0x100>;
 	};
 
-	smc at 0x3404e000 {
+	smc at 3404e000 {
 		compatible = "brcm,bcm21664-smc", "brcm,kona-smc";
 		reg = <0x3404e000 0x400>; /* 1 KiB in SRAM */
 	};
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index dcde93c85c2d..2ee4f04ea9d4 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -464,7 +464,7 @@
 			status = "disabled";
 		};
 
-		aux: aux at 0x7e215000 {
+		aux: aux at 7e215000 {
 			compatible = "brcm,bcm2835-aux";
 			#clock-cells = <1>;
 			reg = <0x7e215000 0x8>;
-- 
2.11.0
