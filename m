From: vincent.yang.fujitsu@gmail.com (Vincent Yang)
Date: Thu, 20 Nov 2014 20:38:46 +0800
Subject: [PATCH 7/9] dt: mb86s7x: add dt files for MB86S7x evbs
In-Reply-To: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <1416487126-25509-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dt files for MB86S7x evb.

Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@jp.fujitsu.com>
---
 arch/arm/boot/dts/Makefile      |   1 +
 arch/arm/boot/dts/mb86s70.dtsi  |  91 ++++++
 arch/arm/boot/dts/mb86s70eb.dts |  52 ++++
 arch/arm/boot/dts/mb86s73.dtsi  |  49 ++++
 arch/arm/boot/dts/mb86s73eb.dts |  39 +++
 arch/arm/boot/dts/mb86s7x.dtsi  | 595 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 827 insertions(+)
 create mode 100644 arch/arm/boot/dts/mb86s70.dtsi
 create mode 100644 arch/arm/boot/dts/mb86s70eb.dts
 create mode 100644 arch/arm/boot/dts/mb86s73.dtsi
 create mode 100644 arch/arm/boot/dts/mb86s73eb.dts
 create mode 100644 arch/arm/boot/dts/mb86s7x.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 38c89ca..3a6051b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -163,6 +163,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += kirkwood-b3.dtb \
 	kirkwood-ts419-6282.dtb
 dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
 dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
+dtb-$(CONFIG_ARCH_MB86S7X) += mb86s70eb.dtb mb86s73eb.dtb
 dtb-$(CONFIG_MACH_MESON6) += meson6-atv1200.dtb
 dtb-$(CONFIG_ARCH_MOXART) += moxart-uc7112lx.dtb
 dtb-$(CONFIG_ARCH_MXC) += \
diff --git a/arch/arm/boot/dts/mb86s70.dtsi b/arch/arm/boot/dts/mb86s70.dtsi
new file mode 100644
index 0000000..3d5d6bf
--- /dev/null
+++ b/arch/arm/boot/dts/mb86s70.dtsi
@@ -0,0 +1,91 @@
+/*
+ * Copyright (C) 2013-2014 FUJITSU SEMICONDUCTOR LIMITED
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ */
+
+#include "mb86s7x.dtsi"
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x0>;
+			cci-control-port = <&cci_control4>;
+			clock-frequency = <1200000000>;
+			clock-latency = <100000>;
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x1>;
+			cci-control-port = <&cci_control4>;
+			clock-frequency = <1200000000>;
+			clock-latency = <100000>;
+		};
+
+		cpu2: cpu at 100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x100>;
+			cci-control-port = <&cci_control3>;
+			clock-frequency = <800000000>;
+			clock-latency = <100000>;
+		};
+
+		cpu3: cpu at 101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x101>;
+			cci-control-port = <&cci_control3>;
+			clock-frequency = <800000000>;
+			clock-latency = <100000>;
+		};
+	};
+
+	cci at 2c090000 {
+		compatible = "arm,cci-400";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0 0x2c090000 0x1000>;
+		ranges = <0x0 0x0 0x2c090000 0x10000>;
+
+		cci_control3: slave-if at 4000 {
+			compatible = "arm,cci-400-ctrl-if";
+			interface-type = "ace";
+			reg = <0x4000 0x1000>;
+		};
+
+		cci_control4: slave-if at 5000 {
+			compatible = "arm,cci-400-ctrl-if";
+			interface-type = "ace";
+			reg = <0x5000 0x1000>;
+		};
+
+		pmu at 9000 {
+			compatible = "arm,cci-400-pmu";
+			reg = <0x9000 0x5000>;
+			interrupts = <0 77 4>,
+					<0 77 4>,
+					<0 77 4>,
+					<0 77 4>,
+					<0 77 4>;
+		};
+	};
+};
+
+&timer1 {
+	status = "disabled";
+};
+
+&pmua7 {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/mb86s70eb.dts b/arch/arm/boot/dts/mb86s70eb.dts
new file mode 100644
index 0000000..a19c72f
--- /dev/null
+++ b/arch/arm/boot/dts/mb86s70eb.dts
@@ -0,0 +1,52 @@
+/*
+ * Copyright (C) 2013-2014 FUJITSU SEMICONDUCTOR LIMITED
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ */
+
+/dts-v1/;
+
+#include "mb86s70.dtsi"
+
+/ {
+	model = "Fujitsu MB86S70 EVB";
+	compatible = "fujitsu,mb86s70-evb";
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x80000000 0x80000000>, <0x08 0x80000000 0x80000000>;
+
+	};
+
+	chosen {
+		bootargs = "loglevel=8 console=ttyS0,115200 root=/dev/mmcblk1p1 rootfstype=ext4 rootwait rw";
+		linux,initrd-start = <0xc0000000>;
+		linux,initrd-end =   <0xc0800000>;
+	};
+
+        vccq_sdhci1: regulator at 0 {
+                compatible = "regulator-gpio";
+                regulator-name = "SDHCI1 VccQ";
+                regulator-min-microvolt = <1800000>;
+                regulator-max-microvolt = <3300000>;
+                gpios = <&gpio0 7 0>;
+                gpios-states = <1>;
+                states = <3300000 1
+                          1800000 0>;
+        };
+
+	sdhci1: sdio at 36600000 {
+		compatible = "fujitsu,mb86s70-sdh30";
+		reg = <0 0x36600000 0x1000>;
+		interrupts = <0 172 0x4>,
+			     <0 173 0x4>;
+		voltage-ranges = <1800 1800>, <3300 3300>;
+		bus-width = <4>;
+		clocks = <&clk_main_c_0>, <&clk_main_d_0>;
+		clock-names = "iface", "core";
+		vqmmc-supply = <&vccq_sdhci1>;
+	};
+};
diff --git a/arch/arm/boot/dts/mb86s73.dtsi b/arch/arm/boot/dts/mb86s73.dtsi
new file mode 100644
index 0000000..45db022
--- /dev/null
+++ b/arch/arm/boot/dts/mb86s73.dtsi
@@ -0,0 +1,49 @@
+/*
+ * Copyright (C) 2013-2014 FUJITSU SEMICONDUCTOR LIMITED
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ */
+
+#include "mb86s7x.dtsi"
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x100>;
+			cci-control-port = <&cci_control3>;
+			clock-frequency = <800000000>;
+			clock-latency = <100000>;
+		};
+
+		cpu1: cpu at 101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x101>;
+			cci-control-port = <&cci_control3>;
+			clock-frequency = <800000000>;
+			clock-latency = <100000>;
+		};
+	};
+
+	cci at 2c090000 {
+		compatible = "arm,cci-400";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0 0x2c090000 0x1000>;
+		ranges = <0x0 0x0 0x2c090000 0x10000>;
+
+		cci_control3: slave-if at 4000 {
+			compatible = "arm,cci-400-ctrl-if";
+			interface-type = "ace";
+			reg = <0x4000 0x1000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/mb86s73eb.dts b/arch/arm/boot/dts/mb86s73eb.dts
new file mode 100644
index 0000000..2bb55a3
--- /dev/null
+++ b/arch/arm/boot/dts/mb86s73eb.dts
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2013-2014 FUJITSU SEMICONDUCTOR LIMITED
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ */
+
+/dts-v1/;
+
+#include "mb86s73.dtsi"
+
+/ {
+	model = "Fujitsu MB86S73 EVB";
+	compatible = "fujitsu,mb86s73-evb";
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x80000000 0x80000000>;
+	};
+
+	chosen {
+		bootargs = "loglevel=8 console=ttyS0,115200 root=/dev/mmcblk1p1 rootfstype=ext4 rootwait rw";
+		linux,initrd-start = <0xc0000000>;
+		linux,initrd-end =   <0xc0800000>;
+	};
+
+	sdhci1: sdio at 36600000 {
+		compatible = "fujitsu,mb86s70-sdh30";
+		reg = <0 0x36600000 0x1000>;
+		interrupts = <0 172 0x4>,
+			     <0 173 0x4>;
+		voltage-ranges = <1800 1800>, <3300 3300>;
+		bus-width = <4>;
+		clocks = <&clk_main_c_0>, <&clk_main_d_0>;
+		clock-names = "iface", "core";
+	};
+};
diff --git a/arch/arm/boot/dts/mb86s7x.dtsi b/arch/arm/boot/dts/mb86s7x.dtsi
new file mode 100644
index 0000000..50dcf04
--- /dev/null
+++ b/arch/arm/boot/dts/mb86s7x.dtsi
@@ -0,0 +1,595 @@
+/*
+ * Copyright (C) 2013-2014 FUJITSU SEMICONDUCTOR LIMITED
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ */
+
+#include "skeleton.dtsi"
+#include <dt-bindings/clock/mb86s70-clk.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <1>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+
+	pmua7: pmu_a7 {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <0 18 4>,
+			     <0 22 4>;
+	};
+
+	/**
+	 * The UngatedCLK is the source of 8 maskable clock ports
+	 * as well as having its own output port which can't be masked.
+	 */
+	clocks {
+		clk_alw_0_0: clk_alw_0_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <0>;
+			port = <0>;
+		};
+
+		clk_alw_0_1: clk_alw_0_1 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <0>;
+			port = <1>;
+		};
+
+		clk_alw_0_2: clk_alw_0_2 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <0>;
+			port = <2>;
+		};
+
+		clk_alw_0_4: clk_alw_0_4 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <0>;
+			port = <4>;
+		};
+
+		clk_alw_0_5: clk_alw_0_5 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <0>;
+			port = <5>;
+		};
+
+		clk_alw_0_8: clk_alw_0_8 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <0>;
+			port = <MB86S70_CRG11_UNGPRT>;
+		};
+
+		clk_alw_1_0: clk_alw_1_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <1>;
+			port = <0>;
+		};
+
+		clk_alw_1_1: clk_alw_1_1 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <1>;
+			port = <1>;
+		};
+
+		clk_alw_1_2: clk_alw_1_2 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <1>;
+			port = <2>;
+		};
+
+		clk_alw_1_8: clk_alw_1_8 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <1>;
+			port = <MB86S70_CRG11_UNGPRT>;
+		};
+
+		clk_alw_2_0: clk_alw_2_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <2>;
+			port = <0>;
+		};
+
+		clk_alw_2_1: clk_alw_2_1 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <2>;
+			port = <1>;
+		};
+
+		clk_alw_2_2: clk_alw_2_2 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <2>;
+			port = <2>;
+		};
+
+		clk_alw_2_4: clk_alw_2_4 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <2>;
+			port = <4>;
+		};
+
+		clk_alw_2_5: clk_alw_2_5 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <2>;
+			port = <5>;
+		};
+
+		clk_alw_2_8: clk_alw_2_8 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <2>;
+			port = <MB86S70_CRG11_UNGPRT>;
+		};
+
+		clk_alw_6_8: clk_alw_6_8 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <6>;
+			port = <MB86S70_CRG11_UNGPRT>;
+		};
+
+		clk_alw_7_0: clk_alw_7_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <7>;
+			port = <0>;
+		};
+
+		clk_alw_8_0: clk_alw_8_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <8>;
+			port = <0>;
+		};
+
+		clk_alw_a_0: clk_alw_a_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <0x0a>;
+			port = <0>;
+		};
+
+		clk_alw_a_1: clk_alw_a_1 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <0x0a>;
+			port = <1>;
+		};
+
+		clk_alw_b_0: clk_alw_b_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <0x0b>;
+			port = <0>;
+		};
+
+		clk_alw_c_0: clk_alw_c_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_ALW>;
+			domain = <0x0c>;
+			port = <0>;
+		};
+
+		clk_ddr3_0_0: clk_ddr3_0_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_DDR3>;
+			domain = <0>;
+			port = <0>;
+		};
+
+		clk_main_0_0: clk_main_0_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <0>;
+			port = <0>;
+		};
+
+		clk_main_0_8: clk_main_0_8 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <0>;
+			port = <MB86S70_CRG11_UNGPRT>;
+		};
+
+		clk_main_1_3: clk_main_1_3 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <1>;
+			port = <3>;
+		};
+
+		clk_main_1_4: clk_main_1_4 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <1>;
+			port = <4>;
+		};
+
+		clk_main_2_0: clk_main_2_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <2>;
+			port = <0>;
+		};
+
+		clk_main_2_3: clk_main_2_3 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <2>;
+			port = <3>;
+		};
+
+		clk_main_2_4: clk_main_2_4 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <2>;
+			port = <4>;
+		};
+
+		clk_main_2_7: clk_main_2_7 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <2>;
+			port = <7>;
+		};
+
+		clk_main_3_0: clk_main_3_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <3>;
+			port = <0>;
+		};
+
+		clk_main_3_3: clk_main_3_3 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <3>;
+			port = <3>;
+		};
+
+		clk_main_3_4: clk_main_3_4 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <3>;
+			port = <4>;
+		};
+
+		clk_main_3_5: clk_main_3_5 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <3>;
+			port = <5>;
+		};
+
+		clk_main_3_6: clk_main_3_6 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <3>;
+			port = <6>;
+		};
+
+		clk_main_4_0: clk_main_4_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <4>;
+			port = <0>;
+		};
+
+		clk_main_4_4: clk_main_4_4 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <4>;
+			port = <4>;
+		};
+
+		clk_main_4_5: clk_main_4_5 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <4>;
+			port = <5>;
+		};
+
+		clk_main_5_0: clk_main_5_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <5>;
+			port = <0>;
+		};
+
+		clk_main_5_3: clk_main_5_3 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <5>;
+			port = <3>;
+		};
+
+		clk_main_5_4: clk_main_5_4 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <5>;
+			port = <4>;
+		};
+
+		clk_main_5_5: clk_main_5_5 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <5>;
+			port = <5>;
+		};
+
+		clk_main_7_0: clk_main_7_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <7>;
+			port = <0>;
+		};
+
+		clk_main_8_1: clk_main_8_1 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <8>;
+			port = <1>;
+		};
+
+		clk_main_9_0: clk_main_9_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <9>;
+			port = <0>;
+		};
+
+		clk_main_a_0: clk_main_a_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <0xa>;
+			port = <0>;
+		};
+
+		clk_main_b_0: clk_main_b_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <0xb>;
+			port = <0>;
+		};
+
+		clk_main_c_0: clk_main_c_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <0xc>;
+			port = <0>;
+		};
+
+		clk_main_d_0: clk_main_d_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_MAIN>;
+			domain = <0xd>;
+			port = <0>;
+		};
+
+		clk_usb_0_0: clk_usb_0_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_HDMI>;
+			domain = <0>;
+			port = <0>;
+		};
+
+		clk_usb_1_0: clk_usb_1_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_HDMI>;
+			domain = <1>;
+			port = <0>;
+		};
+
+		clk_usb_2_0: clk_usb_2_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_HDMI>;
+			domain = <2>;
+			port = <0>;
+		};
+
+		clk_usb_3_0: clk_usb_3_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_HDMI>;
+			domain = <3>;
+			port = <0>;
+		};
+
+		clk_fpdlink_0_0: clk_fpdlink_0_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_DPHY>;
+			domain = <0>;
+			port = <0>;
+		};
+
+		clk_fpdlink_1_0: clk_fpdlink_1_0 {
+			compatible = "fujitsu,mb86s70-clk";
+			#clock-cells = <0>;
+			cntrlr = <MB86S70_CRG11_DPHY>;
+			domain = <1>;
+			port = <0>;
+		};
+	};
+
+	timer0: timer at 31080000 {
+		compatible = "arm,sp804", "arm,primecell";
+		reg = <0 0x31080000 0x1000>;
+		interrupts = <0 324 4>,
+			     <0 325 4>;
+		clocks = <&clk_alw_6_8>;
+		clock-names = "apb_pclk";
+	};
+
+	timer1: archtimer {
+		compatible = "arm,armv7-timer";
+		clock-frequency = <125000000>;
+		interrupts = <1 13 0xf08>,
+			     <1 14 0xf08>,
+			     <1 11 0xf08>,
+			     <1 10 0xf08>;
+	};
+
+	gic: interrupt-controller at 2c001000 {
+		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0 0x2c001000 0x1000>,
+		      <0 0x2c002000 0x1000>,
+		      <0 0x2c004000 0x2000>,
+		      <0 0x2c006000 0x2000>;
+		interrupts = <1 9 0xf04>;
+	};
+
+	mhu: mailbox at 2b1f0000 {
+		#mbox-cells = <1>;
+		compatible = "arm,mbox-mhu";
+		reg = <0 0x2b1f0000 0x1000>;
+		interrupts = <0 36 4>, /* LP Non-Sec */
+			     <0 35 4>, /* HP Non-Sec */
+			     <0 37 4>; /* Secure */
+	};
+
+	mhu_client: scb at 2e000000 {
+		compatible = "fujitsu,mb86s70-scb-1.0";
+		reg = <0 0x2e000000 0x4000>; /* SHM for IPC */
+		mboxes = <&mhu 1>;
+	};
+
+	uart0: serial at 31040000 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0 0x31040000 0x100>;
+		interrupts = <0 320 0x4>;
+		clock-frequency = <62500000>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+		clocks = <&clk_alw_2_1>;
+		clock-names = "sclk";
+	};
+
+	uart1: serial at 31050000 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0 0x31050000 0x100>;
+		interrupts = <0 321 0x4>;
+		clock-frequency = <62500000>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+		clocks = <&clk_alw_2_1>;
+		clock-names = "sclk";
+	};
+
+	uart2: serial at 31060000 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0 0x31060000 0x100>;
+		interrupts = <0 322 0x4>;
+		clock-frequency = <62500000>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+		clocks = <&clk_alw_2_1>;
+		clock-names = "sclk";
+	};
+
+	gpio0: gpio at 31000000 {
+		compatible = "fujitsu,mb86s70-gpio";
+		reg = <0 0x31000000 0x10000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		clocks = <&clk_alw_2_1>;
+	};
+
+	gpio1: gpio at 31010000 {
+		compatible = "fujitsu,mb86s70-gpio";
+		reg = <0 0x31010000 0x10000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		clocks = <&clk_alw_2_1>;
+	};
+
+	sdhci0: emmc at 300c0000 {
+		compatible = "fujitsu,mb86s70-sdh30";
+		reg = <0 0x300c0000 0x1000>;
+		interrupts = <0 164 0x4>,
+			     <0 165 0x4>;
+		voltage-ranges = <1800 1800>, <3300 3300>;
+		bus-width = <8>;
+		clocks = <&clk_alw_c_0>, <&clk_alw_b_0>;
+		clock-names = "iface", "core";
+	};
+};
-- 
1.9.0
