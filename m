From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 25 Aug 2015 19:52:15 -0600
Subject: [PATCH v4 1/5] soc: bcm2835: auxiliar devices enable
 infrastructure
In-Reply-To: <1440405608-3995-2-git-send-email-kernel@martin.sperl.org>
References: <1440405608-3995-1-git-send-email-kernel@martin.sperl.org>
 <1440405608-3995-2-git-send-email-kernel@martin.sperl.org>
Message-ID: <55DD1BCF.7040200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2015 02:40 AM, kernel at martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> The bcm2835 SOC contains 3 auxiliar devices (spi1, spi2 and uart1)
> that all are enabled via a shared register.
> 
> To serialize access to this shared register this soc-driver
> is created that implements:
>   bcm2835aux_enable(struct device *dev, const char *property);
>   bcm2835aux_disable(struct device *dev, const char *property);
> 
> Which will read the property from the device tree of the device
> and enable/disable that specific device as per device tree.
> 
> First use of this api will be spi-bcm2835aux.

> diff --git a/drivers/soc/bcm/bcm2835-aux.c b/drivers/soc/bcm/bcm2835-aux.c

> +static void *bcm2835aux_find_base(struct device *dev, const char *property)
> +{
> +	struct device *found = NULL;
> +	struct device_node *np;
> +
> +	/* get the phandle of the device */
> +	np = of_parse_phandle(dev->of_node, property, 0);
> +	if (!np) {
> +		dev_err(dev, "missing property %s\n", property);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	/* now find the device it points to */
> +	found = driver_find_device(&bcm2835aux_driver.driver, NULL,
> +				   np, bcm2835aux_dev_match);
> +	if (!found) {
> +		dev_err(dev, "device for phandle of %s not found\n",
> +			property);
> +		return ERR_PTR(-ENODEV);

That should return ERR_PTR(-EPROBE_DEFER) so that client drivers know
when to defer their own probe, and not print an error. This is an
expected condition during probing. I could have sworn this was correct
in a previous patch revision.
