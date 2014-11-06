From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 06 Nov 2014 12:53:42 +0100
Subject: [PATCH v3/resend] ARM: shmobile: Add early debugging support
 using SCIF(A)
In-Reply-To: <1415273910-32356-1-git-send-email-geert+renesas@glider.be>
References: <1415273910-32356-1-git-send-email-geert+renesas@glider.be>
Message-ID: <3499638.LG41cHl0JS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 November 2014 12:38:30 Geert Uytterhoeven wrote:
> Add serial port debug macros for the SCIF(A) serial ports.
> This includes all shmobile SoCs, except for EMEV2.
> 
> The configuration logic (both Kconfig and #ifdef) is more complicated than
> one would expect, for several reasons:
>   1. Not all SoCs have the same serial ports, and they're not always at
>      the same addresses.
>   2. There are two different types: SCIF and SCIFA. Fortunately they can
>      easily be distinguished by physical address.
>   3. Not all boards use the same serial port for the console.
>      The defaults correspond to the boards that are supported in
>      mainline. If you want to use a different serial port, just change
>      the value of CONFIG_DEBUG_UART_PHYS, and the rest will auto-adapt.
>   4. On SoCs using the legacy machine_desc.map_io(), an identity mapping
>      of the SCIF(A) registers must be set up in .map_io(). On all but
>      r8a7779 this was already done.
>      On other SoCs, debug_ll_io_init() maps the SCIF(A) registers to a
>      fixed virtual address. 0xfdxxxxxx was chosen, as it should lie below
>      VMALLOC_END = 0xff000000, and must not conflict with the 2 MiB
>      reserved region at PCI_IO_VIRT_BASE = 0xfee00000.
>      Once all SoCs have migrated away from machine_desc.map_io(), more
>      consolidation of DEBUG_<SoC>_<PORT> can be done.
> 
> This was derived from the r8a7790 version by Laurent Pinchart.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I don't object to this patch going in, but have you looked at doing
just earlycon instead? We are still missing some fixmap changes
before that works on arm32, but in general, early looks nicer than
debug_ll because it doesn't require you to build for a particular
machine, with the downside that it's not available as early during
boot.


> @@ -1039,6 +1047,54 @@ config DEBUG_STI_UART
>  	bool
>  	depends on ARCH_STI
>  
> +choice
> +	prompt "Renesas SCIF(A) debugging SoC/port"
> +	depends on DEBUG_RENESAS_SCIF
> +	help
> +	  Choose SoC and SCIF(A) debug port combination from the list below.
> +
> +	  The kernel will most probably only work on the selected SoC.
> +	  The selected debug port will be used to provide the default SCIF(A)
> +	  physical address; the actual address can still be overridden using
> +	  the DEBUG_UART_PHYS option, if needed.

We used to have multi-level choice statements here, but Russell removed
them all in cce278d2034 ("ARM: debug: clean up low level kernel debugging
selection"). Please follow the same style.

> diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
> index d08e75cceaab3ead..b31032294f478c91 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7779.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
> @@ -62,6 +62,15 @@ static struct map_desc r8a7779_io_desc[] __initdata = {
>  		.length		= SZ_16M,
>  		.type		= MT_DEVICE_NONSHARED
>  	},
> +#ifdef CONFIG_DEBUG_R8A7779_SCIF2
> +	/* 64K entity map for 0xffe40000 (SCIF) */

s/entity/identity/ ?

> +	{
> +		.virtual	= 0xffe40000,
> +		.pfn		= __phys_to_pfn(0xffe40000),
> +		.length		= SZ_64K,
> +		.type		= MT_DEVICE_NONSHARED
> +	},
> +#endif /* CONFIG_DEBUG_R8A7779_SCIF2 */
>  };

This should be done automatically if you call debug_ll_io_init() or
have an empty map_io() callback.

	Arnd
