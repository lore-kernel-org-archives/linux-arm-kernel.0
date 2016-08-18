From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 18 Aug 2016 13:55:23 +0200
Subject: [PATCH v4 2/3] arm64: vmlinux.ld: Add .mmuoff.{text,
 data} sections
In-Reply-To: <57B59E85.8020304@arm.com>
References: <1471281122-26295-1-git-send-email-james.morse@arm.com>
 <1471281122-26295-3-git-send-email-james.morse@arm.com>
 <CAKv+Gu-1jEPAFL7mUP6FqVzYrPQvVXfrB9RPuuR5AZFAWHBQQQ@mail.gmail.com>
 <57B59E85.8020304@arm.com>
Message-ID: <CAKv+Gu8X22ghgvez5tTfwrm8PDzsB6xatHDs6S5_BM4YWaKgmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 August 2016 at 13:39, James Morse <james.morse@arm.com> wrote:
> Hi Ard,
>
> On 17/08/16 18:50, Ard Biesheuvel wrote:
>> On 15 August 2016 at 19:12, James Morse <james.morse@arm.com> wrote:
>>> Resume from hibernate needs to clean any text executed by the kernel with
>>> the MMU off to the PoC. Collect these functions together into a new
>>> .mmuoff.text section. __boot_cpu_mode and secondary_holding_pen_release
>>> are data that is read or written with the MMU off. Add these to a new
>>> .mmuoff.data section.
>>>
>>> This covers booting of secondary cores and the cpu_suspend() path used
>>> by cpu-idle and suspend-to-ram.
>>>
>>> The bulk of head.S is not included, as the primary boot code is only ever
>>> executed once, the kernel never needs to ensure it is cleaned to a
>>> particular point in the cache.
>
>>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>>> index b77f58355da1..4230eeeeabf5 100644
>>> --- a/arch/arm64/kernel/head.S
>>> +++ b/arch/arm64/kernel/head.S
>>> @@ -621,17 +622,31 @@ set_cpu_boot_mode_flag:
>>>  ENDPROC(set_cpu_boot_mode_flag)
>>>
>>>  /*
>>> + * Values in this section are written with the MMU off, but read with the
>>> + * MMU on. Writers will invalidate the corresponding address, discarding
>>> + * a 'Cache Writeback Granule' (CWG) worth of data. Align these variables
>>> + * to the architectural maximum of 2K.
>>> + */
>>> +       .pushsection ".mmuoff.data", "aw"
>>> +       .align 11
>>> +/*
>>>   * We need to find out the CPU boot mode long after boot, so we need to
>>>   * store it in a writable variable.
>>>   *
>>>   * This is not in .bss, because we set it sufficiently early that the boot-time
>>>   * zeroing of .bss would clobber it.
>>>   */
>>> -       .pushsection    .data..cacheline_aligned
>>> -       .align  L1_CACHE_SHIFT
>>>  ENTRY(__boot_cpu_mode)
>>>         .long   BOOT_CPU_MODE_EL2
>>>         .long   BOOT_CPU_MODE_EL1
>>> +/*
>>> + * The booting CPU updates the failed status @__early_cpu_boot_status,
>>> + * with MMU turned off.
>>> + */
>>> +ENTRY(__early_cpu_boot_status)
>>> +       .long   0
>>> +
>>> +       .align 11
>>
>> How is this supposed to work? Is secondary_holding_pen_release
>> expected to be covered by this region as well?
>
> In this section, but not in the same CWG:
> __boot_cpu_mode and __early_cpu_boot_status are written with the mmu off, then
> the corresponding cache area is invalidated.
>
> secondary_holding_pen_release works the other way round, it is written with the
> mmu on, then clean+invalidated, to be read with the mmu off.
>
> I grouped them together in an older version, Mark pointed out that the
> maintenance of one could corrupt the other if they fall within a CWG of each
> other. [0]
>
>
>> Wouldn't it be better to handle this alignment in the linker script?
>
> Its not just alignment of the section, but the alignment between mmuoff:read and
> mmuoff:write variables. Maybe it would be cleared if they were in separate sections?
>

Yes, that would make sense. Also, the section containing
secondary_holding_pen_release may still overlap with something else,
afaict if it is emitted after the one in head.S.

> (I should at least smother it with more comments)
>

That too :-)

>
>> (if you even need it, but see below)
>>
>>>         .popsection
>>>
>>>         /*
>>> @@ -687,6 +702,7 @@ __secondary_switched:
>>>         mov     x29, #0
>>>         b       secondary_start_kernel
>>>  ENDPROC(__secondary_switched)
>>> +       .popsection
>>>
>>>  /*
>>>   * The booting CPU updates the failed status @__early_cpu_boot_status,
>>> @@ -706,12 +722,6 @@ ENDPROC(__secondary_switched)
>>>         dc      ivac, \tmp1                     // Invalidate potentially stale cache line
>>>         .endm
>>>
>>> -       .pushsection    .data..cacheline_aligned
>>> -       .align  L1_CACHE_SHIFT
>>> -ENTRY(__early_cpu_boot_status)
>>> -       .long   0
>>> -       .popsection
>>> -
>>>  /*
>>>   * Enable the MMU.
>>>   *
>
>>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>>> index 659963d40bb4..bbab3d886516 100644
>>> --- a/arch/arm64/kernel/vmlinux.lds.S
>>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>>> @@ -120,6 +120,9 @@ SECTIONS
>>>                         IRQENTRY_TEXT
>>>                         SOFTIRQENTRY_TEXT
>>>                         ENTRY_TEXT
>>> +                       __mmuoff_text_start = .;
>>> +                       *(.mmuoff.text)
>>> +                       __mmuoff_text_end = .;
>>>                         TEXT_TEXT
>>>                         SCHED_TEXT
>>>                         LOCK_TEXT
>>> @@ -186,6 +189,11 @@ SECTIONS
>>>         _sdata = .;
>>>         RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
>>>         PECOFF_EDATA_PADDING
>>
>> This padding needs to be at the end, it is intended to make the size
>> of Image a multiple of 512.
>
> Ah, I didn't realise that, readelf says I broke this.
> I will move it to be before.
>

Yes, please. This is required for the PE/COFF signing tools (for UEFI
secure boot)

> (secondary_holding_pen_rel appears after head.S's align 11s, so the next symbol
> isn't 2KB aligned)
>
>
>> Alternatively, you could get rid of it
>> completely, I guess, if the end of .mmuoff.text is expected to be 2 KB
>> aligned (but I wonder if you need to)
>>
>>> +       .mmuoff.data : {
>>
>>  .mmuoff.data : ALIGN (SZ_2K) {
>>
>>> +               __mmuoff_data_start = .;
>>> +               *(.mmuoff.data)
>>
>> . = ALIGN(SZ_2K);
>>
>> However, if the invalidation occurs before .bss is cleared (with the
>> caches on), perhaps there is no need to align the end of this section?
>
> We invalidate something in this section via secondary_entry() ->
> set_cpu_boot_mode_flag(), so this can happen any time.
> My understanding is that CWG is maximum amount of data that will be invalidated
> and at compile time we assume its worst case of 2KB. Aligning the end is to stop
> anything else being located in this worst case range.
>

Actually, it is not even necessary to align the end of .mmuoff.data,
as long as the next section starts at at 2 KB aligned boundary (which
is guaranteed for .bss since it covers page aligned data, although it
would make sense to make that explicit) I.e., something like

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 659963d40bb4..70aa77060729 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -185,10 +185,18 @@ SECTIONS
        _data = .;
        _sdata = .;
        RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
+
+       .mmuoff.read : ALIGN(SZ_2K) {
+               *(.mmuoff.read)
+       }
+       .mmuoff.write : ALIGN(SZ_2K) {
+               *(.mmuoff.write)
+       }
+
        PECOFF_EDATA_PADDING
        _edata = .;

-       BSS_SECTION(0, 0, 0)
+       BSS_SECTION(SZ_2K, SZ_2K, 0)

        . = ALIGN(PAGE_SIZE);
        idmap_pg_dir = .;

AFAICT, this should allow you to drop the alignments in the code. This
is also more future proof, since you can simply emit variables into
these sections anywhere, whereas the explicit .align directive aligns
that particular variable, which could lead to more waste of space.

-- 
Ard.
