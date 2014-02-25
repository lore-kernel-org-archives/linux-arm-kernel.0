From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 25 Feb 2014 16:50:35 -0500
Subject: [PATCH 4/4] ARM: dts: keystone: add support for k2 Edison SoC and EVM
In-Reply-To: <1393365035-20083-1-git-send-email-santosh.shilimkar@ti.com>
References: <1393365035-20083-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1393365035-20083-5-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Murali Karicheri <m-karicheri2@ti.com>

Keystone2 Edison (K2E) is a Quad Cortex A15 based SoC with
1 DSP. It has standard peripherals such as i2c, spi, uart, timer,
pcie, etc similar to k2hk, but without wireless hardwares. This
patch add support for k2 Edison SoC and EVM. This re-uses the common
keystone.dtsi to include common bindings across the various k2
devices.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/k2e-clocks.dtsi |   78 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/k2e-evm.dts     |   60 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/k2e.dtsi        |   80 +++++++++++++++++++++++++++++++++++++
 3 files changed, 218 insertions(+)
 create mode 100644 arch/arm/boot/dts/k2e-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/k2e-evm.dts
 create mode 100644 arch/arm/boot/dts/k2e.dtsi

diff --git a/arch/arm/boot/dts/k2e-clocks.dtsi b/arch/arm/boot/dts/k2e-clocks.dtsi
new file mode 100644
index 0000000..90774d6
--- /dev/null
+++ b/arch/arm/boot/dts/k2e-clocks.dtsi
@@ -0,0 +1,78 @@
+/*
+ * Copyright 2014 Texas Instruments, Inc.
+ *
+ * Keystone 2 Edison SoC specific device tree
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+clocks {
+	mainpllclk: mainpllclk at 2310110 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,main-pll-clock";
+		clocks = <&refclksys>;
+		reg = <0x02620350 4>, <0x02310110 4>;
+		reg-names = "control", "multiplier";
+		fixed-postdiv = <2>;
+	};
+
+	papllclk: papllclk at 2620358 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,pll-clock";
+		clocks = <&refclkpass>;
+		clock-output-names = "pa-pll-clk";
+		reg = <0x02620358 4>;
+		reg-names = "control";
+	};
+
+	ddr3apllclk: ddr3apllclk at 2620360 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,pll-clock";
+		clocks = <&refclkddr3a>;
+		clock-output-names = "ddr-3a-pll-clk";
+		reg = <0x02620360 4>;
+		reg-names = "control";
+	};
+
+	clkusb1: clkusb1 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk16>;
+		clock-output-names = "usb";
+		reg = <0x02350004 0xb00>, <0x02350000 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <0>;
+	};
+
+	clkhyperlink0: clkhyperlink0 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk12>;
+		clock-output-names = "hyperlink-0";
+		reg = <0x02350030 0xb00>, <0x02350014 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <5>;
+	};
+
+	clkpcie1: clkpcie1 {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk12>;
+		clock-output-names = "pcie";
+		reg = <0x0235006c 0xb00>, <0x02350000 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <18>;
+	};
+
+	clkxge: clkxge {
+		#clock-cells = <0>;
+		compatible = "ti,keystone,psc-clock";
+		clocks = <&chipclk13>;
+		clock-output-names = "xge";
+		reg = <0x023500c8 0xb00>, <0x02350074 0x400>;
+		reg-names = "control", "domain";
+		domain-id = <29>;
+	};
+};
diff --git a/arch/arm/boot/dts/k2e-evm.dts b/arch/arm/boot/dts/k2e-evm.dts
new file mode 100644
index 0000000..bb8faeb
--- /dev/null
+++ b/arch/arm/boot/dts/k2e-evm.dts
@@ -0,0 +1,60 @@
+/*
+ * Copyright 2013-2014 Texas Instruments, Inc.
+ *
+ * Keystone 2 Edison EVM device tree
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "keystone.dtsi"
+#include "k2e.dtsi"
+
+/ {
+	compatible =  "ti,k2e-evm";
+	model = "Texas Instruments Keystone 2 Edison EVM";
+
+	soc {
+
+		clocks {
+			refclksys: refclksys {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+				clock-frequency = <100000000>;
+				clock-output-names = "refclk-sys";
+			};
+
+			refclkpass: refclkpass {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+				clock-frequency = <100000000>;
+				clock-output-names = "refclk-pass";
+			};
+
+			refclkddr3a: refclkddr3a {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+				clock-frequency = <100000000>;
+				clock-output-names = "refclk-ddr3a";
+			};
+		};
+	};
+};
+
+&usb_phy {
+	status = "okay";
+};
+
+&usb {
+	status = "okay";
+};
+
+&usb1_phy {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/k2e.dtsi b/arch/arm/boot/dts/k2e.dtsi
new file mode 100644
index 0000000..03d0190
--- /dev/null
+++ b/arch/arm/boot/dts/k2e.dtsi
@@ -0,0 +1,80 @@
+/*
+ * Copyright 2013-2014 Texas Instruments, Inc.
+ *
+ * Keystone 2 Edison soc device tree
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		interrupt-parent = <&gic>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-a15";
+			device_type = "cpu";
+			reg = <0>;
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a15";
+			device_type = "cpu";
+			reg = <1>;
+		};
+
+		cpu at 2 {
+			compatible = "arm,cortex-a15";
+			device_type = "cpu";
+			reg = <2>;
+		};
+
+		cpu at 3 {
+			compatible = "arm,cortex-a15";
+			device_type = "cpu";
+			reg = <3>;
+		};
+	};
+
+	soc {
+		/include/ "k2e-clocks.dtsi"
+
+		usb: usb at 2680000 {
+			interrupts = <GIC_SPI 152 IRQ_TYPE_EDGE_RISING>;
+			dwc3 at 2690000 {
+				interrupts = <GIC_SPI 152 IRQ_TYPE_EDGE_RISING>;
+			};
+		};
+
+		usb1_phy: usb_phy at 2620750 {
+			compatible = "ti,keystone-usbphy";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x2620750 24>;
+			status = "disabled";
+		};
+
+		usb1: usb at 25000000 {
+			compatible = "ti,keystone-dwc3";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x25000000 0x10000>;
+			clocks = <&clkusb1>;
+			clock-names = "usb";
+			interrupts = <GIC_SPI 414 IRQ_TYPE_EDGE_RISING>;
+			ranges;
+			status = "disabled";
+
+			dwc3 at 25010000 {
+				compatible = "synopsys,dwc3";
+				reg = <0x25010000 0x70000>;
+				interrupts = <GIC_SPI 414 IRQ_TYPE_EDGE_RISING>;
+				usb-phy = <&usb1_phy>, <&usb1_phy>;
+			};
+		};
+	};
+};
-- 
1.7.9.5
