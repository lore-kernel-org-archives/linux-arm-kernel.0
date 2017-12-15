From: malat@debian.org (Mathieu Malaterre)
Date: Fri, 15 Dec 2017 13:46:53 +0100
Subject: [PATCH 20/25] arm: kirkwood: dts: Remove leading 0x and 0s from
 bindings notation
Message-ID: <20171215124653.30902-1-malat@debian.org>
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
 arch/arm/boot/dts/kirkwood-linksys-viper.dts | 10 +++++-----
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi   |  2 +-
 arch/arm/boot/dts/kirkwood-ts219.dtsi        |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-linksys-viper.dts b/arch/arm/boot/dts/kirkwood-linksys-viper.dts
index df7851820507..f21a50dd9869 100644
--- a/arch/arm/boot/dts/kirkwood-linksys-viper.dts
+++ b/arch/arm/boot/dts/kirkwood-linksys-viper.dts
@@ -157,7 +157,7 @@
 			reg = <0x80000 0x20000>;
 		};
 
-		partition at A0000 {
+		partition at a0000 {
 			label = "s_env";
 			reg = <0xA0000 0x20000>;
 		};
@@ -167,17 +167,17 @@
 			reg = <0x200000 0x2A0000>;
 		};
 
-		partition at 4A0000 {
+		partition at 4a0000 {
 			label = "rootfs";
 			reg = <0x4A0000 0x1760000>;
 		};
 
-		partition at 1C00000 {
+		partition at 1c00000 {
 			label = "alt_kernel";
 			reg = <0x1C00000 0x2A0000>;
 		};
 
-		partition at 1EA0000 {
+		partition at 1ea0000 {
 			label = "alt_rootfs";
 			reg = <0x1EA0000 0x1760000>;
 		};
@@ -187,7 +187,7 @@
 			reg = <0x3600000 0x4A00000>;
 		};
 
-		partition at C0000 {
+		partition at c0000 {
 			label = "unused";
 			reg = <0xC0000 0x140000>;
 		};
diff --git a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
index 51530ea86622..dc52e3ca7536 100644
--- a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
@@ -84,7 +84,7 @@
 &mdio {
 	status = "okay";
 
-	ethphy0: ethernet-phy at X {
+	ethphy0: ethernet-phy at x {
                 /* overwrite reg property in board file */
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-ts219.dtsi b/arch/arm/boot/dts/kirkwood-ts219.dtsi
index a88eb22070a1..1d3a7fbe1ca9 100644
--- a/arch/arm/boot/dts/kirkwood-ts219.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ts219.dtsi
@@ -85,7 +85,7 @@
 &mdio {
 	status = "okay";
 
-	ethphy0: ethernet-phy at X {
+	ethphy0: ethernet-phy at x {
                 /* overwrite reg property in board file */
 	};
 };
-- 
2.11.0
