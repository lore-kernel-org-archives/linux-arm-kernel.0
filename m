From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 27 Oct 2015 18:12:33 +0100
Subject: [PATCH v6] arm-soc: Add support for Sigma Designs Tango4 platforms
In-Reply-To: <562A5A66.4030404@sigmadesigns.com>
References: <56250FAC.2010800@sigmadesigns.com>
 <562A5A66.4030404@sigmadesigns.com>
Message-ID: <562FB081.1050206@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've made some additional changes, which I'm not 100% sure about.
I suppose this should be considered a RFC.

Changes in v7
Toggle L2 cache via smc
Move peripheral devices compatible strings to board DTS
  (because it contains the chip number, while common is generic)
Add UART IRQ

Patch follows.

Regards.


diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c5021002fe4..d8f0c31f521f 100644
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
diff --git a/arch/arm/boot/dts/tango4-common.dtsi b/arch/arm/boot/dts/tango4-common.dtsi
new file mode 100644
index 000000000000..90e9a6e736ae
--- /dev/null
+++ b/arch/arm/boot/dts/tango4-common.dtsi
@@ -0,0 +1,121 @@
+/*
+ * Derived from Mans Rullgard's Tango3 DT
+ * https://github.com/mansr/linux-tangox
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
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
+	gic: interrupt-controller at 20001000 {
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
+			interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&irq0>;
+			clock-frequency = <7372800>;
+			reg-shift = <2>;
+		};
+
+		eth0: ethernet at 26000 {
+			reg = <0x26000 0x800>;
+			interrupts = <38 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&irq0>;
+			clocks = <&clkgen 1>;
+		};
+
+		intc: interrupt-controller at 6e000 {
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
diff --git a/arch/arm/boot/dts/tango4-smp8758.dtsi b/arch/arm/boot/dts/tango4-smp8758.dtsi
new file mode 100644
index 000000000000..94c3e05f7d4c
--- /dev/null
+++ b/arch/arm/boot/dts/tango4-smp8758.dtsi
@@ -0,0 +1,31 @@
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
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
+		interrupt-parent = <&gic>;
+		interrupts =
+			<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
diff --git a/arch/arm/boot/dts/tango4-vantage-1172.dts b/arch/arm/boot/dts/tango4-vantage-1172.dts
new file mode 100644
index 000000000000..772f27c360ed
--- /dev/null
+++ b/arch/arm/boot/dts/tango4-vantage-1172.dts
@@ -0,0 +1,24 @@
+/dts-v1/;
+
+#include "tango4-smp8758.dtsi"
+#include "tango4-common.dtsi"
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
+	compatible = "sigma,smp8758-ethernet", "sigma,smp8910-ethernet", "sigma,smp8642-ethernet", "aurora,nb8800";
+	phy-connection-type = "rgmii";
+	max-speed = <1000>;
+};
+
+&intc {
+	compatible = "sigma,smp8758-intc", "sigma,smp8642-intc";
+};
diff --git a/arch/arm/mach-tangox/Kconfig b/arch/arm/mach-tangox/Kconfig
new file mode 100644
index 000000000000..2432a51f8b43
--- /dev/null
+++ b/arch/arm/mach-tangox/Kconfig
@@ -0,0 +1,10 @@
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
index 000000000000..0d7e2b5976e3
--- /dev/null
+++ b/arch/arm/mach-tangox/Makefile
@@ -0,0 +1,2 @@
+asflags-y += -mcpu=cortex-a9
+obj-y += setup.o smc.o
diff --git a/arch/arm/mach-tangox/setup.c b/arch/arm/mach-tangox/setup.c
new file mode 100644
index 000000000000..044eb974172a
--- /dev/null
+++ b/arch/arm/mach-tangox/setup.c
@@ -0,0 +1,18 @@
+#include <asm/mach/arch.h>
+#include <asm/hardware/cache-l2x0.h>
+
+static void tango_l2c_write(unsigned long val, unsigned int reg)
+{
+	void tango_set_l2_control(unsigned int val);
+	pr_info("%s: reg=0x%x val=0x%lx\n", __func__, reg, val);
+	if (reg == L2X0_CTRL)
+		tango_set_l2_control(val);
+}
+
+static const char *tango_dt_compat[] = { "sigma,tango4", NULL };
+
+DT_MACHINE_START(TANGO_DT, "Sigma Tango DT")
+	.dt_compat	= tango_dt_compat,
+	.l2c_aux_mask	= ~0,
+	.l2c_write_sec	= tango_l2c_write,
+MACHINE_END
diff --git a/arch/arm/mach-tangox/smc.S b/arch/arm/mach-tangox/smc.S
new file mode 100644
index 000000000000..1527d23cffc5
--- /dev/null
+++ b/arch/arm/mach-tangox/smc.S
@@ -0,0 +1,14 @@
+#include <linux/linkage.h>
+
+#define SMC_SET_L2_CONTROL	0x102
+
+/*
+ * Have Armor write r0 to l2_control.
+ */
+ENTRY(tango_set_l2_control)
+	push	{lr}
+	movw	ip, #SMC_SET_L2_CONTROL
+	dsb
+	smc	#0
+	pop	{pc}
+ENDPROC(tango_set_l2_control)
