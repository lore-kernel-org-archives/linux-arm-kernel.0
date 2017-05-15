From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 15 May 2017 16:40:01 +0800
Subject: [PATCH 4/4] ARM: sun8i: v3s: add support for Lichee Pi Zero w/ dock
 board
In-Reply-To: <20170515084001.63123-1-icenowy@aosc.io>
References: <20170515084001.63123-1-icenowy@aosc.io>
Message-ID: <20170515084001.63123-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Lichee Pi Zero board has a "dock board" which needs to be soldered
with the 1.27mm stamp holes on a Lichee Pi Zero board.

It features:
- Onboard MIC and headphone jack (not supported yet)
- Ethernet port (not supported yet)
- An extra MicroSD slot connected to MMC1 controller
- four keys connected to the LRADC.

As it needs to be soldered with the main board to use, add a stand-alone
device tree for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts | 94 ++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts

diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
new file mode 100644
index 000000000000..d2bfccf47149
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
@@ -0,0 +1,94 @@
+/*
+ * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.xyz>
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
+#include "sun8i-v3s-licheepi-zero.dts"
+
+/ {
+	model = "Lichee Pi Zero with Dock";
+	compatible = "licheepi,licheepi-zero-dock", "licheepi,licheepi-zero",
+		     "allwinner,sun8i-v3s";
+
+	leds {
+		/* The LEDs use PG0~2 pins, which conflict with MMC1 */
+		status = "disbaled";
+	};
+};
+
+&mmc1 {
+	broken-cd;
+	bus-width = <4>;
+	vmmc-supply = <&reg_vcc3v3>;
+	status = "okay";
+};
+
+&lradc {
+	vref-supply = <&reg_vcc3v0>;
+	status = "okay";
+
+	button at 200 {
+		label = "Volume Up";
+		linux,code = <KEY_VOLUMEUP>;
+		channel = <0>;
+		voltage = <200000>;
+	};
+
+	button at 400 {
+		label = "Volume Down";
+		linux,code = <KEY_VOLUMEDOWN>;
+		channel = <0>;
+		voltage = <400000>;
+	};
+
+	button at 600 {
+		label = "Select";
+		linux,code = <KEY_SELECT>;
+		channel = <0>;
+		voltage = <600000>;
+	};
+
+	button at 800 {
+		label = "Start";
+		linux,code = <KEY_OK>;
+		channel = <0>;
+		voltage = <800000>;
+	};
+};
-- 
2.12.2
