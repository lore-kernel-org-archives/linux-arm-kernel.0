From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Thu, 4 Aug 2016 10:41:00 +0200
Subject: [PATCH v3 4/4] iio: adc: add support for Allwinner SoCs ADC
In-Reply-To: <20160729071230.GB6215@lukather>
References: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469519027-11387-5-git-send-email-quentin.schulz@free-electrons.com>
 <20160729071230.GB6215@lukather>
Message-ID: <bccb6739-4804-8c71-a120-2cb8672fb57e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 29/07/2016 09:12, Maxime Ripard wrote:
> On Tue, Jul 26, 2016 at 09:43:47AM +0200, Quentin Schulz wrote:
[...]
>> +static int sunxi_gpadc_adc_read(struct iio_dev *indio_dev, int channel,
>> +				int *val)
>> +{
>> +	struct sunxi_gpadc_dev *info = iio_priv(indio_dev);
>> +	int ret = 0;
>> +
>> +	pm_runtime_get_sync(indio_dev->dev.parent);
>> +	mutex_lock(&info->mutex);
>> +
>> +	reinit_completion(&info->completion);
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
>> +		     info->soc_specific->tp_mode_en |
>> +		     info->soc_specific->tp_adc_select |
>> +		     info->soc_specific->adc_chan_select(channel));
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC,
>> +		     SUNXI_GPADC_TP_INT_FIFOC_TP_FIFO_TRIG_LEVEL(1) |
>> +		     SUNXI_GPADC_TP_INT_FIFOC_TP_FIFO_FLUSH);
>> +	enable_irq(info->fifo_data_irq);
>> +
>> +	if (!wait_for_completion_timeout(&info->completion,
>> +					 msecs_to_jiffies(100))) {
>> +		ret = -ETIMEDOUT;
>> +		goto out;
>> +	}
>> +
>> +	*val = info->adc_data;
>> +
>> +out:
>> +	disable_irq(info->fifo_data_irq);
>> +	mutex_unlock(&info->mutex);
>> +	pm_runtime_mark_last_busy(indio_dev->dev.parent);
>> +	pm_runtime_put_autosuspend(indio_dev->dev.parent);
>> +
>> +	return ret;
>> +}
>> +
>> +static int sunxi_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
>> +{
>> +	struct sunxi_gpadc_dev *info = iio_priv(indio_dev);
>> +	int ret = 0;
>> +
>> +	pm_runtime_get_sync(indio_dev->dev.parent);
>> +	mutex_lock(&info->mutex);
>> +
>> +	reinit_completion(&info->completion);
>> +
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC,
>> +		     SUNXI_GPADC_TP_INT_FIFOC_TP_FIFO_TRIG_LEVEL(1) |
>> +		     SUNXI_GPADC_TP_INT_FIFOC_TP_FIFO_FLUSH);
>> +	/*
>> +	 * The temperature sensor returns valid data only when the ADC operates
>> +	 * in touchscreen mode.
>> +	 */
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
>> +		     info->soc_specific->tp_mode_en);
>> +	enable_irq(info->temp_data_irq);
>> +
>> +	if (!wait_for_completion_timeout(&info->completion,
>> +					 msecs_to_jiffies(100))) {
>> +		ret = -ETIMEDOUT;
>> +		goto out;
>> +	}
>> +
>> +	*val = info->temp_data;
>> +
>> +out:
>> +	disable_irq(info->temp_data_irq);
>> +	mutex_unlock(&info->mutex);
>> +	pm_runtime_mark_last_busy(indio_dev->dev.parent);
>> +	pm_runtime_put_autosuspend(indio_dev->dev.parent);
>> +
>> +	return ret;
>> +}
> 
> This looks like the exact same function than above, can't that be
> factored (for example by passing the interrupt number as argument, and
> giving it a way to know if it's going to be used for the ADC or
> temperature as an argument?)

Yes it can. I could use the interrupt number to know in which mode to
operate since each interrupt is only activated in one mode (temperature
or ADC).

[...]
>> +static int sunxi_gpadc_runtime_suspend(struct device *dev)
>> +{
>> +	struct sunxi_gpadc_dev *info = iio_priv(dev_get_drvdata(dev));
>> +
>> +	mutex_lock(&info->mutex);
>> +
>> +	/* Disable the ADC on IP */
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1, 0);
>> +	/* Disable temperature sensor on IP */
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_TPR, 0);
>> +
>> +	mutex_unlock(&info->mutex);
> 
> Having some comments somewhere about what this mutex protects would be
> great (just like checkpatch tells you about).

ACK.

> However, I'm not sure this is even possible. Isn't the point of the
> runtime_pm precisely to not be called while you're using the device?

I agree on the principle but I am using runtime_pm functions (I am
mainly talking about the pm_runtime_put function) when probing or
removing the driver. Let's say we remove the mutex locks in runtime_pm
functions, what will happen if we are reading raw values from the ADC
when removing the ADC driver for example?

>> +
>> +	return 0;
>> +}
>> +
>> +static int sunxi_gpadc_runtime_resume(struct device *dev)
>> +{
>> +	struct sunxi_gpadc_dev *info = iio_priv(dev_get_drvdata(dev));
>> +
>> +	mutex_lock(&info->mutex);
>> +
>> +	/* clkin = 6MHz */
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL0,
>> +		     SUNXI_GPADC_TP_CTRL0_ADC_CLK_DIVIDER(2) |
>> +		     SUNXI_GPADC_TP_CTRL0_FS_DIV(7) |
>> +		     SUNXI_GPADC_TP_CTRL0_T_ACQ(63));
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
>> +		     info->soc_specific->tp_mode_en);
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL3,
>> +		     SUNXI_GPADC_TP_CTRL3_FILTER_EN |
>> +		     SUNXI_GPADC_TP_CTRL3_FILTER_TYPE(1));
>> +	/* period = SUNXI_GPADC_TP_TPR_TEMP_PERIOD * 256 * 16 / clkin; ~1.3s */
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_TPR,
>> +		     SUNXI_GPADC_TP_TPR_TEMP_ENABLE |
>> +		     SUNXI_GPADC_TP_TPR_TEMP_PERIOD(1953));
>> +
>> +	mutex_unlock(&info->mutex);
>> +
>> +	return 0;
>> +}
[...]
>> +	info->soc_specific = (struct sunxi_gpadc_soc_specific *)platform_get_device_id(pdev)->driver_data;
> 
> I'm not sure that cast is necessary (and you can probably shorten that
> structure name).

GCC warns about implicit pointer to integer cast in that case. ACK for
structure name.

[...]
>> +
>> +	irq = platform_get_irq_byname(pdev, "TEMP_DATA_PENDING");
>> +	if (irq < 0) {
>> +		dev_err(&pdev->dev,
>> +			"no TEMP_DATA_PENDING interrupt registered\n");
>> +		ret = irq;
>> +		goto err;
>> +	}
>> +
>> +	irq = regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
>> +	ret = devm_request_any_context_irq(&pdev->dev, irq,
>> +					   sunxi_gpadc_temp_data_irq_handler, 0,
>> +					   "temp_data", info);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev,
>> +			"could not request TEMP_DATA_PENDING interrupt: %d\n",
>> +			ret);
>> +		goto err;
>> +	}
>> +
>> +	disable_irq(irq);
>> +	info->temp_data_irq = irq;
>> +	atomic_set(&info->ignore_temp_data_irq, 0);
>> +
>> +	irq = platform_get_irq_byname(pdev, "FIFO_DATA_PENDING");
>> +	if (irq < 0) {
>> +		dev_err(&pdev->dev,
>> +			"no FIFO_DATA_PENDING interrupt registered\n");
>> +		ret = irq;
>> +		goto err;
>> +	}
>> +
>> +	irq = regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
>> +	ret = devm_request_any_context_irq(&pdev->dev, irq,
>> +					   sunxi_gpadc_fifo_data_irq_handler, 0,
>> +					   "fifo_data", info);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev,
>> +			"could not request FIFO_DATA_PENDING interrupt: %d\n",
>> +			ret);
>> +		goto err;
>> +	}
>> +
>> +	disable_irq(irq);
>> +	info->fifo_data_irq = irq;
>> +	atomic_set(&info->ignore_fifo_data_irq, 0);
> 
> These two blocks to handle the IRQs look very similar, you porbably
> want to factor them.

ACK.

[...]
>> +
>> +err:
>> +	pm_runtime_put(&pdev->dev);
> 
> You're never disabling it?

ACK.

>> +	/* Disable all hardware interrupts */
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC, 0);
> 
> This looks like the wrong place to do that. You'll disable the
> interrupts of all the devices of the MFD, which is probbaly not what
> you want to do (and if you do, you want to do it in the MFD driver).

Yes but all subdrivers of the MFD are using IIO channels from the ADC
driver so anyway they would not work at all.

[...]
>> +static const struct platform_device_id sunxi_gpadc_id[] = {
>> +	{ "sun4i-a10-gpadc-iio", (kernel_ulong_t)&sun4i_gpadc_soc_specific },
>> +	{ "sun5i-a13-gpadc-iio", (kernel_ulong_t)&sun5i_gpadc_soc_specific },
>> +	{ "sun6i-a31-gpadc-iio", (kernel_ulong_t)&sun6i_gpadc_soc_specific },
> 
> kernel_ulong_t ? that's weird.

That's the type of the data field of platform_device_id
(http://lxr.free-electrons.com/source/include/linux/mod_devicetable.h#L498).
Otherwise, GCC warns with implicit pointer to integer cast.

Quentin

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160804/3afad6e2/attachment.sig>
