From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Feb 2015 17:46:41 +0000
Subject: [RFC PATCH 1/3] eeprom: Add a simple EEPROM framework
In-Reply-To: <1424365708-26681-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1424365639-26634-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424365708-26681-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150220174641.GI8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 19, 2015 at 05:08:28PM +0000, Srinivas Kandagatla wrote:
> +static struct class eeprom_class = {
> +	.name		= "eeprom",
> +	.dev_groups	= eeprom_dev_groups,
> +};
> +
> +int eeprom_register(struct eeprom_device *eeprom)
> +{
> +	int rval;
> +
> +	if (!eeprom->regmap || !eeprom->size) {
> +		dev_err(eeprom->dev, "Regmap not found\n");
> +		return -EINVAL;
> +	}
> +
> +	eeprom->id = ida_simple_get(&eeprom_ida, 0, 0, GFP_KERNEL);
> +	if (eeprom->id < 0)
> +		return eeprom->id;
> +
> +	eeprom->edev.class = &eeprom_class;
> +	eeprom->edev.parent = eeprom->dev;
> +	eeprom->edev.of_node = eeprom->dev ? eeprom->dev->of_node : NULL;
> +	dev_set_name(&eeprom->edev, "eeprom%d", eeprom->id);
> +
> +	device_initialize(&eeprom->edev);
> +
> +	dev_dbg(&eeprom->edev, "Registering eeprom device %s\n",
> +		dev_name(&eeprom->edev));
> +
> +	rval = device_add(&eeprom->edev);
> +	if (rval)
> +		return rval;
> +
> +	mutex_lock(&eeprom_list_mutex);
> +	list_add(&eeprom->list, &eeprom_list);
> +	mutex_unlock(&eeprom_list_mutex);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(eeprom_register);
> +
> +int eeprom_unregister(struct eeprom_device *eeprom)
> +{
> +	device_del(&eeprom->edev);
> +
> +	mutex_lock(&eeprom_list_mutex);
> +	list_del(&eeprom->list);
> +	mutex_unlock(&eeprom_list_mutex);
> +
> +	return 0;

There's problems with this.  "edev" is embedded into eeprom, and "edev"
is a refcounted structure - it has a lifetime, and the lifetime of
eeprom is thus determined by edev.

What this means is that calling eeprom_unregister() and then freeing
the eeprom structure is a potentially unsafe operation - the memory
backing edev must only be freed when the release method for the
struct device has been called.

> +struct eeprom_device {
> +	struct regmap		*regmap;
> +	int			stride;
> +	size_t			size;
> +	struct device		*dev;

Failing to understand and address the driver model life time issues is
a major blocker for this patch.  Sorry.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
