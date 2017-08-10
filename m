From: hannah@marvell.com (hannah at marvell.com)
Date: Thu, 10 Aug 2017 14:28:54 +0300
Subject: [PATCH v2] arm64: dts: marvell: add Device Tree files for Armada-8KP
Message-ID: <1502364534-20732-1-git-send-email-hannah@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanna Hawa <hannah@marvell.com>

This commit adds the base Device Tree files for the Armada 8KPlus.
The Armada 8KP SoCs include several hardware blocks, and this
commit only adds support for the AP810 block, that contains the CPU
core and basic peripherals.

AP810 is a high-performance die, includes octal core application
processor based ARMv8-A architecture, two standard high speed DDR4
interface, and GIC-600 interrupt controller.
AP810 Built as part of Marvell?s MoChi AP family products.

Armada-8080 (8KPlus family), include an AP810 block that contains
the CPU core and basic peripherals.

This commit creates the following hierarchy:
 * armada-ap810-ap0.dtsi - definitions common to AP810
 	* armada-ap810-ap0-octa-core.dtsi - description of the octa cores
		* armada-8080.dtsi - description of the 8080 SoC
			* armada-8080-db.dts - description of the 8080 board

Change-Id: I34ff3dc5d686b048477d953278622d74eaef843d
Signed-off-by: Hanna Hawa <hannah@marvell.com>
---

Notes:
	Changes in v2:
	- remove affininty mask for PPI
	- add missing regions in GIC address space (GICC, GICH, and GICV)

 .../devicetree/bindings/arm/marvell/armada-8kp.txt |  15 ++
 arch/arm64/boot/dts/marvell/Makefile               |   1 +
 arch/arm64/boot/dts/marvell/armada-8080-db.dts     |  67 +++++++++
 arch/arm64/boot/dts/marvell/armada-8080.dtsi       |  53 +++++++
 .../dts/marvell/armada-ap810-ap0-octa-core.dtsi    | 104 +++++++++++++
 arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi  | 163 +++++++++++++++++++++
 6 files changed, 403 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-8kp.txt
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8080-db.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8080.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-ap810-ap0-octa-core.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-8kp.txt b/Documentation/devicetree/bindings/arm/marvell/armada-8kp.txt
new file mode 100644
index 0000000..f3e9624
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-8kp.txt
@@ -0,0 +1,15 @@
+Marvell Armada 8KPlus Platforms Device Tree Bindings
+----------------------------------------------------
+
+Boards using a SoC of the Marvell Armada 8KP families must carry
+the following root node property:
+
+ - compatible, with one of the following values:
+
+   - "marvell,armada-8080", "marvell,armada-ap810-octa", "marvell,armada-ap810"
+     when the SoC being used is the Armada 8080
+
+Example:
+
+compatible = "marvell,armada-8080-db", "marvell,armada-8080",
+	     "marvell,armada-ap810-octa", "marvell,armada-ap810"
diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 3e6ce6c..6cff81e 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-mcbin.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-8080-db.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/marvell/armada-8080-db.dts b/arch/arm64/boot/dts/marvell/armada-8080-db.dts
new file mode 100644
index 0000000..707af83
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-8080-db.dts
@@ -0,0 +1,67 @@
+/*
+ * Copyright (C) 2017 Marvell Technology Group Ltd.
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPLv2 or the X11 license, at your option. Note that this dual
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
+/*
+ * Device Tree file for Marvell Armada-8080 Development board platform
+ */
+
+#include "armada-8080.dtsi"
+
+/ {
+	model = "Marvell 8080 board";
+	compatible = "marvell,armada-8080-db", "marvell,armada-8080",
+		     "marvell,armada-ap810-octa", "marvell,armada-ap810";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 00000000 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+};
+
+&uart0_ap0 {
+	clock-frequency = <384000>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-8080.dtsi b/arch/arm64/boot/dts/marvell/armada-8080.dtsi
new file mode 100644
index 0000000..d5535b7
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-8080.dtsi
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2017 Marvell Technology Group Ltd.
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPLv2 or the X11 license, at your option. Note that this dual
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
+/*
+ * Device Tree file for Marvell Armada-8080 SoC, made of an AP810 OCTA.
+ */
+
+#include "armada-ap810-ap0-octa-core.dtsi"
+
+/ {
+	model = "Marvell 8080 board";
+	compatible = "marvell,armada-8080", "marvell,armada-ap810-octa",
+				"marvell,armada-ap810";
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-ap810-ap0-octa-core.dtsi b/arch/arm64/boot/dts/marvell/armada-ap810-ap0-octa-core.dtsi
new file mode 100644
index 0000000..bf1b22b
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-ap810-ap0-octa-core.dtsi
@@ -0,0 +1,104 @@
+/*
+ * Copyright (C) 2017 Marvell Technology Group Ltd.
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPLv2 or the X11 license, at your option. Note that this dual
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
+/*
+ * Device Tree file for Marvell Armada AP810 OCTA cores.
+ */
+
+#include "armada-ap810-ap0.dtsi"
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "marvell,armada-ap810-octa";
+
+		cpu at 000 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72", "arm,armv8";
+			reg = <0x000>;
+			enable-method = "psci";
+		};
+		cpu at 001 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72", "arm,armv8";
+			reg = <0x001>;
+			enable-method = "psci";
+		};
+		cpu at 100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72", "arm,armv8";
+			reg = <0x100>;
+			enable-method = "psci";
+		};
+		cpu at 101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72", "arm,armv8";
+			reg = <0x101>;
+			enable-method = "psci";
+		};
+		cpu at 200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72", "arm,armv8";
+			reg = <0x200>;
+			enable-method = "psci";
+		};
+		cpu at 201 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72", "arm,armv8";
+			reg = <0x201>;
+			enable-method = "psci";
+		};
+		cpu at 300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72", "arm,armv8";
+			reg = <0x300>;
+			enable-method = "psci";
+		};
+		cpu at 301 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72", "arm,armv8";
+			reg = <0x301>;
+			enable-method = "psci";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi b/arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi
new file mode 100644
index 0000000..7e6f039
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi
@@ -0,0 +1,163 @@
+/*
+ * Copyright (C) 2017 Marvell Technology Group Ltd.
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPLv2 or the X11 license, at your option. Note that this dual
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
+/*
+ * Device Tree file for Marvell Armada AP810.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/dts-v1/;
+
+/ {
+	model = "Marvell Armada AP810";
+	compatible = "marvell,armada-ap810";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart0_ap0;
+		serial1 = &uart1_ap0;
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	ap810-ap0 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		config-space at e8000000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			ranges = <0x0 0x0 0xe8000000 0x4000000>;
+			interrupt-parent = <&gic>;
+
+			gic: interrupt-controller at 3000000 {
+				compatible = "arm,gic-v3";
+				#interrupt-cells = <3>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				interrupt-controller;
+				interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
+
+				reg = <0x3000000 0x10000>,	/* GICD */
+				      <0x3060000 0x100000>,	/* GICR */
+				      <0x00c0000 0x2000>,	/* GICC */
+				      <0x00d0000 0x1000>,	/* GICH */
+				      <0x00e0000 0x2000>;	/* GICV */
+
+				gic_its_ap0: interrupt-controller at 3040000 {
+					compatible = "arm,gic-v3-its";
+					msi-controller;
+					#msi-cells = <1>;
+					reg = <0x3040000 0x20000>;
+				};
+			};
+
+			timer {
+				compatible = "arm,armv8-timer";
+				interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+					     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+					     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+					     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+			};
+
+			xor at 400000 {
+				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
+				reg = <0x400000 0x1000>,
+				      <0x410000 0x1000>;
+				msi-parent = <&gic_its_ap0 0xa0>;
+				dma-coherent;
+			};
+
+			xor at 420000 {
+				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
+				reg = <0x420000 0x1000>,
+				      <0x430000 0x1000>;
+				msi-parent = <&gic_its_ap0 0xa1>;
+				dma-coherent;
+			};
+
+			xor at 440000 {
+				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
+				reg = <0x440000 0x1000>,
+				      <0x450000 0x1000>;
+				msi-parent = <&gic_its_ap0 0xa2>;
+				dma-coherent;
+			};
+
+			xor at 460000 {
+				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
+				reg = <0x460000 0x1000>,
+				      <0x470000 0x1000>;
+				msi-parent = <&gic_its_ap0 0xa3>;
+				dma-coherent;
+			};
+
+			uart0_ap0: serial at 512000 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x512000 0x100>;
+				reg-shift = <2>;
+				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+				reg-io-width = <1>;
+				status = "disabled";
+			};
+
+			uart1_ap0: serial at 512100 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x512100 0x100>;
+				reg-shift = <2>;
+				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+				reg-io-width = <1>;
+				status = "disabled";
+			};
+		};
+	};
+};
-- 
1.9.1
