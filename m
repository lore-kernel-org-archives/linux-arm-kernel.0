From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 22 Apr 2015 16:40:36 +0100
Subject: [RESEND PATCH 4.0-rc7 v20 3/6] irqchip: gic: Introduce plumbing
 for IPI FIQ
In-Reply-To: <20150422135729.2a0beb86@why.wild-wind.fr.eu.org>
References: <1427216014-5324-1-git-send-email-daniel.thompson@linaro.org>	<1428659511-9590-1-git-send-email-daniel.thompson@linaro.org>	<1428659511-9590-4-git-send-email-daniel.thompson@linaro.org>	<55365477.30404@arm.com>	<5536BB1D.6040908@linaro.org>	<20150422101521.606aa38f@arm.com>	<553797ED.8040504@linaro.org>
 <20150422135729.2a0beb86@why.wild-wind.fr.eu.org>
Message-ID: <5537C0F4.7030702@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/04/15 13:57, Marc Zyngier wrote:
> On Wed, 22 Apr 2015 13:45:33 +0100
> Daniel Thompson <daniel.thompson@linaro.org> wrote:
>
>> On 22/04/15 10:15, Marc Zyngier wrote:
>>> On Tue, 21 Apr 2015 22:03:25 +0100
>>> Daniel Thompson <daniel.thompson@linaro.org> wrote:
>>>
>>> Hi Daniel,
>>>
>>>> On 21/04/15 14:45, Marc Zyngier wrote:
>>>>> On 10/04/15 10:51, Daniel Thompson wrote:
>>>>>> Currently it is not possible to exploit FIQ for systems with a GIC, even if
>>>>>> the systems are otherwise capable of it. This patch makes it possible
>>>>>> for IPIs to be delivered using FIQ.
>>>>>>
>>>>>> To do so it modifies the register state so that normal interrupts are
>>>>>> placed in group 1 and specific IPIs are placed into group 0. It also
>>>>>> configures the controller to raise group 0 interrupts using the FIQ
>>>>>> signal. It provides a means for architecture code to define which IPIs
>>>>>> shall use FIQ and to acknowledge any IPIs that are raised.
>>>>>>
>>>>>> All GIC hardware except GICv1-without-TrustZone support provides a means
>>>>>> to group exceptions into group 0 and group 1 but the hardware
>>>>>> functionality is unavailable to the kernel when a secure monitor is
>>>>>> present because access to the grouping registers are prohibited outside
>>>>>> "secure world". However when grouping is not available (or in the case
>>>>>> of early GICv1 implementations is very hard to configure) the code to
>>>>>> change groups does not deploy and all IPIs will be raised via IRQ.
>>>>>>
>>>>>> It has been tested and shown working on two systems capable of
>>>>>> supporting grouping (Freescale i.MX6 and STiH416). It has also been
>>>>>> tested for boot regressions on two systems that do not support grouping
>>>>>> (vexpress-a9 and Qualcomm Snapdragon 600).
>>>>>>
>>>>>> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
>>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>>> Cc: Jason Cooper <jason@lakedaemon.net>
>>>>>> Cc: Russell King <linux@arm.linux.org.uk>
>>>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>>>> Tested-by: Jon Medhurst <tixy@linaro.org>
>>>>>> ---
>>>>>>     arch/arm/kernel/traps.c         |   5 +-
>>>>>>     drivers/irqchip/irq-gic.c       | 151 +++++++++++++++++++++++++++++++++++++---
>>>>>>     include/linux/irqchip/arm-gic.h |   8 +++
>>>>>>     3 files changed, 153 insertions(+), 11 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
>>>>>> index 788e23fe64d8..b35e220ae1b1 100644
>>>>>> --- a/arch/arm/kernel/traps.c
>>>>>> +++ b/arch/arm/kernel/traps.c
>>>>>> @@ -26,6 +26,7 @@
>>>>>>     #include <linux/init.h>
>>>>>>     #include <linux/sched.h>
>>>>>>     #include <linux/irq.h>
>>>>>> +#include <linux/irqchip/arm-gic.h>
>>>>>>
>>>>>>     #include <linux/atomic.h>
>>>>>>     #include <asm/cacheflush.h>
>>>>>> @@ -479,7 +480,9 @@ asmlinkage void __exception_irq_entry handle_fiq_as_nmi(struct pt_regs *regs)
>>>>>>
>>>>>>            nmi_enter();
>>>>>>
>>>>>> -       /* nop. FIQ handlers for special arch/arm features can be added here. */
>>>>>> +#ifdef CONFIG_ARM_GIC
>>>>>> +       gic_handle_fiq_ipi();
>>>>>> +#endif
>>>>>
>>>>> This hunk is what irritates me. It creates a hard dependency between
>>>>> core ARM code and the GIC, and I don't really see how this works with
>>>>> multiplatform, where the interrupt controller is not necessarily a GIC.
>>>>> In that case, you will die a horrible death.
>>>>
>>>> I was just about to reassure you that there is no bug here... but then I
>>>> read the code.
>>>>
>>>> gic_handle_fiq_ipi() was *supposed* to do a check to make it safe to
>>>> call when there is no gic meaning multi-platform support could be
>>>> achieved by calling into multiple handlers.
>>>>
>>>> It looks like I forgot to write the code that would make this possible.
>>>> Maybe I was too disgusted with the approach to implement it correctly.
>>>> Looking at this with fresher eyes (I've been having a bit of a break
>>>> from FIQ recently) I can see how bad the current approach is.
>>>>
>>>>
>>>>> Why can't we just call handle_arch_irq(), and let the normal handler do
>>>>> its thing? You can have a "if (in_nmi())" in there, and call your FIQ
>>>>> function. It would at least save us the above problem.
>>>>
>>>> It should certainly work although it feels odd to reuse the IRQ handler
>>>> for FIQ.
>>>
>>> I can see three options:
>>>
>>> - (a) Either we have an interrupt controller specific, FIQ only entry
>>>     point, and we add calls in traps.c: this implies that each driver has
>>>     to defend itself against spurious calls.
>>>
>>> - (b) We add a separate handle_arch_fiq() indirection that only deals
>>>     with FIQ. Much better, but it also means that we have to keep this in
>>>     sync with arm64, for which the interest is relatively limited (FIQ
>>>     only works if you have a single security domain like XGene, or for a
>>>     VM).
>>>
>>> - (c) We call handle_arch_irq(), and let the interrupt controller code
>>>     sort the mess.
>>>
>>> I really hate (a) with a passion, because it litters both the ARM core
>>> code with IC specific code *and* introduce some defensive programming
>>> in the IC code, which is a waste...
>>>
>>> Option (b) is nicer, but requires additional work and buy-in from the
>>> arm64 maintainers, for a non obvious gain (I quite like the idea of
>>> injecting FIQs in a VM though, just for fun...).
>>>
>>> Option (c) is the simplest, if a little ugly on the side.
>>>
>>> Thoughts?
>>
>> For FIQs, do you anticipate handle_arch_irq() having a role like the
>> current gic_handle_fiq_ipi(), which is acknowledge an IPI and get out?
>> Alternatively it could behave more like its current role for IRQ and
>> call into the handlers itself.
>>
>> The later seems more likely to work out well when I take another look at
>> hooking up the perf interrupt.
>
> Assuming your mention of handle_arch_irq() is actually
> handle_arch_fiq(), I'd expect some interesting problems if you try to
> handle a Linux interrupt while already handling one, as the core IRQ
> code is not designed to be reentrant... Your code works so far because
> you have been careful to keep the IRQ code at bay. Putting it back into
> the equation is going to be hairy at best.

I was actually thinking of option (c) but the question would apply in 
both cases.

To be clear, I agree we cannot call into big piles of irq code from an 
NMI. We'd have to introduce new NMI-only ways to dispatch FIQs from real 
hwirqs (SPIs and PPIs).

In fact, at present we can't even call into handle_IPI() at the moment 
(because it will call irq_enter) although we could try to modify things 
and make that possible.

These issues apply whether we have conditional code in handle_arch_irq() 
or if we introduce handle_arch_fiq().
