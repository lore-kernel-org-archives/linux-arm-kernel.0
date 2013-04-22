From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 22 Apr 2013 10:47:00 -0700
Subject: [RFC][PATCH] arm: highmem: Add support for flushing kmap_atomic
 mappings
In-Reply-To: <20130419164030.GY14496@n2100.arm.linux.org.uk>
References: <1365198171-8469-1-git-send-email-lauraa@codeaurora.org>
 <20130419164030.GY14496@n2100.arm.linux.org.uk>
Message-ID: <51757794.9040206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/19/2013 9:40 AM, Russell King - ARM Linux wrote:
> On Fri, Apr 05, 2013 at 02:42:51PM -0700, Laura Abbott wrote:
>> The highmem code provides kmap_flush_unused to ensure all kmap
>> mappings are really removed if they are used. This code does not
>> handle kmap_atomic mappings since they are managed separately.
>> This prevents an issue for any code which relies on having absolutely
>> no mappings for a particular page. Rather than pay the penalty of
>> having CONFIG_DEBUG_HIGHMEM on all the time, add functionality
>> to remove the kmap_atomic mappings in a similar way to kmap_flush_unused.
>
> I get the feeling that there's something behind this which is pushing
> for there only being no mappings for a particular page.  In a SMP
> environment that sounds like a dodgy assumption.  Maybe you could
> provide the background behind this patch?
>

Yes, I was asked this before and neglected to update the commit text.

We have a use case where we pass memory to trustzone to have it 
protected such that the non-secure environment may not read or write 
that memory. The protecting/unprotecting can happen at runtime. If there 
are any valid mappings in the page tables, the CPU is free to 
speculatively access that memory. If the CPU speculates into a protected 
region while in the non-secure world, we get a fault violation. 
Essentially this means that even if we reserve the memory at bootup time 
with memblock_reserve, if the memory was ever previously mapped with 
kmap_atomic (to flush caches for example) we could still end up with 
stray mappings which can lead to faults.

In general, it seems like this is missing functionality from the 
intended behavior of kmap_flush_unused which is to get rid of all stray 
mappings.



>> This is intended to be an RFC to make sure this approach is
>> reasonable. The goal is to have kmap_atomic_flush_unused be a public
>> API.
>
> That implies that there's some callers which need it, which aren't
> part of this patch - and a motivation for this outside of what we
> can see here.  That needs to be explained.  Plus, unused APIs in
> the mainline kernel don't tend ot stick around for long, so it really
> needs a use case to be demonstrated before it can be merged.
>
>>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>> ---
>>   arch/arm/mm/highmem.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 files changed, 51 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
>> index 21b9e1b..f4c0466 100644
>> --- a/arch/arm/mm/highmem.c
>> +++ b/arch/arm/mm/highmem.c
>> @@ -10,6 +10,7 @@
>>    * published by the Free Software Foundation.
>>    */
>>
>> +#include <linux/cpu.h>
>>   #include <linux/module.h>
>>   #include <linux/highmem.h>
>>   #include <linux/interrupt.h>
>> @@ -135,3 +136,53 @@ struct page *kmap_atomic_to_page(const void *ptr)
>>
>>   	return pte_page(get_top_pte(vaddr));
>>   }
>> +
>> +static void kmap_remove_unused_cpu(int cpu)
>> +{
>> +	int start_idx, idx, type;
>> +
>> +	pagefault_disable();
>> +	type = kmap_atomic_idx();
>> +	start_idx = type + 1 + KM_TYPE_NR * cpu;
>> +
>> +	for (idx = start_idx; idx < KM_TYPE_NR + KM_TYPE_NR * cpu; idx++) {
>> +		unsigned long vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
>> +		set_top_pte(vaddr, __pte(0));
>> +	}
>> +	pagefault_enable();
>
> Hmm.  Why are you using pagefault_disable() around this?  This code itself
> should not cause any page faults.  Maybe you mean to disable preemption,
> but that should already be disabled (if not the above is buggy.)  Maybe
> interrupts - that would make more sense, but as soon as interrupts are
> re-enabled, it's possible for drivers to start create kmap_atomic()
> mappings again.
>
> So... the question is... why this... for what use case?
>
> At the moment it just feels like it's rather buggy and racy.
>

Yes, I think the pagefault disabling is overkill and preemption 
disabling is what I was going for. It is indeed possible for drivers to 
start creating kmap_atomic mappings again but I consider that a buggy 
driver design; any driver who intends for all mappings to really be gone 
needs to do proper locking to prevent against cases of getting new mappings.


>> +static int hotplug_kmap_atomic_callback(struct notifier_block *nfb,
>> +                                unsigned long action, void *hcpu)
>> +{
>> +        switch (action & (~CPU_TASKS_FROZEN)) {
>
> Parens around ~CPU_TASKS_FROZEN is not required.
>
>> +        case CPU_DYING:
>> +		kmap_remove_unused_cpu((int)hcpu);
>> +                break;
>> +        default:
>> +                break;
>> +        }
>> +
>> +        return NOTIFY_OK;
>
> Please watch your indentation...
>
>> +}
>> +
>> +static struct notifier_block hotplug_kmap_atomic_notifier = {
>> +        .notifier_call = hotplug_kmap_atomic_callback,
>> +};
>> +
>> +static int __init init_kmap_atomic(void)
>> +{
>> +
>
> And this blank line isn't needed.
>

Yes, I missed the checkpatch cleanup.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
