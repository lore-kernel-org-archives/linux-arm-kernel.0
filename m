From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 Aug 2016 16:44:09 +0200
Subject: [PATCH v24 5/9] arm64: kdump: add kdump support
In-Reply-To: <20160809015615.28527-3-takahiro.akashi@linaro.org>
References: <20160809015248.28414-2-takahiro.akashi@linaro.org>
 <20160809015615.28527-1-takahiro.akashi@linaro.org>
 <20160809015615.28527-3-takahiro.akashi@linaro.org>
Message-ID: <CAKv+Gu9HabCP5irxZB6pKgtDCVpy23Wdu7eppMsW2++jK7Dk1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 August 2016 at 03:56, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> On crash dump kernel, all the information about primary kernel's system
> memory (core image) is available in elf core header.
> The primary kernel will set aside this header with reserve_elfcorehdr()
> at boot time and inform crash dump kernel of its location via a new
> device-tree property, "linux,elfcorehdr".
>
> Please note that all other architectures use traditional "elfcorehdr="
> kernel parameter for this purpose.
>
> Then crash dump kernel will access the primary kernel's memory with
> copy_oldmem_page(), which reads one page by ioremap'ing it since it does
> not reside in linear mapping on crash dump kernel.
>
> We also need our own elfcorehdr_read() here since the header is placed
> within crash dump kernel's usable memory.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  arch/arm64/Kconfig             | 11 +++++++
>  arch/arm64/kernel/Makefile     |  1 +
>  arch/arm64/kernel/crash_dump.c | 71 ++++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/mm/init.c           | 54 ++++++++++++++++++++++++++++++++
>  4 files changed, 137 insertions(+)
>  create mode 100644 arch/arm64/kernel/crash_dump.c
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 69c8787..9ede54b 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -682,6 +682,17 @@ config KEXEC
>           but it is independent of the system firmware.   And like a reboot
>           you can start any kernel with it, not just Linux.
>
> +config CRASH_DUMP
> +       bool "Build kdump crash kernel"
> +       help
> +         Generate crash dump after being started by kexec. This should
> +         be normally only set in special crash dump kernels which are
> +         loaded in the main kernel with kexec-tools into a specially
> +         reserved region and then later executed after a crash by
> +         kdump/kexec.
> +
> +         For more details see Documentation/kdump/kdump.txt
> +
>  config XEN_DOM0
>         def_bool y
>         depends on XEN
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 14f7b65..f1cbfc8 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -48,6 +48,7 @@ arm64-obj-$(CONFIG_RANDOMIZE_BASE)    += kaslr.o
>  arm64-obj-$(CONFIG_HIBERNATION)                += hibernate.o hibernate-asm.o
>  arm64-obj-$(CONFIG_KEXEC)              += machine_kexec.o relocate_kernel.o    \
>                                            cpu-reset.o
> +arm64-obj-$(CONFIG_CRASH_DUMP)         += crash_dump.o
>
>  obj-y                                  += $(arm64-obj-y) vdso/ probes/
>  obj-m                                  += $(arm64-obj-m)
> diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
> new file mode 100644
> index 0000000..2dc54d1
> --- /dev/null
> +++ b/arch/arm64/kernel/crash_dump.c
> @@ -0,0 +1,71 @@
> +/*
> + * Routines for doing kexec-based kdump
> + *
> + * Copyright (C) 2014 Linaro Limited
> + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/crash_dump.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <linux/memblock.h>
> +#include <linux/uaccess.h>
> +#include <asm/memory.h>
> +
> +/**
> + * copy_oldmem_page() - copy one page from old kernel memory
> + * @pfn: page frame number to be copied
> + * @buf: buffer where the copied page is placed
> + * @csize: number of bytes to copy
> + * @offset: offset in bytes into the page
> + * @userbuf: if set, @buf is in a user address space
> + *
> + * This function copies one page from old kernel memory into buffer pointed by
> + * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
> + * copied or negative error in case of failure.
> + */
> +ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
> +                        size_t csize, unsigned long offset,
> +                        int userbuf)
> +{
> +       void *vaddr;
> +
> +       if (!csize)
> +               return 0;
> +
> +       vaddr = ioremap_cache(__pfn_to_phys(pfn), PAGE_SIZE);

Could we please use memremap() here?

> +       if (!vaddr)
> +               return -ENOMEM;
> +
> +       if (userbuf) {
> +               if (copy_to_user(buf, vaddr + offset, csize)) {
> +                       iounmap(vaddr);
> +                       return -EFAULT;
> +               }
> +       } else {
> +               memcpy(buf, vaddr + offset, csize);
> +       }
> +
> +       iounmap(vaddr);

... and memunmap here?

ioremap_cache() is not very well defined, and memremap() has been
introduced specifically to replace it, so I think we should use it in
new code.

Thanks,
Ard.


> +
> +       return csize;
> +}
> +
> +/**
> + * elfcorehdr_read - read from ELF core header
> + * @buf: buffer where the data is placed
> + * @csize: number of bytes to read
> + * @ppos: address in the memory
> + *
> + * This function reads @count bytes from elf core header which exists
> + * on crash dump kernel's memory.
> + */
> +ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
> +{
> +       memcpy(buf, phys_to_virt((phys_addr_t)*ppos), count);
> +       return count;
> +}
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index e3771c4..bba1e39 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -36,6 +36,7 @@
>  #include <linux/efi.h>
>  #include <linux/swiotlb.h>
>  #include <linux/kexec.h>
> +#include <linux/crash_dump.h>
>
>  #include <asm/boot.h>
>  #include <asm/fixmap.h>
> @@ -186,6 +187,57 @@ static void __init reserve_crashkernel(void)
>  }
>  #endif /* CONFIG_KEXEC_CORE */
>
> +#ifdef CONFIG_CRASH_DUMP
> +static int __init early_init_dt_scan_elfcorehdr(unsigned long node,
> +               const char *uname, int depth, void *data)
> +{
> +       const __be32 *reg;
> +       int len;
> +
> +       if (depth != 1 || strcmp(uname, "chosen") != 0)
> +               return 0;
> +
> +       reg = of_get_flat_dt_prop(node, "linux,elfcorehdr", &len);
> +       if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
> +               return 1;
> +
> +       elfcorehdr_addr = dt_mem_next_cell(dt_root_addr_cells, &reg);
> +       elfcorehdr_size = dt_mem_next_cell(dt_root_size_cells, &reg);
> +
> +       return 1;
> +}
> +
> +/*
> + * reserve_elfcorehdr() - reserves memory for elf core header
> + *
> + * This function reserves elf core header given in "elfcorehdr=" kernel
> + * command line parameter. This region contains all the information about
> + * primary kernel's core image and is used by a dump capture kernel to
> + * access the system memory on primary kernel.
> + */
> +static void __init reserve_elfcorehdr(void)
> +{
> +       of_scan_flat_dt(early_init_dt_scan_elfcorehdr, NULL);
> +
> +       if (!elfcorehdr_size)
> +               return;
> +
> +       if (memblock_is_region_reserved(elfcorehdr_addr, elfcorehdr_size)) {
> +               pr_warn("elfcorehdr is overlapped\n");
> +               return;
> +       }
> +
> +       memblock_reserve(elfcorehdr_addr, elfcorehdr_size);
> +
> +       pr_info("Reserving %lldKB of memory at 0x%llx for elfcorehdr\n",
> +               elfcorehdr_size >> 10, elfcorehdr_addr);
> +}
> +#else
> +static void __init reserve_elfcorehdr(void)
> +{
> +       ;
> +}
> +#endif /* CONFIG_CRASH_DUMP */
>  /*
>   * Return the maximum physical address for ZONE_DMA (DMA_BIT_MASK(32)). It
>   * currently assumes that for memory starting above 4G, 32-bit devices will
> @@ -444,6 +496,8 @@ void __init arm64_memblock_init(void)
>
>         reserve_crashkernel();
>
> +       reserve_elfcorehdr();
> +
>         dma_contiguous_reserve(arm64_dma_phys_limit);
>
>         memblock_allow_resize();
> --
> 2.9.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
