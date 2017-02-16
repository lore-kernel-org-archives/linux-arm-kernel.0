From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu, 16 Feb 2017 19:15:32 +0100
Subject: [PATCH 4/4] ARM: dts: da850-evm: add the UI expander node
In-Reply-To: <1487268932-6469-1-git-send-email-bgolaszewski@baylibre.com>
References: <1487268932-6469-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1487268932-6469-5-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we're using the UI board and want vpif capture, we need to select
the video capture functionality by driving the sel_c pin low on the
tca6416 expander and sel_a & sel_b pins high. Do it statically by
hogging relevant GPIOs in the device tree.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-evm.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index b549861..a90c764 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -9,6 +9,7 @@
  */
 /dts-v1/;
 #include "da850.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	compatible = "ti,da850-evm", "ti,da850";
@@ -78,7 +79,33 @@
 				DRVDD-supply = <&vbat>;
 				DVDD-supply = <&vbat>;
 			};
+			ui_expander: tca6416 at 20 {
+				compatible = "ti,tca6416";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
 
+				sel_a {
+					gpio-hog;
+					gpios = <7 GPIO_ACTIVE_HIGH>;
+					output-high;
+					line-name = "sel_a";
+				};
+
+				sel_b {
+					gpio-hog;
+					gpios = <6 GPIO_ACTIVE_HIGH>;
+					output-high;
+					line-name = "sel_b";
+				};
+
+				sel_c {
+					gpio-hog;
+					gpios = <5 GPIO_ACTIVE_HIGH>;
+					output-low;
+					line-name = "sel_c";
+				};
+			};
 		};
 		wdt: wdt at 21000 {
 			status = "okay";
-- 
2.9.3
