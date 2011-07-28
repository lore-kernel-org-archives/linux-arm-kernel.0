From: ido@wizery.com (Ido Yariv)
Date: Fri, 29 Jul 2011 01:06:43 +0300
Subject: [PATCH v3] davinci: Add wl1271/wlan support for AM18x
In-Reply-To: <4E31D17D.6050000@boundarydevices.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593024DD2CEC2@dbde02.ent.ti.com>
	<1311886373-3060-1-git-send-email-ido@wizery.com>
	<4E31D17D.6050000@boundarydevices.com>
Message-ID: <20110728220643.GG1985@WorkStation>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Troy,

On Thu, Jul 28, 2011 at 02:15:41PM -0700, Troy Kisky wrote:
> > +	if (power_on) {
> > +		/* Power up sequence required for wl127x devices */
> > +		gpio_set_value(DA850_WLAN_EN, 1);
> > +		usleep_range(15000, 15000);
> > +		gpio_set_value(DA850_WLAN_EN, 0);
> > +		usleep_range(1000, 1000);
> > +		gpio_set_value(DA850_WLAN_EN, 1);
> > +		msleep(70);
> 
> Why turn on, then off, and then back on?
> Isn't off, then back on sufficient?

Unfortunately, no. This is a required power up sequence for some
hardware revisions of the 1271 chip.

> Also, why not use regulator API like panda board does?

Unlike omap_hsmmc, davinci's MMC host driver does not toggle any
regulators. To keep things simple, a set_power callback function was
added to the mmc host as part of this patch series.
I've considered adding regulator support instead, but found it to be
a bit over-complicated for this task. In addition, it would require
either modifying the fixed regulator or adding a new one in order to
support the above power sequence.

Thanks for your review,
Ido.
