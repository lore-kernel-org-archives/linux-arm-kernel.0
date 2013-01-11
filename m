From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 12 Jan 2013 00:04:40 +0530
Subject: [PATCH 03/16] ARM: b.L: introduce helpers for platform coherency
 exit/setup
In-Reply-To: <20130111180757.GI1966@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-4-git-send-email-nicolas.pitre@linaro.org>
 <50F04FEA.1040205@ti.com> <20130111180757.GI1966@linaro.org>
Message-ID: <50F05B40.40302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 January 2013 11:37 PM, Dave Martin wrote:
> On Fri, Jan 11, 2013 at 11:16:18PM +0530, Santosh Shilimkar wrote:
>
> [...]
>
>>> +Originally created and documented by Dave Martin for Linaro Limited, in
>>> +collaboration with Nicolas Pitre and Achin Gupta.
>>> +
>> Great write-up Dave!! I might have to do couple of more passes on it to
>> get overall idea, but surely this documentation is good start for
>> anybody reading/reviewing the big.LITTLE switcher code.
>
> Thanks for reading through it.  Partly, this was insurance against me
> forgetting how the code worked in between writing and posting it...
> but this is all quite subtle code, so it felt important to document
> it thoroughly.
>
>>
>>> +Copyright (C) 2012  Linaro Limited
>>> +Distributed under the terms of Version 2 of the GNU General Public
>>> +License, as defined in linux/COPYING.
>>> diff --git a/arch/arm/common/bL_entry.c b/arch/arm/common/bL_entry.c
>>> index 41de0622de..1ea4ec9df0 100644
>>> --- a/arch/arm/common/bL_entry.c
>>> +++ b/arch/arm/common/bL_entry.c
>>> @@ -116,3 +116,163 @@ int bL_cpu_powered_up(void)
>>>   		platform_ops->powered_up();
>>>   	return 0;
>>>   }
>>> +
>>> +struct bL_sync_struct bL_sync;
>>> +
>>> +static void __sync_range(volatile void *p, size_t size)
>>> +{
>>> +	char *_p = (char *)p;
>>> +
>>> +	__cpuc_flush_dcache_area(_p, size);
>>> +	outer_flush_range(__pa(_p), __pa(_p + size));
>>> +	outer_sync();
>>> +}
>>> +
>>> +#define sync_mem(ptr) __sync_range(ptr, sizeof *(ptr))
>>> +
>>> +/*
>> /** as per kerneldoc.
>
> Does kerneldoc not require the comment to be specially formatted?
>
> I haven't played with that, so far.
>
>>
>>> + * __bL_cpu_going_down: Indicates that the cpu is being torn down.
>>> + *    This must be called at the point of committing to teardown of a CPU.
>>> + *    The CPU cache (SCTRL.C bit) is expected to still be active.
>>> + */
>>> +void __bL_cpu_going_down(unsigned int cpu, unsigned int cluster)
>>> +{
>>> +	bL_sync.clusters[cluster].cpus[cpu].cpu = CPU_GOING_DOWN;
>>> +	sync_mem(&bL_sync.clusters[cluster].cpus[cpu].cpu);
>>> +}
>>> +
>>
>> [..]
>>
>>> diff --git a/arch/arm/common/bL_head.S b/arch/arm/common/bL_head.S
>>> index 9d351f2b4c..f7a64ac127 100644
>>> --- a/arch/arm/common/bL_head.S
>>> +++ b/arch/arm/common/bL_head.S
>>> @@ -7,11 +7,19 @@
>>>    * This program is free software; you can redistribute it and/or modify
>>>    * it under the terms of the GNU General Public License version 2 as
>>>    * published by the Free Software Foundation.
>>> + *
>>> + *
>>> + * Refer to Documentation/arm/big.LITTLE/cluster-pm-race-avoidance.txt
>>> + * for details of the synchronisation algorithms used here.
>>>    */
>>>
>>>   #include <linux/linkage.h>
>>>   #include <asm/bL_entry.h>
>>>
>>> +.if BL_SYNC_CLUSTER_CPUS
>>> +.error "cpus must be the first member of struct bL_cluster_sync_struct"
>>> +.endif
>>> +
>>>   	.macro	pr_dbg	cpu, string
>>>   #if defined(CONFIG_DEBUG_LL) && defined(DEBUG)
>>>   	b	1901f
>>> @@ -52,12 +60,82 @@ ENTRY(bL_entry_point)
>>>   2:	pr_dbg	r4, "kernel bL_entry_point\n"
>>>
>>>   	/*
>>> -	 * MMU is off so we need to get to bL_entry_vectors in a
>>> +	 * MMU is off so we need to get to various variables in a
>>>   	 * position independent way.
>>>   	 */
>>>   	adr	r5, 3f
>>> -	ldr	r6, [r5]
>>> +	ldmia	r5, {r6, r7, r8}
>>>   	add	r6, r5, r6			@ r6 = bL_entry_vectors
>>> +	ldr	r7, [r5, r7]			@ r7 = bL_power_up_setup_phys
>>> +	add	r8, r5, r8			@ r8 = bL_sync
>>> +
>>> +	mov	r0, #BL_SYNC_CLUSTER_SIZE
>>> +	mla	r8, r0, r10, r8			@ r8 = bL_sync cluster base
>>> +
>>> +	@ Signal that this CPU is coming UP:
>>> +	mov	r0, #CPU_COMING_UP
>>> +	mov	r5, #BL_SYNC_CPU_SIZE
>>> +	mla	r5, r9, r5, r8			@ r5 = bL_sync cpu address
>>> +	strb	r0, [r5]
>>> +
>>> +	dsb
>> Do you really need above dsb(). With MMU off, the the store should
>
> The short answer is "maybe not".  Some of the barriers can be
> eliminated; some can be demoted to DSBs.  Others may be required but
> unnecessarily duplicated e.g., between bL_head.S and vlock.S.
>
>> any way make it to the main memory, No ?
>
> Yes, but this raises issues about precisely what the architecture
> guarantees about memory ordering in these scenarios.  The only obvious
> thing about that is that it's non-obvious.
>
Well at least ARM documents clearly says the memory accesses will be
treated as strongly ordered with MMU OFF and that means they expect
to make it to main memory.

> Strongly-Ordered memory is not quite the same as having explicit
> barriers everywhere.
>
> I need to have a careful think, but it should be possible to optimise
> a bit here.
>
If the CCI comes in between that rule and if it needs a barrier to let
it flush is WB to main memory then thats a different story.

Anyway thanks for the answer.
Regards
Santosh
