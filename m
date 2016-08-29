From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Mon, 29 Aug 2016 16:28:50 +0300
Subject: [PATCH v5 1/2] ARM: dts: imx6: Add support for Toradex Apalis
 iMX6Q/D SoM
In-Reply-To: <1454688741-4238-2-git-send-email-marcel.ziswiler@toradex.com>
References: <1454688741-4238-1-git-send-email-marcel.ziswiler@toradex.com>
 <1454688741-4238-2-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <97a3d506-35a0-2a15-18ef-2719c0596cc1@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcel,

On 02/05/2016 06:12 PM, Marcel Ziswiler wrote:
> From: Petr ?tetiar <ynezz@true.cz>
>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: Petr ?tetiar <ynezz@true.cz>
> Reviewed-by: Stefan Agner <stefan@agner.ch>
> ---
>

because the change is in mainline now below is kind of out of date
information, but you may find it helpful.

[snip]

> - fixed HDMI DDC (requires GPIO-based bitbanging I2C to be enabled)

This is not needed.

[snip]

> +	/* DDC_I2C: I2C2_SDA/SCL on MXM3 205/207 */
> +	i2cddc: i2c at 0 {
> +		compatible = "i2c-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_i2c_ddc>;
> +		gpios = <&gpio3 16 GPIO_ACTIVE_HIGH /* sda */
> +			 &gpio2 30 GPIO_ACTIVE_HIGH /* scl */
> +			>;
> +		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
> +		status = "disabled";
> +	};
> +

This is not needed.

[snip]

> +	pinctrl_i2c_ddc: gpioi2cddcgrp {
> +		fsl,pins = <
> +			/* DDC bitbang */
> +			MX6QDL_PAD_EIM_EB2__GPIO2_IO30 0x1b0b0
> +			MX6QDL_PAD_EIM_D16__GPIO3_IO16 0x1b0b0
> +		>;
> +	};
> +

Practically you don't need this overcomplicated GPIO-based bitbanging
to emulate I2C, because the DW HDMI controller has a reduced I2C
controller on board, you may take a look at its support published here:

    http://www.spinics.net/lists/dri-devel/msg116308.html

To utilize it the pads should be set to HDMI function instead of
I2C or GPIO.

--
With best wishes,
Vladimir
