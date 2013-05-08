From: jason@lakedaemon.net (Jason Cooper)
Date: Wed,  8 May 2013 19:23:34 +0000
Subject: [RFC PATCH 3/3] ARM: omap3: wireless plus gpmc wip
In-Reply-To: <cover.1368038129.git.jason@lakedaemon.net>
References: <cover.1368038129.git.jason@lakedaemon.net>
Message-ID: <35ebdefa151c2f2d49ccfed5ddba0cd627963581.1368038129.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Need this in order to add the nand node and then the partitions.

in it's current state, crashes the system. :(
---
 arch/arm/boot/dts/omap3-wireless_plus.dts | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-wireless_plus.dts b/arch/arm/boot/dts/omap3-wireless_plus.dts
index 8a0acdf..6f33731 100644
--- a/arch/arm/boot/dts/omap3-wireless_plus.dts
+++ b/arch/arm/boot/dts/omap3-wireless_plus.dts
@@ -17,6 +17,23 @@
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
+
+	gpmc: gpmc at 6800A000 {
+		compatible = "ti,omap2430-gpmc";
+		ti,hwmods = "gpmc";
+		reg = <0x6800A000 0x2000>;
+		/* interrupts = <100>; */
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpmc_pins>;
+
+		gpmc,num-cs = <8>;
+		gpmc,num-waitpins = <2>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0 0 0x08000000 0x10000000>;
+
+		/* child nodes go here */
+	};
 };
 
 &omap3_pmx_core {
@@ -26,7 +43,7 @@
 	 * itself during the boot (or just set them up in the bootloader)
 	 */
 	pinctrl-names = "default";
-	pinctrl-0 = <&sdrc_pins &gpmc_pins &hsusb1_pins>;
+	pinctrl-0 = <&sdrc_pins &hsusb1_pins>;
 
 	/* AM3703CUS pins for this board */
 	sdrc_pins: pinmux_sdrc_pins {
-- 
1.8.2.1
