From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2012 08:40:42 +0000
Subject: [PATCH v4 03/10] pwm: Add device tree support
In-Reply-To: <1331740593-10807-4-git-send-email-thierry.reding@avionic-design.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-4-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <201203150840.42659.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 March 2012, Thierry Reding wrote:
> This patch adds helpers to support device tree bindings for the generic
> PWM API. Device tree binding documentation for PWM controllers is also
> provided.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
> Changes in v4:
>   - add OF-specific code removed from patch 2
>   - make of_node_to_pwmchip() and of_pwm_simple_xlate() static
>   - rename of_get_named_pwm() to of_pwm_request(), return a struct
>     pwm_device, get rid of the now unused spec parameter and use the
>     device_node.name field as the PWM's name
>   - return a requested struct pwm_device from pwm_chip.of_xlate and
>     drop the now unused spec parameter
>   - move OF support code into drivers/pwm/core.c
>   - used deferred probing if a PWM chip is not available yet
> 
> Changes in v2:
>   - add device tree binding documentation
>   - add of_xlate to parse controller-specific PWM-specifier

Looks very cool now, and much simpler!

> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 6ea51dc..d47b8ee 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -57,6 +57,12 @@ config OF_GPIO
>  	help
>  	  OpenFirmware GPIO accessors
>  
> +config OF_PWM
> +	def_bool y
> +	depends on PWM
> +	help
> +	  OpenFirmware PWM accessors
> +
>  config OF_I2C
>  	def_tristate I2C
>  	depends on I2C && !SPARC

You might want to remove this one now and just use CONFIG_OF in the driver,
unless there is  a reason to keep it here.

> +#ifdef CONFIG_OF_PWM
> +static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
> +{
> +	struct pwm_chip *chip;
> +
> +	mutex_lock(&pwm_lock);
> +
> +	list_for_each_entry(chip, &pwm_chips, list)
> +		if (chip->dev && chip->dev->of_node == np) {
> +			mutex_unlock(&pwm_lock);
> +			return chip;
> +		}
> +
> +	mutex_unlock(&pwm_lock);
> +
> +	return ERR_PTR(-EPROBE_DEFER);
> +}

EPROBE_DEFER doesn't exist yet in my kernel, and I wonder if it's actually
safe to be used this way, because it can result in arbitrary drivers using
this to be put on the defered probe list. It certainly sounds like the
right thing to do in the long run though.

> +#else
> +static inline void of_pwmchip_add(struct pwm_chip *pc)
> +{
> +}
> +
> +static inline void of_pwmchip_remove(struct pwm_chip *pc)
> +{
> +}
> +#endif /* CONFIG_OF_PWM */
> +
>  /**
>   * pwm_set_chip_data - set private chip data for a PWM
>   * @pwm: PWM device
> @@ -184,6 +254,7 @@ int pwmchip_add(struct pwm_chip *chip)
>  
>  	INIT_LIST_HEAD(&chip->list);
>  	list_add(&chip->list, &pwm_chips);
> +	of_pwmchip_add(chip);
>  
>  out:
>  	mutex_unlock(&pwm_lock);

You could express the same thing using 

	if (IS_ENABLED(CONFIG_OF_PWM))
		of_pwmchip_add(chip);

The advantage of this is that you always get compile coverage for the
entire file, but the function is automatically discarded by the
compiler when the condition is false at compile time. That obviously
doesn't work for exported functions.

> +#ifdef CONFIG_OF
> +/**
> + * of_pwm_request() - request a PWM via the PWM framework
> + * @np: device node to get the PWM from
> + * @propname: property name containing PWM specifier(s)
> + * @index: index of the PWM
> + *
> + * Returns the PWM device parsed from the phandle specified in the given
> + * property of a device tree node or NULL on failure. Values parsed from
> + * the device tree are stored in the returned PWM device object.
> + */
> +struct pwm_device *of_pwm_request(struct device_node *np,
> +				  const char *propname, int index)
> +{
> +	struct pwm_device *pwm = NULL;
> +	struct of_phandle_args args;
> +	struct pwm_chip *pc;
> +	int err;
> +
> +	err = of_parse_phandle_with_args(np, propname, "#pwm-cells", index,
> +					 &args);

Wow, I just looked up what of_parse_phandle_with_args() does and that is
extremely helpful indeed.

>  /*
> @@ -102,6 +104,12 @@ struct pwm_chip {
>  	unsigned int		npwm;
>  
>  	struct pwm_device	*pwms;
> +
> +#ifdef CONFIG_OF_PWM
> +	struct pwm_device *	(*of_xlate)(struct pwm_chip *pc,
> +					    const struct of_phandle_args *args);
> +	unsigned int		of_pwm_n_cells;
> +#endif
>  };
>  
>  int pwm_set_chip_data(struct pwm_device *pwm, void *data);

If you use IS_ENABLED() as I suggested above, this #ifdef will have to go
away, too, which is a very small size overhead.

	Arnd
