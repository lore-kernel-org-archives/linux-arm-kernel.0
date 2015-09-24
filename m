From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 24 Sep 2015 17:26:50 +0300
Subject: [PATCH 09/17] ARM: dts: OMAP24xx: add reset data
In-Reply-To: <1443104818-993-1-git-send-email-t-kristo@ti.com>
References: <1443104818-993-1-git-send-email-t-kristo@ti.com>
Message-ID: <1443104818-993-10-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add iva, dsp and system reset control as DT data..

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap2420.dtsi |   24 ++++++++++++++++++++++++
 arch/arm/boot/dts/omap2430.dtsi |   17 +++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index 5b9a376..cfb802d 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -13,6 +13,23 @@
 / {
 	compatible = "ti,omap2420", "ti,omap2";
 
+	soc {
+		iva {
+			compatible = "ti,omap2420-iva";
+			ti,hwmods = "iva";
+			reset-names = "iva";
+			resets = <&prcm 0x800 0 8 0 8>;
+		};
+
+		dsp {
+			ti,hwmods = "dsp";
+			compatible = "ti,omap2420-dsp";
+			reset-names = "logic", "mmu";
+			resets = <&prcm 0x800 0 0 0 4>,
+				 <&prcm 0x800 0 1 0 5>;
+		};
+	};
+
 	ocp {
 		l4: l4 at 48000000 {
 			compatible = "ti,omap2-l4", "simple-bus";
@@ -23,6 +40,7 @@
 			prcm: prcm at 8000 {
 				compatible = "ti,omap2-prcm";
 				reg = <0x8000 0x1000>;
+				#reset-cells = <5>;
 
 				prcm_clocks: clocks {
 					#address-cells = <1>;
@@ -31,6 +49,12 @@
 
 				prcm_clockdomains: clockdomains {
 				};
+
+				system_reset: system_reset {
+					compatible = "ti,system-reset";
+					reset-names = "system";
+					resets = <&prcm 0x400 0 2 0 0>;
+				};
 			};
 
 			scm: scm at 0 {
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index 2390f38..0d5f0d6 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -13,6 +13,16 @@
 / {
 	compatible = "ti,omap2430", "ti,omap2";
 
+	soc {
+		iva {
+			compatible = "ti,iva2.1";
+			ti,hwmods = "iva";
+			reset-names = "logic", "mmu";
+			resets = <&prcm 0x800 0 0 0 4>,
+				 <&prcm 0x800 0 1 0 5>;
+		};
+	};
+
 	ocp {
 		l4_wkup: l4_wkup at 49000000 {
 			compatible = "ti,omap2-l4-wkup", "simple-bus";
@@ -23,6 +33,7 @@
 			prcm: prcm at 6000 {
 				compatible = "ti,omap2-prcm";
 				reg = <0x6000 0x1000>;
+				#reset-cells = <5>;
 
 				prcm_clocks: clocks {
 					#address-cells = <1>;
@@ -31,6 +42,12 @@
 
 				prcm_clockdomains: clockdomains {
 				};
+
+				system_reset: system_reset {
+					compatible = "ti,system-reset";
+					reset-names = "system";
+					resets = <&prcm 0x400 0 2 0 0>;
+				};
 			};
 
 			scm: scm at 2000 {
-- 
1.7.9.5
