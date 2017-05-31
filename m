From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 30 May 2017 18:21:25 -0700
Subject: [PATCH] ARM: dts: da850-evm: fix tca6416 for use with GPIO hogs
Message-ID: <20170531012125.12258-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order GPIOS from this controller to be used with the "gpio-hogs"
property, the tca6416 node has to properly labeled as a gpio-controller,
and use #gpio-cells.

With that, the SEL_A, SEL_B, SEL_C lines that are used to select VPIF
input can be configured using GPIO hogs.

As an example, example, the configuration below selects the analog video
input on the da850-evm UI board:

&tca6416 {
	 status = "okay";

	 sel_a {
		gpio-hog;
		gpios = <7 GPIO_ACTIVE_HIGH>;
		output-high;
		line-name = "ADC_ENn";
	 };
	 sel_b {
		gpio-hog;
		gpios = <6 GPIO_ACTIVE_HIGH>;
		output-high;
		line-name = "CAMERA_ENn";
	 };
	 sel_c {
		gpio-hog;
		gpios = <5 GPIO_ACTIVE_HIGH>;
		output-low;
		line-name = "VIDEO_IN_ENn";
	 };
};

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm/boot/dts/da850-evm.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 8d244cd76c36..a423e8ebfb37 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -82,6 +82,8 @@
 			tca6416: gpio at 20 {
 				compatible = "ti,tca6416";
 				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 		};
 		wdt: wdt at 21000 {
-- 
2.9.3
