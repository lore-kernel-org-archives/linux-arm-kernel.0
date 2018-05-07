From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 7 May 2018 09:19:31 +0200
Subject: [PATCH v3 3/3] ARM: dts: sun7i: Add support for the Ainol AW1
 tablet
In-Reply-To: <20180506214901.23429-3-contact@paulk.fr>
References: <20180506214901.23429-1-contact@paulk.fr>
 <20180506214901.23429-3-contact@paulk.fr>
Message-ID: <20180507071931.tebv45yxrojxxkeb@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, May 06, 2018 at 11:49:01PM +0200, Paul Kocialkowski wrote:
> This adds support for the Ainol AW1, an A20-based 7" tablet from Ainol.
> 
> The following board-specific features are supported:
> * LCD panel
> * Backlight
> * USB OTG
> * Buttons
> * Touchscreen (doesn't work without non-free firmware)
> * Accelerometer
> * Battery
> 
> The following are untested:
> * Audio output
> * Audio speakers
> * USB via SPCI connector
> 
> The following are not supported:
> * Wi-Fi
> * Bluetooth
> * NAND
> * Audio via SPCI connector
> * Audio via Bluetooth I2S
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/boot/dts/Makefile                |   1 +
>  arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts | 275 ++++++++++++++++++++++
>  2 files changed, 276 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7e2424957809..4a80971f2bc9 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -946,6 +946,7 @@ dtb-$(CONFIG_MACH_SUN6I) += \
>  	sun6i-a31s-sinovoip-bpi-m2.dtb \
>  	sun6i-a31s-yones-toptech-bs1078-v2.dtb
>  dtb-$(CONFIG_MACH_SUN7I) += \
> +	sun7i-a20-ainol-aw1.dtb \
>  	sun7i-a20-bananapi.dtb \
>  	sun7i-a20-bananapi-m1-plus.dtb \
>  	sun7i-a20-bananapro.dtb \
> diff --git a/arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts b/arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts
> new file mode 100644
> index 000000000000..9a1d54a9f9a0
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts
> @@ -0,0 +1,275 @@
> +/*
> + * Copyright (C) 2018 Paul Kocialkowski <contact@paulk.fr>
> + *
> + * SPDX-License-Identifier: GPL-2.0+

This should be your first line. Also, we usually license our DT under
a dual license (GPL and MIT) so that other projects (like FreeBSD) can
use them as well, instead of duplicating them. It would be great if
you'd consider it.

> + */
> +
> +/dts-v1/;
> +#include "sun7i-a20.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pwm/pwm.h>
> +
> +/ {
> +	model = "Ainol AW1";
> +	compatible = "ainol,ainol-aw1", "allwinner,sun7i-a20";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
> +		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;

The increase in perceived brightness should be linear. Usually, for
PWMs backed backlight, an exponential list is a much better
approximation.

> +		default-brightness-level = <5>;
> +		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
> +	};
> +
> +	panel: panel {
> +		compatible = "innolux,at070tn90";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		power-supply = <&panel_power>;
> +		backlight = <&backlight>;
> +
> +		port at 0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			panel_input: endpoint at 0 {
> +				reg = <0>;
> +				remote-endpoint = <&tcon0_out_panel>;
> +			};
> +		};
> +	};
> +
> +	panel_power: panel_power {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&panel_power_pin>;
> +		regulator-name = "panel-power";
> +		regulator-min-microvolt = <10400000>;
> +		regulator-max-microvolt = <10400000>;
> +		gpio = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
> +		enable-active-high;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&codec {
> +	allwinner,pa-gpios = <&pio 7 15 GPIO_ACTIVE_HIGH>; /* PH15 */
> +	status = "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&reg_dcdc2>;
> +};
> +
> +&de {
> +	status = "okay";
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins_a>;
> +	status = "okay";
> +
> +	axp209: pmic at 34 {
> +		reg = <0x34>;
> +		interrupt-parent = <&nmi_intc>;
> +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins_a>;
> +	status = "okay";
> +
> +	lis3dh: accelerometer at 18 {
> +		compatible = "st,lis3dh-accel";
> +		reg = <0x18>;
> +		vdd-supply = <&reg_vcc3v3>;
> +		vddio-supply = <&reg_vcc3v3>;
> +		st,drdy-int-pin = <1>;
> +	};
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins_a>;
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	gsl1680: touchscreen at 40 {
> +		compatible = "silead,gsl1680";
> +		reg = <0x40>;
> +		interrupt-parent = <&pio>;
> +		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>; /* EINT21 (PH21) */
> +		power-gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>; /* PH20 */
> +		firmware-name = "gsl1680-ainol-aw1.fw";
> +		touchscreen-size-x = <480>;
> +		touchscreen-size-y = <800>;
> +		touchscreen-swapped-x-y;
> +		touchscreen-inverted-y;
> +		silead,max-fingers = <5>;
> +	};
> +};
> +
> +&lradc {
> +	vref-supply = <&reg_ldo2>;
> +	status = "okay";
> +
> +	button at 571 {
> +		label = "Volume Up";
> +		linux,code = <KEY_VOLUMEUP>;
> +		channel = <0>;
> +		voltage = <571428>;
> +	};
> +
> +	button at 761 {
> +		label = "Volume Down";
> +		linux,code = <KEY_VOLUMEDOWN>;
> +		channel = <0>;
> +		voltage = <761904>;
> +	};
> +
> +	button at 952 {
> +		label = "Home";
> +		linux,code = <KEY_HOME>;
> +		channel = <0>;
> +		voltage = <952380>;
> +	};
> +};
> +
> +&mmc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_pins_a>;
> +	vmmc-supply = <&reg_vcc3v3>;

You have the regulators described in your DT, you'd better use them
instead of the one coming from sunxi-common-regulators.dtsi.

> +	bus-width = <4>;
> +	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> +	cd-inverted;
> +	status = "okay";
> +};
> +
> +&ohci0 {
> +	status = "okay";
> +};
> +
> +&ohci1 {
> +	status = "okay";
> +};
> +
> +&otg_sram {
> +	status = "okay";
> +};
> +
> +&pio {
> +	panel_power_pin: panel_power_pin at 0 {
> +		pins = "PH8";
> +		function = "gpio_out";
> +	};
> +};

You don't need that pinctrl node.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180507/19ecef0e/attachment.sig>
