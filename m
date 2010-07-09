From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Fri, 9 Jul 2010 19:15:35 +0400
Subject: [PATCH 2/3] Add s3c-adc-battery driver
In-Reply-To: <201007091707.47807.anarsoul@gmail.com>
References: <1278674842-17583-1-git-send-email-anarsoul@gmail.com>
	<201007091619.20454.anarsoul@gmail.com>
	<20100709135345.GA4351@oksana.dev.rtsoft.ru>
	<201007091707.47807.anarsoul@gmail.com>
Message-ID: <20100709151535.GA14644@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 09, 2010 at 05:07:43PM +0300, Vasily Khoruzhick wrote:
> ? ????????? ?? 9 ???? 2010 16:53:45 ????? Anton Vorontsov ???????:
> > 
> > I guess you can remove all the cable_plugged handling from s3c
> > battery driver, and then use power_supply.external_power_changed
> > callback to get cable_plugged notification (you should fill
> > pda_power.supplied_to properly to make it work).
> > 
> > See drivers/power/ds2760_battery.c and arch/arm/mach-pxa/hx4700.c
> > as an example.
> > 
> > You probably will need to change .external_power_changed() hook
> > to accept 'pst' argument (the supply that caused the change),
> > so that you could write something like this:
> > 
> > s3c_external_power_changed(struct power_supply *psy,
> > 			   struct power_supply *ext)
> > {
> > 	...
> > 	ext->get_property(ext, ONLINE, &val);
> > 	s3c->is_plugged = val.intval;
> > 
> > 	s3c_kick_cable_plugged_handler(s3c);
> > }
> > 
> > Or, instead of ext->get_property() you could just use
> > power_supply_is_system_supplied(). Not very elegant, but
> > should work.
> 
[...reordered...]
> pda_power driver does not support 'battery_charged' pin handling, but I need 
> to handle this pin (and IRQ from it) to prevent battery overcharge

And I was not talking about 'battery_charged' pin handling. :-)
Sure, battery_charged handling should be in the battery driver.

I was talking about 'cable_plugged' handling, it is the only
thing that s3c_adc_ac_get_property() is using, see the driver
you've just posted:

+static int s3c_adc_ac_get_property(struct power_supply *psy,
+                               enum power_supply_property psp,
+                               union power_supply_propval *val)
+{
+       int ret = 0;
+
+       switch (psp) {
+       case POWER_SUPPLY_PROP_ONLINE:
+               val->intval =
+                       !gpio_get_value(main_bat.pdata->gpio_cable_plugged);
+               break;
+       default:
+               ret = -EINVAL;
+               break;
+       }
+       return ret;
+}

And cable_plugged_handler() stays in the battery driver, but it
will be called by the pda_power driver via external_power_changed
callback.

> You didn't get the point. Here's workflow:
> cable plugged -> GPF2 goes to 0, irq is generated

Handled by the pda_power driver.

> cable plugged irq handler -> cable_plugged ? enable_charger : disable_charger

pda_power driver calls power_supply_changed(), which calls
s3c battery.external_power_changed/cable_plugged_handler,
which starts charging (sets is_plugged if
power_supply_is_system_supplied() returns true).

> charging....
> battery is charged, GPF3 goes to 0, irq is generated

Yep, this is handled by the s3c driver.

> battery charged irq handler -> disable_charger

This is still s3c driver's job.

> cable unplugged -> GPF2 goest to 1, irq is generated

Handled by the pda_power driver, it again sends the 'changed'
event to s3c battery driver, and the battery driver
clears is_plugged if power_supply_is_system_supplied() returns
false.

Still think this wont work?

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
