From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 30 Jul 2015 13:55:06 +0200
Subject: [PATCH v3 3/3] ARM: at91/dt: add minimal sama5d2 Xplained board
In-Reply-To: <1438257306-12517-1-git-send-email-nicolas.ferre@atmel.com>
References: <1438257306-12517-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <1438257306-12517-4-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add minimal support for the new sama5d2 Xplained board. Only USB,
spi/i2c, ethernet and uart/usart peripherals added.
With this DTS file you can boot the board and begin to play with it.
Rootfs on NFS and sd card have successfully been tested.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---

Changes in v3:
- remove sd/mmc nodes

Changes in v2:
- enable spi and i2c nodes
- enable sdmmc0
- move to stdout-path for console

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 134 ++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-sama5d2_xplained.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 63e90c5ff679..db25557fa8b1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -41,6 +41,7 @@ dtb-$(CONFIG_SOC_SAM_V4_V5) += \
 	at91sam9x35ek.dtb
 dtb-$(CONFIG_SOC_SAM_V7) += \
 	at91-kizbox2.dtb \
+	at91-sama5d2_xplained.dtb \
 	at91-sama5d3_xplained.dtb \
 	sama5d31ek.dtb \
 	sama5d33ek.dtb \
diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
new file mode 100644
index 000000000000..e8d63afdb135
--- /dev/null
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -0,0 +1,134 @@
+/*
+ * at91-sama5d2_xplained.dts - Device Tree file for SAMA5D2 Xplained board
+ *
+ *  Copyright (C) 2015 Atmel,
+ *                2015 Nicolas Ferre <nicolas.ferre@atmel.com>
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
+/dts-v1/;
+#include "sama5d2.dtsi"
+
+/ {
+	model = "Atmel SAMA5D2 Xplained";
+	compatible = "atmel,sama5d2-xplained", "atmel,sama5d2", "atmel,sama5";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		reg = <0x20000000 0x80000>;
+	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		main_clock: clock at 0 {
+			compatible = "atmel,osc", "fixed-clock";
+			clock-frequency = <12000000>;
+		};
+
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
+			clock-frequency = <12000000>;
+		};
+	};
+
+	ahb {
+		usb0: gadget at 00300000 {
+			status = "okay";
+		};
+
+		usb1: ohci at 00400000 {
+			num-ports = <3>;
+			status = "okay";
+		};
+
+		usb2: ehci at 00500000 {
+			status = "okay";
+		};
+
+		apb {
+			spi0: spi at f8000000 {
+				status = "okay";
+
+				m25p80 at 0 {
+					compatible = "atmel,at25df321a";
+					reg = <0>;
+					spi-max-frequency = <50000000>;
+				};
+			};
+
+			macb0: ethernet at f8008000 {
+				phy-mode = "rmii";
+				status = "okay";
+			};
+
+			uart1: serial at f8020000 {
+				status = "okay";
+			};
+
+			i2c0: i2c at f8028000 {
+				dmas = <0>, <0>;
+				status = "okay";
+			};
+
+			uart3: serial at fc008000 {
+				status = "okay";
+			};
+
+			i2c1: i2c at fc028000 {
+				dmas = <0>, <0>;
+				status = "okay";
+
+				at24 at 54 {
+					compatible = "atmel,24c02";
+					reg = <0x54>;
+					pagesize = <16>;
+				};
+			};
+		};
+	};
+};
-- 
2.1.3
