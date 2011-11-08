From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 8 Nov 2011 14:30:47 +0100
Subject: [PATCH 2/3] ARM: AT91: IIO: Add AT91 ADC driver.
In-Reply-To: <1320682113-23655-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
 <1320682113-23655-1-git-send-email-maxime.ripard@free-electrons.com>
 <1320682113-23655-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20111108143047.25f8fdd6@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Mon,  7 Nov 2011 17:08:32 +0100,
Maxime Ripard <maxime.ripard@free-electrons.com> a ?crit :

> +static inline u32 at91adc_reg_read(void *base, u8 reg)
> +{
> +	return readl_relaxed(base + reg);
> +}
> +
> +static inline void at91adc_reg_write(void *base, u8 reg, u32 val)
> +{
> +	writel_relaxed(val, base + reg);
> +}

Those could probably be written to take a at91adc_state structure as
argument, in order to simplify the call sites. I.e:

static inline u32 at91adc_reg_read(struct at91adc_state *st, u8 reg)
{
	return readl_relaxed(st->reg_base + reg);
}

static inline void at91adc_reg_write(struct at91adc_state *st, u8 reg, u32 val)
{
	writel_relaxed(val, st->reg_base + reg);
}


> +static irqreturn_t at91adc_eoc_trigger(int irq, void *private)
> +{
> +	int chan;
> +	struct iio_dev *idev = private;
> +	struct at91adc_state *st = iio_priv(idev);
> +	unsigned int status = at91adc_reg_read(st->reg_base, AT91_ADC_SR);

would become

+	unsigned int status = at91adc_reg_read(st, AT91_ADC_SR);

> +	if (!(status & AT91_ADC_DRDY))
> +		return IRQ_HANDLED;
> +
> +	for (chan = 0; chan < idev->num_channels; chan++)
> +		if (status & AT91_ADC_EOC(chan)) {
> +			st->done = true;
> +			st->last_value = at91adc_reg_read(st->reg_base,
> +							  AT91_ADC_CHR(chan));

would become

+			st->last_value = at91adc_reg_read(st, AT91_ADC_CHR(chan));


> +static int at91adc_channel_init(struct iio_dev *idev,
> +				struct at91_adc_data *pdata)
> +{
> +	struct iio_chan_spec *chan_array;
> +	int bit, idx = 0;
> +
> +	idev->num_channels = bitmap_weight(&(pdata->channels_used),
> +					   pdata->num_channels);
> +	chan_array = kcalloc(idev->num_channels, sizeof(struct iio_chan_spec),
> +			     GFP_KERNEL);
> +
> +	if (chan_array == NULL)
> +		return -ENOMEM;
> +
> +	for_each_set_bit(bit, &(pdata->channels_used), pdata->num_channels) {
> +		struct iio_chan_spec *chan = chan_array + idx;
> +		chan->type = IIO_VOLTAGE;
> +		chan->indexed = 1;
> +		chan->channel = bit;
> +		chan->scan_type.sign = 's';

It's an unsigned value that you're reading from the ADC, so maybe this
should be = 'u'.

> +static void at91adc_channel_remove(struct iio_dev *idev)
> +{
> +	if (idev->channels == NULL)
> +		return;
> +
> +	kfree(idev->channels);

kfree() is fine with having its argument being NULL, so the if test is
useless here. See http://lxr.free-electrons.com/source/mm/slab.c#L3863.

> +static int at91adc_read_raw(struct iio_dev *idev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct at91adc_state *st = iio_priv(idev);
> +	unsigned int scale_uv;
> +
> +	switch (mask) {
> +	case 0:
> +		mutex_lock(&st->lock);
> +
> +		at91adc_reg_write(st->reg_base, AT91_ADC_CHER,
> +				  AT91_ADC_CH(chan->channel));
> +		at91adc_reg_write(st->reg_base, AT91_ADC_IER,
> +				  AT91_ADC_EOC(chan->channel));
> +		at91adc_reg_write(st->reg_base, AT91_ADC_CR, AT91_ADC_START);
> +
> +		wait_event_interruptible_timeout(st->wq_data_avail, st->done,
> +						 msecs_to_jiffies(10 * 1000));

You forgot to handle the cases where wait_event_interruptible_timeout()
exits because of a signal or because of the timeout, and make the
assumption that the wait_event_interruptible_timeout() is also
successful.


> +	/*
> +	 * Disable all IRQs before setting up the handler
> +	 */
> +	at91adc_reg_write(st->reg_base, AT91_ADC_CR, AT91_ADC_SWRST);
> +	at91adc_reg_write(st->reg_base, AT91_ADC_IDR, 0xFFFFFFFF);
> +	ret = request_irq(st->irq,
> +			  at91adc_eoc_trigger, 0, pdev->dev.driver->name, idev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to allocate IRQ.\n");
> +		goto error_unmap_reg;
> +	}
> +
> +	st->clk = clk_get(&pdev->dev, "adc_clk");
> +	if (IS_ERR(st->clk)) {
> +		dev_err(&pdev->dev, "Failed to get the clock.\n");
> +		ret = PTR_ERR(st->clk);
> +		goto error_free_irq;
> +	}
> +
> +	clk_enable(st->clk);
> +	mstrclk = clk_get_rate(st->clk);

You do a clk_get()/clk_enable() here but nowhere in the ->remove()
function you do a clk_disable()/clk_put().

> +	prsc = (mstrclk / (2 * pdata->adc_clock)) - 1;

[...]

> +	ticks = round_up((pdata->startup_time * pdata->adc_clock /
> +			  1000000) - 1, 8) / 8;

Both of those computations would be better with a small comment
explaining what's happening.

> +static int __devexit at91adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *idev = platform_get_drvdata(pdev);
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	struct at91adc_state *st = iio_priv(idev);
> +
> +	at91adc_channel_remove(idev);
> +	iio_device_unregister(idev);
> +	free_irq(st->irq, idev);
> +	iounmap(st->reg_base);
> +	release_mem_region(res->start, resource_size(res));
> +	iio_device_free(idev);

As said above, clk_disable()/clk_put() is missing.

> +static struct platform_driver at91adc_driver = {
> +	.probe = at91adc_probe,
> +	.remove = __devexit_p(at91adc_remove),
> +	.driver = {
> +		   .name = "at91adc",
> +		   },

Nitpick: wrongly placed parenthesis.

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
