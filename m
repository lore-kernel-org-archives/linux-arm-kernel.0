From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 21 Nov 2016 17:29:04 +0100
Subject: [PATCH 1/2] ARM64: dts: Add support for Meson GXM
In-Reply-To: <20161121162905.14285-1-narmstrong@baylibre.com>
References: <20161121162905.14285-1-narmstrong@baylibre.com>
Message-ID: <20161121162905.14285-2-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the Amlogic Linux kernel, it seem the only differences
between the GXL and GXM SoCs are the CPU Clusters.

This commit renames the gxl-s905d-p23x DTSI in a common file for
S905D p20x and S912 q20x boards.

Then adds a meson-gxm dtsi and reproduce the P23x to Q20x boards
dts files since the S905D and S912 SoCs shares the same pinout
and the P23x and Q20x boards are identical.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt  |   6 +
 arch/arm64/boot/dts/amlogic/Makefile               |   2 +
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi | 190 +++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts    |  19 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts    |   7 +
 .../boot/dts/amlogic/meson-gxl-s905d-p230.dts      |   3 +-
 .../boot/dts/amlogic/meson-gxl-s905d-p231.dts      |   3 +-
 .../boot/dts/amlogic/meson-gxl-s905d-p23x.dtsi     | 188 --------------------
 .../arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts |  77 +++++++++
 .../arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts |  58 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         | 114 +++++++++++++
 11 files changed, 477 insertions(+), 190 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
 delete mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p23x.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index fffc179..1144214 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -25,6 +25,10 @@ Boards with the Amlogic Meson GXL S905D SoC shall have the following properties:
   Required root node property:
     compatible: "amlogic,s905d", "amlogic,meson-gxl";
 
+Boards with the Amlogic Meson GXM S912 SoC shall have the following properties:
+  Required root node property:
+    compatible: "amlogic,s912", "amlogic,meson-gxm";
+
 Board compatible values:
   - "geniatech,atv1200" (Meson6)
   - "minix,neo-x8" (Meson8)
@@ -39,3 +43,5 @@ Board compatible values:
   - "amlogic,p212" (Meson gxl s905x)
   - "amlogic,p230" (Meson gxl s905d)
   - "amlogic,p231" (Meson gxl s905d)
+  - "amlogic,q200" (Meson gxm s912)
+  - "amlogic,q201" (Meson gxm s912)
diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 5a64050..7752a16 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -8,6 +8,8 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-telos.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-q200.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-q201.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
new file mode 100644
index 0000000..7a078be
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -0,0 +1,190 @@
+/*
+ * Copyright (c) 2016 Endless Computers, Inc.
+ * Author: Carlo Caione <carlo@endlessm.com>
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
+/* Common DTSI for same Amlogic Q200/Q201 and P230/P231 boards using either
+ * the pin-compatible S912 (GXM) or S905D (GXL) SoCs.
+ */
+
+/ {
+	aliases {
+		serial0 = &uart_AO;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	vddio_boot: regulator-vddio_boot {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_BOOT";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	vddao_3v3: regulator-vddao_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDAO_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	vcc_3v3: regulator-vcc_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
+	};
+
+	wifi32k: wifi32k {
+		compatible = "pwm-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
+		clocks = <&wifi32k>;
+		clock-names = "ext_clock";
+	};
+};
+
+/* This UART is brought out to the DB9 connector */
+&uart_AO {
+	status = "okay";
+	pinctrl-0 = <&uart_ao_a_pins>;
+	pinctrl-names = "default";
+};
+
+&ir {
+	status = "okay";
+	pinctrl-0 = <&remote_input_ao_pins>;
+	pinctrl-names = "default";
+};
+
+/* Wireless SDIO Module */
+&sd_emmc_a {
+	status = "okay";
+	pinctrl-0 = <&sdio_pins>;
+	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	max-frequency = <100000000>;
+
+	non-removable;
+	disable-wp;
+
+	mmc-pwrseq = <&sdio_pwrseq>;
+
+	vmmc-supply = <&vddao_3v3>;
+	vqmmc-supply = <&vddio_boot>;
+
+	brcmf: bcrmf at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+/* SD card */
+&sd_emmc_b {
+	status = "okay";
+	pinctrl-0 = <&sdcard_pins>;
+	pinctrl-names = "default";
+
+	bus-width = <4>;
+	cap-sd-highspeed;
+	max-frequency = <100000000>;
+	disable-wp;
+
+	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
+	cd-inverted;
+
+	vmmc-supply = <&vddao_3v3>;
+	vqmmc-supply = <&vddio_boot>;
+};
+
+/* eMMC */
+&sd_emmc_c {
+	status = "okay";
+	pinctrl-0 = <&emmc_pins>;
+	pinctrl-names = "default";
+
+	bus-width = <8>;
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
+	max-frequency = <200000000>;
+	non-removable;
+	disable-wp;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+
+	mmc-pwrseq = <&emmc_pwrseq>;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vddio_boot>;
+};
+
+&pwm_ef {
+	status = "okay";
+	pinctrl-0 = <&pwm_e_pins>;
+	pinctrl-names = "default";
+	clocks = <&clkc CLKID_FCLK_DIV4>;
+	clock-names = "clkin0";
+};
+
+&ethmac {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
index 03e3d76..17bb77c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
@@ -56,3 +56,22 @@
 	pinctrl-0 = <&i2c_b_pins>;
 	pinctrl-names = "default";
 };
+
+&ethmac {
+	status = "okay";
+	pinctrl-0 = <&eth_rgmii_pins>;
+	pinctrl-names = "default";
+
+	phy-handle = <&eth_phy0>;
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eth_phy0: ethernet-phy at 0 {
+			reg = <0>;
+			realtek,disable-eee-1000t;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
index 39bb037..5608c51 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
@@ -50,3 +50,10 @@
 	compatible = "amlogic,p201", "amlogic,meson-gxbb";
 	model = "Amlogic Meson GXBB P201 Development Board";
 };
+
+&ethmac {
+	status = "okay";
+	pinctrl-0 = <&eth_rmii_pins>;
+	pinctrl-names = "default";
+	phy-mode = "rmii";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
index 4d082a7..f66939c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
@@ -43,7 +43,8 @@
 
 /dts-v1/;
 
-#include "meson-gxl-s905d-p23x.dtsi"
+#include "meson-gxl-s905d.dtsi"
+#include "meson-gx-p23x-q20x.dtsi"
 
 / {
 	compatible = "amlogic,p230", "amlogic,s905d", "amlogic,meson-gxl";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts
index 1cc8d49..95992cf 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts
@@ -43,7 +43,8 @@
 
 /dts-v1/;
 
-#include "meson-gxl-s905d-p23x.dtsi"
+#include "meson-gxl-s905d.dtsi"
+#include "meson-gx-p23x-q20x.dtsi"
 
 / {
 	compatible = "amlogic,p231", "amlogic,s905d", "amlogic,meson-gxl";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p23x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p23x.dtsi
deleted file mode 100644
index 622ffbe..0000000
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p23x.dtsi
+++ /dev/null
@@ -1,188 +0,0 @@
-/*
- * Copyright (c) 2016 Endless Computers, Inc.
- * Author: Carlo Caione <carlo@endlessm.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This library is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This library is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-#include "meson-gxl-s905d.dtsi"
-
-/ {
-	aliases {
-		serial0 = &uart_AO;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory at 0 {
-		device_type = "memory";
-		reg = <0x0 0x0 0x0 0x80000000>;
-	};
-
-	vddio_boot: regulator-vddio_boot {
-		compatible = "regulator-fixed";
-		regulator-name = "VDDIO_BOOT";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	vddao_3v3: regulator-vddao_3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "VDDAO_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	vcc_3v3: regulator-vcc_3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "VCC_3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	emmc_pwrseq: emmc-pwrseq {
-		compatible = "mmc-pwrseq-emmc";
-		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
-	};
-
-	wifi32k: wifi32k {
-		compatible = "pwm-clock";
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		pwms = <&pwm_ef 0 30518 0>; /* PWM_E at 32.768KHz */
-	};
-
-	sdio_pwrseq: sdio-pwrseq {
-		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
-		clocks = <&wifi32k>;
-		clock-names = "ext_clock";
-	};
-};
-
-/* This UART is brought out to the DB9 connector */
-&uart_AO {
-	status = "okay";
-	pinctrl-0 = <&uart_ao_a_pins>;
-	pinctrl-names = "default";
-};
-
-&ir {
-	status = "okay";
-	pinctrl-0 = <&remote_input_ao_pins>;
-	pinctrl-names = "default";
-};
-
-/* Wireless SDIO Module */
-&sd_emmc_a {
-	status = "okay";
-	pinctrl-0 = <&sdio_pins>;
-	pinctrl-names = "default";
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	bus-width = <4>;
-	cap-sd-highspeed;
-	max-frequency = <100000000>;
-
-	non-removable;
-	disable-wp;
-
-	mmc-pwrseq = <&sdio_pwrseq>;
-
-	vmmc-supply = <&vddao_3v3>;
-	vqmmc-supply = <&vddio_boot>;
-
-	brcmf: bcrmf at 1 {
-		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
-	};
-};
-
-/* SD card */
-&sd_emmc_b {
-	status = "okay";
-	pinctrl-0 = <&sdcard_pins>;
-	pinctrl-names = "default";
-
-	bus-width = <4>;
-	cap-sd-highspeed;
-	max-frequency = <100000000>;
-	disable-wp;
-
-	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
-
-	vmmc-supply = <&vddao_3v3>;
-	vqmmc-supply = <&vddio_boot>;
-};
-
-/* eMMC */
-&sd_emmc_c {
-	status = "okay";
-	pinctrl-0 = <&emmc_pins>;
-	pinctrl-names = "default";
-
-	bus-width = <8>;
-	cap-sd-highspeed;
-	cap-mmc-highspeed;
-	max-frequency = <200000000>;
-	non-removable;
-	disable-wp;
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
-
-	mmc-pwrseq = <&emmc_pwrseq>;
-	vmmc-supply = <&vcc_3v3>;
-	vqmmc-supply = <&vddio_boot>;
-};
-
-&pwm_ef {
-	status = "okay";
-	pinctrl-0 = <&pwm_e_pins>;
-	pinctrl-names = "default";
-	clocks = <&clkc CLKID_FCLK_DIV4>;
-	clock-names = "clkin0";
-};
-
-&ethmac {
-	status = "okay";
-};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts
new file mode 100644
index 0000000..5dbc660
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts
@@ -0,0 +1,77 @@
+/*
+ * Copyright (c) 2016 Endless Computers, Inc.
+ * Author: Carlo Caione <carlo@endlessm.com>
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
+#include "meson-gxm.dtsi"
+#include "meson-gx-p23x-q20x.dtsi"
+
+/ {
+	compatible = "amlogic,q200", "amlogic,s912", "amlogic,meson-gxm";
+	model = "Amlogic Meson GXM (S912) Q200 Development Board";
+};
+
+/* Q200 has exclusive choice between internal or external PHY */
+&ethmac {
+	pinctrl-0 = <&eth_pins>;
+	pinctrl-names = "default";
+
+	/* Select external PHY by default */
+	phy-handle = <&external_phy>;
+
+	/* External PHY reset is shared with internal PHY Led signals */
+	snps,reset-gpio = <&gpio GPIOZ_14 0>;
+	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-active-low;
+
+	/* External PHY is in RGMII */
+	phy-mode = "rgmii";
+};
+
+&external_mdio {
+	external_phy: ethernet-phy at 0 {
+		compatible = "ethernet-phy-id001c.c916", "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+		max-speed = <1000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts
new file mode 100644
index 0000000..95e11d7
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts
@@ -0,0 +1,58 @@
+/*
+ * Copyright (c) 2016 Endless Computers, Inc.
+ * Author: Carlo Caione <carlo@endlessm.com>
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
+#include "meson-gxm.dtsi"
+#include "meson-gx-p23x-q20x.dtsi"
+
+/ {
+	compatible = "amlogic,q201", "amlogic,s912", "amlogic,meson-gxm";
+	model = "Amlogic Meson GXM (S912) Q201 Development Board";
+};
+
+/* Q201 has only internal PHY port */
+&ethmac {
+	phy-mode = "rmii";
+	phy-handle = <&internal_phy>;
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
new file mode 100644
index 0000000..9a90237
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
@@ -0,0 +1,114 @@
+/*
+ * Copyright (c) 2016 Endless Computers, Inc.
+ * Author: Carlo Caione <carlo@endlessm.com>
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
+#include "meson-gxl.dtsi"
+
+/ {
+	compatible = "amlogic,meson-gxm";
+
+	cpus {
+		cpu-map {
+			cluster0 {
+				cpu0 {
+					cpu = <&cpu0>;
+				};
+				cpu1 {
+					cpu = <&cpu1>;
+				};
+				cpu2 {
+					cpu = <&cpu2>;
+				};
+				cpu3 {
+					cpu = <&cpu3>;
+				};
+			};
+
+			cluster1 {
+				cpu0 {
+					cpu = <&cpu4>;
+				};
+				cpu1 {
+					cpu = <&cpu5>;
+				};
+				cpu2 {
+					cpu = <&cpu6>;
+				};
+				cpu3 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		cpu4: cpu at 100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu5: cpu at 101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x101>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu6: cpu at 102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x102>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu7: cpu at 103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x103>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+	};
+};
-- 
2.7.0
