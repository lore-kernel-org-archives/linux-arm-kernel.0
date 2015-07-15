From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 15 Jul 2015 10:02:58 +0200
Subject: [PATCH] ARM: dts: socfpga: Add support of Terasic DE0 Atlas board
In-Reply-To: <1436908987-16038-1-git-send-email-dinguyen@opensource.altera.com>
References: <1436908987-16038-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <20150715080258.GA29885@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Tue, Jul 14, 2015 at 04:23:07PM -0500, dinguyen at opensource.altera.com wrote:
> From: Dalon Westergreen <dwesterg@gmail.com>
> 
> The Terasic DE0 Atlas board is also known as the DE0-Nano board.
> 
> Signed-off-by: Dalon Westergreen <dwesterg@gmail.com>
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
>  arch/arm/boot/dts/Makefile                        |    1 +
>  arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts |  109 +++++++++++++++++++++
>  2 files changed, 110 insertions(+)
>  create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 246473a..29e33aa 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -522,6 +522,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) += \
>  	socfpga_arria5_socdk.dtb \
>  	socfpga_arria10_socdk_sdmmc.dtb \
>  	socfpga_cyclone5_socdk.dtb \
> +	socfpga_cyclone5_de0_sockit.dtb \
                             ^^^^^^

Is that intentional? Terasic doesn't mention sockit at all in the name
of the board.

>  	socfpga_cyclone5_sockit.dtb \
>  	socfpga_cyclone5_socrates.dtb \
>  	socfpga_vt.dtb
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
> new file mode 100644
> index 0000000..3172c82
> --- /dev/null
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
> @@ -0,0 +1,109 @@
> +/*
> + * Copyright Altera Corporation (C) 2015. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "socfpga_cyclone5.dtsi"
> +
> +/ {
> +	model = "Terasic DE-0(Atlas)";
> +	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200";
> +	};
> +
> +	memory {
> +		name = "memory";
> +		device_type = "memory";
> +		reg = <0x0 0x40000000>; /* 1GB */
> +	};
> +
> +	aliases {
> +		/* this allow the ethaddr uboot environmnet variable contents
> +		 * to be added to the gmac1 device tree blob.
> +		 */

I'd personally like to get rid of these types of comments in the dts.
It doesn't matter what uboot needs or does IMHO.

> +		ethernet0 = &gmac1;
> +	};
> +
> +	regulator_3_3v: 3-3-v-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3.3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		hps0 {
> +			label = "hps_led0";
> +			gpios = <&portb 24 0>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +};
> +
> +&gmac1 {
> +	status = "okay";
> +	phy-mode = "rgmii";
> +
> +	rxd0-skew-ps = <0>;
> +	rxd1-skew-ps = <0>;
> +	rxd2-skew-ps = <0>;
> +	rxd3-skew-ps = <0>;
> +	txen-skew-ps = <0>;
> +	txc-skew-ps = <2600>;
> +	rxdv-skew-ps = <0>;
> +	rxc-skew-ps = <2000>;
> +	max-frame-size = <3800>;
> +};
> +
> +&gpio0 {
> +	status = "okay";
> +};
> +
> +&gpio1 {
> +	status = "okay";
> +};
> +
> +&gpio2 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +	speed-mode = <0>;
> +
> +	adxl345: adxl345 at 0 {
> +		compatible = "adi,adxl345";
> +		reg = <0x53>;
> +
> +		interrupt-parent = <&portc>;
> +		interrupts = <3 2>;
> +	};
> +	
> +};
> +
> +&mmc0 {
> +	vmmc-supply = <&regulator_3_3v>;
> +	vqmmc-supply = <&regulator_3_3v>;
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	status = "okay";
> +};

Rest looks okay to me.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
