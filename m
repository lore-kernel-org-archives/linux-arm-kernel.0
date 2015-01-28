From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 29 Jan 2015 00:04:10 +0200
Subject: [PATCH v4 1/2] ARM: digicolor: add minimal device tree description
Message-ID: <8b74c50aebadc781a5aa8061f7639c9164433e84.1422481097.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cx92755.dtsi describes CX92755 on chip peripherals. cx92755_equinox.dts
describes the Equinox evaluation board for the CX92755 SoC.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
This is the only remaining part of the "ARM: Conexant Digicolor CX92755 SoC 
support" series. See v3 changelog at 
http://article.gmane.org/gmane.linux.kernel/1865896.

v4:
   * Rename conexant_equinox.dts to cx92755_equinox.dts which is closer to 
     common practice (Olof Johansson)

   * Add a syscon node; this is now required for the interrupt controller

   * Decrease the registers range in the interrupt controller node to just the 
     IC registers range. We now use syscon to access the global UC_IRQ_CONTROL 
     register.

   * Rename the interrupt controller node to "interrupt-controller" as per 
     ePAPR

 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/cx92755.dtsi        | 113 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/cx92755_equinox.dts |  74 ++++++++++++++++++++++
 3 files changed, 188 insertions(+)
 create mode 100644 arch/arm/boot/dts/cx92755.dtsi
 create mode 100644 arch/arm/boot/dts/cx92755_equinox.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 91bd5bd62857..71c69a271791 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -75,6 +75,7 @@ dtb-$(CONFIG_ARCH_BRCMSTB) += \
 	bcm7445-bcm97445svmb.dtb
 dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
 	da850-evm.dtb
+dtb-$(CONFIG_ARCH_DIGICOLOR) += cx92755_equinox.dtb
 dtb-$(CONFIG_ARCH_EFM32) += efm32gg-dk3750.dtb
 dtb-$(CONFIG_ARCH_EXYNOS) += exynos3250-monk.dtb \
 	exynos3250-rinato.dtb \
diff --git a/arch/arm/boot/dts/cx92755.dtsi b/arch/arm/boot/dts/cx92755.dtsi
new file mode 100644
index 000000000000..490c08075e67
--- /dev/null
+++ b/arch/arm/boot/dts/cx92755.dtsi
@@ -0,0 +1,113 @@
+/*
+ * Device Tree Include file for the Conexant Digicolor CX92755 SoC
+ *
+ * Author: Baruch Siach <baruch@tkos.co.il>
+ *
+ *  Copyright (C) 2014 Paradox Innovation Ltd.
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
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
+#include "skeleton.dtsi"
+
+/ {
+	compatible = "cnxt,cx92755";
+
+	interrupt-parent = <&intc>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a8";
+			reg = <0x0>;
+		};
+	};
+
+	main_clk: main_clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency  = <200000000>;
+	};
+
+	intc: interrupt-controller at f0000040 {
+		compatible = "cnxt,cx92755-ic";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0xf0000040 0x40>;
+		syscon = <&uc_regs>;
+	};
+
+	timer at f0000fc0 {
+		compatible = "cnxt,cx92755-timer";
+		reg = <0xf0000fc0 0x40>;
+		interrupts = <19>, <31>, <34>, <35>, <52>, <53>, <54>, <55>;
+		clocks = <&main_clk>;
+	};
+
+	uc_regs: syscon at f00003a0 {
+		compatible = "cnxt,cx92755-uc", "syscon";
+		reg = <0xf00003a0 0x10>;
+	};
+
+	uart0: uart at f0000740 {
+		compatible = "cnxt,cx92755-usart";
+		reg = <0xf0000740 0x20>;
+		clocks = <&main_clk>;
+		interrupts = <44>;
+		status = "disabled";
+	};
+
+	uart1: uart at f0000760 {
+		compatible = "cnxt,cx92755-usart";
+		reg = <0xf0000760 0x20>;
+		clocks = <&main_clk>;
+		interrupts = <45>;
+		status = "disabled";
+	};
+
+	uart2: uart at f0000780 {
+		compatible = "cnxt,cx92755-usart";
+		reg = <0xf0000780 0x20>;
+		clocks = <&main_clk>;
+		interrupts = <46>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm/boot/dts/cx92755_equinox.dts b/arch/arm/boot/dts/cx92755_equinox.dts
new file mode 100644
index 000000000000..f33bf5635d47
--- /dev/null
+++ b/arch/arm/boot/dts/cx92755_equinox.dts
@@ -0,0 +1,74 @@
+/*
+ * Device Tree file for the Conexant Equinox CX92755 EVK
+ *
+ * Author: Baruch Siach <baruch@tkos.co.il>
+ *
+ *  Copyright (C) 2014 Paradox Innovation Ltd.
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
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
+#include "cx92755.dtsi"
+
+/ {
+	model = "Conexant Equinox CX92755 EVK";
+	compatible = "cnxt,equinox", "cnxt,cx92755";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+
+	memory at 0 {
+		reg = <0 0x8000000>;
+		device_type = "memory";
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &uart0;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.1.4
