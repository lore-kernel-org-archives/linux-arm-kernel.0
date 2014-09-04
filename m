From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Sep 2014 10:12:47 +0900
Subject: [PATCH 2/6] ARM: shmobile: armadillo800eva: Sync DTS
In-Reply-To: <cover.1409792648.git.horms+renesas@verge.net.au>
References: <cover.1409792648.git.horms+renesas@verge.net.au>
Message-ID: <25aa7ba3fdfbfcb48e13c1b7d008bd9e2ca9fa82.1409792648.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Take the contents from the Armadillo800EVA DT reference DTS
and add them to the "regular" Armadillo800EVA DTS. This is
preparation for removal of the DT reference DTS. So the goal
is to have a single DTS for this Armadillo board.

The SoC "r8a7740" is added to compatible string but the board
is left as-is (excluding the reference suffix).

The kernel command line is left as-is, earlyprintk is used in
case of legacy and for multiplatform we can simply ignore it
for now.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 276 +++++++++++++++++++++++++-
 1 file changed, 275 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index a06a11e..effb7b4 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -10,10 +10,18 @@
 
 /dts-v1/;
 #include "r8a7740.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "armadillo 800 eva";
-	compatible = "renesas,armadillo800eva";
+	compatible = "renesas,armadillo800eva", "renesas,r8a7740";
+
+	aliases {
+		serial1 = &scifa1;
+	};
 
 	chosen {
 		bootargs = "console=tty0 console=ttySC1,115200 earlyprintk=sh-sci.1,115200 ignore_loglevel root=/dev/nfs ip=dhcp rw";
@@ -23,4 +31,270 @@
 		device_type = "memory";
 		reg = <0x40000000 0x20000000>;
 	};
+
+	reg_3p3v: regulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc_sdhi0: regulator at 1 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI0 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&pfc 75 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhi0: regulator at 2 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI0 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_sdhi0>;
+
+		enable-gpio = <&pfc 74 GPIO_ACTIVE_HIGH>;
+		gpios = <&pfc 17 GPIO_ACTIVE_HIGH>;
+		states = <3300000 0
+			  1800000 1>;
+
+		enable-active-high;
+	};
+
+	reg_5p0v: regulator at 3 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-5.0V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		power-key {
+			gpios = <&pfc 99 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			label = "SW3";
+			gpio-key,wakeup;
+		};
+
+		back-key {
+			gpios = <&pfc 100 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_BACK>;
+			label = "SW4";
+		};
+
+		menu-key {
+			gpios = <&pfc 97 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MENU>;
+			label = "SW5";
+		};
+
+		home-key {
+			gpios = <&pfc 98 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOME>;
+			label = "SW6";
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led3 {
+			gpios = <&pfc 102 GPIO_ACTIVE_HIGH>;
+			label = "LED3";
+		};
+		led4 {
+			gpios = <&pfc 111 GPIO_ACTIVE_HIGH>;
+			label = "LED4";
+		};
+		led5 {
+			gpios = <&pfc 110 GPIO_ACTIVE_HIGH>;
+			label = "LED5";
+		};
+		led6 {
+			gpios = <&pfc 177 GPIO_ACTIVE_HIGH>;
+			label = "LED6";
+		};
+	};
+
+	i2c2: i2c at 2 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "i2c-gpio";
+		gpios = <&pfc 208 GPIO_ACTIVE_HIGH /* sda */
+			 &pfc 91 GPIO_ACTIVE_HIGH /* scl */
+			>;
+		i2c-gpio,delay-us = <5>;
+	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&tpu 2 33333 PWM_POLARITY_INVERTED>;
+		brightness-levels = <0 1 2 4 8 16 32 64 128 255>;
+		default-brightness-level = <9>;
+		pinctrl-0 = <&backlight_pins>;
+		pinctrl-names = "default";
+		power-supply = <&reg_5p0v>;
+		enable-gpios = <&pfc 61 GPIO_ACTIVE_HIGH>;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,format = "i2s";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sh_fsi2 0>;
+			bitclock-inversion;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&wm8978>;
+			bitclock-master;
+			frame-master;
+			system-clock-frequency = <12288000>;
+		};
+	};
+};
+
+&ether {
+	pinctrl-0 = <&ether_pins>;
+	pinctrl-names = "default";
+
+	phy-handle = <&phy0>;
+	status = "ok";
+
+	phy0: ethernet-phy at 0 {
+		reg = <0>;
+	};
+};
+
+&extal1_clk {
+	clock-frequency = <25000000>;
+};
+&extal2_clk {
+	clock-frequency = <48000000>;
+};
+&fsibck_clk {
+	clock-frequency = <12288000>;
+};
+&cpg_clocks {
+	renesas,mode = <0x05>; /* MD_CK0 | MD_CK2 */
+};
+
+&cmt1 {
+	status = "ok";
+};
+
+&i2c0 {
+	status = "okay";
+	touchscreen at 55 {
+		compatible = "sitronix,st1232";
+		reg = <0x55>;
+		interrupt-parent = <&irqpin1>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&st1232_pins>;
+		pinctrl-names = "default";
+		gpios = <&pfc 166 GPIO_ACTIVE_LOW>;
+	};
+
+	wm8978: wm8978 at 1a {
+		#sound-dai-cells = <0>;
+		compatible = "wlf,wm8978";
+		reg = <0x1a>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+	rtc at 30 {
+		compatible = "sii,s35390a";
+		reg = <0x30>;
+	};
+};
+
+&pfc {
+	ether_pins: ether {
+		renesas,groups = "gether_mii", "gether_int";
+		renesas,function = "gether";
+	};
+
+	scifa1_pins: serial1 {
+		renesas,groups = "scifa1_data";
+		renesas,function = "scifa1";
+	};
+
+	st1232_pins: touchscreen {
+		renesas,groups = "intc_irq10";
+		renesas,function = "intc";
+	};
+
+	backlight_pins: backlight {
+		renesas,groups = "tpu0_to2_1";
+		renesas,function = "tpu0";
+	};
+
+	mmc0_pins: mmc0 {
+		renesas,groups = "mmc0_data8_1", "mmc0_ctrl_1";
+		renesas,function = "mmc0";
+	};
+
+	sdhi0_pins: sd0 {
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_wp";
+		renesas,function = "sdhi0";
+	};
+
+	fsia_pins: sounda {
+		renesas,groups = "fsia_sclk_in", "fsia_mclk_out",
+				 "fsia_data_in_1", "fsia_data_out_0";
+		renesas,function = "fsia";
+	};
+};
+
+&tpu {
+	status = "okay";
+};
+
+&mmcif0 {
+	pinctrl-0 = <&mmc0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&reg_3p3v>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&scifa1 {
+	pinctrl-0 = <&scifa1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&vcc_sdhi0>;
+	vqmmc-supply = <&vccq_sdhi0>;
+	bus-width = <4>;
+	cd-gpios = <&pfc 167 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&sh_fsi2 {
+	pinctrl-0 = <&fsia_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
 };
-- 
2.0.1
