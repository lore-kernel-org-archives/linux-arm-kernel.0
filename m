From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  2 Jan 2018 15:55:57 +0100
Subject: [PATCH v2 7/8] arm64: dts: marvell: de-duplicate CP110 description
In-Reply-To: <20180102145558.9773-1-thomas.petazzoni@free-electrons.com>
References: <20180102145558.9773-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20180102145558.9773-8-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One concept of Marvell Armada 7K/8K SoCs is that they are made of HW
blocks composed of a variety of IPs (network, PCIe, SATA, XOR, SPI,
I2C, etc.), and those HW blocks can be duplicated several times within
a given SoC. The Armada 7K SoC has a single CP110 (so no duplication),
while the Armada 8K SoC has two CP110. In the future, SoCs with more
than 2 CP110s will be introduced.

In current kernel versions, the master CP110 is described in
armada-cp110-master.dtsi and the slave CP110 is described in
armada-cp110-slave.dtsi. Those files are basically exactly the same,
since they describe the same hardware. They only have a few
differences:

 - Base address of the registers is different for the "config-space"

 - Base address of the PCIe registers, MEM, CONF and IO areas were
   different

 - Labels (and phandles pointing to them) of the nodes were different
   ("cpm" prefix in the master CP, "cps" prefix in the slave CP)

This duplication issue has been discussed at the DT workshop [1] in
Prague last October, and we presented on this topic [2]. The solution
of using the C pre-processor to avoid this duplication has been
validated by the people present in this DT workshop, and this patch
simply implements what has been presented.

We handle differences between the master CP and slave CP description
using the C pre-processor, by defining a set of macros with different
values armada-cp110.dtsi is included to instantiate one of the master
or slave CP110.

There are a few aspects that deserve additional explanations:

 - PCIe needs to be handled separately because it is not part of the
   config-space {...} node, since it has registers outside of the
   range covered by config-space {...}.

 - We need to defined CP110_BASE, CP110_PCIEx_BASE without 0x, because
   they are used for the unit address part of some DT nodes. But since
   they are also used for the "reg" property of the same nodes, we
   have an ADDRESSIFY() macro that prepends 0x to those values.

We compared the resulting .dtb for armada-8040-db.dtb before and after
this patch is applied, and the result is exactly the same, except for
a few differences:

 - the SDHCI controller that was only described in the master CP110 is
   now also described in the slave CP110. Even though the SDHCI
   controller from the slave CP110 is indeed not usable (as it isn't
   wired to the outside world) it is technically part of the silicon,
   and therefore it is reasonable to also describe it to be part of
   the slave CP110. In addition, if we wanted to get this correct for
   the SDHCI controller, we should also do it for the NAND controller,
   for which the situation is even more complicated: in a single CP110
   configuration (Armada 7K), the usable NAND controller is in the
   master CP110, while in a dual CP110 configuration (Armada 8K), the
   usable NAND controller is in the slave CP110. Since that would add
   a lot of additional complexity for no good reason, and since the IP
   blocks are in fact really present in both CPs, we simply describe
   them in both CPs at the DT level.

 - the cp110-master and cp110-slave nodes are now named cpm and
   cps. We could have kept cp110-master and cp110-slave, but that
   would have required adding another CP110_xyz define, which didn't
   seem very useful.

Note that this commit also gets rid of the armada-cp110-master.dtsi
and armada-cp110-slave.dtsi files, as future SoCs will have more than
2 CPs. Instead, we instantiate the CPs directly from the SoC-specific
.dtsi files, i.e armada-70x0.dtsi and armada-80x0.dtsi.

[1] https://elinux.org/Device_tree_kernel_summit_2017_etherpad
[2] https://elinux.org/images/1/14/DTWorkshop2017-duplicate-data.pdf

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi       |  23 +-
 arch/arm64/boot/dts/marvell/armada-80x0.dtsi       |  56 ++-
 arch/arm64/boot/dts/marvell/armada-common.dtsi     |  10 +
 .../boot/dts/marvell/armada-cp110-master.dtsi      | 447 ---------------------
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 446 --------------------
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      | 422 +++++++++++++++++++
 6 files changed, 506 insertions(+), 898 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-common.dtsi
 delete mode 100644 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
 delete mode 100644 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-cp110.dtsi

diff --git a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
index 815e64b3a874..9917cff3dae6 100644
--- a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
@@ -44,8 +44,6 @@
  * Device Tree file for the Armada 70x0 SoC
  */
 
-#include "armada-cp110-master.dtsi"
-
 / {
 	aliases {
 		gpio1 = &cpm_gpio1;
@@ -55,6 +53,27 @@
 	};
 };
 
+/*
+ * Instantiate the CP110
+ */
+#define CP110_NAME		cpm
+#define CP110_BASE		f2000000
+#define CP110_PCIE_IO_BASE	0xf9000000
+#define CP110_PCIE_MEM_BASE	0xf6000000
+#define CP110_PCIE0_BASE	f2600000
+#define CP110_PCIE1_BASE	f2620000
+#define CP110_PCIE2_BASE	f2640000
+
+#include "armada-cp110.dtsi"
+
+#undef CP110_NAME
+#undef CP110_BASE
+#undef CP110_PCIE_IO_BASE
+#undef CP110_PCIE_MEM_BASE
+#undef CP110_PCIE0_BASE
+#undef CP110_PCIE1_BASE
+#undef CP110_PCIE2_BASE
+
 &cpm_gpio1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
index de9c34333cd4..5e038e7b7b30 100644
--- a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
@@ -44,9 +44,6 @@
  * Device Tree file for the Armada 80x0 SoC family
  */
 
-#include "armada-cp110-master.dtsi"
-#include "armada-cp110-slave.dtsi"
-
 / {
 	aliases {
 		gpio1 = &cps_gpio1;
@@ -58,6 +55,48 @@
 	};
 };
 
+/*
+ * Instantiate the master CP110
+ */
+#define CP110_NAME		cpm
+#define CP110_BASE		f2000000
+#define CP110_PCIE_IO_BASE	0xf9000000
+#define CP110_PCIE_MEM_BASE	0xf6000000
+#define CP110_PCIE0_BASE	f2600000
+#define CP110_PCIE1_BASE	f2620000
+#define CP110_PCIE2_BASE	f2640000
+
+#include "armada-cp110.dtsi"
+
+#undef CP110_NAME
+#undef CP110_BASE
+#undef CP110_PCIE_IO_BASE
+#undef CP110_PCIE_MEM_BASE
+#undef CP110_PCIE0_BASE
+#undef CP110_PCIE1_BASE
+#undef CP110_PCIE2_BASE
+
+/*
+ * Instantiate the slave CP110
+ */
+#define CP110_NAME		cps
+#define CP110_BASE		f4000000
+#define CP110_PCIE_IO_BASE	0xfd000000
+#define CP110_PCIE_MEM_BASE	0xfa000000
+#define CP110_PCIE0_BASE	f4600000
+#define CP110_PCIE1_BASE	f4620000
+#define CP110_PCIE2_BASE	f4640000
+
+#include "armada-cp110.dtsi"
+
+#undef CP110_NAME
+#undef CP110_BASE
+#undef CP110_PCIE_IO_BASE
+#undef CP110_PCIE_MEM_BASE
+#undef CP110_PCIE0_BASE
+#undef CP110_PCIE1_BASE
+#undef CP110_PCIE2_BASE
+
 /* The 80x0 has two CP blocks, but uses only one block from each. */
 &cps_gpio1 {
 	status = "okay";
@@ -95,3 +134,14 @@
 		};
 	};
 };
+
+&cps_crypto {
+	/*
+	 * The cryptographic engine found on the cp110
+	 * master is enabled by default at the SoC
+	 * level. Because it is not possible as of now
+	 * to enable two cryptographic engines in
+	 * parallel, disable this one by default.
+	 */
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-common.dtsi b/arch/arm64/boot/dts/marvell/armada-common.dtsi
new file mode 100644
index 000000000000..c6dd1d81c68d
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-common.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR X11)
+/*
+ * Copyright (C) 2016 Marvell Technology Group Ltd.
+ */
+
+/* Common definitions used by Armada 7K/8K DTs */
+#define PASTER(x, y) x ## y
+#define EVALUATOR(x, y) PASTER(x, y)
+#define CP110_LABEL(name) EVALUATOR(CP110_NAME, EVALUATOR(_, name))
+#define ADDRESSIFY(addr) EVALUATOR(0x, addr)
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
deleted file mode 100644
index 162e6c228bd9..000000000000
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ /dev/null
@@ -1,447 +0,0 @@
-/*
- * Copyright (C) 2016 Marvell Technology Group Ltd.
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPLv2 or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-/*
- * Device Tree file for Marvell Armada CP110 Master.
- */
-
-#include <dt-bindings/interrupt-controller/mvebu-icu.h>
-
-/ {
-	cp110-master {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		compatible = "simple-bus";
-		interrupt-parent = <&cpm_icu>;
-		ranges;
-
-		config-space at f2000000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "simple-bus";
-			ranges = <0x0 0x0 0xf2000000 0x2000000>;
-
-			cpm_ethernet: ethernet at 0 {
-				compatible = "marvell,armada-7k-pp22";
-				reg = <0x0 0x100000>, <0x129000 0xb000>;
-				clocks = <&cpm_clk 1 3>, <&cpm_clk 1 9>, <&cpm_clk 1 5>;
-				clock-names = "pp_clk", "gop_clk", "mg_clk";
-				marvell,system-controller = <&cpm_syscon0>;
-				status = "disabled";
-				dma-coherent;
-
-				cpm_eth0: eth0 {
-					interrupts = <ICU_GRP_NSR 39 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 43 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 47 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 51 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 55 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 129 IRQ_TYPE_LEVEL_HIGH>;
-					interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
-							  "tx-cpu3", "rx-shared", "link";
-					port-id = <0>;
-					gop-port-id = <0>;
-					status = "disabled";
-				};
-
-				cpm_eth1: eth1 {
-					interrupts = <ICU_GRP_NSR 40 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 44 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 48 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 52 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 56 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 128 IRQ_TYPE_LEVEL_HIGH>;
-					interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
-							  "tx-cpu3", "rx-shared", "link";
-					port-id = <1>;
-					gop-port-id = <2>;
-					status = "disabled";
-				};
-
-				cpm_eth2: eth2 {
-					interrupts = <ICU_GRP_NSR 41 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 45 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 49 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 53 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 57 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 127 IRQ_TYPE_LEVEL_HIGH>;
-					interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
-							  "tx-cpu3", "rx-shared", "link";
-					port-id = <2>;
-					gop-port-id = <3>;
-					status = "disabled";
-				};
-			};
-
-			cpm_comphy: phy at 120000 {
-				compatible = "marvell,comphy-cp110";
-				reg = <0x120000 0x6000>;
-				marvell,system-controller = <&cpm_syscon0>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				cpm_comphy0: phy at 0 {
-					reg = <0>;
-					#phy-cells = <1>;
-				};
-
-				cpm_comphy1: phy at 1 {
-					reg = <1>;
-					#phy-cells = <1>;
-				};
-
-				cpm_comphy2: phy at 2 {
-					reg = <2>;
-					#phy-cells = <1>;
-				};
-
-				cpm_comphy3: phy at 3 {
-					reg = <3>;
-					#phy-cells = <1>;
-				};
-
-				cpm_comphy4: phy at 4 {
-					reg = <4>;
-					#phy-cells = <1>;
-				};
-
-				cpm_comphy5: phy at 5 {
-					reg = <5>;
-					#phy-cells = <1>;
-				};
-			};
-
-			cpm_mdio: mdio at 12a200 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "marvell,orion-mdio";
-				reg = <0x12a200 0x10>;
-				clocks = <&cpm_clk 1 9>, <&cpm_clk 1 5>;
-				status = "disabled";
-			};
-
-			cpm_xmdio: mdio at 12a600 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "marvell,xmdio";
-				reg = <0x12a600 0x10>;
-				status = "disabled";
-			};
-
-			cpm_icu: interrupt-controller at 1e0000 {
-				compatible = "marvell,cp110-icu";
-				reg = <0x1e0000 0x10>;
-				#interrupt-cells = <3>;
-				interrupt-controller;
-				msi-parent = <&gicp>;
-			};
-
-			cpm_rtc: rtc at 284000 {
-				compatible = "marvell,armada-8k-rtc";
-				reg = <0x284000 0x20>, <0x284080 0x24>;
-				reg-names = "rtc", "rtc-soc";
-				interrupts = <ICU_GRP_NSR 77 IRQ_TYPE_LEVEL_HIGH>;
-			};
-
-			cpm_thermal: thermal at 400078 {
-				compatible = "marvell,armada-cp110-thermal";
-				reg = <0x400078 0x4>,
-				      <0x400070 0x8>;
-			};
-
-			cpm_syscon0: system-controller at 440000 {
-				compatible = "syscon", "simple-mfd";
-				reg = <0x440000 0x2000>;
-
-				cpm_clk: clock {
-					compatible = "marvell,cp110-clock";
-					#clock-cells = <2>;
-				};
-
-				cpm_gpio1: gpio at 100 {
-					compatible = "marvell,armada-8k-gpio";
-					offset = <0x100>;
-					ngpios = <32>;
-					gpio-controller;
-					#gpio-cells = <2>;
-					gpio-ranges = <&cpm_pinctrl 0 0 32>;
-					interrupt-controller;
-					interrupts = <ICU_GRP_NSR 86 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 85 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 84 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 83 IRQ_TYPE_LEVEL_HIGH>;
-					status = "disabled";
-				};
-
-				cpm_gpio2: gpio at 140 {
-					compatible = "marvell,armada-8k-gpio";
-					offset = <0x140>;
-					ngpios = <31>;
-					gpio-controller;
-					#gpio-cells = <2>;
-					gpio-ranges = <&cpm_pinctrl 0 32 31>;
-					interrupt-controller;
-					interrupts = <ICU_GRP_NSR 82 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 81 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 80 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 79 IRQ_TYPE_LEVEL_HIGH>;
-					status = "disabled";
-				};
-			};
-
-			cpm_usb3_0: usb3 at 500000 {
-				compatible = "marvell,armada-8k-xhci",
-					     "generic-xhci";
-				reg = <0x500000 0x4000>;
-				dma-coherent;
-				interrupts = <ICU_GRP_NSR 106 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cpm_clk 1 22>;
-				status = "disabled";
-			};
-
-			cpm_usb3_1: usb3 at 510000 {
-				compatible = "marvell,armada-8k-xhci",
-					     "generic-xhci";
-				reg = <0x510000 0x4000>;
-				dma-coherent;
-				interrupts = <ICU_GRP_NSR 105 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cpm_clk 1 23>;
-				status = "disabled";
-			};
-
-			cpm_sata0: sata at 540000 {
-				compatible = "marvell,armada-8k-ahci",
-					     "generic-ahci";
-				reg = <0x540000 0x30000>;
-				interrupts = <ICU_GRP_NSR 107 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cpm_clk 1 15>;
-				status = "disabled";
-			};
-
-			cpm_xor0: xor at 6a0000 {
-				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
-				reg = <0x6a0000 0x1000>,
-				      <0x6b0000 0x1000>;
-				dma-coherent;
-				msi-parent = <&gic_v2m0>;
-				clocks = <&cpm_clk 1 8>;
-			};
-
-			cpm_xor1: xor at 6c0000 {
-				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
-				reg = <0x6c0000 0x1000>,
-				      <0x6d0000 0x1000>;
-				dma-coherent;
-				msi-parent = <&gic_v2m0>;
-				clocks = <&cpm_clk 1 7>;
-			};
-
-			cpm_spi0: spi at 700600 {
-				compatible = "marvell,armada-380-spi";
-				reg = <0x700600 0x50>;
-				#address-cells = <0x1>;
-				#size-cells = <0x0>;
-				clocks = <&cpm_clk 1 21>;
-				status = "disabled";
-			};
-
-			cpm_spi1: spi at 700680 {
-				compatible = "marvell,armada-380-spi";
-				reg = <0x700680 0x50>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				clocks = <&cpm_clk 1 21>;
-				status = "disabled";
-			};
-
-			cpm_i2c0: i2c at 701000 {
-				compatible = "marvell,mv78230-i2c";
-				reg = <0x701000 0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <ICU_GRP_NSR 120 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cpm_clk 1 21>;
-				status = "disabled";
-			};
-
-			cpm_i2c1: i2c at 701100 {
-				compatible = "marvell,mv78230-i2c";
-				reg = <0x701100 0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <ICU_GRP_NSR 121 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cpm_clk 1 21>;
-				status = "disabled";
-			};
-
-			cpm_nand: nand at 720000 {
-				/*
-				 * Due to the limitation of the pins available
-				 * this controller is only usable on the CPM
-				 * for A7K and on the CPS for A8K.
-				 */
-				compatible = "marvell,armada-8k-nand",
-					     "marvell,armada370-nand";
-				reg = <0x720000 0x54>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				interrupts = <ICU_GRP_NSR 115 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cpm_clk 1 2>;
-				marvell,system-controller = <&cpm_syscon0>;
-				status = "disabled";
-			};
-
-			cpm_trng: trng at 760000 {
-				compatible = "marvell,armada-8k-rng", "inside-secure,safexcel-eip76";
-				reg = <0x760000 0x7d>;
-				interrupts = <ICU_GRP_NSR 95 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cpm_clk 1 25>;
-				status = "okay";
-			};
-
-			cpm_sdhci0: sdhci at 780000 {
-				compatible = "marvell,armada-cp110-sdhci";
-				reg = <0x780000 0x300>;
-				interrupts = <ICU_GRP_NSR 27 IRQ_TYPE_LEVEL_HIGH>;
-				clock-names = "core";
-				clocks = <&cpm_clk 1 4>;
-				dma-coherent;
-				status = "disabled";
-			};
-
-			cpm_crypto: crypto at 800000 {
-				compatible = "inside-secure,safexcel-eip197";
-				reg = <0x800000 0x200000>;
-				interrupts = <ICU_GRP_NSR 87 IRQ_TYPE_LEVEL_HIGH>,
-					     <ICU_GRP_NSR 88 IRQ_TYPE_LEVEL_HIGH>,
-					     <ICU_GRP_NSR 89 IRQ_TYPE_LEVEL_HIGH>,
-					     <ICU_GRP_NSR 90 IRQ_TYPE_LEVEL_HIGH>,
-					     <ICU_GRP_NSR 91 IRQ_TYPE_LEVEL_HIGH>,
-					     <ICU_GRP_NSR 92 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "mem", "ring0", "ring1",
-				"ring2", "ring3", "eip";
-				clocks = <&cpm_clk 1 26>;
-				dma-coherent;
-			};
-		};
-
-		cpm_pcie0: pcie at f2600000 {
-			compatible = "marvell,armada8k-pcie", "snps,dw-pcie";
-			reg = <0 0xf2600000 0 0x10000>,
-			      <0 0xf6f00000 0 0x80000>;
-			reg-names = "ctrl", "config";
-			#address-cells = <3>;
-			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			device_type = "pci";
-			dma-coherent;
-			msi-parent = <&gic_v2m0>;
-
-			bus-range = <0 0xff>;
-			ranges =
-				/* downstream I/O */
-				<0x81000000 0 0xf9000000 0  0xf9000000 0 0x10000
-				/* non-prefetchable memory */
-				0x82000000 0 0xf6000000 0  0xf6000000 0 0xf00000>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &cpm_icu ICU_GRP_NSR 22 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts = <ICU_GRP_NSR 22 IRQ_TYPE_LEVEL_HIGH>;
-			num-lanes = <1>;
-			clocks = <&cpm_clk 1 13>;
-			status = "disabled";
-		};
-
-		cpm_pcie1: pcie at f2620000 {
-			compatible = "marvell,armada8k-pcie", "snps,dw-pcie";
-			reg = <0 0xf2620000 0 0x10000>,
-			      <0 0xf7f00000 0 0x80000>;
-			reg-names = "ctrl", "config";
-			#address-cells = <3>;
-			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			device_type = "pci";
-			dma-coherent;
-			msi-parent = <&gic_v2m0>;
-
-			bus-range = <0 0xff>;
-			ranges =
-				/* downstream I/O */
-				<0x81000000 0 0xf9010000 0  0xf9010000 0 0x10000
-				/* non-prefetchable memory */
-				0x82000000 0 0xf7000000 0  0xf7000000 0 0xf00000>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &cpm_icu ICU_GRP_NSR 24 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts = <ICU_GRP_NSR 24 IRQ_TYPE_LEVEL_HIGH>;
-
-			num-lanes = <1>;
-			clocks = <&cpm_clk 1 11>;
-			status = "disabled";
-		};
-
-		cpm_pcie2: pcie at f2640000 {
-			compatible = "marvell,armada8k-pcie", "snps,dw-pcie";
-			reg = <0 0xf2640000 0 0x10000>,
-			      <0 0xf8f00000 0 0x80000>;
-			reg-names = "ctrl", "config";
-			#address-cells = <3>;
-			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			device_type = "pci";
-			dma-coherent;
-			msi-parent = <&gic_v2m0>;
-
-			bus-range = <0 0xff>;
-			ranges =
-				/* downstream I/O */
-				<0x81000000 0 0xf9020000 0  0xf9020000 0 0x10000
-				/* non-prefetchable memory */
-				0x82000000 0 0xf8000000 0  0xf8000000 0 0xf00000>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &cpm_icu ICU_GRP_NSR 23 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts = <ICU_GRP_NSR 23 IRQ_TYPE_LEVEL_HIGH>;
-
-			num-lanes = <1>;
-			clocks = <&cpm_clk 1 12>;
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
deleted file mode 100644
index 207b6f444e24..000000000000
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ /dev/null
@@ -1,446 +0,0 @@
-/*
- * Copyright (C) 2016 Marvell Technology Group Ltd.
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPLv2 or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-/*
- * Device Tree file for Marvell Armada CP110 Slave.
- */
-
-#include <dt-bindings/interrupt-controller/mvebu-icu.h>
-
-/ {
-	cp110-slave {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		compatible = "simple-bus";
-		interrupt-parent = <&cps_icu>;
-		ranges;
-
-		config-space at f4000000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "simple-bus";
-			ranges = <0x0 0x0 0xf4000000 0x2000000>;
-
-			cps_ethernet: ethernet at 0 {
-				compatible = "marvell,armada-7k-pp22";
-				reg = <0x0 0x100000>, <0x129000 0xb000>;
-				clocks = <&cps_clk 1 3>, <&cps_clk 1 9>, <&cps_clk 1 5>;
-				clock-names = "pp_clk", "gop_clk", "mg_clk";
-				marvell,system-controller = <&cps_syscon0>;
-				status = "disabled";
-				dma-coherent;
-
-				cps_eth0: eth0 {
-					interrupts = <ICU_GRP_NSR 39 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 43 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 47 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 51 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 55 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 129 IRQ_TYPE_LEVEL_HIGH>;
-					interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
-							  "tx-cpu3", "rx-shared", "link";
-					port-id = <0>;
-					gop-port-id = <0>;
-					status = "disabled";
-				};
-
-				cps_eth1: eth1 {
-					interrupts = <ICU_GRP_NSR 40 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 44 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 48 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 52 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 56 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 128 IRQ_TYPE_LEVEL_HIGH>;
-					interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
-							  "tx-cpu3", "rx-shared", "link";
-					port-id = <1>;
-					gop-port-id = <2>;
-					status = "disabled";
-				};
-
-				cps_eth2: eth2 {
-					interrupts = <ICU_GRP_NSR 41 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 45 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 49 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 53 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 57 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 127 IRQ_TYPE_LEVEL_HIGH>;
-					interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
-							  "tx-cpu3", "rx-shared", "link";
-					port-id = <2>;
-					gop-port-id = <3>;
-					status = "disabled";
-				};
-			};
-
-			cps_comphy: phy at 120000 {
-				compatible = "marvell,comphy-cp110";
-				reg = <0x120000 0x6000>;
-				marvell,system-controller = <&cps_syscon0>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				cps_comphy0: phy at 0 {
-					reg = <0>;
-					#phy-cells = <1>;
-				};
-
-				cps_comphy1: phy at 1 {
-					reg = <1>;
-					#phy-cells = <1>;
-				};
-
-				cps_comphy2: phy at 2 {
-					reg = <2>;
-					#phy-cells = <1>;
-				};
-
-				cps_comphy3: phy at 3 {
-					reg = <3>;
-					#phy-cells = <1>;
-				};
-
-				cps_comphy4: phy at 4 {
-					reg = <4>;
-					#phy-cells = <1>;
-				};
-
-				cps_comphy5: phy at 5 {
-					reg = <5>;
-					#phy-cells = <1>;
-				};
-			};
-
-			cps_mdio: mdio at 12a200 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "marvell,orion-mdio";
-				reg = <0x12a200 0x10>;
-				clocks = <&cps_clk 1 9>, <&cps_clk 1 5>;
-				status = "disabled";
-			};
-
-			cps_xmdio: mdio at 12a600 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "marvell,xmdio";
-				reg = <0x12a600 0x10>;
-				status = "disabled";
-			};
-
-			cps_icu: interrupt-controller at 1e0000 {
-				compatible = "marvell,cp110-icu";
-				reg = <0x1e0000 0x10>;
-				#interrupt-cells = <3>;
-				interrupt-controller;
-				msi-parent = <&gicp>;
-			};
-
-			cps_rtc: rtc at 284000 {
-				compatible = "marvell,armada-8k-rtc";
-				reg = <0x284000 0x20>, <0x284080 0x24>;
-				reg-names = "rtc", "rtc-soc";
-				interrupts = <ICU_GRP_NSR 77 IRQ_TYPE_LEVEL_HIGH>;
-			};
-
-			cps_thermal: thermal at 400078 {
-				compatible = "marvell,armada-cp110-thermal";
-				reg = <0x400078 0x4>,
-				      <0x400070 0x8>;
-			};
-
-			cps_syscon0: system-controller at 440000 {
-				compatible = "syscon", "simple-mfd";
-				reg = <0x440000 0x2000>;
-
-				cps_clk: clock {
-					compatible = "marvell,cp110-clock";
-					#clock-cells = <2>;
-				};
-
-				cps_gpio1: gpio at 100 {
-					compatible = "marvell,armada-8k-gpio";
-					offset = <0x100>;
-					ngpios = <32>;
-					gpio-controller;
-					#gpio-cells = <2>;
-					gpio-ranges = <&cps_pinctrl 0 0 32>;
-					interrupt-controller;
-					interrupts = <ICU_GRP_NSR 86 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 85 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 84 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 83 IRQ_TYPE_LEVEL_HIGH>;
-					status = "disabled";
-				};
-
-				cps_gpio2: gpio at 140 {
-					compatible = "marvell,armada-8k-gpio";
-					offset = <0x140>;
-					ngpios = <31>;
-					gpio-controller;
-					#gpio-cells = <2>;
-					gpio-ranges = <&cps_pinctrl 0 32 31>;
-					interrupt-controller;
-					interrupts = <ICU_GRP_NSR 82 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 81 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 80 IRQ_TYPE_LEVEL_HIGH>,
-						     <ICU_GRP_NSR 79 IRQ_TYPE_LEVEL_HIGH>;
-					status = "disabled";
-				};
-
-			};
-
-			cps_usb3_0: usb3 at 500000 {
-				compatible = "marvell,armada-8k-xhci",
-					     "generic-xhci";
-				reg = <0x500000 0x4000>;
-				dma-coherent;
-				interrupts = <ICU_GRP_NSR 106 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cps_clk 1 22>;
-				status = "disabled";
-			};
-
-			cps_usb3_1: usb3 at 510000 {
-				compatible = "marvell,armada-8k-xhci",
-					     "generic-xhci";
-				reg = <0x510000 0x4000>;
-				dma-coherent;
-				interrupts = <ICU_GRP_NSR 105 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cps_clk 1 23>;
-				status = "disabled";
-			};
-
-			cps_sata0: sata at 540000 {
-				compatible = "marvell,armada-8k-ahci",
-					     "generic-ahci";
-				reg = <0x540000 0x30000>;
-				interrupts = <ICU_GRP_NSR 107 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cps_clk 1 15>;
-				status = "disabled";
-			};
-
-			cps_xor0: xor at 6a0000 {
-				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
-				reg = <0x6a0000 0x1000>,
-				      <0x6b0000 0x1000>;
-				dma-coherent;
-				msi-parent = <&gic_v2m0>;
-				clocks = <&cps_clk 1 8>;
-			};
-
-			cps_xor1: xor at 6c0000 {
-				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
-				reg = <0x6c0000 0x1000>,
-				      <0x6d0000 0x1000>;
-				dma-coherent;
-				msi-parent = <&gic_v2m0>;
-				clocks = <&cps_clk 1 7>;
-			};
-
-			cps_spi0: spi at 700600 {
-				compatible = "marvell,armada-380-spi";
-				reg = <0x700600 0x50>;
-				#address-cells = <0x1>;
-				#size-cells = <0x0>;
-				clocks = <&cps_clk 1 21>;
-				status = "disabled";
-			};
-
-			cps_spi1: spi at 700680 {
-				compatible = "marvell,armada-380-spi";
-				reg = <0x700680 0x50>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				clocks = <&cps_clk 1 21>;
-				status = "disabled";
-			};
-
-			cps_i2c0: i2c at 701000 {
-				compatible = "marvell,mv78230-i2c";
-				reg = <0x701000 0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <ICU_GRP_NSR 120 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cps_clk 1 21>;
-				status = "disabled";
-			};
-
-			cps_i2c1: i2c at 701100 {
-				compatible = "marvell,mv78230-i2c";
-				reg = <0x701100 0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <ICU_GRP_NSR 121 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cps_clk 1 21>;
-				status = "disabled";
-			};
-
-			cps_nand: nand at 720000 {
-				/*
-				 * Due to the limitation of the pins available
-				 * this controller is only usable on the CPM
-				 * for A7K and on the CPS for A8K.
-				 */
-				compatible = "marvell,armada-8k-nand",
-					     "marvell,armada370-nand";
-				reg = <0x720000 0x54>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				interrupts = <ICU_GRP_NSR 115 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cps_clk 1 2>;
-				marvell,system-controller = <&cpm_syscon0>;
-				status = "disabled";
-			};
-
-			cps_trng: trng at 760000 {
-				compatible = "marvell,armada-8k-rng", "inside-secure,safexcel-eip76";
-				reg = <0x760000 0x7d>;
-				interrupts = <ICU_GRP_NSR 95 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cps_clk 1 25>;
-				status = "okay";
-			};
-
-			cps_crypto: crypto at 800000 {
-				compatible = "inside-secure,safexcel-eip197";
-				reg = <0x800000 0x200000>;
-				interrupts = <ICU_GRP_NSR 87 IRQ_TYPE_LEVEL_HIGH>,
-					     <ICU_GRP_NSR 88 IRQ_TYPE_LEVEL_HIGH>,
-					     <ICU_GRP_NSR 89 IRQ_TYPE_LEVEL_HIGH>,
-					     <ICU_GRP_NSR 90 IRQ_TYPE_LEVEL_HIGH>,
-					     <ICU_GRP_NSR 91 IRQ_TYPE_LEVEL_HIGH>,
-					     <ICU_GRP_NSR 92 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "mem", "ring0", "ring1",
-						  "ring2", "ring3", "eip";
-				clocks = <&cps_clk 1 26>;
-				dma-coherent;
-				/*
-				 * The cryptographic engine found on the cp110
-				 * master is enabled by default at the SoC
-				 * level. Because it is not possible as of now
-				 * to enable two cryptographic engines in
-				 * parallel, disable this one by default.
-				 */
-				status = "disabled";
-			};
-		};
-
-		cps_pcie0: pcie at f4600000 {
-			compatible = "marvell,armada8k-pcie", "snps,dw-pcie";
-			reg = <0 0xf4600000 0 0x10000>,
-			      <0 0xfaf00000 0 0x80000>;
-			reg-names = "ctrl", "config";
-			#address-cells = <3>;
-			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			device_type = "pci";
-			dma-coherent;
-			msi-parent = <&gic_v2m0>;
-
-			bus-range = <0 0xff>;
-			ranges =
-				/* downstream I/O */
-				<0x81000000 0 0xfd000000 0  0xfd000000 0 0x10000
-				/* non-prefetchable memory */
-				0x82000000 0 0xfa000000 0  0xfa000000 0 0xf00000>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &cps_icu ICU_GRP_NSR 22 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts = <ICU_GRP_NSR 22 IRQ_TYPE_LEVEL_HIGH>;
-			num-lanes = <1>;
-			clocks = <&cps_clk 1 13>;
-			status = "disabled";
-		};
-
-		cps_pcie1: pcie at f4620000 {
-			compatible = "marvell,armada8k-pcie", "snps,dw-pcie";
-			reg = <0 0xf4620000 0 0x10000>,
-			      <0 0xfbf00000 0 0x80000>;
-			reg-names = "ctrl", "config";
-			#address-cells = <3>;
-			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			device_type = "pci";
-			dma-coherent;
-			msi-parent = <&gic_v2m0>;
-
-			bus-range = <0 0xff>;
-			ranges =
-				/* downstream I/O */
-				<0x81000000 0 0xfd010000 0  0xfd010000 0 0x10000
-				/* non-prefetchable memory */
-				0x82000000 0 0xfb000000 0  0xfb000000 0 0xf00000>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &cps_icu ICU_GRP_NSR 24 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts = <ICU_GRP_NSR 24 IRQ_TYPE_LEVEL_HIGH>;
-
-			num-lanes = <1>;
-			clocks = <&cps_clk 1 11>;
-			status = "disabled";
-		};
-
-		cps_pcie2: pcie at f4640000 {
-			compatible = "marvell,armada8k-pcie", "snps,dw-pcie";
-			reg = <0 0xf4640000 0 0x10000>,
-			      <0 0xfcf00000 0 0x80000>;
-			reg-names = "ctrl", "config";
-			#address-cells = <3>;
-			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			device_type = "pci";
-			dma-coherent;
-			msi-parent = <&gic_v2m0>;
-
-			bus-range = <0 0xff>;
-			ranges =
-				/* downstream I/O */
-				<0x81000000 0 0xfd020000 0  0xfd020000 0 0x10000
-				/* non-prefetchable memory */
-				0x82000000 0 0xfc000000 0  0xfc000000 0 0xf00000>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &cps_icu ICU_GRP_NSR 23 IRQ_TYPE_LEVEL_HIGH>;
-			interrupts = <ICU_GRP_NSR 23 IRQ_TYPE_LEVEL_HIGH>;
-
-			num-lanes = <1>;
-			clocks = <&cps_clk 1 12>;
-			status = "disabled";
-		};
-	};
-};
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
new file mode 100644
index 000000000000..08989a158578
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -0,0 +1,422 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR X11)
+/*
+ * Copyright (C) 2016 Marvell Technology Group Ltd.
+ */
+
+/*
+ * Device Tree file for Marvell Armada CP110.
+ */
+
+#include <dt-bindings/interrupt-controller/mvebu-icu.h>
+
+#include "armada-common.dtsi"
+
+#define CP110_PCIEx_IO_BASE(iface)	(CP110_PCIE_IO_BASE + (iface *  0x10000))
+#define CP110_PCIEx_MEM_BASE(iface)	(CP110_PCIE_MEM_BASE + (iface *  0x1000000))
+#define CP110_PCIEx_CONF_BASE(iface)	(CP110_PCIEx_MEM_BASE(iface) + 0xf00000)
+
+/ {
+	/*
+	 * The contents of the node are defined below, in order to
+	 * save one indentation level
+	 */
+	CP110_NAME: CP110_NAME { };
+};
+
+&CP110_NAME {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	compatible = "simple-bus";
+	interrupt-parent = <&CP110_LABEL(icu)>;
+	ranges;
+
+	config-space at CP110_BASE {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges = <0x0 0x0 ADDRESSIFY(CP110_BASE) 0x2000000>;
+
+		CP110_LABEL(ethernet): ethernet at 0 {
+			compatible = "marvell,armada-7k-pp22";
+			reg = <0x0 0x100000>, <0x129000 0xb000>;
+			clocks = <&CP110_LABEL(clk) 1 3>, <&CP110_LABEL(clk) 1 9>,
+				 <&CP110_LABEL(clk) 1 5>;
+			clock-names = "pp_clk", "gop_clk", "mg_clk";
+			marvell,system-controller = <&CP110_LABEL(syscon0)>;
+			status = "disabled";
+			dma-coherent;
+
+			CP110_LABEL(eth0): eth0 {
+				interrupts = <ICU_GRP_NSR 39 IRQ_TYPE_LEVEL_HIGH>,
+					<ICU_GRP_NSR 43 IRQ_TYPE_LEVEL_HIGH>,
+					<ICU_GRP_NSR 47 IRQ_TYPE_LEVEL_HIGH>,
+					<ICU_GRP_NSR 51 IRQ_TYPE_LEVEL_HIGH>,
+					<ICU_GRP_NSR 55 IRQ_TYPE_LEVEL_HIGH>,
+					<ICU_GRP_NSR 129 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
+					"tx-cpu3", "rx-shared", "link";
+				port-id = <0>;
+				gop-port-id = <0>;
+				status = "disabled";
+			};
+
+			CP110_LABEL(eth1): eth1 {
+				interrupts = <ICU_GRP_NSR 40 IRQ_TYPE_LEVEL_HIGH>,
+					<ICU_GRP_NSR 44 IRQ_TYPE_LEVEL_HIGH>,
+					<ICU_GRP_NSR 48 IRQ_TYPE_LEVEL_HIGH>,
+					<ICU_GRP_NSR 52 IRQ_TYPE_LEVEL_HIGH>,
+					<ICU_GRP_NSR 56 IRQ_TYPE_LEVEL_HIGH>,
+					<ICU_GRP_NSR 128 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
+					"tx-cpu3", "rx-shared", "link";
+				port-id = <1>;
+				gop-port-id = <2>;
+				status = "disabled";
+			};
+
+			CP110_LABEL(eth2): eth2 {
+				interrupts = <ICU_GRP_NSR 41 IRQ_TYPE_LEVEL_HIGH>,
+					<ICU_GRP_NSR 45 IRQ_TYPE_LEVEL_HIGH>,
+					<ICU_GRP_NSR 49 IRQ_TYPE_LEVEL_HIGH>,
+					<ICU_GRP_NSR 53 IRQ_TYPE_LEVEL_HIGH>,
+					<ICU_GRP_NSR 57 IRQ_TYPE_LEVEL_HIGH>,
+					<ICU_GRP_NSR 127 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "tx-cpu0", "tx-cpu1", "tx-cpu2",
+					"tx-cpu3", "rx-shared", "link";
+				port-id = <2>;
+				gop-port-id = <3>;
+				status = "disabled";
+			};
+		};
+
+		CP110_LABEL(comphy): phy at 120000 {
+			compatible = "marvell,comphy-cp110";
+			reg = <0x120000 0x6000>;
+			marvell,system-controller = <&CP110_LABEL(syscon0)>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			CP110_LABEL(comphy0): phy at 0 {
+				reg = <0>;
+				#phy-cells = <1>;
+			};
+
+			CP110_LABEL(comphy1): phy at 1 {
+				reg = <1>;
+				#phy-cells = <1>;
+			};
+
+			CP110_LABEL(comphy2): phy at 2 {
+				reg = <2>;
+				#phy-cells = <1>;
+			};
+
+			CP110_LABEL(comphy3): phy at 3 {
+				reg = <3>;
+				#phy-cells = <1>;
+			};
+
+			CP110_LABEL(comphy4): phy at 4 {
+				reg = <4>;
+				#phy-cells = <1>;
+			};
+
+			CP110_LABEL(comphy5): phy at 5 {
+				reg = <5>;
+				#phy-cells = <1>;
+			};
+		};
+
+		CP110_LABEL(mdio): mdio at 12a200 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "marvell,orion-mdio";
+			reg = <0x12a200 0x10>;
+			clocks = <&CP110_LABEL(clk) 1 9>, <&CP110_LABEL(clk) 1 5>;
+			status = "disabled";
+		};
+
+		CP110_LABEL(xmdio): mdio at 12a600 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "marvell,xmdio";
+			reg = <0x12a600 0x10>;
+			status = "disabled";
+		};
+
+		CP110_LABEL(icu): interrupt-controller at 1e0000 {
+			compatible = "marvell,cp110-icu";
+			reg = <0x1e0000 0x10>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			msi-parent = <&gicp>;
+		};
+
+		CP110_LABEL(rtc): rtc at 284000 {
+			compatible = "marvell,armada-8k-rtc";
+			reg = <0x284000 0x20>, <0x284080 0x24>;
+			reg-names = "rtc", "rtc-soc";
+			interrupts = <ICU_GRP_NSR 77 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		CP110_LABEL(thermal): thermal at 400078 {
+			compatible = "marvell,armada-cp110-thermal";
+			reg = <0x400078 0x4>,
+			<0x400070 0x8>;
+		};
+
+		CP110_LABEL(syscon0): system-controller at 440000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x440000 0x2000>;
+
+			CP110_LABEL(clk): clock {
+				compatible = "marvell,cp110-clock";
+				#clock-cells = <2>;
+			};
+
+			CP110_LABEL(gpio1): gpio at 100 {
+				compatible = "marvell,armada-8k-gpio";
+				offset = <0x100>;
+				ngpios = <32>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&CP110_LABEL(pinctrl) 0 0 32>;
+				interrupt-controller;
+				interrupts = <ICU_GRP_NSR 86 IRQ_TYPE_LEVEL_HIGH>,
+					<ICU_GRP_NSR 85 IRQ_TYPE_LEVEL_HIGH>,
+					<ICU_GRP_NSR 84 IRQ_TYPE_LEVEL_HIGH>,
+					<ICU_GRP_NSR 83 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			CP110_LABEL(gpio2): gpio at 140 {
+				compatible = "marvell,armada-8k-gpio";
+				offset = <0x140>;
+				ngpios = <31>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&CP110_LABEL(pinctrl) 0 32 31>;
+				interrupt-controller;
+				interrupts = <ICU_GRP_NSR 82 IRQ_TYPE_LEVEL_HIGH>,
+					<ICU_GRP_NSR 81 IRQ_TYPE_LEVEL_HIGH>,
+					<ICU_GRP_NSR 80 IRQ_TYPE_LEVEL_HIGH>,
+					<ICU_GRP_NSR 79 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+		};
+
+		CP110_LABEL(usb3_0): usb3 at 500000 {
+			compatible = "marvell,armada-8k-xhci",
+			"generic-xhci";
+			reg = <0x500000 0x4000>;
+			dma-coherent;
+			interrupts = <ICU_GRP_NSR 106 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&CP110_LABEL(clk) 1 22>;
+			status = "disabled";
+		};
+
+		CP110_LABEL(usb3_1): usb3 at 510000 {
+			compatible = "marvell,armada-8k-xhci",
+			"generic-xhci";
+			reg = <0x510000 0x4000>;
+			dma-coherent;
+			interrupts = <ICU_GRP_NSR 105 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&CP110_LABEL(clk) 1 23>;
+			status = "disabled";
+		};
+
+		CP110_LABEL(sata0): sata at 540000 {
+			compatible = "marvell,armada-8k-ahci",
+			"generic-ahci";
+			reg = <0x540000 0x30000>;
+			interrupts = <ICU_GRP_NSR 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&CP110_LABEL(clk) 1 15>;
+			status = "disabled";
+		};
+
+		CP110_LABEL(xor0): xor at 6a0000 {
+			compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
+			reg = <0x6a0000 0x1000>, <0x6b0000 0x1000>;
+			dma-coherent;
+			msi-parent = <&gic_v2m0>;
+			clocks = <&CP110_LABEL(clk) 1 8>;
+		};
+
+		CP110_LABEL(xor1): xor at 6c0000 {
+			compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
+			reg = <0x6c0000 0x1000>, <0x6d0000 0x1000>;
+			dma-coherent;
+			msi-parent = <&gic_v2m0>;
+			clocks = <&CP110_LABEL(clk) 1 7>;
+		};
+
+		CP110_LABEL(spi0): spi at 700600 {
+			compatible = "marvell,armada-380-spi";
+			reg = <0x700600 0x50>;
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			clocks = <&CP110_LABEL(clk) 1 21>;
+			status = "disabled";
+		};
+
+		CP110_LABEL(spi1): spi at 700680 {
+			compatible = "marvell,armada-380-spi";
+			reg = <0x700680 0x50>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&CP110_LABEL(clk) 1 21>;
+			status = "disabled";
+		};
+
+		CP110_LABEL(i2c0): i2c at 701000 {
+			compatible = "marvell,mv78230-i2c";
+			reg = <0x701000 0x20>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <ICU_GRP_NSR 120 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&CP110_LABEL(clk) 1 21>;
+			status = "disabled";
+		};
+
+		CP110_LABEL(i2c1): i2c at 701100 {
+			compatible = "marvell,mv78230-i2c";
+			reg = <0x701100 0x20>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <ICU_GRP_NSR 121 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&CP110_LABEL(clk) 1 21>;
+			status = "disabled";
+		};
+
+		CP110_LABEL(nand): nand at 720000 {
+			/*
+			* Due to the limitation of the pins available
+			* this controller is only usable on the CPM
+			* for A7K and on the CPS for A8K.
+			*/
+			compatible = "marvell,armada-8k-nand",
+			"marvell,armada370-nand";
+			reg = <0x720000 0x54>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			interrupts = <ICU_GRP_NSR 115 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&CP110_LABEL(clk) 1 2>;
+			marvell,system-controller = <&CP110_LABEL(syscon0)>;
+			status = "disabled";
+		};
+
+		CP110_LABEL(trng): trng at 760000 {
+			compatible = "marvell,armada-8k-rng",
+			"inside-secure,safexcel-eip76";
+			reg = <0x760000 0x7d>;
+			interrupts = <ICU_GRP_NSR 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&CP110_LABEL(clk) 1 25>;
+			status = "okay";
+		};
+
+		CP110_LABEL(sdhci0): sdhci at 780000 {
+			compatible = "marvell,armada-cp110-sdhci";
+			reg = <0x780000 0x300>;
+			interrupts = <ICU_GRP_NSR 27 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "core";
+			clocks = <&CP110_LABEL(clk) 1 4>;
+			dma-coherent;
+			status = "disabled";
+		};
+
+		CP110_LABEL(crypto): crypto at 800000 {
+			compatible = "inside-secure,safexcel-eip197";
+			reg = <0x800000 0x200000>;
+			interrupts = <ICU_GRP_NSR 87 IRQ_TYPE_LEVEL_HIGH>,
+				<ICU_GRP_NSR 88 IRQ_TYPE_LEVEL_HIGH>,
+				<ICU_GRP_NSR 89 IRQ_TYPE_LEVEL_HIGH>,
+				<ICU_GRP_NSR 90 IRQ_TYPE_LEVEL_HIGH>,
+				<ICU_GRP_NSR 91 IRQ_TYPE_LEVEL_HIGH>,
+				<ICU_GRP_NSR 92 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mem", "ring0", "ring1",
+				"ring2", "ring3", "eip";
+			clocks = <&CP110_LABEL(clk) 1 26>;
+			dma-coherent;
+		};
+	};
+
+	CP110_LABEL(pcie0): pcie at CP110_PCIE0_BASE {
+		compatible = "marvell,armada8k-pcie", "snps,dw-pcie";
+		reg = <0 ADDRESSIFY(CP110_PCIE0_BASE) 0 0x10000>,
+		      <0 CP110_PCIEx_CONF_BASE(0) 0 0x80000>;
+		reg-names = "ctrl", "config";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		dma-coherent;
+		msi-parent = <&gic_v2m0>;
+
+		bus-range = <0 0xff>;
+		ranges =
+		/* downstream I/O */
+		<0x81000000 0 CP110_PCIEx_IO_BASE(0) 0  CP110_PCIEx_IO_BASE(0) 0 0x10000
+		/* non-prefetchable memory */
+		0x82000000 0 CP110_PCIEx_MEM_BASE(0) 0  CP110_PCIEx_MEM_BASE(0) 0 0xf00000>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &CP110_LABEL(icu) ICU_GRP_NSR 22 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <ICU_GRP_NSR 22 IRQ_TYPE_LEVEL_HIGH>;
+		num-lanes = <1>;
+		clocks = <&CP110_LABEL(clk) 1 13>;
+		status = "disabled";
+	};
+
+	CP110_LABEL(pcie1): pcie at CP110_PCIE1_BASE {
+		compatible = "marvell,armada8k-pcie", "snps,dw-pcie";
+		reg = <0 ADDRESSIFY(CP110_PCIE1_BASE) 0 0x10000>,
+		      <0 CP110_PCIEx_CONF_BASE(1) 0 0x80000>;
+		reg-names = "ctrl", "config";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		dma-coherent;
+		msi-parent = <&gic_v2m0>;
+
+		bus-range = <0 0xff>;
+		ranges =
+		/* downstream I/O */
+		<0x81000000 0 CP110_PCIEx_IO_BASE(1) 0  CP110_PCIEx_IO_BASE(1) 0 0x10000
+		/* non-prefetchable memory */
+		0x82000000 0 CP110_PCIEx_MEM_BASE(1) 0  CP110_PCIEx_MEM_BASE(1) 0 0xf00000>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &CP110_LABEL(icu) ICU_GRP_NSR 24 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <ICU_GRP_NSR 24 IRQ_TYPE_LEVEL_HIGH>;
+
+		num-lanes = <1>;
+		clocks = <&CP110_LABEL(clk) 1 11>;
+		status = "disabled";
+	};
+
+	CP110_LABEL(pcie2): pcie at CP110_PCIE2_BASE {
+		compatible = "marvell,armada8k-pcie", "snps,dw-pcie";
+		reg = <0 ADDRESSIFY(CP110_PCIE2_BASE) 0 0x10000>,
+		      <0 CP110_PCIEx_CONF_BASE(2) 0 0x80000>;
+		reg-names = "ctrl", "config";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		dma-coherent;
+		msi-parent = <&gic_v2m0>;
+
+		bus-range = <0 0xff>;
+		ranges =
+		/* downstream I/O */
+		<0x81000000 0 CP110_PCIEx_IO_BASE(2) 0  CP110_PCIEx_IO_BASE(2) 0 0x10000
+		/* non-prefetchable memory */
+		0x82000000 0 CP110_PCIEx_MEM_BASE(2) 0  CP110_PCIEx_MEM_BASE(2) 0 0xf00000>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &CP110_LABEL(icu) ICU_GRP_NSR 23 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <ICU_GRP_NSR 23 IRQ_TYPE_LEVEL_HIGH>;
+
+		num-lanes = <1>;
+		clocks = <&CP110_LABEL(clk) 1 12>;
+		status = "disabled";
+	};
+};
-- 
2.14.3
