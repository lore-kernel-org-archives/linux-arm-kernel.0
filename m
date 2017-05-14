From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 14 May 2017 04:24:28 +0200
Subject: [PATCH v3 4/5] ARM64: dts: Add Realtek RTD1295 and Zidoo X9S
In-Reply-To: <20170514022429.11555-1-afaerber@suse.de>
References: <20170514022429.11555-1-afaerber@suse.de>
Message-ID: <20170514022429.11555-5-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial device trees for the RTD1295 SoC and the Zidoo X9S TV box.

The CPUs lack the enable-method property because the vendor device tree
uses a custom "rtk-spin-table" method and "psci" did not appear to work.

The UARTs lack the interrupts properties because the vendor device tree
connects them to a custom interrupt controller. earlycon works without.

A list of memory reservations is adopted from v1.2.11 vendor device tree:
0x02200000 can be used for an initrd, 0x01b00000 is audio-related;
ion-related 0x02600000, 0x02c00000 and 0x11000000 are left out;
0x10000000 is used for sharing the U-Boot environment; others remain
to be investigated.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2 -> v3:
 * Adopted SPDX-License-Identifier (Rob)
 * Added ranges for /soc node (Rob)
 * Changed #address-cells and #size-cells to 1 (Rob)
 
 v1 -> v2:
 * Dropped 0x0000000010000000 /memreserve/
 
 arch/arm64/boot/dts/Makefile                      |   1 +
 arch/arm64/boot/dts/realtek/Makefile              |   5 +
 arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts |  42 +++++++
 arch/arm64/boot/dts/realtek/rtd1295.dtsi          | 131 ++++++++++++++++++++++
 4 files changed, 179 insertions(+)
 create mode 100644 arch/arm64/boot/dts/realtek/Makefile
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1295.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 080232b0270e..78f7991a5906 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -14,6 +14,7 @@ dts-dirs += marvell
 dts-dirs += mediatek
 dts-dirs += nvidia
 dts-dirs += qcom
+dts-dirs += realtek
 dts-dirs += renesas
 dts-dirs += rockchip
 dts-dirs += socionext
diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
new file mode 100644
index 000000000000..8521e921e59a
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/Makefile
@@ -0,0 +1,5 @@
+dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts b/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
new file mode 100644
index 000000000000..6efa8091bb30
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
@@ -0,0 +1,42 @@
+/*
+ * Copyright (c) 2016-2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/dts-v1/;
+
+/memreserve/	0x0000000000000000 0x0000000000030000;
+/memreserve/	0x000000000001f000 0x0000000000001000;
+/memreserve/	0x0000000000030000 0x00000000000d0000;
+/memreserve/	0x0000000001b00000 0x00000000004be000;
+/memreserve/	0x0000000001ffe000 0x0000000000004000;
+
+#include "rtd1295.dtsi"
+
+/ {
+	compatible = "zidoo,x9s", "realtek,rtd1295";
+	model = "Zidoo X9S";
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x80000000>;
+	};
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
new file mode 100644
index 000000000000..d8f84666c8ce
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -0,0 +1,131 @@
+/*
+ * Realtek RTD1295 SoC
+ *
+ * Copyright (c) 2016-2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "realtek,rtd1295";
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x0>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x1>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x2>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x3>;
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache {
+			compatible = "cache";
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		tee at 10100000 {
+			reg = <0x10100000 0xf00000>;
+			no-map;
+		};
+	};
+
+	arm-pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13
+			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		/* Exclude up to 2 GiB of RAM */
+		ranges = <0x80000000 0x80000000 0x80000000>;
+
+		uart0: serial at 98007800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x98007800 0x400>,
+			      <0x98007000 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <27000000>;
+			status = "disabled";
+		};
+
+		uart1: serial at 9801b200 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x9801b200 0x100>,
+			      <0x9801b00c 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <432000000>;
+			status = "disabled";
+		};
+
+		uart2: serial at 9801b400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x9801b400 0x100>,
+			      <0x9801b00c 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <432000000>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller at ff011000 {
+			compatible = "arm,gic-400";
+			reg = <0xff011000 0x1000>,
+			      <0xff012000 0x2000>,
+			      <0xff014000 0x2000>,
+			      <0xff016000 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+	};
+};
-- 
2.12.0
