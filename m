From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 11 Oct 2016 09:21:14 +0100
Subject: [PATCH] arm64: mmu: set the contiguous for kernel mappings when
 appropriate
In-Reply-To: <20161011074419.GA20213@remoulade>
References: <1476123164-10532-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161011074419.GA20213@remoulade>
Message-ID: <CAKv+Gu_y126PuYhmTq81Psjs6Ss_g2zTYm9asqPDBpc5Uqvh0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 October 2016 at 08:44, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Ard,
>
> On Mon, Oct 10, 2016 at 07:12:44PM +0100, Ard Biesheuvel wrote:
>> Now that we no longer allow live kernel PMDs to be split, it is safe to
>> start using the contiguous bit for kernel mappings. So set the contiguous
>> bit in the kernel page mappings for regions whose size and alignment are
>> suitable for this.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Given the splitting is now gone, using the contiguous bit makes sense to me.
>
> With 16K pages, we can have contiguous PMD entries. Should we handle those,
> too? e.g. have separate {PMD,PTE}_CONT{,_SIZE}?
>

Amusingly, this was exactly the feedback I gave to Jeremy when he
proposed this functionality originally. Yes, I think it makes sense,
especially for the linear mapping of system RAM. However, I think it
makes sense for someone else (with access to actual 16k granule
capable hardware) to contribute this functionality on top of this
patch.

> Otherwise, I have some comments below.
>
>> ---
>>  arch/arm64/mm/mmu.c | 23 ++++++++++++++++++++---
>>  1 file changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 05615a3fdc6f..c491025c6a70 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -98,8 +98,11 @@ static phys_addr_t __init early_pgtable_alloc(void)
>>  static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
>>                                 unsigned long end, unsigned long pfn,
>>                                 pgprot_t prot,
>> -                               phys_addr_t (*pgtable_alloc)(void))
>> +                               phys_addr_t (*pgtable_alloc)(void),
>> +                               bool allow_block_mappings)
>
> Not a big deal, but the 'block' part here and elsewhere is now arguably
> misleading (given 'block' is an architectural term).
>
> I haven't come up with a better term, so again, not a big deal. ;)
>

Indeed. I could simply call it 'allow_cont_mappings' in the context of
this function, and keep the call below as is.

>>  {
>> +     pgprot_t prot_cont = __pgprot(pgprot_val(prot) | PTE_CONT);
>> +     bool cont = false;
>>       pte_t *pte;
>>
>>       BUG_ON(pmd_sect(*pmd));
>> @@ -115,7 +118,20 @@ static void alloc_init_pte(pmd_t *pmd, unsigned long addr,
>>
>>       pte = pte_set_fixmap_offset(pmd, addr);
>>       do {
>> -             set_pte(pte, pfn_pte(pfn, prot));
>> +             /*
>> +              * Set the contiguous bit for the subsequent group of PTEs if
>> +              * its size and alignment are suitable.
>> +              */
>> +             if (((addr | PFN_PHYS(pfn)) & ~CONT_MASK) == 0)
>> +                     cont = allow_block_mappings && end - addr >= CONT_SIZE;
[...]
>> +
>> +             /*
>> +              * Ensure that we do not change the contiguous bit once this
>> +              * PTE has been assigned.
>> +              */
>> +             BUG_ON(!pte_none(*pte) && (cont ^ !!(pte_val(*pte) & PTE_CONT)));
>
> IIRC, we only ever intended to mess with the AP bits when remapping an existing region.
>
> So we could mask those out and ensure everything else is identical, rather than
> checking the cont bit specifically. Likewise at the {PMD,PUD,PGD} level.
>

Yes, that should be better, I can put that in a separate preparatory patch.

>> +
>> +             set_pte(pte, pfn_pte(pfn, cont ? prot_cont : prot));
>
> It would be clearer if we just assigned to a local pte_prot variable when
> checking allow_block_mappings and so on above (or split the loop as above).
>

Well, the local pte_prot variable's scope should still cover the
entire function, since cont does not change value at each iteration.
