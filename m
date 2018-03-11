From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 11 Mar 2018 14:12:19 +0000
Subject: [PATCH v8 3/6] module: use relative references for __ksymtab
 entries
In-Reply-To: <20180311123815.17916-4-ard.biesheuvel@linaro.org>
References: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
 <20180311123815.17916-4-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu-TMT5bJ9V69sNK+8_aHeqz6EQ0ugTsjCPgDgfb6_=xqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 March 2018 at 12:38, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> An ordinary arm64 defconfig build has ~64 KB worth of __ksymtab
> entries, each consisting of two 64-bit fields containing absolute
> references, to the symbol itself and to a char array containing
> its name, respectively.
>
> When we build the same configuration with KASLR enabled, we end
> up with an additional ~192 KB of relocations in the .init section,
> i.e., one 24 byte entry for each absolute reference, which all need
> to be processed at boot time.
>
> Given how the struct kernel_symbol that describes each entry is
> completely local to module.c (except for the references emitted
> by EXPORT_SYMBOL() itself), we can easily modify it to contain
> two 32-bit relative references instead. This reduces the size of
> the __ksymtab section by 50% for all 64-bit architectures, and
> gets rid of the runtime relocations entirely for architectures
> implementing KASLR, either via standard PIE linking (arm64) or
> using custom host tools (x86).
>
> Note that the binary search involving __ksymtab contents relies
> on each section being sorted by symbol name. This is implemented
> based on the input section names, not the names in the ksymtab
> entries, so this patch does not interfere with that.
>
> Given that the use of place-relative relocations requires support
> both in the toolchain and in the module loader, we cannot enable
> this feature for all architectures. So make it dependent on whether
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS is defined.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Thomas Garnier <thgarnie@google.com>
> Cc: Nicolas Pitre <nico@linaro.org>
> Acked-by: Jessica Yu <jeyu@kernel.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/x86/include/asm/Kbuild   |  1 +
>  arch/x86/include/asm/export.h |  5 ---
>  include/asm-generic/export.h  | 12 ++++-
>  include/linux/compiler.h      | 19 ++++++++
>  include/linux/export.h        | 46 +++++++++++++++-----
>  kernel/module.c               | 32 +++++++++++---
>  6 files changed, 91 insertions(+), 24 deletions(-)
>
...
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index ab4711c63601..0a9328ea9dbd 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -280,6 +280,25 @@ unsigned long read_word_at_a_time(const void *addr)
>
>  #endif /* __KERNEL__ */
>
> +/*
> + * Force the compiler to emit 'sym' as a symbol, so that we can reference
> + * it from inline assembler. Necessary in case 'sym' could be inlined
> + * otherwise, or eliminated entirely due to lack of references that are
> + * visible to the compiler.
> + */
> +#define __ADDRESSABLE(sym) \
> +       static void * const __attribute__((section(".discard"), used))  \
> +               __PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
> +

kernelci.org tells me that I need to drop the 'const' here, or we may
end up with .discard sections with conflicting attributes (r/o vs r/w)
in some cases (CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y)
