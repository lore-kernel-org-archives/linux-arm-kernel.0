From: carlo@caione.org (Carlo Caione)
Date: Mon, 15 Sep 2014 16:45:01 +0200
Subject: [PATCH 4/6] ARM: meson: dts: add basic Meson/Meson6/Meson6-atv1200
 DTSI/DTS
In-Reply-To: <1410792303-23275-1-git-send-email-carlo@caione.org>
References: <1410792303-23275-1-git-send-email-carlo@caione.org>
Message-ID: <1410792303-23275-5-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Meson6 SoC is produced by Amlogic inc. and it is based on 2 Cortex
A9 and an ARM Mali-400 GPU.
This patch adds two basic DTSI for the preliminary support of Meson and
Meson6 SoCs. Another DTS is also added for supporting the atv1200 board,
produced by Geniatech inc.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/boot/dts/Makefile           |   1 +
 arch/arm/boot/dts/meson.dtsi         | 105 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/meson6-atv1200.dts |  66 ++++++++++++++++++++++
 arch/arm/boot/dts/meson6.dtsi        |  78 ++++++++++++++++++++++++++
 4 files changed, 250 insertions(+)
 create mode 100644 arch/arm/boot/dts/meson.dtsi
 create mode 100644 arch/arm/boot/dts/meson6-atv1200.dts
 create mode 100644 arch/arm/boot/dts/meson6.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b8c5cd3..604acce 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -159,6 +159,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += kirkwood-b3.dtb \
 	kirkwood-ts419-6282.dtb
 dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
 dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
+dtb-$(CONFIG_MACH_MESON6) += meson6-atv1200.dtb
 dtb-$(CONFIG_ARCH_MOXART) += moxart-uc7112lx.dtb
 dtb-$(CONFIG_ARCH_MXC) += \
 	imx25-eukrea-mbimxsd25-baseboard.dtb \
diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
new file mode 100644
index 0000000..55feb14
--- /dev/null
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -0,0 +1,105 @@
+/*
+ * Copyright 2014 Carlo Caione <carlo@caione.org>
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
+ *     You should have received a copy of the GNU General Public
+ *     License along with this library; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
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
+/include/ "skeleton.dtsi"
+
+/ {
+	interrupt-parent = <&gic>;
+
+	gic: interrupt-controller at c4301000 {
+		compatible = "arm,cortex-a9-gic";
+		reg = <0xc4301000 0x1000>,
+		      <0xc4300100 0x0100>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+	};
+
+	timer at c1109940 {
+		compatible = "amlogic,meson6-timer";
+		reg = <0xc1109940 0x14>;
+		interrupts = <0 10 1>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		uart_AO: serial at c81004c0 {
+			compatible = "amlogic,meson-uart";
+			reg = <0xc81004c0 0x14>;
+			interrupts = <0 90 1>;
+			clocks = <&clk81>;
+			status = "disabled";
+		};
+
+		uart_A: serial at c81084c0 {
+			compatible = "amlogic,meson-uart";
+			reg = <0xc81084c0 0x14>;
+			interrupts = <0 90 1>;
+			clocks = <&clk81>;
+			status = "disabled";
+		};
+
+		uart_B: serial at c81084dc {
+			compatible = "amlogic,meson-uart";
+			reg = <0xc81084dc 0x14>;
+			interrupts = <0 90 1>;
+			clocks = <&clk81>;
+			status = "disabled";
+		};
+
+		uart_C: serial at c8108700 {
+			compatible = "amlogic,meson-uart";
+			reg = <0xc8108700 0x14>;
+			interrupts = <0 90 1>;
+			clocks = <&clk81>;
+			status = "disabled";
+		};
+	};
+}; /* end of / */
diff --git a/arch/arm/boot/dts/meson6-atv1200.dts b/arch/arm/boot/dts/meson6-atv1200.dts
new file mode 100644
index 0000000..dc2541f
--- /dev/null
+++ b/arch/arm/boot/dts/meson6-atv1200.dts
@@ -0,0 +1,66 @@
+/*
+ * Copyright 2014 Carlo Caione <carlo@caione.org>
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
+ *     You should have received a copy of the GNU General Public
+ *     License along with this library; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
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
+/include/ "meson6.dtsi"
+
+/ {
+	model = "Geniatech ATV1200";
+	compatible = "geniatech,atv1200";
+
+	aliases {
+		serial0 = &uart_AO;
+	};
+
+	memory {
+		reg = <0x40000000 0x80000000>;
+	};
+};
+
+&uart_AO {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
new file mode 100644
index 0000000..4ba4912
--- /dev/null
+++ b/arch/arm/boot/dts/meson6.dtsi
@@ -0,0 +1,78 @@
+/*
+ * Copyright 2014 Carlo Caione <carlo@caione.org>
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
+ *     You should have received a copy of the GNU General Public
+ *     License along with this library; if not, write to the Free
+ *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ *     MA 02110-1301 USA
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
+/include/ "meson.dtsi"
+
+/ {
+	model = "Amlogic Meson6 SoC";
+	compatible = "amlogic,meson6";
+
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x200>;
+		};
+
+		cpu at 201 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x201>;
+		};
+	};
+
+	clk81: clk at 0 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <200000000>;
+	};
+}; /* end of / */
-- 
1.9.1
