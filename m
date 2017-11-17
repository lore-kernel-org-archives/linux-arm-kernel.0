From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 17 Nov 2017 12:35:40 +0100
Subject: bh1770 hacks: get it to work on n950
In-Reply-To: <20171116115703.GA26735@amd>
References: <20171116115703.GA26735@amd>
Message-ID: <20171117113540.3bapqvq6mfuovxuw@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 16, 2017 at 12:57:03PM +0100, Pavel Machek wrote:
> Hi!
> 
> Ok, not for application, but I can get light sensor to work.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

There is no mainline user of this driver and it has a custom API, so
I think the driver should be dropped and an IIO based one should be
created instead.

-- Sebastian

> diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/omap3-n950.dts
> index 50c4fc6..15841f7 100644
> --- a/arch/arm/boot/dts/omap3-n950.dts
> +++ b/arch/arm/boot/dts/omap3-n950.dts
> @@ -150,6 +150,23 @@
>                 };
>         };
>  
> +       bh1770 at 38 {
> +       		 compatible = "bh1770glc";
> +		 reg = <0x38>;
> +
> +		 vdd-supply = <&vaux1>;
> +		 leds-supply = <&vaux1>; /* FIXME: really on vbat */
> +
> +		 /* GPIO 83 on n950.
> + 		 .leds              = BHSFH_LED1,
> + 		 .led_max_curr      = BHSFH_LED_100mA,
> + 		 .led_def_curr      = BHSFH_LED_50mA,
> + 		 .glass_attenuation = (16384 * 385) / 100, ... about 3.85x filtering
> + 		 */
> +       };
> +
> +       /* Also TLV320DAC33 and TPA6130A2 */
> +
>  	touch at 4b {
>  		compatible = "atmel,maxtouch";
>  		reg = <0x4b>;
> diff --git a/drivers/misc/bh1770glc.c b/drivers/misc/bh1770glc.c
> index 9c62bf0..f08df29 100644
> --- a/drivers/misc/bh1770glc.c
> +++ b/drivers/misc/bh1770glc.c
> @@ -22,6 +22,7 @@
>   *
>   */
>  
> +#define DEBUG
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/i2c.h>
> @@ -525,16 +526,22 @@ static int bh1770_detect(struct bh1770_chip *chip)
>  	s32 ret;
>  	u8 manu, part;
>  
> +	printk("Detect...\n");
> +
>  	ret = i2c_smbus_read_byte_data(client, BH1770_MANUFACT_ID);
>  	if (ret < 0)
>  		goto error;
>  	manu = (u8)ret;
>  
> +	printk("Detect... manufact\n");
> +
>  	ret = i2c_smbus_read_byte_data(client, BH1770_PART_ID);
>  	if (ret < 0)
>  		goto error;
>  	part = (u8)ret;
>  
> +	printk("Detect... part ... got %x %x\n", manu, part);
> +
>  	chip->revision = (part & BH1770_REV_MASK) >> BH1770_REV_SHIFT;
>  	chip->prox_coef = BH1770_COEF_SCALER;
>  	chip->prox_const = 0;
> @@ -1179,6 +1186,8 @@ static const struct attribute_group bh1770_attribute_group = {
>  	.attrs = sysfs_attrs
>  };
>  
> +struct bh1770_platform_data def = {};
> +
>  static int bh1770_probe(struct i2c_client *client,
>  				const struct i2c_device_id *id)
>  {
> @@ -1189,6 +1198,8 @@ static int bh1770_probe(struct i2c_client *client,
>  	if (!chip)
>  		return -ENOMEM;
>  
> +	printk("bh1770: probe\n");
> +
>  	i2c_set_clientdata(client, chip);
>  	chip->client  = client;
>  
> @@ -1198,10 +1209,12 @@ static int bh1770_probe(struct i2c_client *client,
>  
>  	if (client->dev.platform_data == NULL) {
>  		dev_err(&client->dev, "platform data is mandatory\n");
> -		return -EINVAL;
> +		//return -EINVAL;
>  	}
>  
>  	chip->pdata		= client->dev.platform_data;
> +	if (!chip->pdata)
> +		chip->pdata = &def;
>  	chip->lux_calib		= BH1770_LUX_NEUTRAL_CALIB_VALUE;
>  	chip->lux_rate_index	= BH1770_LUX_DEFAULT_RATE;
>  	chip->lux_threshold_lo	= BH1770_LUX_DEF_THRES;
> @@ -1220,6 +1233,8 @@ static int bh1770_probe(struct i2c_client *client,
>  	chip->prox_rate		= BH1770_PROX_DEFAULT_RATE;
>  	chip->prox_data		= 0;
>  
> +	printk("bh1770: regulators\n");
> +	
>  	chip->regs[0].supply = reg_vcc;
>  	chip->regs[1].supply = reg_vleds;
>  
> @@ -1227,14 +1242,12 @@ static int bh1770_probe(struct i2c_client *client,
>  				      ARRAY_SIZE(chip->regs), chip->regs);
>  	if (err < 0) {
>  		dev_err(&client->dev, "Cannot get regulators\n");
> -		return err;
>  	}
>  
>  	err = regulator_bulk_enable(ARRAY_SIZE(chip->regs),
>  				chip->regs);
>  	if (err < 0) {
>  		dev_err(&client->dev, "Cannot enable regulators\n");
> -		return err;
>  	}
>  
>  	usleep_range(BH1770_STARTUP_DELAY, BH1770_STARTUP_DELAY * 2);
> @@ -1242,6 +1255,8 @@ static int bh1770_probe(struct i2c_client *client,
>  	if (err < 0)
>  		goto fail0;
>  
> +	printk("bh1770: detected\n");
> +
>  	/* Start chip */
>  	bh1770_chip_on(chip);
>  	pm_runtime_set_active(&client->dev);
> @@ -1269,6 +1284,8 @@ static int bh1770_probe(struct i2c_client *client,
>  		goto fail1;
>  	}
>  
> +	printk("bh1770: sysfs ok\n");
> +	
>  	/*
>  	 * Chip needs level triggered interrupt to work. However,
>  	 * level triggering doesn't work always correctly with power
> @@ -1282,8 +1299,12 @@ static int bh1770_probe(struct i2c_client *client,
>  	if (err) {
>  		dev_err(&client->dev, "could not get IRQ %d\n",
>  			client->irq);
> -		goto fail2;
> +		//goto fail2;
>  	}
> +
> +	printk("bh1770: irq ok, all done\n");
> +	err = 0;
> +	
>  	regulator_bulk_disable(ARRAY_SIZE(chip->regs), chip->regs);
>  	return err;
>  fail2:
> @@ -1393,10 +1414,18 @@ static const struct dev_pm_ops bh1770_pm_ops = {
>  	SET_RUNTIME_PM_OPS(bh1770_runtime_suspend, bh1770_runtime_resume, NULL)
>  };
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id bh1770_of_match_table[] = {
> +	{ .compatible = "bq27200" },
> +};
> +MODULE_DEVICE_TABLE(of, bh1770_of_match_table);
> +#endif	
> +
>  static struct i2c_driver bh1770_driver = {
>  	.driver	 = {
>  		.name	= "bh1770glc",
>  		.pm	= &bh1770_pm_ops,
> +		.of_match_table = of_match_ptr(bh1770_of_match_table),
>  	},
>  	.probe	  = bh1770_probe,
>  	.remove	  = bh1770_remove,
> 
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171117/d0ff3a21/attachment.sig>
