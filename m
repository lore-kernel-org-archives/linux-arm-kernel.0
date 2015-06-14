From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 14 Jun 2015 16:18:55 +0100
Subject: [PATCH v5 07/17] video: lcd: add LoCoMo LCD driver
In-Reply-To: <1433797008-6246-8-git-send-email-dbaryshkov@gmail.com>
References: <1433797008-6246-1-git-send-email-dbaryshkov@gmail.com>
 <1433797008-6246-8-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20150614151855.GF7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 11:56:38PM +0300, Dmitry Eremin-Solenikov wrote:
> +int locomo_lcd_set_power(struct lcd_device *ldev, int power)
> +{
> +	struct locomo_lcd *lcd = lcd_get_data(ldev);
> +
> +	dev_dbg(&ldev->dev, "LCD power %d (is %d)\n", power, lcd->power);
> +
> +	if (!power && lcd->power)
> +		locomo_lcd_on(lcd);
> +
> +	if (power && !lcd->power)
> +		locomo_lcd_off(lcd);

Is this correct?  You want to turn the LCD _off_ if power is non-zero, but
turn it _on_ if power is _zero_ ?

Just wondering if this would be clearer:

	if (!power != !lcd->power) {
		/* Power state is different */
		if (!power)
			locomo_lcd_on(lcd);
		else
			locomo_lcd_off(lcd);

		lcd->power = power;
	}

At least less prone to getting the power state wrong...

> +static int locomo_lcd_remove(struct platform_device *dev)
> +{
> +	struct lcd_device *ldev = platform_get_drvdata(dev);
> +	struct locomo_lcd *lcd = lcd_get_data(ldev);
> +
> +	locomo_lcd_off(lcd);

You're careful above not to turn the LCD off if it's already off, but here
that doesn't matter?  What if the LCD is already off?  Does this need
protection against double-off?

> +
> +	locomo_lcd_disable_adsync(lcd);
> +
> +	iio_channel_release(lcd->comadj);
> +
> +	return 0;
> +}
> +
> +static void locomo_lcd_shutdown(struct platform_device *dev)
> +{
> +	struct lcd_device *ldev = platform_get_drvdata(dev);
> +	struct locomo_lcd *lcd = lcd_get_data(ldev);
> +
> +	locomo_lcd_off(lcd);

Ditto.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
