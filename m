From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Mar 2017 19:18:53 +0100
Subject: [PATCH] arm64: relocation testing module
In-Reply-To: <20170323181841.6800-1-ard.biesheuvel@linaro.org>
References: <20170323181841.6800-1-ard.biesheuvel@linaro.org>
Message-ID: <20170330181853.GF14608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Thu, Mar 23, 2017 at 06:18:41PM +0000, Ard Biesheuvel wrote:
> This module tests the module loader's ELF relocation processing
> routines. When loaded, it logs output like below.
> 
>     Relocation test:
>     -------------------------------------------------------
>     R_AARCH64_ABS64                 0xffff880000cccccc pass
>     R_AARCH64_ABS32                 0x00000000f800cccc pass
>     R_AARCH64_ABS16                 0x000000000000f8cc pass
>     R_AARCH64_MOVW_SABS_Gn          0xffff880000cccccc pass
>     R_AARCH64_MOVW_UABS_Gn          0xffff880000cccccc pass
>     R_AARCH64_ADR_PREL_LO21         0xffffff9cf4d1a400 pass
>     R_AARCH64_PREL64                0xffffff9cf4d1a400 pass
>     R_AARCH64_PREL32                0xffffff9cf4d1a400 pass
>     R_AARCH64_PREL16                0xffffff9cf4d1a400 pass
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/Kconfig.debug            |  4 ++
>  arch/arm64/kernel/Makefile          |  2 +
>  arch/arm64/kernel/reloc_test_core.c | 79 +++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/reloc_test_syms.S | 83 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 168 insertions(+)
>  create mode 100644 arch/arm64/kernel/reloc_test_core.c
>  create mode 100644 arch/arm64/kernel/reloc_test_syms.S

Thanks for posting this, I really like it. Just a couple of things:

> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
> index b661fe742615..5b0c07cbe766 100644
> --- a/arch/arm64/Kconfig.debug
> +++ b/arch/arm64/Kconfig.debug
> @@ -62,6 +62,10 @@ config DEBUG_ALIGN_RODATA
>  
>  	  If in doubt, say N.
>  
> +config ARM64_RELOC_TEST
> +	depends on m
> +	tristate "Relocation testing module"
> +

There's a trivial conflict with for-next/core here (just an FYI for
Catalin).

>  source "drivers/hwtracing/coresight/Kconfig"
>  
>  endmenu
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 7d66bbaafc0c..38d67a5db973 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -50,6 +50,8 @@ arm64-obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
>  arm64-obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
>  arm64-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o	\
>  					   cpu-reset.o
> +arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
> +arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
>  
>  obj-y					+= $(arm64-obj-y) vdso/ probes/
>  obj-m					+= $(arm64-obj-m)
> diff --git a/arch/arm64/kernel/reloc_test_core.c b/arch/arm64/kernel/reloc_test_core.c
> new file mode 100644
> index 000000000000..22d84fdb6d98
> --- /dev/null
> +++ b/arch/arm64/kernel/reloc_test_core.c
> @@ -0,0 +1,79 @@
> +/*
> + * Copyright (C) 2016 Linaro Ltd;  <ard.biesheuvel@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */

Could you then add a MODULE_LICENSE entry, please? Without it, loading
the test taints the kernel:

  arm64_reloc_test: module license 'unspecified' taints kernel.

With that:

  Acked-by: Will Deacon <will.deacon@arm.com>

Thanks,

Will
