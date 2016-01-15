From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 15 Jan 2016 13:46:58 +0100
Subject: [PATCH] arm64: hide __efistub_ aliases from kallsyms
In-Reply-To: <20160115124159.GF3262@leverpostej>
References: <1452860937-4413-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160115124159.GF3262@leverpostej>
Message-ID: <CAKv+Gu8mos798tm625kYWbFkAoCfeppsmQs=_QO2HpGQB64KYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 January 2016 at 13:41, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Jan 15, 2016 at 01:28:57PM +0100, Ard Biesheuvel wrote:
>> Commit e8f3010f7326 ("arm64/efi: isolate EFI stub from the kernel
>> proper") isolated the EFI stub code from the kernel proper by prefixing
>> all of its symbols with __efistub_, and selectively allowing access to
>> core kernel symbols from the stub by emitting __efistub_ aliases for
>> functions and variables that the stub can access legally.
>>
>> As an unintended side effect, these aliases are emitted into the
>> kallsyms symbol table, which means they may turn up in backtraces,
>> e.g.,
>>
>>   ...
>>   PC is at __efistub_memset+0x108/0x200
>>   LR is at fixup_init+0x3c/0x48
>>   ...
>>   [<ffffff8008328608>] __efistub_memset+0x108/0x200
>>   [<ffffff8008094dcc>] free_initmem+0x2c/0x40
>>   [<ffffff8008645198>] kernel_init+0x20/0xe0
>>   [<ffffff8008085cd0>] ret_from_fork+0x10/0x40
>>
>> The backtrace in question has nothing to do with the EFI stub, but
>> simply returns one of the several aliases of memset() that have been
>> recorded in the kallsyms table. This is undesirable, since it may
>> suggest to people who are not aware of this that the issue they are
>> seeing is somehow EFI related.
>>
>> So hide the __efistub_ aliases from kallsyms, by emitting them as
>> absolute linker symbols explicitly. The distinction between those
>> and section relative symbols is completely irrelevant to these
>> definitions, and to the final link we are performing when these
>> definitions are being taken into account (the distinction is only
>> relevant to symbols defined inside a section definition when performing
>> a partial link), and so the resulting values are identical to the
>> original ones. Since absolute symbols are ignored by kallsyms, this
>> will result in these values to be omitted from its symbol table.
>>
>> After this patch, the backtrace generated from the same address looks
>> like this:
>>   ...
>>   PC is at __memset+0x108/0x200
>>   LR is at fixup_init+0x3c/0x48
>>   ...
>>   [<ffffff8008328608>] __memset+0x108/0x200
>>   [<ffffff8008094dcc>] free_initmem+0x2c/0x40
>>   [<ffffff8008645198>] kernel_init+0x20/0xe0
>>   [<ffffff8008085cd0>] ret_from_fork+0x10/0x40
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/kernel/image.h | 40 +++++++++++++++++++++++++---------------
>>  1 file changed, 25 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
>> index ddd61e2d9e3e..ce6f02c56b3d 100644
>> --- a/arch/arm64/kernel/image.h
>> +++ b/arch/arm64/kernel/image.h
>> @@ -81,6 +81,16 @@
>>  #ifdef CONFIG_EFI
>>
>>  /*
>> + * Prevent the symbol aliases below from being emitted into the kallsyms
>> + * table, by forcing them to be absolute symbols (which are conveniently
>> + * ignored by scripts/kallsyms) rather than section relative symbols.
>> + * The distinction is only relevant for partial linking, and only for symbols
>> + * that are defined within a section declaration (which is not the case for
>> + * the definitions below) so the resulting values will be identical.
>> + */
>> +#define KALLSYMS_HIDE(sym)   ABSOLUTE(sym)
>
> From looking at the GNU LD manual recently, I discovered
> PROVIDE_HIDDEN(sym), which sounds closer to what we want semantically,
> even if ABSOLUTE(sym) acheives the same thing.
>
> If that works, that might be preferable.
>

No, it doesn't. PROVIDE_HIDDEN() turns it into a local symbol, but
preserves the type, i.e.,

Before:
ffffff8008080000 T __efistub__text

With this patch
ffffff8008080000 A __efistub__text

With PROVIDE_HIDDEN
ffffff8008080000 t __efistub__text

I am not crazy about this change myself, but at least it keeps the
ugliness confined to image.h in a well annotated manner, rather than
in every backtrace that involves any of these functions.

> Either way this looks sensible to me, so:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>

Thanks,
Ard.

>> +
>> +/*
>>   * The EFI stub has its own symbol namespace prefixed by __efistub_, to
>>   * isolate it from the kernel proper. The following symbols are legally
>>   * accessed by the stub, so provide some aliases to make them accessible.
>> @@ -89,25 +99,25 @@
>>   * linked at. The routines below are all implemented in assembler in a
>>   * position independent manner
>>   */
>> -__efistub_memcmp             = __pi_memcmp;
>> -__efistub_memchr             = __pi_memchr;
>> -__efistub_memcpy             = __pi_memcpy;
>> -__efistub_memmove            = __pi_memmove;
>> -__efistub_memset             = __pi_memset;
>> -__efistub_strlen             = __pi_strlen;
>> -__efistub_strcmp             = __pi_strcmp;
>> -__efistub_strncmp            = __pi_strncmp;
>> -__efistub___flush_dcache_area        = __pi___flush_dcache_area;
>> +__efistub_memcmp             = KALLSYMS_HIDE(__pi_memcmp);
>> +__efistub_memchr             = KALLSYMS_HIDE(__pi_memchr);
>> +__efistub_memcpy             = KALLSYMS_HIDE(__pi_memcpy);
>> +__efistub_memmove            = KALLSYMS_HIDE(__pi_memmove);
>> +__efistub_memset             = KALLSYMS_HIDE(__pi_memset);
>> +__efistub_strlen             = KALLSYMS_HIDE(__pi_strlen);
>> +__efistub_strcmp             = KALLSYMS_HIDE(__pi_strcmp);
>> +__efistub_strncmp            = KALLSYMS_HIDE(__pi_strncmp);
>> +__efistub___flush_dcache_area        = KALLSYMS_HIDE(__pi___flush_dcache_area);
>>
>>  #ifdef CONFIG_KASAN
>> -__efistub___memcpy           = __pi_memcpy;
>> -__efistub___memmove          = __pi_memmove;
>> -__efistub___memset           = __pi_memset;
>> +__efistub___memcpy           = KALLSYMS_HIDE(__pi_memcpy);
>> +__efistub___memmove          = KALLSYMS_HIDE(__pi_memmove);
>> +__efistub___memset           = KALLSYMS_HIDE(__pi_memset);
>>  #endif
>>
>> -__efistub__text                      = _text;
>> -__efistub__end                       = _end;
>> -__efistub__edata             = _edata;
>> +__efistub__text                      = KALLSYMS_HIDE(_text);
>> +__efistub__end                       = KALLSYMS_HIDE(_end);
>> +__efistub__edata             = KALLSYMS_HIDE(_edata);
>>
>>  #endif
>>
>> --
>> 2.5.0
>>
