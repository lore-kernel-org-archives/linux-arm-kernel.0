From: ayaka@soulik.info (Randy Li)
Date: Sun, 18 Sep 2016 22:01:18 +0800
Subject: [PATCH v7 2/3] ARM: dts: add TOPEET itop elite based board
In-Reply-To: <1474207279-9662-1-git-send-email-ayaka@soulik.info>
References: <1474207279-9662-1-git-send-email-ayaka@soulik.info>
Message-ID: <1474207279-9662-3-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TOPEET itop exynos 4412 have three versions base board. The
Elite version is the cheap one without too much peripheral devices
on it.

Currently supported are serial console, wired networking(USB),
USB OTG in peripheral mode, USB host, SD storage, GPIO buttons,
PWM beeper, ADC and LEDs. The WM8960 analog audio codec is also
enabled.

The FIMC is not used for camera currently, I enabled it just for a
colorspace convertor.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 .../bindings/arm/samsung/samsung-boards.txt        |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/exynos4412-itop-elite.dts        | 240 +++++++++++++++++++++
 3 files changed, 244 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos4412-itop-elite.dts

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
index 0ea7f14..5160fa5 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
@@ -22,6 +22,9 @@ Required root node properties:
   * FriendlyARM
 	- "friendlyarm,tiny4412"  - for Exynos4412-based FriendlyARM
 				    TINY4412 board.
+  * TOPEET
+	- "topeet,itop4412-elite" - for Exynos4412-based TOPEET
+                                    Elite base board.
 
   * Google
 	- "google,pi"		- for Exynos5800-based Google Peach Pi
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index befcd26..d709f74 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -136,6 +136,7 @@ dtb-$(CONFIG_ARCH_EXYNOS4) += \
 	exynos4210-smdkv310.dtb \
 	exynos4210-trats.dtb \
 	exynos4210-universal_c210.dtb \
+	exynos4412-itop-elite.dtb \
 	exynos4412-odroidu3.dtb \
 	exynos4412-odroidx.dtb \
 	exynos4412-odroidx2.dtb \
diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
new file mode 100644
index 0000000..b08705e
--- /dev/null
+++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
@@ -0,0 +1,240 @@
+/*
+ * TOPEET's Exynos4412 based itop board device tree source
+ *
+ * Copyright (c) 2016 SUMOMO Computer Association
+ *			https://www.sumomo.mobi
+ *			Randy Li <ayaka@soulik.info>
+ *
+ * Device tree source file for TOPEET iTop Exynos 4412 core board
+ * which is based on Samsung's Exynos4412 SoC.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/dts-v1/;
+#include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/sound/samsung-i2s.h>
+#include "exynos4412-itop-scp-core.dtsi"
+
+/ {
+	model = "TOPEET iTop 4412 Elite board based on Exynos4412";
+	compatible = "topeet,itop4412-elite", "samsung,exynos4412", "samsung,exynos4";
+
+	chosen {
+		bootargs = "root=/dev/mmcblk0p2 rw rootfstype=ext4 rootdelay=1 rootwait";
+		stdout-path = "serial2:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led2 {
+			label = "red:system";
+			gpios = <&gpx1 0 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+			linux,default-trigger = "heartbeat";
+		};
+
+		led3 {
+			label = "red:user";
+			gpios = <&gpk1 1 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		home {
+			label = "GPIO Key Home";
+			linux,code = <KEY_HOME>;
+			gpios = <&gpx1 1 GPIO_ACTIVE_LOW>;
+		};
+
+		back {
+			label = "GPIO Key Back";
+			linux,code = <KEY_BACK>;
+			gpios = <&gpx1 2 GPIO_ACTIVE_LOW>;
+		};
+
+		sleep {
+			label = "GPIO Key Sleep";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpx3 3 GPIO_ACTIVE_LOW>;
+		};
+
+		vol-up {
+			label = "GPIO Key Vol+";
+			linux,code = <KEY_UP>;
+			gpios = <&gpx2 1 GPIO_ACTIVE_LOW>;
+		};
+
+		vol-down {
+			label = "GPIO Key Vol-";
+			linux,code = <KEY_DOWN>;
+			gpios = <&gpx2 0 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "wm-sound";
+
+		assigned-clocks = <&clock_audss EXYNOS_MOUT_AUDSS>,
+				<&clock_audss EXYNOS_MOUT_I2S>,
+				<&clock_audss EXYNOS_DOUT_SRP>,
+				<&clock_audss EXYNOS_DOUT_AUD_BUS>;
+		assigned-clock-parents = <&clock CLK_FOUT_EPLL>,
+				<&clock_audss EXYNOS_MOUT_AUDSS>;
+		assigned-clock-rates = <0>,
+				<0>,
+				<112896000>,
+				<11289600>;
+
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&link0_codec>;
+		simple-audio-card,frame-master = <&link0_codec>;
+
+		simple-audio-card,widgets =
+			"Microphone", "Mic Jack",
+			"Line", "Line In",
+			"Line", "Line Out",
+			"Speaker", "Speaker",
+			"Headphone", "Headphone Jack";
+		simple-audio-card,routing =
+			"Headphone Jack", "HP_L",
+			"Headphone Jack", "HP_R",
+			"Speaker", "SPK_LP",
+			"Speaker", "SPK_LN",
+			"Speaker", "SPK_RP",
+			"Speaker", "SPK_RN",
+			"LINPUT1", "Mic Jack",
+			"LINPUT3", "Mic Jack",
+			"RINPUT1", "Mic Jack",
+			"RINPUT2", "Mic Jack";
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s0 0>;
+		};
+
+		link0_codec: simple-audio-card,codec {
+			sound-dai = <&codec>;
+			clocks = <&i2s0 CLK_I2S_CDCLK>;
+			system-clock-frequency = <11289600>;
+		};
+	};
+
+	beep {
+		compatible = "pwm-beeper";
+		pwms = <&pwm 0 4000000 PWM_POLARITY_INVERTED>;
+	};
+
+	camera: camera {
+		pinctrl-0 = <&cam_port_a_clk_active>;
+		pinctrl-names = "default";
+		status = "okay";
+		assigned-clocks = <&clock CLK_MOUT_CAM0>;
+		assigned-clock-parents = <&clock CLK_XUSBXTI>;
+	};
+};
+
+&adc {
+	vdd-supply = <&ldo3_reg>;
+	status = "okay";
+};
+
+&ehci {
+	status = "okay";
+	/* In order to reset USB ethernet */
+	samsung,vbus-gpio = <&gpc0 1 GPIO_ACTIVE_HIGH>;
+
+	port at 0 {
+		status = "okay";
+	};
+
+	port at 2 {
+		status = "okay";
+	};
+};
+
+&exynos_usbphy {
+	status = "okay";
+};
+
+&fimc_0 {
+	status = "okay";
+	assigned-clocks = <&clock CLK_MOUT_FIMC0>,
+			<&clock CLK_SCLK_FIMC0>;
+	assigned-clock-parents = <&clock CLK_MOUT_MPLL_USER_T>;
+	assigned-clock-rates = <0>, <176000000>;
+};
+
+&hsotg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&i2c_4 {
+	samsung,i2c-sda-delay = <100>;
+	samsung,i2c-slave-addr = <0x10>;
+	samsung,i2c-max-bus-freq = <100000>;
+	pinctrl-0 = <&i2c4_bus>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	codec: wm8960 at 1a {
+		compatible = "wlf,wm8960";
+		reg = <0x1a>;
+		clocks = <&pmu_system_controller 0>;
+		clock-names = "MCLK1";
+		wlf,shared-lrclk;
+		#sound-dai-cells = <0>;
+	};
+};
+
+&i2s0 {
+	pinctrl-0 = <&i2s0_bus>;
+	pinctrl-names = "default";
+	status = "okay";
+	clocks = <&clock_audss EXYNOS_I2S_BUS>,
+		 <&clock_audss EXYNOS_DOUT_AUD_BUS>,
+		 <&clock_audss EXYNOS_SCLK_I2S>;
+	clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
+};
+
+&pinctrl_1 {
+	ether-reset {
+		samsung,pins = "gpc0-1";
+		samsung,pin-function = <1>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <0>;
+	};
+};
+
+&pwm {
+	status = "okay";
+	pinctrl-0 = <&pwm0_out>;
+	pinctrl-names = "default";
+	samsung,pwm-outputs = <0>;
+};
+
+&sdhci_2 {
+	bus-width = <4>;
+	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4>;
+	pinctrl-names = "default";
+	cd-gpio = <&gpx0 7 GPIO_ACTIVE_LOW>;
+	cap-sd-highspeed;
+	vmmc-supply = <&ldo23_reg>;
+	vqmmc-supply = <&ldo17_reg>;
+	status = "okay";
+};
+
+&serial_1 {
+	status = "okay";
+};
+
+&serial_2 {
+	status = "okay";
+};
-- 
2.7.4
