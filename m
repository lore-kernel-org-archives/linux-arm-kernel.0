From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 1 Apr 2011 11:45:39 +0800
Subject: [PATCH 2/9] ARM: pxa: enable sparsemem in saarb
In-Reply-To: <1301625568-16583-2-git-send-email-haojian.zhuang@marvell.com>
References: <1301625568-16583-1-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <AANLkTimf+s7NNGc=SczGjeXNP_5VYFfALC65DZ8FSEvq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 1, 2011 at 10:39 AM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:
> Make sparsemem to support 512MB low memory with two banks in SAARB.
>
> Change-Id: I1688dde366b5f3b13b48b7167bf6b88afc4f9a92
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

The concern is that this will exclude SAARB from being built into a single
binary with other boards. Did you ever try HIGHMEM?

> ---
> ?arch/arm/mach-pxa/Kconfig ? ? ? ? ? ? ? | ? ?1 +
> ?arch/arm/mach-pxa/include/mach/memory.h | ? 36 ++++++++++++++++++++++++++++++-
> ?2 files changed, 36 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index 2fc9f94..e8615ee 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -53,6 +53,7 @@ config MACH_SAAR
> ?config MACH_SAARB
> ? ? ? ?bool "PXA955 Handheld Platform (aka SAARB)"
> ? ? ? ?select CPU_PXA955
> + ? ? ? select ARCH_SPARSEMEM_ENABLE
>
> ?comment "Third Party Dev Platforms (sorted by vendor name)"
>
> diff --git a/arch/arm/mach-pxa/include/mach/memory.h b/arch/arm/mach-pxa/include/mach/memory.h
> index 92361a6..9a3f265 100644
> --- a/arch/arm/mach-pxa/include/mach/memory.h
> +++ b/arch/arm/mach-pxa/include/mach/memory.h
> @@ -3,6 +3,7 @@
> ?*
> ?* Author: ? ? Nicolas Pitre
> ?* Copyright: ?(C) 2001 MontaVista Software Inc.
> + * Copyright: ?(C) 2010 Marvell Semiconductor Inc.
> ?*
> ?* This program is free software; you can redistribute it and/or modify
> ?* it under the terms of the GNU General Public License version 2 as
> @@ -27,4 +28,37 @@ void cmx2xx_pci_adjust_zones(unsigned long *size, unsigned long *holes);
> ?#define MAX_DMA_ADDRESS ? ? ? ? ? ? ? ?(PAGE_OFFSET + SZ_64M)
> ?#endif
>
> -#endif
> +
> +#ifdef CONFIG_SPARSEMEM
> +
> +#if defined(CONFIG_MACH_SAARB) || defined(CONFIG_MACH_SAARB_MG1)
> +/*
> + * There're two DRAM banks in PXA955 Saarb board.
> + *
> + * The macros below define sections with 256MB size and a non-linear virtual to
> + * physical mapping:
> + *
> + * node 0: 0x80000000-0x8fffffff -> 0xc0000000-0xcfffffff
> + * node 1: 0xc0000000-0xcfffffff -> 0xd0000000-0xdfffffff
> + *
> + * Since DRAM can be wrapped, 0xa0000000 equals to 0x80000000.
> + */
> +#define MAX_PHYSMEM_BITS ? ? ? 32
> +#define SECTION_SIZE_BITS ? ? ?28
> +
> +/* bank page offsets */
> +#define BANK_PAGE_OFFSET ? ? ? (PAGE_OFFSET + 0x10000000)
> +
> +#define __phys_to_virt(phys) ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> + ? ? ? ((phys) >= 0xc0000000 ? (phys) - 0xc0000000 + BANK_PAGE_OFFSET :\
> + ? ? ? ?(phys) >= 0xa0000000 ? (phys) - 0xa0000000 + PAGE_OFFSET : ? ? \
> + ? ? ? ?(phys) - 0x80000000 + PAGE_OFFSET) ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> +
> +#define __virt_to_phys(virt) ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> + ? ? ? ((virt) >= BANK_PAGE_OFFSET ? (virt) - BANK_PAGE_OFFSET + 0xc0000000 :\
> + ? ? ? ?(virt) - PAGE_OFFSET + PLAT_PHYS_OFFSET)
> +#endif /* CONFIG_MACH_SAARB || CONFIG_MACH_SAARB_MG1 */
> +
> +#endif /* CONFIG_SPARSEMEM */
> +
> +#endif /* __ASM_ARCH_MEMORY_H */
> --
> 1.5.6.5
>
>
