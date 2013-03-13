From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 13 Mar 2013 16:28:44 +0000
Subject: [PATCH v3 06/11] ARM: vexpress: use clocksource_of_init for sp804
In-Reply-To: <CAD6h2NTufx2rRwbwsgGHN42t7+_KL418++zk_C++EvFKU+ZwLg@mail.gmail.com>
References: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
 <1363151142-32162-7-git-send-email-haojian.zhuang@linaro.org>
 <1363173037.3100.22.camel@hornet>
 <CAD6h2NQWB3+1QepQjBE0BZiG44YAQRi7e-9+oZvVYpYV8QycDA@mail.gmail.com>
 <1363175175.3100.37.camel@hornet>
 <CAD6h2NSUyFvhoqMsYqT=rzFZ--MWv+0vHOCtAV9n-5YO+LNTMA@mail.gmail.com>
 <1363186087.3100.72.camel@hornet>
 <CAD6h2NRkS4qk+iqbWhaOpBHmjSYOB=YBbfNkn0X3jzNawzgNEA@mail.gmail.com>
 <1363187979.3100.93.camel@hornet>
 <CAD6h2NTufx2rRwbwsgGHN42t7+_KL418++zk_C++EvFKU+ZwLg@mail.gmail.com>
Message-ID: <1363192124.3100.120.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-13 at 15:59 +0000, Haojian Zhuang wrote:
> Maybe I didn't express my idea well. My point is that timer could be
> clock source
> /clock event. It could also just be a timer that user app or other device driver
> may want to use it directly. There're a lot of reason that user app or some
>  driver wants to use hardware timer. For example, the specific timer may
> keep running even system is in low power mode.

That's all fair enough. My point is in any case the *system* will take
care of setting this all up. Therefore it can manage the available
resources to avoid the conflict.

> Although there's so much hardware timers available, system must choose
> one for the usage of clock source / clock event / other hardware timer usage.

By all means. I'm just claiming that in normal situation it can choose
on its convenience. In other words - if there are no limitations in
hardware, it can pick any of them, being responsible for making the
right decision.

> >> >> Imagine that only TIMINT1 signal in sp804 is routed to interrupt controller.
> >> >> Could system still pick any one it wants?
> >> >
> >> Then we need another new property. I try to find using minim properties.
> >
> > No, we don't. See the discussion with Rob. He has an idea (using the
> > interrupt property only), I have another one (using already defined
> > interrupt-names property). I see you've just came with another one
> > (TIMINTC treated as TIMINT1), which is fine with me. Either way you've
> > got what you need to make the right decision.
> >
> After considered as second time, I think that we still need a property to meet
> alias usage. Excuse me expand it in this topic.
> 
> arm,sp804-has-irq = <offset>;
> The offset means TIMER register offset. If it's not zero, TIMER2 is using
> irq. And it could be configured as clock event. Otherwise, TIMER1 is clock
> event.
> We must make sure that only one of all sp804 timers is using this property.
> 
> alias:
> linux,clocksource = <&sp804-A>
> linux,clockevent = <&sp804-A>
> 
> Although both of them points to timerA, only TIMER1 or TIMER2 of sp804
> is using irq. So one is clock source, and the other is clock event.
> 
> alias:
> linux,clocksource = <&sp804-A>
> linux,clockevent = <&sp804-B>
> The issue comes since system don't know whether TIMER1 or TIMER2 could
> be configured as clock source.
> 
> We still need a new property to claim it. It seems that we can't drop
> "arm,sp804-clocksource", although everybody don't like it.
> 
> What's your opinion?

Let me repeat myself - I'm not saying that there must be no such thing
like the alias (or your property). I'm sure there will be a use case for
them.

What I am saying is that they should not be obligatory. Shortly speaking
- I don't want to have them in VE DTS files. For VE platform the driver
should pick one of the timers and use it as clocksource (I don't care
which one), another one as clockevent (again, it's up to you) and the
rest for whatever it wants. 

Could you please provide a solution for such a "generic" case, when
there are no aliases defined in the tree? I see no problem with checking
if the aliases exist and if they don't picking the first SP804 you can
get hold of. Just give me that and you won't hear me complaining
further :-)

> > Where do you do this? In the Device Tree? No. In the kernel command
> > line
> Yes, command line could also be filled in DTS.

Which is a very bad practice... There's a reason why "chosen" node is
named like this ;-)

Pawe?
