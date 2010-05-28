From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 28 May 2010 13:56:20 +0400
Subject: [PATCH 08/15] ARM: SAMSUNG: Add s3c_gpio_cfgall_range() function
In-Reply-To: <1275026212-27510-9-git-send-email-ben-linux@fluff.org>
References: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
	<1275026212-27510-9-git-send-email-ben-linux@fluff.org>
Message-ID: <4BFF9344.8030606@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Ben Dooks wrote:

> Add a function to configure a range of GPIOs function and
> pull in one go, mainly for the SDHCI and framebuffer helpers
> which tend to do this.

> Signed-off-by: Ben Dooks <ben-linux@fluff.org>

    Another little correction.

> diff --git a/arch/arm/plat-samsung/gpio-config.c b/arch/arm/plat-samsung/gpio-config.c
> index a927dd2..3a02e23 100644
> --- a/arch/arm/plat-samsung/gpio-config.c
> +++ b/arch/arm/plat-samsung/gpio-config.c
> @@ -56,6 +56,21 @@ int s3c_gpio_cfgpin_range(unsigned int start, unsigned int nr,
>  }
>  EXPORT_SYMBOL_GPL(s3c_gpio_cfgpin_range);
>  
> +int s3c_gpio_cfgall_range(unsigned int start, unsigned int nr,
> +			  unsigned int cfg, s3c_gpio_pull_t pull)
> +{
> +	int ret;
> +
> +	for (; nr > 0; nr--, start++) {
> +		s3c_gpio_setpull(start, pull);
> +		ret = s3c_gpio_cfgpin(start, cfg);
> +		if (ret != 0)
> +			return ret;
> +	}
> +
> +}
> +EXPORT_SYMBOL_GPL(s3c_gpio_cfgall_range);
> +
>  unsigned s3c_gpio_getcfg(unsigned int pin)
>  {
>  	struct s3c_gpio_chip *chip = s3c_gpiolib_getchip(pin);
> diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg.h b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
> index 8ec9936..bec872f 100644
> --- a/arch/arm/plat-samsung/include/plat/gpio-cfg.h
> +++ b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
> @@ -161,4 +161,24 @@ extern s5p_gpio_drvstr_t s5p_gpio_get_drvstr(unsigned int pin);
>  */
>  extern int s5p_gpio_set_drvstr(unsigned int pin, s5p_gpio_drvstr_t drvstr);
>  
> +/* configure `all` aspects of an gpio */
> +
> +/**
> + * s3c_gpio_cfgall_range() - configure range of gpio functtion and pull.
> + * @gpio: The gpio number to start at.

    But you call it either 'start' ot 'pin'.

> + * @size: The number of gpio to configure.
> + * @cfg: The configuration to use
> + * @pull: The pull setting to use.
> + *
> + * Run s3c_gpio_cfgpin() and s3c_gpio_setpull() over the gpio range starting
> + * @gpio and running for @size.
> + *
> + * @sa s3c_gpio_cfgpin
> + * @sa s3c_gpio_setpull
> + * @sa s3c_gpio_cfgpin_range
> + */
> +extern int s3c_gpio_cfgall_range(unsigned int pin, unsigned int size,

   You call these parameters 'start' and 'nr' where the function is 
defined...

> +				 unsigned int cfg, s3c_gpio_pull_t pull);
> +
> +
>  #endif /* __PLAT_GPIO_CFG_H */

WBR, Sergei
