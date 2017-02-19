From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 19 Feb 2017 04:19:59 +0100
Subject: [PATCH 3/4] ARM64: dts: marvell: Add IAP140 and Andromeda Box Edge
In-Reply-To: <20170219032000.4674-1-afaerber@suse.de>
References: <20170219032000.4674-1-afaerber@suse.de>
Message-ID: <20170219032000.4674-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PPI interrupts 11, 10, 9 are guesses, and so are the second two memory
regions of the GIC.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/marvell/Makefile               |   2 +
 .../boot/dts/marvell/iap140-andromeda-box-edge.dts |  70 ++++++++
 arch/arm64/boot/dts/marvell/iap140.dtsi            | 195 +++++++++++++++++++++
 3 files changed, 267 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/iap140-andromeda-box-edge.dts
 create mode 100644 arch/arm64/boot/dts/marvell/iap140.dtsi

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 3e6ce6c..d2046be 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -9,6 +9,8 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-mcbin.dtb
 
+dtb-$(CONFIG_ARCH_PXA) += iap140-andromeda-box-edge.dtb
+
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
 clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/marvell/iap140-andromeda-box-edge.dts b/arch/arm64/boot/dts/marvell/iap140-andromeda-box-edge.dts
new file mode 100644
index 0000000..de01d93
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/iap140-andromeda-box-edge.dts
@@ -0,0 +1,70 @@
+/*
+ * Copyright (c) 2016-2017 Andreas F?rber
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+
+/memreserve/ 0x09000000 0x01000000;
+/memreserve/ 0x0a000000 0x00080000;
+
+#include "iap140.dtsi"
+
+/ {
+	compatible = "mrvl,andromeda-box-edge", "mrvl,iap140";
+	model = "Andromeda Box Edge";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/marvell/iap140.dtsi b/arch/arm64/boot/dts/marvell/iap140.dtsi
new file mode 100644
index 0000000..38acb14
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/iap140.dtsi
@@ -0,0 +1,195 @@
+/*
+ * Copyright (c) 2016-2017 Andreas F?rber
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "mrvl,iap140";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	arm-pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+		             <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+		             <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+		             <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		smmu: iommu at c0010000 {
+			compatible = "arm,mmu-400";
+			reg = <0x0 0xc0010000 0x0 0x10000>;
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		asram: sram at d12a0000 {
+			compatible = "mmio-sram";
+			reg = <0x0 0xd12a0000 0x0 0x10000>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller at d1df9000 {
+			compatible = "arm,gic-400";
+			reg = <0x0 0xd1df9000 0x0 0x1000>,
+			      <0x0 0xd1dfa000 0x0 0x2000>,
+			      <0x0 0xd1dfc000 0x0 0x2000>,
+			      <0x0 0xd1dfe000 0x0 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
+		apb at d4000000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xd4000000 0x0 0x00200000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0xd4000000 0x00200000>;
+
+			pdma: dma-controller at 0 {
+				compatible = "marvell,pdma-1.0";
+				reg = <0x0 0x10000>;
+				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+				#dma-cells = <2>;
+				#dma-channels = <30>;
+			};
+
+			uart0: serial at 17000 {
+				compatible = "mrvl,mmp-uart", "mrvl,pxa-uart";
+				reg = <0x17000 0x1000>;
+				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&pdma 21 1>,
+				       <&pdma 22 1>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			uart1: serial at 18000 {
+				compatible = "mrvl,mmp-uart", "mrvl,pxa-uart";
+				reg = <0x18000 0x1000>;
+				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&pdma 23 1>,
+				       <&pdma 24 1>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			uart2: serial at 36000 {
+				compatible = "mrvl,mmp-uart", "mrvl,pxa-uart";
+				reg = <0x36000 0x1000>;
+				interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&pdma 4 1>,
+				       <&pdma 5 1>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+		};
+
+		axi at d4200000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xd4200000 0x0 0x00200000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0xd4200000 0x00200000>;
+		};
+	};
+};
-- 
2.10.2
