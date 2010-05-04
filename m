From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 4 May 2010 22:44:58 +0800
Subject: [PATCH] pxa/vpac270: Add OneNAND support
In-Reply-To: <1272689676-20824-1-git-send-email-marek.vasut@gmail.com>
References: <1272689676-20824-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <k2lf17812d71005040744n2b5d0207g6d404c1c7704e3cd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 1, 2010 at 12:54 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Applied.

> ---
> ?arch/arm/mach-pxa/vpac270.c | ? 51 ++++++++++++++++++++++++++++++++++++++++--
> ?1 files changed, 48 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
> index a87bad5..8da22d4 100644
> --- a/arch/arm/mach-pxa/vpac270.c
> +++ b/arch/arm/mach-pxa/vpac270.c
> @@ -21,6 +21,7 @@
> ?#include <linux/mtd/mtd.h>
> ?#include <linux/mtd/partitions.h>
> ?#include <linux/mtd/physmap.h>
> +#include <linux/mtd/onenand.h>
> ?#include <linux/dm9000.h>
> ?#include <linux/ucb1400.h>
> ?#include <linux/ata_platform.h>
> @@ -149,7 +150,7 @@ static unsigned long vpac270_pin_config[] __initdata = {
> ?* NOR Flash
> ?******************************************************************************/
> ?#if defined(CONFIG_MTD_PHYSMAP) || defined(CONFIG_MTD_PHYSMAP_MODULE)
> -static struct mtd_partition vpac270_partitions[] = {
> +static struct mtd_partition vpac270_nor_partitions[] = {
> ? ? ? ?{
> ? ? ? ? ? ? ? ?.name ? ? ? ? ? = "Flash",
> ? ? ? ? ? ? ? ?.offset ? ? ? ? = 0x00000000,
> @@ -160,8 +161,8 @@ static struct mtd_partition vpac270_partitions[] = {
> ?static struct physmap_flash_data vpac270_flash_data[] = {
> ? ? ? ?{
> ? ? ? ? ? ? ? ?.width ? ? ? ? ?= 2, ? ?/* bankwidth in bytes */
> - ? ? ? ? ? ? ? .parts ? ? ? ? ?= vpac270_partitions,
> - ? ? ? ? ? ? ? .nr_parts ? ? ? = ARRAY_SIZE(vpac270_partitions)
> + ? ? ? ? ? ? ? .parts ? ? ? ? ?= vpac270_nor_partitions,
> + ? ? ? ? ? ? ? .nr_parts ? ? ? = ARRAY_SIZE(vpac270_nor_partitions)
> ? ? ? ?}
> ?};
>
> @@ -189,6 +190,49 @@ static inline void vpac270_nor_init(void) {}
> ?#endif
>
> ?/******************************************************************************
> + * OneNAND Flash
> + ******************************************************************************/
> +#if defined(CONFIG_MTD_ONENAND) || defined(CONFIG_MTD_ONENAND_MODULE)
> +static struct mtd_partition vpac270_onenand_partitions[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "Flash",
> + ? ? ? ? ? ? ? .offset ? ? ? ? = 0x00000000,
> + ? ? ? ? ? ? ? .size ? ? ? ? ? = MTDPART_SIZ_FULL,
> + ? ? ? }
> +};
> +
> +static struct onenand_platform_data vpac270_onenand_info = {
> + ? ? ? .parts ? ? ? ? ?= vpac270_onenand_partitions,
> + ? ? ? .nr_parts ? ? ? = ARRAY_SIZE(vpac270_onenand_partitions),
> +};
> +
> +static struct resource vpac270_onenand_resources[] = {
> + ? ? ? [0] = {
> + ? ? ? ? ? ? ? .start ?= PXA_CS0_PHYS,
> + ? ? ? ? ? ? ? .end ? ?= PXA_CS0_PHYS + SZ_1M,
> + ? ? ? ? ? ? ? .flags ?= IORESOURCE_MEM,
> + ? ? ? },
> +};
> +
> +static struct platform_device vpac270_onenand = {
> + ? ? ? .name ? ? ? ? ? = "onenand-flash",
> + ? ? ? .id ? ? ? ? ? ? = -1,
> + ? ? ? .resource ? ? ? = vpac270_onenand_resources,
> + ? ? ? .num_resources ?= ARRAY_SIZE(vpac270_onenand_resources),
> + ? ? ? .dev ? ? ? ? ? ?= {
> + ? ? ? ? ? ? ? .platform_data ?= &vpac270_onenand_info,
> + ? ? ? },
> +};
> +
> +static void __init vpac270_onenand_init(void)
> +{
> + ? ? ? platform_device_register(&vpac270_onenand);
> +}
> +#else
> +static void __init vpac270_onenand_init(void) {}
> +#endif
> +
> +/******************************************************************************
> ?* SD/MMC card controller
> ?******************************************************************************/
> ?#if defined(CONFIG_MMC_PXA) || defined(CONFIG_MMC_PXA_MODULE)
> @@ -549,6 +593,7 @@ static void __init vpac270_init(void)
> ? ? ? ?vpac270_lcd_init();
> ? ? ? ?vpac270_mmc_init();
> ? ? ? ?vpac270_nor_init();
> + ? ? ? vpac270_onenand_init();
> ? ? ? ?vpac270_leds_init();
> ? ? ? ?vpac270_keys_init();
> ? ? ? ?vpac270_uhc_init();
> --
> 1.7.0
>
>
