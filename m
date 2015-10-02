From: slash.tmp@free.fr (Mason)
Date: Fri, 2 Oct 2015 18:02:04 +0200
Subject: [PATCH] arm-soc: Add Sigma Designs Tango4 port
Message-ID: <560EAA7C.3070302@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Tango4-based SoCs (SMP8756, SMP8758)

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
NOTE: Mans reviewed the patch, and noted that the proposed
clock tree is too simplified. I have an upcoming patch fixing
that issue.
---
 arch/arm/Kconfig                   |   2 +
 arch/arm/Makefile                  |   1 +
 arch/arm/boot/dts/Makefile         |   2 +
 arch/arm/boot/dts/tango4.dtsi      | 117 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/vantage-1172.dts |   8 +++
 arch/arm/mach-tangox/Kconfig       |  12 ++++
 arch/arm/mach-tangox/Makefile      |   1 +
 arch/arm/mach-tangox/setup.c       |   7 +++
 8 files changed, 150 insertions(+)
 create mode 100644 arch/arm/boot/dts/tango4.dtsi
 create mode 100644 arch/arm/boot/dts/vantage-1172.dts
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
index 246473a244f6..42ba8b1be0d5 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -605,6 +605,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 dtb-$(CONFIG_MACH_SUN9I) += \
 	sun9i-a80-optimus.dtb \
 	sun9i-a80-cubieboard4.dtb
+dtb-$(CONFIG_ARCH_TANGOX) += \
+	vantage-1172.dtb
 dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
 	tegra20-harmony.dtb \
 	tegra20-iris-512.dtb \
diff --git a/arch/arm/boot/dts/tango4.dtsi b/arch/arm/boot/dts/tango4.dtsi
new file mode 100644
index 000000000000..7336fcc3ac1d
--- /dev/null
+++ b/arch/arm/boot/dts/tango4.dtsi
@@ -0,0 +1,117 @@
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	compatible = "sigma,tango4-soc";
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
+		sysclk: sysclk {
+			compatible = "fixed-clock";
+			clock-frequency = <396000000>;
+			#clock-cells = <0>;
+		};
+
+		cpuclk: cpuclk {
+			compatible = "fixed-clock";
+			clock-frequency = <999000000>;
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
+		twd_never_stops;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		xtal_in_cnt {
+			compatible = "sigma,xtal_in_cnt";
+			reg = <0x10048 0x4>;
+			clocks = <&xtal>;
+		};
+
+		uart0 {
+			compatible = "ralink,rt2880-uart";
+			reg = <0x10700 0x100>;
+			clock-frequency = <7372800>;
+			reg-shift = <2>;
+/*			fifo-size = <16>; BROKEN */
+		};
+
+		eth0: eth0 {
+			compatible = "sigma,smp8640-emac";
+			reg = <0x26000 0x800>;
+			interrupts = <38 4>;
+			interrupt-parent = <&irq0>;
+			mac-address = [ 00 16 e8 02 08 42 ];
+			clocks = <&sysclk>;
+		};
+
+		intc: intc at e000 {
+			compatible = "sigma,tango-intc";
+			reg = <0x6e000 0x1000>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			irq0: irq0 at 000 {
+				reg = <0x000 0x100>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 2 4>;
+			};
+
+			irq1: irq1 at 100 {
+				reg = <0x100 0x100>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 3 4>;
+			};
+
+			irq2: irq2 at 300 {
+				reg = <0x300 0x100>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 4 4>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/vantage-1172.dts b/arch/arm/boot/dts/vantage-1172.dts
new file mode 100644
index 000000000000..56f6babe7093
--- /dev/null
+++ b/arch/arm/boot/dts/vantage-1172.dts
@@ -0,0 +1,8 @@
+/dts-v1/;
+
+#include "tango4.dtsi"
+
+&eth0 {
+	phy-connection-type = "rgmii";
+	max-speed = <1000>;
+};
diff --git a/arch/arm/mach-tangox/Kconfig b/arch/arm/mach-tangox/Kconfig
new file mode 100644
index 000000000000..152cdd487056
--- /dev/null
+++ b/arch/arm/mach-tangox/Kconfig
@@ -0,0 +1,12 @@
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
+	select SERIAL_8250_RT288X if SERIAL_8250
diff --git a/arch/arm/mach-tangox/Makefile b/arch/arm/mach-tangox/Makefile
new file mode 100644
index 000000000000..2b9dba458932
--- /dev/null
+++ b/arch/arm/mach-tangox/Makefile
@@ -0,0 +1 @@
+obj-y += setup.o
diff --git a/arch/arm/mach-tangox/setup.c b/arch/arm/mach-tangox/setup.c
new file mode 100644
index 000000000000..14baf14bbd49
--- /dev/null
+++ b/arch/arm/mach-tangox/setup.c
@@ -0,0 +1,7 @@
+#include <asm/mach/arch.h>
+
+static const char *tango_dt_compat[] = { "sigma,tango4-soc", NULL };
+
+DT_MACHINE_START(TANGO_DT, "Sigma TangoX DT")
+	.dt_compat	= tango_dt_compat,
+MACHINE_END
-- 
2.4.5
