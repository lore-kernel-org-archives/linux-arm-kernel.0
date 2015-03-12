From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Thu, 12 Mar 2015 13:53:12 +0200
Subject: [PATCH v6 5/6] ARM: dts: Alpine platform devicetree
Message-ID: <55017e28.Jzshpkksg8eI/q72%tsahee@annapurnalabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces devicetree for the Alpine platform, and
for a development board based on the same platform.

Signed-off-by: Barak Wasserstrom <barak@annapurnalabs.com>
Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/Makefile      |   3 +
 arch/arm/boot/dts/alpine-db.dts |  35 ++++++++++
 arch/arm/boot/dts/alpine.dtsi   | 141 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 179 insertions(+)
 create mode 100644 arch/arm/boot/dts/alpine-db.dts
 create mode 100644 arch/arm/boot/dts/alpine.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 2a45218..0eb23a0 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -2,6 +2,9 @@ ifeq ($(CONFIG_OF),y)
 
 dtb-$(CONFIG_MACH_ASM9260) += \
 	alphascale-asm9260-devkit.dtb
+
+dtb-$(CONFIG_ARCH_ALPINE) += alpine_db.dtb
+
 # Keep at91 dtb files sorted alphabetically for each SoC
 dtb-$(CONFIG_SOC_SAM_V4_V5) += \
 	at91rm9200ek.dtb \
diff --git a/arch/arm/boot/dts/alpine-db.dts b/arch/arm/boot/dts/alpine-db.dts
new file mode 100644
index 0000000..dfb5a08
--- /dev/null
+++ b/arch/arm/boot/dts/alpine-db.dts
@@ -0,0 +1,35 @@
+/*
+ * Copyright 2015 Annapurna Labs Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * Alternatively, redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following conditions
+ * are met:
+ *
+ *   *   Redistributions of source code must retain the above copyright notice,
+ *       this list of conditions and the following disclaimer.
+ *
+ *   *   Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in
+ *       the documentation and/or other materials provided with the
+ *       distribution.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+/dts-v1/;
+
+#include "alpine.dtsi"
+
+/ {
+	model = "Annapurna Labs Alpine Dev Board";
+	/* no need for anything outside SOC */
+};
+
diff --git a/arch/arm/boot/dts/alpine.dtsi b/arch/arm/boot/dts/alpine.dtsi
new file mode 100644
index 0000000..519f58c
--- /dev/null
+++ b/arch/arm/boot/dts/alpine.dtsi
@@ -0,0 +1,141 @@
+/*
+ * Copyright 2015 Annapurna Labs Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * Alternatively, redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following conditions
+ * are met:
+ *
+ *   *   Redistributions of source code must retain the above copyright notice,
+ *       this list of conditions and the following disclaimer.
+ *
+ *   *   Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in
+ *       the documentation and/or other materials provided with the
+ *       distribution.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "skeleton64.dtsi"
+
+/ {
+	/* SOC compatibility */
+	compatible = "al,alpine";
+
+	/* CPU Configuration */
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		enable-method = "al,alpine-smp";
+
+		cpu at 0 {
+			compatible = "arm,cortex-a15";
+			device_type = "cpu";
+			reg = <0>;
+			clock-frequency = <0>; /* Filled by loader */
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a15";
+			device_type = "cpu";
+			reg = <1>;
+			clock-frequency = <0>; /* Filled by loader */
+		};
+
+		cpu at 2 {
+			compatible = "arm,cortex-a15";
+			device_type = "cpu";
+			reg = <2>;
+			clock-frequency = <0>; /* Filled by loader */
+		};
+
+		cpu at 3 {
+			compatible = "arm,cortex-a15";
+			device_type = "cpu";
+			reg = <3>;
+			clock-frequency = <0>; /* Filled by loader */
+		};
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		arch-timer {
+			compatible = "arm,cortex-a15-timer",
+				     "arm,armv7-timer";
+			interrupts =
+				<GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+			clock-frequency = <0>; /* Filled by loader */
+		};
+
+		/* Interrupt Controller */
+		gic: gic at fb001000 {
+			compatible = "arm,cortex-a15-gic";
+			#interrupt-cells = <3>;
+			#size-cells = <0>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0xfb001000 0x0 0x1000>,
+			      <0x0 0xfb002000 0x0 0x2000>,
+			      <0x0 0xfb004000 0x0 0x1000>,
+			      <0x0 0xfb006000 0x0 0x2000>;
+			interrupts =
+				<GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		/* CPU Resume registers */
+		cpu-resume at fbff5ec0 {
+			compatible = "al,alpine-cpu-resume";
+			reg = <0x0 0xfbff5ec0 0x0 0x30>;
+		};
+
+		/* North Bridge Service Registers */
+		sysfabric-service at fb070000 {
+			compatible = "al,alpine-sysfabric-service", "syscon";
+			reg = <0x0 0xfb070000 0x0 0x10000>;
+		};
+
+		/* Performance Monitor Unit */
+		pmu {
+			compatible = "arm,cortex-a15-pmu";
+			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		uart0:uart at fd883000 {
+			compatible = "ns16550a";
+			reg = <0x0 0xfd883000 0x0 0x1000>;
+			clock-frequency = <0>; /* Filled by loader */
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+		uart1:uart at 0xfd884000 {
+			compatible = "ns16550a";
+			reg = <0x0 0xfd884000 0x0 0x1000>;
+			clock-frequency = <0>; /* Filled by loader */
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+	};
+};
-- 
1.9.1
