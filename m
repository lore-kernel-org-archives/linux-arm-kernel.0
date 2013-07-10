From: broonie@kernel.org (Mark Brown)
Date: Wed, 10 Jul 2013 16:47:12 +0100
Subject: [PATCH] rtc: Add MOXA ART RTC driver
In-Reply-To: <1373464848-28146-1-git-send-email-jonas.jensen@gmail.com>
References: <1373464848-28146-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20130710154712.GG24508@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 10, 2013 at 04:00:48PM +0200, Jonas Jensen wrote:

> +++ b/drivers/rtc/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_RTC_DRV_MAX6902)	+= rtc-max6902.o
>  obj-$(CONFIG_RTC_DRV_MAX77686)	+= rtc-max77686.o
>  obj-$(CONFIG_RTC_DRV_MC13XXX)	+= rtc-mc13xxx.o
>  obj-$(CONFIG_RTC_DRV_MSM6242)	+= rtc-msm6242.o
> +obj-$(CONFIG_RTC_DRV_MOXART)	+= rtc-moxart.o
>  obj-$(CONFIG_RTC_DRV_MPC5121)	+= rtc-mpc5121.o

It'd be good to keep this sorted.

> +struct rtc_plat_data {

This is a bit confusing - normally platform data is data passed in by
the platform as part of device registration, not runtime data.

> +	struct rtc_device *rtc;
> +};
> +
> +static spinlock_t rtc_lock;

Why is this global not part of the runtime data?  Not that anyone is
likely to have two RTCs in the one system but still...

> +u8 moxart_rtc_read_byte(void)
> +{
> +	int i;
> +	u8 data = 0;
> +
> +	for (i = 0; i < 8; i++) {
> +		gpio_set_value(GPIO_RTC_SCLK, GPIO_EM1240_LOW);
> +		udelay(GPIO_RTC_DELAY_TIME);
> +		gpio_set_value(GPIO_RTC_SCLK, GPIO_EM1240_HIGH);
> +		if (gpio_get_value(GPIO_RTC_DATA))
> +			data |= (1 << i);
> +		udelay(GPIO_RTC_DELAY_TIME);

This looks wrong, although I expect it's probably fine - you're reading
the value with no delay after setting the GPIO high.  I assume the
hardware actually strobes the data out on the the high to low transition
but in that case I'd expect the get to be before the raise.  Either that
or some delay after the raise just to make sure.

It's also very odd seeing the constants for _LOW and _HIGH, these should
just be booleans.

> +static int moxart_rtc_ioctl(struct device *dev, unsigned int cmd,
> +	unsigned long arg)
> +{
> +	switch (cmd) {
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +
> +	return 0;
> +}

Why not just remove this function?

> + out:
> +	if (pdata->rtc)
> +		rtc_device_unregister(pdata->rtc);
> +	devm_kfree(&pdev->dev, pdata);

devm_kfree() isn't needed, the main point of devm_ is to avoid having to
explicitly free things.

> +	gpio_free(GPIO_RTC_DATA);
> +	gpio_free(GPIO_RTC_SCLK);
> +	gpio_free(GPIO_RTC_RESET);

Use devm_gpio_request().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130710/be4d14ac/attachment.sig>
