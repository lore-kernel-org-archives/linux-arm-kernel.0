From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 07 Apr 2015 17:38:09 +0100
Subject: [PATCH 5/6] arm64/kexec: Add core kexec support
In-Reply-To: <88216e29d97715cecac8630bc57342d0be860235.1426793116.git.geoff@infradead.org>
References: <cover.1426793116.git.geoff@infradead.org>
 <88216e29d97715cecac8630bc57342d0be860235.1426793116.git.geoff@infradead.org>
Message-ID: <552407F1.1040909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/03/15 20:35, Geoff Levand wrote:
> Add three new files, kexec.h, machine_kexec.c and relocate_kernel.S to the
> arm64 architecture that add support for the kexec re-boot mechanism
> (CONFIG_KEXEC) on arm64 platforms.
>
> With the addition of arm64 kexec support shutdown code paths through the kernel
> are executed that previously were not.  To avoid system instability do to
> problems in the current arm64 KVM kernel implementation add a Kconfig dependency
> on !KEXEC to the arm64 KVM menu item.
>
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>   arch/arm64/Kconfig                  |   9 +++
>   arch/arm64/include/asm/kexec.h      |  48 ++++++++++++
>   arch/arm64/kernel/Makefile          |   1 +
>   arch/arm64/kernel/machine_kexec.c   | 125 ++++++++++++++++++++++++++++++
>   arch/arm64/kernel/relocate_kernel.S | 149 ++++++++++++++++++++++++++++++++++++
>   arch/arm64/kvm/Kconfig              |   1 +
>   include/uapi/linux/kexec.h          |   1 +
>   7 files changed, 334 insertions(+)
>   create mode 100644 arch/arm64/include/asm/kexec.h
>   create mode 100644 arch/arm64/kernel/machine_kexec.c
>   create mode 100644 arch/arm64/kernel/relocate_kernel.S
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1b8e973..5a606d1 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -528,6 +528,15 @@ config SECCOMP
>            and the task is only allowed to execute a few safe syscalls
>            defined by each seccomp mode.
>
> +config KEXEC
> +       depends on (!SMP || PM_SLEEP_SMP)
> +       bool "kexec system call"
> +       ---help---
> +         kexec is a system call that implements the ability to shutdown your
> +         current kernel, and to start another kernel.  It is like a reboot
> +         but it is independent of the system firmware.   And like a reboot
> +         you can start any kernel with it, not just Linux.
> +
>   config XEN_DOM0
>          def_bool y
>          depends on XEN
> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> new file mode 100644
> index 0000000..3530ff5
> --- /dev/null
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -0,0 +1,48 @@
> +/*
> + * kexec for arm64
> + *
> + * Copyright (C) Linaro.
> + * Copyright (C) Futurewei Technologies.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#if !defined(_ARM64_KEXEC_H)
> +#define _ARM64_KEXEC_H
> +
> +/* Maximum physical address we can use pages from */
> +
> +#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
> +
> +/* Maximum address we can reach in physical address mode */
> +
> +#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
> +
> +/* Maximum address we can use for the control code buffer */
> +
> +#define KEXEC_CONTROL_MEMORY_LIMIT (-1UL)
> +
> +#define KEXEC_CONTROL_PAGE_SIZE        4096
> +
> +#define KEXEC_ARCH KEXEC_ARCH_ARM64
> +
> +#if !defined(__ASSEMBLY__)
> +
> +/**
> + * crash_setup_regs() - save registers for the panic kernel
> + *
> + * @newregs: registers are saved here
> + * @oldregs: registers to be saved (may be %NULL)
> + */
> +
> +static inline void crash_setup_regs(struct pt_regs *newregs,
> +                                   struct pt_regs *oldregs)
> +{
> +       /* Empty routine needed to avoid build errors. */
> +}
> +
> +#endif /* !defined(__ASSEMBLY__) */
> +
> +#endif
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 5ee07ee..da9a7ee 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -35,6 +35,7 @@ arm64-obj-$(CONFIG_KGDB)              += kgdb.o
>   arm64-obj-$(CONFIG_EFI)                        += efi.o efi-stub.o efi-entry.o
>   arm64-obj-$(CONFIG_PCI)                        += pci.o
>   arm64-obj-$(CONFIG_ARMV8_DEPRECATED)   += armv8_deprecated.o
> +arm64-obj-$(CONFIG_KEXEC)              += machine_kexec.o relocate_kernel.o
>
>   obj-y                                  += $(arm64-obj-y) vdso/
>   obj-m                                  += $(arm64-obj-m)
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> new file mode 100644
> index 0000000..f1387d0
> --- /dev/null
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -0,0 +1,125 @@
> +/*
> + * kexec for arm64
> + *
> + * Copyright (C) Linaro.
> + * Copyright (C) Futurewei Technologies.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kexec.h>
> +#include <linux/of_fdt.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/system_misc.h>
> +
> +/* Global variables for the relocate_kernel routine. */
> +extern const unsigned char relocate_new_kernel[];
> +extern const unsigned long relocate_new_kernel_size;
> +extern unsigned long arm64_kexec_dtb_addr;
> +extern unsigned long arm64_kexec_kimage_head;
> +extern unsigned long arm64_kexec_kimage_start;
> +
> +void machine_kexec_cleanup(struct kimage *image)
> +{
> +       /* Empty routine needed to avoid build errors. */
> +}
> +
> +/**
> + * machine_kexec_prepare - Prepare for a kexec reboot.
> + *
> + * Called from the core kexec code when a kernel image is loaded.
> + */
> +int machine_kexec_prepare(struct kimage *image)
> +{
> +       arm64_kexec_kimage_start = image->start;
> +       return 0;
> +}
> +
> +/**
> + * kexec_list_flush - Helper to flush the kimage list to PoC.
> + */
> +static void kexec_list_flush(unsigned long kimage_head)
> +{
> +       void *dest;

What is the use of dest ?
> +       unsigned long *entry;
> +
> +       for (entry = &kimage_head, dest = NULL; ; entry++) {
> +               unsigned int flag = *entry &
> +                       (IND_DESTINATION | IND_INDIRECTION | IND_DONE |
> +                       IND_SOURCE);
You could instead do :

	flag = *entry & IND_FLAGS;

> +               void *addr = phys_to_virt(*entry & PAGE_MASK);
> +
> +               switch (flag) {
> +               case IND_INDIRECTION:
> +                       entry = (unsigned long *)addr - 1;
> +                       __flush_dcache_area(addr, PAGE_SIZE);
> +                       break;
> +               case IND_DESTINATION:
> +                       dest = addr;
> +                       break;
> +               case IND_SOURCE:
> +                       __flush_dcache_area(addr, PAGE_SIZE);
> +                       dest += PAGE_SIZE;
> +                       break;
> +               case IND_DONE:
> +                       return;
> +               default:
> +                       BUG();
> +               }
> +       }
> +}

Thanks
Suzuki
