From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 11 May 2015 09:22:16 +0200
Subject: [PATCH 2/6] pinctrl: sunxi: add allwinner A33 PIO controller
 support
In-Reply-To: <1431240383-12763-3-git-send-email-vishnupatekar0510@gmail.com>
References: <1431240383-12763-1-git-send-email-vishnupatekar0510@gmail.com>
 <1431240383-12763-3-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1431328936.2398.67.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2015-05-10 at 12:16 +0530, Vishnu Patekar wrote:
> --- a/drivers/pinctrl/sunxi/Kconfig
> +++ b/drivers/pinctrl/sunxi/Kconfig

> +

(Unneeded white line.)

> +config PINCTRL_SUN8I_A33
> +	def_bool MACH_SUN8I
> +	select PINCTRL_SUNXI_COMMON

> --- a/drivers/pinctrl/sunxi/Makefile
> +++ b/drivers/pinctrl/sunxi/Makefile

> +obj-$(CONFIG_PINCTRL_SUN8I_A33)		+= pinctrl-sun8i-a33.o

PINCTRL_SUN8I_A33 is a bool symbol, so pinctrl-sun8i-a33.o will never be
part of a module, right?

> --- /dev/null
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c
> @@ -0,0 +1,513 @@

> +#include <linux/module.h>

> +MODULE_DEVICE_TABLE(of, sun8i_a33_pinctrl_match);
> +
> +static struct platform_driver sun8i_a33_pinctrl_driver = {
> +	.probe	= sun8i_a33_pinctrl_probe,
> +	.driver	= {
> +		.name		= "sun8i-a33-pinctrl",
> +		.of_match_table	= sun8i_a33_pinctrl_match,
> +	},
> +};
> +module_platform_driver(sun8i_a33_pinctrl_driver);

(The series starting at https://lkml.org/lkml/2015/5/10/131 would allow
to use builtin_platform_driver() for  built-in only code.)

> +MODULE_AUTHOR("Vishnu Patekar <vishnupatekar0510@gmail.com>");
> +MODULE_DESCRIPTION("Allwinner a33 pinctrl driver");
> +MODULE_LICENSE("GPL");

This adds some module specific boilerplate. Was it perhaps your
intention to make PINCTRL_SUN8I_A33 a tristate symbol? If I understand
Maxime correctly drivers like these can be made modular (see
https://lkml.org/lkml/2015/5/9/96 ).

Thanks,


Paul Bolle
