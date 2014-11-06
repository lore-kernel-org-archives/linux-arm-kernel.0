From: broonie@kernel.org (Mark Brown)
Date: Thu, 6 Nov 2014 05:50:17 +0000
Subject: [PATCHv0 3/3] rtc: rtc-isl12057: add alarm support to Intersil
 ISL12057 RTC driver
In-Reply-To: <148403c0ab1d556cbb99d9242c65f714a77843e5.1415222752.git.arno@natisbad.org>
References: <cover.1415222752.git.arno@natisbad.org>
 <148403c0ab1d556cbb99d9242c65f714a77843e5.1415222752.git.arno@natisbad.org>
Message-ID: <20141106055017.GL8509@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 05, 2014 at 10:42:52PM +0100, Arnaud Ebalard wrote:

> +static int _isl12057_rtc_toggle_alarm(struct device *dev, int enable)
> +{
> +	struct isl12057_rtc_data *data = dev_get_drvdata(dev);

I can't help but think that toggle is a confusing name for this.
enable?

> +	ret = regmap_update_bits(data->regmap, ISL12057_REG_INT,
> +				 ISL12057_REG_INT_A1IE,
> +				 enable ? ISL12057_REG_INT_A1IE : 0);
> +	if (ret)
> +		dev_err(dev, "%s: writing INT failed\n", __func__);

It's generally helpful to log the error code as well.

> +static int _isl12057_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
>  	u8 regs[ISL12057_RTC_SEC_LEN];
>  	int ret;
>  
> -	mutex_lock(&data->lock);
>  	ret = regmap_bulk_read(data->regmap, ISL12057_REG_RTC_SC, regs,
>  			       ISL12057_RTC_SEC_LEN);
> -	mutex_unlock(&data->lock);
> -

This is a perfectly sensible change (there's no need for the lock,
regmap locks the physical I/O and there's no other interaction) but it's
not related to enabling alarm functionality so should be in a separate
patch.

> +static int isl12057_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	ret = _isl12057_rtc_read_time(dev, tm);
> +	mutex_unlock(&data->lock);

Why lock?  I guess this is due to the above change but it seems better
to just not lock since it's redundant.

> +	ret = rtc_tm_to_time(&rtc_tm, &rtc_secs);
> +	if (ret)
> +		goto err_unlock;
> +
> +	ret = rtc_tm_to_time(alarm_tm, &alarm_secs);
> +	if (ret)
> +		goto err_unlock;
> +
> +	/* If alarm time is before current time, disable the alarm */
> +	if (!alarm->enabled || alarm_secs <= rtc_secs) {
> +		enable = 0;

Shouldn't there be some margin for time rolling forwards when checking
for alarm times in the past (or just refuse to set them, I've not
checked if this is following existing practice for RTC drivers)? 

> +	if (client->irq > 0) {
> +		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +						isl12057_rtc_interrupt,
> +						IRQF_SHARED|IRQF_ONESHOT,
> +						DRV_NAME, client);
> +		if (!ret) {
> +			device_init_wakeup(&client->dev, true);
> +		} else {
> +			dev_err(dev, "irq %d unavailable, no alarm support\n",
> +				client->irq);
> +			client->irq = 0;
> +		}
> +	}
> +

None of the alarm functionality checks to see if there's actually an IRQ
- is that OK?  I'd at least expect the alarm interrupt enable call to
check if the interrupt is wired up.

It's also bad form to overwrite client->irq - it's possible a future
probe might work (eg, if the driver for the interrupt controller gets
loaded).  Ideally we'd handle deferred probe, though I don't think the
interrupt core supports that yet.

> +err:
> +	if (client->irq > 0)
> +		free_irq(client->irq, client);

The whole point with devm_ is that you don't need to manually free
anything, remove this (and the entire remove function).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/4b2c7d8e/attachment.sig>
