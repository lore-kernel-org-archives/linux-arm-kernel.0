From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 13 Feb 2015 18:12:50 +0200
Subject: [PATCHv2 31/33] ARM: dts: omap5: add nodes for control module core
 instances
In-Reply-To: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Message-ID: <1423843973-6050-29-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for control module core generic and padconf memory spaces.
These nodes add syscon support for shared access, and the duplicate
omap5_padconf_global node is removed with the same patch. Kernel support
for the new compatible strings is going to be added in a separate patch.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/arm/omap/ctrl.txt          |    2 ++
 arch/arm/boot/dts/omap5.dtsi                       |   19 ++++++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/ctrl.txt b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
index 02fb500..99f81ea 100644
--- a/Documentation/devicetree/bindings/arm/omap/ctrl.txt
+++ b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
@@ -17,6 +17,8 @@ Required properties:
 		"ti,omap3-scrm"
 		"ti,omap4-ctrl-gen-core"
 		"ti,omap4-ctrl-pad-core"
+		"ti,omap5-ctrl-gen-core"
+		"ti,omap5-ctrl-pad-core"
 - reg:		Contains Control Module register address range
 		(base address and length)
 
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index b321fdf..8d49116 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -182,6 +182,16 @@
 			};
 		};
 
+		ctrl_gen_core: ctrl_gen_core at 4a002000 {
+			compatible = "ti,omap5-ctrl-gen-core", "syscon";
+			reg = <0x4a002000 0x800>;
+		};
+
+		ctrl_pad_core: ctrl_pad_core at 4a002800 {
+			compatible = "ti,omap5-ctrl-pad-core", "syscon";
+			reg = <0x4a002800 0x800>;
+		};
+
 		counter32k: counter at 4ae04000 {
 			compatible = "ti,omap-counter32k";
 			reg = <0x4ae04000 0x40>;
@@ -209,15 +219,10 @@
 			pinctrl-single,function-mask = <0x7fff>;
 		};
 
-		omap5_padconf_global: tisyscon at 4a002da0 {
-			compatible = "syscon";
-			reg = <0x4A002da0 0xec>;
-		};
-
 		pbias_regulator: pbias_regulator {
 			compatible = "ti,pbias-omap";
-			reg = <0x60 0x4>;
-			syscon = <&omap5_padconf_global>;
+			reg = <0x600 0x4>;
+			syscon = <&ctrl_pad_core>;
 			pbias_mmc_reg: pbias_mmc_omap5 {
 				regulator-name = "pbias_mmc_omap5";
 				regulator-min-microvolt = <1800000>;
-- 
1.7.9.5
