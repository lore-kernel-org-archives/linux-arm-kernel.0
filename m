From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 29 Aug 2016 09:56:10 +0200
Subject: [RFC PATCH 2/3] ARM64: dts: amlogic: Switch Meson GXL dtsi to use
 common GX dtsi
In-Reply-To: <1472457371-1305-1-git-send-email-narmstrong@baylibre.com>
References: <1472457371-1305-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1472457371-1305-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson GXL should use the common GX dtsi as base.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 133 +----------------------------
 1 file changed, 1 insertion(+), 132 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 2aa4555..16891e0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -41,139 +41,8 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "meson-gx-common.dtsi"
 
 / {
 	compatible = "amlogic,meson-gxl";
-	interrupt-parent = <&gic>;
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	cpus {
-		#address-cells = <0x2>;
-		#size-cells = <0x0>;
-
-		cpu0: cpu at 0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a53", "arm,armv8";
-			reg = <0x0 0x0>;
-			enable-method = "psci";
-		};
-
-		cpu1: cpu at 1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a53", "arm,armv8";
-			reg = <0x0 0x1>;
-			enable-method = "psci";
-		};
-
-		cpu2: cpu at 2 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a53", "arm,armv8";
-			reg = <0x0 0x2>;
-			enable-method = "psci";
-		};
-
-		cpu3: cpu at 3 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a53", "arm,armv8";
-			reg = <0x0 0x3>;
-			enable-method = "psci";
-		};
-	};
-
-	arm-pmu {
-		compatible = "arm,cortex-a53-pmu";
-		interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
-	};
-
-	psci {
-		compatible = "arm,psci-0.2";
-		method = "smc";
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13
-			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_EDGE_RISING)>,
-			     <GIC_PPI 14
-			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_EDGE_RISING)>,
-			     <GIC_PPI 11
-			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_EDGE_RISING)>,
-			     <GIC_PPI 10
-			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_EDGE_RISING)>;
-	};
-
-	xtal: xtal-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <24000000>;
-		clock-output-names = "xtal";
-		#clock-cells = <0>;
-	};
-
-	soc {
-		compatible = "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		cbus: cbus at c1100000 {
-			compatible = "simple-bus";
-			reg = <0x0 0xc1100000 0x0 0x100000>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xc1100000 0x0 0x100000>;
-
-			uart_A: serial at 84c0 {
-				compatible = "amlogic,meson-uart";
-				reg = <0x0 0x084c0 0x0 0x14>;
-				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>;
-				status = "disabled";
-			};
-		};
-
-		gic: interrupt-controller at c4301000 {
-			compatible = "arm,gic-400";
-			reg = <0x0 0xc4301000 0 0x1000>,
-			      <0x0 0xc4302000 0 0x2000>,
-			      <0x0 0xc4304000 0 0x2000>,
-			      <0x0 0xc4306000 0 0x2000>;
-			interrupt-controller;
-			interrupts = <GIC_PPI 9
-				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
-			#interrupt-cells = <3>;
-			#address-cells = <0>;
-		};
-
-		aobus: aobus at c8100000 {
-			compatible = "simple-bus";
-			reg = <0x0 0xc8100000 0x0 0x100000>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xc8100000 0x0 0x100000>;
-
-			uart_AO: serial at 4c0 {
-				compatible = "amlogic,meson-uart";
-				reg = <0x0 0x004c0 0x0 0x14>;
-				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&xtal>;
-				status = "disabled";
-			};
-		};
-
-		apb: apb at d0000000 {
-			compatible = "simple-bus";
-			reg = <0x0 0xd0000000 0x0 0x200000>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xd0000000 0x0 0x200000>;
-		};
-	};
 };
-- 
1.9.1
