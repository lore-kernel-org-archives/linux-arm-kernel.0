From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Mar 2013 10:00:05 +0800
Subject: [PATCH v2 05/14] ARM: integrator: use clocksource_of_init for
 sp804
In-Reply-To: <201303121854.45864.arnd@arndb.de>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <1363108124-17484-6-git-send-email-haojian.zhuang@linaro.org>
 <201303121854.45864.arnd@arndb.de>
Message-ID: <CAD6h2NSKJqe7eDbLM-Jaxi4GHKPxV6boUVSZmCRjp_gvie7OZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2013 02:54, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 12 March 2013, Haojian Zhuang wrote:
>>
>> -       aliases {
>> -               arm,timer-primary = &timer2;
>> -               arm,timer-secondary = &timer1;
>> -       };
>> -
>>         chosen {
>>                 bootargs = "root=/dev/ram0 console=ttyAMA0,38400n8 earlyprintk";
>>         };
>> @@ -29,10 +24,14 @@
>>
>>         timer1: timer at 13000100 {
>>                 compatible = "arm,sp804", "arm,primecell";
>> +               arm,sp804-clockevent = <0>;
>> +               status = "ok";
>>         };
>
> I would prefer to keep the old way of doing this. The "aliases" node is
> meant for configuration, while the timer device itself should not care
> whether it is used as a clockevent or clocksource or some other device.
>
> We could probably change the identifiers in the aliases to
> "linux,clocksource" and "linux,clockevents" instead of
> "arm,timer-primary" and "arm,timer-secondary".
>
>         Arnd

SP804 is a dual timer. Either TIMER1 or TIMER2 in the same SP804
could be configured as clock source. And either TIMER1 or TIMER2 in
the same SP804 could be configured as clock event.


Integratorap/cp is always using TIMER1 of SP804-A as clocksource,
and TIMER1 of SP804-B as clockevent. This usage case always
drop TIMER2 usage.

I tried to add arm,sp804-clocksource to specify whether TIMER1 or
TIMER2 is configured as clocksource. For example, realview is using
TIMER2 of SP804-B as clockevent and TIMER1 of SP804-A as
clocksource.

If we decide to support the property like "arm,sp804-clocksource",
we could get the TIMER offset & clock source information at the same
time. Then alias configuration is duplicated.

If we decide to support alais configuration like "linux,clocksource",
we could get clock source/event information. But we don't know which
TIMER is used in the same SP804. We still need one property to
identify it. And people are also using both TIMERs in the same SP804,
like vexpress v2m.

Which method do we choose?

Regards
Haojian
