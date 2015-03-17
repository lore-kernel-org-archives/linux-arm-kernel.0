From: hns@goldelico.com (Dr. H. Nikolaus Schaller)
Date: Tue, 17 Mar 2015 09:56:55 +0100
Subject: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
In-Reply-To: <20150317084730.GA9761@amd>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
 <1423088075-10025-4-git-send-email-marek@goldelico.com>
 <20150316210532.GA11441@amd>
 <CAAfyv34vnRY=TAyx4+7s1SW7rVE7CFh9z+OOcCsbCx63y9aVog@mail.gmail.com>
 <20150317084730.GA9761@amd>
Message-ID: <940EE988-03A4-4B1B-A168-959E367953A6@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 17.03.2015 um 09:47 schrieb Pavel Machek <pavel@ucw.cz>:

> Hi!
> 
>>>> diff --git a/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
>>>> new file mode 100644
>>>> index 0000000..bb3580c
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/power_supply/twl4030_madc_battery.txt
>>>> @@ -0,0 +1,43 @@
>>>> +twl4030_madc_battery
>>>> +
>>>> +Required properties:
>>>> + - compatible : "ti,twl4030-madc-battery"
>>>> + - capacity-uah : battery capacity in uAh
>>> 
>>> Could we make it capacity-uAh ?
>> This name was suggested by Mark Rutland [1] and naming convention
>> should be all lowercase. There exists already bindings
>> without uppercase (e.g. ti,bb-uamp) so I would keep it consistent.
> 
> Messing up SI units due to "convention" is _stupid_. Don't do it.
> 
>>> to introduce coefficients for temperature and discharge rate?
>> What do you mean? Nothing like that is used in current driver why do
>> we need to add it?
> 
> Well, conversion between Li-ion's voltage and state of charge at 0
> current is well known:

We can?t measure at 0 current since the OMAP is driven from battery
and charger and may also draw some mA?

> 
>    def percent(m, v):
>    	u = 0.0387-(1.4523*(3.7835-v))
>        if u < 0:
>            return 0
>          return (0.1966+math.sqrt(u))*100
> 
> And there's not much to calibrate there, and it should become library
> helper function; there's no need to write it to every single dts.
> 
> The charge/discharge difference is due to internal battery resistance,
> and Ohm's law. (Then, you should not need different values for
> charging/discharging case.)

Yes, and that also depends on the board and battery type. So you always
need to specify some battery specific coefficient for that in the DT.

We simply did choose a table, because calculating the right coefficients
is more complex and getting the table values can easily be done from
running one full charge-discharge-charge cycle.

> 
> With your aproach, you'll get lower percentage when phone is under
> load vs. idle. Taking internal resistance into account would give you
> more precise readings. (Attached, old patch for zaurus shows the
> needed computation).

This is why we have a charging and a discharging table to compensate
for this effect.

> 
> And if you wanted even more precise readings... internal resistance
> depends on temperature.

We don?t necessarily know the real battery temperature.

> 
> I guess this should go into library somewhere, because many machines
> need similar code.

Is a library easier to maintain and handle than just a set of table values?

Anyways it ends up in a representation of a mapping function with two
input parameters (voltage and charge/discharge indication).

My proposal: keep it simple for everybody. And I can?t imagine something
easier than a mapping table.

BR,
Nikolaus
