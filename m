From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 17 Mar 2011 17:18:25 +0100
Subject: [PATCH 2/9] lpc2k: Exception vector handling
In-Reply-To: <1300377264-10843-3-git-send-email-ithamar.adema@team-embedded.nl>
References: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300377264-10843-3-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <20110317161825.GA31219@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2011 at 04:54:17PM +0100, Ithamar R. Adema wrote:
> Since the LPC2K does not have an MMU (ARM7TDMI based), it expects the vectors to be
> stored in on-chip SRAM. However, this moves the vectors too far away from the stubs
> page, requiring the vector jumps to be indirect.
> 
> Since now VECTOR_BASE is below PHYS_OFFSET, do not try to reserve the vector
> page, as it will fail (and prevent the kernel from booting).
> 
> Also, commit 247055aa (6384/1: Remove the domain switching on ARMv6k/v7 CPUs) broke
> the placement of vectors in the !MMU case, so fix this too.
> 
> Signed-off-by: Ithamar R. Adema <ithamar.adema@team-embedded.nl>
> ---
>  arch/arm/Kconfig             |    1 +
>  arch/arm/kernel/entry-armv.S |   18 ++++++++++++++++++
>  arch/arm/kernel/traps.c      |    2 +-
>  arch/arm/mm/nommu.c          |    2 ++
>  4 files changed, 22 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 331540d..9c12d71 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -186,6 +186,7 @@ config VECTORS_BASE
>  	hex
>  	default 0xffff0000 if MMU || CPU_HIGH_VECTOR
>  	default DRAM_BASE if REMAP_VECTORS_TO_RAM
> +	default 0x40000000 if ARCH_LPC2K
>  	default 0x00000000
>  	help
>  	  The base address of exception vectors.
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index e8d8856..618a971 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -1208,6 +1208,7 @@ __stubs_end:
>  
>  	.globl	__vectors_start
>  __vectors_start:
> +#ifndef CONFIG_ARCH_LPC2K
>   ARM(	swi	SYS_ERROR0	)
>   THUMB(	svc	#0		)
>   THUMB(	nop			)
> @@ -1218,6 +1219,23 @@ __vectors_start:
>  	W(b)	vector_addrexcptn + stubs_offset
>  	W(b)	vector_irq + stubs_offset
>  	W(b)	vector_fiq + stubs_offset
> +#else /* CONFIG_ARCH_LPC2K */
The description from the commit log should be repeated here.

And I wonder if this shouldn't depend on CONFIG_ARCH_LPC2K but
CONFIG_MMU.

> +	swi	SYS_ERROR0
I think arm7tdmi doesn't have thumb2, does it? If it has you need to do
ARM(swi SYS_ERROR0)
THUMB(svc ..)
...

as above

> +	ldr	pc, .vector_und
> +	ldr	pc, .vector_swi
> +	ldr	pc, .vector_pabt
> +	ldr	pc, .vector_dabt
> +	ldr	pc, .vector_addrexcptn
> +	ldr	pc, .vector_irq
> +	ldr	pc, .vector_fiq
> +.vector_und:		.word   vector_und
> +.vector_swi:		.word   vector_swi
> +.vector_pabt:		.word   vector_pabt
> +.vector_dabt:		.word   vector_dabt
> +.vector_addrexcptn:	.word   vector_addrexcptn
> +.vector_irq:		.word   vector_irq
> +.vector_fiq:		.word   vector_fiq
> +#endif
>  
>  	.globl	__vectors_end
>  __vectors_end:
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 21ac43f..639c4c8 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -758,7 +758,7 @@ static void __init kuser_get_tls_init(unsigned long vectors)
>  
>  void __init early_trap_init(void)
>  {
> -#if defined(CONFIG_CPU_USE_DOMAINS)
> +#if defined(CONFIG_CPU_USE_DOMAINS) || !defined(CONFIG_MMU)
>  	unsigned long vectors = CONFIG_VECTORS_BASE;
>  #else
>  	unsigned long vectors = (unsigned long)vectors_page;
> diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
> index 687d023..e3bec02 100644
> --- a/arch/arm/mm/nommu.c
> +++ b/arch/arm/mm/nommu.c
> @@ -24,7 +24,9 @@ void __init arm_mm_memblock_reserve(void)
>  	 * some architectures which the DRAM is the exception vector to trap,
>  	 * alloc_page breaks with error, although it is not NULL, but "0."
>  	 */
> +#if PHYS_OFFSET <= CONFIG_VECTORS_BASE
>  	memblock_reserve(CONFIG_VECTORS_BASE, PAGE_SIZE);
> +#endif
>  }
>  
>  /*
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
