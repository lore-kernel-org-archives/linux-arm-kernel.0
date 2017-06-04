From: icenowy@aosc.io (Icenowy Zheng)
Date: Sun,  4 Jun 2017 10:43:44 +0800
Subject: [PATCH 1/2] arm64: allwinner: a64: add DTSI file for SoPine SoM
Message-ID: <20170604024345.23021-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.xyz>

SoPine is a SoM by Pine64, which have a gold finger compatible with the
slot of DDR3 SODIMM (signals are not compatible), and have an A64, an
AXP803, a LPDDR3 DRAM chip, a power led and a MicroSD slot on it.

The card detect pin of the MicroSD slot on the SoM is pulled down, which
makes it unusable; however, the slot is at the surface of the SoM that
is closed to the baseboard, so it's nearly impossible to hot-swap it,
thus I make it non-removable.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi      | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
new file mode 100644
index 000000000000..475518b031dd
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
@@ -0,0 +1,65 @@
+/*
+ * Copyright (c) 2017 Icenowy Zheng <icenowy@aosc.xyz>
+ *
+ * Based on sun50i-a64-pine64.dts, which is:
+ *   Copyright (c) 2016 ARM Ltd.
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
+#include "sun50i-a64.dtsi"
+
+/ {
+	reg_vcc3v3: vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	vmmc-supply = <&reg_vcc3v3>;
+	non-removable;
+	disable-wp;
+	bus-width = <4>;
+	status = "okay";
+};
-- 
2.12.2
