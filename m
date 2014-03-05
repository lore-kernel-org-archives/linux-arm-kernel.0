From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 05 Mar 2014 12:03:58 -0800
Subject: [PATCH v2] ARM64: Kernel managed pages are only flushed
In-Reply-To: <06b7685849ef4682878556ea1ea8f9d6@BN1PR03MB266.namprd03.prod.outlook.com>
References: <1394018716-17075-1-git-send-email-Bharat.Bhushan@freescale.com>
 <20140305161255.GG29309@mudshark.cambridge.arm.com>
 <06b7685849ef4682878556ea1ea8f9d6@BN1PR03MB266.namprd03.prod.outlook.com>
Message-ID: <5317832E.9020809@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/5/2014 8:27 AM, Bharat.Bhushan at freescale.com wrote:
>
>
>> -----Original Message-----
>> From: Will Deacon [mailto:will.deacon at arm.com]
>> Sent: Wednesday, March 05, 2014 9:43 PM
>> To: Bhushan Bharat-R65777
>> Cc: Catalin Marinas; linux-arm-kernel at lists.infradead.org; Bhushan Bharat-R65777
>> Subject: Re: [PATCH v2] ARM64: Kernel managed pages are only flushed
>>
>> On Wed, Mar 05, 2014 at 11:25:16AM +0000, Bharat Bhushan wrote:
>>> Kernel can only access pages which maps to managed memory.
>>> So flush only valid kernel pages.
>>>
>>> I observed kernel crash direct assigning a device using VFIO and found
>>> that it was caused because of accessing invalid page
>>>
>>> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@freescale.com>
>>> ---
>>> v1->v2
>>>   Getting pfn usin pte_pfn() in pfn_valid.
>>>
>>>   arch/arm64/mm/flush.c |   13 ++++++++++++-
>>>   1 files changed, 12 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c index
>>> e4193e3..319826a 100644
>>> --- a/arch/arm64/mm/flush.c
>>> +++ b/arch/arm64/mm/flush.c
>>> @@ -72,7 +72,18 @@ void copy_to_user_page(struct vm_area_struct *vma,
>>> struct page *page,
>>>
>>>   void __sync_icache_dcache(pte_t pte, unsigned long addr)  {
>>> -	struct page *page = pte_page(pte);
>>> +	struct page *page;
>>> +
>>> +#ifdef CONFIG_HAVE_ARCH_PFN_VALID
>>> +	/*
>>> +	 * We can only access pages that the kernel maps
>>> +	 * as memory. Bail out for unmapped ones.
>>> +	 */
>>> +	if (!pfn_valid(pte_pfn(pte)))
>>> +		return;
>>> +
>>> +#endif
>>> +	page = pte_page(pte);
>>
>> How do you get into this function without a valid, userspace, executable pte?
>>
>> I suspect you've got changes elsewhere and are calling this function in a
>> context where it's not supposed to be called.
>
> Below I will describe the context in which this function is called:
>
> When we direct assign a bus device (we have a different freescale specific bus
 > device but we can take PCI device for discussion as this logic 
applies equally
 > for PCI device I think) to user space using VFIO. Then userspace needs to
 > mmap(PCI_BARx_offset: this PCI bar offset in not a kernel visible 
memory).
> Then VFIO-kernel mmap() ioctl code calls remap_pfn_range()  for mapping the
 >requested address. While remap_pfn_range() internally calls this function.
>

As someone who likes calling functions in context where they aren't 
supposed to be called, I took a look a this because I was curious.

I can confirm the same problem trying to mmap arbitrary io address space 
with remap_pfn_range. We should only be hitting this if the pte is 
marked as exec per set_pte_at. With my test case, even mmaping with only 
PROT_READ and PROT_WRITE was setting PROT_EXEC as well which was 
triggering the bug. This seems to be because READ_IMPLIES_EXEC 
personality was set which was derived from

#define elf_read_implies_exec(ex,stk)   (stk != EXSTACK_DISABLE_X)

and none of the binaries I'm generating seem to be setting the stack 
execute bit either way (all are EXECSTACK_DEFAULT).

It's not obvious what the best solution is here.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
