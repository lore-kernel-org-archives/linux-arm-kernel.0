From: malat@debian.org (Mathieu Malaterre)
Date: Fri, 15 Dec 2017 13:46:47 +0100
Subject: [PATCH 15/25] arm: versatile: dts: Remove leading 0x and 0s from
 bindings notation
Message-ID: <20171215124648.30641-1-malat@debian.org>
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
 arch/arm/boot/dts/versatile-ab.dts | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index 4a51612996bc..2f60ecd7741e 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -24,7 +24,7 @@
 		reg = <0x0 0x08000000>;
 	};
 
-	xtal24mhz: xtal24mhz at 24M {
+	xtal24mhz: xtal24mhz at 24m {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
@@ -34,7 +34,7 @@
 		compatible = "arm,core-module-versatile", "syscon", "simple-mfd";
 		reg = <0x10000000 0x200>;
 
-		led at 08.0 {
+		led at 8.0 {
 			compatible = "register-bit-led";
 			offset = <0x08>;
 			mask = <0x01>;
@@ -42,7 +42,7 @@
 			linux,default-trigger = "heartbeat";
 			default-state = "on";
 		};
-		led at 08.1 {
+		led at 8.1 {
 			compatible = "register-bit-led";
 			offset = <0x08>;
 			mask = <0x02>;
@@ -50,7 +50,7 @@
 			linux,default-trigger = "mmc0";
 			default-state = "off";
 		};
-		led at 08.2 {
+		led at 8.2 {
 			compatible = "register-bit-led";
 			offset = <0x08>;
 			mask = <0x04>;
@@ -58,35 +58,35 @@
 			linux,default-trigger = "cpu0";
 			default-state = "off";
 		};
-		led at 08.3 {
+		led at 8.3 {
 			compatible = "register-bit-led";
 			offset = <0x08>;
 			mask = <0x08>;
 			label = "versatile:3";
 			default-state = "off";
 		};
-		led at 08.4 {
+		led at 8.4 {
 			compatible = "register-bit-led";
 			offset = <0x08>;
 			mask = <0x10>;
 			label = "versatile:4";
 			default-state = "off";
 		};
-		led at 08.5 {
+		led at 8.5 {
 			compatible = "register-bit-led";
 			offset = <0x08>;
 			mask = <0x20>;
 			label = "versatile:5";
 			default-state = "off";
 		};
-		led at 08.6 {
+		led at 8.6 {
 			compatible = "register-bit-led";
 			offset = <0x08>;
 			mask = <0x40>;
 			label = "versatile:6";
 			default-state = "off";
 		};
-		led at 08.7 {
+		led at 8.7 {
 			compatible = "register-bit-led";
 			offset = <0x08>;
 			mask = <0x80>;
@@ -95,14 +95,14 @@
 		};
 
 		/* OSC1 on AB, OSC4 on PB */
-		osc1: cm_aux_osc at 24M {
+		osc1: cm_aux_osc at 24m {
 			#clock-cells = <0>;
 			compatible = "arm,versatile-cm-auxosc";
 			clocks = <&xtal24mhz>;
 		};
 
 		/* The timer clock is the 24 MHz oscillator divided to 1MHz */
-		timclk: timclk at 1M {
+		timclk: timclk at 1m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <24>;
@@ -110,7 +110,7 @@
 			clocks = <&xtal24mhz>;
 		};
 
-		pclk: pclk at 24M {
+		pclk: pclk at 24m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <1>;
-- 
2.11.0
