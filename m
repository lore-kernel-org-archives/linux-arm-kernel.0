From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 15 Sep 2011 15:21:54 +0100
Subject: [RFC PATCH 11/11] DT: regulator: register regulators as platform
	devices
In-Reply-To: <1316085727-15023-12-git-send-email-rnayak@ti.com>
References: <1316085727-15023-3-git-send-email-rnayak@ti.com>
	<1316085727-15023-4-git-send-email-rnayak@ti.com>
	<1316085727-15023-5-git-send-email-rnayak@ti.com>
	<1316085727-15023-6-git-send-email-rnayak@ti.com>
	<1316085727-15023-7-git-send-email-rnayak@ti.com>
	<1316085727-15023-8-git-send-email-rnayak@ti.com>
	<1316085727-15023-9-git-send-email-rnayak@ti.com>
	<1316085727-15023-10-git-send-email-rnayak@ti.com>
	<1316085727-15023-11-git-send-email-rnayak@ti.com>
	<1316085727-15023-12-git-send-email-rnayak@ti.com>
Message-ID: <20110915142153.GP7988@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 04:52:07PM +0530, Rajendra Nayak wrote:
> of_regulator_register_devices() registers all regulators
> as platform devices. Use this to register all twl regulators
> from the twl driver probe.

Regulators can be devices of any type, not just platform devices.

>  drivers/mfd/twl-core.c       |    3 +++
>  drivers/of/of_regulator.c    |   30 ++++++++++++++++++++++++++++++
>  include/linux/of_regulator.h |    5 +++++

Again, in the regulator code not hidden away please.

> +/**
> + * of_regulator_register_devices - Register regulator devices to platform bus
> + * @np:	Parent device node with regulator child nodes
> + *
> + * Registers all the regulator and regulator-fixed nodes as platform devices
> + *
> + */
> +void of_regulator_register_devices(struct device_node *np)
> +{
> +	struct device_node *child;
> +	struct platform_device *dev;
> +
> +	for_each_child_of_node(np, child) {
> +		if (of_device_is_compatible(child, "regulator")
> +			|| of_device_is_compatible(child, "regulator-fixed")) {
> +			dev = of_device_alloc(child, NULL, NULL);
> +			if (!dev)
> +				return;
> +			dev->dev.bus = &platform_bus_type;
> +			if (of_device_add(dev) != 0) {
> +				platform_device_put(dev);
> +				return;
> +			}

I'm not entirely sure what this is for?  Surely we should be
instantiating the subdevices of the MFD in the same way we always have
done?

> +		}
> +	}
> +	return;
> +}
> +
> diff --git a/include/linux/of_regulator.h b/include/linux/of_regulator.h
> index 5fc7329..38cf7e3 100644
> --- a/include/linux/of_regulator.h
> +++ b/include/linux/of_regulator.h
> @@ -15,6 +15,7 @@ extern struct fixed_voltage_config
>  	*of_get_fixed_voltage_config(struct device_node *np);
>  extern struct device_node *of_get_regulator(struct device *dev,
>  	const char *id);
> +extern void of_regulator_register_devices(struct device_node *np);
>  #else
>  static inline struct regulator_init_data
>  	*of_get_regulator_init_data(struct device_node *np)
> @@ -31,6 +32,10 @@ static inline struct device_node *of_get_regulator(struct device *dev,
>  {
>  	return NULL;
>  }
> +static inline void of_regulator_register_devices(struct device_node *np)
> +{
> +	return NULL;
> +}
>  #endif /* CONFIG_OF_REGULATOR */
>  
>  #endif /* __LINUX_OF_REG_H */
> -- 
> 1.7.1
> 
