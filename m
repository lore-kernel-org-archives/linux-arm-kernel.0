From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 31 Aug 2010 21:09:20 +0530
Subject: [PATCH v1] davinci: Initial support for MityDSP-L138/MityARM-1808
In-Reply-To: <4C7C52FD.6010608@criticallink.com>
References: <4C7C52FD.6010608@criticallink.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301F6AC5679@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Tue, Aug 31, 2010 at 06:25:25, Michael Williamson wrote:
> This patch adds initial support for the MityDSP-L138 and MityDSP-1808 system
> on Module (SOM) under the machine name "mityomapl138".  These SOMs are based
> on the da850 davinci CPU architecture.  Information on these SOMs may be
> found at http://www.mitydsp.com.
>
> Basic support for the console UART, NAND, and EMAC (MII interface) is
> included in this patch.
>
> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>

[...]

> diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
> index 292e8b7..e51a80f 100644
> --- a/arch/arm/mach-davinci/board-da830-evm.c
> +++ b/arch/arm/mach-davinci/board-da830-evm.c
> @@ -586,6 +586,9 @@ static __init void da830_evm_init(void)
>  #ifdef CONFIG_SERIAL_8250_CONSOLE
>  static int __init da830_evm_console_init(void)
>  {
> +     if (!machine_is_davinci_da830_evm())
> +             return 0;
> +
>       return add_preferred_console("ttyS", 2, "115200");
>  }
>  console_initcall(da830_evm_console_init);
> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index 190ebd3..d491b5f 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -847,6 +847,9 @@ static __init void da850_evm_init(void)
>  #ifdef CONFIG_SERIAL_8250_CONSOLE
>  static int __init da850_evm_console_init(void)
>  {
> +     if (!machine_is_davinci_da850_evm())
> +             return 0;
> +
>       return add_preferred_console("ttyS", 2, "115200");
>  }
>  console_initcall(da850_evm_console_init);

I think this should be carved into a separate patch as
this is a bug fix of existing code rather than addition
of new board as subject and description of this patch
indicate.

> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
> new file mode 100644
> index 0000000..7338adb
> --- /dev/null
> +++ b/arch/arm/mach-davinci/board-mityomapl138.c
> @@ -0,0 +1,220 @@
> +/*
> + * Critical Link MityOMAP-L138 SoM
> + *
> + * Copyright (C) 2010 Critical Link LLC - http://www.criticallink.com
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of
> + * any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/console.h>
> +#include <linux/platform_device.h>
> +#include <linux/mtd/partitions.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <mach/common.h>
> +#include <mach/cp_intc.h>
> +#include <mach/da8xx.h>
> +#include <mach/nand.h>
> +#include <mach/mux.h>
> +
> +#define MITYOMAPL138_PHY_MASK                0x08 /* hardcoded for now */
> +#define MITYOMAPL138_MDIO_FREQUENCY  (2200000) /* PHY bus frequency */
> +
> +/*
> + * MityDSP-L138 includes a 256 MByte large-page NAND flash
> + * (128K blocks).
> + */
> +struct mtd_partition mityomapl138_nandflash_partition[] = {
> +     {
> +             .name           = "rootfs",
> +             .offset         = 0,
> +             .size           = SZ_128M,
> +             .mask_flags     = 0, /* MTD_WRITEABLE, */
> +     },
> +     {
> +             .name           = "homefs",
> +             .offset         = MTDPART_OFS_APPEND,
> +             .size           = MTDPART_SIZ_FULL,
> +             .mask_flags     = 0,
> +     },
> +};
> +
> +static struct davinci_nand_pdata mityomapl138_nandflash_data = {
> +     .parts          = mityomapl138_nandflash_partition,
> +     .nr_parts       = ARRAY_SIZE(mityomapl138_nandflash_partition),
> +     .ecc_mode       = NAND_ECC_HW,
> +     .options        = NAND_USE_FLASH_BBT | NAND_BUSWIDTH_16,
> +     .ecc_bits   = 1, /* 4 bit mode is not supported with 16 bit NAND */
> +};
> +
> +static struct resource mityomapl138_nandflash_resource[] = {
> +     {
> +             .start  = DA8XX_AEMIF_CS3_BASE,
> +             .end    = DA8XX_AEMIF_CS3_BASE + SZ_512K + 2 * SZ_1K - 1,
> +             .flags  = IORESOURCE_MEM,
> +     },
> +     {
> +             .start  = DA8XX_AEMIF_CTL_BASE,
> +             .end    = DA8XX_AEMIF_CTL_BASE + SZ_32K - 1,
> +             .flags  = IORESOURCE_MEM,
> +     },
> +};
> +
> +static struct platform_device mityomapl138_nandflash_device = {
> +     .name           = "davinci_nand",
> +     .id             = 0,
> +     .dev            = {
> +             .platform_data  = &mityomapl138_nandflash_data,
> +     },
> +     .num_resources  = ARRAY_SIZE(mityomapl138_nandflash_resource),
> +     .resource       = mityomapl138_nandflash_resource,
> +};
> +
> +static struct platform_device *mityomapl138_devices[] __initdata = {
> +     &mityomapl138_nandflash_device,
> +};
> +
> +static void __init mityomapl138_setup_nand(void)
> +{
> +     platform_add_devices(mityomapl138_devices,
> +                              ARRAY_SIZE(mityomapl138_devices));
> +}
> +
> +static struct davinci_uart_config mityomapl138_uart_config __initdata = {
> +     .enabled_uarts = 0x7,
> +};
> +
> +static const short mityomap_mii_pins[] = {
> +     DA850_MII_TXEN, DA850_MII_TXCLK, DA850_MII_COL, DA850_MII_TXD_3,
> +     DA850_MII_TXD_2, DA850_MII_TXD_1, DA850_MII_TXD_0, DA850_MII_RXER,
> +     DA850_MII_CRS, DA850_MII_RXCLK, DA850_MII_RXDV, DA850_MII_RXD_3,
> +     DA850_MII_RXD_2, DA850_MII_RXD_1, DA850_MII_RXD_0, DA850_MDIO_CLK,
> +     DA850_MDIO_D,
> +     -1
> +};
> +
> +static const short mityomap_rmii_pins[] = {
> +     DA850_RMII_TXD_0, DA850_RMII_TXD_1, DA850_RMII_TXEN,
> +     DA850_RMII_CRS_DV, DA850_RMII_RXD_0, DA850_RMII_RXD_1,
> +     DA850_RMII_RXER, DA850_RMII_MHZ_50_CLK, DA850_MDIO_CLK,
> +     DA850_MDIO_D,
> +     -1
> +};
> +
> +static void __init mityomapl138_config_emac(void)
> +{
> +     void __iomem *cfg_chip3_base;
> +     int ret;
> +     u32 val;
> +     struct davinci_soc_info *soc_info = &davinci_soc_info;
> +     soc_info->emac_pdata->rmii_en = 0; /* hardcoded for now */
> +
> +     cfg_chip3_base = DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG);
> +     val = __raw_readl(cfg_chip3_base);
> +
> +     if (soc_info->emac_pdata->rmii_en) {
> +             val |= BIT(8);
> +             ret = davinci_cfg_reg_list(mityomap_rmii_pins);
> +             pr_info("RMII PHY configured\n");
> +     } else {
> +             val &= ~BIT(8);
> +             ret = davinci_cfg_reg_list(mityomap_mii_pins);
> +             pr_info("MII PHY configured\n");
> +     }
> +
> +     if (ret) {
> +             pr_warning("mii/rmii mux setup failed: %d\n", ret);
> +             return;
> +     }
> +
> +     /* configure the CFGCHIP3 register for RMII or MII */
> +     __raw_writel(val, cfg_chip3_base);
> +
> +     soc_info->emac_pdata->phy_mask = MITYOMAPL138_PHY_MASK;
> +     pr_info("setting phy_mask to %x\n", soc_info->emac_pdata->phy_mask);

This should be pr_debug()?

Thanks,
Sekhar
