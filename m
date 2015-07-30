From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 30 Jul 2015 10:38:45 +0100
Subject: [PATCH] irqchip: gic: Add a cpu map for each GIC instance
In-Reply-To: <55B9EEA7.4090903@nvidia.com>
References: <1438180984-18219-1-git-send-email-jonathanh@nvidia.com>
 <20150729183321.GP7557@n2100.arm.linux.org.uk> <55B92939.5040101@nvidia.com>
 <55B9DE44.1010102@arm.com> <55B9E145.9050202@nvidia.com>
 <55B9E89E.5050905@arm.com> <55B9EEA7.4090903@nvidia.com>
Message-ID: <55B9F0A5.8030309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/07/15 10:30, Jon Hunter wrote:
> 
> On 30/07/15 10:04, Marc Zyngier wrote:
>> On 30/07/15 09:33, Jon Hunter wrote:
>>>
>>> On 30/07/15 09:20, Marc Zyngier wrote:
>>>> On 29/07/15 20:27, Jon Hunter wrote:
>>>>>
>>>>> On 29/07/15 19:33, Russell King - ARM Linux wrote:
>>>>>> On Wed, Jul 29, 2015 at 03:43:04PM +0100, Jon Hunter wrote:
>>>>>>> The gic_init_bases() function initialises an array that stores the mapping
>>>>>>> between the GIC and CPUs. This array is a global array that is
>>>>>>> unconditionally initialised on every call to gic_init_bases(). Although,
>>>>>>> it is not common for there to be more than one GIC instance, there are
>>>>>>> some devices that do support nested GIC controllers and gic_init_bases()
>>>>>>> can be called more than once.
>>>>>>>
>>>>>>> A 2nd call to gic_init_bases() will clear the previous CPU mapping and
>>>>>>> will only setup the mapping again for CPU0. This is because for child GIC
>>>>>>> controllers there is most likely only one recipient of the interrupt.
>>>>>>>
>>>>>>> Fix this by moving the CPU mapping array to the GIC chip data structure
>>>>>>> so that it is initialised for each GIC instance separately. It is assumed
>>>>>>> that the bL switcher code is only interested in the root or primary GIC
>>>>>>> instance.
>>>>>>
>>>>>> Does it make sense to expose the per-CPU-ness of the non-primary GIC?
>>>>>> If they are chained off a primary GIC SPI interrupt, then all IRQs on
>>>>>> the secondary GIC are routed to the same CPU that the SPI on the primary
>>>>>> GIC is routed to.
>>>>>
>>>>> I am looking at a use-case where there is a secondary GIC and the secondary
>>>>> GIC is used as a interrupt router between the main CPU cluster and another
>>>>> CPU. So in this case the mapping of a secondary is still of interest. This
>>>>> patch does not address setting up the secondary mapping, but avoids a
>>>>> secondary GIC overwriting the primary map (which we don't want).
>>>>>  
>>>>>> Other features like the PPIs and SGIs in the secondary CPU should also
>>>>>> be ignored - they probably aren't used anyway.
>>>>>
>>>>> Yes, agree.
>>>>>  
>>>>>> I have to say though... are the 1020 IRQs that the primary GIC provides
>>>>>> really not enough?  What insane hardware needs more than 1020 IRQs?
>>>>>
>>>>> Ha. I guess some realview boards for a start ...
>>>>>
>>>>> # grep -r "gic_init(1" arch/arm/
>>>>> arch/arm/mach-realview/realview_pb1176.c:	gic_init(1, IRQ_PB1176_GIC_START,
>>>>> arch/arm/mach-realview/realview_eb.c:		gic_init(1, 96, __io_address(REALVIEW_EB_GIC_DIST_BASE),
>>>>> arch/arm/mach-realview/realview_pb11mp.c:	gic_init(1, IRQ_PB11MP_GIC_START,
>>>>
>>>> Different use case. These are development boards with a relatively
>>>> modular design, where the SoC may or may not have a GIC by itself. When
>>>> it has one, you end up with the on-board GIC being a secondary one.
>>>
>>> Yes, I understand that the use-case may be different, but I highlighted
>>> this as a use where the primary map would be overwritten as the driver
>>> is today.
>>>
>>>> I never thought someone would quote these designs as an example to
>>>> follow... ;-)
>>>
>>> I can't say if this example was followed, but nevertheless hardware
>>> designers certainly do get creative ;-)
>>>
>>> So we need to ensure the primary cpu map does not get overwritten by a
>>> secondary and I have a case where the secondary map is of interest. So
>>> are ok with this?
>>
>> My point is that there is no secondary map. That map should only be
>> written for the primary GIC, because that's the only place it makes
>> sense. Your "other CPU" is not under the control of Linux (at least, not
>> as a CPU), so this map is not the right data structure.
> 
> Yes the "other CPU" may not run Linux, but it is certainly under the
> control of Linux as a slave CPU. Linux will decide whether it wants to
> receive the interrupts from this GIC or route them to the other CPU.
> 
> Yes, I see that this may not be technically a cpu map and may be that is
> a mis-use. Following that I assume that using set_affinity here would
> also not be correct and a custom API should be employed?

Indeed. set_affinity is only concerned with delivering interrupts to the
CPUs, and not to other entities. It looks like we need an different API,
but I would refrain from declaring it "custom". There is at least one
other example of a platform doing similar things (vybrid), and I'd like
to see some collaboration on that (Stefan on CC).

> If that is the case, then may be I should just fix up the irq-gic driver
> to only set the cpu map for the primary?

Yes please.

	M.
-- 
Jazz is not dead. It just smells funny...
