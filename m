From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 May 2015 22:54:05 +0200
Subject: [PATCH v2 6/7] ARM: sunxi: Add codec clock support
In-Reply-To: <1432241646-9511-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1432241646-9511-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1432241646-9511-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emilio L?pez <emilio@elopez.com.ar>

This commit adds the codec clock definition to the sun4i, sun5i and
sun7i device trees. The codec clock is used in the analog codec block.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 9 +++++++++
 arch/arm/boot/dts/sun5i.dtsi      | 9 +++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi  | 9 +++++++++
 drivers/clk/sunxi/clk-a10-codec.c | 1 -
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 235e5204742f..dfa8cd2d3ba8 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -45,6 +45,7 @@
 
 #include <dt-bindings/thermal/thermal.h>
 
+#include <dt-bindings/clock/sun4i-a10-pll2.h>
 #include <dt-bindings/dma/sun4i-a10.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
@@ -455,6 +456,14 @@
 			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
 			clock-output-names = "spi3";
 		};
+
+		codec_clk: clk at 01c20140 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-codec-clk";
+			reg = <0x01c20140 0x4>;
+			clocks = <&pll2 SUN4I_A10_PLL2_1X>;
+			clock-output-names = "codec";
+		};
 	};
 
 	/*
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 2f553a92a6dc..ab5184d2094d 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -44,6 +44,7 @@
 
 #include "skeleton.dtsi"
 
+#include <dt-bindings/clock/sun4i-a10-pll2.h>
 #include <dt-bindings/dma/sun4i-a10.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
@@ -293,6 +294,14 @@
 			clock-output-names = "usb_ohci0", "usb_phy";
 		};
 
+		codec_clk: clk at 01c20140 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-codec-clk";
+			reg = <0x01c20140 0x4>;
+			clocks = <&pll2 SUN4I_A10_PLL2_1X>;
+			clock-output-names = "codec";
+		};
+
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun5i-a13-mbus-clk";
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 0141cc9876a7..b5ecfa5fa0eb 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -47,6 +47,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 
+#include <dt-bindings/clock/sun4i-a10-pll2.h>
 #include <dt-bindings/dma/sun4i-a10.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
@@ -469,6 +470,14 @@
 			clock-output-names = "spi3";
 		};
 
+		codec_clk: clk at 01c20140 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-codec-clk";
+			reg = <0x01c20140 0x4>;
+			clocks = <&pll2 SUN4I_A10_PLL2_1X>;
+			clock-output-names = "codec";
+		};
+
 		mbus_clk: clk at 01c2015c {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun5i-a13-mbus-clk";
diff --git a/drivers/clk/sunxi/clk-a10-codec.c b/drivers/clk/sunxi/clk-a10-codec.c
index aaeccf8cde39..ac321d6a0df5 100644
--- a/drivers/clk/sunxi/clk-a10-codec.c
+++ b/drivers/clk/sunxi/clk-a10-codec.c
@@ -15,7 +15,6 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/clkdev.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 
-- 
2.4.1
