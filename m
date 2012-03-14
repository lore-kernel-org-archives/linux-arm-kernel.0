From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 14 Mar 2012 21:11:38 +0100
Subject: [PATCH v4 03/10] pwm: Add device tree support
In-Reply-To: <1331740593-10807-4-git-send-email-thierry.reding@avionic-design.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-4-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120314201138.GU3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 04:56:26PM +0100, Thierry Reding wrote:
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
> 
>  Documentation/devicetree/bindings/pwm/pwm.txt |   48 ++++++++++
>  drivers/of/Kconfig                            |    6 ++
>  drivers/pwm/core.c                            |  127 +++++++++++++++++++++++++
>  include/linux/of_pwm.h                        |   36 +++++++
>  include/linux/pwm.h                           |    8 ++
>  5 files changed, 225 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm.txt
>  create mode 100644 include/linux/of_pwm.h
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
> new file mode 100644
> index 0000000..9421fe7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> @@ -0,0 +1,48 @@
> +Specifying PWM information for devices
> +======================================
> +
> +1) PWM user nodes
> +-----------------
> +
> +PWM users should specify a list of PWM devices that they want to use
> +with a property containing a 'pwm-list':
> +
> +	pwm-list ::= <single-pwm> [pwm-list]
> +	single-pwm ::= <pwm-phandle> <pwm-specifier>
> +	pwm-phandle : phandle to PWM controller node
> +	pwm-specifier : array of #pwm-cells specifying the given PWM
> +			(controller specific)
> +
> +PWM properties should be named "[<name>-]pwms". Exact meaning of each
> +pwms property must be documented in the device tree binding for each
> +device.
> +
> +The following example could be used to describe a PWM-based backlight
> +device:
> +
> +	pwm: pwm {
> +		#pwm-cells = <2>;
> +	};
> +
> +	[...]
> +
> +	bl: backlight {
> +		pwms = <&pwm 0 5000000>;
> +	};
> +
> +pwm-specifier typically encodes the chip-relative PWM number and the PWM
> +period in nanoseconds.
> +
> +2) PWM controller nodes
> +-----------------------
> +
> +PWM controller nodes must specify the number of cells used for the
> +specifier using the '#pwm-cells' property.
> +
> +An example PWM controller might look like this:
> +
> +	pwm: pwm at 7000a000 {
> +		compatible = "nvidia,tegra20-pwm";
> +		reg = <0x7000a000 0x100>;
> +		#pwm-cells = <2>;
> +	};
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
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 74dd295..c600606 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -20,6 +20,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/of_pwm.h>
>  #include <linux/pwm.h>
>  #include <linux/radix-tree.h>
>  #include <linux/list.h>
> @@ -121,6 +122,75 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
>  	return 0;
>  }
>  
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
> +
> +static struct pwm_device *of_pwm_simple_xlate(struct pwm_chip *pc,
> +					      const struct of_phandle_args *args)
> +{
> +	struct pwm_device *pwm;
> +
> +	if (pc->of_pwm_n_cells < 2)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (args->args_count < pc->of_pwm_n_cells)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (args->args[0] >= pc->npwm)
> +		return ERR_PTR(-EINVAL);
> +
> +	pwm = pwm_request_from_device(pc->dev, args->args[0], NULL);
> +	if (IS_ERR(pwm))
> +		return ERR_PTR(-ENODEV);
> +
> +	pwm_set_period(pwm, args->args[1]);
> +
> +	return pwm;
> +}
> +
> +void of_pwmchip_add(struct pwm_chip *chip)
> +{
> +	if (!chip->dev || !chip->dev->of_node)
> +		return;
> +
> +	if (!chip->of_xlate) {
> +		chip->of_xlate = of_pwm_simple_xlate;
> +		chip->of_pwm_n_cells = 2;
> +	}
> +
> +	of_node_get(chip->dev->of_node);
> +}
> +
> +void of_pwmchip_remove(struct pwm_chip *chip)
> +{
> +	if (chip->dev && chip->dev->of_node)
> +		of_node_put(chip->dev->of_node);
> +}
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
> @@ -215,6 +286,7 @@ int pwmchip_remove(struct pwm_chip *chip)
>  	}
>  
>  	list_del_init(&chip->list);
> +	of_pwmchip_remove(chip);
>  	free_pwms(chip);
>  
>  out:
> @@ -364,6 +436,61 @@ void pwm_disable(struct pwm_device *pwm)
>  }
>  EXPORT_SYMBOL_GPL(pwm_disable);
>  
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
> +	if (err) {
> +		pr_debug("%s(): can't parse property \"%s\"\n", __func__,
> +			 propname);
> +		return ERR_PTR(err);
> +	}
> +
> +	pc = of_node_to_pwmchip(args.np);
> +	if (IS_ERR(pc)) {
> +		pr_debug("%s(): PWM chip not found\n", __func__);
> +		pwm = ERR_CAST(pc);
> +		goto put;
> +	}
> +
> +	if (args.args_count != pc->of_pwm_n_cells) {
> +		pr_debug("%s: wrong #pwm-cells for %s\n", np->full_name,
> +			 args.np->full_name);
> +		pwm = ERR_PTR(-EINVAL);
> +		goto put;
> +	}
> +
> +	pwm = pc->of_xlate(pc, &args);
> +	if (IS_ERR(pwm))
> +		goto put;
> +
> +	pwm->label = np->name;
> +
> +put:
> +	of_node_put(args.np);
> +
> +	return pwm;
> +}
> +EXPORT_SYMBOL(of_pwm_request);
> +#endif
> +
>  #ifdef CONFIG_DEBUG_FS
>  static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
>  {
> diff --git a/include/linux/of_pwm.h b/include/linux/of_pwm.h
> new file mode 100644
> index 0000000..a3a3da7
> --- /dev/null
> +++ b/include/linux/of_pwm.h
> @@ -0,0 +1,36 @@
> +/*
> + * OF helpers for the PWM API
> + *
> + * Copyright (c) 2011-2012 Avionic Design GmbH
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef __LINUX_OF_PWM_H
> +#define __LINUX_OF_PWM_H
> +
> +#include <linux/err.h>
> +#include <linux/pwm.h>
> +
> +struct device_node;
> +
> +#ifdef CONFIG_OF_PWM
> +
> +struct pwm_device *of_pwm_request(struct device_node *np,
> +				  const char *propname, int index);
> +
> +#else
> +
> +static inline struct pwm_device *of_pwm_request(struct device_node *np,
> +						const char *propname,
> +						int index);
                                                         ^^^

No semicolon here please.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
