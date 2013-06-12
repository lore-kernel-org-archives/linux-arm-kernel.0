From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 12 Jun 2013 17:25:15 -0400
Subject: [PATCH v2 1/3] ARM: dts: keystone: Add minimal Keystone SOC device
 tree data
In-Reply-To: <1371072317-15030-1-git-send-email-santosh.shilimkar@ti.com>
References: <1371072317-15030-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1371072317-15030-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add minimal device tree data for Keystone2 based SOCs. Patch
contains mainly ARM related SOC data and nothing about EVM specific
yet.

Cc: Grant Likely <grant.likely@linaro.org>
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: arm at kernel.org

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 .../devicetree/bindings/arm/keystone/keystone.txt  |   10 ++
 arch/arm/boot/dts/keystone.dts                     |  109 ++++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/keystone/keystone.txt
 create mode 100644 arch/arm/boot/dts/keystone.dts

diff --git a/Documentation/devicetree/bindings/arm/keystone/keystone.txt b/Documentation/devicetree/bindings/arm/keystone/keystone.txt
new file mode 100644
index 0000000..231e031
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/keystone/keystone.txt
@@ -0,0 +1,10 @@
+TI Kesytone Platforms Device Tree Bindings
+-----------------------------------------------
+
+Boards with Keystone2 based devices (TCI66xxK2H) SOC shall have the
+following properties.
+
+Required properties:
+ - compatible: All TI specific devices present in Keystone SOC should be in
+   the form "ti,keystone-*". Generic devices like gic, arch_timers, ns16550
+   type UART should use the specified compatible for those devices.
diff --git a/arch/arm/boot/dts/keystone.dts b/arch/arm/boot/dts/keystone.dts
new file mode 100644
index 0000000..588a0a3
--- /dev/null
+++ b/arch/arm/boot/dts/keystone.dts
@@ -0,0 +1,109 @@
+/*
+ * Copyright 2013 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "Texas Instruments Keystone 2 SoC";
+	compatible =  "ti,keystone-evm";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&gic>;
+
+	aliases {
+		serial0	= &uart0;
+	};
+
+	memory {
+		reg = <0x00000000 0x80000000 0x00000000 0x40000000>;
+	};
+
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
+	gic:	interrupt-controller at 02560000 {
+		compatible = "arm,cortex-a15-gic";
+		#interrupt-cells = <3>;
+		#size-cells = <0>;
+		#address-cells = <1>;
+		interrupt-controller;
+		reg = <0x0 0x02561000 0x0 0x1000>,
+		      <0x0 0x02562000 0x0 0x2000>;
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <1 13 0xf08>,
+			     <1 14 0xf08>,
+			     <1 11 0xf08>,
+			     <1 10 0x308>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "ti,keystone","simple-bus";
+		interrupt-parent = <&gic>;
+		ranges = <0x0 0x0 0x0 0xc0000000>;
+
+		rstctrl:rstctrl at 23100e8 {
+			compatible = "ti,keystone-reset";
+			reg = <0x023100e8 4>;	/* pll reset control reg */
+		};
+
+		uart0:	serial at 02530c00 {
+			compatible	= "ns16550a";
+			current-speed	= <115200>;
+			reg-shift	= <2>;
+			reg-io-width	= <4>;
+			reg		= <0x02530c00 0x100>;
+			clock-frequency	= <133120000>;
+			interrupts	= <0 277 0xf01>;
+		};
+
+		uart1:	serial at 02531000 {
+			compatible	= "ns16550a";
+			current-speed	= <115200>;
+			reg-shift	= <2>;
+			reg-io-width	= <4>;
+			reg		= <0x02531000 0x100>;
+			clock-frequency	= <133120000>;
+			interrupts	= <0 280 0xf01>;
+		};
+
+	};
+};
-- 
1.7.9.5
