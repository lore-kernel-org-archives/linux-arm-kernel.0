From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 May 2011 18:21:38 +0100
Subject: [PATCH 2/2] ARM: use ARM_DMA_ZONE_SIZE to adjust the zone sizes
In-Reply-To: <E1QKCEB-0007Ns-AN@rmk-PC.arm.linux.org.uk>
References: <20110511162450.GF5315@n2100.arm.linux.org.uk>
	<E1QKCEB-0007Ns-AN@rmk-PC.arm.linux.org.uk>
Message-ID: <1305134498.10103.123.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-05-11 at 17:25 +0100, Russell King - ARM Linux wrote:
> Rather than each platform providing its own function to adjust the
> zone sizes, use the new ARM_DMA_ZONE_SIZE definition to perform this
> adjustment.  This ensures that the actual DMA zone size and the
> ISA_DMA_THRESHOLD/MAX_DMA_ADDRESS definitions are consistent with
> each other, and moves this complexity out of the platform code.
...
> diff --git a/arch/arm/mach-realview/include/mach/memory.h b/arch/arm/mach-realview/include/mach/memory.h
> index 973428d..1759fa6 100644
> --- a/arch/arm/mach-realview/include/mach/memory.h
> +++ b/arch/arm/mach-realview/include/mach/memory.h
> @@ -29,11 +29,7 @@
>  #define PLAT_PHYS_OFFSET               UL(0x00000000)
>  #endif
> 
> -#if !defined(__ASSEMBLY__) && defined(CONFIG_ZONE_DMA)
> -extern void realview_adjust_zones(unsigned long *size, unsigned long *hole);
> -#define arch_adjust_zones(size, hole) \
> -       realview_adjust_zones(size, hole)
> -
> +#ifdef CONFIG_ZONE_DMA
>  #define ARM_DMA_ZONE_SIZE      SZ_256M
>  #endif

We only use ZONE_DMA for PBX and realview_adjust_zones() does this
check. We end up with limiting the DMA zone to 256MB on all RealView
platforms if we compile a single kernel image that includes PBX. Not a
big problem though:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
