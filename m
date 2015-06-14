From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 14 Jun 2015 18:16:19 +0100
Subject: [PATCH v5 07/17] video: lcd: add LoCoMo LCD driver
In-Reply-To: <CALT56yN63hiC+8xun2ewegYDd0Nqxy+uUbxnKj1skJgC3uEkpw@mail.gmail.com>
References: <1433797008-6246-1-git-send-email-dbaryshkov@gmail.com>
 <1433797008-6246-8-git-send-email-dbaryshkov@gmail.com>
 <20150614151855.GF7557@n2100.arm.linux.org.uk>
 <CALT56yN63hiC+8xun2ewegYDd0Nqxy+uUbxnKj1skJgC3uEkpw@mail.gmail.com>
Message-ID: <20150614171619.GH7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 14, 2015 at 07:28:50PM +0300, Dmitry Eremin-Solenikov wrote:
> 2015-06-14 18:18 GMT+03:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Mon, Jun 08, 2015 at 11:56:38PM +0300, Dmitry Eremin-Solenikov wrote:
> >> +int locomo_lcd_set_power(struct lcd_device *ldev, int power)
> >> +{
> >> +     struct locomo_lcd *lcd = lcd_get_data(ldev);
> >> +
> >> +     dev_dbg(&ldev->dev, "LCD power %d (is %d)\n", power, lcd->power);
> >> +
> >> +     if (!power && lcd->power)
> >> +             locomo_lcd_on(lcd);
> >> +
> >> +     if (power && !lcd->power)
> >> +             locomo_lcd_off(lcd);
> >
> > Is this correct?  You want to turn the LCD _off_ if power is non-zero, but
> > turn it _on_ if power is _zero_ ?
> 
> Yes, this is a crazy part of fb/backlight/LCD, where power is a FB_BLANK_*
> value, and FB_BLANK_UNBLANK is equal to 0.

In which case, the code is probably wrong anyway.  This would make it much
clearer:

	bool power_on = power == FB_BLANK_UNBLANK;

	if (power_on != lcd->power_is_on) {
		if (power_on)
			locomo_lcd_on(lcd);
		else
			locomo_lcd_off(lcd);

		lcd->power_is_on = power_on;
	}

with lcd->power_is_on also being a bool.  The above is almost English...

	if the power state is different from last time, then
		if we want power on
			call locomo_lcd_on
		otherwise
			call locomo_lcd_off
		remember power state

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
