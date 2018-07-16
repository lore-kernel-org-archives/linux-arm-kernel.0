From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 16 Jul 2018 12:11:51 +0200
Subject: [PATCH 6/6] ARM64: dts: meson-axg: add the audio clock controller
In-Reply-To: <20180716101151.31109-1-jbrunet@baylibre.com>
References: <20180716101151.31109-1-jbrunet@baylibre.com>
Message-ID: <20180716101151.31109-7-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the audio clock controller which is part of the audio bus
This controller takes 8 input plls, and the usual clock gate, from the
main clock controller. It provides the clocs for the all the devices of
the audio subsystem, such as tdms, spdif, pdm, etc.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 36 ++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 461be4a35f92..6adc8d3dbf0a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/axg-audio-clkc.h>
 #include <dt-bindings/clock/axg-clkc.h>
 #include <dt-bindings/clock/axg-aoclkc.h>
 #include <dt-bindings/gpio/meson-axg-gpio.h>
@@ -155,6 +156,41 @@
 			};
 		};
 
+		audio: bus at ff642000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xff642000 0x0 0x2000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xff642000 0x0 0x2000>;
+
+			clkc_audio: clock-controller at 0 {
+				compatible = "amlogic,axg-audio-clkc";
+				reg = <0x0 0x0 0x0 0xb4>;
+				#clock-cells = <1>;
+
+				clocks = <&clkc CLKID_AUDIO>,
+					 <&clkc CLKID_MPLL0>,
+					 <&clkc CLKID_MPLL1>,
+					 <&clkc CLKID_MPLL2>,
+					 <&clkc CLKID_MPLL3>,
+					 <&clkc CLKID_HIFI_PLL>,
+					 <&clkc CLKID_FCLK_DIV3>,
+					 <&clkc CLKID_FCLK_DIV4>,
+					 <&clkc CLKID_GP0_PLL>;
+				clock-names = "pclk",
+					      "mst_in0",
+					      "mst_in1",
+					      "mst_in2",
+					      "mst_in3",
+					      "mst_in4",
+					      "mst_in5",
+					      "mst_in6",
+					      "mst_in7";
+
+				resets = <&reset RESET_AUDIO>;
+			};
+		};
+
 		cbus: bus at ffd00000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xffd00000 0x0 0x25000>;
-- 
2.14.4
