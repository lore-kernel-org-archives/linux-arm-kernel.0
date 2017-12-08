From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 8 Dec 2017 09:54:18 +0800
Subject: [PATCH v4 2/2] ARM64: dts: meson-axg: add pinctrl DT info for
 Meson-AXG SoC
In-Reply-To: <20171208015418.9632-1-yixun.lan@amlogic.com>
References: <20171208015418.9632-1-yixun.lan@amlogic.com>
Message-ID: <20171208015418.9632-3-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xingyu Chen <xingyu.chen@amlogic.com>

Add new pinctrl DT info for the Amlogic's Meson-AXG SoC.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 44 ++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index e7213eb53958..7b24f83ab4bf 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/gpio/meson-axg-gpio.h>
 
 / {
 	compatible = "amlogic,meson-axg";
@@ -157,6 +158,32 @@
 			#mbox-cells = <1>;
 		};
 
+		periphs: periphs at ff634000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xff634000 0x0 0x2000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xff634000 0x0 0x2000>;
+
+			pinctrl_periphs: pinctrl at 480 {
+				compatible = "amlogic,meson-axg-periphs-pinctrl";
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges;
+
+				gpio: bank at 480 {
+					reg = <0x0 0x00480 0x0 0x40>,
+						<0x0 0x004e8 0x0 0x14>,
+						<0x0 0x00520 0x0 0x14>,
+						<0x0 0x00430 0x0 0x3c>;
+					reg-names = "mux", "pull", "pull-enable", "gpio";
+					gpio-controller;
+					#gpio-cells = <2>;
+					gpio-ranges = <&pinctrl_periphs 0 0 86>;
+				};
+			};
+		};
+
 		sram: sram at fffc0000 {
 			compatible = "amlogic,meson-axg-sram", "mmio-sram";
 			reg = <0x0 0xfffc0000 0x0 0x20000>;
@@ -182,6 +209,23 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
 
+			pinctrl_aobus: pinctrl at 14 {
+				compatible = "amlogic,meson-axg-aobus-pinctrl";
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges;
+
+				gpio_ao: bank at 14 {
+					reg = <0x0 0x00014 0x0 0x8>,
+						<0x0 0x0002c 0x0 0x4>,
+						<0x0 0x00024 0x0 0x8>;
+					reg-names = "mux", "pull", "gpio";
+					gpio-controller;
+					#gpio-cells = <2>;
+					gpio-ranges = <&pinctrl_aobus 0 0 15>;
+				};
+			};
+
 			uart_AO: serial at 3000 {
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
 				reg = <0x0 0x3000 0x0 0x18>;
-- 
2.15.1
