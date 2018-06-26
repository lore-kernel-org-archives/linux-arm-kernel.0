From: nm@ti.com (Nishanth Menon)
Date: Tue, 26 Jun 2018 11:26:13 -0500
Subject: [PATCH V2 3/5] arm64: dts: ti: Add Support for AM654 SoC
In-Reply-To: <20180626162615.19194-1-nm@ti.com>
References: <20180626162615.19194-1-nm@ti.com>
Message-ID: <20180626162615.19194-4-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AM654 SoC is a lead device of the K3 Multicore SoC architecture
platform, targeted for broad market and industrial control with aim to
meet the complex processing needs of modern embedded products.

Some highlights of this SoC are:
* Quad ARMv8 A53 cores split over two clusters
* GICv3 compliant GIC500
* Configurable L3 Cache and IO-coherent architecture
* Dual lock-step capable R5F uC for safety-critical applications
* High data throughput capable distributed DMA architecture under NAVSS
* Three Gigabit Industrial Communication Subsystems (ICSSG), each with dual
  PRUs and dual RTUs
* Hardware accelerator block containing AES/DES/SHA/MD5 called SA2UL
* Centralized System Controller for Security, Power, and Resource
  management.
* Dual ADCSS, eQEP/eCAP, eHRPWM, dual CAN-FD
* Flash subsystem with OSPI and Hyperbus interfaces
* Multimedia capability with CAL, DSS7-UL, SGX544, McASP
* Peripheral connectivity including USB3, PCIE, MMC/SD, GPMC, I2C, SPI,
  GPIO

See AM65x Technical Reference Manual (SPRUID7, April 2018)
for further details: http://www.ti.com/lit/pdf/spruid7

NOTE:
1. AM654 is the first of the device variants, hence we introduce a
   generic am65.dtsi.
2. We indicate the proper bus topology, the ranges are elaborated in
   each bus segment instead of using the top level ranges to make sure
   that peripherals in each segment use the address space accurately.
3. Peripherals in each bus segment is maintained in a separate dtsi
   allowing for reuse in different bus segment representation from a
   different core such as R5. This is also the reason for maintaining a
   1-1 address map in the ranges.
4. Cache descriptions follow the ARM64 standard description.

Further tweaks may be necessary as we introduce more complex devices,
but can be introduced in context of the device introduction.

Reviewed-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Benjamin Fair <b-fair@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1:
 * Picked up Tony's reviewed-by
 * s/cbass@/interconnect@/
 
V1: https://patchwork.kernel.org/patch/10475307/
RFC: https://patchwork.kernel.org/patch/10447719/ , https://patchwork.kernel.org/patch/10453659/

 MAINTAINERS                              |   1 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi |  31 +++++++++
 arch/arm64/boot/dts/ti/k3-am65.dtsi      |  87 +++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am654.dtsi     | 115 +++++++++++++++++++++++++++++++
 4 files changed, 234 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index fbd93eee41ae..6785ceaf5b0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2093,6 +2093,7 @@ M:	Nishanth Menon <nm@ti.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/arm/ti/k3.txt
+F:	arch/arm64/boot/dts/ti/k3-*
 
 ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
 M:	Santosh Shilimkar <ssantosh@kernel.org>
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
new file mode 100644
index 000000000000..2409344df4fa
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM6 SoC Family Main Domain peripherals
+ *
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+&cbass_main {
+	gic500: interrupt-controller at 1800000 {
+		compatible = "arm,gic-v3";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x01800000 0x10000>,	/* GICD */
+		      <0x01880000 0x90000>;	/* GICR */
+		/*
+		 * vcpumntirq:
+		 * virtual CPU interface maintenance interrupt
+		 */
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+		gic_its: gic-its at 18200000 {
+			compatible = "arm,gic-v3-its";
+			reg = <0x01820000 0x10000>;
+			msi-controller;
+			#msi-cells = <1>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
new file mode 100644
index 000000000000..cede1fa0983c
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM6 SoC Family
+ *
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	model = "Texas Instruments K3 AM654 SoC";
+	compatible = "ti,am654";
+	interrupt-parent = <&gic500>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen { };
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+
+		psci: psci {
+			compatible = "arm,psci-1.0";
+			method = "smc";
+		};
+	};
+
+	a53_timer0: timer-cl0-cpu0 {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* cntpsirq */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* cntpnsirq */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* cntvirq */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* cnthpirq */
+	};
+
+	pmu: pmu {
+		compatible = "arm,armv8-pmuv3";
+		/* Recommendation from GIC500 TRM Table A.3 */
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	cbass_main: interconnect at 100000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00100000 0x00 0x00100000 0x00020000>, /* ctrl mmr */
+			 <0x00600000 0x00 0x00600000 0x00001100>, /* GPIO */
+			 <0x00900000 0x00 0x00900000 0x00012000>, /* serdes */
+			 <0x01000000 0x00 0x01000000 0x0af02400>, /* Most peripherals */
+			 <0x30800000 0x00 0x30800000 0x0bc00000>, /* MAIN NAVSS */
+			 /* MCUSS Range */
+			 <0x28380000 0x00 0x28380000 0x03880000>,
+			 <0x40200000 0x00 0x40200000 0x00900100>,
+			 <0x42040000 0x00 0x42040000 0x03ac2400>,
+			 <0x45100000 0x00 0x45100000 0x00c24000>,
+			 <0x46000000 0x00 0x46000000 0x00200000>,
+			 <0x47000000 0x00 0x47000000 0x00068400>;
+
+		cbass_mcu: interconnect at 28380000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x28380000 0x28380000 0x03880000>, /* MCU NAVSS*/
+				 <0x40200000 0x40200000 0x00900100>, /* First peripheral window */
+				 <0x42040000 0x42040000 0x03ac2400>, /* WKUP */
+				 <0x45100000 0x45100000 0x00c24000>, /* MMRs, remaining NAVSS */
+				 <0x46000000 0x46000000 0x00200000>, /* CPSW */
+				 <0x47000000 0x47000000 0x00068400>; /* OSPI space 1 */
+
+			cbass_wakeup: interconnect at 42040000 {
+				compatible = "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				/* WKUP  Basic peripherals */
+				ranges = <0x42040000 0x42040000 0x03ac2400>;
+			};
+		};
+	};
+};
+
+/* Now include the peripherals for each bus segments */
+#include "k3-am65-main.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-am654.dtsi b/arch/arm64/boot/dts/ti/k3-am654.dtsi
new file mode 100644
index 000000000000..2affa6f6617e
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am654.dtsi
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM6 SoC family in Quad core configuration
+ *
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include "k3-am65.dtsi"
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu-map {
+			cluster0: cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+			};
+
+			cluster1: cluster1 {
+				core0 {
+					cpu = <&cpu2>;
+				};
+
+				core1 {
+					cpu = <&cpu3>;
+				};
+			};
+		};
+
+		cpu0: cpu at 0 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x000>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu1: cpu at 1 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x001>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu2: cpu at 100 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x100>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&L2_1>;
+		};
+
+		cpu3: cpu at 101 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x101>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&L2_1>;
+		};
+	};
+
+	L2_0: l2-cache0 {
+		compatible = "cache";
+		cache-level = <2>;
+		cache-size = <0x80000>;
+		cache-line-size = <64>;
+		cache-sets = <512>;
+		next-level-cache = <&msmc_l3>;
+	};
+
+	L2_1: l2-cache1 {
+		compatible = "cache";
+		cache-level = <2>;
+		cache-size = <0x80000>;
+		cache-line-size = <64>;
+		cache-sets = <512>;
+		next-level-cache = <&msmc_l3>;
+	};
+
+	msmc_l3: l3-cache0 {
+		compatible = "cache";
+		cache-level = <3>;
+	};
+};
-- 
2.15.1
