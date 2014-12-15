From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 15 Dec 2014 21:18:01 +0100
Subject: RFC: new dt property "can-wakeup-machine" [Was: [PATCHv0 1/5]
 rtc: rtc-isl12057: add alarm support to Intersil ISL12057 RTC driver]
In-Reply-To: <548F3842.1010605@kleine-koenig.org> ("Uwe
 \=\?utf-8\?Q\?Kleine-K\?\= \=\?utf-8\?Q\?\=C3\=B6nig\=22's\?\=
 message of "Mon, 15 Dec 2014 20:36:34 +0100")
References: <cover.1418519430.git.arno@natisbad.org>
 <c38e3f1a4254e0d8db409ad87ba824c3383d0998.1418519430.git.arno@natisbad.org>
 <548F3842.1010605@kleine-koenig.org>
Message-ID: <87vblczmyu.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Thanks for bearing w/ me,

Uwe Kleine-K?nig <uwe@kleine-koenig.org> writes:

> I adapted the subject line to make the critical element in this patch
> more obvious.

thanks.

> As I wouldn't be surprised to get some discussion about your approach it
> would be beneficial to split this patch into:
>
>  - add (traditional) alarm support to rtc-isl12057
>  - allow the driver to wakeup the machine without the irq being
>    reported to the CPU.
>
> The first patch should not be controversial and the patch to discuss
> gets smaller.

Will do that. But it would be good we end up w/ a solution for current
in-tree users of the driver, i.e. those w/ a need for the second
patch ;-)


> On 12/14/2014 02:42 AM, Arnaud Ebalard wrote:
>> +Example isl12057 node without IRQ#2 pin connected to the SoC but to a
>> +PMIC, allowing the device to be started based on configured alarm:
>> +
>> +	isl12057: isl12057 at 68 {
>> +		compatible = "isil,isl12057";
>> +		reg = <0x68>;
>> +		can-wakeup-machine;
>> +	};
> What if the IRC#1 pin wakes the machine?

I handled that in details in the documentation (w/ a typo I will fix, I
must confess). The answer is: if you put a "can-wakeup-machine" property
in your .dts for ISL12057, then it means IRQ#2 can wake up the machine
BUT is not hooked up to the SoC. And only that. Alarm2 is not supported
(it can generate an interrupt on IRQ#1 or IRQ#2) so the driver does not
deal w/ IRQ#1 at all.

That being said, one can still add support later for Alarm2 (via IRQ#1
or IRQ#2) and the "can-wakeup-machine" property you proposed will still
handle that w/o issue.

As a side note, on our ReadyNAS, we can easily test a support for alarm2
on IRQ#2 pin. But In the end, the main problem will still be core rtc
interface: how do you handle the existence of two alarms on a RTC chip
using current sysfs interface, for instance?


> And I wonder if there is a more sane approach for this setup that
> wouldn't need specialized driver support.
>
> Something like:
>
> 	isl12057: isl12057 at 68 {
> 		compatible = "isil,isl12057";
> 		reg = <0x68>;
> 		interrupt-parent = <&wakeupfoo>;
> 		interrupts = <???>
> 	};
>
> 	wakeupfoo: ... {
> 		/*
> 		 * This controller cannot report irqs to the cpu, but
> 		 * can wake it up.
> 		 */
> 		....
> 	}
>
> Hmm, the bad thing here is that this "interrupt controller" isn't
> suitable to support "normal" interrupts. But maybe it's good enough to
> get into a discussion for a better idea?!

I agree you had a good idea in the first place not to force the rtc as
wakeup source and make that configurable via the .dts based on specific
system setup. But I think we should keep the knob simple.

What you propose is probably more accurate w/ the existence of a PMIC
in the device but IMHO the main purpose of the property is to tell the
driver that IRQ#2 (associated w/ the alarm1 it supports) can wake the
machine up. It would be more complex than needed for the driver to try
and understand that in fact the controller and irq that are passed are
placebo and it should the declare the device as a wakeup source.

What about changing the property name from "can-wakeup-machine" to
"isil,irq2-can-wakeup-machine" instead? It makes it clear that it is
specific to that driver, and that it only works w/ IRQ#2.


>> diff --git a/drivers/rtc/rtc-isl12057.c b/drivers/rtc/rtc-isl12057.c
>> index 6e1fcfb5d7e6..98adc2c1bdb0 100644
>> --- a/drivers/rtc/rtc-isl12057.c
>> +++ b/drivers/rtc/rtc-isl12057.c
>> @@ -1,5 +1,5 @@
>>  /*
>> - * rtc-isl12057 - Driver for Intersil ISL12057 I2C Real Time Clock
>> + * rtc-isl12057 - Driver for Intersil ISL12057 I2C Real Time Clock / Alarm
> I wouldn't care here to add "Alarm" at various places. Actually having
> an alarm is a quite usual feature of an rtc. *shrug*

Will drop thoses changes.

Cheers,

a+
