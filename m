From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 14 Oct 2011 13:41:29 +0100
Subject: [PATCH v4 0/4] genirq: handling GIC per-cpu interrupts
In-Reply-To: <20111013181415.GM21648@n2100.arm.linux.org.uk>
References: <1317661446-2876-1-git-send-email-marc.zyngier@arm.com>
	<20111013181415.GM21648@n2100.arm.linux.org.uk>
Message-ID: <4E982DF9.4090806@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/10/11 19:14, Russell King - ARM Linux wrote:
> On Mon, Oct 03, 2011 at 06:04:02PM +0100, Marc Zyngier wrote:
>> The current GIC per-cpu interrupts (aka PPIs) suffer from a number of
>> problems:
>>
>> - They use a completely separate scheme to handle the interrupts,
>>   mostly because the PPI concept doesn't really match the kernel view
>>   of an interrupt.
>> - PPIs can only be used by the timer code, unless we add more low-level
>>   assembly code.
>> - The local timer code can only be used by devices generating PPIs,
>>   and not SPIs.
>> - At least one platform (msm) has started implementing its own
>>   alternative scheme.
>> - Some low-level code gets duplicated, as usual...
>>
>> The proposed solution is to handle the PPIs using the same path as
>> SPIs. A new core API is added to deal with per-cpu interrupts in a
>> less awkward way. The local timer code is updated to reflect these
>> changes.
>>
>> The core API changes are based on an initial idea by Thomas Gleixner.
>>
>> Tested on ARM Versatile Express (Cortex A15), ARM RealView PB11MP,
>> OMAP4 (Panda) and Tegra (Harmony). Patch series against next-20110930.
>>
>> The two first patches can also be found in Thomas' tree:
>>
>> 	git://tesla.tglx.de/git/linux-2.6-tip irq/core
> 
> So, how do we deal with merging this without ending up with some
> problematical inter-tree dependencies?

My view on this is that the whole series should ideally be merged via
one tree only. I suspect that yours would be the best candidate, as
there is probably little chance of conflicts on the core code.

Otherwise, we'd have to do a two step merge, adding the ARM bits once
the core code has been merged.

> It looks like I'll see conflicts with:
> arch/arm/common/gic.c
> arch/arm/kernel/smp.c
> arch/arm/include/asm/localtimer.h
> 
> and possibly:
> arch/arm/include/asm/smp.h
> arch/arm/kernel/irq.c
> 
> as well.  I've not checked with patch 4, so there may be some more too.
> 
> Some of this is probably because of 7123/1 and 7124/1.

Do you have a branch you consider stable enough for me to rebase this
series on? I've already solved these conflicts against -next, so
rebasing it should be faily trivial.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
