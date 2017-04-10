From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 10 Apr 2017 10:39:35 -0400
Subject: [PATCH 2/2] arm64: ftrace: add support for far branches to
 dynamic ftrace
In-Reply-To: <CAKv+Gu9Y+LNomTJZi1B3vyzCSXa3-VYRtKUkpNFimDpPkD_KFw@mail.gmail.com>
References: <20170410141343.1045-1-ard.biesheuvel@linaro.org>
 <20170410141343.1045-3-ard.biesheuvel@linaro.org>
 <CAKv+Gu9Y+LNomTJZi1B3vyzCSXa3-VYRtKUkpNFimDpPkD_KFw@mail.gmail.com>
Message-ID: <20170410103935.31921d43@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Apr 2017 15:22:24 +0100
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On 10 April 2017 at 15:13, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > Currently, dynamic ftrace support in the arm64 kernel assumes that all
> > core kernel code is within range of ordinary branch instructions in
> > module code, which is usually the case, but is no longer guaranteed now
> > that we have support for module PLTs and address space randomization.
> >
> > Since all patching of branch instructions involves function calls to
> > ftrace_caller(), we can emit the modules with a trampoline that has
> > unlimited range, and patch the branch instruction to call the trampoline
> > if ftrace_caller() itself is out of range.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/arm64/Kconfig              |  2 +-
> >  arch/arm64/Makefile             |  3 ++
> >  arch/arm64/include/asm/module.h |  3 ++
> >  arch/arm64/kernel/ftrace.c      | 37 ++++++++++++++++++--
> >  arch/arm64/kernel/module-plts.c | 10 ++++++
> >  arch/arm64/lib/Makefile         |  2 ++
> >  arch/arm64/lib/ftrace-mod.S     | 25 +++++++++++++
> >  7 files changed, 78 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index e7f043efff41..31af7ea72072 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -982,7 +982,7 @@ config RANDOMIZE_BASE
> >
> >  config RANDOMIZE_MODULE_REGION_FULL
> >         bool "Randomize the module region independently from the core kernel"
> > -       depends on RANDOMIZE_BASE && !DYNAMIC_FTRACE
> > +       depends on RANDOMIZE_BASE
> >         default y
> >         help
> >           Randomizes the location of the module region without considering the
> > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > index b9a4a934ca05..01498eab5ada 100644
> > --- a/arch/arm64/Makefile
> > +++ b/arch/arm64/Makefile
> > @@ -68,6 +68,9 @@ endif
> >
> >  ifeq ($(CONFIG_ARM64_MODULE_PLTS),y)
> >  KBUILD_LDFLAGS_MODULE  += -T $(srctree)/arch/arm64/kernel/module.lds
> > +ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
> > +KBUILD_LDFLAGS_MODULE  += $(objtree)/arch/arm64/lib/ftrace-mod.o
> > +endif
> >  endif
> >
> >  # Default value
> > diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
> > index e12af6754634..2ff2b7782957 100644
> > --- a/arch/arm64/include/asm/module.h
> > +++ b/arch/arm64/include/asm/module.h
> > @@ -25,6 +25,9 @@ struct mod_arch_specific {
> >         struct elf64_shdr       *plt;
> >         int                     plt_num_entries;
> >         int                     plt_max_entries;
> > +
> > +       /* for CONFIG_DYNAMIC_FTRACE */
> > +       struct elf64_shdr       *ftrace_trampoline;
> >  };
> >  #endif
> >
> > diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> > index a8db6857cad6..8f5a7dc36c1b 100644
> > --- a/arch/arm64/kernel/ftrace.c
> > +++ b/arch/arm64/kernel/ftrace.c
> > @@ -9,11 +9,14 @@
> >   * published by the Free Software Foundation.
> >   */
> >
> > +#include <linux/elf.h>
> >  #include <linux/ftrace.h>
> > +#include <linux/module.h>
> >  #include <linux/swab.h>
> >  #include <linux/uaccess.h>
> >
> >  #include <asm/cacheflush.h>
> > +#include <asm/debug-monitors.h>
> >  #include <asm/ftrace.h>
> >  #include <asm/insn.h>
> >
> > @@ -63,6 +66,35 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
> >         return ftrace_modify_code(pc, 0, new, false);
> >  }
> >
> > +#ifdef CONFIG_ARM64_MODULE_PLTS
> > +EXPORT_SYMBOL_GPL(ftrace_caller);
> > +#endif
> > +
> > +static u32 __ftrace_gen_branch(unsigned long pc, unsigned long addr)
> > +{
> > +       long offset = (long)pc - (long)addr;
> > +       struct module *mod;
> > +
> > +       if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
> > +           addr == (unsigned long)&ftrace_caller &&
> > +           unlikely(offset < -SZ_128M || offset >= SZ_128M)) {
> > +
> > +               /*
> > +                * On kernels that support module PLTs, the offset between the
> > +                * call and its target may legally exceed the range of an
> > +                * ordinary branch instruction. In this case, we need to branch
> > +                * via a trampoline in the module.
> > +                */
> > +               mod = __module_address(pc);
> > +               if (WARN_ON(!mod))
> > +                       return AARCH64_BREAK_FAULT;
> > +
> > +               addr = (unsigned long)mod->arch.ftrace_trampoline->sh_addr;
> > +       }
> > +
> > +       return aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
> > +}
> > +
> >  /*
> >   * Turn on the call to ftrace_caller() in instrumented function
> >   */
> > @@ -72,7 +104,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
> >         u32 old, new;
> >
> >         old = aarch64_insn_gen_nop();
> > -       new = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
> > +       new = __ftrace_gen_branch(pc, addr);
> >
> >         return ftrace_modify_code(pc, old, new, true);
> >  }
> > @@ -87,8 +119,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
> >         u32 old = 0, new;
> >
> >         if (!IS_ENABLED(CONFIG_ARM64_MODULE_PLTS))
> > -               old = aarch64_insn_gen_branch_imm(pc, addr,
> > -                                                 AARCH64_INSN_BRANCH_LINK);
> > +               old = __ftrace_gen_branch(pc, addr);
> >         new = aarch64_insn_gen_nop();
> >
> >         return ftrace_modify_code(pc, old, new,
> > diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> > index 1ce90d8450ae..859c7170e69a 100644
> > --- a/arch/arm64/kernel/module-plts.c
> > +++ b/arch/arm64/kernel/module-plts.c
> > @@ -162,6 +162,10 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> >                         mod->arch.plt = sechdrs + i;
> >                 else if (sechdrs[i].sh_type == SHT_SYMTAB)
> >                         syms = (Elf64_Sym *)sechdrs[i].sh_addr;
> > +               else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
> > +                        strcmp(".text.ftrace_trampoline",
> > +                               secstrings + sechdrs[i].sh_name) == 0)
> > +                       mod->arch.ftrace_trampoline = sechdrs + i;
> >         }
> >
> >         if (!mod->arch.plt) {
> > @@ -173,6 +177,12 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> >                 return -ENOEXEC;
> >         }
> >
> > +       if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) && !mod->arch.ftrace_trampoline) {
> > +               pr_err("%s: module ftrace trampoline section missing\n",
> > +                      mod->name);
> > +               return -ENOEXEC;
> > +       }
> > +
> >         for (i = 0; i < ehdr->e_shnum; i++) {
> >                 Elf64_Rela *rels = (void *)ehdr + sechdrs[i].sh_offset;
> >                 int numrels = sechdrs[i].sh_size / sizeof(Elf64_Rela);
> > diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> > index c86b7909ef31..b01dcfa9c002 100644
> > --- a/arch/arm64/lib/Makefile
> > +++ b/arch/arm64/lib/Makefile
> > @@ -4,6 +4,8 @@ lib-y           := bitops.o clear_user.o delay.o copy_from_user.o       \
> >                    memcmp.o strcmp.o strncmp.o strlen.o strnlen.o       \
> >                    strchr.o strrchr.o
> >
> > +lib-$(CONFIG_DYNAMIC_FTRACE) += ftrace-mod.o
> > +
> >  # Tell the compiler to treat all general purpose registers (with the
> >  # exception of the IP registers, which are already handled by the caller
> >  # in case of a PLT) as callee-saved, which allows for efficient runtime
> > diff --git a/arch/arm64/lib/ftrace-mod.S b/arch/arm64/lib/ftrace-mod.S
> > new file mode 100644
> > index 000000000000..ce15b9948851
> > --- /dev/null
> > +++ b/arch/arm64/lib/ftrace-mod.S
> > @@ -0,0 +1,25 @@
> > +/*
> > + * Copyright (C) 2017 Linaro Ltd <ard.biesheuvel@linaro.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/linkage.h>
> > +#include <asm/assembler.h>
> > +
> > +       .section        ".text.ftrace_trampoline", "ax"
> > +ENTRY(__ftrace_trampoline)
> > +       stp             x29, x30, [sp, #-16]!
> > +       mov             x29, sp
> > +
> > +       movz            x30, #:abs_g3:ftrace_caller
> > +       movk            x30, #:abs_g2_nc:ftrace_caller
> > +       movk            x30, #:abs_g1_nc:ftrace_caller
> > +       movk            x30, #:abs_g0_nc:ftrace_caller
> > +       blr             x30
> > +
> > +       ldp             x29, x30, [sp], #16
> > +       ret
> > +ENDPROC(__ftrace_trampoline)  
> 
> I suppose the additional stack frame interferes with correct operation
> of ftrace() here, so we should probably do this:
> 
> ENTRY(__ftrace_trampoline)
>     movz x16, #:abs_g3:ftrace_caller
>     movk x16, #:abs_g2_nc:ftrace_caller
>     movk x16, #:abs_g1_nc:ftrace_caller
>     movk x16, #:abs_g0_nc:ftrace_caller
>     blr  x16

Then should that still be a blr or just a br?

-- Steve

> ENDPROC(__ftrace_trampoline)
> 
> instead.
