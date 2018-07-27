From: diego.rondini@kynetics.com (Diego Rondini)
Date: Fri, 27 Jul 2018 14:57:39 +0200
Subject: [PATCH] ARM: dts: sun8i: Add initial Orangepi Zero Plus 2 H3 support
Message-ID: <20180727125739.22871-1-diego.rondini@kynetics.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Orangepi Zero Plus 2 is an open-source single-board computer, available in two
Allwinner SOC variants, H3 and H5. We add support for H3 variant here, as the
H5 is already supported by sun50i-h5-orangepi-zero-plus2.dts.

H5 Orangepi Zero Plus 2 has
- Quad-core Cortex-A7
- 512MB DDR3
- micrSD slot and 8GB eMMC
- Debug TTL UART
- HDMI
- Wifi + BT
- OTG+power supply

Signed-off-by: Diego Rondini <diego.rondini@kynetics.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/sun8i-h3-orangepi-zero-plus2.dts | 146 ++++++++++++++++++
 2 files changed, 147 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 37a3de760d40..03fb915f2337 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1024,6 +1024,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-h3-orangepi-pc-plus.dtb \
 	sun8i-h3-orangepi-plus.dtb \
 	sun8i-h3-orangepi-plus2e.dtb \
+	sun8i-h3-orangepi-zero-plus2.dtb \
 	sun8i-r16-bananapi-m2m.dtb \
 	sun8i-r16-nintendo-nes-classic.dtb \
 	sun8i-r16-nintendo-super-nes-classic.dtb \
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
new file mode 100644
index 000000000000..3701644adc30
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
@@ -0,0 +1,146 @@
+/*
+ * Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
+ * Copyright (C) 2018 Diego Rondini <diego.rondini@kynetics.com>
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
+#include "sun8i-h3.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "OrangePi Zero Plus2 H3";
+	compatible = "xunlong,orangepi-zero-plus2", "allwinner,sun8i-h3";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
+	reg_vcc3v3: vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		reset-gpios = <&pio 0 9 GPIO_ACTIVE_LOW>; /* PA9 */
+		post-power-on-delay-ms = <200>;
+	};
+};
+
+&de {
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&mmc1 {
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc3v3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	brcmf: wifi at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&r_pio>;
+		interrupts = <0 7 IRQ_TYPE_LEVEL_LOW>;	/* PL7 */
+		interrupt-names = "host-wake";
+	};
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bit_pins>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	status = "okay";
+};
-- 
2.17.1
