From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 6 Sep 2012 15:56:27 +0200
Subject: [PATCH 4/6 v2] ARM: integrator: initial device tree support
In-Reply-To: <5048A31E.2090704@gmail.com>
References: <1346471760-23993-1-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-2-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-3-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-4-git-send-email-linus.walleij@linaro.org>
 <5043E4BE.1060508@gmail.com>
 <CACRpkdbTRCUnx1JjCQ+WT4PoxtDG38MP=ctUp6TBPd64xQ39jw@mail.gmail.com>
 <5048A31E.2090704@gmail.com>
Message-ID: <CACRpkdYy2CZXXA+kkEaOTznaucxXEwiwSn-5ux0ByHjXrsm-2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 6, 2012 at 3:20 PM, Rob Herring <robherring2@gmail.com> wrote:
> [Me]
>> I can of course skip the aliases and go for the timer nodes
>> I want directly, but that isn't any helpful for people reading the
>> device tree, is it?
>
> Well, the dts doesn't really need to describe how Linux is using things.

The arm,integrator-clocksource and arm,integrator-clockevent
are renamed arm,timer-primary and arm,timer-secondary in the
last patch set.

Are you OK with this for now, going forward? I'd be happy to
take a round refactoring it for the next cycle as outlined
below.

> I'd like to get to common DT code for sp804 so all platforms just have a
> call to sp804_dt_init() which does all the initialization.

The Integrator/AP does not have the SP804 timer, it has a
precursor with similar, yet different register setup. The
driver is in the integrator_ab. core file.

(I could look into merging this SP804 ancestor into the SP804
driver with some flag or so, but that would be a different
TODO item.)

The Integrator/CP has the SP804 however.

>> Maybe primary-timer, secondary-timer is sufficiently
>> good and neutral aliases?
>
> That doesn't distinguish clk-event vs. clk-source. Perhaps we can use
> presence of interrupt to distinguish that.

They all have interrupts in the Integrator case so all timers
are equal. But I vaguely recall someone whisper bad things about
timer0.

> It shouldn't really matter
> which timer Linux picks as long as the h/w has the necessary features.

That is true, what I've been doing so far is just a 1-to-1 mapping
to current usage without much massaging of the abstract resource
concept.

> We just need to make sure dts describes those features. Some of the
> things we have to deal with:
>
> Highbank has interrupt for timer0, but not on timer1, so timer0 must be
> clk-event. It also users timer1 for sched clock, but ARM Ltd platforms
> use a different timer.

So I guess this SP804? They just didn't route the IRQ line
I guess... :-(

> Realview and Versatile use timer0 for clk-event and timer3 for clk-src.
> Is there something broken with timer1 and timer2? It is certainly
> possible the h/w has the clock tied off for 1 of the 2 timers.

Integrator use timer2 for clockevent and timer1 for clocksource,
and legends tell that timer0 should be avoided. But I guess
I could try to find out by experience, I fear that it could work
but be instable so that it appears to work but in reality does not...

> VExpress CA9 has broken timers on the core tile (at least they were
> ifdef'ed out before the last clean-up). We could just remove/disable
> them in the dts so they are not used.

There is something about the DT ambition here (or for that matter
the boardfile ambition). On the RealView PB1176 there is
a broken DMA engine, we just deleted it from the resource
list. Other people might want to have all available resources
listed but marked "broken" in the DT for completeness.

The latter has the upside of providing hints to the next
engineer who would otherwise come around and ask why
the hardware in the refman is not listed in the DT and start
to try to add it and find out it is broken. Knowing it's there
and it's broken is encoding real knowledge at the expense
of a few DT bytes.

(I'm fine with either.)

Yours,
Linus Walleij
