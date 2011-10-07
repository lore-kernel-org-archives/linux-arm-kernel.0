From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Oct 2011 11:16:21 -0700
Subject: [PATCH 1/4] ARM: Add __arm_ioremap_exec for mapping external
	memory as MT_MEMORY
In-Reply-To: <4E8F395B.9070203@ti.com>
References: <20111005004339.26980.31149.stgit@kaulin.local>
	<20111005004539.26980.52409.stgit@kaulin.local>
	<alpine.LFD.2.02.1110042059110.9106@xanadu.home>
	<20111005220619.GC6324@atomide.com> <4E8E9EE8.8010106@ti.com>
	<20111007144349.GE6324@atomide.com> <4E8F14A6.5050402@ti.com>
	<20111007151116.GI6324@atomide.com> <4E8F395B.9070203@ti.com>
Message-ID: <20111007181621.GJ6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [111007 10:05]:
> 
> I initially tried some thing similar but the issue was GP and
> HS devices. SRAM_PA isn't same on GP and EMU device and hence
> did that dynamically. One way is I can make GP and HS
> device SRAM_PA same for OMAP4 (Will loose 16 KB of
> SRAM on OMAP4 GP). It's ok to loose that 16 KB SRAM
> for OMAP4 with errata enabled.

Oh yeah, the beginning is different too, I forgot that.
 
> Below change works on both GP and HS device
> If you are OK with it, I can update errata patch accordingly.

OK to me to loose 16KB when the errata is enabled. That can
be fixed later on for example by passing the SRAM area from
device tree.

I assume now you can add the mapping to io.c instead? If so,
then it's easier to apply the patches whatever way makes more
sense.

Regards,

Tony
 
> diff --git a/arch/arm/plat-omap/include/plat/sram.h
> b/arch/arm/plat-omap/include/plat/sram.h
> index f500fc3..111b1a8 100644
> --- a/arch/arm/plat-omap/include/plat/sram.h
> +++ b/arch/arm/plat-omap/include/plat/sram.h
> @@ -95,6 +95,11 @@ static inline void omap_push_sram_idle(void) {}
>   */
>  #define OMAP2_SRAM_PA		0x40200000
>  #define OMAP3_SRAM_PA           0x40200000
> +#ifdef CONFIG_OMAP4_ERRATA_I688
> +#define OMAP4_SRAM_PA		0x40304000
> +#else
>  #define OMAP4_SRAM_PA		0x40300000
> +#endif
> +#define OMAP4_SRAM_VA		0xfe404000
> 
>  #endif
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index 363c91e..cdd303f 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -48,9 +48,13 @@
>  #define OMAP3_SRAM_VA           0xfe400000
>  #define OMAP3_SRAM_PUB_PA       (OMAP3_SRAM_PA + 0x8000)
>  #define OMAP3_SRAM_PUB_VA       (OMAP3_SRAM_VA + 0x8000)
> -#define OMAP4_SRAM_VA		0xfe400000
> +#ifdef CONFIG_OMAP4_ERRATA_I688
> +#define OMAP4_SRAM_PUB_PA	OMAP4_SRAM_PA
> +#define OMAP4_SRAM_PUB_VA	OMAP4_SRAM_VA
> +#else
>  #define OMAP4_SRAM_PUB_PA	(OMAP4_SRAM_PA + 0x4000)
>  #define OMAP4_SRAM_PUB_VA	(OMAP4_SRAM_VA + 0x4000)
> +#endif
> 
>  #if defined(CONFIG_ARCH_OMAP2PLUS)
>  #define SRAM_BOOTLOADER_SZ	0x00
> @@ -203,6 +207,11 @@ static void __init omap_map_sram(void)
>  	if (omap_sram_size == 0)
>  		return;
> 
> +#ifdef CONFIG_OMAP4_ERRATA_I688
> +		omap_sram_base += PAGE_SIZE;
> +		omap_sram_start += PAGE_SIZE;
> +		omap_sram_size -= SZ_16K;
> +#endif
>  	if (cpu_is_omap34xx()) {
>  		/*
>  		 * SRAM must be marked as non-cached on OMAP3 since the
> 
> Regards
> Santosh
