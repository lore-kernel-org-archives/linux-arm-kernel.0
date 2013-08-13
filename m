From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 Aug 2013 22:30:01 +0200
Subject: [PATCH] ARM: sunxi: dt: Add device tree for Mele A1000
In-Reply-To: <1376420865-4650-1-git-send-email-emilio@elopez.com.ar>
References: <1376420865-4650-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <20130813203001.GC28819@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On Tue, Aug 13, 2013 at 04:07:45PM -0300, Emilio L?pez wrote:
> This adds a device tree usable on Mele A1000 (and A2000, as it
> apparently is the same device except for the case). This device features
> one UART port, Ethernet, an AXP209 PMU on i2c0 and two user configurable
> LEDs.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
> 
> This has been tested by arokux on #linux-sunxi in Freenode and found to 
> work correctly.
>
>  arch/arm/boot/dts/Makefile            |   1 +
>  arch/arm/boot/dts/sun4i-a10-a1000.dts | 106 ++++++++++++++++++++++++++++++++++
>  2 files changed, 107 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun4i-a10-a1000.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 641b3c9..3fd3919 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -206,6 +206,7 @@ dtb-$(CONFIG_ARCH_STI)+= stih415-b2000.dtb \
>  	stih415-b2020.dtb \
>  	stih416-b2020.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += \
> +	sun4i-a10-a1000.dtb \
>  	sun4i-a10-cubieboard.dtb \
>  	sun4i-a10-mini-xplus.dtb \
>  	sun4i-a10-hackberry.dtb \
> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> new file mode 100644
> index 0000000..304a38e
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> @@ -0,0 +1,106 @@
> +/*
> + * Copyright 2013 Emilio L?pez
> + *
> + * Emilio L?pez <emilio@elopez.com.ar>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +/include/ "sun4i-a10.dtsi"
> +
> +/ {
> +	model = "Mele A1000";
> +	compatible = "mele,a1000", "allwinner,sun4i-a10";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		bootargs = "earlyprintk console=ttyS0,115200";
> +	};

That's not quite useful anymore now that we have a DT-aware bootloader,
I'd remove it.

> +
> +	soc at 01c20000 {
> +		emac: ethernet at 01c0b000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&emac_pins_a>;
> +			phy = <&phy1>;
> +			status = "okay";
> +		};
> +
> +		mdio at 01c0b080 {
> +			phy-supply = <&reg_emac_3v3>;
> +			status = "okay";
> +
> +			phy1: ethernet-phy at 1 {
> +				reg = <1>;
> +			};
> +		};
> +
> +		pinctrl at 01c20800 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&a1000_hogs>;
> +
> +			a1000_hogs: hogs at 0 {
> +				allwinner,pins = "PH15";
> +				allwinner,function = "gpio_out";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};

Why using the hog pins here? I don't think you require it anymore, just
grab the pinctrl node from the regulator, it should work, right?

> +
> +			led_pins_a1000: led_pins at 0 {
> +				allwinner,pins = "PH10", "PH20";
> +				allwinner,function = "gpio_out";
> +				allwinner,drive = <1>;

Do you really need the extra 10 mA here?

> +				allwinner,pull = <0>;
> +			};
> +		};
> +
> +		uart0: serial at 01c28000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&uart0_pins_a>;
> +			status = "okay";
> +		};
> +
> +		i2c0: i2c at 01c2ac00 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c0_pins_a>;
> +			status = "okay";
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pins_a1000>;
> +
> +		red {
> +			label = "a1000:red:usr";
> +			gpios = <&pio 7 10 0>;
> +		};
> +
> +		blue {
> +			label = "a1000:blue:usr";
> +			gpios = <&pio 7 20 0>;
> +		};
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +
> +		reg_emac_3v3: emac-3v3 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "emac-3v3";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			enable-active-high;
> +			gpio = <&pio 7 15 0>;
> +		};
> +	};
> +};
> -- 
> 1.8.3.4
> 

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130813/eb6377c4/attachment.sig>
