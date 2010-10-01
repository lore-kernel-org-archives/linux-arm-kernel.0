From: ccross@google.com (Colin Cross)
Date: Thu, 30 Sep 2010 20:27:21 -0700
Subject: [PATCH 3/3] ARM: twd_smp: add clock api support
In-Reply-To: <4CA551FF.3080100@gmail.com>
References: <1285886952-30888-1-git-send-email-robherring2@gmail.com>
	<1285886952-30888-3-git-send-email-robherring2@gmail.com>
	<AANLkTi=L69BXQZfT3VAeLgyBBHA2O8ELeLdqL1Onk3t=@mail.gmail.com>
	<4CA5417B.5020200@gmail.com>
	<AANLkTik=JXaDKbx97avUKerDQeK-O9gRuyfAZPHDQ2Yp@mail.gmail.com>
	<4CA551FF.3080100@gmail.com>
Message-ID: <AANLkTim3wYDNySWxba3-xWkj495GTiGxWN9L08Rnaa9C@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 30, 2010 at 8:14 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 09/30/2010 09:30 PM, Colin Cross wrote:
>>
>> On Thu, Sep 30, 2010 at 7:03 PM, Rob Herring<robherring2@gmail.com>
>> ?wrote:
>>>
>>> On 09/30/2010 07:49 PM, Colin Cross wrote:
>>>>
>>>> On Thu, Sep 30, 2010 at 3:49 PM, Rob Herring<robherring2@gmail.com>
>>>> ?wrote:
>>>>>
>>>>> From: Rob Herring<rob.herring@smooth-stone.com>
>>>>>
>>>>> The private timer freq is currently dynamically detected
>>>>> using jiffies count to determine the rate. This method adds
>>>>> a delay to boot-up, so use the clock api instead to get the
>>>>> clock rate.
>>>>>
>>>>> Signed-off-by: Rob Herring<rob.herring@smooth-stone.com>
>>>>> ---
>>>>> ?arch/arm/include/asm/smp_twd.h | ? ?2 ++
>>>>> ?arch/arm/kernel/smp_twd.c ? ? ?| ? ?7 +++++++
>>>>> ?2 files changed, 9 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/include/asm/smp_twd.h
>>>>> b/arch/arm/include/asm/smp_twd.h
>>>>> index 634f357..bafad52 100644
>>>>> --- a/arch/arm/include/asm/smp_twd.h
>>>>> +++ b/arch/arm/include/asm/smp_twd.h
>>>>> @@ -19,11 +19,13 @@
>>>>> ?#define TWD_TIMER_CONTROL_IT_ENABLE ? ?(1<< ? ?2)
>>>>>
>>>>> ?struct clock_event_device;
>>>>> +struct clk;
>>>>>
>>>>> ?extern void __iomem *twd_base;
>>>>>
>>>>> ?void twd_timer_stop(void);
>>>>> ?int twd_timer_ack(void);
>>>>> ?void twd_timer_setup(struct clock_event_device *);
>>>>> +void twd_timer_init(void __iomem *base, struct clk *clk);
>>>>>
>>>>> ?#endif
>>>>> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
>>>>> index 35882fb..1a3c959 100644
>>>>> --- a/arch/arm/kernel/smp_twd.c
>>>>> +++ b/arch/arm/kernel/smp_twd.c
>>>>> @@ -17,6 +17,7 @@
>>>>> ?#include<linux/clockchips.h>
>>>>> ?#include<linux/irq.h>
>>>>> ?#include<linux/io.h>
>>>>> +#include<linux/clk.h>
>>>>>
>>>>> ?#include<asm/smp_twd.h>
>>>>> ?#include<asm/hardware/gic.h>
>>>>> @@ -151,6 +152,12 @@ void __cpuinit twd_timer_setup(struct
>>>>> clock_event_device *clk)
>>>>> ? ? ? ?clockevents_register_device(clk);
>>>>> ?}
>>>>>
>>>>> +void __init twd_timer_init(void __iomem *base, struct clk *clk)
>>>>> +{
>>>>> + ? ? ? twd_base = base;
>>>>> + ? ? ? twd_timer_rate = clk_get_rate(clk);
>>>>> +}
>>>>> +
>>>>> ?#ifdef CONFIG_HOTPLUG_CPU
>>>>> ?/*
>>>>> ?* take a local timer down
>>>>
>>>> The local timers run off the PERIPHCLK in the CPU, which is specified
>>>> as the CPU clock divided by an implementation defined integer>= 2.
>>>> If you take the divider value as a parameter to twd_timer_init, the
>>>> clock that is passed in can be the cpu's clock.
>>>
>>> That is an implementation detail of the A9. Future designs could be
>>> completely asynchronous. Using the clock api works either way.
>>
>> True. ?That could still be handled by passing a divider of 1. ?For all
>> current implementations, this api will be used with clock that is a
>> constant divider of an existing clock. ?Taking a divider value would
>> avoid having to create a new clock that may not be similar to any
>> other clock in the device.
>
> If I pass in a divider, what clock rate do I divide with it? If I only have
> the divider, then I'm dependent on knowing CLK freq (the cpu freq in A9
> case). Ultimately I have to know the timer clock rate to setup a clock_event
> device. I'm open to passing in the clock rate directly, but having the clk
> ptr is more flexible. Other examples of timer init like i.MX use the same
> arguments.
>
> The point of this api is to avoid spending 5 jiffies on the primary cpu to
> calculate the rate. That is a significant chunk of the kernel boot time.
> Calling this function is entirely optional and the old way still works.

I like the idea of passing in the clk pointer - it would simplify
problems I've been having with rescaling the localtimer when the cpu
frequency changes.  However, it would reduce the amount of
machine-specific code necessary if I could pass in the
already-existing clock (cpu clock, for A9), as well as the value of
the divider that is present inside cpu (4 for Tegra2).
