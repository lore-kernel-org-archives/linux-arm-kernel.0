From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Dec 2011 16:19:06 +0000
Subject: [PATCH V2 1/2] pinctrl: enable pinmux for pxa series
In-Reply-To: <1323769253-22580-2-git-send-email-haojian.zhuang@marvell.com>
References: <1323769253-22580-1-git-send-email-haojian.zhuang@marvell.com>
 <1323769253-22580-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <201112131619.07181.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 December 2011, Haojian Zhuang wrote:
> Support pxa3xx/pxa168/pxa910/mmp2. Support to switch pin configuration.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  drivers/pinctrl/Kconfig          |   15 +
>  drivers/pinctrl/Makefile         |    3 +
>  drivers/pinctrl/pinctrl-pxa3xx.c |  193 +++++++++++
>  drivers/pinctrl/pinmux-pxa168.c  |  170 ++++++++++
>  drivers/pinctrl/pinmux-pxa300.c  |  647 ++++++++++++++++++++++++++++++++++++++
>  drivers/pinctrl/pinmux-pxa910.c  |  373 ++++++++++++++++++++++
>  include/linux/pinctrl/pxa3xx.h   |  213 +++++++++++++

I like the split of the files, even though the common parts turned out much
smaller than I had hoped, in comparison with the pxa300 specific parts.

I think the header file should be in drivers/pinctrl/pinctrl-pxa3xx.h
instead of a globally visible directory. If there are parts that are
absolutely required to be visible to platform code, make those explicit
by putting them into a separate global header file.

> +static int pxa3xx_get_gpio_func(enum pxa_cpu_type cputype, unsigned int gpio)
> +{
> +	int ret = 0;
> +
> +	switch (cputype) {
> +	case PINMUX_PXA300:
> +	case PINMUX_PXA310:
> +		if (gpio == 50)
> +			ret = 2;
> +		else if (gpio == 49 || gpio == 51 || gpio == 53)
> +			ret = 3;
> +		break;
> +	case PINMUX_PXA320:
> +		if (gpio == 56 || (gpio > 58 && gpio < 63))
> +			goto out;
> +		break;
> +	case PINMUX_PXA168:
> +		if ((gpio >= 0 && gpio < 16) || gpio == 17 || gpio == 19 ||
> +			(gpio > 20 && gpio < 26) || (gpio > 26 && gpio < 34))
> +			ret = 1;
> +		break;
> +	case PINMUX_PXA910:
> +		if ((gpio > 116 && gpio < 121) || gpio == 122 || gpio == 123 ||
> +			gpio == 125 || gpio == 99 || gpio == 58 || gpio == 59)
> +			ret = 1;
> +		break;
> +	case PINMUX_PXA930:
> +		if (gpio == 83)
> +			goto out;
> +		break;
> +	case PINMUX_MMP2:
> +		if ((gpio > 101 && gpio < 114) || (gpio > 141 && gpio <= 168))
> +			ret = 1;
> +		break;
> +	default:
> +		goto out;
> +	}
> +	return ret & MFPR_FUNC;
> +out:
> +	return -1;
> +}

This one feels a little silly: you basically combine six entirely different
functions into one and then multiplex by the device type. I think it
would be better to have individual function pointers in pxa3xx_pinmux_info
that are set to the trivial per-soc function. Not all that important
to me though, the code you have here is basically ok.

> +#define GPIO0_GPIO106_PINS()						\
> +	PINCTRL_PIN(0, "GPIO0"), 	PINCTRL_PIN(1, "GPIO1"),	\
> +	PINCTRL_PIN(2, "GPIO2"),	PINCTRL_PIN(3, "GPIO3"),	\
> +	PINCTRL_PIN(4, "GPIO4"),	PINCTRL_PIN(5, "GPIO5"),	\
> +	PINCTRL_PIN(6, "GPIO6"),	PINCTRL_PIN(7, "GPIO7"),	\
> +	PINCTRL_PIN(8, "GPIO8"),	PINCTRL_PIN(9, "GPIO9"),	\
> ...
> +#define GPIO107_GPIO122_PINS()					\
> +	PINCTRL_PIN(107, "GPIO107"),	PINCTRL_PIN(108, "GPIO108"),	\
> +	PINCTRL_PIN(109, "GPIO109"),	PINCTRL_PIN(110, "GPIO110"),	\
> +	PINCTRL_PIN(111, "GPIO111"),	PINCTRL_PIN(112, "GPIO112"),	\
> ...
> +#define GPIO123_GPIO127_PINS()					\
> +	PINCTRL_PIN(123, "GPIO123"),	PINCTRL_PIN(124, "GPIO124"),	\
> +	PINCTRL_PIN(125, "GPIO125"),	PINCTRL_PIN(126, "GPIO126"),	\
> +	PINCTRL_PIN(127, "GPIO127")
> ...
> +#define GPIO128_GPIO168_PINS()					\
> +	PINCTRL_PIN(128, "GPIO128"),	PINCTRL_PIN(129, "GPIO129"),	\
> +	PINCTRL_PIN(130, "GPIO130"),	PINCTRL_PIN(131, "GPIO131"),	\
> +	PINCTRL_PIN(132, "GPIO132"),	PINCTRL_PIN(133, "GPIO133"),	\

This one seems more problematic to me. I think these endless macros
very much inhibit readability and cause bloat in the code by duplicating
the same data for each soc.

Ideally, you should not be required to write such pointless lists, but
I don't know if the pinctrl subsystem can provide a better alternative.

Since each pxa chip seems to have a list of trivial pins (between 107 and
169 of them) as well as a few special ones, I think you can do away
with the macros entirely by splitting the list into two and making the
169 simple entries a global array in pinctrl-pxa3xx.c, while the
count of those that are present as well as the array of specific
ones are simply an open-coded property of the individual soc.

Does that make sense?

	Arnd
