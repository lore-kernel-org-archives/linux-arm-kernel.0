From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 28 Jan 2013 10:02:22 +0200
Subject: [PATCH 06/10] gpio: pxa: define nr gpios in platform data
In-Reply-To: <1358929554-32265-7-git-send-email-haojian.zhuang@linaro.org>
References: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
 <1358929554-32265-7-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <5106308E.8050303@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/13 10:25, Haojian Zhuang wrote:
> Avoid to define gpio numbers in gpio driver. Define it in platform data
> instead.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/mach-mmp/aspenite.c      |    1 +
>  arch/arm/mach-mmp/avengers_lite.c |    1 +
>  arch/arm/mach-mmp/brownstone.c    |    1 +
>  arch/arm/mach-mmp/flint.c         |    1 +
>  arch/arm/mach-mmp/gplugd.c        |    1 +
>  arch/arm/mach-mmp/tavorevb.c      |    1 +
>  arch/arm/mach-mmp/teton_bga.c     |    1 +
>  arch/arm/mach-mmp/ttc_dkb.c       |    1 +
>  arch/arm/mach-pxa/pxa25x.c        |    3 +++
>  arch/arm/mach-pxa/pxa27x.c        |    1 +
>  arch/arm/mach-pxa/pxa3xx.c        |   15 +++++++++++-
>  drivers/gpio/gpio-pxa.c           |   48 +++++++------------------------------
>  include/linux/gpio-pxa.h          |    1 +
>  13 files changed, 35 insertions(+), 41 deletions(-)

[...]

> diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
> index 656a1bb..a0cc797 100644
> --- a/arch/arm/mach-pxa/pxa3xx.c
> +++ b/arch/arm/mach-pxa/pxa3xx.c
> @@ -435,6 +435,10 @@ void __init pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info)
>  	pxa_register_device(&pxa3xx_device_i2c_power, info);
>  }
>  
> +static struct pxa_gpio_platform_data pxa3xx_gpio_info __initdata = {
> +	.nr_gpios = 128,
> +};

This misses the:
#include <linux/gpio-pxa.h>

> +
>  static struct platform_device *devices[] __initdata = {
>  	&pxa_device_gpio,
>  	&pxa27x_device_udc,
> @@ -482,8 +486,17 @@ static int __init pxa3xx_init(void)
>  		register_syscore_ops(&pxa3xx_mfp_syscore_ops);
>  		register_syscore_ops(&pxa3xx_clock_syscore_ops);
>  
> -		if (!of_have_populated_dt())
> +		if (!of_have_populated_dt()) {
> +			if (cpu_is_pxa93x())
> +				pxa3xx_gpio_info.nr_gpios = 192;
> +			ret = platform_device_add_data(&pxa_device_gpio,
> +					&pxa3xx_gpio_info,
> +					sizeof(struct pxa_gpio_platform_data);

Closing parenthesis is missing...

> +			if (ret < 0)
> +				break;
> +
>  			ret = platform_add_devices(devices, ARRAY_SIZE(devices));
> +		}
>  	}
>  
>  	return ret;

[...]


-- 
Regards,
Igor.
