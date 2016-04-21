From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Apr 2016 10:35:59 +0200
Subject: [PATCH v2 10/11] arm: Add Aspeed machine
In-Reply-To: <1461225849-28074-11-git-send-email-joel@jms.id.au>
References: <1461225849-28074-1-git-send-email-joel@jms.id.au>
 <1461225849-28074-11-git-send-email-joel@jms.id.au>
Message-ID: <6245614.OXDTEyrM2z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 April 2016 17:34:08 Joel Stanley wrote:
> diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
> new file mode 100644
> index 000000000000..30bafc0bbd8b
> --- /dev/null
> +++ b/arch/arm/mach-aspeed/Kconfig
> @@ -0,0 +1,28 @@
> +menuconfig ARCH_ASPEED
> +	bool "Aspeed BMC architectures"
> +	select OF
> +	select SRAM

Please add

	depends on ARCH_MULTI_V5 || ARCH_MULTI_V6

to hide the submenu otherwise. The 'select OF' is redundant and
can be removed.


> +	help
> +	  Say Y here if you want to run your kernel on hardware with an
> +	  ASpeed BMC SoC.
> +
> +if ARCH_ASPEED
> +
> +config MACH_AST_G4
> +	bool "Aspeed SoC 4th Generation" if ARCH_MULTI_V5
> +	depends on ARCH_ASPEED
> +	select CPU_ARM926T
> +	help
> +	 Say yes if you intend to run on an Aspeed ast2400 or similar
> +	 fourth generation BMCs, such as those used by OpenPower Power8
> +	 systems.
> +
> +config MACH_AST_G5
> +	bool "Aspeed SoC 5th Generation" if ARCH_MULTI_V6
> +	depends on ARCH_ASPEED

The two 'depends on ARCH_ASPEED are redundant as well, you already have
the 'if ARCH_ASPEED' around it.

> +
> +#define AST_BASE_WDT		0x1E785000 /* Watchdog Timer (WDT) */
> +#define AST_BASE_SCU		0x1E6E2000 /* System Control Unit (SCU) */

Please try to avoid hardcoding any addresses in the platform file.

> +static void __init aspeed_dt_init(void)
> +{
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}

We have just introduced of_platform_default_populate() that you could
use here, but the preferred way is to leave out the function entirely
as this is what we do anyway if none is provided.

> +#define AST_IO_VA	0xf0000000
> +#define AST_IO_PA	0x1e600000
> +#define AST_IO_SZ	0x00200000
> +
> +#define AST_IO(__pa)	((void __iomem *)(((__pa) & 0x001fffff) | AST_IO_VA))
> +
> +static struct map_desc aspeed_io_desc[] __initdata __maybe_unused = {
> +	{
> +		.virtual	=  AST_IO_VA,
> +		.pfn		= __phys_to_pfn(AST_IO_PA),
> +		.length		= AST_IO_SZ,
> +		.type		= MT_DEVICE
> +	},
> +};
>
> +
> +#define SCU_PASSWORD	0x1688A8A8
> +
> +static void __init aspeed_init_early(void)
> +{
> +	u32 reg;
> +
> +	/*
> +	 * Unlock SCU
> +	 */
> +	writel(SCU_PASSWORD, AST_IO(AST_BASE_SCU));
> +
> +	/* We enable the UART clock divisor in the SCU's misc control
> +	 * register, as the baud rates in aspeed.dtb all assume that the
> +	 * divisor is active
> +	 */
> +	reg = readl(AST_IO(AST_BASE_SCU | 0x2c));
> +	writel(reg | 0x00001000, AST_IO(AST_BASE_SCU | 0x2c));

Can you explain a bit more about this? I would assume that the UART
that is used for the console is working at the point that the bootloader
hands over to the kernel, while the other uarts don't need to be
active this early. Why do you need to do this at such an early stage?

> +	/*
> +	 * Disable the watchdogs
> +	 */
> +	writel(0, AST_IO(AST_BASE_WDT | 0x0c));
> +	writel(0, AST_IO(AST_BASE_WDT | 0x2c));
> +}

Similarly here: why so early? Is the initial timeout too short to wait
for the watchdog driver to come up? I think it makes sense to require
the watchdog driver to be loaded if a watchdog is enabled during boot,
and that keeps the register access in one place.

	Arnd
