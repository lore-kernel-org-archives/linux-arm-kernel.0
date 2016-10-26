From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 26 Oct 2016 18:47:42 +0100
Subject: [PATCH v2] modversions: treat symbol CRCs as 32 bit quantities on
 64 bit archs
In-Reply-To: <CAKv+Gu-MEG5ayvBcbOwEFzaWPUvOwzTHVH9JKF_tKVN683Eh7A@mail.gmail.com>
References: <1476956263-1787-1-git-send-email-ard.biesheuvel@linaro.org>
 <871sz3xw1s.fsf@concordia.ellerman.id.au>
 <CAKv+Gu-MEG5ayvBcbOwEFzaWPUvOwzTHVH9JKF_tKVN683Eh7A@mail.gmail.com>
Message-ID: <CAKv+Gu8MJyyCWroHrfLANZU2Rmq7Efkag+JEssWpbqrGS0cznA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 October 2016 at 14:04, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 26 October 2016 at 11:07, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Hi Ard,
>>
>> I like the concept, but ...
>>
>> Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
>>> The symbol CRCs are emitted as ELF symbols, which allows us to easily
>>> populate the kcrctab sections by relying on the linker to associate
>>> each kcrctab slot with the correct value.
>>>
>>> This has two downsides:
>>> - given that the CRCs are treated as pointers, we waste 4 bytes for
>>>   each CRC on 64 bit architectures,
>>> - on architectures that support runtime relocation, a relocation entry is
>>>   emitted for each CRC value, which may take up 24 bytes of __init space
>>>   (on ELF64 systems)
>>>
>>> This comes down to a x8 overhead in [uncompressed] kernel size. In addition,
>>> each relocation has to be reverted before the CRC value can be used.
>>>
>>> Switching to explicit 32 bit values on 64 bit architectures fixes both
>>> issues, since 32 bit values are not treated as relocatable quantities on
>>> ELF64 systems, even if the value ultimately resolves to a linker supplied
>>> value.
>>
>> Are we sure that part is true? ("not treated as relocatable")
>>
>
> Thanks for testing this.
>
>> A quick test build on powerpc gives me:
>>
>>   WARNING: 6829 bad relocations
>>   c000000000ca3748 R_PPC64_ADDR16    *ABS*+0x0000000013f53da6
>>   c000000000ca374a R_PPC64_ADDR16    *ABS*+0x00000000f7272059
>>   c000000000ca374c R_PPC64_ADDR16    *ABS*+0x0000000002013d36
>>   c000000000ca374e R_PPC64_ADDR16    *ABS*+0x00000000a59dffc8
>>   ...
>>
>> Which is coming from our relocs_check.sh script, which checks that the
>> generated relocations are ones we know how to handle.
>>
>
> OK, first of all, it appears the ppc64 assembler interprets .word
> differently than the arm64 one, so I will need to fold this in
>
> """
> diff --git a/include/linux/export.h b/include/linux/export.h
> index fa51ab2ad190..a000d421526d 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -54,7 +54,7 @@ extern struct module __this_module;
>  #define __CRC_SYMBOL(sym, sec)                                         \
>         asm("   .section \"___kcrctab" sec "+" #sym "\", \"a\"  \n"     \
>             "   .weak   " VMLINUX_SYMBOL_STR(__crc_##sym) "     \n"     \
> -           "   .word   " VMLINUX_SYMBOL_STR(__crc_##sym) "     \n"     \
> +           "   .long   " VMLINUX_SYMBOL_STR(__crc_##sym) "     \n"     \
>             "   .previous                                       \n");
>  #endif
>  #else
> """
>
> With that change, the CRCs are actually emitted as
>
> WARNING: 7525 bad relocations
> c000000000ce7f50 R_PPC64_ADDR32    *ABS*+0x0000000013f53da6
> c000000000ce7f54 R_PPC64_ADDR32    *ABS*+0x0000000004f7c64e
> c000000000ce7f58 R_PPC64_ADDR32    *ABS*+0x0000000092be8a3e
>
> which is still a bit disappointing, given that we still have 7525 RELA
> entries to process.
> I tried several thing, i.e., adding -Bsymbolic to the linker command
> line, emitting the reference above as .hidden or emit  the definition
> from the linker script as HIDDEN(), but nothing seems to make any
> difference. (On arm64, -Bsymbolic eliminates *all* runtime relocations
> except R_<arch>_RELATIVE ones)
>
>> And when I try to boot it I get:
>>
>>   virtio: disagrees about version of symbol module_layout
>>   virtio: disagrees about version of symbol module_layout
>>   scsi_mod: disagrees about version of symbol module_layout
>>
>> And it can't find my root file system (unsurprisingly as it's on scsi).
>>
>
> Something like the below should fix it, I hope.
>
> """
> diff --git a/arch/powerpc/kernel/reloc_64.S b/arch/powerpc/kernel/reloc_64.S
> index d88736fbece6..99cdf2311ab5 100644
> --- a/arch/powerpc/kernel/reloc_64.S
> +++ b/arch/powerpc/kernel/reloc_64.S
> @@ -14,6 +14,7 @@
>  RELA = 7
>  RELACOUNT = 0x6ffffff9
>  R_PPC64_RELATIVE = 22
> +R_PPC64_ADDR32 = 1
>
>  /*
>   * r3 = desired final address of kernel
> @@ -77,9 +78,22 @@ _GLOBAL(relocate)
>         add     r0,r0,r3
>         stdx    r0,r7,r6
>         addi    r9,r9,24
> -       bdnz    5b
> +       b       7f
> +
> +       /*
> +        * CRCs of exported symbols are emitted as 32-bit relocations against
> +        * the *ABS* section with the CRC value recorded in the addend.
> +        */
> +6:     cmpdi   r0,R_PPC64_ADDR32
> +       bne     7f
> +       ld      r6,0(r9)        /* reloc->r_offset */
> +       ld      r0,16(r9)       /* reloc->r_addend */
> +       stwx    r0,r7,r6
> +       addi    r9,r9,24
> +
> +7:     bdnz    5b
> +       blr
>
> -6:     blr
>
>  .balign 8
>  p_dyn: .llong  __dynamic_start - 0b
> """
>
> Note that the loop no longer terminates at the first
> non-R_PPC64_RELATIVE relocation, but that seems safer to me in any
> case. It simply stores the value of r_addend at r_offset, which is the
> correct thing to do for R_PPC64_ADDR32 relocations against the *ABS*
> section, regardless of whether we are dealing with CRCs or something
> else. Note that the comparison above will fail for R_PPC64_ADDR32
> relocations against named symbols, since we compare the entire r_info
> field and not just the type (as the comment a few lines higher up
> suggests)
>
> Also a fix for relocs_check.sh:
>
> """
> diff --git a/arch/powerpc/relocs_check.sh b/arch/powerpc/relocs_check.sh
> index ec2d5c835170..2f510fbc87da 100755
> --- a/arch/powerpc/relocs_check.sh
> +++ b/arch/powerpc/relocs_check.sh
> @@ -43,7 +43,8 @@ R_PPC_ADDR16_HA
>  R_PPC_RELATIVE
>  R_PPC_NONE' |
>         grep -E -v '\<R_PPC64_ADDR64[[:space:]]+mach_' |
> -       grep -E -v '\<R_PPC64_ADDR64[[:space:]]+__crc_'
> +       grep -E -v '\<R_PPC64_ADDR64[[:space:]]+__crc_' |
> +       grep -E -v '\<R_PPC64_ADDR32[[:space:]]+\*ABS\*'
>  )
>
>  if [ -z "$bad_relocs" ]; then
> """
>
> If these changes work for PPC, I think we should fold them in.
> Hopefully, GNU ld for PPC will gain that ability to resolve absolute
> relocations at build time (like other architectures), and then the
> R_PPC64_ADDR32 handling will simply become dead code. In any case, it
> is an improvement over the mangling of CRC values to undo the runtime
> relocation, imo.
>

I have spent some more time looking into this, and it seems impossible
to coerce the powerpc linker into resolving relocations against build
time absolute constants at build time.

Interestingly, the CONFIG_MODVERSIONS + CONFIG_RELOCATABLE issue
exists on PPC32 as well, i.e., commit 0e0ed6406e61 ("powerpc/modules:
Module CRC relocation fix causes perf issues") reintroduced it on
PPC32 by making the fix PPC64 specific.

I think the fact that relocations against *ABS* symbols are converted
into R_PPC[64]_RELATIVE relocations is a linker bug. I spotted
something similar on arm64 a while ago

https://lists.gnu.org/archive/html/bug-binutils/2016-07/msg00087.html

but this has not been fixed yet either.

Having to deal with toolchain bugs when working on issues like these
is always a bit annoying, so I wonder what your take is on the PPC32
issue. If nobody cares about CONFIG_RELOCATABLE on PPC32, perhaps it
could be made mutually exclusive with CONFIG_MODVERSIONS on 32-bit
PPC.
