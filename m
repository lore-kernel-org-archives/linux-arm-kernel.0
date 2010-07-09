From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 9 Jul 2010 17:07:43 +0300
Subject: [PATCH 2/3] Add s3c-adc-battery driver
In-Reply-To: <20100709135345.GA4351@oksana.dev.rtsoft.ru>
References: <1278674842-17583-1-git-send-email-anarsoul@gmail.com>
	<201007091619.20454.anarsoul@gmail.com>
	<20100709135345.GA4351@oksana.dev.rtsoft.ru>
Message-ID: <201007091707.47807.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 9 ???? 2010 16:53:45 ????? Anton Vorontsov ???????:
> 
> I guess you can remove all the cable_plugged handling from s3c
> battery driver, and then use power_supply.external_power_changed
> callback to get cable_plugged notification (you should fill
> pda_power.supplied_to properly to make it work).
> 
> See drivers/power/ds2760_battery.c and arch/arm/mach-pxa/hx4700.c
> as an example.
> 
> You probably will need to change .external_power_changed() hook
> to accept 'pst' argument (the supply that caused the change),
> so that you could write something like this:
> 
> s3c_external_power_changed(struct power_supply *psy,
> 			   struct power_supply *ext)
> {
> 	...
> 	ext->get_property(ext, ONLINE, &val);
> 	s3c->is_plugged = val.intval;
> 
> 	s3c_kick_cable_plugged_handler(s3c);
> }
> 
> Or, instead of ext->get_property() you could just use
> power_supply_is_system_supplied(). Not very elegant, but
> should work.

You didn't get the point. Here's workflow:

cable plugged -> GPF2 goes to 0, irq is generated
cable plugged irq handler -> cable_plugged ? enable_charger : disable_charger
charging....
battery is charged, GPF3 goes to 0, irq is generated
battery charged irq handler -> disable_charger
cable unplugged -> GPF2 goest to 1, irq is generated

pda_power driver does not support 'battery_charged' pin handling, but I need 
to handle this pin (and IRQ from it) to prevent battery overcharge

> Timer is a softirq, atomic context. It adds latency to your
> embedded, underpowered device. Plus with timer you can't use
> sleepable GPIOs (we should change it for pda_power too, btw).
> 
> Jitter filtering isn't urgent task for the kernel (or user)
> needs, right? So it's fine to postpone it for non-atomic
> context.

Ok, will replace timer with delayed works

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100709/0dfa45f9/attachment.sig>
