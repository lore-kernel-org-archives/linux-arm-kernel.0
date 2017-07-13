From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 13 Jul 2017 12:31:12 +0200
Subject: [PATCH v3 5/6] ARM: dts: meson8: add support for booting the
 secondary CPU cores
In-Reply-To: <20170713103113.21560-1-martin.blumenstingl@googlemail.com>
References: <20170713103113.21560-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170713103113.21560-6-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Suggested-by: Carlo Caione <carlo@caione.org>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index b98d44fde6b6..9373d54aae21 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -60,6 +60,8 @@
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
 			reg = <0x200>;
+			enable-method = "amlogic,meson8-smp";
+			resets = <&clkc 0>;
 		};
 
 		cpu at 201 {
@@ -67,6 +69,8 @@
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
 			reg = <0x201>;
+			enable-method = "amlogic,meson8-smp";
+			resets = <&clkc 1>;
 		};
 
 		cpu at 202 {
@@ -74,6 +78,8 @@
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
 			reg = <0x202>;
+			enable-method = "amlogic,meson8-smp";
+			resets = <&clkc 2>;
 		};
 
 		cpu at 203 {
@@ -81,6 +87,8 @@
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
 			reg = <0x203>;
+			enable-method = "amlogic,meson8-smp";
+			resets = <&clkc 3>;
 		};
 	};
 
@@ -118,6 +126,11 @@
 }; /* end of / */
 
 &aobus {
+	pmu: pmu at e0 {
+		compatible = "amlogic,meson8-pmu", "syscon";
+		reg = <0xe0 0x8>;
+	};
+
 	pinctrl_aobus: pinctrl at 84 {
 		compatible = "amlogic,meson8-aobus-pinctrl";
 		reg = <0x84 0xc>;
@@ -249,6 +262,13 @@
 	};
 };
 
+&ahb_sram {
+	smp-sram at 1ff80 {
+		compatible = "amlogic,meson8-smp-sram";
+		reg = <0x1ff80 0x8>;
+	};
+};
+
 &ethmac {
 	clocks = <&clkc CLKID_ETH>;
 	clock-names = "stmmaceth";
-- 
2.13.2
