From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 16 Jan 2015 11:45:29 +0000 (UTC)
Subject: [PATCH] arm64: dts: Add initial device tree support for Tegra132
Message-ID: <alpine.DEB.2.02.1501161139180.9776@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Add an initial device tree file for the Tegra132 SoC.  The DT file is
based on arch/arm/boot/dts/tegra124.dtsi and
arch/arm/boot/dts/tegra114.dtsi, with the following significant
changes:

- Tegra132 uses a Denver CPU cluster rather than an ARMv7 CPU cluster
- Devices are arranged by bus, rather than in a flat topology
- No polling delays have been defined for the thermal zones.  I don't
  believe that this is a property of the SoC hardware, but rather of a
  given use-case.

DT nodes representing IP blocks have generally been labeled according
to the names used in Section 2.1 "System Address Map" of the _Tegra K1
64-Bit Mobile Processor Technical Reference Manual_
(DP-07148-001_ALPHA), with a few exceptions for disambiguation or
abbreviated naming.  Some of the known IP block aliases used by PCB
designers (e.g., "GEN2_I2C" for "I2C2") have been noted in DT node 
comments.

Known future work:

- Add support for the Denver CLUSTER_clocks IP block
- Add support for the CPU thermal zone; now handled by a CCPLEX IP block
- The CPU spin_table enable-method may change to PSCI at some point
- Add support for several missing IP blocks
- Some drivers use unusual address spaces for devices which don't match
  the TRM and/or hardware decode.  At some point these should be
  reconciled.

This patch was originally based on a patch by Allen Martin
<amartin@nvidia.com> and the Tegra124 and Tegra114 DTS files.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Allen Martin <amartin@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-tegra at vger.kernel.org
---
 arch/arm64/boot/dts/Makefile            |   1 +
 arch/arm64/boot/dts/tegra/Makefile      |   3 +
 arch/arm64/boot/dts/tegra/tegra132.dtsi | 997 ++++++++++++++++++++++++++++++++
 3 files changed, 1001 insertions(+)
 create mode 100644 arch/arm64/boot/dts/tegra/Makefile
 create mode 100644 arch/arm64/boot/dts/tegra/tegra132.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index b411251..90f6284 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -3,6 +3,7 @@ dts-dirs += apm
 dts-dirs += arm
 dts-dirs += cavium
 dts-dirs += exynos
+dts-dirs += tegra
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/tegra/Makefile b/arch/arm64/boot/dts/tegra/Makefile
new file mode 100644
index 0000000..15dbaa0
--- /dev/null
+++ b/arch/arm64/boot/dts/tegra/Makefile
@@ -0,0 +1,3 @@
+always          := $(dtb-y)
+subdir-y        := $(dts-dirs)
+clean-files     := *.dtb
diff --git a/arch/arm64/boot/dts/tegra/tegra132.dtsi b/arch/arm64/boot/dts/tegra/tegra132.dtsi
new file mode 100644
index 0000000..4b93bfe
--- /dev/null
+++ b/arch/arm64/boot/dts/tegra/tegra132.dtsi
@@ -0,0 +1,997 @@
+#include <dt-bindings/clock/tegra124-car.h>
+#include <dt-bindings/gpio/tegra-gpio.h>
+#include <dt-bindings/memory/tegra124-mc.h>
+#include <dt-bindings/pinctrl/pinctrl-tegra.h>
+#include <dt-bindings/pinctrl/pinctrl-tegra-xusb.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/thermal/tegra124-soctherm.h>
+
+#include "skeleton.dtsi"
+
+/ {
+	compatible = "nvidia,tegra132";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	pcie-controller at 0,01003000 {
+		compatible = "nvidia,tegra132-pcie", "nvidia,tegra124-pcie";
+		device_type = "pci";
+		reg = <0x0 0x01003000 0x0 0x00000800   /* PADS registers */
+		       0x0 0x01003800 0x0 0x00000800   /* AFI registers */
+		       0x0 0x02000000 0x0 0x10000000>; /* configuration space */
+		reg-names = "pads", "afi", "cs";
+		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+			     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+
+		bus-range = <0x00 0xff>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		ranges = <0x82000000 0 0x01000000 0x0 0x01000000 0 0x00001000   /* port 0 configuration space */
+			  0x82000000 0 0x01001000 0x0 0x01001000 0 0x00001000   /* port 1 configuration space */
+			  0x81000000 0 0x0        0x0 0x12000000 0 0x00010000   /* downstream I/O (64 KiB) */
+			  0x82000000 0 0x13000000 0x0 0x13000000 0 0x0d000000   /* non-prefetchable memory (208 MiB) */
+			  0xc2000000 0 0x20000000 0x0 0x20000000 0 0x20000000>; /* prefetchable memory (512 MiB) */
+
+		clocks = <&tegra_car TEGRA124_CLK_PCIE>,
+			 <&tegra_car TEGRA124_CLK_AFI>,
+			 <&tegra_car TEGRA124_CLK_PLL_E>,
+			 <&tegra_car TEGRA124_CLK_CML0>;
+		clock-names = "pex", "afi", "pll_e", "cml";
+		resets = <&tegra_car 70>,
+			 <&tegra_car 72>,
+			 <&tegra_car 74>;
+		reset-names = "pex", "afi", "pcie_x";
+		status = "disabled";
+
+		phys = <&xusb_padctl TEGRA_XUSB_PADCTL_PCIE>;
+		phy-names = "pcie";
+
+		pci at 1,0 {
+			device_type = "pci";
+			assigned-addresses = <0x82000800 0 0x01000000 0 0x1000>;
+			reg = <0x000800 0 0 0 0>;
+			status = "disabled";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+
+			nvidia,num-lanes = <2>;
+		};
+
+		pci at 2,0 {
+			device_type = "pci";
+			assigned-addresses = <0x82001000 0 0x01001000 0 0x1000>;
+			reg = <0x001000 0 0 0 0>;
+			status = "disabled";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+
+			nvidia,num-lanes = <1>;
+		};
+	};
+
+	iram_a: iram at 0,40000000 {
+		compatible = "mmio-sram";
+		reg = <0x0 0x40000000 0x0 0x10000>;
+	};
+
+	iram_b: iram at 0,40010000 {
+		compatible = "mmio-sram";
+		reg = <0x0 0x40010000 0x0 0x10000>;
+	};
+
+	iram_c: iram at 0,40020000 {
+		compatible = "mmio-sram";
+		reg = <0x0 0x40020000 0x0 0x10000>;
+	};
+
+	iram_d: iram at 0,40030000 {
+		compatible = "mmio-sram";
+		reg = <0x0 0x40030000 0x0 0x10000>;
+	};
+
+	host1x at 0,50000000 {
+		compatible = "nvidia,tegra132-host1x", "nvidia,tegra124-host1x", "simple-bus";
+		reg = <0x0 0x50000000 0x0 0x00034000>;
+		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>, /* syncpt */
+			     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>; /* general */
+		clocks = <&tegra_car TEGRA124_CLK_HOST1X>;
+		resets = <&tegra_car 28>;
+		reset-names = "host1x";
+
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		ranges = <0 0x54000000 0 0x54000000 0 0x01000000>;
+
+		dc at 0,54200000 {
+			compatible = "nvidia,tegra132-dc", "nvidia,tegra124-dc";
+			reg = <0x0 0x54200000 0x0 0x00040000>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_DISP1>,
+				 <&tegra_car TEGRA124_CLK_PLL_P>;
+			clock-names = "dc", "parent";
+			resets = <&tegra_car 27>;
+			reset-names = "dc";
+
+			iommus = <&mc TEGRA_SWGROUP_DC>;
+
+			nvidia,head = <0>;
+		};
+
+		dc at 0,54240000 {
+			compatible = "nvidia,tegra132-dc", "nvidia,tegra124-dc";
+			reg = <0x0 0x54240000 0x0 0x00040000>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_DISP2>,
+				 <&tegra_car TEGRA124_CLK_PLL_P>;
+			clock-names = "dc", "parent";
+			resets = <&tegra_car 26>;
+			reset-names = "dc";
+
+			iommus = <&mc TEGRA_SWGROUP_DCB>;
+
+			nvidia,head = <1>;
+		};
+
+		hdmi at 0,54280000 {
+			compatible = "nvidia,tegra132-hdmi", "nvidia,tegra124-hdmi";
+			reg = <0x0 0x54280000 0x0 0x00040000>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_HDMI>,
+				 <&tegra_car TEGRA124_CLK_PLL_D2_OUT0>;
+			clock-names = "hdmi", "parent";
+			resets = <&tegra_car 51>;
+			reset-names = "hdmi";
+			status = "disabled";
+		};
+
+		sor at 0,54540000 {
+			compatible = "nvidia,tegra132-sor", "nvidia,tegra124-sor";
+			reg = <0x0 0x54540000 0x0 0x00040000>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_SOR0>,
+				 <&tegra_car TEGRA124_CLK_PLL_D_OUT0>,
+				 <&tegra_car TEGRA124_CLK_PLL_DP>,
+				 <&tegra_car TEGRA124_CLK_CLK_M>;
+			clock-names = "sor", "parent", "dp", "safe";
+			resets = <&tegra_car 182>;
+			reset-names = "sor";
+			status = "disabled";
+		};
+
+		dpaux: dpaux at 0,545c0000 {
+			compatible = "nvidia,tegra132-dpaux", "nvidia,tegra124-dpaux";
+			reg = <0x0 0x545c0000 0x0 0x00040000>;
+			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_DPAUX>,
+				 <&tegra_car TEGRA124_CLK_PLL_DP>;
+			clock-names = "dpaux", "parent";
+			resets = <&tegra_car 181>;
+			reset-names = "dpaux";
+			status = "disabled";
+		};
+	};
+
+	gic: interrupt-controller at 0,50041000 {
+		compatible = "arm,cortex-a15-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x0 0x50041000 0x0 0x1000>,
+		      <0x0 0x50042000 0x0 0x1000>,
+		      <0x0 0x50044000 0x0 0x2000>,
+		      <0x0 0x50046000 0x0 0x2000>;
+		interrupts = <GIC_PPI 9
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	gpu: gpu at 0,57000000 {
+		compatible = "nvidia,gk20a";
+		reg = <0x0 0x57000000 0x0 0x01000000>,
+		      <0x0 0x58000000 0x0 0x01000000>;
+		interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "stall", "nonstall";
+		clocks = <&tegra_car TEGRA124_CLK_GPU>,
+			 <&tegra_car TEGRA124_CLK_PLL_P_OUT5>;
+		clock-names = "gpu", "pwr";
+		resets = <&tegra_car 184>;
+		reset-names = "gpu";
+		status = "disabled";
+	};
+
+	ppsb: ppsb at 0,60000000 {
+		compatible = "simple-bus";
+		reg = <0x0 0x60000000 0x0 0x01000000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		timer at 0,60005000 {
+			compatible = "nvidia,tegra132-timer", "nvidia,tegra124-timer", "nvidia,tegra20-timer";
+			reg = <0x0 0x60005000 0x0 0x400>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_TIMER>;
+		};
+
+		tegra_car: car at 0,60006000 {
+			compatible = "nvidia,tegra132-car", "nvidia,tegra124-car";
+			reg = <0x0 0x60006000 0x0 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		flow_controller: flow-controller at 0,60007000 {
+			compatible = "nvidia,tegra132-flowctrl", "nvidia,tegra124-flowctrl";
+			reg = <0x0 0x60007000 0x0 0x1000>;
+		};
+
+		ahb_gizmo: ahb-gizmo at 0,6000c004 {
+			compatible = "nvidia,tegra132-ahb", "nvidia,tegra124-ahb", "nvidia,tegra30-ahb";
+			/*
+			 * This IP block actually starts at 0x6000c000,
+			 * but all of the register offsets in the driver
+			 * have 0x4 subtracted from them.  So handle
+			 * it this way until the driver is fixed.
+			 */
+			reg = <0x0 0x6000c004 0x0 0x14d>;
+		};
+
+		gpio: gpio at 0,6000d000 {
+			/* XXX 8 GPIO blocks exist - this is only the first */
+			compatible = "nvidia,tegra132-gpio", "nvidia,tegra124-gpio", "nvidia,tegra30-gpio";
+			reg = <0x0 0x6000d000 0x0 0x1000>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+		};
+
+		apbdma: apbdma at 0,60020000 {
+			compatible = "nvidia,tegra132-apbdma", "nvidia,tegra124-apbdma", "nvidia,tegra148-apbdma";
+			reg = <0x0 0x60020000 0x0 0x1400>;
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_APBDMA>;
+			resets = <&tegra_car 34>;
+			reset-names = "dma";
+			#dma-cells = <1>;
+		};
+
+	}; /* ppsb */
+
+	apb: apb at 0,70000000 {
+		compatible = "simple-bus";
+		reg = <0x0 0x70000000 0x0 0x01000000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		apbmisc: apbmisc at 0,70000800 {
+			compatible = "nvidia,tegra132-apbmisc", "nvidia,tegra124-apbmisc", "nvidia,tegra20-apbmisc";
+			reg = <0x0 0x70000800 0x0 0x64>,   /* Chip revision */
+			      <0x0 0x7000E864 0x0 0x04>;   /* Strapping options */
+		};
+
+		pinmux: pinmux at 0,70000868 {
+			compatible = "nvidia,tegra132-pinmux", "nvidia,tegra124-pinmux";
+			reg = <0x0 0x70000868 0x0 0x164>,  /* Pad control registers */
+			      <0x0 0x70003000 0x0 0x434>;  /* Mux registers */
+		};
+
+		/*
+		 * There are two serial drivers: an 8250 based simple
+		 * serial driver and an APB DMA based serial driver
+		 * for higher baudrate and performance. To enable the
+		 * 8250 based driver, the compatible string is
+		 * "nvidia,tegra132-uart", "nvidia,tegra124-uart",
+		 * "nvidia,tegra20-uart" and to enable the APB DMA
+		 * based serial driver, the compatible string is
+		 * "nvidia,tegra132-hsuart", "nvidia,tegra124-hsuart",
+		 * "nvidia,tegra30-hsuart".
+		 */
+		uarta: serial at 0,70006000 {
+			compatible = "nvidia,tegra132-uart", "nvidia,tegra124-uart", "nvidia,tegra20-uart";
+			reg = <0x0 0x70006000 0x0 0x40>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_UARTA>;
+			resets = <&tegra_car 6>;
+			reset-names = "serial";
+			dmas = <&apbdma 8>, <&apbdma 8>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		uartb: serial at 0,70006040 {
+			compatible = "nvidia,tegra132-uart", "nvidia,tegra124-uart", "nvidia,tegra20-uart";
+			reg = <0x0 0x70006040 0x0 0x40>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_UARTB>;
+			resets = <&tegra_car 7>;
+			reset-names = "serial";
+			dmas = <&apbdma 9>, <&apbdma 9>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		uartc: serial at 0,70006200 {
+			compatible = "nvidia,tegra132-uart", "nvidia,tegra124-uart", "nvidia,tegra20-uart";
+			reg = <0x0 0x70006200 0x0 0x40>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_UARTC>;
+			resets = <&tegra_car 55>;
+			reset-names = "serial";
+			dmas = <&apbdma 10>, <&apbdma 10>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		uartd: serial at 0,70006300 {
+			compatible = "nvidia,tegra132-uart", "nvidia,tegra124-uart", "nvidia,tegra20-uart";
+			reg = <0x0 0x70006300 0x0 0x40>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_UARTD>;
+			resets = <&tegra_car 65>;
+			reset-names = "serial";
+			dmas = <&apbdma 19>, <&apbdma 19>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		pwm: pwm at 0,7000a000 {
+			compatible = "nvidia,tegra132-pwm", "nvidia,tegra124-pwm", "nvidia,tegra20-pwm";
+			reg = <0x0 0x7000a000 0x0 0x100>;
+			#pwm-cells = <2>;
+			clocks = <&tegra_car TEGRA124_CLK_PWM>;
+			resets = <&tegra_car 17>;
+			reset-names = "pwm";
+			status = "disabled";
+		};
+
+		i2c1: i2c at 0,7000c000 { /* GEN1_I2C */
+			compatible = "nvidia,tegra132-i2c", "nvidia,tegra124-i2c", "nvidia,tegra114-i2c";
+			reg = <0x0 0x7000c000 0x0 0x100>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&tegra_car TEGRA124_CLK_I2C1>;
+			clock-names = "div-clk";
+			resets = <&tegra_car 12>;
+			reset-names = "i2c";
+			dmas = <&apbdma 21>, <&apbdma 21>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		i2c2: i2c at 0,7000c400 { /* GEN2_I2C */
+			compatible = "nvidia,tegra132-i2c", "nvidia,tegra124-i2c", "nvidia,tegra114-i2c";
+			reg = <0x0 0x7000c400 0x0 0x100>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&tegra_car TEGRA124_CLK_I2C2>;
+			clock-names = "div-clk";
+			resets = <&tegra_car 54>;
+			reset-names = "i2c";
+			dmas = <&apbdma 22>, <&apbdma 22>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		i2c3: i2c at 0,7000c500 { /* CAM_I2C */
+			compatible = "nvidia,tegra132-i2c", "nvidia,tegra124-i2c", "nvidia,tegra114-i2c";
+			reg = <0x0 0x7000c500 0x0 0x100>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&tegra_car TEGRA124_CLK_I2C3>;
+			clock-names = "div-clk";
+			resets = <&tegra_car 67>;
+			reset-names = "i2c";
+			dmas = <&apbdma 23>, <&apbdma 23>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		i2c4: i2c at 0,7000c700 {
+			compatible = "nvidia,tegra132-i2c", "nvidia,tegra124-i2c", "nvidia,tegra114-i2c";
+			reg = <0x0 0x7000c700 0x0 0x100>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&tegra_car TEGRA124_CLK_I2C4>;
+			clock-names = "div-clk";
+			resets = <&tegra_car 103>;
+			reset-names = "i2c";
+			dmas = <&apbdma 26>, <&apbdma 26>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		i2c5: i2c at 0,7000d000 { /* PWR_I2C */
+			compatible = "nvidia,tegra132-i2c", "nvidia,tegra124-i2c", "nvidia,tegra114-i2c";
+			reg = <0x0 0x7000d000 0x0 0x100>;
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&tegra_car TEGRA124_CLK_I2C5>;
+			clock-names = "div-clk";
+			resets = <&tegra_car 47>;
+			reset-names = "i2c";
+			dmas = <&apbdma 24>, <&apbdma 24>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		i2c6: i2c at 0,7000d100 {
+			compatible = "nvidia,tegra132-i2c", "nvidia,tegra124-i2c", "nvidia,tegra114-i2c";
+			reg = <0x0 0x7000d100 0x0 0x100>;
+			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&tegra_car TEGRA124_CLK_I2C6>;
+			clock-names = "div-clk";
+			resets = <&tegra_car 166>;
+			reset-names = "i2c";
+			dmas = <&apbdma 30>, <&apbdma 30>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		spi2b_1: spi at 0,7000d400 {
+			compatible = "nvidia,tegra132-spi", "nvidia,tegra124-spi", "nvidia,tegra114-spi";
+			reg = <0x0 0x7000d400 0x0 0x200>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&tegra_car TEGRA124_CLK_SBC1>;
+			clock-names = "spi";
+			resets = <&tegra_car 41>;
+			reset-names = "spi";
+			dmas = <&apbdma 15>, <&apbdma 15>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		spi2b_2: spi at 0,7000d600 {
+			compatible = "nvidia,tegra132-spi", "nvidia,tegra124-spi", "nvidia,tegra114-spi";
+			reg = <0x0 0x7000d600 0x0 0x200>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&tegra_car TEGRA124_CLK_SBC2>;
+			clock-names = "spi";
+			resets = <&tegra_car 44>;
+			reset-names = "spi";
+			dmas = <&apbdma 16>, <&apbdma 16>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		spi2b_3: spi at 0,7000d800 {
+			compatible = "nvidia,tegra132-spi", "nvidia,tegra124-spi", "nvidia,tegra114-spi";
+			reg = <0x0 0x7000d800 0x0 0x200>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&tegra_car TEGRA124_CLK_SBC3>;
+			clock-names = "spi";
+			resets = <&tegra_car 46>;
+			reset-names = "spi";
+			dmas = <&apbdma 17>, <&apbdma 17>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		spi2b_4: spi at 0,7000da00 {
+			compatible = "nvidia,tegra132-spi", "nvidia,tegra124-spi", "nvidia,tegra114-spi";
+			reg = <0x0 0x7000da00 0x0 0x200>;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&tegra_car TEGRA124_CLK_SBC4>;
+			clock-names = "spi";
+			resets = <&tegra_car 68>;
+			reset-names = "spi";
+			dmas = <&apbdma 18>, <&apbdma 18>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		spi2b_5: spi at 0,7000dc00 {
+			compatible = "nvidia,tegra132-spi", "nvidia,tegra124-spi", "nvidia,tegra114-spi";
+			reg = <0x0 0x7000dc00 0x0 0x200>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&tegra_car TEGRA124_CLK_SBC5>;
+			clock-names = "spi";
+			resets = <&tegra_car 104>;
+			reset-names = "spi";
+			dmas = <&apbdma 27>, <&apbdma 27>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		spi2b_6: spi at 0,7000de00 {
+			compatible = "nvidia,tegra132-spi", "nvidia,tegra124-spi", "nvidia,tegra114-spi";
+			reg = <0x0 0x7000de00 0x0 0x200>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&tegra_car TEGRA124_CLK_SBC6>;
+			clock-names = "spi";
+			resets = <&tegra_car 105>;
+			reset-names = "spi";
+			dmas = <&apbdma 28>, <&apbdma 28>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		rtc: rtc at 0,7000e000 {
+			compatible = "nvidia,tegra132-rtc", "nvidia,tegra124-rtc", "nvidia,tegra20-rtc";
+			reg = <0x0 0x7000e000 0x0 0x100>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_RTC>;
+		};
+
+		pmc: pmc at 0,7000e400 {
+			compatible = "nvidia,tegra132-pmc", "nvidia,tegra124-pmc";
+			reg = <0x0 0x7000e400 0x0 0x400>;
+			clocks = <&tegra_car TEGRA124_CLK_PCLK>, <&clk32k_in>;
+			clock-names = "pclk", "clk32k_in";
+		};
+
+		fuse: fuse at 0,7000f800 {
+			compatible = "nvidia,tegra132-efuse", "nvidia,tegra124-efuse";
+			reg = <0x0 0x7000f800 0x0 0x400>;
+			clocks = <&tegra_car TEGRA124_CLK_FUSE>;
+			clock-names = "fuse";
+			resets = <&tegra_car 39>;
+			reset-names = "fuse";
+		};
+
+		mc: memory-controller at 0,70019000 {
+			compatible = "nvidia,tegra132-mc", "nvidia,tegra124-mc";
+			reg = <0x0 0x70019000 0x0 0x1000>;
+			clocks = <&tegra_car TEGRA124_CLK_MC>;
+			clock-names = "mc";
+
+			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+
+			#iommu-cells = <1>;
+		};
+
+		sata: sata at 0,70020000 {
+			compatible = "nvidia,tegra132-ahci", "nvidia,tegra124-ahci";
+
+			reg = <0x0 0x70027000 0x0 0x2000>, /* AHCI */
+				<0x0 0x70020000 0x0 0x7000>; /* SATA */
+
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&tegra_car TEGRA124_CLK_SATA>,
+				<&tegra_car TEGRA124_CLK_SATA_OOB>,
+				<&tegra_car TEGRA124_CLK_CML1>,
+				<&tegra_car TEGRA124_CLK_PLL_E>;
+			clock-names = "sata", "sata-oob", "cml1", "pll_e";
+
+			resets = <&tegra_car 124>,
+				<&tegra_car 123>,
+				<&tegra_car 129>;
+			reset-names = "sata", "sata-oob", "sata-cold";
+
+			phys = <&xusb_padctl TEGRA_XUSB_PADCTL_SATA>;
+			phy-names = "sata-phy";
+
+			status = "disabled";
+		};
+
+		hda: hda at 0,70030000 {
+			compatible = "nvidia,tegra132-hda", "nvidia,tegra124-hda", "nvidia,tegra30-hda";
+			reg = <0x0 0x70030000 0x0 0x10000>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_HDA>,
+				 <&tegra_car TEGRA124_CLK_HDA2HDMI>,
+				 <&tegra_car TEGRA124_CLK_HDA2CODEC_2X>;
+			clock-names = "hda", "hda2hdmi", "hdacodec_2x";
+			resets = <&tegra_car 125>, /* hda */
+				 <&tegra_car 128>, /* hda2hdmi */
+				 <&tegra_car 111>; /* hda2codec_2x */
+			reset-names = "hda", "hda2hdmi", "hdacodec_2x";
+			status = "disabled";
+		};
+
+		xusb_padctl: xusb_padctl at 0,7009f000 {
+			compatible = "nvidia,tegra132-xusb-padctl", "nvidia,tegra124-xusb-padctl";
+			reg = <0x0 0x7009f000 0x0 0x1000>;
+			resets = <&tegra_car 142>;
+			reset-names = "padctl"; /* XXX support an xusb_padctl alias */
+
+			#phy-cells = <1>;
+		};
+
+		sdmmc1: sdhci at 0,700b0000 {
+			compatible = "nvidia,tegra132-sdhci", "nvidia,tegra124-sdhci", "nvidia,tegra114-sdhci";
+			reg = <0x0 0x700b0000 0x0 0x200>;
+			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_SDMMC1>;
+			resets = <&tegra_car 14>;
+			reset-names = "sdhci";
+			status = "disabled";
+		};
+
+		sdmmc2: sdhci at 0,700b0200 {
+			compatible = "nvidia,tegra132-sdhci", "nvidia,tegra124-sdhci", "nvidia,tegra114-sdhci";
+			reg = <0x0 0x700b0200 0x0 0x200>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_SDMMC2>;
+			resets = <&tegra_car 9>;
+			reset-names = "sdhci";
+			status = "disabled";
+		};
+
+		sdmmc3: sdhci at 0,700b0400 {
+			compatible = "nvidia,tegra132-sdhci", "nvidia,tegra124-sdhci", "nvidia,tegra114-sdhci";
+			reg = <0x0 0x700b0400 0x0 0x200>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_SDMMC3>;
+			resets = <&tegra_car 69>;
+			reset-names = "sdhci";
+			status = "disabled";
+		};
+
+		sdmmc4: sdhci at 0,700b0600 {
+			compatible = "nvidia,tegra132-sdhci", "nvidia,tegra124-sdhci", "nvidia,tegra114-sdhci";
+			reg = <0x0 0x700b0600 0x0 0x200>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_SDMMC4>;
+			resets = <&tegra_car 15>;
+			reset-names = "sdhci";
+			status = "disabled";
+		};
+
+		soc_therm: thermal-sensor at 0,700e2000 {
+			compatible = "nvidia,tegra132-soctherm", "nvidia,tegra124-soctherm";
+			reg = <0x0 0x700e2000 0x0 0x1000>;
+			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_TSENSOR>,
+				<&tegra_car TEGRA124_CLK_SOC_THERM>;
+			clock-names = "tsensor", "soctherm";
+			resets = <&tegra_car 78>;
+			reset-names = "soctherm";
+			#thermal-sensor-cells = <1>;
+		};
+
+		audio_cluster: ahub at 0,70300000 {
+			compatible = "nvidia,tegra132-ahub", "nvidia,tegra124-ahub";
+			reg = <0x0 0x70300000 0x0 0x200>,
+			      <0x0 0x70300800 0x0 0x800>,
+			      <0x0 0x70300200 0x0 0x600>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA124_CLK_D_AUDIO>,
+				 <&tegra_car TEGRA124_CLK_APBIF>;
+			clock-names = "d_audio", "apbif";
+			resets = <&tegra_car 106>, /* d_audio */
+				 <&tegra_car 107>, /* apbif */
+				 <&tegra_car 30>,  /* i2s0 */
+				 <&tegra_car 11>,  /* i2s1 */
+				 <&tegra_car 18>,  /* i2s2 */
+				 <&tegra_car 101>, /* i2s3 */
+				 <&tegra_car 102>, /* i2s4 */
+				 <&tegra_car 108>, /* dam0 */
+				 <&tegra_car 109>, /* dam1 */
+				 <&tegra_car 110>, /* dam2 */
+				 <&tegra_car 10>,  /* spdif */
+				 <&tegra_car 153>, /* amx */
+				 <&tegra_car 185>, /* amx1 */
+				 <&tegra_car 154>, /* adx */
+				 <&tegra_car 180>, /* adx1 */
+				 <&tegra_car 186>, /* afc0 */
+				 <&tegra_car 187>, /* afc1 */
+				 <&tegra_car 188>, /* afc2 */
+				 <&tegra_car 189>, /* afc3 */
+				 <&tegra_car 190>, /* afc4 */
+				 <&tegra_car 191>; /* afc5 */
+			reset-names = "d_audio", "apbif", "i2s0", "i2s1", "i2s2",
+				      "i2s3", "i2s4", "dam0", "dam1", "dam2",
+				      "spdif", "amx", "amx1", "adx", "adx1",
+				      "afc0", "afc1", "afc2", "afc3", "afc4", "afc5";
+			dmas = <&apbdma 1>, <&apbdma 1>,
+			       <&apbdma 2>, <&apbdma 2>,
+			       <&apbdma 3>, <&apbdma 3>,
+			       <&apbdma 4>, <&apbdma 4>,
+			       <&apbdma 6>, <&apbdma 6>,
+			       <&apbdma 7>, <&apbdma 7>,
+			       <&apbdma 12>, <&apbdma 12>,
+			       <&apbdma 13>, <&apbdma 13>,
+			       <&apbdma 14>, <&apbdma 14>,
+			       <&apbdma 29>, <&apbdma 29>;
+			dma-names = "rx0", "tx0", "rx1", "tx1", "rx2", "tx2",
+				    "rx3", "tx3", "rx4", "tx4", "rx5", "tx5",
+				    "rx6", "tx6", "rx7", "tx7", "rx8", "tx8",
+				    "rx9", "tx9";
+			ranges;
+			#address-cells = <2>;
+			#size-cells = <2>;
+
+			i2s0: i2s at 0,70301000 {
+				compatible = "nvidia,tegra132-i2s", "nvidia,tegra124-i2s";
+				reg = <0x0 0x70301000 0x0 0x100>;
+				nvidia,ahub-cif-ids = <4 4>;
+				clocks = <&tegra_car TEGRA124_CLK_I2S0>;
+				resets = <&tegra_car 30>;
+				reset-names = "i2s";
+				status = "disabled";
+			};
+
+			i2s1: i2s at 0,70301100 {
+				compatible = "nvidia,tegra132-i2s", "nvidia,tegra124-i2s";
+				reg = <0x0 0x70301100 0x0 0x100>;
+				nvidia,ahub-cif-ids = <5 5>;
+				clocks = <&tegra_car TEGRA124_CLK_I2S1>;
+				resets = <&tegra_car 11>;
+				reset-names = "i2s";
+				status = "disabled";
+			};
+
+			i2s2: i2s at 0,70301200 {
+				compatible = "nvidia,tegra132-i2s", "nvidia,tegra124-i2s";
+				reg = <0x0 0x70301200 0x0 0x100>;
+				nvidia,ahub-cif-ids = <6 6>;
+				clocks = <&tegra_car TEGRA124_CLK_I2S2>;
+				resets = <&tegra_car 18>;
+				reset-names = "i2s";
+				status = "disabled";
+			};
+
+			i2s3: i2s at 0,70301300 {
+				compatible = "nvidia,tegra132-i2s", "nvidia,tegra124-i2s";
+				reg = <0x0 0x70301300 0x0 0x100>;
+				nvidia,ahub-cif-ids = <7 7>;
+				clocks = <&tegra_car TEGRA124_CLK_I2S3>;
+				resets = <&tegra_car 101>;
+				reset-names = "i2s";
+				status = "disabled";
+			};
+
+			i2s4: i2s at 0,70301400 {
+				compatible = "nvidia,tegra132-i2s", "nvidia,tegra124-i2s";
+				reg = <0x0 0x70301400 0x0 0x100>;
+				nvidia,ahub-cif-ids = <8 8>;
+				clocks = <&tegra_car TEGRA124_CLK_I2S4>;
+				resets = <&tegra_car 102>;
+				reset-names = "i2s";
+				status = "disabled";
+			};
+		};
+
+	}; /* apb */
+
+	ahb_a2: ahb at 0,7c000000 {
+		compatible = "simple-bus";
+		reg = <0x0 0x7c000000 0x0 0x02000000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		usb1: usb at 0,7d000000 {
+			compatible = "nvidia,tegra132-ehci", "nvidia,tegra124-ehci", "nvidia,tegra30-ehci", "usb-ehci";
+			reg = <0x0 0x7d000000 0x0 0x4000>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			phy_type = "utmi";
+			clocks = <&tegra_car TEGRA124_CLK_USBD>;
+			resets = <&tegra_car 22>;
+			reset-names = "usb";
+			nvidia,phy = <&phy1>;
+			status = "disabled";
+		};
+
+		phy1: usb-phy at 0,7d000000 {
+			compatible = "nvidia,tegra132-usb-phy", "nvidia,tegra124-usb-phy", "nvidia,tegra30-usb-phy";
+			reg = <0x0 0x7d000000 0x0 0x4000>,
+			      <0x0 0x7d000000 0x0 0x4000>;
+			phy_type = "utmi";
+			clocks = <&tegra_car TEGRA124_CLK_USBD>,
+				 <&tegra_car TEGRA124_CLK_PLL_U>,
+				 <&tegra_car TEGRA124_CLK_USBD>;
+			clock-names = "reg", "pll_u", "utmi-pads";
+			resets = <&tegra_car 59>, <&tegra_car 22>;
+			reset-names = "usb", "utmi-pads";
+			nvidia,hssync-start-delay = <0>;
+			nvidia,idle-wait-delay = <17>;
+			nvidia,elastic-limit = <16>;
+			nvidia,term-range-adj = <6>;
+			nvidia,xcvr-setup = <9>;
+			nvidia,xcvr-lsfslew = <0>;
+			nvidia,xcvr-lsrslew = <3>;
+			nvidia,hssquelch-level = <2>;
+			nvidia,hsdiscon-level = <5>;
+			nvidia,xcvr-hsslew = <12>;
+			status = "disabled";
+		};
+
+		usb2: usb at 0,7d004000 {
+			compatible = "nvidia,tegra132-ehci", "nvidia,tegra124-ehci", "nvidia,tegra30-ehci", "usb-ehci";
+			reg = <0x0 0x7d004000 0x0 0x4000>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			phy_type = "utmi";
+			clocks = <&tegra_car TEGRA124_CLK_USB2>;
+			resets = <&tegra_car 58>;
+			reset-names = "usb";
+			nvidia,phy = <&phy2>;
+			status = "disabled";
+		};
+
+		phy2: usb-phy at 0,7d004000 {
+			compatible = "nvidia,tegra132-usb-phy", "nvidia,tegra124-usb-phy", "nvidia,tegra30-usb-phy";
+			reg = <0x0 0x7d004000 0x0 0x4000>,
+			      <0x0 0x7d000000 0x0 0x4000>;
+			phy_type = "utmi";
+			clocks = <&tegra_car TEGRA124_CLK_USB2>,
+				 <&tegra_car TEGRA124_CLK_PLL_U>,
+				 <&tegra_car TEGRA124_CLK_USBD>;
+			clock-names = "reg", "pll_u", "utmi-pads";
+			resets = <&tegra_car 22>, <&tegra_car 22>;
+			reset-names = "usb", "utmi-pads";
+			nvidia,hssync-start-delay = <0>;
+			nvidia,idle-wait-delay = <17>;
+			nvidia,elastic-limit = <16>;
+			nvidia,term-range-adj = <6>;
+			nvidia,xcvr-setup = <9>;
+			nvidia,xcvr-lsfslew = <0>;
+			nvidia,xcvr-lsrslew = <3>;
+			nvidia,hssquelch-level = <2>;
+			nvidia,hsdiscon-level = <5>;
+			nvidia,xcvr-hsslew = <12>;
+			nvidia,has-utmi-pad-registers;
+			status = "disabled";
+		};
+
+		usb3: usb at 0,7d008000 {
+			compatible = "nvidia,tegra132-ehci", "nvidia,tegra124-ehci", "nvidia,tegra30-ehci", "usb-ehci";
+			reg = <0x0 0x7d008000 0x0 0x4000>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			phy_type = "utmi";
+			clocks = <&tegra_car TEGRA124_CLK_USB3>;
+			resets = <&tegra_car 59>;
+			reset-names = "usb";
+			nvidia,phy = <&phy3>;
+			status = "disabled";
+		};
+
+		phy3: usb-phy at 0,7d008000 {
+			compatible = "nvidia,tegra132-usb-phy", "nvidia,tegra124-usb-phy", "nvidia,tegra30-usb-phy";
+			reg = <0x0 0x7d008000 0x0 0x4000>,
+			      <0x0 0x7d000000 0x0 0x4000>;
+			phy_type = "utmi";
+			clocks = <&tegra_car TEGRA124_CLK_USB3>,
+				 <&tegra_car TEGRA124_CLK_PLL_U>,
+				 <&tegra_car TEGRA124_CLK_USBD>;
+			clock-names = "reg", "pll_u", "utmi-pads";
+			resets = <&tegra_car 58>, <&tegra_car 22>;
+			reset-names = "usb", "utmi-pads";
+			nvidia,hssync-start-delay = <0>;
+			nvidia,idle-wait-delay = <17>;
+			nvidia,elastic-limit = <16>;
+			nvidia,term-range-adj = <6>;
+			nvidia,xcvr-setup = <9>;
+			nvidia,xcvr-lsfslew = <0>;
+			nvidia,xcvr-lsrslew = <3>;
+			nvidia,hssquelch-level = <2>;
+			nvidia,hsdiscon-level = <5>;
+			nvidia,xcvr-hsslew = <12>;
+			status = "disabled";
+		};
+
+	}; /* ahb_a2 */
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "nvidia,denver", "arm,armv8";
+			reg = <0x0 0x0>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x80000008>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "nvidia,denver", "arm,armv8";
+			reg = <0x0 0x1>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x80000008>;
+		};
+	};
+
+	thermal-zones {
+		/* XXX T132 CPU thermal zone - still TBD */
+
+		mem {
+			thermal-sensors =
+				<&soc_therm TEGRA124_SOCTHERM_SENSOR_MEM>;
+		};
+
+		gpu {
+			thermal-sensors =
+				<&soc_therm TEGRA124_SOCTHERM_SENSOR_GPU>;
+		};
+
+		pllx {
+			thermal-sensors =
+				<&soc_therm TEGRA124_SOCTHERM_SENSOR_PLLX>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+};
-- 
2.0.0.GIT
