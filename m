From: uwe@kleine-koenig.org (=?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=)
Date: Thu, 27 Nov 2014 10:23:43 +0100
Subject: [PATCHv1 6/6] rtc: rtc-isl12057: add alarm support to Intersil
 ISL12057 RTC driver
In-Reply-To: <986ee8d9d3e6862007f398ffddc2a4bb2368933e.1416006090.git.arno@natisbad.org>
References: <cover.1416006090.git.arno@natisbad.org>
 <986ee8d9d3e6862007f398ffddc2a4bb2368933e.1416006090.git.arno@natisbad.org>
Message-ID: <5476ED9F.2070600@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

finally I managed to test this series on my (unmodified) rn104.

For patch 1: Maybe point out that the issue with the century bit isn't
that critical, because this bit is not expected to be set before year 2100.

For patch 3: This patch adds a few dev_err calls that get later amended
in patch 5 to also include an error code. IMHO these should already be
added in patch 3. Patch 5 should only add it to the already existing
strings (if applicable).

For patch 4: Maybe
s/obsolete/for backwards compatibility, don't use in new code/.

Some further comments inline ...

On 11/15/2014 12:07 AM, Arnaud Ebalard wrote:
> The latter is the one found on current 3 kernel users of the chip
> for which support was initially developed (Netgear ReadyNAS 102,
> 104 and 2120 NAS). On those devices, the IRQ#2 pin of the chip is not
> connected to the SoC but to a PMIC. This allows setting an alarm,
> powering off the device and have it wake up when the alarm rings.
> To support that configuration the driver does the following:
> 
>  1. it has alarm_irq_enable() function returns -ENOTTY when no IRQ
>     is passed to the driver.
>  2. it marks the device as a wakeup source in all cases (whether an
>     IRQ is passed to the driver or not) to have 'wakealarm' sysfs
>     entry created.
This is not pretty, but I don't know if there is a nicer alternative.
Maybe this should only be done in the presence of a flag in the device
tree (say: can-wakeup-machine, a prefix would be nice, but "isil," feels
wrong).

> [...]
> FWIW, if someone is looking for a way to test alarm support on a system
> on which the chip IRQ line has the ability to boot the system (e.g.
> ReadyNAS 102, 104, etc):
> 
>     # echo 0 > /sys/class/rtc/rtc0/wakealarm
Why is this needed?

>     # echo `date '+%s' -d '+ 1 minutes'` > /sys/class/rtc/rtc0/wakealarm
>     # shutdown -h now
> 
> With the commandes above, after a minute, the system comes back to life.
s/commandes/commands/

> +	ret = regmap_update_bits(data->regmap, ISL12057_REG_INT,
> +				 ISL12057_REG_INT_A1IE,
> +				 enable ? ISL12057_REG_INT_A1IE : 0);
> +	if (ret)
> +		dev_err(dev, "%s: changing alarm interrupt flag failed (%d)\n",
> +			__func__, ret);
> +
> +	return ret;
> +}
Maybe point out in the commit log that the first alarm (of two) is used,
and the event is signaled on pin $Ididntlookitup.
(IIRC the 2nd alarm register set doesn't support seconds, but in return
has year and month field.)

> [...]
> +	/*
> +	 * This is needed to have 'wakealarm' sysfs entry available. One
> +	 * would expect the device to be marked as a wakeup source only
> +	 * when an IRQ pin of the RTC is routed to an interrupt line of the
> +	 * CPU. In practice, such an IRQ pin can be connected to a PMIC and
> +	 * this allows the device to be powered up when RTC alarm rings.
Maybe add the machines you know of that have this setup to the comment.

> +	 */
> +	device_init_wakeup(dev, true);
> +
> +	data->rtc = devm_rtc_device_register(dev, DRV_NAME, &rtc_ops,
> +					     THIS_MODULE);
> +	ret = PTR_ERR_OR_ZERO(data->rtc);
> +	if (ret) {
> +		dev_err(dev, "%s: unable to register RTC device (%d)\n",
> +			__func__, ret);
> +		goto err;
> +	}
> +
> +	/* We cannot support UIE mode if we do not have an IRQ line */
> +	if (!data->irq)
> +		data->rtc->uie_unsupported = 1;
> +
> +err:
> +	return ret;
>  }
>  
> +static int isl12057_remove(struct i2c_client *client)
> +{
> +	struct isl12057_rtc_data *rtc_data = dev_get_drvdata(&client->dev);
> +
> +	if (rtc_data->irq > 0)
> +		device_init_wakeup(&client->dev, false);
I didn't check, but I wonder it that could be/is done by the device
core already?

> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int isl12057_rtc_suspend(struct device *dev)
> +{
> +	struct isl12057_rtc_data *rtc_data = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		return enable_irq_wake(rtc_data->irq);
Does this need a check for data->irq?

> +
> +	return 0;
> +}
> +
> +static int isl12057_rtc_resume(struct device *dev)
> +{
> +	struct isl12057_rtc_data *rtc_data = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		return disable_irq_wake(rtc_data->irq);
ditto.

Thanks for your efforts to improve my NAS :-)
Uwe
