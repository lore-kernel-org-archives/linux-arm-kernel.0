From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 6 Oct 2015 17:57:00 +0200
Subject: [PATCH v3] arm-soc: Add support for Sigma Designs Tango4
In-Reply-To: <5612A473.8030405@sigmadesigns.com>
References: <560EAA7C.3070302@free.fr> <5124277.UR9sg1IOHT@wuerfel>
 <560EFDB3.9010305@free.fr> <11113740.WL812ZaRcZ@wuerfel>
 <5612A473.8030405@sigmadesigns.com>
Message-ID: <5613EF4C.30603@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for Sigma Designs "Tango4" platform, which is
built around the ARM Cortex A9 MPCore (single and dual core SoCs).

Tango4 is not to be confused with Tango3, which was built around a
MIPS 74kf CPU.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
v3 changes: Updated clock tree DT (clk driver submitted)
---
 arch/arm/Kconfig                          |   2 +
 arch/arm/Makefile                         |   1 +
 arch/arm/boot/dts/Makefile                |   2 +
 arch/arm/boot/dts/tango4-vantage-1172.dts |  17 ++++
 arch/arm/boot/dts/tango4.dtsi             | 133 ++++++++++++++++++++++++++++++
 arch/arm/mach-tangox/Kconfig              |  11 +++
 arch/arm/mach-tangox/Makefile             |   1 +
 arch/arm/mach-tangox/setup.c              |   7 ++
 8 files changed, 174 insertions(+)
 create mode 100644 arch/arm/boot/dts/tango4-vantage-1172.dts
 create mode 100644 arch/arm/boot/dts/tango4.dtsi
 create mode 100644 arch/arm/mach-tangox/Kconfig
 create mode 100644 arch/arm/mach-tangox/Makefile
 create mode 100644 arch/arm/mach-tangox/setup.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c5021002fe4..94a1a0277c94 100644
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
index 000000000000..3eff944e2103
--- /dev/null
+++ b/arch/arm/boot/dts/tango4-vantage-1172.dts
@@ -0,0 +1,17 @@
+/dts-v1/;
+
+#include "tango4.dtsi"
+
+/ {
+	model = "Sigma Designs SMP8758 Vantage-1172 dev board";
+	compatible = "sigma,vantage-1172", "sigma,smp8758", "sigma,tango4";
+
+	chosen {
+		stdout-path = &uart;
+	};
+};
+
+&eth0 {
+	phy-connection-type = "rgmii";
+	max-speed = <1000>;
+};
diff --git a/arch/arm/boot/dts/tango4.dtsi b/arch/arm/boot/dts/tango4.dtsi
new file mode 100644
index 000000000000..c682617866e9
--- /dev/null
+++ b/arch/arm/boot/dts/tango4.dtsi
@@ -0,0 +1,133 @@
+#include <dt-bindings/interrupt-controller/irq.h>
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
+		pll0: pll0 {
+			compatible = "sigma,tango4-pll";
+			reg = <0x10000 4>;
+			clocks = <&xtal>;
+			#clock-cells = <0>;
+		};
+
+		pll1: pll1 {
+			compatible = "sigma,tango4-pll";
+			reg = <0x10008 4>;
+			clocks = <&xtal>;
+			#clock-cells = <0>;
+		};
+
+		cpuclk: cpuclk {
+			compatible = "sigma,tango4-cpuclk";
+			reg = <0x10024 4>;
+			clocks = <&pll0>;
+			#clock-cells = <0>;
+		};
+
+		periphclk: periphclk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpuclk>;
+			clock-mult = <1>;
+			clock-div  = <2>;
+			#clock-cells = <0>;
+		};
+
+		sysclk: sysclk {
+			compatible = "fixed-factor-clock";
+			clocks = <&pll1>;
+			clock-mult = <1>;
+			clock-div  = <3>; /* HW bug precludes other dividers */
+			#clock-cells = <0>;
+		};
+	};
+
+	gic: gic at 20001000 {
+		compatible = "arm,cortex-a9-gic";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x20001000 0x1000>,
+		      <0x20000100 0x0100>;
+	};
+
+	twd-timer at 20000600 {
+		compatible = "arm,cortex-a9-twd-timer";
+		reg = <0x20000600 0x10>;
+		interrupts = <1 13 0xf01>;
+		interrupt-parent = <&gic>;
+		clocks = <&periphclk>;
+		twd-never-stops;
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
+			reg = <0x10700 0x100>;
+			clock-frequency = <7372800>;
+			reg-shift = <2>;
+		};
+
+		eth0: ethernet at 26000 {
+			compatible = "sigma,tango-emac";
+			reg = <0x26000 0x800>;
+			interrupts = <38 4>;
+			interrupt-parent = <&irq0>;
+			clocks = <&sysclk>;
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
+				interrupts = <0 2 4>;
+			};
+
+			irq1: irq1 at 6e100 {
+				reg = <0x100 0x100>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 3 4>;
+			};
+
+			irq2: irq2 at 6e300 {
+				reg = <0x300 0x100>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 4 4>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-tangox/Kconfig b/arch/arm/mach-tangox/Kconfig
new file mode 100644
index 000000000000..b8a308f08ec6
--- /dev/null
+++ b/arch/arm/mach-tangox/Kconfig
@@ -0,0 +1,11 @@
+# Tango3 was based on MIPS 74kf. Tango4 is based on ARM Cortex A9 MPCore.
+
+config ARCH_TANGOX
+	bool "Sigma Designs Tango4 (SMP87xx)" if ARCH_MULTI_V7
+	select ARCH_HAS_HOLES_MEMORYMODEL
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_764369 if SMP
+	select ARM_GIC
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
