From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Jul 2014 01:06:22 +0100
Subject: [PATCH v2 2/3] ARM: remove remaining definitions of
 PLAT_PHYS_OFFSET from <mach/memory.h>
In-Reply-To: <1404717185-10010-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1404295043-6661-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <1404717185-10010-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20140725000621.GO21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 09:13:05AM +0200, Uwe Kleine-K?nig wrote:
> The platforms selecting NEED_MACH_MEMORY_H defined the start address of
> their physical memory in the respective <mach/memory.h>. With
> ARM_PATCH_PHYS_VIRT=y (which is quite common today) this is useless
> though because the definition isn't used but determined dynamically.
> 
> So remove the definitions from all <mach/memory.h> and provide the
> Kconfig symbol PHYS_OFFSET with the respective defaults in case
> ARM_PATCH_PHYS_VIRT isn't enabled.
> 
> This allows to drop the dependency of PHYS_OFFSET on !NEED_MACH_MEMORY_H
> which prevents compiling an integrator nommu-kernel.
> (CONFIG_PAGE_OFFSET which has "default PHYS_OFFSET if !MMU" expanded to
> "0x" because CONFIG_PHYS_OFFSET doesn't exist as INTEGRATOR selects
> NEED_MACH_MEMORY_H.)

Should I assume that this hasn't been build tested?

> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 2b751464d6ff..04ccf1c0a1af 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -150,13 +150,11 @@
>  
>  /*
>   * PLAT_PHYS_OFFSET is the offset (from zero) of the start of physical
> - * memory.  This is used for XIP and NoMMU kernels, or by kernels which
> - * have their own mach/memory.h.  Assembly code must always use
> + * memory.  This is used for XIP and NoMMU kernels, and on platforms that don't
> + * have CONFIG_ARM_PATCH_PHYS_VIRT. Assembly code must always use
>   * PLAT_PHYS_OFFSET and not PHYS_OFFSET.
>   */
> -#ifndef PLAT_PHYS_OFFSET
>  #define PLAT_PHYS_OFFSET	UL(CONFIG_PHYS_OFFSET)
> -#endif

So when CONFIG_PHYS_OFFSET is not defined, PLAT_PHYS_OFFSET becomes the
identifier "CONFIG_PHYS_OFFSETUL" here.

This leads our first error:

arch/arm/include/asm/memory.h:157:29: error: 'CONFIG_PHYS_OFFSETUL' undeclared (first use in this function)

> diff --git a/arch/arm/mach-realview/include/mach/memory.h b/arch/arm/mach-realview/include/mach/memory.h
> index db09170e3832..eb69feb3b804 100644
> --- a/arch/arm/mach-realview/include/mach/memory.h
> +++ b/arch/arm/mach-realview/include/mach/memory.h
> @@ -21,17 +21,6 @@
>  #define __ASM_ARCH_MEMORY_H
>  
>  /*
> - * Physical DRAM offset.
> - */
> -#ifdef CONFIG_REALVIEW_HIGH_PHYS_OFFSET
> -#define PLAT_PHYS_OFFSET		UL(0x70000000)
> -#else
> -#define PLAT_PHYS_OFFSET		UL(0x00000000)
> -#endif
> -
> -#ifdef CONFIG_SPARSEMEM
> -
> -/*
>   * Sparsemem definitions for RealView PBX.
>   *
>   * The RealView PBX board has another block of 512MB of RAM at 0x20000000,

This bit of the patch is obviously bollocks - you're removing the
#ifdef CONFIG_SPARSEMEM but its balancing #endif remains.

This gives us our second error:

arch/arm/mach-realview/include/mach/memory.h:62:2: error: #endif without #if

Olof's kbuilder found these, and I expect mine will find them in a bit
over an hours time, followed by the zero day stuff when it hits
linux-next (probably tomorrow.)

Submitting not very well tested patches now generates /lots/ of automated
build systems to find their errors.  Don't do it. :)

(Hint: try building realview_defconfig and realview-smp_defconfig.)

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
