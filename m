From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Wed, 6 Jan 2016 09:03:58 +0100
Subject: [PATCH v2 1/2] ARM: dts: imx6: Add support for Toradex Apalis
 iMX6Q/D SoM
In-Reply-To: <1452011942-11940-2-git-send-email-marcel.ziswiler@toradex.com>
References: <1452011942-11940-1-git-send-email-marcel.ziswiler@toradex.com>
 <1452011942-11940-2-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <20160106080358.GD9030@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marcel Ziswiler <marcel.ziswiler@toradex.com> [2016-01-05 17:39:01]:

Hi Marcel,

thanks for taking care of this, I'm quite busy with other tasks :(

> - integrated review feedback from Lucas

You've probably missed few of them :) See my nitpicks bellow.

> - left and even added some more comments as I don't see why putting any
>   explanatory comments in dts' should be such a bad thing to do

You've marked this as v2 so I think, that you should only work on the
feedback. Ideally you shouldn't add any new stuff if it wasn't requested
otherwise you're wasting reviewer time.

> - completely got rid of the memory node as that is something typically filled
>   in by the boot loader e.g. U-Boot

If I'm not mistaken, it wasn't requested by the reviewer.

> - without the regulators simple-bus it no longer boots

It works for me on 4.4.0-rc3 with following DTS[1]. BTW, this DTS is my
preparation for v2 patch series.

> - fixed Ethernet PHY reset & interrupt (requires Micrel PHY driver to be
>   enabled)

Great!

> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.

Hope you've some kind of ACK from FSL and Linaro :)

> +		reg_usb_otg_vbus: usb_otg_vbus {
> +			compatible = "regulator-fixed";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_regulator_usbotg_pwr>;
> +			regulator-name = "usb_otg_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
> +			enable-active-high;
> +			status = "disabled";
> +		};

I'm not sure, but it seems to me, that we should move this regulator into the
carrier board DTS. On our custom carrier board we've this regulator always on
and we use this GPIO for heartbeat LED, so I've this in our carrier board
DTS[2]:

	reg_usb_otg_vbus: usb_otg_vbus {
		/* Regulator is always on, and we use GPIO for heartbeat LED */
		pinctrl-0 = <>;
		gpio = <>;

		compatible = "regulator-fixed";
		regulator-name = "usb_otg_vbus";
		regulator-min-microvolt = <5000000>;
		regulator-max-microvolt = <5000000>;
		regulator-always-on;
	};

	...

	usbotg {
		/* GPIO3_IO22 is Heartbeat LED */
		pinctrl_regulator_usbotg_pwr: gpio_regulator_usbotg_pwr {
		};
	};

> +/* PAD Ctrl values for common settings */
> +/*
> + * (PAD_CTL_HYS | PAD_CTL_PUS_100K_UP | PAD_CTL_PUE | PAD_CTL_PKE |
> + *  PAD_CTL_SPEED_MED | PAD_CTL_DSE_40ohm)
> + */
> +#define PAD_CTRL_HYS_PU 0x1b0b0

This was requested to be reworked. I've simply replaced all the macros with
hex values.

> +		pinctrl_usdhc3_100mhz: usdhc3grp-100mhz { /* 100Mhz */
> +			fsl,pins = <
> +				MX6QDL_PAD_SD3_CMD__SD3_CMD 0x170B9

As per review comments, all hex values should be lowercase.

1. https://github.com/ynezz/linux-2.6/blob/b27de46e67605fe1a8e386b065845a9708e8e792/arch/arm/boot/dts/imx6qdl-apalis.dtsi
2. https://github.com/ynezz/linux-2.6/blob/ec678e3734d9fff35f7ba9605469a68a3e424020/arch/arm/boot/dts/imx6qdl-apalis-gaben-flexisbc.dtsi#L143

Thanks!

-- ynezz
