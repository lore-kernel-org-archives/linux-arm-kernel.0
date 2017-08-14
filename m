From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 14 Aug 2017 23:59:00 +0200
Subject: [PATCH v6 6/6] ARM: dts: meson8b: add support for booting the
 secondary CPU cores
In-Reply-To: <20170814215900.1032-1-martin.blumenstingl@googlemail.com>
References: <20170814215900.1032-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170814215900.1032-7-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@caione.org>

Booting the secondary CPU cores involves the following nodes/devices:
- SCU (Snoop-Control-Unit, for which we already have a DT node)
- a reset line for each CPU core, provided by the reset-controller
  which is built into the clock-controller
- the PMU (power management unit) which controls the power of the CPU
  cores
- a range in the SRAM specifically reserved for booting secondary CPU
  cores
- the "enable-method" which activates booting the secondary CPU cores

This adds all required nodes and properties to boot the secondary CPU
cores.

Signed-off-by: Carlo Caione <carlo@caione.org>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index bc278da7df0d..aaebfcce9073 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -47,6 +47,7 @@
 #include <dt-bindings/clock/meson8b-clkc.h>
 #include <dt-bindings/gpio/meson8b-gpio.h>
 #include <dt-bindings/reset/amlogic,meson8b-reset.h>
+#include <dt-bindings/reset/amlogic,meson8b-clkc-reset.h>
 #include "meson.dtsi"
 
 / {
@@ -59,6 +60,8 @@
 			compatible = "arm,cortex-a5";
 			next-level-cache = <&L2>;
 			reg = <0x200>;
+			enable-method = "amlogic,meson8b-smp";
+			resets = <&clkc CLKC_RESET_CPU0_SOFT_RESET>;
 		};
 
 		cpu at 201 {
@@ -66,6 +69,8 @@
 			compatible = "arm,cortex-a5";
 			next-level-cache = <&L2>;
 			reg = <0x201>;
+			enable-method = "amlogic,meson8b-smp";
+			resets = <&clkc CLKC_RESET_CPU1_SOFT_RESET>;
 		};
 
 		cpu at 202 {
@@ -73,6 +78,8 @@
 			compatible = "arm,cortex-a5";
 			next-level-cache = <&L2>;
 			reg = <0x202>;
+			enable-method = "amlogic,meson8b-smp";
+			resets = <&clkc CLKC_RESET_CPU2_SOFT_RESET>;
 		};
 
 		cpu at 203 {
@@ -80,6 +87,8 @@
 			compatible = "arm,cortex-a5";
 			next-level-cache = <&L2>;
 			reg = <0x203>;
+			enable-method = "amlogic,meson8b-smp";
+			resets = <&clkc CLKC_RESET_CPU3_SOFT_RESET>;
 		};
 	};
 
@@ -90,6 +99,11 @@
 }; /* end of / */
 
 &aobus {
+	pmu: pmu at e0 {
+		compatible = "amlogic,meson8b-pmu", "syscon";
+		reg = <0xe0 0x18>;
+	};
+
 	pinctrl_aobus: pinctrl at 84 {
 		compatible = "amlogic,meson8b-aobus-pinctrl";
 		reg = <0x84 0xc>;
@@ -157,6 +171,13 @@
 	};
 };
 
+&ahb_sram {
+	smp-sram at 1ff80 {
+		compatible = "amlogic,meson8b-smp-sram";
+		reg = <0x1ff80 0x8>;
+	};
+};
+
 &ethmac {
 	clocks = <&clkc CLKID_ETH>;
 	clock-names = "stmmaceth";
-- 
2.14.1
