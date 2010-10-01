From: ccross@google.com (Colin Cross)
Date: Fri, 1 Oct 2010 11:22:31 -0700
Subject: [PATCH 3/3] ARM: twd_smp: add clock api support
In-Reply-To: <4CA614AA.8090305@gmail.com>
References: <1285886952-30888-1-git-send-email-robherring2@gmail.com>
	<1285886952-30888-3-git-send-email-robherring2@gmail.com>
	<AANLkTi=L69BXQZfT3VAeLgyBBHA2O8ELeLdqL1Onk3t=@mail.gmail.com>
	<4CA5417B.5020200@gmail.com>
	<AANLkTik=JXaDKbx97avUKerDQeK-O9gRuyfAZPHDQ2Yp@mail.gmail.com>
	<4CA551FF.3080100@gmail.com>
	<AANLkTim3wYDNySWxba3-xWkj495GTiGxWN9L08Rnaa9C@mail.gmail.com>
	<4CA614AA.8090305@gmail.com>
Message-ID: <AANLkTi=zwxKhhO7ERBvWfeHF7yO4beex5CYioPtiyWpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 1, 2010 at 10:04 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 09/30/2010 10:27 PM, Colin Cross wrote:
>>
>> On Thu, Sep 30, 2010 at 8:14 PM, Rob Herring<robherring2@gmail.com>
>> ?wrote:
>>>
>>> On 09/30/2010 09:30 PM, Colin Cross wrote:
>>>>
>>>> On Thu, Sep 30, 2010 at 7:03 PM, Rob Herring<robherring2@gmail.com>
>>>> ?wrote:
>>>>>
>>>>> On 09/30/2010 07:49 PM, Colin Cross wrote:

snip

>>>>>> The local timers run off the PERIPHCLK in the CPU, which is specified
>>>>>> as the CPU clock divided by an implementation defined integer>= 2.
>>>>>> If you take the divider value as a parameter to twd_timer_init, the
>>>>>> clock that is passed in can be the cpu's clock.
>>>>>
>>>>> That is an implementation detail of the A9. Future designs could be
>>>>> completely asynchronous. Using the clock api works either way.
>>>>
>>>> True. ?That could still be handled by passing a divider of 1. ?For all
>>>> current implementations, this api will be used with clock that is a
>>>> constant divider of an existing clock. ?Taking a divider value would
>>>> avoid having to create a new clock that may not be similar to any
>>>> other clock in the device.
>>>
>>> If I pass in a divider, what clock rate do I divide with it? If I only
>>> have
>>> the divider, then I'm dependent on knowing CLK freq (the cpu freq in A9
>>> case). Ultimately I have to know the timer clock rate to setup a
>>> clock_event
>>> device. I'm open to passing in the clock rate directly, but having the
>>> clk
>>> ptr is more flexible. Other examples of timer init like i.MX use the same
>>> arguments.
>>>
>>> The point of this api is to avoid spending 5 jiffies on the primary cpu
>>> to
>>> calculate the rate. That is a significant chunk of the kernel boot time.
>>> Calling this function is entirely optional and the old way still works.
>>
>> I like the idea of passing in the clk pointer - it would simplify
>> problems I've been having with rescaling the localtimer when the cpu
>> frequency changes. ?However, it would reduce the amount of
>> machine-specific code necessary if I could pass in the
>> already-existing clock (cpu clock, for A9), as well as the value of
>> the divider that is present inside cpu (4 for Tegra2).
>
> You are assuming all hardware would have a fixed divider. There is no
> requirement that the CLK:PERIPHCLK ratio is fixed. Well designed clock
> controller h/w would support CLK changing while maintaining PERIPHCLK rate
> or at least support changing the ratio.

The ARM specification for Cortex A9 requires a fixed CLK:PERIPHCLK
ratio, which AFAICT covers at least 5 out of the 6 current users of
the twd driver.

> You will need to get the clock rate every set_next_event and somehow sync
> cpu freq changes to when no timers are active on all cores. Or just accept
> the timer inaccuracy for 1 time. Good luck with that... ;)

The timer APIs require that a timer take at least as long as requested
to fire.  If you change the TWD prescaler before the CPU frequency
increases, or after the CPU frequency decreases, the timer interrupt
will not fire until a small time after the requested time.

> What is the problem of defining another clock in the platform? The watchdogs
> if implemented also need that clock.

It would be a convenient shortcut.  On Tegra, we don't use the A9
watchdog, because it gets powered down in idle.  Defining a new clock
is not a trivial task - on Tegra we have no fixed dividers like this,
so we would need a new clock type.  An extra argument, which can be
set to 1 if your local timer block has no divider, would save ~20 LoC
on each existing platform, but either way would work.
