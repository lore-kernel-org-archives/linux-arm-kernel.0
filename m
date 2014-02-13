From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Feb 2014 12:04:32 +0100
Subject: [PATCH v3 10/13] ARM: mvebu: add Device Tree description of the
 Armada 380/385 SoCs
In-Reply-To: <1392289475-8902-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392289475-8902-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392289475-8902-11-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 380 and 385 SoCs are new SoCs from Marvell, based on a
Cortex-A9 cores (single core for 380, dual core for 385) and a number
of hardware blocks that are common with earlier SoCs from the mvebu
family.

The provided Device Tree describes the following parts of the SoC:

 * CPU
 * Device Bus
 * Clocks
 * Interrupt controllers: GIC and MPIC
 * GPIO controllers
 * I2C buses
 * L2 cache
 * MBus controller
 * Pinctrl
 * Serial
 * SPI buses
 * System controller (for reboot)
 * Timer
 * XOR engines
 * PCIe controllers
 * Network interfaces

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-380.dtsi | 117 +++++++++++++
 arch/arm/boot/dts/armada-385.dtsi | 149 ++++++++++++++++
 arch/arm/boot/dts/armada-38x.dtsi | 345 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 611 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-380.dtsi
 create mode 100644 arch/arm/boot/dts/armada-385.dtsi
 create mode 100644 arch/arm/boot/dts/armada-38x.dtsi

diff --git a/arch/arm/boot/dts/armada-380.dtsi b/arch/arm/boot/dts/armada-380.dtsi
new file mode 100644
index 0000000..5a46ec7
--- /dev/null
+++ b/arch/arm/boot/dts/armada-380.dtsi
@@ -0,0 +1,117 @@
+/*
+ * Device Tree Include file for Marvell Armada 380 SoC.
+ *
+ * Copyright (C) 2014 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/include/ "armada-38x.dtsi"
+
+/ {
+	model = "Marvell Armada 380 family SoC";
+	compatible = "marvell,armada380", "marvell,armada38x";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+		};
+	};
+
+	soc {
+		internal-regs {
+			pinctrl {
+				compatible = "marvell,mv88f6810-pinctrl";
+				reg = <0x18000 0x20>;
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
+				0x81000000 0x3 0     MBUS_ID(0x04, 0xd0) 0 1 0 /* Port 2 IO  */>;
+
+			/* x1 port */
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
+				interrupt-map = <0 0 0 0 &gic 0 29 0x4>;
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
+				interrupt-map = <0 0 0 0 &gic 0 33 0x4>;
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
+				reg = <0x1000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
+					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &gic 0 70 0x4>;
+				marvell,pcie-port = <2>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 6>;
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/armada-385.dtsi
new file mode 100644
index 0000000..b22f5f1
--- /dev/null
+++ b/arch/arm/boot/dts/armada-385.dtsi
@@ -0,0 +1,149 @@
+/*
+ * Device Tree Include file for Marvell Armada 385 SoC.
+ *
+ * Copyright (C) 2014 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include "armada-38x.dtsi"
+
+/ {
+	model = "Marvell Armada 385 family SoC";
+	compatible = "marvell,armada385", "marvell,armada38x";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
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
+		internal-regs {
+			pinctrl {
+				compatible = "marvell,mv88f6820-pinctrl";
+				reg = <0x18000 0x20>;
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
+				interrupt-map = <0 0 0 0 &gic 0 29 0x4>;
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
+				interrupt-map = <0 0 0 0 &gic 0 33 0x4>;
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
+				reg = <0x1000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
+					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &gic 0 70 0x4>;
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
+				reg = <0x1000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
+					  0x81000000 0 0 0x81000000 0x4 0 1 0>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &gic 0 71 0x4>;
+				marvell,pcie-port = <3>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 7>;
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
new file mode 100644
index 0000000..5a10248
--- /dev/null
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -0,0 +1,345 @@
+/*
+ * Device Tree Include file for Marvell Armada 38x family of SoCs.
+ *
+ * Copyright (C) 2014 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include "skeleton.dtsi"
+
+#define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
+
+/ {
+	model = "Marvell Armada 38x family SoC";
+	compatible = "marvell,armada38x";
+
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		eth0 = &eth0;
+		eth1 = &eth1;
+		eth2 = &eth2;
+	};
+
+	soc {
+		compatible = "marvell,armada380-mbus", "marvell,armada370-mbus",
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
+		devbus-bootcs {
+			compatible = "marvell,mvebu-devbus";
+			reg = <MBUS_ID(0xf0, 0x01) 0x10400 0x8>;
+			ranges = <0 MBUS_ID(0x01, 0x2f) 0 0xffffffff>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
+
+		devbus-cs0 {
+			compatible = "marvell,mvebu-devbus";
+			reg = <MBUS_ID(0xf0, 0x01) 0x10408 0x8>;
+			ranges = <0 MBUS_ID(0x01, 0x3e) 0 0xffffffff>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
+
+		devbus-cs1 {
+			compatible = "marvell,mvebu-devbus";
+			reg = <MBUS_ID(0xf0, 0x01) 0x10410 0x8>;
+			ranges = <0 MBUS_ID(0x01, 0x3d) 0 0xffffffff>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
+
+		devbus-cs2 {
+			compatible = "marvell,mvebu-devbus";
+			reg = <MBUS_ID(0xf0, 0x01) 0x10418 0x8>;
+			ranges = <0 MBUS_ID(0x01, 0x3b) 0 0xffffffff>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
+
+		devbus-cs3 {
+			compatible = "marvell,mvebu-devbus";
+			reg = <MBUS_ID(0xf0, 0x01) 0x10420 0x8>;
+			ranges = <0 MBUS_ID(0x01, 0x37) 0 0xffffffff>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
+
+		internal-regs {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 MBUS_ID(0xf0, 0x01) 0 0x100000>;
+
+			L2: cache-controller at 8000 {
+				compatible = "arm,pl310-cache";
+				reg = <0x8000 0x1000>;
+				cache-unified;
+				cache-level = <2>;
+			};
+
+			timer at c600 {
+				compatible = "arm,cortex-a9-twd-timer";
+				reg = <0xc600 0x20>;
+				interrupts = <1 13 0x301>;
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
+			spi0: spi at 10600 {
+				compatible = "marvell,orion-spi";
+				reg = <0x10600 0x50>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				cell-index = <0>;
+				interrupts = <0 1 0x4>;
+				clocks = <&coreclk 0>;
+				status = "disabled";
+			};
+
+			spi1: spi at 10680 {
+				compatible = "marvell,orion-spi";
+				reg = <0x10680 0x50>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				cell-index = <1>;
+				interrupts = <0 63 0x4>;
+				clocks = <&coreclk 0>;
+				status = "disabled";
+			};
+
+			i2c0: i2c at 11000 {
+				compatible = "marvell,mv64xxx-i2c";
+				reg = <0x11000 0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <0 2 0x4>;
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
+				interrupts = <0 3 0x4>;
+				timeout-ms = <1000>;
+				clocks = <&coreclk 0>;
+				status = "disabled";
+			};
+
+			serial at 12000 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x12000 0x100>;
+				reg-shift = <2>;
+				interrupts = <0 12 4>;
+				reg-io-width = <1>;
+				status = "disabled";
+			};
+
+			serial at 12100 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x12100 0x100>;
+				reg-shift = <2>;
+				interrupts = <0 13 4>;
+				reg-io-width = <1>;
+				status = "disabled";
+			};
+
+			pinctrl {
+				compatible = "marvell,mv88f6820-pinctrl";
+				reg = <0x18000 0x20>;
+			};
+
+			gpio0: gpio at 18100 {
+				compatible = "marvell,orion-gpio";
+				reg = <0x18100 0x40>;
+				ngpios = <32>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 53 0x4>, <0 54 0x4>,
+					     <0 55 0x4>, <0 56 0x4>;
+			};
+
+			gpio1: gpio at 18140 {
+				compatible = "marvell,orion-gpio";
+				reg = <0x18140 0x40>;
+				ngpios = <28>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <0 58 0x4>, <0 59 0x4>,
+					     <0 60 0x4>, <0 61 0x4>;
+			};
+
+			system-controller at 18200 {
+				compatible = "marvell,armada-380-system-controller",
+					     "marvell,armada-370-xp-system-controller";
+				reg = <0x18200 0x100>;
+			};
+
+			gateclk: clock-gating-control at 18220 {
+				compatible = "marvell,armada-380-gating-clock";
+				reg = <0x18220 0x4>;
+				clocks = <&coreclk 0>;
+				#clock-cells = <1>;
+			};
+
+			coreclk: mvebu-sar at 18600 {
+				compatible = "marvell,armada-380-core-clock";
+				reg = <0x18600 0x04>;
+				#clock-cells = <1>;
+			};
+
+			mbusc: mbus-controller at 20000 {
+				compatible = "marvell,mbus-controller";
+				reg = <0x20000 0x100>, <0x20180 0x20>;
+			};
+
+			mpic: interrupt-controller at 20000 {
+				compatible = "marvell,mpic";
+				reg = <0x20a00 0x2d0>, <0x21070 0x58>;
+				#interrupt-cells = <1>;
+				#size-cells = <1>;
+				interrupt-controller;
+				msi-controller;
+				interrupts = <1 15 0x4>;
+			};
+
+			timer at 20300 {
+				compatible = "marvell,armada-380-timer",
+					     "marvell,armada-xp-timer";
+				reg = <0x20300 0x30>, <0x21040 0x30>;
+				interrupts-extended = <&gic  0  8 4>,
+						      <&gic  0  9 4>,
+						      <&gic  0 10 4>,
+						      <&gic  0 11 4>,
+						      <&mpic 5>,
+						      <&mpic 6>;
+				clocks = <&coreclk 2>, <&refclk>;
+				clock-names = "nbclk", "fixed";
+			};
+
+			eth1: ethernet at 30000 {
+				compatible = "marvell,armada-370-neta";
+				reg = <0x30000 0x4000>;
+				interrupts-extended = <&mpic 10>;
+				clocks = <&gateclk 3>;
+				status = "disabled";
+			};
+
+			eth2: ethernet at 34000 {
+				compatible = "marvell,armada-370-neta";
+				reg = <0x34000 0x4000>;
+				interrupts-extended = <&mpic 12>;
+				clocks = <&gateclk 2>;
+				status = "disabled";
+			};
+
+			xor at 60800 {
+				compatible = "marvell,orion-xor";
+				reg = <0x60800 0x100
+				       0x60a00 0x100>;
+				clocks = <&gateclk 22>;
+				status = "okay";
+
+				xor00 {
+					interrupts = <0 22 0x4>;
+					dmacap,memcpy;
+					dmacap,xor;
+				};
+				xor01 {
+					interrupts = <0 23 0x4>;
+					dmacap,memcpy;
+					dmacap,xor;
+					dmacap,memset;
+				};
+			};
+
+			xor at 60900 {
+				compatible = "marvell,orion-xor";
+				reg = <0x60900 0x100
+				       0x60b00 0x100>;
+				clocks = <&gateclk 28>;
+				status = "okay";
+
+				xor10 {
+					interrupts = <0 65 0x4>;
+					dmacap,memcpy;
+					dmacap,xor;
+				};
+				xor11 {
+					interrupts = <0 66 0x4>;
+					dmacap,memcpy;
+					dmacap,xor;
+					dmacap,memset;
+				};
+			};
+
+			eth0: ethernet at 70000 {
+				compatible = "marvell,armada-370-neta";
+				reg = <0x70000 0x4000>;
+				interrupts-extended = <&mpic 8>;
+				clocks = <&gateclk 4>;
+				status = "disabled";
+			};
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "marvell,orion-mdio";
+				reg = <0x72004 0x4>;
+			};
+		};
+	};
+
+	clocks {
+		/* 25 MHz reference crystal */
+		refclk: oscillator {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <25000000>;
+		};
+	};
+};
-- 
1.8.3.2
