From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 26 May 2010 21:56:27 +0800
Subject: [PATCH 1/8] pxa/colibri270: Refactor board definition file
In-Reply-To: <1274480980-10109-2-git-send-email-marek.vasut@gmail.com>
References: <1274480980-10109-1-git-send-email-marek.vasut@gmail.com>
	<1274480980-10109-2-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTik13GgkjGMSkuDIw_Xti5myNJxbBnCtil3-zI7-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 22, 2010 at 6:29 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> This patch just moves code around and polishes it. Also, compile in only
> selected pieces of hardware.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Applied.

> ---
> ?arch/arm/mach-pxa/colibri-pxa270.c ? ? ? | ? 69 ++++++++++++++++++------------
> ?arch/arm/mach-pxa/include/mach/colibri.h | ? ?9 +---
> ?2 files changed, 43 insertions(+), 35 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
> index 061c453..4519e89 100644
> --- a/arch/arm/mach-pxa/colibri-pxa270.c
> +++ b/arch/arm/mach-pxa/colibri-pxa270.c
> @@ -3,6 +3,7 @@
> ?*
> ?* ?Support for Toradex PXA270 based Colibri module
> ?* ?Daniel Mack <daniel@caiaq.de>
> + * ?Marek Vasut <marek.vasut@gmail.com>
> ?*
> ?* ?This program is free software; you can redistribute it and/or modify
> ?* ?it under the terms of the GNU General Public License version 2 as
> @@ -36,23 +37,25 @@
> ?#include "generic.h"
> ?#include "devices.h"
>
> -/*
> - * GPIO configuration
> - */
> +/******************************************************************************
> + * Pin configuration
> + ******************************************************************************/
> ?static mfp_cfg_t colibri_pxa270_pin_config[] __initdata = {
> + ? ? ? /* Ethernet */
> ? ? ? ?GPIO78_nCS_2, ? /* Ethernet CS */
> ? ? ? ?GPIO114_GPIO, ? /* Ethernet IRQ */
> ?};
>
> -/*
> - * NOR flash
> - */
> +/******************************************************************************
> + * NOR Flash
> + ******************************************************************************/
> +#if defined(CONFIG_MTD_PHYSMAP) || defined(CONFIG_MTD_PHYSMAP_MODULE)
> ?static struct mtd_partition colibri_partitions[] = {
> ? ? ? ?{
> ? ? ? ? ? ? ? ?.name = ? ? ? ? "Bootloader",
> ? ? ? ? ? ? ? ?.offset = ? ? ? 0x00000000,
> ? ? ? ? ? ? ? ?.size = ? ? ? ? 0x00040000,
> - ? ? ? ? ? ? ? .mask_flags = ? MTD_WRITEABLE ?/* force read-only */
> + ? ? ? ? ? ? ? .mask_flags = ? MTD_WRITEABLE ? /* force read-only */
> ? ? ? ?}, {
> ? ? ? ? ? ? ? ?.name = ? ? ? ? "Kernel",
> ? ? ? ? ? ? ? ?.offset = ? ? ? 0x00040000,
> @@ -90,42 +93,50 @@ static struct platform_device colibri_pxa270_flash_device = {
> ? ? ? ?.num_resources = 1,
> ?};
>
> -/*
> - * DM9000 Ethernet
> - */
> -#if defined(CONFIG_DM9000)
> -static struct resource dm9000_resources[] = {
> +static void __init colibri_pxa270_nor_init(void)
> +{
> + ? ? ? platform_device_register(&colibri_pxa270_flash);
> +}
> +#else
> +static inline void colibri_pxa270_nor_init(void) {}
> +#endif
> +
> +/******************************************************************************
> + * Ethernet
> + ******************************************************************************/
> +#if defined(CONFIG_DM9000) || defined(CONFIG_DM9000_MODULE)
> +static struct resource colibri_pxa270_dm9000_resources[] = {
> ? ? ? ?[0] = {
> - ? ? ? ? ? ? ? .start ?= COLIBRI_PXA270_ETH_PHYS,
> - ? ? ? ? ? ? ? .end ? ?= COLIBRI_PXA270_ETH_PHYS + 3,
> + ? ? ? ? ? ? ? .start ?= PXA_CS2_PHYS,
> + ? ? ? ? ? ? ? .end ? ?= PXA_CS2_PHYS + 3,
> ? ? ? ? ? ? ? ?.flags ?= IORESOURCE_MEM,
> ? ? ? ?},
> ? ? ? ?[1] = {
> - ? ? ? ? ? ? ? .start ?= COLIBRI_PXA270_ETH_PHYS + 4,
> - ? ? ? ? ? ? ? .end ? ?= COLIBRI_PXA270_ETH_PHYS + 4 + 500,
> + ? ? ? ? ? ? ? .start ?= PXA_CS2_PHYS + 4,
> + ? ? ? ? ? ? ? .end ? ?= PXA_CS2_PHYS + 4 + 500,
> ? ? ? ? ? ? ? ?.flags ?= IORESOURCE_MEM,
> ? ? ? ?},
> ? ? ? ?[2] = {
> - ? ? ? ? ? ? ? .start ?= COLIBRI_PXA270_ETH_IRQ,
> - ? ? ? ? ? ? ? .end ? ?= COLIBRI_PXA270_ETH_IRQ,
> + ? ? ? ? ? ? ? .start ?= gpio_to_irq(GPIO114_COLIBRI_PXA270_ETH_IRQ),
> + ? ? ? ? ? ? ? .end ? ?= gpio_to_irq(GPIO114_COLIBRI_PXA270_ETH_IRQ),
> ? ? ? ? ? ? ? ?.flags ?= IORESOURCE_IRQ | IRQF_TRIGGER_RISING,
> ? ? ? ?},
> ?};
>
> -static struct platform_device dm9000_device = {
> +static struct platform_device colibri_pxa270_dm9000_device = {
> ? ? ? ?.name ? ? ? ? ? = "dm9000",
> ? ? ? ?.id ? ? ? ? ? ? = -1,
> - ? ? ? .num_resources ?= ARRAY_SIZE(dm9000_resources),
> - ? ? ? .resource ? ? ? = dm9000_resources,
> + ? ? ? .num_resources ?= ARRAY_SIZE(colibri_pxa270_dm9000_resources),
> + ? ? ? .resource ? ? ? = colibri_pxa270_dm9000_resources,
> ?};
> -#endif /* CONFIG_DM9000 */
>
> -static struct platform_device *colibri_pxa270_devices[] __initdata = {
> - ? ? ? &colibri_pxa270_flash_device,
> -#if defined(CONFIG_DM9000)
> - ? ? ? &dm9000_device,
> +static void __init colibri_pxa270_eth_init(void)
> +{
> + ? ? ? platform_device_register(&colibri_pxa270_dm9000_device);
> +}
> +#else
> +static inline void colibri_pxa270_eth_init(void) {}
> ?#endif
> -};
>
> ?static void __init colibri_pxa270_init(void)
> ?{
> @@ -133,7 +144,9 @@ static void __init colibri_pxa270_init(void)
> ? ? ? ?pxa_set_ffuart_info(NULL);
> ? ? ? ?pxa_set_btuart_info(NULL);
> ? ? ? ?pxa_set_stuart_info(NULL);
> - ? ? ? platform_add_devices(ARRAY_AND_SIZE(colibri_pxa270_devices));
> +
> + ? ? ? colibri_pxa270_nor_init();
> + ? ? ? colibri_pxa270_eth_init();
> ?}
>
> ?MACHINE_START(COLIBRI, "Toradex Colibri PXA270")
> diff --git a/arch/arm/mach-pxa/include/mach/colibri.h b/arch/arm/mach-pxa/include/mach/colibri.h
> index 5f2ba8d..9e47e1f 100644
> --- a/arch/arm/mach-pxa/include/mach/colibri.h
> +++ b/arch/arm/mach-pxa/include/mach/colibri.h
> @@ -33,13 +33,8 @@ static inline void colibri_pxa3xx_init_nand(void) {}
> ?/* physical memory regions */
> ?#define COLIBRI_SDRAM_BASE ? ? 0xa0000000 ? ? ?/* SDRAM region */
>
> -/* definitions for Colibri PXA270 */
> -
> -#define COLIBRI_PXA270_FLASH_PHYS ? ? ?(PXA_CS0_PHYS) ?/* Flash region */
> -#define COLIBRI_PXA270_ETH_PHYS ? ? ? ? ? ? ? ?(PXA_CS2_PHYS) ?/* Ethernet */
> -#define COLIBRI_PXA270_ETH_IRQ_GPIO ? ?114
> -#define COLIBRI_PXA270_ETH_IRQ ? ? ? ? \
> - ? ? ? gpio_to_irq(mfp_to_gpio(COLIBRI_PXA270_ETH_IRQ_GPIO))
> +/* GPIO definitions for Colibri PXA270 */
> +#define GPIO114_COLIBRI_PXA270_ETH_IRQ 114
>
> ?#endif /* _COLIBRI_H_ */
>
> --
> 1.7.0
>
>
