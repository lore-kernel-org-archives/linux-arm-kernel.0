From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 3 Mar 2016 15:29:29 +0100
Subject: [PATCH 06/17] reset: Add PLX Technology Reset Controller driver
In-Reply-To: <1457014709.3425.53.camel@pengutronix.de>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457005210-18485-7-git-send-email-narmstrong@baylibre.com>
 <1457014709.3425.53.camel@pengutronix.de>
Message-ID: <56D84A49.4010400@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2016 03:18 PM, Philipp Zabel wrote:
> Hi Neil,
> 
>> +config RESET_OXNAS
>> +	bool
>> +	select MFD_SYSCON
> 
> I'd prefer not to select MFD_SYSCON here, but rather let ARCH_OXNAS do
> that.
> 
OK.

>> +#include <linux/io.h>
> 
> Is there any need to include linux/io.h ?

No, dropping.

>> +static int oxnas_reset_reset(struct reset_controller_dev *rcdev,
>> +			      unsigned long id)
>> +{
>> +	struct oxnas_reset *data =
>> +		container_of(rcdev, struct oxnas_reset, rcdev);
>> +
>> +	regmap_write(data->regmap, RST_SET_REGOFFSET, BIT(id));
>> +	msleep(50);
> 
> Is this the right delay for all of the resets in this register?
> If not, I'd drop the .reset callback.
> 
The delay is not strictly necessary, but better to avoid any HW issues.
And the .reset callback is needed since reset_control_reset
does not assert -> deassert as fallback.

>> +	regmap_write(data->regmap, RST_CLR_REGOFFSET, BIT(id));
>> +
>> +	return 0;
>> +}
>> +
>> +static int oxnas_reset_assert(struct reset_controller_dev *rcdev,
>> +			      unsigned long id)
>> +{
>> +	struct oxnas_reset *data =
>> +		container_of(rcdev, struct oxnas_reset, rcdev);
>> +
>> +	regmap_write(data->regmap, RST_SET_REGOFFSET, BIT(id));
>> +
>> +	return 0;
>> +}
>> +
>> +static int oxnas_reset_deassert(struct reset_controller_dev *rcdev,
>> +				unsigned long id)
>> +{
>> +	struct oxnas_reset *data =
>> +		container_of(rcdev, struct oxnas_reset, rcdev);
>> +
>> +	regmap_write(data->regmap, RST_CLR_REGOFFSET, BIT(id));
>> +
>> +	return 0;
>> +}
>> +
>> +static struct reset_control_ops oxnas_reset_ops = {
> 
> const
> 
Something checkpatch should report...

>> +	.reset		= oxnas_reset_reset,
>> +	.assert		= oxnas_reset_assert,
>> +	.deassert	= oxnas_reset_deassert,
>> +};
>> +
>> +static const struct of_device_id oxnas_reset_dt_ids[] = {
>> +	 { .compatible = "plxtech,nas782x-reset", },
>> +	 { /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, oxnas_reset_dt_ids);
>> +
>> +static int oxnas_reset_probe(struct platform_device *pdev)
>> +{
>> +	struct oxnas_reset *data;
>> +	struct device *parent;
>> +
>> +	parent = pdev->dev.parent;
>> +	if (!parent) {
>> +		dev_err(&pdev->dev, "no parent\n");
> 
> Can this even happen?
> 
It's to make sure parent->of_node is valid for syscon_node_to_regmap.

>> +		return -ENODEV;
>> +	}
>> +
>> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->regmap = syscon_node_to_regmap(parent->of_node);
>> +	if (IS_ERR(data->regmap)) {
>> +		dev_err(&pdev->dev, "failed to get parent regmap\n");
>> +		return -ENODEV;
> 
> Better print the error code and return it.
> 
Good point.

>> +	}
>> +
>> +	data->rcdev.owner = THIS_MODULE;
>> +	data->rcdev.nr_resets = 32;
>> +	data->rcdev.ops = &oxnas_reset_ops;
>> +	data->rcdev.of_node = pdev->dev.of_node;
>> +	reset_controller_register(&data->rcdev);
> 
> Move this down a bit:
> 
>> +
>> +	platform_set_drvdata(pdev, data);
>> +
>> +	return 0;
> 
> and
> 	return reset_controller_register(&data->rcdev);
> here.
> 
Yes, sound better...

>> +static struct platform_driver oxnas_reset_driver = {
>> +	.probe	= oxnas_reset_probe,
>> +	.remove	= oxnas_reset_remove,
>> +	.driver = {
>> +		.name		= "oxnas-reset",
>> +		.owner		= THIS_MODULE,
> 
> The .owner field is overwritten by __platform_driver_register() anyway,
> just drop it.
OK

>> +/*
>> + * Reset controller does not support probe deferral, so it has to be
>> + * initialized before any user, in particular, PCIE uses subsys_initcall.
>> + */
>> +arch_initcall(oxnas_reset_init);
> 
> That doesn't sound right. (of_)reset_control_get return -EPROBE_DEFER if
> the rcdev isn't found in the list. Could you elaborate on this?
It was an old change, I will put back the generic module platform init.

> 
> regards
> Philipp
> 
Thanks,

Neil
