From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 20 Oct 2015 18:35:18 +0200
Subject: [PATCH v5] arm-soc: Add support for Sigma Designs Tango4 platforms
In-Reply-To: <56250FAC.2010800@sigmadesigns.com>
References: <56250FAC.2010800@sigmadesigns.com>
Message-ID: <56266D46.5080809@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support Tango4 platforms (single and dual core SoCs) built around the
ARM Cortex-A9 MPCore.

Tango4 is not to be confused with Tango3, which was built around the
MIPS 74kf.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
Changes in v5
drop mac-address property from eth0 node
tentatively add pmu node (not looking good)
hw perfevents: failed to probe PMU!
hw perfevents: failed to register PMU devices!

Changes in v4
add memory node, cpus node, l2cc node
rewrite clkgen node, as requested by clk maintainers
not sure about pmu node
---
 arch/arm/Kconfig                          |   2 +
 arch/arm/Makefile                         |   1 +
 arch/arm/boot/dts/Makefile                |   2 +
 arch/arm/boot/dts/tango4-vantage-1172.dts |  18 ++++
 arch/arm/boot/dts/tango4.dtsi             | 140 ++++++++++++++++++++++++++++++
 arch/arm/mach-tangox/Kconfig              |  12 +++
 arch/arm/mach-tangox/Makefile             |   1 +
 arch/arm/mach-tangox/setup.c              |   7 ++
 8 files changed, 183 insertions(+)
 create mode 100644 arch/arm/boot/dts/tango4-vantage-1172.dts
 create mode 100644 arch/arm/boot/dts/tango4.dtsi
 create mode 100644 arch/arm/mach-tangox/Kconfig
 create mode 100644 arch/arm/mach-tangox/Makefile
 create mode 100644 arch/arm/mach-tangox/setup.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 774dc59650c5..d8f0c31f521f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -934,6 +934,8 @@ source "arch/arm/mach-sunxi/Kconfig"
 
 source "arch/arm/mach-prima2/Kconfig"
 
+source "arch/arm/mach-tangox/Kconfig"
+
 source "arch/arm/mach-tegra/Kconfig"
 
 source "arch/arm/mach-u300/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 7451b447cc2d..7fcb4c63cdf7 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -203,6 +203,7 @@ machine-$(CONFIG_ARCH_SOCFPGA)		+= socfpga
 machine-$(CONFIG_ARCH_STI)		+= sti
 machine-$(CONFIG_ARCH_STM32)		+= stm32
 machine-$(CONFIG_ARCH_SUNXI)		+= sunxi
+machine-$(CONFIG_ARCH_TANGOX)		+= tangox
 machine-$(CONFIG_ARCH_TEGRA)		+= tegra
 machine-$(CONFIG_ARCH_U300)		+= u300
 machine-$(CONFIG_ARCH_U8500)		+= ux500
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
diff --git a/arch/arm/boot/dts/tango4-vantage-1172.dts b/arch/arm/boot/dts/tango4-vantage-1172.dts
new file mode 100644
index 000000000000..00c9d7e69f80
--- /dev/null
+++ b/arch/arm/boot/dts/tango4-vantage-1172.dts
@@ -0,0 +1,18 @@
+/dts-v1/;
+
+#include "tango4.dtsi"
+
+/ {
+	model = "Sigma Designs SMP8758 Vantage-1172 dev board";
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
+	max-speed = <1000>;
+};
diff --git a/arch/arm/boot/dts/tango4.dtsi b/arch/arm/boot/dts/tango4.dtsi
new file mode 100644
index 000000000000..af856b40228b
--- /dev/null
+++ b/arch/arm/boot/dts/tango4.dtsi
@@ -0,0 +1,140 @@
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "sigma,tango4";
+
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	clocks {
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
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
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu at 0 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <0>;
+		};
+		cpu at 1 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <1>;
+		};
+	};
+
+	gic: gic at 20001000 {
+		compatible = "arm,cortex-a9-gic";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x20001000 0x1000>, <0x20000100 0x0100>;
+	};
+
+	l2cc: l2-cache-controller at 20100000 {
+		compatible = "arm,pl310-cache";
+		reg = <0x20100000 0x1000>;
+		cache-level = <2>;
+		cache-unified;
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
+		interrupt-parent = <&gic>;
+		clocks = <&periphclk>;
+		always-on;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupts =
+			<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
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
+			clock-frequency = <7372800>;
+			reg-shift = <2>;
+		};
+
+		eth0: ethernet at 26000 {
+			compatible = "sigma,tango-emac";
+			reg = <0x26000 0x800>;
+			interrupts = <38 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&irq0>;
+			clocks = <&clkgen 1>;
+		};
+
+		interrupt-controller at 6e000 {
+			compatible = "sigma,tango-intc";
+			reg = <0x6e000 0x400>;
+			ranges = <0 0x6e000 0x400>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			irq0: irq0 at 6e000 {
+				reg = <0x000 0x100>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			irq1: irq1 at 6e100 {
+				reg = <0x100 0x100>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			irq2: irq2 at 6e300 {
+				reg = <0x300 0x100>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-tangox/Kconfig b/arch/arm/mach-tangox/Kconfig
new file mode 100644
index 000000000000..4d04952ed00f
--- /dev/null
+++ b/arch/arm/mach-tangox/Kconfig
@@ -0,0 +1,12 @@
+# Tango3 was based on MIPS 74kf. Tango4 is based on ARM Cortex-A9 MPCore.
+
+config ARCH_TANGOX
+	bool "Sigma Designs Tango4 (SMP87xx)" if ARCH_MULTI_V7
+	select ARCH_HAS_HOLES_MEMORYMODEL
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_764369 if SMP
+	select ARM_GIC
+	select CLKSRC_TANGO_XTAL
+	select GENERIC_IRQ_CHIP
+	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD
diff --git a/arch/arm/mach-tangox/Makefile b/arch/arm/mach-tangox/Makefile
new file mode 100644
index 000000000000..2b9dba458932
--- /dev/null
+++ b/arch/arm/mach-tangox/Makefile
@@ -0,0 +1 @@
+obj-y += setup.o
diff --git a/arch/arm/mach-tangox/setup.c b/arch/arm/mach-tangox/setup.c
new file mode 100644
index 000000000000..46ae91e49f81
--- /dev/null
+++ b/arch/arm/mach-tangox/setup.c
@@ -0,0 +1,7 @@
+#include <asm/mach/arch.h>
+
+static const char *tango_dt_compat[] = { "sigma,tango4", NULL };
+
+DT_MACHINE_START(TANGO_DT, "Sigma Tango DT")
+	.dt_compat	= tango_dt_compat,
+MACHINE_END
-- 
2.4.5
