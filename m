From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Tue,  5 Jan 2016 17:39:02 +0100
Subject: [PATCH v2 2/2] ARM: dts: imx6: Add support for Toradex Ixora carrier
 board
In-Reply-To: <1452011942-11940-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1452011942-11940-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <1452011942-11940-3-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Petr ?tetiar <ynezz@true.cz>

Signed-off-by: Petr ?tetiar <ynezz@true.cz>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

Changes in v2: None

 arch/arm/boot/dts/Makefile               |   1 +
 arch/arm/boot/dts/imx6q-apalis-ixora.dts | 256 +++++++++++++++++++++++++++++++
 2 files changed, 257 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-apalis-ixora.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 44508dc..29b1aae 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -315,6 +315,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-udoo.dtb \
 	imx6dl-wandboard.dtb \
 	imx6dl-wandboard-revb1.dtb \
+	imx6q-apalis-ixora.dtb \
 	imx6q-apf6dev.dtb \
 	imx6q-arm2.dtb \
 	imx6q-cm-fx6.dtb \
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
new file mode 100644
index 0000000..5494a13
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -0,0 +1,256 @@
+/*
+ * Copyright 2014-2016 Toradex AG
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License
+ *     version 2 as published by the Free Software Foundation.
+ *
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "imx6q.dtsi"
+#include "imx6qdl-apalis.dtsi"
+
+/ {
+	model = "Toradex Apalis iMX6Q/D Module on Ixora Carrier Board";
+	compatible = "toradex,apalis_imx6q-ixora", "toradex,apalis_imx6q",
+		     "fsl,imx6q";
+
+	aliases {
+		i2c0 = &i2cddc;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+	};
+
+	aliases {
+		rtc0 = &rtc_i2c;
+		rtc1 = "/soc/aips-bus at 02000000/snvs at 020cc000/snvs-rtc-lp at 34";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		wakeup {
+			label = "Wake-Up";
+			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_WAKEUP>;
+			debounce-interval = <10>;
+			gpio-key,wakeup;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_leds_ixora>;
+
+		led4-green {
+			label = "LED_4_GREEN";
+			gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
+		};
+
+		led4-red {
+			label = "LED_4_RED";
+			gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
+		};
+
+		led5-green {
+			label = "LED_5_GREEN";
+			gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		led5-red {
+			label = "LED_5_RED";
+			gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	pwmleds {
+		compatible = "pwm-leds";
+		ledpwm1 {
+			label = "PWM1";
+			pwms = <&pwm1 0 50000>;
+			max-brightness = <255>;
+		};
+
+		ledpwm2 {
+			label = "PWM2";
+			pwms = <&pwm2 0 50000>;
+			max-brightness = <255>;
+		};
+
+		ledpwm3 {
+			label = "PWM3";
+			pwms = <&pwm3 0 50000>;
+			max-brightness = <255>;
+		};
+	};
+
+	regulators {
+		reg_usb_otg_vbus: usb_otg_vbus {
+			status = "okay";
+		};
+
+		reg_usb_host_vbus: usb_host_vbus {
+			status = "okay";
+		};
+	};
+};
+
+&backlight {
+	brightness-levels = <0 127 191 223 239 247 251 255>;
+	default-brightness-level = <1>;
+	status = "okay";
+};
+
+&can1 {
+	status = "okay";
+};
+
+&can2 {
+	status = "okay";
+};
+
+/* GEN1_I2C: I2C1_SDA/SCL on MXM3 209/211 (e.g. RTC on carrier board) */
+&i2c1 {
+	status = "okay";
+
+	cat24c02 at 50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+	};
+
+	/* M41T0M6 real time clock on carrier board */
+	rtc_i2c: rtc at 68 {
+		compatible = "st,m41t00";
+		reg = <0x68>;
+	};
+};
+
+&iomuxc {
+	/*
+	 * Mux the Apalis GPIOs, GPIO7 used for PCIe reset,
+	 * GPIO5, 6 used by optional fusion_F0710A kernel module
+	 */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_apalis_gpio1 &pinctrl_apalis_gpio2
+		     &pinctrl_apalis_gpio3 &pinctrl_apalis_gpio4
+		     &pinctrl_apalis_gpio5 &pinctrl_apalis_gpio6
+		     &pinctrl_apalis_gpio7 &pinctrl_apalis_gpio8>;
+
+	leds_ixora {
+		pinctrl_leds_ixora: leds-ixora {
+			fsl,pins = <
+				MX6QDL_PAD_SD1_DAT1__GPIO1_IO17 PAD_CTRL_HYS_PU
+				MX6QDL_PAD_SD1_DAT3__GPIO1_IO21 PAD_CTRL_HYS_PU
+				MX6QDL_PAD_NANDF_D1__GPIO2_IO01 PAD_CTRL_HYS_PU
+				MX6QDL_PAD_NANDF_D2__GPIO2_IO02 PAD_CTRL_HYS_PU
+			>;
+		};
+	};
+};
+
+&pcie {
+	/* active-low meaning opposite of regular PERST# active-low polarity */
+	reset-gpio = <&gpio1 28 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
+
+&pwm4 {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+};
+
+&sound_spdif {
+	status = "okay";
+};
+
+&spdif {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&usbh1 {
+	status = "okay";
+};
+
+&usbotg {
+	status = "okay";
+};
+
+/* SD1 */
+&usdhc2 {
+	status = "okay";
+};
-- 
2.5.0
