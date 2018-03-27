From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Tue, 27 Mar 2018 09:53:16 -0500
Subject: [PATCH V2] arm64: tlbflush: avoid writing RES0 bits
In-Reply-To: <985a0edd-e388-dade-8824-30cc58a236f3@arm.com>
References: <1522120877-9136-1-git-send-email-pelcan@codeaurora.org>
 <985a0edd-e388-dade-8824-30cc58a236f3@arm.com>
Message-ID: <56b560a5-6e57-8e01-32ca-9d3c95ccd2e5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 03/27/2018 06:34 AM, Robin Murphy wrote:
> On 27/03/18 04:21, Philip Elcan wrote:
>> Several of the bits of the TLBI register operand are RES0 per the ARM
>> ARM, so TLBI operations should avoid writing non-zero values to these
>> bits.
>>
>> This patch adds a macro __TLBI_VADDR(addr, asid) that creates the
>> operand register in the correct format and honors the RES0 bits.
>>
>> Signed-off-by: Philip Elcan <pelcan@codeaurora.org>
>> ---
>> ? arch/arm64/include/asm/tlbflush.h | 23 ++++++++++++++++-------
>> ? 1 file changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>> index 9e82dd7..b1205e9 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -60,6 +60,15 @@
>> ????????? __tlbi(op, (arg) | USER_ASID_FLAG);??????????????? \
>> ? } while (0)
>> ? +/* This macro creates a properly formatted VA operand for the TLBI */
>> +#define __TLBI_VADDR(addr, asid)??????????????? \
>> +??? ({??????????????????????????? \
>> +??????? unsigned long __ta = (addr) >> 12;??????? \
>> +??????? __ta &= GENMASK_ULL(43, 0);??????????? \
>> +??????? __ta |= (unsigned long)(asid) << 48;??????? \
>> +??????? __ta;??????????????????????? \
>> +??? })
> 
> I'd be inclined to make this a static inline function rather than a macro, since it doesn't need to do any wacky type-dodging, but either way the overall change now looks appropriate;
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> 

Tested-by: Shanker Donthineni <shankerd@codeaurora.org>

> Thanks,
> Robin.
> 
>> +
>> ? /*
>> ?? *??? TLB Management
>> ?? *??? ==============
>> @@ -117,7 +126,7 @@ static inline void flush_tlb_all(void)
>> ? ? static inline void flush_tlb_mm(struct mm_struct *mm)
>> ? {
>> -??? unsigned long asid = ASID(mm) << 48;
>> +??? unsigned long asid = __TLBI_VADDR(0, ASID(mm));
>> ? ????? dsb(ishst);
>> ????? __tlbi(aside1is, asid);
>> @@ -128,7 +137,7 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
>> ? static inline void flush_tlb_page(struct vm_area_struct *vma,
>> ??????????????????? unsigned long uaddr)
>> ? {
>> -??? unsigned long addr = uaddr >> 12 | (ASID(vma->vm_mm) << 48);
>> +??? unsigned long addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
>> ? ????? dsb(ishst);
>> ????? __tlbi(vale1is, addr);
>> @@ -154,8 +163,8 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
>> ????????? return;
>> ????? }
>> ? -??? start = asid | (start >> 12);
>> -??? end = asid | (end >> 12);
>> +??? start = __TLBI_VADDR(start, asid);
>> +??? end = __TLBI_VADDR(end, asid);
>> ? ????? dsb(ishst);
>> ????? for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12)) {
>> @@ -185,8 +194,8 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
>> ????????? return;
>> ????? }
>> ? -??? start >>= 12;
>> -??? end >>= 12;
>> +??? start = __TLBI_VADDR(start, 0);
>> +??? end = __TLBI_VADDR(end, 0);
>> ? ????? dsb(ishst);
>> ????? for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12))
>> @@ -202,7 +211,7 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
>> ? static inline void __flush_tlb_pgtable(struct mm_struct *mm,
>> ???????????????????????? unsigned long uaddr)
>> ? {
>> -??? unsigned long addr = uaddr >> 12 | (ASID(mm) << 48);
>> +??? unsigned long addr = __TLBI_VADDR(uaddr, ASID(mm));
>> ? ????? __tlbi(vae1is, addr);
>> ????? __tlbi_user(vae1is, addr);
>>

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
