From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 10 Jan 2013 15:09:21 +0100
Subject: [PATCH v3 06/18] ARM: clps711x: cdb89712: Special driver for
 handling memory is removed
In-Reply-To: <1353160644-22446-7-git-send-email-shc_work@mail.ru>
References: <1353160644-22446-1-git-send-email-shc_work@mail.ru>
 <1353160644-22446-7-git-send-email-shc_work@mail.ru>
Message-ID: <20130110140921.GC14860@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I just stumbled over commit 86449336dd3c6e0edf97b971db2daa88917c1d7e
(contained in v3.8-rc1) which is the result of this patch submission. So
it's too late for a review comment, so if you care about my concerns you
need to follow up with a new patch.

On Sat, Nov 17, 2012 at 05:57:12PM +0400, Alexander Shiyan wrote:
> This patch provide migration to using "physmap-flash" and "mtd-ram"
> drivers instead of using special driver for handling memory.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-clps711x/cdb89712.c              |   84 +++++++
>  arch/arm/mach-clps711x/include/mach/hardware.h |    3 +
>  drivers/mtd/maps/Kconfig                       |    7 -
>  drivers/mtd/maps/Makefile                      |    1 -
>  drivers/mtd/maps/cdb89712.c                    |  278 ------------------------
>  5 files changed, 87 insertions(+), 286 deletions(-)
>  delete mode 100644 drivers/mtd/maps/cdb89712.c
> 
> diff --git a/arch/arm/mach-clps711x/cdb89712.c b/arch/arm/mach-clps711x/cdb89712.c
> index 235e625..24f573b 100644
> --- a/arch/arm/mach-clps711x/cdb89712.c
> +++ b/arch/arm/mach-clps711x/cdb89712.c
> @@ -26,6 +26,10 @@
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
>  
> +#include <linux/mtd/physmap.h>
> +#include <linux/mtd/plat-ram.h>
> +#include <linux/mtd/partitions.h>
> +
>  #include <mach/hardware.h>
>  #include <asm/pgtable.h>
>  #include <asm/page.h>
> @@ -44,8 +48,88 @@ static struct resource cdb89712_cs8900_resource[] __initdata = {
>  	DEFINE_RES_IRQ(CDB89712_CS8900_IRQ),
>  };
>  
> +static struct mtd_partition cdb89712_flash_partitions[] __initdata = {
> +	{
> +		.name	= "Flash",
> +		.offset	= 0,
> +		.size	= MTDPART_SIZ_FULL,
> +	},
> +};
> +
> +static struct physmap_flash_data cdb89712_flash_pdata __initdata = {
> +	.width		= 4,
> +	.probe_type	= "map_rom",
> +	.parts		= cdb89712_flash_partitions,
> +	.nr_parts	= ARRAY_SIZE(cdb89712_flash_partitions),
> +};
> +
> +static struct resource cdb89712_flash_resources[] __initdata = {
> +	DEFINE_RES_MEM(CS0_PHYS_BASE, SZ_8M),
> +};
> +
> +static struct platform_device cdb89712_flash_pdev __initdata = {
> +	.name		= "physmap-flash",
> +	.id		= 0,
> +	.resource	= cdb89712_flash_resources,
> +	.num_resources	= ARRAY_SIZE(cdb89712_flash_resources),
> +	.dev	= {
> +		.platform_data	= &cdb89712_flash_pdata,
> +	},
> +};
> +
> +static struct mtd_partition cdb89712_bootrom_partitions[] __initdata = {
> +	{
> +		.name	= "BootROM",
> +		.offset	= 0,
> +		.size	= MTDPART_SIZ_FULL,
> +	},
> +};
> +
> +static struct physmap_flash_data cdb89712_bootrom_pdata __initdata = {
> +	.width		= 4,
> +	.probe_type	= "map_rom",
> +	.parts		= cdb89712_bootrom_partitions,
> +	.nr_parts	= ARRAY_SIZE(cdb89712_bootrom_partitions),
> +};
> +
> +static struct resource cdb89712_bootrom_resources[] __initdata = {
> +	DEFINE_RES_NAMED(CS7_PHYS_BASE, SZ_128, "BOOTROM", IORESOURCE_MEM |
> +			 IORESOURCE_CACHEABLE | IORESOURCE_READONLY),
> +};
> +
> +static struct platform_device cdb89712_bootrom_pdev __initdata = {
> +	.name		= "physmap-flash",
> +	.id		= 1,
> +	.resource	= cdb89712_bootrom_resources,
> +	.num_resources	= ARRAY_SIZE(cdb89712_bootrom_resources),
> +	.dev	= {
> +		.platform_data	= &cdb89712_bootrom_pdata,
> +	},
> +};
> +
> +static struct platdata_mtd_ram cdb89712_sram_pdata __initdata = {
> +	.bankwidth	= 4,
> +};
> +
> +static struct resource cdb89712_sram_resources[] __initdata = {
> +	DEFINE_RES_MEM(CLPS711X_SRAM_BASE, CLPS711X_SRAM_SIZE),
> +};
> +
> +static struct platform_device cdb89712_sram_pdev __initdata = {
> +	.name		= "mtd-ram",
> +	.id		= 0,
> +	.resource	= cdb89712_sram_resources,
> +	.num_resources	= ARRAY_SIZE(cdb89712_sram_resources),
> +	.dev	= {
> +		.platform_data	= &cdb89712_sram_pdata,
> +	},
> +};
> +
>  static void __init cdb89712_init(void)
>  {
> +	platform_device_register(&cdb89712_flash_pdev);
> +	platform_device_register(&cdb89712_bootrom_pdev);
> +	platform_device_register(&cdb89712_sram_pdev);
This is broken, all these structs are located in .init.data which is
discarded after the machine is fully booted. Also platformdata must not
live in init data. Consider using platform_device_register_full which
allows more data to be init data.

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
