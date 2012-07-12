From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 12 Jul 2012 15:12:31 +0200
Subject: linux-next: manual merge of the arm-soc tree with the
 i2c-embedded tree
In-Reply-To: <20120710164130.f38e4d1673f925ddb13914c9@canb.auug.org.au>
References: <20120710164130.f38e4d1673f925ddb13914c9@canb.auug.org.au>
Message-ID: <20120712131231.GH2194@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I fixed it up (I think - see below) and can carry the fix as necessary.
> Please check this and talk to each other ...

I also noticed the bindings today [1]. They came in via a seperate
patch (suboptimal) which has no ack by a devicetree maintainer which I'd
really like to see here, because the bindings look suspicious to me.
They look like they mostly export register settings which is usually
questionable since we might want to abstract bindings so they can be
useful for a number of drivers.

Arnd, since you committed the patches, can you please comment? I'd
prefer to drop this DT conversion for now, otherwise we might have to
support this possibly rushed bindings forever? LinusW, what do you
think?

Thanks,

   Wolfram

[1] http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commitdiff;h=87a174f3d7cea1b9c7596911c39616768f441629

> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
> 
> diff --cc drivers/i2c/busses/i2c-nomadik.c
> index e6b93f3,5471303..0000000
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c
> @@@ -24,8 -23,10 +24,9 @@@
>   #include <linux/io.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/pm_runtime.h>
>  +#include <linux/platform_data/i2c-nomadik.h>
> + #include <linux/of.h>
>   
>  -#include <plat/i2c.h>
>  -
>   #define DRIVER_NAME "nmk-i2c"
>   
>   /* I2C Controller register offsets */
> @@@ -911,23 -896,93 +908,94 @@@ static const struct i2c_algorithm nmk_i
>   	.functionality	= nmk_i2c_functionality
>   };
>   
> + static struct nmk_i2c_controller u8500_i2c = {
> + 	/*
> + 	 * Slave data setup time; 250ns, 100ns, and 10ns, which
> + 	 * is 14, 6 and 2 respectively for a 48Mhz i2c clock.
> + 	 */
> + 	.slsu           = 0xe,
> + 	.tft            = 1,      /* Tx FIFO threshold */
> + 	.rft            = 8,      /* Rx FIFO threshold */
> + 	.clk_freq       = 400000, /* std. mode operation */
> + 	.timeout        = 200,    /* Slave response timeout(ms) */
> + 	.sm             = I2C_FREQ_MODE_FAST,
> + };
> + 
> + static int __devinit
> + nmk_i2c_of_probe(struct device_node *np, struct nmk_i2c_controller *pdata)
> + {
> + 	of_property_read_u32(np, "clock-frequency", (u32*)&pdata->clk_freq);
> + 	if (!pdata->clk_freq) {
> + 		pr_warn("%s: Clock frequency not found\n", np->full_name);
> + 		return -EINVAL;
> + 	}
> + 
> + 	of_property_read_u32(np, "stericsson,slsu", (u32*)&pdata->slsu);
> + 	if (!pdata->slsu) {
> + 		pr_warn("%s: Data line delay not found\n", np->full_name);
> + 		return -EINVAL;
> + 	}
> + 
> + 	of_property_read_u32(np, "stericsson,tft", (u32*)&pdata->tft);
> + 	if (!pdata->tft) {
> + 		pr_warn("%s: Tx FIFO threshold not found\n", np->full_name);
> + 		return -EINVAL;
> + 	}
> + 
> + 	of_property_read_u32(np, "stericsson,rft", (u32*)&pdata->rft);
> + 	if (!pdata->rft) {
> + 		pr_warn("%s: Rx FIFO threshold not found\n", np->full_name);
> + 		return -EINVAL;
> + 	}
> + 
> + 	of_property_read_u32(np, "stericsson,timeout", (u32*)&pdata->timeout);
> + 	if (!pdata->timeout) {
> + 		pr_warn("%s: Timeout not found\n", np->full_name);
> + 		return -EINVAL;
> + 	}
> + 
> + 	/*
> + 	 * This driver only supports fast and standard frequency
> + 	 * modes. If anything else is requested fall-back to standard.
> + 	 */
> + 	if (of_get_property(np, "stericsson,i2c_freq_mode_fast", NULL))
> + 		pdata->sm = I2C_FREQ_MODE_FAST;
> + 	else
> + 		pdata->sm = I2C_FREQ_MODE_STANDARD;
> + 
> + 	return 0;
> + }
> + 
>  -static int __devinit nmk_i2c_probe(struct platform_device *pdev)
>  +static atomic_t adapter_id = ATOMIC_INIT(0);
>  +
>  +static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
>   {
>   	int ret = 0;
> - 	struct nmk_i2c_controller *pdata =
> - 			adev->dev.platform_data;
>  -	struct resource *res;
>  -	struct nmk_i2c_controller *pdata = pdev->dev.platform_data;
>  -	struct device_node *np = pdev->dev.of_node;
> ++	struct nmk_i2c_controller *pdata = adev->dev.platform_data;
> ++	struct device_node *np = adev->dev.of_node;
>   	struct nmk_i2c_dev	*dev;
>   	struct i2c_adapter *adap;
>   
> - 	if (!pdata) {
> - 		dev_warn(&adev->dev, "no platform data\n");
> - 		return -ENODEV;
> + 	if (np) {
> + 		if (!pdata) {
>  -			pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> ++			pdata = devm_kzalloc(&adev->dev, sizeof(*pdata), GFP_KERNEL);
> + 			if (!pdata) {
> + 				ret = -ENOMEM;
> + 				goto err_no_mem;
> + 			}
> + 		}
> + 		ret = nmk_i2c_of_probe(np, pdata);
> + 		if (ret)
> + 			kfree(pdata);
>   	}
> + 
> + 	if (!pdata)
> + 		/* No i2c configuration found, using the default. */
> + 		pdata = &u8500_i2c;
> + 
>   	dev = kzalloc(sizeof(struct nmk_i2c_dev), GFP_KERNEL);
>   	if (!dev) {
>  -		dev_err(&pdev->dev, "cannot allocate memory\n");
>  +		dev_err(&adev->dev, "cannot allocate memory\n");
>   		ret = -ENOMEM;
>   		goto err_no_mem;
>   	}
> @@@ -969,12 -1037,12 +1037,11 @@@
>   	adap->owner	= THIS_MODULE;
>   	adap->class	= I2C_CLASS_HWMON | I2C_CLASS_SPD;
>   	adap->algo	= &nmk_i2c_algo;
> - 	adap->timeout	= pdata->timeout ? msecs_to_jiffies(pdata->timeout) :
> - 		msecs_to_jiffies(20000);
> + 	adap->timeout	= msecs_to_jiffies(pdata->timeout);
>  +	adap->nr = atomic_read(&adapter_id);
>   	snprintf(adap->name, sizeof(adap->name),
>  -		 "Nomadik I2C%d at %lx", pdev->id, (unsigned long)res->start);
>  -
>  -	/* fetch the controller id */
>  -	adap->nr	= pdev->id;
>  +		 "Nomadik I2C%d at %pR", adap->nr, &adev->res);
>  +	atomic_inc(&adapter_id);
>   
>   	/* fetch the controller configuration from machine */
>   	dev->cfg.clk_freq = pdata->clk_freq;
> @@@ -1040,29 -1110,20 +1107,35 @@@ static int nmk_i2c_remove(struct amba_d
>   	return 0;
>   }
>   
>  +static struct amba_id nmk_i2c_ids[] = {
>  +	{
>  +		.id	= 0x00180024,
>  +		.mask	= 0x00ffffff,
>  +	},
>  +	{
>  +		.id	= 0x00380024,
>  +		.mask	= 0x00ffffff,
>  +	},
>  +	{},
>  +};
>  +
>  +MODULE_DEVICE_TABLE(amba, nmk_i2c_ids);
>  +
> + static const struct of_device_id nmk_gpio_match[] = {
> + 	{ .compatible = "st,nomadik-i2c", },
> + 	{},
> + };
> + 
>  -static struct platform_driver nmk_i2c_driver = {
>  -	.driver = {
>  +static struct amba_driver nmk_i2c_driver = {
>  +	.drv = {
>   		.owner = THIS_MODULE,
>   		.name = DRIVER_NAME,
>   		.pm = &nmk_i2c_pm,
> + 		.of_match_table = nmk_gpio_match,
>   	},
>  +	.id_table = nmk_i2c_ids,
>   	.probe = nmk_i2c_probe,
>  -	.remove = __devexit_p(nmk_i2c_remove),
>  +	.remove = nmk_i2c_remove,
>   };
>   
>   static int __init nmk_i2c_init(void)



-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120712/b23ede08/attachment.sig>
