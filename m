From: vincent.cw.yang@gmail.com (Vincent Yang)
Date: Wed,  4 Mar 2015 19:05:46 +0800
Subject: [PATCH v7 5/7] dt: mb86s7x: add dt files for MB86S7x evbs
In-Reply-To: <1425466367-30556-1-git-send-email-vincent.yang@socionext.com>
References: <1425466367-30556-1-git-send-email-vincent.yang@socionext.com>
Message-ID: <1425467146-30777-1-git-send-email-vincent.yang@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jaswinder.singh@linaro.org>

Add dt files for MB86S7x evb.

Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Vincent Yang <vincent.yang@socionext.com>
Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@socionext.com>
---
 arch/arm/boot/dts/Makefile      |   3 +
 arch/arm/boot/dts/mb86s70.dtsi  |  91 +++++++++++++++++++++++++
 arch/arm/boot/dts/mb86s70eb.dts |  57 ++++++++++++++++
 arch/arm/boot/dts/mb86s73.dtsi  |  63 ++++++++++++++++++
 arch/arm/boot/dts/mb86s73eb.dts |  44 +++++++++++++
 arch/arm/boot/dts/mb86s7x.dtsi  | 142 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 400 insertions(+)
 create mode 100644 arch/arm/boot/dts/mb86s70.dtsi
 create mode 100644 arch/arm/boot/dts/mb86s70eb.dts
 create mode 100644 arch/arm/boot/dts/mb86s73.dtsi
 create mode 100644 arch/arm/boot/dts/mb86s73eb.dts
 create mode 100644 arch/arm/boot/dts/mb86s7x.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a1c776b..aa0e6d4 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -197,6 +197,9 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
 	kirkwood-ts419-6282.dtb
 dtb-$(CONFIG_ARCH_LPC32XX) += \
 	ea3250.dtb phy3250.dtb
+dtb-$(CONFIG_ARCH_MB86S7X) += \
+	mb86s70eb.dtb \
+	mb86s73eb.dtb
 dtb-$(CONFIG_MACH_MESON6) += \
 	meson6-atv1200.dtb
 dtb-$(CONFIG_ARCH_MMP) += \
diff --git a/arch/arm/boot/dts/mb86s70.dtsi b/arch/arm/boot/dts/mb86s70.dtsi
new file mode 100644
index 0000000..057e135
--- /dev/null
+++ b/arch/arm/boot/dts/mb86s70.dtsi
@@ -0,0 +1,91 @@
+/*
+ * Copyright (C) 2013-2015 FUJITSU SEMICONDUCTOR LIMITED
+ * Copyright (C) 2015 Linaro Ltd.
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
+&archtimer {
+	status = "disabled";
+};
+
+&pmua7 {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/mb86s70eb.dts b/arch/arm/boot/dts/mb86s70eb.dts
new file mode 100644
index 0000000..1e51ce0
--- /dev/null
+++ b/arch/arm/boot/dts/mb86s70eb.dts
@@ -0,0 +1,57 @@
+/*
+ * Copyright (C) 2013-2015 FUJITSU SEMICONDUCTOR LIMITED
+ * Copyright (C) 2015 Linaro Ltd.
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
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x80000000 0x80000000>, <0x08 0x80000000 0x80000000>;
+
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 root=/dev/mmcblk1p1 rootfstype=ext4 rootwait rw";
+		linux,initrd-start = <0xc0000000>;
+		linux,initrd-end =   <0xc0800000>;
+	};
+
+	vccq_sdhci1: regulator at 0 {
+		compatible = "regulator-gpio";
+		regulator-name = "SDHCI1 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&gpio0 7 0>;
+		gpios-states = <1>;
+		states = <3300000 1
+			  1800000 0>;
+	};
+};
+
+&sdhci0 {
+	status = "ok";
+	bus-width = <8>;
+};
+
+&sdhci1 {
+	status = "ok";
+	bus-width = <4>;
+	vqmmc-supply = <&vccq_sdhci1>;
+};
diff --git a/arch/arm/boot/dts/mb86s73.dtsi b/arch/arm/boot/dts/mb86s73.dtsi
new file mode 100644
index 0000000..3c9d8d0
--- /dev/null
+++ b/arch/arm/boot/dts/mb86s73.dtsi
@@ -0,0 +1,63 @@
+/*
+ * Copyright (C) 2013-2015 FUJITSU SEMICONDUCTOR LIMITED
+ * Copyright (C) 2015 Linaro Ltd.
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
+
+	hcd21_ehci: f_usb20ho_echi at 34240000 {
+		compatible = "fujitsu,f_usb20ho", "generic-ehci";
+		reg = <0 0x34240000 0x1000>;
+		interrupts = <0 419 0x4>;
+		clocks = <&clock 2 2 4>, <&clock 2 4 5>, <&clock 4 0 0>;
+	};
+
+	hcd21_ohci: f_usb20ho_ochi at 34240000 {
+		compatible = "fujitsu,f_usb20ho", "generic-ohci";
+		reg = <0 0x34241000 0x1000>;
+		interrupts = <0 419 0x4>;
+		clocks = <&clock 2 2 4>, <&clock 2 4 5>, <&clock 4 0 0>;
+	};
+};
diff --git a/arch/arm/boot/dts/mb86s73eb.dts b/arch/arm/boot/dts/mb86s73eb.dts
new file mode 100644
index 0000000..43f2fc6
--- /dev/null
+++ b/arch/arm/boot/dts/mb86s73eb.dts
@@ -0,0 +1,44 @@
+/*
+ * Copyright (C) 2013-2015 FUJITSU SEMICONDUCTOR LIMITED
+ * Copyright (C) 2015 Linaro Ltd.
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
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x80000000 0x80000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 root=/dev/mmcblk1p1 rootfstype=ext4 rootwait rw";
+		linux,initrd-start = <0xc0000000>;
+		linux,initrd-end =   <0xc0800000>;
+	};
+};
+
+&sdhci0 {
+	status = "ok";
+	bus-width = <8>;
+};
+
+&sdhci1 {
+	status = "ok";
+	bus-width = <4>;
+};
diff --git a/arch/arm/boot/dts/mb86s7x.dtsi b/arch/arm/boot/dts/mb86s7x.dtsi
new file mode 100644
index 0000000..4731af1
--- /dev/null
+++ b/arch/arm/boot/dts/mb86s7x.dtsi
@@ -0,0 +1,142 @@
+/*
+ * Copyright (C) 2013-2015 FUJITSU SEMICONDUCTOR LIMITED
+ * Copyright (C) 2015 Linaro Ltd.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ */
+
+#include "skeleton.dtsi"
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <1>;
+
+	pmua7: pmu_a7 {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <0 18 4>,
+			     <0 22 4>;
+	};
+
+	clock: crg11 {
+		compatible = "fujitsu,mb86s70-crg11";
+		#clock-cells = <3>;
+	};
+
+	timer0: timer at 31080000 {
+		compatible = "arm,sp804", "arm,primecell";
+		reg = <0 0x31080000 0x1000>;
+		interrupts = <0 324 4>,
+			     <0 325 4>;
+		clocks = <&clock 0 6 8>;
+		clock-names = "apb_pclk";
+	};
+
+	archtimer: archtimer {
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
+		compatible = "arm,mhu", "arm,primecell";
+		reg = <0 0x2b1f0000 0x1000>;
+		interrupts = <0 36 4>, /* LP Non-Sec */
+			     <0 35 4>, /* HP Non-Sec */
+			     <0 37 4>; /* Secure */
+		clocks = <&clock 0 6 8>;
+		clock-names = "apb_pclk";
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
+		clocks = <&clock 0 2 1>;
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
+		clocks = <&clock 0 2 1>;
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
+		clocks = <&clock 0 2 1>;
+		clock-names = "sclk";
+	};
+
+	gpio0: gpio at 31000000 {
+		compatible = "fujitsu,mb86s70-gpio";
+		reg = <0 0x31000000 0x10000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		clocks = <&clock 0 2 1>;
+	};
+
+	gpio1: gpio at 31010000 {
+		compatible = "fujitsu,mb86s70-gpio";
+		reg = <0 0x31010000 0x10000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		clocks = <&clock 0 2 1>;
+	};
+
+	sdhci0: mmc at 300c0000 {
+		status = "disabled";
+		compatible = "fujitsu,mb86s70-sdhci-3.0";
+		reg = <0 0x300c0000 0x1000>;
+		interrupts = <0 164 0x4>,
+			     <0 165 0x4>;
+		clocks = <&clock 0 0xc 0>, <&clock 0 0xb 0>;
+		clock-names = "iface", "core";
+	};
+
+	sdhci1: mmc at 36600000 {
+		status = "disabled";
+		compatible = "fujitsu,mb86s70-sdhci-3.0";
+		reg = <0 0x36600000 0x1000>;
+		interrupts = <0 172 0x4>,
+			     <0 173 0x4>;
+		clocks = <&clock 2 0xc 0>, <&clock 2 0xd 0>;
+		clock-names = "iface", "core";
+	};
+};
-- 
1.9.0
