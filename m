From: hns@goldelico.com (Dr. H. Nikolaus Schaller)
Date: Tue, 17 Mar 2015 12:14:11 +0100
Subject: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
In-Reply-To: <20150317103746.GB3759@amd>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
 <1423088075-10025-4-git-send-email-marek@goldelico.com>
 <20150316210532.GA11441@amd>
 <CAAfyv34vnRY=TAyx4+7s1SW7rVE7CFh9z+OOcCsbCx63y9aVog@mail.gmail.com>
 <20150317084730.GA9761@amd>
 <940EE988-03A4-4B1B-A168-959E367953A6@goldelico.com>
 <20150317103746.GB3759@amd>
Message-ID: <CDA0FF88-2D00-46E0-828E-DD6F4FF4ADAF@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

Am 17.03.2015 um 11:37 schrieb Pavel Machek <pavel@ucw.cz>:

> Hi!
> 
>>>>> to introduce coefficients for temperature and discharge rate?
>>>> What do you mean? Nothing like that is used in current driver why do
>>>> we need to add it?
>>> 
>>> Well, conversion between Li-ion's voltage and state of charge at 0
>>> current is well known:
>> 
>> We can?t measure at 0 current since the OMAP is driven from battery
>> and charger and may also draw some mA?
> 
> Yes, but you know how many mA you are taking just now. So if you knew
> the internal resistance, you could compute the voltage at 0
> current. (And it should also work during charging, as long as you know
> how much current is going in.)

As far as I understand the twl4030 charger and MADC it is not possible to
separate these values. It is only reporting the inflow from charger to
battery + system. So you don?t know how many mA are supplying the system
and how many mA are left over for charging.

You can only assume how much the system is drawing while running (something
between 50 and 600 mA but this depends on system activities, power state
of peripherald and e.g. backlight being switched on).

I think your basic assumption that we know any time how many mA the system
is taking is not given.

> 
>>>   def percent(m, v):
>>>   	u = 0.0387-(1.4523*(3.7835-v))
>>>       if u < 0:
>>>           return 0
>>>         return (0.1966+math.sqrt(u))*100
>>> 
>>> And there's not much to calibrate there, and it should become library
>>> helper function; there's no need to write it to every single dts.
>>> 
>>> The charge/discharge difference is due to internal battery resistance,
>>> and Ohm's law. (Then, you should not need different values for
>>> charging/discharging case.)
>> 
>> Yes, and that also depends on the board and battery type. So you always
>> need to specify some battery specific coefficient for that in the DT.
> 
> Yes, and that coefficient should be internal battery resistance ;-).

But where do you know this value from to write it into a DT file?
Usually you can?t measure it easily and for some batteries you don?t have
a data sheet.

Contrary, the calibration curves can easily be measured on the device
(assuming that the charge level decreases/increases linearly over time
between Full and Empty).

I tend to make software easy to use for the user (developer of a board support
package) of a driver, not theoretically correct or mathematically elegant.

> 
>> We simply did choose a table, because calculating the right coefficients
>> is more complex and getting the table values can easily be done from
>> running one full charge-discharge-charge cycle.
> 
> Well.. One set of coefficients would be kind of ok. But you are doing
> two, because it really depends on current, not charge/discharge. So
> why not do it right, for all currents??

Because the right solution for all these issues is to use a fuel gauge chip
(bq27xxx).

This driver is just for systems where the hardware designer did forget
(or did not want to spend money) for such a chip, but user space
expects some /sys/class/power_supply indication (e.g. Android/Replicant).

The missing optimal precision is something we can live with.

> 
>>> With your aproach, you'll get lower percentage when phone is under
>>> load vs. idle. Taking internal resistance into account would give you
>>> more precise readings. (Attached, old patch for zaurus shows the
>>> needed computation).
>> 
>> This is why we have a charging and a discharging table to compensate
>> for this effect.
> 
> Yes, but there's very different current during "idle" phone and during
> call (for example). So yes, you are compensating for different current
> during charge and discharge, but it is possible to do better.

I am not convinced that it can be really done better, considering the
limitations of the twl4030 circuits, and I doubt that it is worth the efforts
of doing it better.

> 
>>> I guess this should go into library somewhere, because many machines
>>> need similar code.
>> 
>> Is a library easier to maintain and handle than just a set of table
>> values?
> 
> I think so, yes, because otherwise you need a set of tables for each
> machine.

Yes, but what is the problem? We have different device trees for each
machine anyways. And as soon as they differ in battery characteristics
the coefficients for your calculation have to be defined for each machine.

So someone has to write in some DT values (difficult to understand
and derive coefficients or two simple mapping tables).

To me it looks as if you want to make it a 100% solution while I am happy
with the 80% solution, which already exists as a platform data driver and
just want to get it back into DT based boards.

So I would suggest that Mareks patches to make the platform data
driver DT compatible are applied first, and you are invited to submit a
technically better solution for testing on real hardware.

BR,
Nikolaus
