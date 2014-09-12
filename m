From: rric@kernel.org (Robert Richter)
Date: Fri, 12 Sep 2014 19:49:44 +0200
Subject: [PATCH v3 1/4] arm64, thunder: Add initial dts for Cavium Thunder SoC
In-Reply-To: <1410544187-15876-1-git-send-email-rric@kernel.org>
References: <1410544187-15876-1-git-send-email-rric@kernel.org>
Message-ID: <1410544187-15876-2-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

Add initial device tree nodes for Cavium Thunder SoCs with support of
48 cores and gicv3. The dtsi file requires further changes, esp. for
pci, gicv3-its and smmu. This changes will be added later together
with the device drivers.

Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/boot/dts/Makefile          |   2 +
 arch/arm64/boot/dts/thunder-88xx.dts  |  67 ++++++
 arch/arm64/boot/dts/thunder-88xx.dtsi | 401 ++++++++++++++++++++++++++++++++++
 3 files changed, 470 insertions(+)
 create mode 100644 arch/arm64/boot/dts/thunder-88xx.dts
 create mode 100644 arch/arm64/boot/dts/thunder-88xx.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index c52bdb051f66..c2e8e4661a90 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -1,6 +1,8 @@
 dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
 dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
 
+dtb-y += thunder-88xx.dtb
+
 targets += dtbs
 targets += $(dtb-y)
 
diff --git a/arch/arm64/boot/dts/thunder-88xx.dts b/arch/arm64/boot/dts/thunder-88xx.dts
new file mode 100644
index 000000000000..800ba65991f7
--- /dev/null
+++ b/arch/arm64/boot/dts/thunder-88xx.dts
@@ -0,0 +1,67 @@
+/*
+ * Cavium Thunder DTS file - Thunder board description
+ *
+ * Copyright (C) 2014, Cavium Inc.
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
+
+/include/ "thunder-88xx.dtsi"
+
+/ {
+	model = "Cavium ThunderX CN88XX board";
+	compatible = "cavium,thunder-88xx";
+
+	aliases {
+		serial0 = &uaa0;
+		serial1 = &uaa1;
+	};
+
+	memory at 00000000 {
+		device_type = "memory";
+		reg = <0x0 0x00000000 0x0 0x80000000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/thunder-88xx.dtsi b/arch/arm64/boot/dts/thunder-88xx.dtsi
new file mode 100644
index 000000000000..d8c0bdc51882
--- /dev/null
+++ b/arch/arm64/boot/dts/thunder-88xx.dtsi
@@ -0,0 +1,401 @@
+/*
+ * Cavium Thunder DTS file - Thunder SoC description
+ *
+ * Copyright (C) 2014, Cavium Inc.
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
+/ {
+	compatible = "cavium,thunder-88xx";
+	interrupt-parent = <&gic0>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu at 000 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x000>;
+			enable-method = "psci";
+		};
+		cpu at 001 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x001>;
+			enable-method = "psci";
+		};
+		cpu at 002 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x002>;
+			enable-method = "psci";
+		};
+		cpu at 003 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x003>;
+			enable-method = "psci";
+		};
+		cpu at 004 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x004>;
+			enable-method = "psci";
+		};
+		cpu at 005 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x005>;
+			enable-method = "psci";
+		};
+		cpu at 006 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x006>;
+			enable-method = "psci";
+		};
+		cpu at 007 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x007>;
+			enable-method = "psci";
+		};
+		cpu at 008 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x008>;
+			enable-method = "psci";
+		};
+		cpu at 009 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x009>;
+			enable-method = "psci";
+		};
+		cpu at 00a {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x00a>;
+			enable-method = "psci";
+		};
+		cpu at 00b {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x00b>;
+			enable-method = "psci";
+		};
+		cpu at 00c {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x00c>;
+			enable-method = "psci";
+		};
+		cpu at 00d {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x00d>;
+			enable-method = "psci";
+		};
+		cpu at 00e {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x00e>;
+			enable-method = "psci";
+		};
+		cpu at 00f {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x00f>;
+			enable-method = "psci";
+		};
+		cpu at 100 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+		};
+		cpu at 101 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x101>;
+			enable-method = "psci";
+		};
+		cpu at 102 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x102>;
+			enable-method = "psci";
+		};
+		cpu at 103 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x103>;
+			enable-method = "psci";
+		};
+		cpu at 104 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x104>;
+			enable-method = "psci";
+		};
+		cpu at 105 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x105>;
+			enable-method = "psci";
+		};
+		cpu at 106 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x106>;
+			enable-method = "psci";
+		};
+		cpu at 107 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x107>;
+			enable-method = "psci";
+		};
+		cpu at 108 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x108>;
+			enable-method = "psci";
+		};
+		cpu at 109 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x109>;
+			enable-method = "psci";
+		};
+		cpu at 10a {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10a>;
+			enable-method = "psci";
+		};
+		cpu at 10b {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10b>;
+			enable-method = "psci";
+		};
+		cpu at 10c {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10c>;
+			enable-method = "psci";
+		};
+		cpu at 10d {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10d>;
+			enable-method = "psci";
+		};
+		cpu at 10e {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10e>;
+			enable-method = "psci";
+		};
+		cpu at 10f {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x10f>;
+			enable-method = "psci";
+		};
+		cpu at 200 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x200>;
+			enable-method = "psci";
+		};
+		cpu at 201 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x201>;
+			enable-method = "psci";
+		};
+		cpu at 202 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x202>;
+			enable-method = "psci";
+		};
+		cpu at 203 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x203>;
+			enable-method = "psci";
+		};
+		cpu at 204 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x204>;
+			enable-method = "psci";
+		};
+		cpu at 205 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x205>;
+			enable-method = "psci";
+		};
+		cpu at 206 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x206>;
+			enable-method = "psci";
+		};
+		cpu at 207 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x207>;
+			enable-method = "psci";
+		};
+		cpu at 208 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x208>;
+			enable-method = "psci";
+		};
+		cpu at 209 {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x209>;
+			enable-method = "psci";
+		};
+		cpu at 20a {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x20a>;
+			enable-method = "psci";
+		};
+		cpu at 20b {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x20b>;
+			enable-method = "psci";
+		};
+		cpu at 20c {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x20c>;
+			enable-method = "psci";
+		};
+		cpu at 20d {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x20d>;
+			enable-method = "psci";
+		};
+		cpu at 20e {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x20e>;
+			enable-method = "psci";
+		};
+		cpu at 20f {
+			device_type = "cpu";
+			compatible = "cavium,thunder", "arm,armv8";
+			reg = <0x0 0x20f>;
+			enable-method = "psci";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <1 13 0xff01>,
+		             <1 14 0xff01>,
+		             <1 11 0xff01>,
+		             <1 10 0xff01>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		refclk50mhz: refclk50mhz {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <50000000>;
+			clock-output-names = "refclk50mhz";
+		};
+
+		gic0: interrupt-controller at 8010,00000000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x8010 0x00000000 0x0 0x010000>, /* GICD */
+			      <0x8010 0x80000000 0x0 0x600000>; /* GICR */
+			interrupts = <1 9 0xf04>;
+		};
+
+		uaa0: serial at 87e0,24000000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x87e0 0x24000000 0x0 0x1000>;
+			interrupts = <1 21 4>;
+			clocks = <&refclk50mhz>;
+			clock-names = "apb_pclk";
+		};
+
+		uaa1: serial at 87e0,25000000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x87e0 0x25000000 0x0 0x1000>;
+			interrupts = <1 22 4>;
+			clocks = <&refclk50mhz>;
+			clock-names = "apb_pclk";
+		};
+	};
+};
-- 
2.1.0
