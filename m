From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 07 Nov 2014 10:37:01 +0100
Subject: [PATCHv0 3/3] rtc: rtc-isl12057: add alarm support to Intersil
 ISL12057 RTC driver
References: <cover.1415222752.git.arno@natisbad.org>
 <148403c0ab1d556cbb99d9242c65f714a77843e5.1415222752.git.arno@natisbad.org>
 <20141106055017.GL8509@sirena.org.uk> <87ppcznbyv.fsf@natisbad.org>
 <20141107075843.GD10432@pengutronix.de>
Message-ID: <878ujnnygy.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Thanks for your support.

Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> writes:

>> No strong feeling on that point. ISL12008 on which this driver is based
>> has a similar logic.
> Some time ago I already had the feeling that there is much "rank growth"
> in the rtc drivers. I guess this is because maintenance of the rtc
> subsystem isn't optimal and there are no guidelines (at least I'm not
> aware of any) about detail questions.

I had that feeling too when I pushed the ISL12057 driver.

>> > None of the alarm functionality checks to see if there's actually an IRQ
>> > - is that OK? I'd at least expect the alarm interrupt enable call to
>> > check if the interrupt is wired up.
>> 
>> I can add those check BUT I would like some directions in order to
>> support the following use case too.
>> 
>> Current three in-tree users of ISL12057 are NAS devices (Netgear
>> ReadyNAS 102, 104 and 2120). All of them *do not have* the interrupt pin
> I assume you don't have schematics of the devices, right? If so, do you
> think it might be worth to try to get them from Netgear? Just to make
> sure that there really is no pin connected to the SoC.

I'll ask but I am skeptical: I already tested all the MPP of the SoC so
unless I missed something, it's unlikely.


>> of the RTC chip connected to an interrupt line of the SoC. Nonetheless,
>> the IRQ line of the chip being connected to a PMIC on the board (TI
>> TPS65251 [1] on ReadyNAS 102 and 104, I do not know for ReadyNAS
> Looking over the manual it seems there is no way to let the PMIC forward
> the irq either.
>
>> 2120). When the device is off and the alarm rings, the device gets
>> powered on. AFAICT, the IRQ coming on the TPS65251 is not replicated on
>> any line of the SoC.
>> 
>> I think it's possible w/ some soldering to get somewhere where the RTC
>> framework wants me to be and finish the alarm part to have it merged
>> upstream but that's of limited interest if in-tree user cannot use it to
>> fit their need, i.e. configure an alarm value and enable the associated
>> interrupt which is routed externally, i.e. not visible by the SoC.
> Do you need to enable the irq somewhere else (apart from in the RTC
> device)? I guess not.

This is the problem: I just need to enable the interrupt in the ISL12057
(flag in regs) but w/o dealing with SoC/system interrupt, i.e. w/o having
a client->irq passed to the driver. In current RTC framework, alarm
support requires a client->irq and a working interrupt line w/ the SoC.


>> FWIW, we had a similar discussion a while ago, during driver inclusion:
>> 
>>   http://marc.info/?l=devicetree&m=138109313118504&w=2
>> 
>> Uwe, any idea?
> What is the problem of a not-wired-up irq line? Does the rtc framework
> need to change to allow setting an alarm without the irq line being
> hooked up?

yes. 


> Is it "only" that the alarm is missed?

In practice, yes. But RTC framework does not support that. Or maybe
there is some trick a maintainer would be aware of to support that
scenario. Something involving:

 - returning some specific value in alarm_irq_enable handler
 - calling device_init_wakeup(dev, true); w/o having an IRQ line
 - extend workaround started in c9f5c7e7a84f and 4a649903f91232
   and expose those via dt
 - ...

> Irq polling probably isn't sensible?
>
> I assume it's not that unusual that an rtc irq doesn't trigger a system
> irq, so having that supported nicely would be great.

Now, we're two to think that way ;-)


> Looking through the rtc's datasheet, the device is a tad more
> complicated than the current driver handles. There are two irq lines and
> three functions that can be routed through these (alarm1, alarm2 and
> clkout; not all combinations are possible).

Yes, but I wanted to handle the problem at hand before soldering IRQ#1
on my RN102 and add more feature.

a+
