From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 23 Feb 2012 17:32:16 +0100
Subject: [V1 1/3] mfd: add power control interface for pm8606 chip
In-Reply-To: <1329469400-8167-1-git-send-email-jtzhou@marvell.com>
References: <1329469400-8167-1-git-send-email-jtzhou@marvell.com>
Message-ID: <20120223163216.GL24377@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jett,

On Fri, Feb 17, 2012 at 05:03:20PM +0800, Jett.Zhou wrote:
> +int pm8606_osc_enable(struct pm860x_chip *chip, unsigned short client)
> +{
> +	int ret = -EIO;
> +	struct i2c_client *i2c = (chip->id == CHIP_PM8606) ?
> +		chip->client : chip->companion;
> +
> +	dev_dbg(chip->dev, "%s(B): client=0x%x\n", __func__, client);
> +	dev_dbg(chip->dev, "%s(B): vote=0x%x status=%d\n",
> +			__func__, chip->osc_vote,
> +			chip->osc_status);
> +
> +	mutex_lock(&chip->osc_lock);
> +	/* Update voting status */
> +	chip->osc_vote |= client;
> +	/* If reference group is off - turn on*/
> +	if (chip->osc_status != PM8606_REF_GP_OSC_ON) {
> +		do {
> +			chip->osc_status =
> +				PM8606_REF_GP_OSC_UNKNOWN;
> +
> +			/* Enable Reference group Vsys */
> +			if (pm860x_set_bits(i2c, PM8606_VSYS,
> +					PM8606_VSYS_EN, PM8606_VSYS_EN))
> +				break;
> +			/*Enable Internal Oscillator */
> +			if (pm860x_set_bits(i2c, PM8606_MISC,
> +					PM8606_MISC_OSC_EN, PM8606_MISC_OSC_EN))
> +				break;
> +
> +			/* Update status (only if writes succeed) */
> +			chip->osc_status = PM8606_REF_GP_OSC_ON;
> +			ret = 0;
> +		} while (0);
Could you please remove the do {} while (0); scope ?


> +	} else
> +		ret = 0;
> +	mutex_unlock(&chip->osc_lock);
> +
> +	dev_dbg(chip->dev, "%s(A): vote=0x%x status=%d ret=%d\n",
> +			__func__, chip->osc_vote,
> +			chip->osc_status, ret);
> +	return ret;
> +}
Beside the unneeded scope, you should add more spacing in this routine. It
would look more readable.

> @@ -766,7 +867,14 @@ static void __devinit device_8607_init(struct pm860x_chip *chip,
>  out:
>  	return;
>  }
> -
Keep this one here.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
