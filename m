From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 09:34:34 +0100
Subject: [PATCH v2 1/3] power: Add simple poweroff-gpio driver
In-Reply-To: <20121116192525.GA25838@schnuecks.de>
References: <1352821485-10032-1-git-send-email-andrew@lunn.ch>
 <1352821485-10032-2-git-send-email-andrew@lunn.ch>
 <20121116192525.GA25838@schnuecks.de>
Message-ID: <20121117083434.GI24569@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > + * Hold configuration here, cannot be more than one instance of the driver
> > + * since pm_power_off itself is global.
> > + */
> > +static int gpio_num = -1;
> > +static int gpio_active_low;
> > +
> > +static void gpio_poweroff_do_poweroff(void)
> > +{
> > +	BUG_ON(gpio_num == -1);
> > +
> > +	/* drive it active */
> > +	gpio_direction_output(gpio_num, !gpio_active_low);
> > +	mdelay(100);
> > +	/* rising edge or drive inactive */
> > +	gpio_set_value(gpio_num, gpio_active_low);
> > +	mdelay(100);
> > +	/* falling edge */
> > +	gpio_set_value(gpio_num, !gpio_active_low);
> > +
> > +	/* give it some time */
> > +	mdelay(100);
> 
> On the IB-NAS 6210 I need to increase this delay to a whopping 3000
> milliseconds to suppress the warning (2000 is not enough).  Is it
> acceptable to increase this to such a high value or do we need
> another solution?

Hi Simon

It is interesting how slow these things are at turning off. I already
had to increase it once from 10ms for the DNSKW.

So i will increase it to 3000 in the next spin of the patches.

Thanks

	Andrew
