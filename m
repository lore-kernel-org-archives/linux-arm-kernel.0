From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Sep 2014 17:08:08 +0200
Subject: [PATCH v2 1/8] ARM: add mach-asm9260
In-Reply-To: <1411324904-14881-2-git-send-email-linux@rempel-privat.de>
References: <1411324904-14881-1-git-send-email-linux@rempel-privat.de>
 <1411324904-14881-2-git-send-email-linux@rempel-privat.de>
Message-ID: <71905861.S3QD6rl7jU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 21 September 2014 20:41:37 Oleksij Rempel wrote:
> it is low cost (?) SoC targeted for market in China and India which
> trying to compete with AT91SAM9G25.
> 
> Here is some info:
> http://www.alphascale.com/index.asp?ics/615.html
> 
> One of products:
> http://www.aliexpress.com/store/product/2014-hot-sales-FREE-SHIPPING-new-Purple-core-ARM9-development-board-ASM9260T-SDRAM-power-line/433637_1931495721.html
> 
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>

Thanks for the submission! It looks pretty good, but has one main mistake
in being incompatible with ARCH_MULTIPLATFORM. I think that should be easy
to fix. There are also a few minor issues that can be improved.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5918d40..1a71feb 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -379,6 +379,20 @@ config ARCH_AT91
>  	  This enables support for systems based on Atmel
>  	  AT91RM9200 and AT91SAM9* processors.
>  
> +config MACH_ASM9260
> +	bool "Alphascale ASM9260"
> +	select ARCH_REQUIRE_GPIOLIB
> +	select COMMON_CLK
> +	select IRQ_DOMAIN
> +	select SPARSE_IRQ
> +	select MULTI_IRQ_HANDLER
> +	select GENERIC_IRQ_CHIP
> +	select GENERIC_CLOCKEVENTS
> +	select CLKSRC_MMIO
> +	select CPU_ARM926T
> +	help
> +	  Support for Alpascale ASM9260 based platform.

To enable multiplatform support, please move this to its own
arch/arm/mach-asm9260/Kconfig file and make it depend on ARCH_MULTI_V5,
then remove all 'select' statements that are implicitly enabled there
already (most of the above).

> diff --git a/arch/arm/mach-asm9260/Makefile b/arch/arm/mach-asm9260/Makefile
> new file mode 100644
> index 0000000..4bd8ebd
> --- /dev/null
> +++ b/arch/arm/mach-asm9260/Makefile
> @@ -0,0 +1,11 @@
> +#
> +# Makefile for the linux kernel.
> +#
> +
> +# Object file lists.
> +
> +obj-y			:= core.o
> +obj-m			:=
> +obj-n			:=
> +obj-			:=

You can remove most of these and just leave the one line.

> diff --git a/arch/arm/mach-asm9260/Makefile.boot b/arch/arm/mach-asm9260/Makefile.boot
> new file mode 100644
> index 0000000..c57b3b4
> --- /dev/null
> +++ b/arch/arm/mach-asm9260/Makefile.boot
> @@ -0,0 +1,2 @@
> +zreladdr-y	:= 0x20008000

This file should be removed, nowadays we use AUTO_ZRELADDR, which is
implied by multiplatform.

> +static struct map_desc asm9260_io_desc[] __initdata = {
> +	{	/* IO space */
> +		.virtual	= (unsigned long)0xf0000000,
> +		.pfn		= __phys_to_pfn(0x80000000),
> +		.length		= 0x00800000,
> +		.type		= MT_DEVICE
> +	},
> +	{	/* LCD IO space	*/
> +		.virtual	= (unsigned long)0xf0a00000,
> +		.pfn		= __phys_to_pfn(0x80800000),
> +		.length		= 0x00009000,
> +		.type		= MT_DEVICE
> +	},
> +	{	/* GPIO IO space */
> +		.virtual	= (unsigned long)0xf0800000,
> +		.pfn		= __phys_to_pfn(0x50000000),
> +		.length		= 0x00100000,
> +		.type		= MT_DEVICE
> +	},
> +	{	/* SRAM space Cacheable */
> +		.virtual	= (unsigned long)0xd0000000,
> +		.pfn		= __phys_to_pfn(0x40000000),
> +		.length		= 0x00100000,
> +#ifdef CONFIG_SRAM_MEM_CACHED
> +		.type		= MT_MEMORY
> +#else
> +		.type		= MT_DEVICE
> +#endif
> +	},
> +};

This should not be necessary, as all drivers are supposed to
ioremap their own device registers. For large register ranges
that are used a lot, you could use these as an optimization to
get 1 MB sections mapped using a large TLB entry, but usually
the benefit is very small.

> +static void __init asm9260_init(void)
> +{
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}

When you don't do anything else in the init_machine callback, you can
remove it entirely.

	Arnd
