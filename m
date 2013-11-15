From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 15 Nov 2013 15:08:13 +0000
Subject: [PATCH 3/6] ARM: mm: Drop the lowmem watermark check from
 virt_addr_valid()
In-Reply-To: <528635D4.4090605@ti.com>
References: <y> <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
 <1384457866-16135-4-git-send-email-santosh.shilimkar@ti.com>
 <20131115002232.GE20516@lvm> <528608E9.1060407@arm.com>
 <528635D4.4090605@ti.com>
Message-ID: <528638DD.3060300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/11/13 14:55, Santosh Shilimkar wrote:
> On Friday 15 November 2013 06:43 AM, Marc Zyngier wrote:
>> On 15/11/13 00:22, Christoffer Dall wrote:
>>>> On Thu, Nov 14, 2013 at 02:37:43PM -0500, Santosh Shilimkar wrote:
>>>>>> Slab allocator can allocate memory beyond the lowmem watermark
>>>>>> which can lead to false failure of virt_addr_valid().
>>>>>>
>>>>>> So drop the check. The issue was seen with percpu_alloc()
>>>>>> in KVM code which was allocating memory beyond lowmem watermark.
>>>>>>
>>>>>> Am not completly sure whether this is the right fix and if it could
>>>>>> impact any other user of virt_addr_valid(). Without this fix as
>>>>>> pointed out the KVM init was failing in my testing.
>>>>>>
>>>>>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>>>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>>>> Cc: Russell King <linux@arm.linux.org.uk>
>>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>>>
>>>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>>> ---
>>>>>>  arch/arm/include/asm/memory.h |    3 +--
>>>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
>>>>>> index 4dd2145..412da47 100644
>>>>>> --- a/arch/arm/include/asm/memory.h
>>>>>> +++ b/arch/arm/include/asm/memory.h
>>>>>> @@ -343,8 +343,7 @@ static inline __deprecated void *bus_to_virt(unsigned long x)
>>>>>>  #define ARCH_PFN_OFFSET		PHYS_PFN_OFFSET
>>>>>>  
>>>>>>  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
>>>>>> -#define virt_addr_valid(kaddr)	((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory)
>>>>>> -
>>>>>> +#define virt_addr_valid(kaddr)	((unsigned long)(kaddr) >= PAGE_OFFSET)
>>>>>>  #endif
>>>>>>  
>>>>>>  #include <asm-generic/memory_model.h>
>>>>>> -- 
>>>>>> 1.7.9.5
>>>>>>
>>>>
>>>> This looks wrong to me.  Check Documentation/arm/memory.txt, this would
>>>> return true for the VMALLOC region, which would cause virt_to_phys to
>>>> give you something invalid, which would be bad.
>>>>
>>>> We use the check in create_hyp_mappings to be sure that the physical
>>>> address returned by virt_to_phys is valid and that if we're mapping more
>>>> than one page that those pages are physically contiguous.
>>>>
>>>> So if you want to get rid of this check, you need to change the mapping
>>>> functionality to obtain the physical address by walking the page table
>>>> mappings for each page that you are mapping instead.  Or limit each call
>>>> to a single page in size and take the physical address as input and use
>>>> per_cpu_ptr_to_phys at the caller side instead.
>>>>
>>>> Alternatively, we need to get rid of alloc_percpu and use regular
>>>> kmallocs instead, unless anyone else knows of an even better way.
>> alloc_percpu has nice properties (cache locality, mostly).
>>
>> One way out of it would be to give percpu stuff a special treatment. Can
>> you try the attach patch as a first approximation? It needs more
>> refinements (allocations straddling two pages?), but I think that's the
>> right sort of things.
>>
>> Let me know how it works for you.
>>
> Host boots bug guest fails. Patch needs small update as mentioned
> with inline patch.
> 
>> From 01bc1c8eaebdd70b1ea044050144b9bfb3375f82 Mon Sep 17 00:00:00 2001
>> From: Marc Zyngier <marc.zyngier@arm.com>
>> Date: Fri, 15 Nov 2013 11:36:36 +0000
>> Subject: [PATCH] arm/arm64: KVM: introduce new mapping API for percpu mappings
>>
>> Using virt_to_phys on percpu mappings is horribly wrong (my own bad).
>> Thankfully, the kernel offers a way to obtain the phisical address
>> of such a mapping.
>>
>> Add a new "create_hyp_percpu_mappings" to deal with those.
>>
>> *Fully untested, don't merge*
>>
>> Not-Even-Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/include/asm/kvm_mmu.h   |  1 +
>>  arch/arm/kvm/arm.c               |  2 +-
>>  arch/arm/kvm/mmu.c               | 20 ++++++++++++++++++++
>>  arch/arm64/include/asm/kvm_mmu.h |  1 +
>>  4 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
>> index 9b28c41..6dcb9ff 100644
>> --- a/arch/arm/include/asm/kvm_mmu.h
>> +++ b/arch/arm/include/asm/kvm_mmu.h
>> @@ -43,6 +43,7 @@
>>  #include <asm/pgalloc.h>
>>  
>>  int create_hyp_mappings(void *from, void *to);
>> +int create_hyp_percpu_mappings(void *from, void *to);
>>  int create_hyp_io_mappings(void *from, void *to, phys_addr_t);
>>  void free_boot_hyp_pgd(void);
>>  void free_hyp_pgds(void);
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index 9c697db..6191960 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -911,7 +911,7 @@ static int init_hyp_mode(void)
>>  		kvm_cpu_context_t *cpu_ctxt;
>>  
>>  		cpu_ctxt = per_cpu_ptr(kvm_host_cpu_state, cpu);
>> -		err = create_hyp_mappings(cpu_ctxt, cpu_ctxt + 1);
>> +		err = create_hyp_percpu_mappings(cpu_ctxt, cpu_ctxt + 1);
>>  
>>  		if (err) {
>>  			kvm_err("Cannot map host CPU state: %d\n", err);
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index b0de86b..e509718 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -331,6 +331,26 @@ int create_hyp_mappings(void *from, void *to)
>>  }
>>  
>>  /**
>> + * create_hyp_percpu_mappings - duplicate a percpu kernel virtual address
>> + *				range in Hyp mode
>> + * @from:	The virtual kernel start address of the range
>> + * @to:		The virtual kernel end address of the range (exclusive)
>> + *
>> + * The same virtual address as the kernel virtual address is also used
>> + * in Hyp-mode mapping (modulo HYP_PAGE_OFFSET) to the same underlying
>> + * physical pages. It *has* to be a percpu pointer.
>> + */
>> +int create_hyp_percpu_mappings(void *from, void *to)
>> +{
>> +	unsigned long phys_addr = per_cpu_ptr_to_phys(from);
> phys_addr_t phys_addr = per_cpu_ptr_to_phys(from);

Yeah, of course... ;-)

> With this change things work as expected without $subject patch.
> Thanks for the patch.

Good. I'll respin another version with support for allocations
straddling multiple pages and post it ASAP.

Thanks for testing!

	M.
-- 
Jazz is not dead. It just smells funny...
