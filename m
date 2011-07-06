From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 6 Jul 2011 14:38:35 +0800
Subject: [PATCH 01/37] ARM: prepare for removal of a bunch of
	<mach/memory.h> files
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <CAGsJ_4yLmvjYkOavbBXXAFNavstsqQqwTJ-fkGni19vAoKRL_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/6 Nicolas Pitre <nicolas.pitre@linaro.org>:
> When the CONFIG_NO_MACH_MEMORY_H symbol is selected by a particular
> machine class, the machine specific memory.h include file is no longer
> used and can be removed. ?In that case the equivalent information can
> be obtained dynamically at runtime by enabling CONFIG_ARM_PATCH_PHYS_VIRT
> or by specifying the physical memory address at kernel configuration time.
>
> If/when all instances of mach/memory.h are removed then this symbol could
> be removed.

guess the main reason for this is that physical memory address should
not be hard-coded in kernel. and it will cause issues while crossing
platforms/boards.
i noticed PLAT_PHYS_OFFSET is referred much early in head.S with
CONFIG_XIP_KERNEL.

#ifndef CONFIG_XIP_KERNEL
        adr     r3, 2f
        ldmia   r3, {r4, r8}
        sub     r4, r3, r4                      @ (PHYS_OFFSET - PAGE_OFFSET)
        add     r8, r8, r4                      @ PHYS_OFFSET
#else
        ldr     r8, =PLAT_PHYS_OFFSET
#endif


>
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> ---
> ?arch/arm/Kconfig ? ? ? ? ? ? ?| ? 15 ++++++++++++++-
> ?arch/arm/include/asm/memory.h | ? ?6 +++++-
> ?2 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9adc278..9fc052c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -191,11 +191,17 @@ config VECTORS_BASE
> ? ? ? ?help
> ? ? ? ? ?The base address of exception vectors.
>
> +config NO_MACH_MEMORY_H
> + ? ? ? bool
> + ? ? ? help
> + ? ? ? ? Select this when mach/memory.h is removed.
> +
> ?config ARM_PATCH_PHYS_VIRT
> ? ? ? ?bool "Patch physical to virtual translations at runtime (EXPERIMENTAL)"
> - ? ? ? depends on EXPERIMENTAL
> + ? ? ? depends on EXPERIMENTAL || NO_MACH_MEMORY_H
> ? ? ? ?depends on !XIP_KERNEL && MMU
> ? ? ? ?depends on !ARCH_REALVIEW || !SPARSEMEM
> + ? ? ? default y if NO_MACH_MEMORY_H
> ? ? ? ?help
> ? ? ? ? ?Patch phys-to-virt and virt-to-phys translation functions at
> ? ? ? ? ?boot and module load time according to the position of the
> @@ -213,6 +219,13 @@ config ARM_PATCH_PHYS_VIRT_16BIT
> ? ? ? ? ?to allow physical memory down to a theoretical minimum of 64K
> ? ? ? ? ?boundaries.
>
> +config PHYS_OFFSET
> + ? ? ? hex "Physical address of main memory"
> + ? ? ? depends on !ARM_PATCH_PHYS_VIRT && NO_MACH_MEMORY_H
> + ? ? ? help
> + ? ? ? ? Please provide the physical address corresponding to the
> + ? ? ? ? location of main memory in your system.
> +
> ?source "init/Kconfig"
>
> ?source "kernel/Kconfig.freezer"
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index deb2eaa..2d21414 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -16,7 +16,6 @@
> ?#include <linux/compiler.h>
> ?#include <linux/const.h>
> ?#include <linux/types.h>
> -#include <mach/memory.h>
> ?#include <asm/sizes.h>
>
> ?/*
> @@ -200,8 +199,13 @@ static inline unsigned long __phys_to_virt(unsigned long x)
> ?#endif
>
> ?#ifndef PHYS_OFFSET
> +#ifdef CONFIG_NO_MACH_MEMORY_H
> +#define PHYS_OFFSET ? ?UL(CONFIG_PHYS_OFFSET)
> +#else
> +#include <mach/memory.h>
> ?#define PHYS_OFFSET ? ?PLAT_PHYS_OFFSET
> ?#endif
> +#endif
>
> ?/*
> ?* The DMA mask corresponding to the maximum bus address allocatable
> --
> 1.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
