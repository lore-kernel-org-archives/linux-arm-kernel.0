From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Feb 2015 17:47:50 +0000
Subject: [RFC PATCH 2/3] eeprom: sunxi: Move the SID driver to the eeprom
 framework
In-Reply-To: <1424365720-26725-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1424365639-26634-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424365720-26725-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150220174750.GJ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 19, 2015 at 05:08:40PM +0000, Srinivas Kandagatla wrote:
> +static int sunxi_sid_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *device;
> +	struct eeprom_sid *sid;
> +	struct resource *res;
> +	struct eeprom_device *eeprom;
> +	struct device *dev = &pdev->dev;
> +	int rval;
> +
> +	sid = devm_kzalloc(dev, sizeof(*sid), GFP_KERNEL);
> +	if (!sid)
> +		return -ENOMEM;
> +
> +	eeprom = &sid->eeprom;
...
> +	rval = eeprom_register(eeprom);
> +	if (rval)
> +		return rval;
...
> +static int sunxi_sid_remove(struct platform_device *pdev)
> +{
> +	struct eeprom_device *eeprom = platform_get_drvdata(pdev);
> +
> +	return eeprom_unregister(eeprom);

As pointed out in the previous patch, this is unsafe as the eeprom
structure contains a struct device.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
