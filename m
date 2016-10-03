From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  3 Oct 2016 10:09:13 +0200
Subject: [PATCH v3 9/9] arm64: dts: add Pine64 support
In-Reply-To: <20161003080913.24197-1-maxime.ripard@free-electrons.com>
References: <20161003080913.24197-1-maxime.ripard@free-electrons.com>
Message-ID: <20161003080913.24197-10-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>

The Pine64 is a cost-efficient development board based on the
Allwinner A64 SoC.
There are three models: the basic version with Fast Ethernet and
512 MB of DRAM (Pine64) and two Pine64+ versions, which both
feature Gigabit Ethernet and additional connectors for touchscreens
and a camera. Or as my son put it: "Those are smaller and these are
missing." ;-)
The two Pine64+ models just differ in the amount of DRAM
(1GB vs. 2GB). Since U-Boot will figure out the right size for us and
patches the DT accordingly we just need to provide one DT for the
Pine64+.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
[Maxime: Removed the common DTSI and include directly the pine64 DTS]
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm64/boot/dts/Makefile                       |  1 +
 arch/arm64/boot/dts/allwinner/Makefile             |  5 ++
 .../boot/dts/allwinner/sun50i-a64-pine64-plus.dts  | 50 +++++++++++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 74 +++++++++++++++++
 include/dt-bindings/reset/sun50i-a64-ccu.h         | 97 +++++++++++-----------
 5 files changed, 179 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/Makefile
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 6e199c903676..ddcbf5a2c17e 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -1,4 +1,5 @@
 dts-dirs += al
+dts-dirs += allwinner
 dts-dirs += altera
 dts-dirs += amd
 dts-dirs += amlogic
diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
new file mode 100644
index 000000000000..1e29a5ae8282
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -0,0 +1,5 @@
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
new file mode 100644
index 000000000000..790d14daaa6a
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
@@ -0,0 +1,50 @@
+/*
+ * Copyright (c) 2016 ARM Ltd.
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
+#include "sun50i-a64-pine64.dts"
+
+/ {
+	model = "Pine64+";
+	compatible = "pine64,pine64-plus", "allwinner,sun50i-a64";
+
+	/* TODO: Camera, Ethernet PHY, touchscreen, etc. */
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
new file mode 100644
index 000000000000..9f127b3d0e33
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -0,0 +1,74 @@
+/*
+ * Copyright (c) 2016 ARM Ltd.
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
+#include "sun50i-a64.dtsi"
+
+/ {
+	model = "Pine64";
+	compatible = "pine64,pine64", "allwinner,sun50i-a64";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	status = "okay";
+};
+
+&i2c1_pins {
+	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+};
diff --git a/include/dt-bindings/reset/sun50i-a64-ccu.h b/include/dt-bindings/reset/sun50i-a64-ccu.h
index e61fac294d73..db60b29ddb11 100644
--- a/include/dt-bindings/reset/sun50i-a64-ccu.h
+++ b/include/dt-bindings/reset/sun50i-a64-ccu.h
@@ -46,52 +46,53 @@
 #define RST_USB_PHY0		0
 #define RST_USB_PHY1		1
 #define RST_USB_HSIC		2
-#define RST_MBUS		3
-#define RST_BUS_MIPI_DSI	4
-#define RST_BUS_CE		5
-#define RST_BUS_DMA		6
-#define RST_BUS_MMC0		7
-#define RST_BUS_MMC1		8
-#define RST_BUS_MMC2		9
-#define RST_BUS_NAND		10
-#define RST_BUS_DRAM		11
-#define RST_BUS_EMAC		12
-#define RST_BUS_TS		13
-#define RST_BUS_HSTIMER		14
-#define RST_BUS_SPI0		15
-#define RST_BUS_SPI1		16
-#define RST_BUS_OTG		17
-#define RST_BUS_EHCI0		18
-#define RST_BUS_EHCI1		19
-#define RST_BUS_OHCI0		20
-#define RST_BUS_OHCI1		21
-#define RST_BUS_VE		22
-#define RST_BUS_TCON0		23
-#define RST_BUS_TCON1		24
-#define RST_BUS_DEINTERLACE	25
-#define RST_BUS_CSI		26
-#define RST_BUS_HDMI0		27
-#define RST_BUS_HDMI1		28
-#define RST_BUS_DE		29
-#define RST_BUS_GPU		30
-#define RST_BUS_MSGBOX		31
-#define RST_BUS_SPINLOCK	32
-#define RST_BUS_DBG		33
-#define RST_BUS_LVDS		34
-#define RST_BUS_CODEC		35
-#define RST_BUS_SPDIF		36
-#define RST_BUS_THS		37
-#define RST_BUS_I2S0		38
-#define RST_BUS_I2S1		39
-#define RST_BUS_I2S2		40
-#define RST_BUS_I2C0		41
-#define RST_BUS_I2C1		42
-#define RST_BUS_I2C2		43
-#define RST_BUS_SCR		44
-#define RST_BUS_UART0		45
-#define RST_BUS_UART1		46
-#define RST_BUS_UART2		47
-#define RST_BUS_UART3		48
-#define RST_BUS_UART4		49
+#define RST_DRAM		3
+#define RST_MBUS		4
+#define RST_BUS_MIPI_DSI	5
+#define RST_BUS_CE		6
+#define RST_BUS_DMA		7
+#define RST_BUS_MMC0		8
+#define RST_BUS_MMC1		9
+#define RST_BUS_MMC2		10
+#define RST_BUS_NAND		11
+#define RST_BUS_DRAM		12
+#define RST_BUS_EMAC		13
+#define RST_BUS_TS		14
+#define RST_BUS_HSTIMER		15
+#define RST_BUS_SPI0		16
+#define RST_BUS_SPI1		17
+#define RST_BUS_OTG		18
+#define RST_BUS_EHCI0		19
+#define RST_BUS_EHCI1		20
+#define RST_BUS_OHCI0		21
+#define RST_BUS_OHCI1		22
+#define RST_BUS_VE		23
+#define RST_BUS_TCON0		24
+#define RST_BUS_TCON1		25
+#define RST_BUS_DEINTERLACE	26
+#define RST_BUS_CSI		27
+#define RST_BUS_HDMI0		28
+#define RST_BUS_HDMI1		29
+#define RST_BUS_DE		30
+#define RST_BUS_GPU		31
+#define RST_BUS_MSGBOX		32
+#define RST_BUS_SPINLOCK	33
+#define RST_BUS_DBG		34
+#define RST_BUS_LVDS		35
+#define RST_BUS_CODEC		36
+#define RST_BUS_SPDIF		37
+#define RST_BUS_THS		38
+#define RST_BUS_I2S0		39
+#define RST_BUS_I2S1		40
+#define RST_BUS_I2S2		41
+#define RST_BUS_I2C0		42
+#define RST_BUS_I2C1		43
+#define RST_BUS_I2C2		44
+#define RST_BUS_SCR		45
+#define RST_BUS_UART0		46
+#define RST_BUS_UART1		47
+#define RST_BUS_UART2		48
+#define RST_BUS_UART3		49
+#define RST_BUS_UART4		50
 
-#endif /* _DT_BINDINGS_RST_SUN8I_H3_H_ */
+#endif /* _DT_BINDINGS_RST_SUN50I_A64_H_ */
-- 
2.9.3
