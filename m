From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 17 Mar 2015 09:47:30 +0100
Subject: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
In-Reply-To: <CAAfyv34vnRY=TAyx4+7s1SW7rVE7CFh9z+OOcCsbCx63y9aVog@mail.gmail.com>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
 <1423088075-10025-4-git-send-email-marek@goldelico.com>
 <20150316210532.GA11441@amd>
 <CAAfyv34vnRY=TAyx4+7s1SW7rVE7CFh9z+OOcCsbCx63y9aVog@mail.gmail.com>
Message-ID: <20150317084730.GA9761@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >> diff --git a/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
> >> new file mode 100644
> >> index 0000000..bb3580c
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
> >> @@ -0,0 +1,43 @@
> >> +twl4030_madc_battery
> >> +
> >> +Required properties:
> >> + - compatible : "ti,twl4030-madc-battery"
> >> + - capacity-uah : battery capacity in uAh
> >
> > Could we make it capacity-uAh ?
> This name was suggested by Mark Rutland [1] and naming convention
> should be all lowercase. There exists already bindings
> without uppercase (e.g. ti,bb-uamp) so I would keep it consistent.

Messing up SI units due to "convention" is _stupid_. Don't do it.

> > to introduce coefficients for temperature and discharge rate?
> What do you mean? Nothing like that is used in current driver why do
> we need to add it?

Well, conversion between Li-ion's voltage and state of charge at 0
current is well known:

    def percent(m, v):
    	u = 0.0387-(1.4523*(3.7835-v))
        if u < 0:
            return 0
          return (0.1966+math.sqrt(u))*100

And there's not much to calibrate there, and it should become library
helper function; there's no need to write it to every single dts.

The charge/discharge difference is due to internal battery resistance,
and Ohm's law. (Then, you should not need different values for
charging/discharging case.)

With your aproach, you'll get lower percentage when phone is under
load vs. idle. Taking internal resistance into account would give you
more precise readings. (Attached, old patch for zaurus shows the
needed computation).

And if you wanted even more precise readings... internal resistance
depends on temperature.

I guess this should go into library somewhere, because many machines
need similar code.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: zbattery.10.diff
Type: text/x-diff
Size: 15807 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150317/debefd99/attachment.bin>
