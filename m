From: robherring2@gmail.com (Rob Herring)
Date: Thu, 06 Sep 2012 08:20:30 -0500
Subject: [PATCH 4/6 v2] ARM: integrator: initial device tree support
In-Reply-To: <CACRpkdbTRCUnx1JjCQ+WT4PoxtDG38MP=ctUp6TBPd64xQ39jw@mail.gmail.com>
References: <1346471760-23993-1-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-2-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-3-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-4-git-send-email-linus.walleij@linaro.org>
 <5043E4BE.1060508@gmail.com>
 <CACRpkdbTRCUnx1JjCQ+WT4PoxtDG38MP=ctUp6TBPd64xQ39jw@mail.gmail.com>
Message-ID: <5048A31E.2090704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/2012 04:51 PM, Linus Walleij wrote:
> On Mon, Sep 3, 2012 at 12:59 AM, Rob Herring <robherring2@gmail.com> wrote:
>> On 08/31/2012 10:55 PM, Linus Walleij wrote:
> 
>>> +/ {
>>> +     model = "ARM Integrator/CP";
>>> +     compatible = "arm,integrator-cp";
>>> +     ranges;
>>> +
>>> +     aliases {
>>> +             arm,integrator-clocksource = &timer2;
>>> +             arm,integrator-clockevent = &timer1;
>>
>> This is linux specific and a common issue we need a solution for. Grant
>> had done something for versatile and we discussed it some, but nothing
>> ever got close to finalized. IIRC, Grant's solution was just add a
>> "linux,clockevent" or "linux,clocksource" to the nodes that are to be
>> used. But he wasn't really happy with it. Perhaps using these names as
>> aliases would be better.
> 
> Atleast I'm honest about what this is, IMHO this is better than
> any of the solutions we already have in boot/dts.
> 
> Look at the versatile express
> arch/arm/boot/dts/vexpress-v2m.dtsi:
> 
>         aliases {
>                 arm,v2m_timer = &v2m_timer01;
>         };
> 
> It's quite hard to tell that this "vtm_timer" is actually the block
> serving as clock source and clockevent for the Vexpress,
> but if you inspect the code you can see that this is what it is.

Yeah, we really need to unify all this.

> I can of course skip the aliases and go for the timer nodes
> I want directly, but that isn't any helpful for people reading the
> device tree, is it?

Well, the dts doesn't really need to describe how Linux is using things.
I'd like to get to common DT code for sp804 so all platforms just have a
call to sp804_dt_init() which does all the initialization.

> 
> Maybe primary-timer, secondary-timer is sufficiently
> good and neutral aliases?

That doesn't distinguish clk-event vs. clk-source. Perhaps we can use
presence of interrupt to distinguish that. It shouldn't really matter
which timer Linux picks as long as the h/w has the necessary features.
We just need to make sure dts describes those features. Some of the
things we have to deal with:

Highbank has interrupt for timer0, but not on timer1, so timer0 must be
clk-event. It also users timer1 for sched clock, but ARM Ltd platforms
use a different timer.

Realview and Versatile use timer0 for clk-event and timer3 for clk-src.
Is there something broken with timer1 and timer2? It is certainly
possible the h/w has the clock tied off for 1 of the 2 timers.

VExpress CA9 has broken timers on the core tile (at least they were
ifdef'ed out before the last clean-up). We could just remove/disable
them in the dts so they are not used.

Rob
