From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 24 Nov 2015 18:19:22 +0100
Subject: [PATCH v10 1/2] arm-soc: Import initial tango4 device tree
In-Reply-To: <56549B3A.8010703@sigmadesigns.com>
References: <56549B3A.8010703@sigmadesigns.com>
Message-ID: <56549C1A.8010109@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This device tree was tested on a Sigma Designs SMP8758 Vantage-1172
development board.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 arch/arm/boot/dts/Makefile                |   2 +
 arch/arm/boot/dts/tango4-common.dtsi      | 121 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tango4-smp8758.dtsi     |  31 ++++++++
 arch/arm/boot/dts/tango4-vantage-1172.dts |  29 +++++++
 4 files changed, 183 insertions(+)
 create mode 100644 arch/arm/boot/dts/tango4-common.dtsi
 create mode 100644 arch/arm/boot/dts/tango4-smp8758.dtsi
 create mode 100644 arch/arm/boot/dts/tango4-vantage-1172.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 246473a244f6..2499295051d5 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -605,6 +605,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 dtb-$(CONFIG_MACH_SUN9I) += \
 	sun9i-a80-optimus.dtb \
 	sun9i-a80-cubieboard4.dtb
+dtb-$(CONFIG_ARCH_TANGOX) += \
+	tango4-vantage-1172.dtb
 dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
 	tegra20-harmony.dtb \
 	tegra20-iris-512.dtb \
diff --git a/arch/arm/boot/dts/tango4-common.dtsi b/arch/arm/boot/dts/tango4-common.dtsi
new file mode 100644
index 000000000000..2a49aeea137f
--- /dev/null
+++ b/arch/arm/boot/dts/tango4-common.dtsi
@@ -0,0 +1,121 @@
+/*
+ * Based on Mans Rullgard's Tango3 DT
+ * https://github.com/mansr/linux-tangox
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	scu: scu at 20000000 {
+		compatible = "arm,cortex-a9-scu";
+		reg = <0x20000000 0x100>;
+	};
+
+	gic: interrupt-controller at 20001000 {
+		compatible = "arm,cortex-a9-gic";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x20001000 0x1000>, <0x20000100 0x0100>;
+	};
+
+	periphclk: periphclk {
+		compatible = "fixed-factor-clock";
+		clocks = <&clkgen 0>;
+		clock-mult = <1>;
+		clock-div  = <2>;
+		#clock-cells = <0>;
+	};
+
+	twd-timer at 20000600 {
+		compatible = "arm,cortex-a9-twd-timer";
+		reg = <0x20000600 0x10>;
+		interrupts = <GIC_PPI 13 0xf04>;
+		clocks = <&periphclk>;
+		always-on;
+	};
+
+	l2cc: l2-cache-controller at 20100000 {
+		compatible = "arm,pl310-cache";
+		reg = <0x20100000 0x1000>;
+		cache-level = <2>;
+		cache-unified;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&irq0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		xtal: xtal {
+			compatible = "fixed-clock";
+			clock-frequency = <27000000>;
+			#clock-cells = <0>;
+		};
+
+		clkgen: clkgen at 10000 {
+			compatible = "sigma,tango4-clkgen";
+			reg = <0x10000 0x40>;
+			clocks = <&xtal>;
+			clock-output-names = "cpuclk", "sysclk";
+			#clock-cells = <1>;
+		};
+
+		tick-counter at 10048 {
+			compatible = "sigma,tick-counter";
+			reg = <0x10048 0x4>;
+			clocks = <&xtal>;
+		};
+
+		uart: serial at 10700 {
+			compatible = "ralink,rt2880-uart";
+			reg = <0x10700 0x30>;
+			interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <7372800>;
+			reg-shift = <2>;
+		};
+
+		eth0: ethernet at 26000 {
+			compatible = "sigma,smp8734-ethernet";
+			reg = <0x26000 0x800>;
+			interrupts = <38 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clkgen 1>;
+		};
+
+		intc: interrupt-controller at 6e000 {
+			compatible = "sigma,smp8642-intc";
+			reg = <0x6e000 0x400>;
+			ranges = <0 0x6e000 0x400>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			irq0: irq0 at 000 {
+				reg = <0x000 0x100>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			irq1: irq1 at 100 {
+				reg = <0x100 0x100>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			irq2: irq2 at 300 {
+				reg = <0x300 0x100>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/tango4-smp8758.dtsi b/arch/arm/boot/dts/tango4-smp8758.dtsi
new file mode 100644
index 000000000000..7ed88ee629fb
--- /dev/null
+++ b/arch/arm/boot/dts/tango4-smp8758.dtsi
@@ -0,0 +1,31 @@
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "sigma,tango4-smp";
+
+		cpu0: cpu at 0 {
+			compatible = "arm,cortex-a9";
+			next-level-cache = <&l2cc>;
+			device_type = "cpu";
+			reg = <0>;
+		};
+
+		cpu1: cpu at 1 {
+			compatible = "arm,cortex-a9";
+			next-level-cache = <&l2cc>;
+			device_type = "cpu";
+			reg = <1>;
+		};
+	};
+
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupt-affinity = <&cpu0>, <&cpu1>;
+		interrupts =
+			<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
diff --git a/arch/arm/boot/dts/tango4-vantage-1172.dts b/arch/arm/boot/dts/tango4-vantage-1172.dts
new file mode 100644
index 000000000000..fcfac8231e7a
--- /dev/null
+++ b/arch/arm/boot/dts/tango4-vantage-1172.dts
@@ -0,0 +1,29 @@
+/dts-v1/;
+
+#include "tango4-smp8758.dtsi"
+#include "tango4-common.dtsi"
+
+/ {
+	model = "Sigma Designs SMP8758 Vantage-1172 Rev E1";
+	compatible = "sigma,vantage-1172", "sigma,smp8758", "sigma,tango4";
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>; /* 2 GB */
+	};
+};
+
+&eth0 {
+	phy-connection-type = "rgmii";
+	phy-handle = <&eth0_phy>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* Atheros AR8035 */
+	eth0_phy: ethernet-phy at 4 {
+		compatible = "ethernet-phy-id004d.d072",
+			     "ethernet-phy-ieee802.3-c22";
+		interrupts = <37 IRQ_TYPE_EDGE_RISING>;
+		reg = <4>;
+	};
+};
-- 
2.4.5
