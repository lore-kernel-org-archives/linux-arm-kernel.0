From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 15 Nov 2013 10:33:15 -0500
Subject: [PATCH 1/6] arm64: mm: Add __virt_to_idmap() to keep kvm build
 happy
In-Reply-To: <20131115153116.GD11347@arm.com>
References: <y> <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
 <1384457866-16135-2-git-send-email-santosh.shilimkar@ti.com>
 <5286384A.5050105@arm.com> <52863CE5.3070906@ti.com>
 <52863DF0.9070200@arm.com> <20131115153116.GD11347@arm.com>
Message-ID: <52863EBB.7050804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 November 2013 10:31 AM, Catalin Marinas wrote:
> On Fri, Nov 15, 2013 at 03:29:52PM +0000, Marc Zyngier wrote:
>> On 15/11/13 15:25, Santosh Shilimkar wrote:
>>> On Friday 15 November 2013 10:05 AM, Marc Zyngier wrote:
>>>> On 14/11/13 19:37, Santosh Shilimkar wrote:
>>>>> ARM kvm code will make use of __virt_to_idmap() on arm32
>>>>> machines as hardware interconnect supported alias of physical
>>>>> memory for idmap purposes. The same code is shared with arm64
>>>>> bit and hence will break the builds. So we add __virt_to_idmap()
>>>>> which is just __virt_to_phys() on arm64 bit to keep build happy.
>>>>>
>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>>>>>
>>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>> ---
>>>>>  arch/arm64/include/asm/memory.h |    8 ++++++++
>>>>>  1 file changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>>>>> index 3776217..d9341ee 100644
>>>>> --- a/arch/arm64/include/asm/memory.h
>>>>> +++ b/arch/arm64/include/asm/memory.h
>>>>> @@ -75,6 +75,14 @@
>>>>>  #define __phys_to_virt(x)	((unsigned long)((x) - PHYS_OFFSET + PAGE_OFFSET))
>>>>>  
>>>>>  /*
>>>>> + * Added to keep arm64 kvm build working which shares code with
>>>>> + * 32bit port. ARM kvm code makes use of __virt_to_idmap() on arm32
>>>>> + * machines as hardware interconnect supported alias of physical
>>>>> + * memory for idmap purposes.
>>>>> + */
>>>>> +#define virt_to_idmap(x)	__virt_to_phys(x)
>>>>> +
>>>>> +/*
>>>>>   * Convert a physical address to a Page Frame Number and back
>>>>>   */
>>>>>  #define	__phys_to_pfn(paddr)	((unsigned long)((paddr) >> PAGE_SHIFT))
>>>>>
>>>>
>>>> I'd rather have a kvm_virt_to_phys() in kvm_mmu.h. That's how we've
>>>> dealt with that kind of difference so far.
>>>>
>>> Are you suggesting something like below ?
>>
>> Yes, I like it a lot more.
>>
>> Catalin, what do you think?
> 
> It looks better ;)
> 
OK then. I will use this approach in my refreshed version. Still need
to get around other lingering issue with guest userspace corruption.

Regards,
Santosh
