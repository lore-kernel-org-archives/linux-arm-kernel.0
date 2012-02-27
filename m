From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 27 Feb 2012 15:58:11 +0100
Subject: [V3 1/3] mfd: add power control interface for pm8606 chip
In-Reply-To: <1330052089-12215-1-git-send-email-jtzhou@marvell.com>
References: <1330052089-12215-1-git-send-email-jtzhou@marvell.com>
Message-ID: <20120227145811.GS27687@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jett,

I have one more comment, sorry for not including it in my first review:

On Fri, Feb 24, 2012 at 10:54:49AM +0800, Jett.Zhou wrote:
> +static void __devinit device_osc_init(struct i2c_client *i2c)
> +{
> +	struct pm860x_chip *chip = i2c_get_clientdata(i2c);
> +
> +	mutex_init(&chip->osc_lock);
> +	/* init portofino reference group voting and status */
> +	/* Disable Reference group Vsys */
> +	pm860x_set_bits(i2c, PM8606_VSYS, PM8606_VSYS_EN, 0);
> +	/* Disable Internal Oscillator */
> +	pm860x_set_bits(i2c, PM8606_MISC, PM8606_MISC_OSC_EN, 0);
> +
> +	chip->osc_vote = REF_GP_NO_CLIENTS;
> +	chip->osc_status = PM8606_REF_GP_OSC_OFF;
> +}
> +
>  static void __devinit device_bk_init(struct pm860x_chip *chip,
>  				     struct pm860x_platform_data *pdata)
>  {
> @@ -767,6 +860,15 @@ out:
>  	return;
>  }
>  
> +static void __devinit device_8606_init(struct pm860x_chip *chip,
> +				       struct i2c_client *i2c,
> +				       struct pm860x_platform_data *pdata)
> +{
> +	device_osc_init(i2c);
> +	device_bk_init(chip, pdata);
> +	device_led_init(chip, pdata);
> +}
> +
Could you please put the device_8606_init() factorization into a separate
patch ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
