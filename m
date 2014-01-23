From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 Jan 2014 11:24:05 +0000
Subject: [PATCH 6/6] arm64: add EFI runtime services
In-Reply-To: <1389392950-22457-7-git-send-email-msalter@redhat.com>
References: <1389392950-22457-1-git-send-email-msalter@redhat.com>
 <1389392950-22457-7-git-send-email-msalter@redhat.com>
Message-ID: <20140123112405.GC27520@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 10:29:10PM +0000, Mark Salter wrote:
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> new file mode 100644
> index 0000000..a835b2c
> --- /dev/null
> +++ b/arch/arm64/include/asm/efi.h
> @@ -0,0 +1,12 @@
> +#ifndef _ASM_ARM64_EFI_H
> +#define _ASM_ARM64_EFI_H

__ASM_EFI_H please for consistency with the other files.

> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> new file mode 100644
> index 0000000..a42dc38
> --- /dev/null
> +++ b/arch/arm64/kernel/efi.c
> @@ -0,0 +1,353 @@
> +/*
> + * Extensible Firmware Interface
> + *
> + * Based on Extensible Firmware Interface Specification version 2.4
> + *
> + * Copyright (C) 2013 Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/efi.h>
> +#include <linux/export.h>
> +#include <linux/memblock.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/efi.h>
> +#include <asm/tlbflush.h>
> +#include <asm/mmu_context.h>
> +
> +struct efi_memory_map memmap;

Is this variable used outside this file or from common code? It has a
too generic name, may clash with other things.

> +static unsigned long arm_efi_facility;

You could drop the "arm_" prefix here, that's just local to this file.

> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 5516f54..7a45095 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -41,6 +41,7 @@
>  #include <linux/memblock.h>
>  #include <linux/of_fdt.h>
>  #include <linux/of_platform.h>
> +#include <linux/efi.h>
>
>  #include <asm/fixmap.h>
>  #include <asm/cputype.h>
> @@ -55,6 +56,7 @@
>  #include <asm/traps.h>
>  #include <asm/memblock.h>
>  #include <asm/psci.h>
> +#include <asm/efi.h>
>
>  unsigned int processor_id;
>  EXPORT_SYMBOL(processor_id);
> @@ -229,9 +231,13 @@ void __init setup_arch(char **cmdline_p)
>
>         arm64_memblock_init();
>
> +       efi_init();
>         paging_init();
>         request_standard_resources();
>
> +       if (efi_enabled(EFI_BOOT))
> +               efi_enter_virtual_mode();

The common start_kernel() function already has this call:

#ifdef CONFIG_X86
	if (efi_enabled(EFI_RUNTIME_SERVICES))
		efi_enter_virtual_mode();
#endif

Could we not use it for arm64 as well? Ideally with an empty
efi_enter_virtual_mode() in include/linux/efi.h if !CONFIG_EFI but I
noticed that ia64 does a separate call and they don't seem to have
efi_enabled(), so probably not feasible for them.

--
Catalin
