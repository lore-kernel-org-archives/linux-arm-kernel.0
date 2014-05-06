From: m.smarduch@samsung.com (Mario Smarduch)
Date: Mon, 05 May 2014 18:27:48 -0700
Subject: [PATCH v4 5/5] change update_range to handle > 4GB 2nd stage range
 for ARMv7
In-Reply-To: <CA+eFSM2FundVPupJpr1EJ7R8XB2ZJzcGbi8KNs33v=xsYtimpA@mail.gmail.com>
References: <535EF871.9090604@samsung.com> <535EFB21.9040308@samsung.com>
 <CA+eFSM2FundVPupJpr1EJ7R8XB2ZJzcGbi8KNs33v=xsYtimpA@mail.gmail.com>
Message-ID: <53683A94.6090308@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gavin,
   thanks, didn't catch that, I'll remove these calls.

- Mario

On 05/05/2014 04:34 PM, Gavin Guo wrote:
> Hi Mario,
> 
> On Tue, Apr 29, 2014 at 9:06 AM, Mario Smarduch <m.smarduch@samsung.com> wrote:
>>
>> This patch adds support for unmapping 2nd stage page tables for addresses >4GB
>> on ARMv7.
>>
>> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
>> ---
>>  arch/arm/kvm/mmu.c |   20 ++++++++++++--------
>>  1 file changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index 88f5503..afbf8ba 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -176,21 +176,25 @@ static void clear_pte_entry(struct kvm *kvm, pte_t *pte, phys_addr_t addr)
>>         }
>>  }
>>
>> +/* Function shared between identity and 2nd stage mappings. For 2nd stage
>> + * the IPA may be > 4GB on ARMv7, and page table range functions
>> + * will fail. kvm_xxx_addr_end() is used to handle both cases.
>> + */
>>  static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
>> -                       unsigned long long start, u64 size)
>> +                       phys_addr_t start, u64 size)
>>  {
>>         pgd_t *pgd;
>>         pud_t *pud;
>>         pmd_t *pmd;
>>         pte_t *pte;
>> -       unsigned long long addr = start, end = start + size;
>> -       u64 next;
>> +       phys_addr_t addr = start, end = start + size;
>> +       phys_addr_t next;
>>
>>         while (addr < end) {
>>                 pgd = pgdp + pgd_index(addr);
>>                 pud = pud_offset(pgd, addr);
>>                 if (pud_none(*pud)) {
>> -                       addr = pud_addr_end(addr, end);
>> +                       addr = kvm_pud_addr_end(addr, end);
>>                         continue;
>>                 }
>>
>> @@ -200,13 +204,13 @@ static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
>>                          * move on.
>>                          */
>>                         clear_pud_entry(kvm, pud, addr);
>> -                       addr = pud_addr_end(addr, end);
>> +                       addr = kvm_pud_addr_end(addr, end);
>>                         continue;
>>                 }
>>
>>                 pmd = pmd_offset(pud, addr);
>>                 if (pmd_none(*pmd)) {
>> -                       addr = pmd_addr_end(addr, end);
>> +                       addr = kvm_pmd_addr_end(addr, end);
>>                         continue;
>>                 }
>>
>> @@ -221,10 +225,10 @@ static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
>>                  */
>>                 if (kvm_pmd_huge(*pmd) || page_empty(pte)) {
>>                         clear_pmd_entry(kvm, pmd, addr);
>> -                       next = pmd_addr_end(addr, end);
>> +                       next = kvm_pmd_addr_end(addr, end);
>>                         if (page_empty(pmd) && !page_empty(pud)) {
>>                                 clear_pud_entry(kvm, pud, addr);
>> -                               next = pud_addr_end(addr, end);
>> +                               next = kvm_pud_addr_end(addr, end);
>>                         }
>>                 }
>>
>> --
>> 1.7.9.5
>>
>>
>>
> 
> It seems that your adding kvm_pmd_addr_end(addr, end) already exists
> in the following patch and may need to remove these parts from your
> patch.
> 
> commit a3c8bd31af260a17d626514f636849ee1cd1f63e
> Author: Marc Zyngier <marc.zyngier@arm.com>
> Date:   Tue Feb 18 14:29:03 2014 +0000
> 
>     ARM: KVM: introduce kvm_p*d_addr_end
> 
>     The use of p*d_addr_end with stage-2 translation is slightly dodgy,
>     as the IPA is 40bits, while all the p*d_addr_end helpers are
>     taking an unsigned long (arm64 is fine with that as unligned long
>     is 64bit).
> 
>     The fix is to introduce 64bit clean versions of the same helpers,
>     and use them in the stage-2 page table code.
> 
>     Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>     Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>     Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Gavin
> 
