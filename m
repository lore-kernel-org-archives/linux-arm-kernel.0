From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sun, 12 Oct 2014 18:03:39 +0200
Subject: [PATCH 1/3] ARM: meson: reset: Add reset controller for MesonX
 SoCs
In-Reply-To: <1413125679-24443-2-git-send-email-carlo@caione.org>
References: <1413125679-24443-1-git-send-email-carlo@caione.org>
 <1413125679-24443-2-git-send-email-carlo@caione.org>
Message-ID: <20141012160339.GA16293@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 12, 2014 at 04:54:37PM +0200, Carlo Caione wrote:
> This patch adds support for the reset controller found on the Amlogic
> MesonX SoCs. For several devices in the AO (Always-On) power domain, it
> is possible to reset them by programming a specific bit in a register.

Hi Carlo,

> [...]
> +
> +static int meson_reset_probe(struct platform_device *pdev)
> +{
> +	struct meson_reset_data *data;
> +	struct resource *res;
> +
> +	/*
> +	 * The binding was mainlined without the required property.
> +	 * Do not continue, when we encounter an old DT.
> +	 */
> +	if (!of_find_property(pdev->dev.of_node, "#reset-cells", NULL)) {
> +		dev_err(&pdev->dev, "%s missing #reset-cells property\n",
> +			pdev->dev.of_node->full_name);
> +		return -EINVAL;
> +	}

Probably the above comment was taken from another driver but is not
relevant here.

> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->membase = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(data->membase))
> +		return PTR_ERR(data->membase);
> +
> +	spin_lock_init(&data->lock);
> +
> +	data->rcdev.owner = THIS_MODULE;
> +	data->rcdev.nr_resets = BITS_PER_LONG;
> +	data->rcdev.ops = &meson_reset_ops;
> +	data->rcdev.of_node = pdev->dev.of_node;
> +	reset_controller_register(&data->rcdev);
> +
> +	return 0;
> +}
> +
> +static int meson_reset_remove(struct platform_device *pdev)
> +{
> +	struct meson_reset_data *data = platform_get_drvdata(pdev);

Don't you need to call platform_set_drvdata() in the probe() function
for this to be valid?

> +
> +	reset_controller_unregister(&data->rcdev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id meson_reset_dt_ids[] = {
> +	{ .compatible = "amlogic,meson6-rst-mgr-ao", },
> +	{ /* sentinel */ },
> +};
> +
> +static struct platform_driver meson_reset_driver = {
> +	.probe	= meson_reset_probe,
> +	.remove	= meson_reset_remove,
> +	.driver = {
> +		.name		= "meson-reset",
> +		.owner		= THIS_MODULE,

I believe you can drop the owner field.

Beniamino
