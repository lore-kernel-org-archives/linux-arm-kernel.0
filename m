From: netz.kernel@gmail.com (Marty Plummer)
Date: Thu, 15 Sep 2016 16:05:05 -0500
Subject: [RFC PATCH v2 5/5] ARM: hisi: add devicetree for hi3520
In-Reply-To: <20160915210505.21878-1-netz.kernel@gmail.com>
References: <20160915210505.21878-1-netz.kernel@gmail.com>
Message-ID: <20160915210505.21878-6-netz.kernel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Probably needs a lot more work, but as of right now this can get me into
a basic busybox userspace 
Signed-off-by: Marty Plummer <netz.kernel@gmail.com>
---
 arch/arm/boot/dts/Makefile              |   2 +
 arch/arm/boot/dts/hi3520-1176-dm77a.dts |  62 +++++++++++
 arch/arm/boot/dts/hi3520-1176.dtsi      | 178 ++++++++++++++++++++++++++++++++
 3 files changed, 242 insertions(+)
 create mode 100644 arch/arm/boot/dts/hi3520-1176-dm77a.dts
 create mode 100644 arch/arm/boot/dts/hi3520-1176.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7ffd3a3..285f56a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -154,6 +154,8 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
 	exynos5440-sd5v1.dtb \
 	exynos5440-ssdk5440.dtb \
 	exynos5800-peach-pi.dtb
+dtb-$(CONFIG_ARCH_HI3520_1176) += \
+	hi3520-1176-dm77a.dtb
 dtb-$(CONFIG_ARCH_HI3620) += \
 	hi3620-hi4511.dtb
 dtb-$(CONFIG_ARCH_HIGHBANK) += \
diff --git a/arch/arm/boot/dts/hi3520-1176-dm77a.dts b/arch/arm/boot/dts/hi3520-1176-dm77a.dts
new file mode 100644
index 0000000..c87a18e
--- /dev/null
+++ b/arch/arm/boot/dts/hi3520-1176-dm77a.dts
@@ -0,0 +1,62 @@
+/*
+ * Copyright (C) 2016  Marty Plummer <netz.kernel@gmail.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 3 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/dts-v1/;
+#include "hi3520-1176.dtsi"
+
+/ {
+	model = "Nightowl zeus-dvr";
+	compatible = "hisilicon,hi3520-1176";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+	};
+
+	/* chosen { */
+	/* 	bootargs = "mem=72M console=ttyAMA0,115200 root=/dev/ram"; */
+	/* 	stdout-path = "serial0:115200n8"; */
+	/* }; */
+
+	memory at e2000000 {
+		device_type = "memory";
+		reg = <0xe2000000 0x4800000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&dual_timer0 {
+	status = "okay";
+};
+
+&gmac0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	phy-handle = <&phy1>;
+	phy-mode = "mii";
+	mac-address = [00 00 00 00 00 00];
+	status = "okay";
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
diff --git a/arch/arm/boot/dts/hi3520-1176.dtsi b/arch/arm/boot/dts/hi3520-1176.dtsi
new file mode 100644
index 0000000..a7dbc16
--- /dev/null
+++ b/arch/arm/boot/dts/hi3520-1176.dtsi
@@ -0,0 +1,178 @@
+/*
+ * Copyright (C) 2016  Marty Plummer <netz.kernel@gmail.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 3 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	/* interrupt-parent = <&vic0>; */
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,arm1176jzf-s";
+			reg = <0>;
+		};
+	};
+
+	uartclk: uartclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <101000000>;
+	};
+
+	clk_3m: clk_3m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <101000000>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+
+		vic0: interrupt-controller at 10070000 {
+			compatible = "arm,pl190-vic";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x10070000 0x1000>;
+		};
+
+		vic1: interrupt-controller at 10080000 {
+			compatible = "arm,pl190-vic";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0x10080000 0x1000>;
+		};
+
+		amba {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			ranges;
+
+			uart0: uart at 20090000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x20090000 0x1000>;
+				clocks = <&uartclk &clk_3m>;
+				clock-names = "uartclk", "apb_pclk";
+				interrupts-extended = <&vic0 12 4>;
+				status = "disable";
+			};
+
+			uart1: uart at 200a0000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x200a0000 0x1000>;
+				clocks = <&uartclk &clk_3m>;
+				clock-names = "uartclk", "apb_pclk";
+				interrupts-extended = <&vic0 12 4>;
+			};
+
+			uart2: uart at 200b0000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x200b0000 0x1000>;
+				clocks = <&uartclk &clk_3m>;
+				clock-names = "uartclk", "apb_pclk";
+				interrupts-extended = <&vic0 13 4>;
+			};
+
+			uart3: uart at 200c0000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x200c0000 0x1000>;
+				clocks = <&uartclk &clk_3m>;
+				clock-names = "uartclk", "apb_pclk";
+				interrupts-extended = <&vic0 13 4>;
+			};
+
+			gpio0: gpio at 20150000 {
+				compatible = "arm,pl061", "arm,primecell";
+				reg = <0x20150000 0x1000>;
+				interrupts-extended = <&vic1 6 4>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				clocks = <&uartclk &clk_3m>;
+				clock-names = "apb_pclk";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				status = "disabled";
+			};
+
+			dual_timer0: dual_timer at 20000000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0x20000000 0x1000>;
+				interrupts-extended = <&vic0 4 4>, <&vic0 4 4>;
+				clocks = <&clk_3m>;
+				clock-names = "apb_pclk";
+				status = "disable";
+			};
+
+			dual_timer1: dual_timer at 20010000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0x20010000 0x1000>;
+				interrupts-extended = <&vic0 5 4>, <&vic0 5 4>;
+				clocks = <&clk_3m>;
+				clock-names = "apb_pclk";
+				status = "disable";
+			};
+
+			spi_bus0: spi at 200e0000 {
+				compatible = "arm,pl022", "arm,primecell";
+				reg = <0x200e0000 0x1000>;
+				interrupts-extended = <&vic0 11 4>;
+				num-cs = <1>;
+			};
+		};
+
+		sysctrl: system-controller at 20050000 {
+			compatible = "hisilicon,hi3520-sysctrl", "syscon";
+			reg = <0x20050000 0x1000>;
+		};
+
+		reboot {
+			compatible = "syscon-reboot";
+			regmap = <&sysctrl>;
+			offset = <0x4>;
+			mask = <0xdeadbeef>;
+		};
+
+		/* gmac0: ethernet at 10090000 { */
+		/* 	compatible = "hisilicon,hix5hd2-gmac"; */
+		/* 	reg = <0x10090000 0x1000>,<0x20050000 0x1000>; */
+		/* 	interrupts-extended = <&vic0 14 4>; */
+		/* 	clocks = <&clk_3m>; */
+		/* 	status = "disabled"; */
+		/* }; */
+
+		usb0: ehci at 100b0000 {
+			compatible = "generic-ehci";
+			reg = <0x100b0000 0x1000>;
+			interrupts-extended = <&vic0 23 4>;
+			clocks = <&clk_3m>;
+		};
+
+		usb1: ohci at 100a0000 {
+			compatible = "generic-ohci";
+			reg = <0x100a0000 0x1000>;
+			interrupts-extended = <&vic0 22 4>;
+			clocks = <&clk_3m>;
+		};
+	};
+};
-- 
2.9.3
