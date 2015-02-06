From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  6 Feb 2015 16:57:55 +0100
Subject: [PATCH 09/10] ARM: mvebu: add Device Tree files for Armada 39x SoC
 and board
In-Reply-To: <1423238276-9206-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1423238276-9206-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1423238276-9206-10-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the Device Tree files for the Armada 39x family of
processors, as well as one Armada 398 Development Board.

Like for other Marvell EBU families, a common armada-39x.dtsi contains
the description of the common features of all Armada 39x SoCs, while
armada-390.dtsi and armada-398.dtsi respectively describe the
specificities of those SoCs.

Finally, an armada-398-db.dts file is added to describe the Armada 398
Development Board itself.

So far, the following features are supported:

 * SMP: dual Cortex-A9
 * Basic ARM IPs: SCU, timer, GIC
 * Basic Marvell IPs: pin-muxing, clocks, system controller, MBus
   controller, MPIC interrupt controller, timer, CPU reset for SMP,
   PMSU.
 * I2C
 * UART
 * PCIe

Additional features will be supported in the future.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/Makefile          |   2 +
 arch/arm/boot/dts/armada-390.dtsi   |  57 ++++++
 arch/arm/boot/dts/armada-398-db.dts | 116 +++++++++++
 arch/arm/boot/dts/armada-398.dtsi   |  60 ++++++
 arch/arm/boot/dts/armada-39x.dtsi   | 372 ++++++++++++++++++++++++++++++++++++
 5 files changed, 607 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-390.dtsi
 create mode 100644 arch/arm/boot/dts/armada-398-db.dts
 create mode 100644 arch/arm/boot/dts/armada-398.dtsi
 create mode 100644 arch/arm/boot/dts/armada-39x.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 968bc7a..64886fb 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -540,6 +540,8 @@ dtb-$(CONFIG_MACH_ARMADA_38X) += \
 	armada-388-db.dtb \
 	armada-388-gp.dtb \
 	armada-388-rd.dtb
+dtb-$(CONFIG_MACH_ARMADA_39X) += \
+	armada-398-db.dtb
 dtb-$(CONFIG_MACH_ARMADA_XP) += \
 	armada-xp-axpwifiap.dtb \
 	armada-xp-db.dtb \
diff --git a/arch/arm/boot/dts/armada-390.dtsi b/arch/arm/boot/dts/armada-390.dtsi
new file mode 100644
index 0000000..094e39c
--- /dev/null
+++ b/arch/arm/boot/dts/armada-390.dtsi
@@ -0,0 +1,57 @@
+/*
+ * Device Tree Include file for Marvell Armada 390 SoC.
+ *
+ * Copyright (C) 2015 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "armada-39x.dtsi"
+
+/ {
+	soc {
+		internal-regs {
+			pinctrl at 18000 {
+				compatible = "marvell,mv88f6920-pinctrl";
+				reg = <0x18000 0x20>;
+			};
+		};
+};
diff --git a/arch/arm/boot/dts/armada-398-db.dts b/arch/arm/boot/dts/armada-398-db.dts
new file mode 100644
index 0000000..b889864
--- /dev/null
+++ b/arch/arm/boot/dts/armada-398-db.dts
@@ -0,0 +1,116 @@
+/*
+ * Device Tree Include file for Marvell Armada 398 Development Board
+ *
+ * Copyright (C) 2015 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "armada-398.dtsi"
+
+/ {
+	model = "Marvell Armada 398 Development Board";
+	compatible = "marvell,a398-db", "marvell,armada398", "marvell,armada390";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000>; /* 2 GB */
+	};
+
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
+			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
+
+		internal-regs {
+                        i2c at 11000 {
+				pinctrl-0 = <&i2c0_pins>;
+				pinctrl-names = "default";
+                                status = "okay";
+                                clock-frequency = <100000>;
+                        };
+
+			serial at 12000 {
+				pinctrl-0 = <&uart0_pins>;
+				pinctrl-names = "default";
+				status = "okay";
+			};
+
+			serial at 12100 {
+				pinctrl-0 = <&uart1_pins>;
+				pinctrl-names = "default";
+				status = "okay";
+			};
+
+			pinctrl at 18000 {
+				uart0_pins: uart0-pins {
+					marvell,pins = "mpp0", "mpp1";
+					marvell,function = "ua0";
+				};
+
+				uart1_pins: uart1-pins {
+					marvell,pins = "mpp19", "mpp20";
+					marvell,function = "ua1";
+				};
+			};
+		};
+
+		pcie-controller {
+			status = "okay";
+
+			pcie at 1,0 {
+				status = "okay";
+			};
+
+			pcie at 2,0 {
+				status = "okay";
+			};
+
+			pcie at 3,0 {
+				status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-398.dtsi b/arch/arm/boot/dts/armada-398.dtsi
new file mode 100644
index 0000000..fdc2591
--- /dev/null
+++ b/arch/arm/boot/dts/armada-398.dtsi
@@ -0,0 +1,60 @@
+/*
+ * Device Tree Include file for Marvell Armada 398 SoC.
+ *
+ * Copyright (C) 2015 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "armada-39x.dtsi"
+
+/ {
+	compatible = "marvell,armada398", "marvell,armada390";
+
+	soc {
+		internal-regs {
+			pinctrl at 18000 {
+				compatible = "marvell,mv88f6928-pinctrl";
+				reg = <0x18000 0x20>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
new file mode 100644
index 0000000..e248332
--- /dev/null
+++ b/arch/arm/boot/dts/armada-39x.dtsi
@@ -0,0 +1,372 @@
+/*
+ * Device Tree Include file for Marvell Armada 39x family of SoCs.
+ *
+ * Copyright (C) 2015 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "skeleton.dtsi"
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+#define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
+
+/ {
+	model = "Marvell Armada 39x family SoC";
+	compatible = "marvell,armada390";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "marvell,armada-390-smp";
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+		};
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+		};
+	};
+
+	soc {
+		compatible = "marvell,armada390-mbus", "marvell,armadaxp-mbus",
+			     "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		controller = <&mbusc>;
+		interrupt-parent = <&gic>;
+		pcie-mem-aperture = <0xe0000000 0x8000000>;
+		pcie-io-aperture  = <0xe8000000 0x100000>;
+
+		bootrom {
+			compatible = "marvell,bootrom";
+			reg = <MBUS_ID(0x01, 0x1d) 0 0x200000>;
+		};
+
+		internal-regs {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 MBUS_ID(0xf0, 0x01) 0 0x100000>;
+
+			scu at c000 {
+				compatible = "arm,cortex-a9-scu";
+				reg = <0xc000 0x100>;
+			};
+
+			timer at c600 {
+				compatible = "arm,cortex-a9-twd-timer";
+				reg = <0xc600 0x20>;
+				interrupts = <GIC_PPI 13 (IRQ_TYPE_EDGE_RISING | GIC_CPU_MASK_SIMPLE(2))>;
+				clocks = <&coreclk 2>;
+			};
+
+			gic: interrupt-controller at d000 {
+				compatible = "arm,cortex-a9-gic";
+				#interrupt-cells = <3>;
+				#size-cells = <0>;
+				interrupt-controller;
+				reg = <0xd000 0x1000>,
+				      <0xc100 0x100>;
+			};
+
+			i2c0: i2c at 11000 {
+				compatible = "marvell,mv64xxx-i2c";
+				reg = <0x11000 0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				timeout-ms = <1000>;
+				clocks = <&coreclk 0>;
+				status = "disabled";
+			};
+
+			i2c1: i2c at 11100 {
+				compatible = "marvell,mv64xxx-i2c";
+				reg = <0x11100 0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+				timeout-ms = <1000>;
+				clocks = <&coreclk 0>;
+				status = "disabled";
+			};
+
+			i2c2: i2c at 11200 {
+				compatible = "marvell,mv64xxx-i2c";
+				reg = <0x11200 0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+				timeout-ms = <1000>;
+				clocks = <&coreclk 0>;
+				status = "disabled";
+			};
+
+			i2c3: i2c at 11300 {
+				compatible = "marvell,mv64xxx-i2c";
+				reg = <0x11300 0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+				timeout-ms = <1000>;
+				clocks = <&coreclk 0>;
+				status = "disabled";
+			};
+
+			serial at 12000 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x12000 0x100>;
+				reg-shift = <2>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				reg-io-width = <1>;
+				clocks = <&coreclk 0>;
+				status = "disabled";
+			};
+
+			serial at 12100 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x12100 0x100>;
+				reg-shift = <2>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				reg-io-width = <1>;
+				clocks = <&coreclk 0>;
+				status = "disabled";
+			};
+
+			serial at 12200 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x12200 0x100>;
+				reg-shift = <2>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				reg-io-width = <1>;
+				clocks = <&coreclk 0>;
+				status = "disabled";
+			};
+
+			serial at 12300 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x12300 0x100>;
+				reg-shift = <2>;
+				interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+				reg-io-width = <1>;
+				clocks = <&coreclk 0>;
+				status = "disabled";
+			};
+
+			pinctrl at 18000 {
+				i2c0_pins: i2c0-pins {
+					marvell,pins = "mpp2", "mpp3";
+					marvell,function = "i2c0";
+				};
+			};
+
+			system-controller at 18200 {
+				compatible = "marvell,armada-390-system-controller",
+					     "marvell,armada-370-xp-system-controller";
+				reg = <0x18200 0x100>;
+			};
+
+			gateclk: clock-gating-control at 18220 {
+				compatible = "marvell,armada-390-gating-clock";
+				reg = <0x18220 0x4>;
+				clocks = <&coreclk 0>;
+				#clock-cells = <1>;
+			};
+
+			coreclk: mvebu-sar at 18600 {
+				compatible = "marvell,armada-390-core-clock";
+				reg = <0x18600 0x04>;
+				#clock-cells = <1>;
+			};
+
+			mbusc: mbus-controller at 20000 {
+				compatible = "marvell,mbus-controller";
+				reg = <0x20000 0x100>, <0x20180 0x20>, <0x20250 0x8>;
+			};
+
+			mpic: interrupt-controller at 20000 {
+				compatible = "marvell,mpic";
+				reg = <0x20a00 0x2d0>, <0x21070 0x58>;
+				#interrupt-cells = <1>;
+				#size-cells = <1>;
+				interrupt-controller;
+				msi-controller;
+				interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			timer at 20300 {
+				compatible = "marvell,armada-380-timer",
+					     "marvell,armada-xp-timer";
+				reg = <0x20300 0x30>, <0x21040 0x30>;
+				interrupts-extended = <&gic  GIC_SPI  8 IRQ_TYPE_LEVEL_HIGH>,
+						      <&gic  GIC_SPI  9 IRQ_TYPE_LEVEL_HIGH>,
+						      <&gic  GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+						      <&gic  GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+						      <&mpic 5>,
+						      <&mpic 6>;
+				clocks = <&coreclk 2>, <&coreclk 5>;
+				clock-names = "nbclk", "fixed";
+			};
+
+			cpurst at 20800 {
+				compatible = "marvell,armada-370-cpu-reset";
+				reg = <0x20800 0x10>;
+			};
+
+			pmsu at 22000 {
+				compatible = "marvell,armada-390-pmsu",
+					     "marvell,armada-380-pmsu";
+				reg = <0x22000 0x1000>;
+			};
+		};
+
+		pcie-controller {
+			compatible = "marvell,armada-370-pcie";
+			status = "disabled";
+			device_type = "pci";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			msi-parent = <&mpic>;
+			bus-range = <0x00 0xff>;
+
+			ranges =
+			       <0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000
+				0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000
+				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000
+				0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000
+				0x82000000 0x1 0     MBUS_ID(0x08, 0xe8) 0 1 0 /* Port 0 MEM */
+				0x81000000 0x1 0     MBUS_ID(0x08, 0xe0) 0 1 0 /* Port 0 IO  */
+				0x82000000 0x2 0     MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 1 MEM */
+				0x81000000 0x2 0     MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 1 IO  */
+				0x82000000 0x3 0     MBUS_ID(0x04, 0xd8) 0 1 0 /* Port 2 MEM */
+				0x81000000 0x3 0     MBUS_ID(0x04, 0xd0) 0 1 0 /* Port 2 IO  */
+				0x82000000 0x4 0     MBUS_ID(0x04, 0xb8) 0 1 0 /* Port 3 MEM */
+				0x81000000 0x4 0     MBUS_ID(0x04, 0xb0) 0 1 0 /* Port 3 IO  */>;
+
+			/*
+			 * This port can be either x4 or x1. When
+			 * configured in x4 by the bootloader, then
+			 * pcie at 4,0 is not available.
+			 */
+			pcie at 1,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x80000 0 0x2000>;
+				reg = <0x0800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
+					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &gic GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 8>;
+				status = "disabled";
+			};
+
+			/* x1 port */
+			pcie at 2,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
+				reg = <0x1000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
+					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &gic GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+				marvell,pcie-port = <1>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 5>;
+				status = "disabled";
+			};
+
+			/* x1 port */
+			pcie at 3,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
+				reg = <0x1800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
+					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+				marvell,pcie-port = <2>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 6>;
+				status = "disabled";
+			};
+
+			/*
+			 * x1 port only available when pcie at 1,0 is
+			 * configured as a x1 port
+			 */
+			pcie at 4,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x48000 0 0x2000>;
+				reg = <0x2000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
+					  0x81000000 0 0 0x81000000 0x4 0 1 0>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &gic GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+				marvell,pcie-port = <3>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 7>;
+				status = "disabled";
+			};
+		};
+	};
+};
-- 
2.1.0
