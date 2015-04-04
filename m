From: hns@goldelico.com (Dr. H. Nikolaus Schaller)
Date: Sat, 4 Apr 2015 11:46:10 +0200
Subject: [PATCH v4 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
In-Reply-To: <20150404081655.GD31064@amd>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
 <1426022847-30912-4-git-send-email-marek@goldelico.com>
 <20150311152414.GX5264@atomide.com>
 <844740CD-C95B-4411-A2C8-4906F58DBEE8@goldelico.com>
 <20150311164442.GA5264@atomide.com> <20150331072643.GB30788@amd>
 <BC5A7447-CAD7-4CCE-8F08-8CEFBB5C6905@goldelico.com>
 <20150401201605.GA11421@amd>
 <D659872E-E276-4E00-BAFC-1E461EDA1FA7@goldelico.com>
 <20150404081655.GD31064@amd>
Message-ID: <920D9B36-7369-4E3F-83F3-DB27D52503CC@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

Am 04.04.2015 um 10:16 schrieb Pavel Machek <pavel@ucw.cz>:

> Hi!
> 
>>>> Please propose your own code doing that so that we can test if it is
>>>> better.
>>> 
>>> So, how does this look?
>>> 
>>> It looks to me like you have cca 0.1 Ohm resistance in your system,
>> 
>> This is completely unknown.
>> 
>>> and are using cca 75mA while discharging, and charge by cca 1.4A.
>> 
>> Where do you get these figures from?
> 
> Least squares fitting of my coefficients to your tables.

Ah, I see.

> 
>> A GTA04 board discharges usually between 50 and 400 mA (depending on activities)
>> and if you turn on WiFi, it will be up to 600 mA. If you use 3G it can draw even more
>> during operation.
> 
> How big battery do you have?

1200 mAh

> According to least squares fitting,
> assuming maximum charge of .46A, you were taking about 25mA when
> doing the discharge test.

No, that can?t fit well. But I do not remember who has done this calibration in which situation
because it was done many months ago for the platform data version. We have just reformatted
the table for the DT.

> 
>> Total current going in is 500-800 mA (depending on USB negotiations) and this is
>> split into system operation and charging current. So 1.4A charging current is not
>> possible. Rather 200-500 mA.
>> 
>> So it might be that the battery is discharged although the system is connected
>> to a charger.
> 
> Yah, and your battery meter will be wrong in such case, as will be
> mine, because they are based on same information.

Well, it is not ?mine?, it is the platform_data based driver already in kernel.org
since ca. 3.12.

We have just updated it to DT to get rid of platform_data in this area as well?

Yes, I see your argument that hiding the tables (two characteristic curves)
into an analytic approximation can be superior. 

The problem I see is just that your formula needs some parameters which
are difficult to derive or estimate. And must be adjusted to the specific
battery and system setup in a non-trivial way.

At least we must supply a tool (in the kernel/scripts directory?) where someone
can can estimate the parameters of the formula from the characteristic curves.

Maybe a tool that automatically runs several charge/discharge cycles at
different system load. And measures time vs. voltage. And assumes a linear
capacity decrease between the end points. (i.e. if it needs 10 hours to charge
from completely empty to full, we can assume 50% after 5,0 hours).

So my goal is to measure all characteristics of the battery - and no need to
study a (potentially non-existing) data sheet.

If you can provide that for all parameters of your algorithm I am fine with it.

> The thing is, mine
> can be improved without adding more tables. 

How can you improve your algorithm without tweaking or adding new parameters?

> 
>>> It is tricky to do a good job near 0%... or anywhere else. See for
>>> example
>>> 
>>> http://cseweb.ucsd.edu/~trosing/lectures/battery.pdf
>>> 
>>> You start a call, percentage goes down, end a call, it will go
>>> back up. I'm pretty sure you will not be able to make a call with "5%"
>>> indication from your code at low battery temperature (say -10C).
>> 
>> The whole system is heating up a little, so that you never have -10C for the
>> battery.
> 
> Umm. When not calling, your phone should not heat itself up.

Yes, in suspend it needs <20 mA which does not heat or course.
But steady operation@20-400 mA does significantly rise OMAP
temperature beyond environment temperature.

> And you
> definitely can power it down, leave it in outer pocket, then power it
> up. It is actually something people do when they want to preserve battery...
> 
>> I think you are trying to solve situations that don?t exist in practice.
>> 
>> And AFAIK, the GTA04 board is the only user of this driver in case the battery
>> has no built-in fuel gauge. So why improve it beyond what the GTA04
>> users need?
> 
> Because then other users can share the same code, and because you

But you have ugly parameters in dts that nobody can easily see in the schematics
and that are full of assumptions.

>From a perspective of uncertainty analysis, estimation of the internal parameters
needs a higher precision than the calibration points.

> avoid big ugly tables in dts.

Well, the biggest tables I have seen in dts are keyboard matrix codes?

> 
>> I repeat myself: this driver is not built for highest precision because there are
>> better methods (fuel gauge chip). These might not be available so this fall-back
>> driver has been built.
>> 
>> It is definitively better than no driver and worse than the optimum.
> 
> And my email suggested solution better than your driver, so why not
> just use it?

I am not yet convinced that it is better.

It just moves the (unavoidable) limitations (measuring multiple calibration points)
just to a different area (measuring the hidden and not precisely known parameter
of the system).

> 
> 
>>> #perc = percent(volt)
>>> compute(charging, 1)
>>> compute(discharging, 0)
>> 
>> Please explain what you calculate here. Especially what ?Badness? is?
> 
> Badness is error in least squares method.

Ok, I see. Thanks for clarification.

BR,
NIkolaus
