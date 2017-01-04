From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Wed, 4 Jan 2017 15:58:12 +0000
Subject: [PATCH v5 2/4] ARM: Define KERNEL_START and KERNEL_END
In-Reply-To: <20170104011417.1496-3-f.fainelli@gmail.com>
References: <edc8eaa2-5414-506c-1dad-f2404ef19c81@gmail.com>
 <20170104011417.1496-1-f.fainelli@gmail.com>
 <20170104011417.1496-3-f.fainelli@gmail.com>
Message-ID: <SN1PR0101MB15656D0B421E37BC4813F560D0610@SN1PR0101MB1565.prod.exchangelabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 03, 2017 6:14 PM, Florian Fainelli wrote:
>
> In preparation for adding CONFIG_DEBUG_VIRTUAL support, define a set of
> common constants: KERNEL_START and KERNEL_END which abstract
> CONFIG_XIP_KERNEL vs. !CONFIG_XIP_KERNEL. Update the code where
> relevant.
>
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/include/asm/memory.h | 7 +++++++
>  arch/arm/mm/init.c            | 7 ++-----
>  arch/arm/mm/mmu.c             | 6 +-----
>  3 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 76cbd9c674df..bee7511c5098 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -111,6 +111,13 @@
>  
>  #endif /* !CONFIG_MMU */
>  
> +#ifdef CONFIG_XIP_KERNEL
> +#define KERNEL_START		_sdata
> +#else
> +#define KERNEL_START		_stext
> +#endif
> +#define KERNEL_END		_end
> +
>  /*
>   * We fix the TCM memories max 32 KiB ITCM resp DTCM at these
>   * locations
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 370581aeb871..c87d0d5b65f2 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -230,11 +230,8 @@ phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
>  void __init arm_memblock_init(const struct machine_desc *mdesc)
>  {
>  	/* Register the kernel text, kernel data and initrd with memblock. */
> -#ifdef CONFIG_XIP_KERNEL
> -	memblock_reserve(__pa(_sdata), _end - _sdata);
> -#else
> -	memblock_reserve(__pa(_stext), _end - _stext);
> -#endif
> +	memblock_reserve(__pa(KERNEL_START), _end - KERNEL_START);

Shouldn't the '_end' above be 'KERNEL_END'?

Hartley
