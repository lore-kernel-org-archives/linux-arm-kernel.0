From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 9 Aug 2016 09:54:34 +0100
Subject: [PATCH 1/1] irqchip: irq-gic: forward SGI to itself for cortex-a7
 single core
In-Reply-To: <20160809071821.GD31105@shlinux2>
References: <20160808105026.GA12649@leverpostej>
 <HE1PR04MB1450C6BE844A31C95CEE3BE18B1B0@HE1PR04MB1450.eurprd04.prod.outlook.com>
 <20160808130754.GB12649@leverpostej> <20160808132847.GB17680@shlinux2>
 <20160808134842.GE12649@leverpostej> <20160808145916.0924e868@arm.com>
 <20160809034613.GB31105@shlinux2> <20160809063401.3117dc94@arm.com>
 <20160809055701.GC31105@shlinux2> <20160809075930.529f98ca@arm.com>
 <20160809071821.GD31105@shlinux2>
Message-ID: <57A99A4A.6010301@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/16 08:18, Peter Chen wrote:
> On Tue, Aug 09, 2016 at 07:59:30AM +0100, Marc Zyngier wrote:
>> On Tue, 9 Aug 2016 13:57:01 +0800
>> Peter Chen <hzpeterchen@gmail.com> wrote:
>>
>>> On Tue, Aug 09, 2016 at 06:34:01AM +0100, Marc Zyngier wrote:
>>>> On Tue, 9 Aug 2016 11:46:13 +0800
>>>> Peter Chen <hzpeterchen@gmail.com> wrote:
>>>>   
>>>>> On Mon, Aug 08, 2016 at 02:59:16PM +0100, Marc Zyngier wrote:  
>>>>>> On Mon, 8 Aug 2016 14:48:42 +0100
>>>>>> Mark Rutland <mark.rutland@arm.com> wrote:
>>>>>>     
>>>>>>> On Mon, Aug 08, 2016 at 09:28:47PM +0800, Peter Chen wrote:    
>>>>>>>> On Mon, Aug 08, 2016 at 02:07:54PM +0100, Mark Rutland wrote:      
>>>>>>>>> I see that for arm64 we have:
>>>>>>>>>
>>>>>>>>> static inline bool arch_irq_work_has_interrupt(void)
>>>>>>>>> {
>>>>>>>>> 	return !!__smp_cross_call;
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> Could we do similarly for ARM, and ony register gic_raise_softirq if
>>>>>>>>> we have non-zero SGI targets?
>>>>>>>>>
>>>>>>>>> If I've understood correctly, that would make things behave as they do
>>>>>>>>> for UP on you system.      
>>>>>>>
>>>>>>> [...]
>>>>>>>     
>>>>>>>>> If self-IPI is necessary, then this would be up to the GIC code to
>>>>>>>>> solve.
>>>>>>>>>
>>>>>>>>> For that case, it would be nicer if we could detect whether this was
>>>>>>>>> necessary based on the GIC registers alone. That way we handle the
>>>>>>>>> various ways this can be integrated, aren't totally relient on the DT,
>>>>>>>>> work in VMs, etc.      
>>>>>>>>
>>>>>>>> How we can detect IPI capabilities based on GIC register?      
>>>>>>>
>>>>>>> Check the mask associated with SGIs, as we do for gic_get_cpumask(). If
>>>>>>> this is zero, we have a non-multiprocessor GIC (or one that's otherwise
>>>>>>> broken), and can't do SGI in the usual way.
>>>>>>>
>>>>>>> However, it only makes sense to do this if self-IPI is truly a
>>>>>>> necessity. Given there are other interrupt controllers that can't do
>>>>>>> self-IPI, avoiding self-IPI in general would be a better strategy,
>>>>>>> avoiding churn in each and every driver...    
>>>>>>
>>>>>> Indeed. And I won't take such a patch until all other avenues have been
>>>>>> explored, including fixing core code if required...
>>>>>>     
>>>>>
>>>>> Ok, it seems both you and Mark agree with disable IPI for GIC who has only
>>>>> self-IPI capability (GICD_ITARGETSR0 to GICD_ITARGETSR7 are all
>>>>> zero), right?  
>>>>
>>>> Not necessarily. This can be seen a latency improvement, compared to
>>>> the timer method which should be the fallback.
>>>>   
>>>
>>> Why? Your below patch (I tried too) just fixes NULL pointer issue for
>>
>> And that's the first issue to solve.
>>
>>> without define smp_cross_call function. But imx6ul is a SMP platform
>>
>> It is *not* an SMP platform. It may have a SMP-capable core, but that's
>> about it.
>>
> 
> Well. That's what I thought at the beginning, but the kernel
> takes it is. At __fixup_smp (arch/arm/kernel/head.S), it only checks
> MPIDR, for MPcore, it is 0x80000000, it means it is Multiprocessing
> Extensions and Processor is part of a multiprocessor system.

If it is a multi-processor system, please show me the second core.
If you can't, this is a UP system, end of story. It may have the MP
extensions (there is no such thing as a non-MP A7), but that doesn't
make it an SMP system. Please don't confuse the two things.

> 
> From my point, single-core in multiprocessor system is different
> with uniprocessor system. The first one can execute SMP instruction, but
> can't for latter.
> 
>>> (all imx6/7 uses the same configuration with both CONFIG_SMP and
>>>  CONFIG_SMP_ON_UP are defined), it still defines smp_cross_call.
>>> We still need the changes at gic code.
>>
>> That's a different story. You could simply not register the cross-call
>> on your UP system, and it would just work.
>>
> 
> Again, it is taken as SMP by kernel, and run SMP instructions, the
> kernel does not do fixup symbol for it.

Again, you're confusing MP-capable with SMP. Yes, the kernel tends to 
confuse the two as well because it is not always easy to tell them 
apart (as you just found). That doesn't mean we can't do a better job 
separating the two concepts when we have the right level of information
(i.e. we know the topology of the system).

> 
>>> Besides, if the hardware has IPI capability, but we just disable it
>>> to align with UP platforms, is it reasonable?
>>
>> Again: having a self-IPI on UP is an optimization. Nothing more.
>>
>> Now, coming back to your original idea, I'm aiming towards something
>> like this:
>>
> 
> Your below patch can work (tested), but why not registering an self-IPI
> smp_cross_call function for single core, it can avoid judging in code
> for each IPI calls.

Because it is an unnecessary complication. If you can demonstrate that 
this single test is an overhead, then I'll consider making this a 
separate function. Also, we can  move the test out of the lock that protects
the CPU map as, by definition, there is nothing to protect, making it even
more lightweight than your own approach:

>From 23ba8b645d219e333a10224d74fb5d8d75d67de2 Mon Sep 17 00:00:00 2001
From: Marc Zyngier <marc.zyngier@arm.com>
Date: Tue, 9 Aug 2016 07:50:44 +0100
Subject: [PATCH] irqchip/gic: Allow self-SGIs for SMP on UP configurations

On systems where a single CPU is present, the GIC may not support
having SGIs delivered to a target list. In that case, we use the
self-SGI mechanism to allow the interrupt to be delivered locally.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index c2cab57..390fac5 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -769,6 +769,13 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	int cpu;
 	unsigned long flags, map = 0;
 
+	if (unlikely(nr_cpu_ids == 1)) {
+		/* Only one CPU? let's do a self-IPI... */
+		writel_relaxed(2 << 24 | irq,
+			       gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
+		return;
+	}
+
 	raw_spin_lock_irqsave(&irq_controller_lock, flags);
 
 	/* Convert our logical CPU mask into a physical one. */

Also, your patch seems to break the arm64 ACPI support by moving the SMP
setup to a DT-specific function (I don't see why this should be DT only
anyway).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
