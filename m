From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Jun 2017 18:15:35 +0100
Subject: [PATCH v2 2/2] arm64: ftrace: add support for far branches to
 dynamic ftrace
In-Reply-To: <20170530135220.20759-3-ard.biesheuvel@linaro.org>
References: <20170530135220.20759-1-ard.biesheuvel@linaro.org>
 <20170530135220.20759-3-ard.biesheuvel@linaro.org>
Message-ID: <20170605171535.GP21944@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

Thanks for posting this.

On Tue, May 30, 2017 at 01:52:20PM +0000, Ard Biesheuvel wrote:
> Currently, dynamic ftrace support in the arm64 kernel assumes that all
> core kernel code is within range of ordinary branch instructions in that
> occur in module code, which is usually the case, but is no longer guaranteed
> now that we have support for module PLTs and address space randomization.
> 
> Since on arm64, all patching of branch instructions involves function calls
> to the same entry point [ftrace_caller()], we can emit the modules with a
> trampoline that has unlimited range, and patch both the trampoline itself
> and the branch instruction to redirect the call via the trampoline.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

--->8

> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 1dcb69d3d0e5..f2b4e816b6de 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -62,3 +62,6 @@ extra-y					+= $(head-y) vmlinux.lds
>  ifeq ($(CONFIG_DEBUG_EFI),y)
>  AFLAGS_head.o += -DVMLINUX_PATH="\"$(realpath $(objtree)/vmlinux)\""
>  endif
> +
> +# will be included by each individual module but not by the core kernel itself
> +extra-$(CONFIG_DYNAMIC_FTRACE) += ftrace-mod.o
> diff --git a/arch/arm64/kernel/ftrace-mod.S b/arch/arm64/kernel/ftrace-mod.S
> new file mode 100644
> index 000000000000..00c4025be4ff
> --- /dev/null
> +++ b/arch/arm64/kernel/ftrace-mod.S
> @@ -0,0 +1,18 @@
> +/*
> + * Copyright (C) 2017 Linaro Ltd <ard.biesheuvel@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/assembler.h>
> +
> +	.section	".text.ftrace_trampoline", "ax"
> +	.align		3
> +0:	.quad		0
> +__ftrace_trampoline:
> +	ldr		x16, 0b
> +	br		x16

[...]

> +static u32 __ftrace_gen_branch(unsigned long pc, unsigned long addr)
> +{
> +	long offset = (long)pc - (long)addr;
> +	unsigned long *tramp;
> +	struct module *mod;
> +
> +	if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
> +	    (offset < -SZ_128M || offset >= SZ_128M)) {
> +
> +		/*
> +		 * On kernels that support module PLTs, the offset between the
> +		 * call and its target may legally exceed the range of an
> +		 * ordinary branch instruction. In this case, we need to branch
> +		 * via a trampoline in the module.
> +		 */
> +		mod = __module_address(pc);
> +		if (WARN_ON(!mod))
> +			return AARCH64_BREAK_FAULT;
> +
> +		/*
> +		 * There is only one ftrace trampoline per module. For now,
> +		 * this is not a problem since on arm64, all dynamic ftrace
> +		 * invocations are routed via ftrace_caller(). This will need
> +		 * to be revisited if support for multiple ftrace entry points
> +		 * is added in the future, but for now, the pr_err() below
> +		 * deals with a theoretical issue only.
> +		 */
> +		tramp = (unsigned long *)mod->arch.ftrace_trampoline->sh_addr;
> +		if (tramp[0] != addr) {
> +			if (tramp[0] != 0) {
> +				pr_err("ftrace: far branches to multiple entry points unsupported inside a single module\n");
> +				return AARCH64_BREAK_FAULT;
> +			}
> +
> +			/* point the trampoline to our ftrace entry point */
> +			module_disable_ro(mod);
> +			tramp[0] = addr;
> +			module_enable_ro(mod, true);

I'm not sure what the barrier semantics are for module_enable_ro, but I'd be
inclined to stick in a smp_wmb() here to order the write of the trampoline
data before the writing of the branch instruction.

Will

> +		}
> +		addr = (unsigned long)&tramp[1];
> +	}
> +	return aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
> +}
> +
