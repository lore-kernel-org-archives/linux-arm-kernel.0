From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 17 Nov 2009 21:16:31 -0800
Subject: [PATCH 06/10] mfd add subdevs in 88pm860x
In-Reply-To: <771cded00911162231i6b548138sf348f20fdd508296@mail.gmail.com>
References: <771cded00911130100u2a97c6f4v968e40b912650482@mail.gmail.com>
	<20091114045051.GA4463@core.coreip.homeip.net>
	<771cded00911162231i6b548138sf348f20fdd508296@mail.gmail.com>
Message-ID: <20091118051631.GB31480@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Tue, Nov 17, 2009 at 01:31:34AM -0500, Haojian Zhuang wrote:
> 
> +static int __devinit __88pm8607_gpadc_init(struct pm860x_chip *chip,
> +					   struct pm860x_plat_data *pdata)
> +{
> +	int use_gpadc = 0, data, ret;
> +
> +	/* initialize GPADC without turn on */
> +

"... without turning it on" or even "... without activating it" -
otherwise it reads really funny.

> +	if (pdata && pdata->touch) {
> +		/* set GPADC MISC1 register */
> +		data = 0;
> +		if (pdata->touch->gpadc_prebias)
> +			data |= pdata->touch->gpadc_prebias << 1;
> +		if (pdata->touch->slot_cycle)
> +			data |= pdata->touch->slot_cycle << 3;
> +		if (pdata->touch->off_scale)
> +			data |= pdata->touch->off_scale << 5;
> +		if (pdata->touch->sw_cal)
> +			data |= pdata->touch->sw_cal << 7;

This cab be simply written as:

	data =  (pdata->touch->gpadc_prebias << 1) |
		(pdata->touch->slot_cycle << 3) |
		(pdata->touch->off_scale << 5) |
		(pdata->touch->sw_cal << 7);

No need for checking.

> +		if (data) {
> +			ret = pm860x_reg_write(chip->parent, DESC_8607,
> +						PM8607_GPADC_MISC1, data);
> +			if (ret < 0)
> +				goto out;
> +		}
> +		/* set tsi prebias time */
> +		if (pdata->touch->tsi_prebias) {
> +			data = pdata->touch->tsi_prebias;
> +			ret = pm860x_reg_write(chip->parent, DESC_8607,
> +						PM8607_TSI_PREBIAS, data);
> +			if (ret < 0)
> +				goto out;
> +		}
> +		/* set prebias & prechg time of pen detect */
> +		data = 0;
> +		if (pdata->touch->pen_prebias)
> +			data |= pdata->touch->pen_prebias;
> +		if (pdata->touch->pen_prechg)
> +			data |= pdata->touch->pen_prechg << 5;

Same here.

> +		if (data) {
> +			ret = pm860x_reg_write(chip->parent, DESC_8607,
> +						PM8607_PD_PREBIAS, data);
> +			if (ret < 0)
> +				goto out;
> +		}
> +		

Whitespace damage.

> +		use_gpadc = 1;
> +	}
> +
> +	/* turn on GPADC */
> +	if (use_gpadc) {
> +		ret = pm860x_set_bits(chip->parent, DESC_8607,
> +					PM8607_GPADC_MISC1,
> +					PM8607_GPADC_EN,
> +					PM8607_GPADC_EN);
> +	}
> +out:
> +	return ret;
> +}
> +
>  static int __devinit __88pm8606_init(struct pm860x_chip *chip, void *pdata)
>  {
>  	chip->parent = &mixed_chip;
> @@ -337,6 +489,10 @@ static int __devinit __88pm8607_init(struct
> pm860x_chip *chip,
>  		}
>  	}
> 
> +	ret = __88pm8607_gpadc_init(chip, pdata);
> +	if (ret < 0)
> +		goto out;
> +
>  	ret = __88pm8607_irq_init(chip, pdata);
>  	if (ret < 0)
>  		goto out;
> @@ -344,9 +500,9 @@ out:
>  	return ret;
>  }
> 
> -int __devinit pm860x_device_init(struct pm860x_chip *chip, void *pdata)
> +int __devinit pm860x_device_init(struct pm860x_chip *chip,
> +				 struct pm860x_plat_data *pdata)
>  {
> -	int i, count;
>  	int ret = -EINVAL;
> 
>  	/* Mixed chip isn't initialized yet. */
> @@ -354,23 +510,46 @@ int __devinit pm860x_device_init(struct
> pm860x_chip *chip, void *pdata)
>  		mutex_init(&mixed_chip.io_lock);
> 
>  	if (!strcmp(chip->id.name, "88PM8607")) {
> -		ret = __88pm8607_init(chip, (struct pm860x_plat_data *)pdata);
> +		ret = __88pm8607_init(chip, pdata);
>  		if (ret < 0)
>  			goto out;
> 
> -		count = ARRAY_SIZE(pm8607_devs);
> -		for (i = 0; i < count; i++) {
> -			ret = mfd_add_devices(chip->dev, i, &pm8607_devs[i],
> -					      1, NULL, 0);
> -			if (ret != 0) {
> -				dev_err(chip->dev, "Failed to add subdevs\n");
> -				goto out;
> -			}
> +		ret = mfd_add_devices(chip->dev, 0, &regulator_devs[0],
> +				      ARRAY_SIZE(regulator_devs),
> +				      &regulator_resources[0], 0);
> +		if (ret < 0)
> +			dev_err(chip->dev, "Failed to add regulator subdev\n");
> +
> +		if (pdata && pdata->touch) {
> +			ret = mfd_add_devices(chip->dev, 0, &touch_devs[0],
> +					ARRAY_SIZE(touch_devs),
> +					&touch_resources[0], 0);
> +			if (ret < 0)
> +				dev_err(chip->dev, "Failed to add touch "
> +					"subdev\n");

Umm, when I was asking for error handling I expected more than just
printing a message. What about cleanup? Is device functional without
half of the devices? Do we want to have a crippled device?

Thanks.

-- 
Dmitry
