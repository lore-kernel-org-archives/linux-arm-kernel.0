From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 17 Oct 2016 17:26:19 +0100
Subject: [PATCH] modversions: treat symbol CRCs as 32 bit quantities on 64
 bit archs
In-Reply-To: <1476522968-20156-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1476522968-20156-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu_mD7g1UepqM=iRvrn8BYCdOF_61y4kR9p+omNs2jF8qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 October 2016 at 10:16, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> The symbol CRCs are emitted as ELF symbols, which allows us to easily
> populate the kcrctab sections by relying on the linker to associate
> each kcrctab slot with the correct value.
>
> This has two downsides:
> - given that the CRCs are treated as pointers, we waste 4 bytes for
>   each CRC on 64 bit architectures,
> - on architectures that support runtime relocation, a relocation entry is
>   emitted for each CRC value, which may take up 24 bytes of __init space
>   (on ELF64 systems)
>
> This comes down to a x8 overhead in [uncompressed] kernel size. In addition,
> each relocation has to be reverted before the CRC value can be used, which
> has resulted in an ugly workaround involving ARCH_RELOCATES_KCRCTAB, and an
> even uglier workaround around the workaround involving the "TOC." symbol on
> PPC64. This patch gets rid of all of that.
>
> So switch to explicit 32 bit values on 64 bit architectures. This fixes
> both issues, given that 32 bit values are not treated as runtime relocatable
> quantities on ELF64 systems, even if they ultimately resolve to linker
> supplied values. Also note that the only two architectures affected by the
> runtime relocation issue are PPC and arm64, both of which rely on the
> toolchain's PIE routines to create a runtime relocatable vmlinux. While x86
> also implements CONFIG_RELOCATABLE, it relies on its own build tools, which
> disregard kcrctab entries explicitly.
>
> So redefine all CRC fields and variables as u32, and redefine the
> __CRC_SYMBOL() macro for 64 bit builds to emit the CRC reference using
> inline assembler (which is necessary since 64-bit C code cannot use
> 32-bit types to hold memory addresses, even if they are ultimately
> resolved using values that do no exceed 0xffffffff).
>
> Also remove the special handling for PPC64, this should no longer be
> required.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>
> I received some feedback on draft versions of this patch from the kbuild
> test robot, but none of it regarding the inline asm in this patch.
> Hopefully, that means it works on all 64 bit architectures we support,
> but I have not been able to test that exhaustively myself.
>
> On an arm64 defconfig build with CONFIG_RELOCATABLE=y, this patch reduces
> the CRC footprint by 24 KB for .rodata, and by 217 KB for .init
>
> Before:
>   [ 9] __kcrctab         PROGBITS         ffff000008b992a8  00b292a8
>        0000000000009440  0000000000000000   A       0     0     8
>   [10] __kcrctab_gpl     PROGBITS         ffff000008ba26e8  00b326e8
>        0000000000008d40  0000000000000000   A       0     0     8
>   ...
>   [22] .rela             RELA             ffff000008c96e20  00c26e20
>        00000000001cc758  0000000000000018   A       0     0     8
>
> After:
>   [ 9] __kcrctab         PROGBITS         ffff000008b728a8  00b028a8
>        0000000000004a20  0000000000000000   A       0     0     1
>   [10] __kcrctab_gpl     PROGBITS         ffff000008b772c8  00b072c8
>        00000000000046a0  0000000000000000   A       0     0     1
>   ...
>   [22] .rela             RELA             ffff000008c66e20  00bf6e20
>        00000000001962d8  0000000000000018   A       0     0     8
>
>  arch/powerpc/include/asm/module.h |  4 --
>  arch/powerpc/kernel/module_64.c   |  8 ----
>  include/linux/export.h            |  8 ++++
>  include/linux/module.h            | 16 ++++----
>  kernel/module.c                   | 39 +++++++-------------
>  5 files changed, 30 insertions(+), 45 deletions(-)
>

[...]
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 0c3207d26ac0..a51b70fcbc6b 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -33,7 +33,7 @@
>  #define MODULE_NAME_LEN MAX_PARAM_PREFIX_LEN
>
>  struct modversion_info {
> -       unsigned long crc;
> +       u32 crc;

This hunk breaks depmod, and potentially other userland tools, given
that it modifies the layout of the __versions section.

Simply reverting this hunk (and fixing up a format string below) seems
to fix this, so I will send a v2 that incorporates that.

-- 
Ard.
