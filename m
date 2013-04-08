From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 08 Apr 2013 11:18:46 -0700
Subject: [RFC][PATCH] arm: highmem: Add support for flushing kmap_atomic
 mappings
In-Reply-To: <alpine.LFD.2.03.1304061006530.1171@syhkavp.arg>
References: <1365198171-8469-1-git-send-email-lauraa@codeaurora.org>
 <alpine.LFD.2.03.1304061006530.1171@syhkavp.arg>
Message-ID: <51630A06.90702@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/6/2013 7:22 AM, Nicolas Pitre wrote:
> On Fri, 5 Apr 2013, Laura Abbott wrote:
>
>> The highmem code provides kmap_flush_unused to ensure all kmap
>> mappings are really removed if they are used. This code does not
>
> You meant "if they are *not* used", right?
>

Yes, missed a word there

>> handle kmap_atomic mappings since they are managed separately.
>> This prevents an issue for any code which relies on having absolutely
>> no mappings for a particular page. Rather than pay the penalty of
>> having CONFIG_DEBUG_HIGHMEM on all the time, add functionality
>> to remove the kmap_atomic mappings in a similar way to kmap_flush_unused.
>
> Could you elaborate on that code that relies on having absolutely no
> mappings for a particular page please?
>

We have a use case where we pass memory to trustzone to have it 
protected such that the non-secure environment may not read or write 
that memory. The protecting/unprotecting can happen at runtime. If there 
are any valid mappings in the page tables, the CPU is free to 
speculatively access that memory. If the CPU speculates into a protected 
region while in the non-secure world, we get a fault violation. 
Essentially this means that even if we reserve the memory at bootup time 
with memblock_reserve, if  the memory was ever previously mapped with 
kmap_atomic (to flush caches for example) we could still end up with 
stray mappings which can lead to faults.

In general, it seems like this is missing functionality from the 
intended behavior of kmap_flush_unused which is to get rid of all stray 
mappings.


>> This is intended to be an RFC to make sure this approach is
>> reasonable. The goal is to have kmap_atomic_flush_unused be a public
>> API.
>
> The clearing code is going to be costly since you do a
> set_top_pte(vaddr, __pte(0)) unconditionally on the whole range,
> regardless if the PTE is already set to 0.
>

Good point. I'll add a check for that.

> Using it via an hotplug callback is rather strange, but I'm assuming
> that this was only for testing?
>

The hotplug callback is needed because we clear the mappings per-CPU. If 
a CPU is hotplugged out with stray mappings they will not be cleared 
since on_each_cpu only works on online CPUs.

>
> Nicolas
>

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
