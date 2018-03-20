From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 20 Mar 2018 12:09:49 +0800
Subject: [RFC PATCH 1/6] arm64/mm: add explicit physical address argument
 to map_kernel_segment
In-Reply-To: <20180320033323.kyjgtbzxc3vjpars@salmiak>
References: <20180319111958.4171-1-ard.biesheuvel@linaro.org>
 <20180319111958.4171-2-ard.biesheuvel@linaro.org>
 <20180320033323.kyjgtbzxc3vjpars@salmiak>
Message-ID: <CAKv+Gu9u26jC90rTsRuNuP_vnCKpun=WOoq7RJ0juWwiWy7coA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 March 2018 at 11:33, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Mar 19, 2018 at 07:19:53PM +0800, Ard Biesheuvel wrote:
>> In preparation of mapping a physically non-adjacent memory region
>> as backing for the vmlinux segment covering the trampoline and primary
>> level swapper_pg_dir regions, make the physical address an explicit
>> argument of map_kernel_segment().
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/mm/mmu.c | 22 ++++++++++++--------
>>  1 file changed, 13 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 8c704f1e53c2..007b2e32ca71 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -507,10 +507,10 @@ void mark_rodata_ro(void)
>>  }
>>
>>  static void __init map_kernel_segment(pgd_t *pgdp, void *va_start, void *va_end,
>> -                                   pgprot_t prot, struct vm_struct *vma,
>> -                                   int flags, unsigned long vm_flags)
>> +                                   phys_addr_t pa_start, pgprot_t prot,
>> +                                   struct vm_struct *vma, int flags,
>> +                                   unsigned long vm_flags)
>>  {
>> -     phys_addr_t pa_start = __pa_symbol(va_start);
>>       unsigned long size = va_end - va_start;
>>
>>       BUG_ON(!PAGE_ALIGNED(pa_start));
>
> How about we rename this to __map_kernel_segment(), and have a
> map_kernel_segment wrapper that does the __pa_symbol() stuff?
>
> That would avoid some redundancy in map_kernel(), and when we can use
> __map_kernel_segment() for the trampoline bits.
>

Fair enough.
