From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Fri, 9 Jul 2010 17:53:45 +0400
Subject: [PATCH 2/3] Add s3c-adc-battery driver
In-Reply-To: <201007091619.20454.anarsoul@gmail.com>
References: <1278674842-17583-1-git-send-email-anarsoul@gmail.com>
	<1278674842-17583-3-git-send-email-anarsoul@gmail.com>
	<20100709125701.GA28316@oksana.dev.rtsoft.ru>
	<201007091619.20454.anarsoul@gmail.com>
Message-ID: <20100709135345.GA4351@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 09, 2010 at 04:19:14PM +0300, Vasily Khoruzhick wrote:
[...]
> > > +	.get_property = s3c_adc_ac_get_property,
> > > +};
> > 
> > You really shouldn't create yet another "ac" power supply
> > instance. You can use drivers/power/pda_power.c for this.
> > 
> > Yep, it's duplication of pda_power.c functionality.
> > 
> > So, you probably want to register S3C ADC battery and pda-power
> > platform devices. And S3C ADC battery driver would only do
> > battery stuff, and pda-power would do the AC stuff.
> 
> Nope, I can't use pda_power here, as it can't control whether battery is 
> already charged (it's separate gpio pin, and I need to disable charger in this 
> case)

I guess you can remove all the cable_plugged handling from s3c
battery driver, and then use power_supply.external_power_changed
callback to get cable_plugged notification (you should fill
pda_power.supplied_to properly to make it work).

See drivers/power/ds2760_battery.c and arch/arm/mach-pxa/hx4700.c
as an example.

You probably will need to change .external_power_changed() hook
to accept 'pst' argument (the supply that caused the change),
so that you could write something like this:

s3c_external_power_changed(struct power_supply *psy,
			   struct power_supply *ext)
{
	...
	ext->get_property(ext, ONLINE, &val);
	s3c->is_plugged = val.intval;

	s3c_kick_cable_plugged_handler(s3c);
}

Or, instead of ext->get_property() you could just use
power_supply_is_system_supplied(). Not very elegant, but
should work.

[...]
> > > +			lut_volt1 = calc_full_volt(lut[0].volt, lut[0].cur);
> > > +			lut_volt2 = calc_full_volt(lut[1].volt, lut[1].cur);
> > > +			if (full_volt < lut_volt1 && full_volt >= lut_volt2) {
> > > +				new_level = (lut[1].level +
> > > +					(lut[0].level - lut[1].level) *
> > > +					(full_volt - lut_volt2) /
> > > +					(lut_volt1 - lut_volt2)) * 1000;
> > > +				break;
> > > +			}
> > > +			new_level = lut[1].level * 1000;
> > > +			lut++;
> > > +		}
> > > +	}
> > 
> > Cool!
> 
> Is it some kind of sarcasm? :)

Nope. ;-)

[...]
> > You probably don't need a timer for this.
> > Use schedule_work() instead.
> 
> Timer's used to prevet jitter on gpio pins, and here it's used to check pins 
> state on startup. I don't see any reason to replace it with delayed work.

Timer is a softirq, atomic context. It adds latency to your
embedded, underpowered device. Plus with timer you can't use
sleepable GPIOs (we should change it for pda_power too, btw).

Jitter filtering isn't urgent task for the kernel (or user)
needs, right? So it's fine to postpone it for non-atomic
context.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
