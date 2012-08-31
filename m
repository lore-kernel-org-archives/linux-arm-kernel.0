From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 31 Aug 2012 09:26:29 +0800
Subject: [PATCH v4 1/7] mfd: add syscon driver based on regmap
In-Reply-To: <1346237818-9498-2-git-send-email-b29396@freescale.com>
References: <1346237818-9498-1-git-send-email-b29396@freescale.com>
 <1346237818-9498-2-git-send-email-b29396@freescale.com>
Message-ID: <20120831012626.GA7726@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 06:56:52PM +0800, Dong Aisheng wrote:
> +config MFD_SYSCON
> +        bool "System Controller Register R/W Based on Regmap"

If the driver only compiles and works for device tree probe, we should
have the following?

	depends on OF

> +        select REGMAP_MMIO
> +        help
> +	  Select this option to enable accessing system control registers
> +	  via regmap.
> +

<snip>

> +struct regmap *syscon_node_to_regmap(struct device_node *np)
> +{
> +	struct syscon *syscon;
> +	struct device *dev;
> +
> +	dev = driver_find_device(&syscon_driver.driver, NULL, np,
> +				 syscon_match);
> +	of_node_put(np);

This looks a little unnatural to me.  Function syscon_node_to_regmap
becomes an API visible to clients, who might never know that np will
be put inside the API.  I'm saying the client may also call of_node_put
to put the node they get.

I think of_node_put should be moved out from here and put into
syscon_node_to_regmap and syscon_regmap_lookup_by_compatible.

Regards,
Shawn

> +
> +	if (!dev)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	syscon = dev_get_drvdata(dev);
> +
> +	return syscon->regmap;
> +}
> +EXPORT_SYMBOL_GPL(syscon_node_to_regmap);
> +
> +struct regmap *syscon_regmap_lookup_by_compatible(const char *s)
> +{
> +	struct device_node *syscon_np;
> +
> +	syscon_np = of_find_compatible_node(NULL, NULL, s);
> +	if (!syscon_np)
> +		return ERR_PTR(-ENODEV);
> +
> +	return syscon_node_to_regmap(syscon_np);
> +}
> +EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_compatible);
> +
> +struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
> +					const char *property)
> +{
> +	struct device_node *syscon_np;
> +
> +	syscon_np = of_parse_phandle(np, property, 0);
> +	if (!syscon_np)
> +		return ERR_PTR(-ENODEV);
> +
> +	return syscon_node_to_regmap(syscon_np);
> +}
> +EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle);
