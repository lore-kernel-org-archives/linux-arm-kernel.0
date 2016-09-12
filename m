From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 12 Sep 2016 16:12:19 +0100
Subject: [PATCH] arm64: mm: move zero page from .bss to right before
 swapper_pg_dir
In-Reply-To: <20160912145931.GB14165@leverpostej>
References: <1473689784-29745-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160912145931.GB14165@leverpostej>
Message-ID: <CAKv+Gu9pfBt5n58vUy7P-VytJ1xRiETO8vqxkPqQ3tF6WtXJaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 September 2016 at 15:59, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Ard,
>
> On Mon, Sep 12, 2016 at 03:16:24PM +0100, Ard Biesheuvel wrote:
>>  static inline void cpu_set_reserved_ttbr0(void)
>>  {
>> -     unsigned long ttbr = virt_to_phys(empty_zero_page);
>> -
>> -     asm(
>> -     "       msr     ttbr0_el1, %0                   // set TTBR0\n"
>> -     "       isb"
>> -     :
>> -     : "r" (ttbr));
>> +     /*
>> +      * The zero page is located right before swapper_pg_dir, whose
>> +      * physical address we can easily fetch from TTBR1_EL1.
>> +      */
>> +     write_sysreg(read_sysreg(ttbr1_el1) - PAGE_SIZE, ttbr0_el1);
>> +     isb();
>>  }
>
> As a heads-up, in arm64 for-next/core this is a write_sysreg() and an
> isb() thanks to [1,2]. This will need a rebase to avoid conflict.
>

OK, I will rebase onto for-next/core for v3, if needed.

>>  /*
>> @@ -109,7 +108,8 @@ static inline void cpu_uninstall_idmap(void)
>>  {
>>       struct mm_struct *mm = current->active_mm;
>>
>> -     cpu_set_reserved_ttbr0();
>> +     write_sysreg(virt_to_phys(empty_zero_page), ttbr0_el1);
>> +     isb();
>>       local_flush_tlb_all();
>>       cpu_set_default_tcr_t0sz();
>>
>> @@ -119,7 +119,8 @@ static inline void cpu_uninstall_idmap(void)
>>
>>  static inline void cpu_install_idmap(void)
>>  {
>> -     cpu_set_reserved_ttbr0();
>> +     write_sysreg(virt_to_phys(empty_zero_page), ttbr0_el1);
>> +     isb();
>>       local_flush_tlb_all();
>>       cpu_set_idmap_tcr_t0sz();
>
> It would be worth a comment as to why we have to open-code these, so as
> to avoid "obvious" / "trivial cleanup" patches to this later. e.g.
> expand the comment in cpu_set_reserved_ttbr0 with:
>
> * In some cases (e.g. where cpu_replace_ttbr1 is used), TTBR1 may not
> * point at swapper_pg_dir, and this helper cannot be used.
>
> ... and add /* see cpu_set_reserved_ttbr0 */ to both of these above the
> write_sysreg().
>

Ack.

>> diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
>> index 4e7e7067afdb..44e94e234ba0 100644
>> --- a/arch/arm64/include/asm/sections.h
>> +++ b/arch/arm64/include/asm/sections.h
>> @@ -26,5 +26,6 @@ extern char __hyp_text_start[], __hyp_text_end[];
>>  extern char __idmap_text_start[], __idmap_text_end[];
>>  extern char __irqentry_text_start[], __irqentry_text_end[];
>>  extern char __mmuoff_data_start[], __mmuoff_data_end[];
>> +extern char __robss_start[], __robss_end[];
>>
>>  #endif /* __ASM_SECTIONS_H */
>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> index 5ce9b2929e0d..eae5036dc725 100644
>> --- a/arch/arm64/kernel/vmlinux.lds.S
>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> @@ -209,9 +209,19 @@ SECTIONS
>>
>>       BSS_SECTION(0, 0, 0)
>>
>> -     . = ALIGN(PAGE_SIZE);
>> +     . = ALIGN(SEGMENT_ALIGN);
>> +     __robss_start = .;
>>       idmap_pg_dir = .;
>> -     . += IDMAP_DIR_SIZE;
>> +     . = ALIGN(. + IDMAP_DIR_SIZE + PAGE_SIZE, SEGMENT_ALIGN);
>> +     __robss_end = .;
>
> Is it really worth aligning this beyond PAGE_SIZE?
>
> We shouldn't be poking these very often, the padding is always larger
> than the number of used pages, and the swapper dir is relegated to page
> mappings regardless.
>

The segment alignment is intended to take advantage of PTE_CONT
mappings (support for which still hasn't landed, afaict). I don't care
deeply either way ...

>> +     /*
>> +      * Put the zero page right before swapper_pg_dir so we can easily
>> +      * obtain its physical address by subtracting PAGE_SIZE from the
>> +      * contents of TTBR1_EL1.
>> +      */
>> +     empty_zero_page = __robss_end - PAGE_SIZE;
>
> Further to the above, I think this would be clearer if defined in-line
> as with the idmap and swapper pgdirs (with page alignment).
>

Perhaps it is best to simply do

empty_zero_page = swapper_pg_dir - PAGE_SIZE;

since that is the relation we're after.

>>       /*
>> -      * Map the linear alias of the [_text, __init_begin) interval as
>> -      * read-only/non-executable. This makes the contents of the
>> -      * region accessible to subsystems such as hibernate, but
>> -      * protects it from inadvertent modification or execution.
>> +      * Map the linear alias of the intervals [_text, __init_begin) and
>> +      * [robss_start, robss_end) as read-only/non-executable. This makes
>> +      * the contents of these regions accessible to subsystems such
>> +      * as hibernate, but protects them from inadvertent modification or
>> +      * execution.
>
> For completeness, it may also be worth stating that we're mapping the
> gap between those as usual, since this will be freed.
>
> Then again, maybe not. ;)
>

Well, there is a tacit assumption here that a memblock that covers any
part of the kernel covers all of it, but I think this is reasonable,
given that the memblock layer merges adjacent entries, and we could
not have holes.

Re freeing, I don't get your point: all of these mappings are permanent.

> [...]
>
>> @@ -436,13 +442,19 @@ static void __init map_kernel_segment(pgd_t *pgd, void *va_start, void *va_end,
>>   */
>>  static void __init map_kernel(pgd_t *pgd)
>>  {
>> -     static struct vm_struct vmlinux_text, vmlinux_rodata, vmlinux_init, vmlinux_data;
>> +     static struct vm_struct vmlinux_text, vmlinux_rodata, vmlinux_init,
>> +             vmlinux_data, vmlinux_robss, vmlinux_tail;
>>
>>       map_kernel_segment(pgd, _text, _etext, PAGE_KERNEL_EXEC, &vmlinux_text);
>>       map_kernel_segment(pgd, __start_rodata, __init_begin, PAGE_KERNEL, &vmlinux_rodata);
>>       map_kernel_segment(pgd, __init_begin, __init_end, PAGE_KERNEL_EXEC,
>>                          &vmlinux_init);
>> -     map_kernel_segment(pgd, _data, _end, PAGE_KERNEL, &vmlinux_data);
>> +     map_kernel_segment(pgd, _data, __robss_start, PAGE_KERNEL,
>> +                        &vmlinux_data);
>> +     map_kernel_segment(pgd, __robss_start, __robss_end, PAGE_KERNEL_RO,
>> +                        &vmlinux_robss);
>> +     map_kernel_segment(pgd, __robss_end, _end, PAGE_KERNEL,
>> +                        &vmlinux_tail);
>
> Perhaps s/tail/swapper/ or s/tail/pgdir/ to make this clearer?
>

Sure.

> Modulo the above, this looks good to me.
>

Thanks.
