From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2012 09:07:29 +0000
Subject: [PATCH v9] mfd: Add anatop mfd driver
In-Reply-To: <1331797421-23731-1-git-send-email-paul.liu@linaro.org>
References: <1331797421-23731-1-git-send-email-paul.liu@linaro.org>
Message-ID: <201203150907.29895.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 March 2012, Ying-Chun Liu (PaulLiu) wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> 
> Anatop is a mfd chip embedded in Freescale i.MX6Q SoC.
> Anatop provides regulators and thermal.
> This driver handles the address space and the operation of the mfd device.

Hi Paul,

This looks like a very nice and clean driver, good work!

Very broadly speaking, I wonder whether we could use the regmap
infrastructure for these things in the future, but I would first
need to understand whether that is actually in the scope of regmap.

It seems that you just need a subset of what regmap provides,
so it could work, but it might not actually be better than what
you have now.

Mark, can you comment on that?

> +u32 anatop_get_bits(struct anatop *adata, u32 addr, int bit_shift,
> +		    int bit_width)
> +{
> +	u32 val, mask;
> +
> +	if (bit_width == 32)
> +		mask = ~0;
> +	else
> +		mask = (1 << bit_width) - 1;
> +
> +	val = readl(adata->ioreg + addr);
> +	val = (val >> bit_shift) & mask;
> +
> +	return val;
> +}
> +EXPORT_SYMBOL(anatop_get_bits);

I think the exports here should be EXPORT_SYMBOL_GPL. There is no reason
why an out of tree driver would ever use these.

> +static const struct of_device_id of_anatop_subdevice_match[] = {
> +	{ .compatible = "fsl,anatop-regulator", },
> +	{ .compatible = "fsl,anatop-thermal", },
> +	{ },
> +};
> +
> +static int __devinit of_anatop_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	void *ioreg;
> +	struct anatop *drvdata;
> +
> +	ioreg = of_iomap(np, 0);
> +	if (!ioreg)
> +		return -EADDRNOTAVAIL;
> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +	drvdata->ioreg = ioreg;
> +	spin_lock_init(&drvdata->reglock);
> +	platform_set_drvdata(pdev, drvdata);
> +	of_platform_bus_probe(np, of_anatop_subdevice_match, dev);
> +
> +	return 0;
> +}

Why do you list the subdevices in of_anatop_subdevice_match()? I think you
should just use 

	of_platform_bus_probe(np, of_anatop_match, dev);

here, using the same match table that you have in the platform_driver.
That will automatically create platform devices for any children of this
device, so you don't have to update the list above when you get new
child drivers.

	Arnd
