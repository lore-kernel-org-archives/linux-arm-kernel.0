From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 4 May 2018 22:20:44 +0200
Subject: Motorola Droid 4 progress, power consumption
In-Reply-To: <20180503142240.GQ98604@atomide.com>
References: <20180501183148.GA26996@amd> <20180502144158.GJ98604@atomide.com>
 <20180503090611.GA14451@amd> <20180503142240.GQ98604@atomide.com>
Message-ID: <20180504202044.GC22519@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > user at devuan:/sys/class/power_supply/battery$ date; cat current_now
> > current_avg
> > Thu May  3 09:33:07 CEST 2018
> > -56000
> > -72308
> > user at devuan:/sys/class/power_supply/battery$ date; cat current_now
> > current_avg
> > Thu May  3 09:33:08 CEST 2018
> > -37000
> > -211362
> 
> I recall it just being calculated based on the time between
> the reads. Hard to say what it does, -ENODOCS.. Maybe the mc13783
> PMIC docs have something similar.

Hmm. current_avg is world readable; if it does changes to the
hardware, that's somehow bad.

But I guess I can sample charge_counter every minute or so and get
what I need?

> > > Hmm oh and the POWER_SUPPLY_CHARGE_COUNTER value should be monitored
> > > by your libbattery and it's low value and high value should be saved
> > > to a file. Low should be saved when we get the battery low interrupt
> > > and battery state changes to POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL.
> > > High value should be saved on POWER_SUPPLY_CAPACITY_LEVEL_FULL.
> > > 
> > > Then when you know the high value and low value, you can calculate
> > > the remaining capacity based on the current value and
> > > POWER_SUPPLY_POWER_AVG.
> > 
> > I'll look into that... but probably will do experiments with python,
> > first.
> 
> Sure. The reason why I think we should not do it in the kernel in
> addition to the earlier reasoning is that we don't have a place
> to store the min and max values across reboot. I think there's
> some flash on the battery over 1w bus, but it probably just
> contains battery serial number or something and is not intended
> for writing much to it. I guess the min and max values should be
> really keyd based on this battery id in case the battery gets
> changed.

I agree this should not be done in kernel as it requires persistent
storage.

Battery is not user-replacable (and this will recalibrate itself on
charge/discharge cycle) so.. I don't think keying is strictly
neccessary for D4.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180504/1468df3d/attachment.sig>
