From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 15 Nov 2013 11:48:05 +0000
Subject: [PATCH 3/6] ARM: mm: Drop the lowmem watermark check from
 virt_addr_valid()
In-Reply-To: <20131115004034.GG20516@lvm>
References: <y> <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
 <1384457866-16135-4-git-send-email-santosh.shilimkar@ti.com>
 <20131115002232.GE20516@lvm> <52856B68.4040502@ti.com>
 <20131115004034.GG20516@lvm>
Message-ID: <528609F5.1020802@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/11/13 00:40, Christoffer Dall wrote:
> On Thu, Nov 14, 2013 at 07:31:36PM -0500, Santosh Shilimkar wrote:
>> On Thursday 14 November 2013 07:22 PM, Christoffer Dall wrote:
>>> On Thu, Nov 14, 2013 at 02:37:43PM -0500, Santosh Shilimkar wrote:
>>>> Slab allocator can allocate memory beyond the lowmem watermark
>>>> which can lead to false failure of virt_addr_valid().
>>>>
>>>> So drop the check. The issue was seen with percpu_alloc()
>>>> in KVM code which was allocating memory beyond lowmem watermark.
>>>>
>>>> Am not completly sure whether this is the right fix and if it could
>>>> impact any other user of virt_addr_valid(). Without this fix as
>>>> pointed out the KVM init was failing in my testing.
>>>>
>>>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>> Cc: Russell King <linux@arm.linux.org.uk>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>
>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> ---
>>>>  arch/arm/include/asm/memory.h |    3 +--
>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
>>>> index 4dd2145..412da47 100644
>>>> --- a/arch/arm/include/asm/memory.h
>>>> +++ b/arch/arm/include/asm/memory.h
>>>> @@ -343,8 +343,7 @@ static inline __deprecated void *bus_to_virt(unsigned long x)
>>>>  #define ARCH_PFN_OFFSET		PHYS_PFN_OFFSET
>>>>  
>>>>  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
>>>> -#define virt_addr_valid(kaddr)	((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory)
>>>> -
>>>> +#define virt_addr_valid(kaddr)	((unsigned long)(kaddr) >= PAGE_OFFSET)
>>>>  #endif
>>>>  
>>>>  #include <asm-generic/memory_model.h>
>>>> -- 
>>>> 1.7.9.5
>>>>
>>>
>>> This looks wrong to me.  Check Documentation/arm/memory.txt, this would
>>> return true for the VMALLOC region, which would cause virt_to_phys to
>>> give you something invalid, which would be bad.
>>>
>> I also thought it might not be right fix and hence added a disclaimer
>> in the commit message ;-)
>>  
> Yes I know, I'm not holding it against you ;)
> 
> Not sure what the nicest fix is though.  I think we can get away with
> the single page restriction per call for Hyp mappings for now.  IIRC the
> Hyp code is still limited to be within a single page.
> 
> Let's see what Marc has to say.

So that may change quite quickly. I already have additional code for
GICv3 in HYP, and I'd like to avoid putting restrictions that we'd have
a hard time removing later.

I'd like to try the approach I just sent out in a separate email first,
and if it can't be made to work, we can see how to either enforce a
single-page restriction or move the percpu stuff to kmalloc instead.

	M.
-- 
Jazz is not dead. It just smells funny...
