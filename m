From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 3 May 2018 11:06:11 +0200
Subject: Motorola Droid 4 progress, power consumption
In-Reply-To: <20180502144158.GJ98604@atomide.com>
References: <20180501183148.GA26996@amd> <20180502144158.GJ98604@atomide.com>
Message-ID: <20180503090611.GA14451@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Anyway, >5.5hours of standby with screen off, GSM on is already
> > usable.
> 
> Just to rub that in, you do mean GSM usable for voice calls and
> SMS with your unicsy_demo with mainline kernel plus the pending
> LCD related patches, right? :)
> 
> > This is the core of code I'm using.
> > 
> > https://github.com/pavelmachek/unicsy_demo
> > 
> > Battery graphs are attached. I'm not sure if the battery was really
> > close to empty at that point -- voltage curve should have different
> > shape if that was the case. 
> 
> Cool. BTW, the value for POWER_SUPPLY_POWER_AVG should be quite
> accurate for the whole device power consumption.
> 
> It comes from the shunt resistor measured by the PMIC. Sorry I don't
> remember how often it needs to be polled but I'm guessing polling it
> once a minute or so should be plenty.

I'd like current_avg more, but if I cat it manually, it changes on
order of seconds, and quite significantly... which suggest shorter
polling interval would be needed.

user at devuan:/sys/class/power_supply/battery$ date; cat current_now
current_avg
Thu May  3 09:33:05 CEST 2018
-71000
-218408
user at devuan:/sys/class/power_supply/battery$ date; cat current_now
current_avg
Thu May  3 09:33:06 CEST 2018
-61000
-200238
user at devuan:/sys/class/power_supply/battery$ date; cat current_now
current_avg
Thu May  3 09:33:06 CEST 2018
-51000
-209879
user at devuan:/sys/class/power_supply/battery$ date; cat current_now
current_avg
Thu May  3 09:33:07 CEST 2018
-56000
-72308
user at devuan:/sys/class/power_supply/battery$ date; cat current_now
current_avg
Thu May  3 09:33:08 CEST 2018
-37000
-211362

> Hmm oh and the POWER_SUPPLY_CHARGE_COUNTER value should be monitored
> by your libbattery and it's low value and high value should be saved
> to a file. Low should be saved when we get the battery low interrupt
> and battery state changes to POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL.
> High value should be saved on POWER_SUPPLY_CAPACITY_LEVEL_FULL.
> 
> Then when you know the high value and low value, you can calculate
> the remaining capacity based on the current value and
> POWER_SUPPLY_POWER_AVG.

I'll look into that... but probably will do experiments with python,
first.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180503/5bccc8c0/attachment.sig>
