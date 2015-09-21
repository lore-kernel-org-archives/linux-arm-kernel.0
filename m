From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 21 Sep 2015 13:01:00 +0200
Subject: [PATCH v2 3/3] gpiolib: Add GPIO initialization
In-Reply-To: <1440920686-6892-4-git-send-email-mpa@pengutronix.de>
References: <1440920686-6892-1-git-send-email-mpa@pengutronix.de>
 <1440920686-6892-4-git-send-email-mpa@pengutronix.de>
Message-ID: <20150921110100.GC32203@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 30, 2015 at 09:44:46AM +0200, Markus Pargmann wrote:
> This functions adds a way to initialize a GPIO without hogging it.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/gpio/gpio.txt | 29 +++++++------
>  drivers/gpio/gpiolib-of.c                       |  9 ++++
>  drivers/gpio/gpiolib.c                          | 55 ++++++++++++++++++++-----
>  drivers/gpio/gpiolib.h                          |  2 +
>  4 files changed, 73 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio.txt b/Documentation/devicetree/bindings/gpio/gpio.txt
> index 5788d5cf1252..55d58983ba43 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio.txt
> @@ -116,29 +116,34 @@ Every GPIO controller node must contain both an empty "gpio-controller"
>  property, and a #gpio-cells integer property, which indicates the number of
>  cells in a gpio-specifier.
>  
> -The GPIO chip may contain GPIO hog definitions. GPIO hogging is a mechanism
> -providing automatic GPIO request and configuration as part of the
> -gpio-controller's driver probe function.
> +The GPIO chip may contain GPIO definitions. These define properties for single
> +GPIOs of this controller.
>  
> -Each GPIO hog definition is represented as a child node of the GPIO controller.
> +GPIO hogging is a mechanism providing automatic GPIO request and configuration
> +as part of the gpio-controller's driver probe function.
> +
> +GPIO initialization provides an automatic initialization to known save values.
> +Instead of GPIO hogging the GPIO's value and direction can be modified by other
> +users after it was initialized.
> +
> +Each GPIO definition is represented as a child node of the GPIO controller.
>  Required properties:
> -- gpio-hog:   A property specifying that this child node represent a GPIO hog.
>  - gpios:      Store the GPIO information (id, flags, ...). Shall contain the
>  	      number of cells specified in its parent node (GPIO controller
>  	      node).
> -Only one of the following properties scanned in the order shown below.
> -This means that when multiple properties are present they will be searched
> -in the order presented below and the first match is taken as the intended
> -configuration.
> +
> +Optional properties:
> +- line-name:  The GPIO label name. If not present the node name is used.
> + Only one of gpio-hog and gpio-initval may be specified.
> +- gpio-hog:   A property specifying that this child node represent a GPIO hog.
> +- gpio-initval: This GPIO should be initialized to the specified configuration.

Any feedback on this new DT binding?

Best Regards,

Markus

> + Only one of input, output-low and output-high may be specified:
>  - input:      A property specifying to set the GPIO direction as input.
>  - output-low  A property specifying to set the GPIO direction as output with
>  	      the value low.
>  - output-high A property specifying to set the GPIO direction as output with
>  	      the value high.
>  
> -Optional properties:
> -- line-name:  The GPIO label name. If not present the node name is used.
> -
>  Example of two SOC GPIO banks defined as gpio-controller nodes:
>  
>  	qe_pio_a: gpio-controller at 1400 {
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index f1fe5123da28..ee00c2c63f57 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -234,6 +234,15 @@ static void of_gpiochip_scan_gpios(struct gpio_chip *chip)
>  
>  			if (gpiod_hog(desc, lflags, dflags))
>  				continue;
> +		} else if (of_property_read_bool(np, "gpio-initval")) {
> +			if (!dflags) {
> +				dev_warn(chip->dev, "GPIO line %d (%s): no initialization state specified, bailing out\n",
> +					 desc_to_gpio(desc), np->name);
> +				continue;
> +			}
> +
> +			if (gpiod_initialize(desc, lflags, dflags))
> +				continue;
>  		}
>  	}
>  }
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index f1559fa72c36..d7aa27a92e82 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2178,15 +2178,8 @@ struct gpio_desc *__must_check __gpiod_get_index_optional(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(__gpiod_get_index_optional);
>  
> -/**
> - * gpiod_hog - Hog the specified GPIO desc given the provided flags
> - * @desc:	gpio whose value will be assigned
> - * @lflags:	gpio_lookup_flags - returned from of_find_gpio() or
> - *		of_get_gpio_hog()
> - * @dflags:	gpiod_flags - optional GPIO initialization flags
> - */
> -int gpiod_hog(struct gpio_desc *desc, unsigned long lflags,
> -	      enum gpiod_flags dflags)
> +static int _gpiod_initialize(struct gpio_desc *desc, unsigned long lflags,
> +		      enum gpiod_flags dflags)
>  {
>  	int status;
>  	const char *name = desc->name;
> @@ -2202,11 +2195,31 @@ int gpiod_hog(struct gpio_desc *desc, unsigned long lflags,
>  	status = gpiod_configure_flags(desc, name, lflags, dflags);
>  	if (status < 0) {
>  		pr_err("setup of hog GPIO %s (chip %s, offset %d) failed\n",
> -		       name, gpiod_to_chip(desc)->label, gpio_chip_hwgpio(desc));
> +		       name, gpiod_to_chip(desc)->label,
> +		       gpio_chip_hwgpio(desc));
>  		gpiochip_free_own_desc(desc);
>  		return status;
>  	}
>  
> +	return 0;
> +}
> +
> +/**
> + * gpiod_hog - Hog the specified GPIO desc given the provided flags
> + * @desc:	gpio whose value will be assigned
> + * @lflags:	gpio_lookup_flags - returned from of_find_gpio() or
> + *		of_get_gpio_hog()
> + * @dflags:	gpiod_flags - optional GPIO initialization flags
> + */
> +int gpiod_hog(struct gpio_desc *desc, unsigned long lflags,
> +	      enum gpiod_flags dflags)
> +{
> +	int ret;
> +
> +	ret = _gpiod_initialize(desc, lflags, dflags);
> +	if (ret)
> +		return ret;
> +
>  	/* Mark GPIO as hogged so it can be identified and removed later */
>  	set_bit(FLAG_IS_HOGGED, &desc->flags);
>  
> @@ -2236,6 +2249,28 @@ static void gpiochip_free_hogs(struct gpio_chip *chip)
>  }
>  
>  /**
> + * gpiod_initialize - Initialize a GPIO with a given value
> + * @desc:	gpio whose value will be assigned
> + * @lflags:	gpio_lookup_flags - returned from of_find_gpio() or
> + *		of_get_gpio_hog()
> + * @dflags:	gpiod_flags - optional GPIO initialization flags
> + *
> + * This is used to initialize GPIOs that were defined in DT
> + */
> +int gpiod_initialize(struct gpio_desc *desc, unsigned long lflags,
> +		     enum gpiod_flags dflags)
> +{
> +	int ret;
> +
> +	ret = _gpiod_initialize(desc, lflags, dflags);
> +	if (ret)
> +		return ret;
> +
> +	__gpiod_free(desc);
> +	return ret;
> +}
> +
> +/**
>   * gpiod_get_array - obtain multiple GPIOs from a multi-index GPIO function
>   * @dev:	GPIO consumer, can be NULL for system-global GPIOs
>   * @con_id:	function within the GPIO consumer
> diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> index 6c2aeff59f86..b6dfa3526e3a 100644
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@ -99,6 +99,8 @@ int gpiod_request(struct gpio_desc *desc, const char *label);
>  void gpiod_free(struct gpio_desc *desc);
>  int gpiod_hog(struct gpio_desc *desc, unsigned long lflags,
>  	      enum gpiod_flags dflags);
> +int gpiod_initialize(struct gpio_desc *desc, unsigned long lflags,
> +		     enum gpiod_flags dflags);
>  
>  /*
>   * Return the GPIO number of the passed descriptor relative to its chip
> -- 
> 2.5.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150921/7262705f/attachment.sig>
