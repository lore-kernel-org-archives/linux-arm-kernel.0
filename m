From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 25 Jul 2017 13:53:43 +0200
Subject: [PATCH 2/2] pwm: add ZTE ZX PWM device driver
In-Reply-To: <1498704874-14599-3-git-send-email-shawnguo@kernel.org>
References: <1498704874-14599-1-git-send-email-shawnguo@kernel.org>
 <1498704874-14599-3-git-send-email-shawnguo@kernel.org>
Message-ID: <20170725115343.GD22355@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 10:54:34AM +0800, Shawn Guo wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
> 
> It adds PWM device driver for ZTE ZX family SoCs.  The PWM controller
> supports 4 devices with polarity configuration.
> 
> The driver has been tested with pwm-regulator support to scale core
> voltage via cpufreq.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/pwm/Kconfig  |   9 ++
>  drivers/pwm/Makefile |   1 +
>  drivers/pwm/pwm-zx.c | 244 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 254 insertions(+)
>  create mode 100644 drivers/pwm/pwm-zx.c

Hi Shawn,

This is close to perfect. Two minor things, see below.

> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 313c10789ca2..e98175331a69 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -500,4 +500,13 @@ config PWM_VT8500
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-vt8500.
>  
> +config PWM_ZX
> +	tristate "ZTE ZX PWM support"
> +	depends on ARCH_ZX
> +	help
> +	  Generic PWM framework driver for ZTE ZX family SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-zx.
> +
>  endif
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 93da1f79a3b8..75ab74094d7b 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -49,3 +49,4 @@ obj-$(CONFIG_PWM_TIPWMSS)	+= pwm-tipwmss.o
>  obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
>  obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
>  obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
> +obj-$(CONFIG_PWM_ZX)		+= pwm-zx.o
> diff --git a/drivers/pwm/pwm-zx.c b/drivers/pwm/pwm-zx.c
> new file mode 100644
> index 000000000000..5c81c2ddc0a9
> --- /dev/null
> +++ b/drivers/pwm/pwm-zx.c
> @@ -0,0 +1,244 @@
> +/*
> + * Copyright (C) 2017 Sanechips Technology Co., Ltd.
> + * Copyright 2017 Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +
> +#define ZX_PWM_MODE		0x0
> +#define ZX_PWM_CLKDIV_MASK	GENMASK(11, 2)
> +#define ZX_PWM_CLKDIV(x)	(((x) << 8) & ZX_PWM_CLKDIV_MASK)
> +#define ZX_PWM_POLAR		BIT(1)
> +#define ZX_PWM_EN		BIT(0)
> +#define ZX_PWM_PERIOD		0x4
> +#define ZX_PWM_DUTY		0x8
> +
> +#define ZX_PWM_CLKDIV_MAX	1023
> +#define ZX_PWM_PERIOD_MAX	65535
> +
> +struct zx_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *pclk;
> +	struct clk *wclk;
> +	void __iomem *base;
> +};
> +
> +#define to_zx_pwm_chip(_chip) container_of(_chip, struct zx_pwm_chip, chip)

Please use a static inline function for this. That way diagnostic
messages from the compiler make more sense.

[...]
> +static const struct pwm_ops zx_pwm_ops = {
> +	.config = zx_pwm_config,
> +	.enable = zx_pwm_enable,
> +	.disable = zx_pwm_disable,
> +	.set_polarity = zx_pwm_set_polarity,
> +	.owner = THIS_MODULE,
> +};

Please convert this to implement the atomic PWM callbacks (->apply() and
->get_state()).

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170725/8c21e80f/attachment.sig>
