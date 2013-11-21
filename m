From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 21 Nov 2013 12:43:19 +0100
Subject: [PATCH v2 1/5] mfd: max14577: Add max14577 MFD driver core
In-Reply-To: <20131121103408.GA22536@lee--X1>
References: <1384956732-19526-1-git-send-email-k.kozlowski@samsung.com>
 <1384956732-19526-2-git-send-email-k.kozlowski@samsung.com>
 <20131121103408.GA22536@lee--X1>
Message-ID: <1385034199.748.21.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-11-21 at 10:34 +0000, Lee Jones wrote:
> <snip>
> 
> > +/**
> > + * After resuming from suspend it may happen that IRQ is signalled but
> > + * IRQ GPIO is not high. Also the interrupt registers won't have any data
> > + * (all of them equal to 0x00).
> > + *
> > + * In such case retry few times reading the interrupt registers.
> > + */
> > +#define IRQ_READ_REG_RETRY_CNT		5
> 
> Where is this used?
> 
> <snip>
> 
> > +#define DECLARE_IRQ(idx, _group, _mask)		\
> > +	[(idx)] = { .group = (_group), .mask = (_mask) }
> 
> I'm pretty sure the parentheses are supurfluous.
> 
> > +static const inline struct max14577_irq_data *
> > irq_to_max14577_irq(struct max14577 *max14577, int irq)
> 
> We should tab this back out.
> 
> > +{
> > +	struct irq_data *data = irq_get_irq_data(irq);
> > +	return &max14577_irqs[data->hwirq];
> 
> Shouldn't you be using irq_create_mapping() or irq_find_mapping() here?
> 
> > +static void max14577_irq_mask(struct irq_data *data)
> > +{
> > +	struct max14577 *max14577 = irq_get_chip_data(data->irq);
> 
>                                     irq_data_get_irq_chip_data(data); ?
> 
> > +	const struct max14577_irq_data *irq_data =
> > +	    irq_to_max14577_irq(max14577, data->irq);
> > +
> > +	if (!irq_data)
> > +		return;
> > +
> > +	if (irq_data->group >= MAX14577_IRQ_REGS_NUM)
> > +		return;
> > +
> > +	max14577->irq_masks_cur[irq_data->group] &= ~irq_data->mask;
> > +}
> 
> <snip>
> 
> > +int max14577_irq_resume(struct max14577 *max14577)
> > +{
> > +	int ret = 0;
> > +
> > +	if (max14577->irq && max14577->irq_domain)
> > +		ret = max14577_irq_thread(0, max14577);
> > +
> > +	return ret >= 0 ? 0 : ret;
> 
> Please open this out to something more easily comprehensible.

Thanks for pointing these out however after using regmap_irq_chip whole
file won't be needed anymore.

(...)

> > +static int max14577_i2c_probe(struct i2c_client *i2c,
> > +			      const struct i2c_device_id *id)
> > +{
> > +	struct max14577 *max14577;
> > +	struct max14577_platform_data *pdata = dev_get_platdata(&i2c->dev);
> > +	u8 reg_data;
> > +	int ret = 0;
> > +
> > +	if (i2c->dev.of_node) {
> 
> Can you pull this out. It looks neater as the top as:
>   struct device_node *np = i2c->dev.of_node;

I am not sure if I understand you correctly. You would like to change
this to:
-------------------------
static int max14577_i2c_probe(struct i2c_client *i2c,
                              const struct i2c_device_id *id)
{
        struct max14577 *max14577;
        struct max14577_platform_data *pdata =
dev_get_platdata(&i2c->dev);
        struct device_node *np = i2c->dev.of_node;
        u8 reg_data;
        int ret = 0;

        if (np) {
                pdata = devm_kzalloc(&i2c->dev,
                                sizeof(struct max14577_platform_data),
                                GFP_KERNEL);
-------------------------
The variable 'np' would be used only once.


> 
> > +		pdata = devm_kzalloc(&i2c->dev,
> > +				sizeof(struct max14577_platform_data),
> 
> I prefer:
>   sizeof(*pdata),

OK. Line will be shorter. I will change this patter also in other
places.

> 
> > +				GFP_KERNEL);
> > +		if (!pdata)
> > +			return -ENOMEM;
> > +		i2c->dev.platform_data = pdata;
> > +	}
> > +
> > +	if (IS_ERR_OR_NULL(pdata)) {
> 
> It's not likely to be an ERR, just do:
>  if (!pdata) {

OK.


> > +		dev_err(&i2c->dev, "No platform data found: %ld\n",
> > +				PTR_ERR(pdata));
> > +		return -EINVAL;
> > +	}
> > +
> > +	max14577 = devm_kzalloc(&i2c->dev, sizeof(struct max14577), GFP_KERNEL);
> > +	if (!max14577)
> > +		return -ENOMEM;
> > +
> > +	i2c_set_clientdata(i2c, max14577);
> > +	max14577->pdata = pdata;
> 
> How many different places do you want to store this?
> 
> > +	max14577->dev = &i2c->dev;
> 
> You're storing dev here anyway.
> 
> Remove the pdata property and get it from dev when/if you require it.

OK.


> > +	max14577->i2c = i2c;
> > +	max14577->irq = i2c->irq;
> > +
> > +	max14577->regmap = devm_regmap_init_i2c(i2c, &max14577_regmap_config);
> > +	if (IS_ERR(max14577->regmap)) {
> > +		ret = PTR_ERR(max14577->regmap);
> > +		dev_err(max14577->dev, "Failed to allocate register map: %d\n",
> > +				ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = max14577_read_reg(max14577->regmap, MAX14577_REG_DEVICEID,
> > +			&reg_data);
> > +	if (ret) {
> > +		dev_err(max14577->dev, "Device not found on this channel: %d\n",
> > +				ret);
> > +		return ret;
> > +	}
> > +	max14577->vendor_id = (reg_data & 0x7);
> > +	max14577->device_id = ((reg_data & 0xF8) >> 0x3);
> > +	dev_info(max14577->dev, "Device ID: 0x%x, vendor: 0x%x\n",
> > +			max14577->device_id, max14577->vendor_id);
> > +
> > +	ret = max14577_irq_init(max14577);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = mfd_add_devices(max14577->dev, -1, max14577_devs,
> > +			ARRAY_SIZE(max14577_devs), NULL, 0, NULL);
> 
> You should be passing the irqdomain as the final parameter here.

I replaced the IRQ handling with regmap_irq_chip so this would look like
this:
-------------------------
        ret = mfd_add_devices(max14577->dev, -1, max14577_devs,
                        ARRAY_SIZE(max14577_devs), NULL, 0,
                        regmap_irq_get_domain(max14577->irq_data));
-------------------------
Am I correct?


> > +	if (ret < 0)
> > +		goto err_mfd;
> > +
> > +	device_init_wakeup(max14577->dev, 1);
> > +
> > +	return 0;
> > +
> > +err_mfd:
> > +	max14577_irq_exit(max14577);
> > +	return ret;
> > +}
> > +
> > +static int max14577_i2c_remove(struct i2c_client *i2c)
> > +{
> > +	struct max14577 *max14577 = i2c_get_clientdata(i2c);
> > +
> > +	mfd_remove_devices(max14577->dev);
> > +	max14577_irq_exit(max14577);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct i2c_device_id max14577_i2c_id[] = {
> > +	{ MAX14577_MFD_DEV_NAME, 0 },
> 
> Can you use the proper name here, these types of defines are pretty ugly.

OK.

> <snip>
> 
> > +#ifdef CONFIG_OF
> > +static struct of_device_id max14577_dt_match[] = {
> > +	{ .compatible = "maxim,max14577", },
> > +	{},
> > +};
> > +#else
> > +#define max14577_dt_match	NULL
> > +#endif
> 
> You don't need to do this and use of_match_ptr().
> 
> Remove the #ifdef.

Yes, Mark also pointed this.

> 
> > +static SIMPLE_DEV_PM_OPS(max14577_pm, max14577_suspend, max14577_resume);
> > +
> > +static struct i2c_driver max14577_i2c_driver = {
> > +	.driver = {
> > +		.name = MAX14577_MFD_DEV_NAME,
> 
> Can you use the proper name here, these types of defines are pretty ugly.

OK.

> 
> > +		.owner = THIS_MODULE,
> > +		.pm = &max14577_pm,
> > +		.of_match_table = of_match_ptr(max14577_dt_match),
> > +	},
> > +	.probe = max14577_i2c_probe,
> > +	.remove = max14577_i2c_remove,
> > +	.id_table = max14577_i2c_id,
> > +};
> 
> >>>>>>>>>>>>>>>>>>>>>>
> 
> > +static int __init max14577_i2c_init(void)
> > +{
> > +	return i2c_add_driver(&max14577_i2c_driver);
> > +}
> > +subsys_initcall(max14577_i2c_init);
> > +
> > +static void __exit max14577_i2c_exit(void)
> > +{
> > +	i2c_del_driver(&max14577_i2c_driver);
> > +}
> > +module_exit(max14577_i2c_exit);
> 
> >>>>>>>>>>>>>>>>>>>>>>
> 
> Remove all this and replace with:
>   module_i2c_driver(max14577_i2c_driver);

The subsys_initcall is needed. Marek Szyprowski replied to this here:
http://thread.gmane.org/gmane.linux.drivers.devicetree/51903/focus=1594651


(...)

> > +struct max14577_regulator_platform_data {
> > +	int id;
> > +	struct regulator_init_data *initdata;
> > +	struct device_node *of_node;
> 
> Do you ever set this? What's the point of it is it's set in the device?

Do you mean the whole struct max14577_regulator_platform_data or only
some member of it (of_node?)?

Best regards,
Krzysztof
