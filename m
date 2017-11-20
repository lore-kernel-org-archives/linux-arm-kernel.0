From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 20 Nov 2017 14:56:06 +0000
Subject: [PATCH v2] arm64: ftrace: emit ftrace-mod.o contents through code
In-Reply-To: <20171120141259.6724-1-ard.biesheuvel@linaro.org>
References: <20171120141259.6724-1-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu9ahT66HyCLUnEXdi5q_a=Z2Y=66obNEZvmhdN-7MGoog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 November 2017 at 14:12, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> When building the arm64 kernel with both CONFIG_ARM64_MODULE_PLTS and
> CONFIG_DYNAMIC_FTRACE enabled, the ftrace-mod.o object file is built
> with the kernel and contains a trampoline that is linked into each
> module, so that modules can be loaded far away from the kernel and
> still reach the ftrace entry point in the core kernel with an ordinary
> relative branch, as is emitted by the compiler instrumentation code
> dynamic ftrace relies on.
>
> In order to be able to build out of tree modules, this object file
> needs to be included into the linux-headers or linux-devel packages,
> which is undesirable, as it makes arm64 a special case (although a
> precedent does exist for 32-bit PPC).
>
> Given that the trampoline only consists of two instructions, let's
> not bother with a source or object file for it, and simply patch in
> these instructions whenever the trampoline is being populated.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v2: populate the two trampoline instruction slots from the ftrace code so
>     there is no longer a need to have a template .o or .S in the first place
>     don't use a separate linker scripts for ftrace+PLTs
>

Actually, I will respin this to reuse the existing plt_entry code,
given that it is so similar to the ftrace trampoline.

>  arch/arm64/Makefile                   |  3 ---
>  arch/arm64/kernel/Makefile            |  3 ---
>  arch/arm64/kernel/ftrace-mod.S        | 18 ------------------
>  arch/arm64/kernel/ftrace-trampoline.h | 18 ++++++++++++++++++
>  arch/arm64/kernel/ftrace.c            | 16 ++++++++++------
>  arch/arm64/kernel/module-plts.c       | 14 ++++++++++++++
>  arch/arm64/kernel/module.lds          |  1 +
>  7 files changed, 43 insertions(+), 30 deletions(-)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index b35788c909f1..b481b4a7c011 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -83,9 +83,6 @@ endif
>
>  ifeq ($(CONFIG_ARM64_MODULE_PLTS),y)
>  KBUILD_LDFLAGS_MODULE  += -T $(srctree)/arch/arm64/kernel/module.lds
> -ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
> -KBUILD_LDFLAGS_MODULE  += $(objtree)/arch/arm64/kernel/ftrace-mod.o
> -endif
>  endif
>
>  # Default value
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 8265dd790895..067baace74a0 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -61,6 +61,3 @@ extra-y                                       += $(head-y) vmlinux.lds
>  ifeq ($(CONFIG_DEBUG_EFI),y)
>  AFLAGS_head.o += -DVMLINUX_PATH="\"$(realpath $(objtree)/vmlinux)\""
>  endif
> -
> -# will be included by each individual module but not by the core kernel itself
> -extra-$(CONFIG_DYNAMIC_FTRACE) += ftrace-mod.o
> diff --git a/arch/arm64/kernel/ftrace-mod.S b/arch/arm64/kernel/ftrace-mod.S
> deleted file mode 100644
> index 00c4025be4ff..000000000000
> --- a/arch/arm64/kernel/ftrace-mod.S
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -/*
> - * Copyright (C) 2017 Linaro Ltd <ard.biesheuvel@linaro.org>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#include <linux/linkage.h>
> -#include <asm/assembler.h>
> -
> -       .section        ".text.ftrace_trampoline", "ax"
> -       .align          3
> -0:     .quad           0
> -__ftrace_trampoline:
> -       ldr             x16, 0b
> -       br              x16
> -ENDPROC(__ftrace_trampoline)
> diff --git a/arch/arm64/kernel/ftrace-trampoline.h b/arch/arm64/kernel/ftrace-trampoline.h
> new file mode 100644
> index 000000000000..caf8434ca52a
> --- /dev/null
> +++ b/arch/arm64/kernel/ftrace-trampoline.h
> @@ -0,0 +1,18 @@
> +/*
> + * Copyright (C) 2017 Linaro Ltd. <ard.biesheuvel@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/types.h>
> +
> +#define FTRACE_TRAMPOLINE_LDR  cpu_to_le32(0x58ffffd0)
> +#define FTRACE_TRAMPOLINE_BR   cpu_to_le32(0xd61f0200)
> +
> +struct ftrace_trampoline {
> +       u64     literal;        /* 0:   .quad   0x0             */
> +       __le32  ldr;            /*      ldr     x16, 0b         */
> +       __le32  br;             /*      br      x16             */
> +};
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index c13b1fca0e5b..2198b5a48871 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -19,6 +19,8 @@
>  #include <asm/ftrace.h>
>  #include <asm/insn.h>
>
> +#include "ftrace-trampoline.h"
> +
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  /*
>   * Replace a single instruction, which may be a branch or NOP.
> @@ -76,7 +78,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>
>         if (offset < -SZ_128M || offset >= SZ_128M) {
>  #ifdef CONFIG_ARM64_MODULE_PLTS
> -               unsigned long *trampoline;
> +               struct ftrace_trampoline *trampoline;
>                 struct module *mod;
>
>                 /*
> @@ -104,22 +106,24 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>                  * is added in the future, but for now, the pr_err() below
>                  * deals with a theoretical issue only.
>                  */
> -               trampoline = (unsigned long *)mod->arch.ftrace_trampoline;
> -               if (trampoline[0] != addr) {
> -                       if (trampoline[0] != 0) {
> +               trampoline = (void *)mod->arch.ftrace_trampoline;
> +               if (trampoline->literal != addr) {
> +                       if (trampoline->literal != 0) {
>                                 pr_err("ftrace: far branches to multiple entry points unsupported inside a single module\n");
>                                 return -EINVAL;
>                         }
>
>                         /* point the trampoline to our ftrace entry point */
>                         module_disable_ro(mod);
> -                       trampoline[0] = addr;
> +                       trampoline->literal = addr;
> +                       trampoline->ldr = FTRACE_TRAMPOLINE_LDR;
> +                       trampoline->br = FTRACE_TRAMPOLINE_BR;
>                         module_enable_ro(mod, true);
>
>                         /* update trampoline before patching in the branch */
>                         smp_wmb();
>                 }
> -               addr = (unsigned long)&trampoline[1];
> +               addr = (unsigned long)&trampoline->ldr;
>  #else /* CONFIG_ARM64_MODULE_PLTS */
>                 return -EINVAL;
>  #endif /* CONFIG_ARM64_MODULE_PLTS */
> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index d05dbe658409..c8fe9c98abc4 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -11,6 +11,8 @@
>  #include <linux/module.h>
>  #include <linux/sort.h>
>
> +#include "ftrace-trampoline.h"
> +
>  struct plt_entry {
>         /*
>          * A program that conforms to the AArch64 Procedure Call Standard
> @@ -154,6 +156,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>         unsigned long core_plts = 0;
>         unsigned long init_plts = 0;
>         Elf64_Sym *syms = NULL;
> +       Elf_Shdr *tramp = NULL;
>         int i;
>
>         /*
> @@ -165,6 +168,10 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>                         mod->arch.core.plt = sechdrs + i;
>                 else if (!strcmp(secstrings + sechdrs[i].sh_name, ".init.plt"))
>                         mod->arch.init.plt = sechdrs + i;
> +               else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
> +                        !strcmp(secstrings + sechdrs[i].sh_name,
> +                                ".text.ftrace_trampoline"))
> +                       tramp = sechdrs + i;
>                 else if (sechdrs[i].sh_type == SHT_SYMTAB)
>                         syms = (Elf64_Sym *)sechdrs[i].sh_addr;
>         }
> @@ -215,5 +222,12 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>         mod->arch.init.plt_num_entries = 0;
>         mod->arch.init.plt_max_entries = init_plts;
>
> +       if (tramp) {
> +               tramp->sh_type = SHT_NOBITS;
> +               tramp->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
> +               tramp->sh_addralign = __alignof__(struct ftrace_trampoline);
> +               tramp->sh_size = sizeof(struct ftrace_trampoline);
> +       }
> +
>         return 0;
>  }
> diff --git a/arch/arm64/kernel/module.lds b/arch/arm64/kernel/module.lds
> index f7c9781a9d48..22e36a21c113 100644
> --- a/arch/arm64/kernel/module.lds
> +++ b/arch/arm64/kernel/module.lds
> @@ -1,4 +1,5 @@
>  SECTIONS {
>         .plt (NOLOAD) : { BYTE(0) }
>         .init.plt (NOLOAD) : { BYTE(0) }
> +       .text.ftrace_trampoline (NOLOAD) : { BYTE(0) }
>  }
> --
> 2.11.0
>
