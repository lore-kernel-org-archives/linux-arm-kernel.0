From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 12 May 2010 01:24:28 +0200
Subject: [PATCH 1/2] pxa/vpac270: Enable SparseMEM for 256 MB of RAM
In-Reply-To: <1272992229-29361-1-git-send-email-marek.vasut@gmail.com>
References: <1272992229-29361-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <201005120124.28864.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 4. kv?tna 2010 18:57:08 Marek Vasut napsal(a):
> This patch enables SparseMEM for the Voipac PXA270 board. To work around
> the PHYS_OFFSET being set to 0xa0000000 and disallowing us to map the
> other partition at 0x80000000, the physical-to-virtual mapping of SDRAM
> was altered and the partition at 0x80000000 was moved to 0x10000000 in
> virtual memory (past the first SDRAM partition). As the Voipac PXA270 is
> probably the only PXA270 device which utilizes 256 MB of RAM, adding the
> following code into memory.h seems much less painful than tinkering with
> PHYS_OFFSET.
> 
> NOTE: Once the PHYS_OFFSET can be dynamically configured, this code can
> probably be removed.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
>  arch/arm/mach-pxa/Kconfig               |    1 +
>  arch/arm/mach-pxa/include/mach/memory.h |   21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index 88e00db..ded9d64 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -253,6 +253,7 @@ config MACH_VPAC270
>  	bool "Voipac PXA270"
>  	select PXA27x
>  	select HAVE_PATA_PLATFORM
> +	select ARCH_SPARSEMEM_ENABLE
>  	help
>  	  PXA270 based Single Board Computer.
> 
> diff --git a/arch/arm/mach-pxa/include/mach/memory.h
> b/arch/arm/mach-pxa/include/mach/memory.h index f626730..705c7a0 100644
> --- a/arch/arm/mach-pxa/include/mach/memory.h
> +++ b/arch/arm/mach-pxa/include/mach/memory.h
> @@ -40,4 +40,25 @@ void cmx2xx_pci_adjust_zones(int node, unsigned long
> *size, #define MAX_DMA_ADDRESS		(PAGE_OFFSET + SZ_64M)
>  #endif
> 
> +/*
> + * Voipac PXA270/PXA270M is probably the only board in the world with
> PXA27x + * that uses more than 128MB or SDRAM (256MB in the 'max
> configuration'). This + * hack should be removed once the PHYS_OFFSET can
> be configured dynamically. + *
> + * The two 128MB SDRAM banks are at addresses 0xa0000000 and 0x80000000.
> The + * following code moves the block of SDRAM at 0x80000000 past the
> block at + * 0xa0000000 in virtual memory and vice versa. We use SparseMEM
> to map the + * pages properly.
> + */
> +#ifdef	CONFIG_MACH_VPAC270
> +#define	MAX_PHYSMEM_BITS	32
> +#define	SECTION_SIZE_BITS	28
> +#define	__phys_to_virt(p) \
> +	(((p) & 0x0fffffff) | \
> +	(((p) & 0x20000000) ? 0 : 0x10000000) | PAGE_OFFSET)
> +#define	__virt_to_phys(v) \
> +	(((v) & 0x0fffffff) | \
> +	(((v) & 0x10000000) ? 0x80000000 : 0xa0000000))
> +#endif
> +
>  #endif

Eric, any updates on this and the other one? Would you mind applying?
