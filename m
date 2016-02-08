From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon,  8 Feb 2016 10:11:38 +0100
Subject: [PATCH 2/3] arm64: dts: add the Alpine v2 EVP
In-Reply-To: <1454922699-16785-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1454922699-16785-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1454922699-16785-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the initial support for the Alpine v2 EVP board from
Annapurna Labs (Amazon).

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Barak Wasserstrom <barak@annapurnalabs.com>
Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
---
 arch/arm64/boot/dts/Makefile             |   1 +
 arch/arm64/boot/dts/al/Makefile          |   5 +
 arch/arm64/boot/dts/al/alpine-v2-evp.dts |  46 +++++++
 arch/arm64/boot/dts/al/alpine-v2.dtsi    | 221 +++++++++++++++++++++++++++++++
 4 files changed, 273 insertions(+)
 create mode 100644 arch/arm64/boot/dts/al/Makefile
 create mode 100644 arch/arm64/boot/dts/al/alpine-v2-evp.dts
 create mode 100644 arch/arm64/boot/dts/al/alpine-v2.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index f832b8a7453a..fd80617a9c6f 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -1,3 +1,4 @@
+dts-dirs += al
 dts-dirs += altera
 dts-dirs += amd
 dts-dirs += apm
diff --git a/arch/arm64/boot/dts/al/Makefile b/arch/arm64/boot/dts/al/Makefile
new file mode 100644
index 000000000000..8a6cde4f9b23
--- /dev/null
+++ b/arch/arm64/boot/dts/al/Makefile
@@ -0,0 +1,5 @@
+dtb-$(CONFIG_ARCH_ALPINE)	+= alpine-v2-evp.dtb
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/al/alpine-v2-evp.dts b/arch/arm64/boot/dts/al/alpine-v2-evp.dts
new file mode 100644
index 000000000000..3e3080fa45e4
--- /dev/null
+++ b/arch/arm64/boot/dts/al/alpine-v2-evp.dts
@@ -0,0 +1,46 @@
+/*
+ * Copyright 2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * Antoine Tenart <antoine.tenart@free-electrons.com>
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include "alpine-v2.dtsi"
+
+/ {
+	model = "Annapurna Labs Alpine v2 EVP";
+	compatible = "al,alpine-v2-evp", "al,alpine-v2";
+
+	chosen {
+		stdout-path = "console0:115200n8";
+	};
+};
+
+&uart0 { status = "okay"; };
diff --git a/arch/arm64/boot/dts/al/alpine-v2.dtsi b/arch/arm64/boot/dts/al/alpine-v2.dtsi
new file mode 100644
index 000000000000..eb7a03b71456
--- /dev/null
+++ b/arch/arm64/boot/dts/al/alpine-v2.dtsi
@@ -0,0 +1,221 @@
+/*
+ * Copyright 2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * Antoine Tenart <antoine.tenart@free-electrons.com>
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	model = "Annapurna Labs Alpine v2";
+	compatible = "al,alpine-v2";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-a57", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a57", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+		};
+
+		cpu at 2 {
+			compatible = "arm,cortex-a57", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+		};
+
+		cpu at 3 {
+			compatible = "arm,cortex-a57", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2", "arm,psci";
+		method = "smc";
+		cpu_on = <0x84000003>;
+	};
+
+	sbclk: sbclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1000000>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		interrupt-parent = <&gic>;
+		ranges;
+
+		timer {
+			compatible = "arm,armv8-timer";
+			interrupts = <GIC_PPI 0xd 0xff08>,
+				     <GIC_PPI 0xe 0xff08>,
+				     <GIC_PPI 0xb 0xff08>,
+				     <GIC_PPI 0xa 0xff08>;
+		};
+
+		pmu {
+			compatible = "arm,armv8-pmuv3";
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		gic: gic at f0100000 {
+			compatible = "arm,gic-v3";
+			reg = <0x0 0xf0200000 0x0 0x10000>,	/* GIC Dist */
+			      <0x0 0xf0280000 0x0 0x200000>,	/* GICR */
+			      <0x0 0xf0100000 0x0 0x2000>;	/* GICC */
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
+		pcie-internal at 0xfbc00000 {
+			compatible = "pci-host-ecam-generic";
+			device_type = "pci";
+			#size-cells = <2>;
+			#address-cells = <3>;
+			#interrupt-cells = <1>;
+			reg = <0x0 0xfbc00000 0x0 0x100000>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+			/* add legacy interrupts for SATA only */
+			interrupt-map = <0x4000 0 0 1 &gic 0 53 4>,
+					<0x4800 0 0 1 &gic 0 54 4>;
+			/* 32 bit non prefetchable memory space */
+			ranges = <0x2000000 0x0 0xfe000000 0x0 0xfe000000 0x0 0x1000000>;
+			bus-range = <0x00 0x00>;
+		};
+
+		uart0: uart at fd883000 {
+			compatible = "ns16550a";
+			device_type = "serial";
+			reg = <0x0 0xfd883000 0x0 0x1000>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <500000000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart1: uart at fd884000 {
+			compatible = "ns16550a";
+			device_type = "serial";
+			reg = <0x0 0xfd884000 0x0 0x1000>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <500000000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart2: uart at fd885000 {
+			compatible = "ns16550a";
+			device_type = "serial";
+			reg = <0x0 0xfd885000 0x0 0x1000>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <500000000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart3: uart at fd886000 {
+			compatible = "ns16550a";
+			device_type = "serial";
+			reg = <0x0 0xfd886000 0x0 0x1000>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <500000000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		timer0: timer at fd890000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x0 0xfd890000 0x0 0x1000>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sbclk>;
+		};
+
+		timer1: timer at fd891000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x0 0xfd891000 0x0 0x1000>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sbclk>;
+			status = "disabled";
+		};
+
+		timer2: timer at fd892000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x0 0xfd892000 0x0 0x1000>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sbclk>;
+			status = "disabled";
+		};
+
+		timer3: timer at fd893000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x0 0xfd893000 0x0 0x1000>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sbclk>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.7.0
