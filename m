From: keescook@chromium.org (Kees Cook)
Date: Tue, 8 Dec 2015 10:38:48 -0800
Subject: [PATCH v2] ARM: mm: mark section-aligned portion of rodata NX
In-Reply-To: <CAKv+Gu9EeKQk7GOAPV2cvff10=kD49u+oP-yEiOrJBPOF=QNtw@mail.gmail.com>
References: <20151207223534.GA13722@www.outflux.net>
 <CAKv+Gu9EeKQk7GOAPV2cvff10=kD49u+oP-yEiOrJBPOF=QNtw@mail.gmail.com>
Message-ID: <CAGXu5j+Pc7ucC4tmxHyDW7aW88pwQvMejuR2Ehdxp=vY+pv-5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 7, 2015 at 11:47 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 7 December 2015 at 23:35, Kees Cook <keescook@chromium.org> wrote:
>> When rodata is large enough that it crosses a section boundary after the
>> kernel text, mark the rest NX. This is as close to full NX of rodata as
>> we can get without splitting page tables or doing section alignment via
>> CONFIG_DEBUG_ALIGN_RODATA.
>>
>> When the config is:
>>
>>  CONFIG_DEBUG_RODATA=y
>>  # CONFIG_DEBUG_ALIGN_RODATA is not set
>>
>> Before:
>>
>> ---[ Kernel Mapping ]---
>> 0x80000000-0x80100000           1M     RW NX SHD
>> 0x80100000-0x80a00000           9M     ro x  SHD
>> 0x80a00000-0xa0000000         502M     RW NX SHD
>>
>> After:
>>
>> ---[ Kernel Mapping ]---
>> 0x80000000-0x80100000           1M     RW NX SHD
>> 0x80100000-0x80700000           6M     ro x  SHD
>> 0x80700000-0x80a00000           3M     ro NX SHD
>> 0x80a00000-0xa0000000         502M     RW NX SHD
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> v2:
>> - static declaration, ard
>> ---
>>  arch/arm/kernel/vmlinux.lds.S | 9 +++++++--
>>  arch/arm/mm/init.c            | 7 ++++---
>>  2 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
>> index a6e395c53a48..9c249c71fda1 100644
>> --- a/arch/arm/kernel/vmlinux.lds.S
>> +++ b/arch/arm/kernel/vmlinux.lds.S
>> @@ -8,9 +8,7 @@
>>  #include <asm/thread_info.h>
>>  #include <asm/memory.h>
>>  #include <asm/page.h>
>> -#ifdef CONFIG_DEBUG_RODATA
>>  #include <asm/pgtable.h>
>> -#endif
>>
>>  #define PROC_INFO                                                      \
>>         . = ALIGN(4);                                                   \
>> @@ -337,6 +335,13 @@ SECTIONS
>>  }
>>
>>  /*
>> + * Without CONFIG_DEBUG_ALIGN_RODATA, __start_rodata_section_aligned will
>> + * be the first section-aligned location after __start_rodata. Otherwise,
>> + * it will be equal to __start_rodata.
>> + */
>> +__start_rodata_section_aligned = ALIGN(__start_rodata, 1 << SECTION_SHIFT);
>> +
>> +/*
>>   * These must never be empty
>>   * If you have to comment these two assert statements out, your
>>   * binutils is too old (for other reasons as well)
>> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
>> index 321d3683dc7c..6b16f6cf4843 100644
>> --- a/arch/arm/mm/init.c
>> +++ b/arch/arm/mm/init.c
>> @@ -579,6 +579,9 @@ struct section_perm {
>>         pmdval_t clear;
>>  };
>>
>> +/* First section-aligned location at or after __start_rodata. */
>> +extern char __start_rodata_section_aligned[];
>> +
>>  static struct section_perm nx_perms[] = {
>>         /* Make pages tables, etc before _stext RW (set NX). */
>>         {
>> @@ -596,16 +599,14 @@ static struct section_perm nx_perms[] = {
>>                 .mask   = ~PMD_SECT_XN,
>>                 .prot   = PMD_SECT_XN,
>>         },
>> -#ifdef CONFIG_DEBUG_ALIGN_RODATA
>>         /* Make rodata NX (set RO in ro_perms below). */
>>         {
>>                 .name   = "rodata NX",
>> -               .start  = (unsigned long)__start_rodata,
>> +               .start  = (unsigned long)__start_rodata_section_aligned,
>>                 .end    = (unsigned long)__init_begin,
>
> What happens if start > end ?

It isn't possible, since rodata will be after text and before
init_begin, so it must either less than or equal to init_begin. The
equal case is quite possible, and that's fine, since both cases are
(correctly) silently ignored by set_section_perms:

                for (addr = perms[i].start; addr < perms[i].end; addr
+= SECTION_SIZE)
                    section_update(....

-Kees

>
>>                 .mask   = ~PMD_SECT_XN,
>>                 .prot   = PMD_SECT_XN,
>>         },
>> -#endif
>>  };
>>
>>  static struct section_perm ro_perms[] = {
>> --
>> 1.9.1
>>
>>
>> --
>> Kees Cook
>> Chrome OS & Brillo Security



-- 
Kees Cook
Chrome OS & Brillo Security
