From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 27 Dec 2016 01:11:55 +0800
Subject: [PATCH 5/6] arm64: dts: allwinner: add Allwinner H5 .dtsi
In-Reply-To: <20161226171156.11605-1-icenowy@aosc.xyz>
References: <20161226171156.11605-1-icenowy@aosc.xyz>
Message-ID: <20161226171156.11605-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

The Allwinner H5 SoC is pin-compatible to the H3 SoC, but uses
Cortex-A53 cores instead.
Based on the now shared base .dtsi describing the common peripherals
describe the H5 specific nodes on top of that.
That symlinks in the sun8i-h3-h5.dtsi from the arch/arm tree.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
[Icenowy: remove H5 mmc compatible (seems equal to A64), add H5 pinctrl
 compatible, and changes for my h3-h5 dtsi refactor, commit message
 change to met new arm64 naming scheme]
Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi   | 143 +++++++++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun8i-h3-h5.dtsi |   1 +
 2 files changed, 144 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
 create mode 120000 arch/arm64/boot/dts/allwinner/sun8i-h3-h5.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
new file mode 100644
index 000000000000..2cc372121f60
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -0,0 +1,143 @@
+/*
+ * Copyright (C) 2016 ARM Ltd.
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
+#include <dt-bindings/clock/sun50i-h5-ccu.h>
+#include <dt-bindings/reset/sun50i-h5-ccu.h>
+#include "sun8i-h3-h5.dtsi"
+
+/ {
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <0>;
+			enable-method = "psci";
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <1>;
+			enable-method = "psci";
+		};
+
+		cpu at 2 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <2>;
+			enable-method = "psci";
+		};
+
+		cpu at 3 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			device_type = "cpu";
+			reg = <3>;
+			enable-method = "psci";
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	soc {
+		mmc at 01c0f000 {
+			compatible = "allwinner,sun50i-a64-mmc",
+				     "allwinner,sun5i-a13-mmc";
+			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
+			clock-names = "ahb", "mmc";
+		};
+
+		mmc at 01c10000 {
+			compatible = "allwinner,sun50i-a64-mmc",
+				     "allwinner,sun5i-a13-mmc";
+			clocks = <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
+			clock-names = "ahb", "mmc";
+		};
+
+		mmc at 01c11000 {
+			compatible = "allwinner,sun50i-a64-mmc",
+				     "allwinner,sun5i-a13-mmc";
+			clocks = <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
+			clock-names = "ahb", "mmc";
+		};
+
+		clock at 01c20000 {
+			compatible = "allwinner,sun50i-h5-ccu",
+				     "allwinner,sun8i-h3-ccu";
+		};
+
+		pinctrl at 01c20800 {
+			compatible = "allwinner,sun50i-h5-pinctrl",
+				     "allwinner,sun8i-h3-pinctrl";
+		};
+
+		gic: interrupt-controller at 1c81000 {
+			compatible = "arm,gic-400";
+			reg = <0x01c81000 0x1000>,
+			      <0x01c82000 0x2000>,
+			      <0x01c84000 0x2000>,
+			      <0x01c86000 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun8i-h3-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun8i-h3-h5.dtsi
new file mode 120000
index 000000000000..74f3ce9358a5
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun8i-h3-h5.dtsi
@@ -0,0 +1 @@
+../../../../arm/boot/dts/sun8i-h3-h5.dtsi
\ No newline at end of file
-- 
2.11.0
