From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 26 Jul 2010 14:59:18 +0530
Subject: [PATCH v3] davinci: Add MityDSP-L138/MityARM-1808 SOM support
In-Reply-To: <4C45AE5E.7070905@criticallink.com>
References: <4C45AE5E.7070905@criticallink.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7D0AF64@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Michael,

On Tue, Jul 20, 2010 at 19:40:38, Michael Williamson wrote:
>  This patch adds support for the MityDSP-L138 and MityARM-1808 system on
> module (SOM) under the registered machine "mityomapl138".  These SOMs
> are based on the da850 davinci CPU architecture.  Information on these
> SOMs may be found at http://www.mitydsp.com.
>
> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
> ---

[...]

>
>  arch/arm/configs/da8xx_omapl_defconfig             |  291 ++++++--
>  arch/arm/include/asm/setup.h                       |    5 +
>  arch/arm/mach-davinci/Kconfig                      |    7 +
>  arch/arm/mach-davinci/Makefile                     |    1 +
>  arch/arm/mach-davinci/board-mityomapl138.c         |  793 ++++++++++++++++++++
>  .../mach-davinci/include/mach/cb-mityomapl138.h    |  125 +++
>  arch/arm/mach-davinci/include/mach/da8xx.h         |    1 +
>  arch/arm/mach-davinci/include/mach/uncompress.h    |    1 +
>  8 files changed, 1181 insertions(+), 43 deletions(-)
>

[...]

> diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
> index f392fb4..d6b1a47 100644
> --- a/arch/arm/include/asm/setup.h
> +++ b/arch/arm/include/asm/setup.h
> @@ -143,6 +143,11 @@ struct tag_memclk {
>      __u32 fmemclk;
>  };
>
> +/** MityDSP-L138 peripheral configuration info,
> +  *  see arch/arm/mach-davinci/include/mach/cb-mityomapl138.h
> +  */
> +#define ATAG_PERIPHERALS 0x42000101

Instead of naming this so generic, can you call this ATAG_MITYDSPL138 or
something like that?

Since passing peripheral configuration from bootloader is a first for
DaVinci, can you please explain why this is the best suited method for this
board and why methods used on other boards wont work?

> +
>  struct tag {
>      struct tag_header hdr;
>      union {
> diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
> index 71f90f8..064b0e2 100644
> --- a/arch/arm/mach-davinci/Kconfig
> +++ b/arch/arm/mach-davinci/Kconfig
> @@ -178,6 +178,13 @@ config DA850_UI_RMII
>
>  endchoice
>
> +config MACH_MITYOMAPL138
> +    bool "Critical Link MityOMAPL138 SoM"
> +    depends on ARCH_DAVINCI_DA850
> +    select GPIO_PCA953X
> +    help
> +      Say Y here to select the Critical Link MityOMAP-L138 System on Module.

Here you can include some pointers on where more information about the
board can be found.

> +
>  config MACH_TNETV107X
>      bool "TI TNETV107X Reference Platform"
>      default ARCH_DAVINCI_TNETV107X
> diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
> index eab4c0f..dfc0fc4 100644
> --- a/arch/arm/mach-davinci/Makefile
> +++ b/arch/arm/mach-davinci/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_MACH_DAVINCI_DM6467_EVM)    += board-dm646x-evm.o cdce949.o
>  obj-$(CONFIG_MACH_DAVINCI_DM365_EVM)    += board-dm365-evm.o
>  obj-$(CONFIG_MACH_DAVINCI_DA830_EVM)    += board-da830-evm.o
>  obj-$(CONFIG_MACH_DAVINCI_DA850_EVM)    += board-da850-evm.o
> +obj-$(CONFIG_MACH_MITYOMAPL138)    += board-mityomapl138.o
>  obj-$(CONFIG_MACH_TNETV107X)        += board-tnetv107x-evm.o
>
>  # Power Management
> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
> new file mode 100644
> index 0000000..c8541f1
> --- /dev/null
> +++ b/arch/arm/mach-davinci/board-mityomapl138.c
> @@ -0,0 +1,793 @@
> +/*
> + * Critical Link MityOMAP-L138 SoM
> + *
> + * Copyright (C) 2010 Critical Link Incorporated - http://www.criticallink.com
> + *
> + * Derived from board-da850-evm.c
> + * Original Copyrights follow:
> + *
> + * Copyright (C) 2009 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * Derived from: arch/arm/mach-davinci/board-da830-evm.c
> + * Original Copyrights follow:
> + *
> + * 2007, 2009 (c) MontaVista Software, Inc. This file is licensed under
> + * the terms of the GNU General Public License version 2. This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + */
> +
> +#define pr_fmt(fmt) "%s: " fmt, __func__
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/console.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c/at24.h>
> +#include <linux/i2c/pca953x.h>

You do not seem to have defined platform data for pca953.

I guess the include here and the config select above are
copy-paste errors?

> +#include <linux/gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/physmap.h>

I didn't see any NOR devices registered?

> +#include <linux/regulator/machine.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/flash.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/setup.h>
> +#include <mach/cp_intc.h>
> +#include <mach/da8xx.h>
> +#include <mach/nand.h>
> +#include <mach/mux.h>
> +#include <mach/cb-mityomapl138.h>
> +#include <mach/spi.h>
> +#include <mach/irqs.h>
> +
> +static struct tag_peripherals peripheral_config = {
> +        .Version = PERIPHERALS_VERSION,
> +        .Manufacturer = "Critical Link",
> +        .ENETConfig.EnetConfig = ENET_CONFIG_MII,
> +        .ENETConfig.MACAddr = { 0x00, 0x50, 0xC2, 0x49, 0xDF, 0xFF },
> +        .UARTConfig[0] = {
> +            .Enable = 0,
> +            .IsConsole = 0,
> +            .Baud = 115200,
> +        },
> +        .UARTConfig[1] = {
> +            .Enable = 1,
> +            .IsConsole = 1,
> +            .Baud = 115200,
> +        },
> +        .UARTConfig[2] = {
> +            .Enable = 0,
> +            .IsConsole = 0,
> +            .Baud = 115200,
> +        },
> +        .SPIConfig[0] = {
> +            .Enable = 0,
> +            .CLKOut = 0,
> +            .CSEnable = { 0, 0, 0, 0, 0, 0, 0, 0},
> +            .ENAEnable = 0,
> +            .CLKRate = 0,
> +        },
> +        .SPIConfig[1] = {
> +            .Enable = 1,
> +            .CLKOut = 1,
> +            .CSEnable = { 1, 0, 0, 0, 0, 0, 0, 0},
> +            .ENAEnable = 0,
> +            .CLKRate = 30000000,
> +        },
> +        .LCDConfig = {
> +            .Enable = 0,
> +            .PanelName = "",
> +        }
> +};

Do we really need the camel case naming?

[...]

> +
> +static __init void mityomapl138_setup_nand(void)
> +{
> +

Extra line here..

> +    platform_add_devices(mityomapl138_devices,
> +                 ARRAY_SIZE(mityomapl138_devices));
> +}
> +
> +static int mityomapl138_mmc_get_ro(int index)
> +{
> +    return gpio_get_value(DA850_MMCSD_WP_PIN);
> +}
> +
> +static int mityomapl138_mmc_get_cd(int index)
> +{
> +    return !gpio_get_value(DA850_MMCSD_CD_PIN);
> +}
> +
> +static struct davinci_mmc_config da850_mmc_config = {
> +    .get_ro        = mityomapl138_mmc_get_ro,
> +    .get_cd        = mityomapl138_mmc_get_cd,
> +    .wires        = 4,
> +    .max_freq    = 50000000,
> +    .caps        = MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
> +    .version    = MMC_CTLR_VERSION_2,
> +};
> +
> +static __init void mityomapl138_setup_mmc(void)
> +{
> +    int ret;
> +
> +    ret = davinci_cfg_reg_list(da850_mmcsd0_pins);
> +    if (ret)
> +        pr_warning("mmcsd0 mux setup failed: %d\n" ,ret);
> +
> +    ret = gpio_request(DA850_MMCSD_CD_PIN, "MMC CD\n");
> +    if (ret)
> +        pr_warning("can not open GPIO %d\n", DA850_MMCSD_CD_PIN);
> +    gpio_direction_input(DA850_MMCSD_CD_PIN);
> +
> +    ret = gpio_request(DA850_MMCSD_WP_PIN, "MMC WP\n");
> +    if (ret)
> +        pr_warning("can not open GPIO %d\n", DA850_MMCSD_WP_PIN);
> +    gpio_direction_input(DA850_MMCSD_WP_PIN);

Its not nice to go ahead and operate on the GPIO even
though the request call fails. I can see the EVM code does
it this way, but that code needs fixing too.

> +
> +    ret = da8xx_register_mmcsd0(&da850_mmc_config);
> +    if (ret)
> +        pr_warning("mmcsd0 registration failed: %d\n", ret);
> +}
> +
> +

Extra line here..

> +static struct davinci_uart_config mityomapl138_uart_config __initdata = {
> +    .enabled_uarts = 0x7,
> +};
> +
> +static int __init mityomapl138_config_emac(void)
> +{
> +    void __iomem *cfg_chip3_base;
> +    int ret;
> +    u32 val;
> +    struct davinci_soc_info *soc_info = &davinci_soc_info;
> +    u8 rmii_en = 0;
> +
> +    switch (peripheral_config.ENETConfig.EnetConfig) {
> +    case ENET_CONFIG_RMII:
> +        soc_info->emac_pdata->rmii_en = 1;
> +        rmii_en = 1;
> +        break;
> +    case ENET_CONFIG_MII:
> +        soc_info->emac_pdata->rmii_en = 0;
> +        rmii_en = 0;
> +        break;
> +    case ENET_CONFIG_NONE:
> +    default:
> +        pr_info("No Ethernet PHY Selected, EMAC disabled\n");
> +        return 0; /* no enet... */
> +        break;
> +    }
> +    memcpy(&soc_info->emac_pdata->mac_addr[0],
> +           &peripheral_config.ENETConfig.MACAddr[0], 6);
> +
> +    cfg_chip3_base = DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG);
> +
> +    val = __raw_readl(cfg_chip3_base);
> +
> +    if (rmii_en) {
> +        val |= BIT(8);
> +        ret = davinci_cfg_reg_list(da850_rmii_pins);
> +        pr_info("RMII PHY configured, MII PHY will not be functional\n");
> +    } else {
> +        val &= ~BIT(8);
> +        ret = davinci_cfg_reg_list(da850_cpgmac_pins);
> +        pr_info("MII PHY configured, RMII PHY will not be functional\n");
> +    }
> +
> +    if (ret)
> +        pr_warning("cpgmac/rmii mux setup failed: %d\n", ret);
> +
> +    /* configure the CFGCHIP3 register for RMII or MII */
> +    __raw_writel(val, cfg_chip3_base);
> +
> +    soc_info->emac_pdata->phy_mask = peripheral_config.ENETConfig.PHYMask ?
> +            peripheral_config.ENETConfig.PHYMask : 1;
> +    pr_info("setting phy_mask to %x\n", soc_info->emac_pdata->phy_mask);
> +    soc_info->emac_pdata->mdio_max_freq = MITYOMAPL138_MDIO_FREQUENCY;
> +
> +    ret = da8xx_register_emac();
> +    if (ret)
> +        pr_warning("emac registration failed: %d\n", ret);
> +
> +    return 0;
> +}
> +device_initcall(mityomapl138_config_emac);

Using device_initcall here is not good. It will get called on other
boards as well just because support for this board is built into
the kernel. So, at a minimum, there should be check to bail out
if machine != mityomapl138.

Better still, please re-evaluate whether you really need a
device_initcall() here. On the EVM this method was chosen
since the Ethernet init was tied to UI card detection. You
should aim to eliminate it on this board.

> +
> +static struct davinci_i2c_platform_data mityomap_i2c_0_pdata = {
> +    .bus_freq    = 100,    /* kHz */
> +    .bus_delay    = 0,    /* usec */
> +};

This is exactly the pdata that davinci I2C driver uses by default,
so you can save a few bytes and a few lines of code by passing NULL
pdata.

[...]

> +
> +static struct davinci_spi_platform_data mityomap_spi1_pdata = {
> +    .version        = SPI_VERSION_2,
> +    .num_chipselect = 1,
> +    .wdelay         = 0,
> +    .odd_parity     = 0,
> +    .parity_enable  = 0,
> +    .wait_enable    = 0,
> +    .timer_disable  = 0,
> +    .clk_internal   = 1,
> +    .cs_hold        = 1,
> +    .intr_level     = 0,
> +    .poll_mode      = 1,
> +    .use_dma        = 0,
> +    .c2tdelay       = 8,
> +    .t2cdelay       = 8,
> +};
> +
> +static struct resource mityomap_spi1_resources[] = {
> +    [0] = {
> +        .start = 0x01F0E000,
> +        .end   = 0x01F0EFFF,
> +        .flags = IORESOURCE_MEM,
> +    },
> +    [1] = {
> +        .start = IRQ_DA8XX_SPINT1,
> +        .start = IRQ_DA8XX_SPINT1,
> +        .flags = IORESOURCE_IRQ,
> +    },
> +    [2] = {
> +        .start = EDMA_CTLR_CHAN(0, 18),
> +        .end = EDMA_CTLR_CHAN(0, 18),
> +        .flags = IORESOURCE_DMA,
> +    },
> +    [3] = {
> +        .start = EDMA_CTLR_CHAN(0, 19),
> +        .end = EDMA_CTLR_CHAN(0, 19),
> +        .flags = IORESOURCE_DMA,
> +    },
> +    [4] = {
> +        .start = 1,
> +        .end = 1,
> +        .flags = IORESOURCE_DMA,
> +    },
> +};
> +
> +static struct platform_device mityomap_spi1_device = {
> +    .name = "spi_davinci",
> +    .id = 1,
> +    .dev = {
> +        .platform_data = &mityomap_spi1_pdata,
> +    },
> +    .num_resources = ARRAY_SIZE(mityomap_spi1_resources),
> +    .resource = mityomap_spi1_resources,
> +};
> +
> +/*****************************************************************************
> + * SPI Devices:
> + *      SPI1_CS0: 8M Flash ST-M25P64-VME6G
> + ****************************************************************************/
> +static struct mtd_partition spi_flash_partitions[] = {
> +    [0] = {
> +        .name = "UBL",
> +        .offset = 0,
> +        .size = SZ_64K,
> +        .mask_flags = MTD_WRITEABLE
> +    },
> +    [1] = {
> +        .name = "U-Boot",
> +        .offset = MTDPART_OFS_APPEND,
> +        .size = SZ_512K,
> +        .mask_flags = 0,
> +    },
> +    [2] = {
> +        .name = "Spare",
> +        .offset = MTDPART_OFS_APPEND,
> +        .size = MTDPART_SIZ_FULL,
> +        .mask_flags = 0,
> +    },
> +};
> +
> +static struct flash_platform_data mityomap_spi_flash_data = {
> +    .name     = "m25p80",
> +    .parts    = spi_flash_partitions,
> +    .nr_parts = ARRAY_SIZE(spi_flash_partitions),
> +    .type     = "m25p64",
> +};
> +
> +static struct spi_board_info mityomap_spi_flash_info[] = {
> +    {
> +        .modalias       = "m25p80",
> +        .platform_data  = &mityomap_spi_flash_data,
> +        .mode           = SPI_MODE_0,
> +        .max_speed_hz   = 30000000,
> +        .bus_num        = 1,
> +        .chip_select    = 0,
> +    },
> +};
> +
> +void __init mityomap_init_spi1(unsigned chipselect_mask,
> +                struct spi_board_info *info, unsigned len)
> +{
> +    int ret;
> +    ret = platform_device_register(&mityomap_spi1_device);
> +    if (ret)
> +        pr_warning("failed to register spi device : %d\n", ret);
> +
> +    ret = spi_register_board_info(info, len);
> +    if (ret)
> +        pr_warning("failed to register board info : %d\n", ret);
> +}
> +
> +/* davinci da850 evm audio machine driver */
> +static u8 da850_iis_serializer_direction[] = {
> +    INACTIVE_MODE,    INACTIVE_MODE,    INACTIVE_MODE,    INACTIVE_MODE,
> +    INACTIVE_MODE,    INACTIVE_MODE,    INACTIVE_MODE,    INACTIVE_MODE,
> +    INACTIVE_MODE,    INACTIVE_MODE,    INACTIVE_MODE,    INACTIVE_MODE,
> +    INACTIVE_MODE,    INACTIVE_MODE,    INACTIVE_MODE,    INACTIVE_MODE,
> +};
> +
> +static struct snd_platform_data mityomapl138_snd_data = {
> +    .tx_dma_offset    = 0x2000,
> +    .rx_dma_offset    = 0x2000,
> +    .op_mode    = DAVINCI_MCASP_IIS_MODE,
> +    .num_serializer    = ARRAY_SIZE(da850_iis_serializer_direction),
> +    .tdm_slots    = 0,
> +    .serial_dir    = da850_iis_serializer_direction,
> +    .eventq_no    = EVENTQ_1,

This field was recently changed in a patch[1] which is already
queued for ASoC merge for 2.6.36. You will need to base this on that
change. When you do that please note the dependency below the '---'
in the patch so maintainer knows the order in which to commit patches.

[1] http://git.kernel.org/?p=linux/kernel/git/broonie/sound-2.6.git;a=commit;h=48519f0ae03bc7e86b3dc93e56f1334d53803770

> +    .version    = MCASP_VERSION_2,
> +    .txnumevt    = 0,
> +    .rxnumevt    = 0,
> +};
> +
> +short mityomapl138_mcasp_pins[24] __initdata = {
> +    DA850_AHCLKX, DA850_ACLKX, DA850_AFSX,
> +    DA850_AHCLKR, DA850_ACLKR, DA850_AFSR,
> +    DA850_AMUTE,
> +    -1, -1, -1, -1,
> +    -1, -1, -1, -1,
> +    -1, -1, -1, -1,
> +    -1, -1, -1, -1,
> +    -1

Do we really need all these -1s?

> +};
> +
> +static __init int mityomapl138_setup_mcasp(void)
> +{
> +    int ret;
> +
> +    mityomapl138_mcasp_pins[7+0] = DA850_AXR_13;
> +    da850_iis_serializer_direction[12] = TX_MODE;

Why not stick these into the static initialization?

> +
> +    ret = davinci_cfg_reg_list(mityomapl138_mcasp_pins);
> +    if (ret)
> +        pr_warning("mcasp mux setup failed: %d\n", ret);
> +
> +    mityomapl138_snd_data.tdm_slots = 2;
> +    mityomapl138_snd_data.txnumevt = 1;

And the same for these?

> +
> +    da8xx_register_mcasp(0, &mityomapl138_snd_data);
> +
> +    return ret;
> +}
> +
> +static const struct display_panel disp_panel = {
> +    QVGA,
> +    16,
> +    16,
> +    COLOR_ACTIVE,
> +};
> +
> +static struct lcd_ctrl_config lcd_cfg = {
> +    &disp_panel,
> +    .ac_bias        = 255,
> +    .ac_bias_intrpt        = 0,
> +    .dma_burst_sz        = 16,
> +    .bpp            = 16,
> +    .fdd            = 255,
> +    .tft_alt_mode        = 0,
> +    .stn_565_mode        = 0,
> +    .mono_8bit_mode        = 0,
> +    .invert_line_clock    = 0,
> +    .invert_frm_clock    = 0,
> +    .sync_edge        = 0,
> +    .sync_ctrl        = 1,
> +    .raster_order        = 0,
> +};
> +
> +static struct da8xx_lcdc_platform_data sharp_lq035q7dh06_pdata = {
> +    .manu_name            = "sharp",
> +    .controller_data    = &lcd_cfg,
> +    .type                = "Sharp_LQ035Q7DH06",
> +};
> +
> +static struct da8xx_lcdc_platform_data chimei_p0430wqlb_pdata = {
> +    .manu_name            = "ChiMei",
> +    .controller_data    = &lcd_cfg,
> +    .type                = "ChiMei_P0430WQLB",
> +};
> +
> +static struct da8xx_lcdc_platform_data vga_640x480_pdata = {
> +    .manu_name            = "VGA",
> +    .controller_data    = &lcd_cfg,
> +    .type                = "vga_640x480",
> +};
> +
> +static struct resource da8xx_lcdc_resources[] = {
> +    [0] = { /* registers */
> +        .start  = DA8XX_LCD_CNTRL_BASE,
> +        .end    = DA8XX_LCD_CNTRL_BASE + SZ_4K - 1,
> +        .flags  = IORESOURCE_MEM,
> +    },
> +    [1] = { /* interrupt */
> +        .start  = IRQ_DA8XX_LCDINT,
> +        .end    = IRQ_DA8XX_LCDINT,
> +        .flags  = IORESOURCE_IRQ,
> +    },
> +};
> +
> +static struct platform_device da8xx_lcdc_device = {
> +    .name        = "da8xx_lcdc",
> +    .id        = 0,
> +    .num_resources    = ARRAY_SIZE(da8xx_lcdc_resources),
> +    .resource    = da8xx_lcdc_resources,
> +    .dev = {
> +        .platform_data = &sharp_lq035q7dh06_pdata,
> +    }

Should have ',' on the last member as well.

> +};
> +
> +static __init void mityomapl138_setup_lcd(void)
> +{
> +    int ret;
> +
> +    if (peripheral_config.LCDConfig.Enable) {
> +        u32 prio;
> +
> +        /* set peripheral master priority up to 1 */
> +        prio = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_MSTPRI2_REG));
> +        prio &= ~MSTPRI2_LCD_MASK;
> +        prio |= 1<<MSTPRI2_LCD_SHIFT;

Spaces around binary '<<'

> +        __raw_writel(prio, DA8XX_SYSCFG0_VIRT(DA8XX_MSTPRI2_REG));
> +
> +        if (0 == strncmp("Sharp_LQ035Q7DH06",
> +                peripheral_config.LCDConfig.PanelName,
> +                sizeof(peripheral_config.
> +                       LCDConfig.PanelName))) {

Why strncmp instead of just strcmp?

> +            da8xx_lcdc_device.dev.platform_data =
> +                &sharp_lq035q7dh06_pdata;
> +        } else if (0 == strncmp("ChiMei_P0430WQLB",
> +            peripheral_config.LCDConfig.PanelName,
> +            sizeof(peripheral_config.LCDConfig.PanelName))) {
> +            da8xx_lcdc_device.dev.platform_data =
> +                &chimei_p0430wqlb_pdata;
> +        } else if (0 == strncmp("vga_640x480",
> +                    peripheral_config.LCDConfig.PanelName,
> +                    sizeof(peripheral_config.
> +                           LCDConfig.PanelName))) {
> +            da8xx_lcdc_device.dev.platform_data =
> +                &vga_640x480_pdata;
> +        } else {
> +            pr_warning("unknown LCD type : %s\n",
> +                peripheral_config.LCDConfig.PanelName);
> +            return;
> +        }
> +
> +        ret = davinci_cfg_reg_list(da850_lcdcntl_pins);
> +        if (ret) {
> +            pr_warning("lcd pinmux failed : %d\n", ret);
> +            return;
> +        }
> +
> +        ret = platform_device_register(&da8xx_lcdc_device);
> +    } else {
> +        pr_warning("no LCD device enabled\n");
> +    }
> +}
> +
> +static __init void mityomapl138_init(void)
> +{
> +    int ret;
> +
> +    ret = pmic_tps65023_init();
> +    if (ret)
> +        pr_warning("TPS65023 PMIC init failed: %d\n", ret);
> +
> +    ret = da8xx_register_edma();
> +    if (ret)
> +        pr_warning("edma registration failed: %d\n", ret);
> +
> +    ret = da8xx_register_i2c(0, &mityomap_i2c_0_pdata);
> +    if (ret)
> +        pr_warning("i2c0 registration failed: %d\n", ret);
> +
> +    ret = da8xx_register_watchdog();
> +    if (ret)
> +        pr_warning("watchdog registration failed: %d\n", ret);
> +
> +    davinci_serial_init(&mityomapl138_uart_config);
> +
> +    ret = da8xx_register_rtc();
> +    if (ret)
> +        pr_warning("rtc setup failed: %d\n", ret);
> +
> +    ret = da850_register_cpufreq();
> +    if (ret)
> +        pr_warning("cpufreq registration failed: %d\n", ret);
> +
> +    ret = da8xx_register_cpuidle();
> +    if (ret)
> +        pr_warning("cpuidle registration failed: %d\n", ret);
> +
> +    mityomapl138_setup_nand();
> +
> +    mityomap_init_spi1(1, mityomap_spi_flash_info,
> +               ARRAY_SIZE(mityomap_spi_flash_info));
> +
> +    mityomapl138_setup_lcd();
> +
> +    mityomapl138_setup_mmc();
> +
> +    mityomapl138_setup_mcasp();
> +}
> +
> +#ifdef CONFIG_SERIAL_8250_CONSOLE
> +static int __init mityomapl138_console_init(void)
> +{
> +    return add_preferred_console("ttyS", 1, "115200");
> +}
> +console_initcall(mityomapl138_console_init);
> +#endif
> +
> +static void __init mityomapl138_map_io(void)
> +{
> +    da850_init();
> +}
> +
> +static int __init parse_tag_peripherals(const struct tag *tag)
> +{
> +    struct tag_peripherals *ptag;
> +    int i, j;
> +
> +    ptag = (struct tag_peripherals *)&tag->u.cmdline.cmdline[0];
> +    memcpy(&peripheral_config, ptag, sizeof(peripheral_config));
> +    pr_info("Peripheral Config Block Found\n");
> +    pr_info("Enet_Config = %d\n", peripheral_config.ENETConfig.EnetConfig);
> +    pr_info("EMAC = %pM\n", peripheral_config.ENETConfig.MACAddr);
> +    pr_info("PHYMask = 0x%x\n", peripheral_config.ENETConfig.PHYMask);
> +    if (peripheral_config.LCDConfig.Enable)
> +        pr_info("LCD Configured : %s\n",
> +            peripheral_config.LCDConfig.PanelName);
> +    else
> +        pr_info("No LCD Configured\n");
> +
> +    for (i = 0; i < 3; i++) {
> +        pr_info("UART[%d] = %d, %d, %d, %d\n", i,
> +            peripheral_config.UARTConfig[i].Enable,
> +            peripheral_config.UARTConfig[i].IsConsole,
> +            peripheral_config.UARTConfig[i].EnableHWFlowCtrl,
> +            peripheral_config.UARTConfig[i].Baud);

Without explaining what you are printing, this wont be of
much info. You intended this to be debug instead? Even then
it is better to include some information on what is being
dumped.

> +    }
> +    for (i = 0; i < 2; i++) {
> +        int mask = 0;
> +        for (j = 0; j < 8; j++)
> +            mask |= ((peripheral_config.SPIConfig[i].CSEnable[j]) ?
> +                (1<<j) : 0);
> +
> +        pr_info("SPI[%d] = %d, %d, %02X, %d, %d\n", i,
> +            peripheral_config.SPIConfig[i].Enable,
> +            peripheral_config.SPIConfig[i].CLKOut,
> +            mask,
> +            peripheral_config.SPIConfig[i].ENAEnable,
> +            peripheral_config.SPIConfig[i].CLKRate);

Same here..

> +    }
> +    return 0;
> +}
> +__tagtable(ATAG_PERIPHERALS, parse_tag_peripherals);
> +
> +
> +MACHINE_START(MITYOMAPL138, "MityDSP-L138")
> +    .phys_io    = IO_PHYS,
> +    .io_pg_offst    = (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
> +    .boot_params    = (DA8XX_DDR_BASE + 0x100),
> +    .map_io        = mityomapl138_map_io,
> +    .init_irq    = cp_intc_init,
> +    .timer        = &davinci_timer,
> +    .init_machine    = mityomapl138_init,
> +MACHINE_END
> diff --git a/arch/arm/mach-davinci/include/mach/cb-mityomapl138.h b/arch/arm/mach-davinci/include/mach/cb-mityomapl138.h
> new file mode 100644
> index 0000000..7ba085a
> --- /dev/null
> +++ b/arch/arm/mach-davinci/include/mach/cb-mityomapl138.h
> @@ -0,0 +1,125 @@
> +/**
> + * Factory / Peripheral Configuration Data as provided by ATAG_PERIPHERAL
> + * for the MityDSP-L138 SOMs. (mityomapl138 machines)
> + *
> + * Copyright (C) 2010 Critical Link LLC.  This file is licensed under
> + * the terms of the GNU General Public License version 2. This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + */
> +#ifndef CONFIG_BLOCK_H_
> +#define CONFIG_BLOCK_H_

Copy paste error?

> +
> +#define CONFIG_MAGIC_WORD 0x00BD0138
> +#define CONFIG_VERSION 0x00010000
> +
> +#define ENET_CONFIG_NONE 1
> +#define ENET_CONFIG_MII  2
> +#define ENET_CONFIG_RMII 3
> +
> +#define CONFIG_I2C_MAGIC_WORD 0x012C0138
> +#define CONFIG_I2C_VERSION    0x00010001
> +
> +/**
> + * Peripherals Version History
> + * 1.00 Baseline
> + * 1.01 Added McASP Configuration
> + * 1.02 Added ethernet phy mask
> + */
> +#define PERIPHERALS_VERSION   0x00010002
> +
> +#ifndef CONFIG_MITYDSP_ENV_SIZE
> +#define CONFIG_MITYDSP_ENV_SIZE (64 << 10)
> +#endif
> +
> +#define FPGATYPE_NONE       0
> +#define FPGATYPE_XC6SLX9    1
> +#define FPGATYPE_XC6SLX16   2
> +#define FPGATYPE_XC6SLX25   3
> +#define FPGATYPE_XC6SLX45   4
> +#define FPGATYPE_UNKNOWN    10000
> +
> +struct I2CFactoryConfig {
> +    u32               ConfigMagicWord;  /** CONFIG_I2C_MAGIC_WORD */
> +    u32               ConfigVersion;    /** CONFIG_I2C_VERSION */
> +    u8                MACADDR[6];       /** mac address assigned to part */
> +    u32               FpgaType;         /** fpga installed, see above */
> +    u32               Spare;            /** Not Used */
> +    u32               SerialNumber;     /** serial number of part */
> +    char              PartNumber[32];   /** board part number */
> +};
> +
> +struct UARTConfig {
> +    u8           Enable;            /** enable Tx/Rx */
> +    u8           IsConsole;         /** cfg as the console */
> +    u8           EnableHWFlowCtrl;  /** cfg CTS/RTS */
> +    u32          Baud;              /** default baud rate */
> +};
> +
> +struct SPIConfig {
> +    u8           Enable;         /** cfg dev+CLK, SIMO, SOMI pins */
> +    u8           CLKOut;         /** drive the CLK */
> +    u8           CSEnable[8];    /** cfg the associated CS as output */
> +    u8           ENAEnable;      /** cfg the ENA pin for SPI function */
> +    u32          CLKRate;        /** default clock rate */
> +    u8           Spare[8];
> +};
> +
> +struct LCDConfig {
> +    u8           Enable;
> +    u8           PanelName[32];
> +};
> +
> +struct ENETConfig {
> +    u32          EnetConfig;
> +    u8           MACAddr[6];
> +    u32          PHYMask;
> +    u8           Spare[8];
> +};
> +
> +#define MCASP_PINMODE_INACTIVE 0
> +#define MCASP_PINMODE_TX       1
> +#define MCASP_PINMODE_RX       2
> +
> +struct MCASPConfig {
> +    u8           Enable;
> +    u8           Mode;
> +    u8           PinMode[16];
> +};
> +/**
> + * struct tag_peripherals is passed in via kernel ATAG_PERIPHERALS
> + */
> +struct tag_peripherals {
> +    u32                Version; /** == PERIPHERALS_VERSION */
> +    u8                 Manufacturer[64]; /** null terminated string indicating manufacturer */
> +    struct ENETConfig  ENETConfig;        /** Enable on-board ethernet */
> +    struct UARTConfig  UARTConfig[3];     /** default UART 0,1,2 Configuration */
> +    struct SPIConfig   SPIConfig[2];
> +    struct LCDConfig   LCDConfig;
> +    struct MCASPConfig MCASPConfig;
> +};
> +
> +/**
> + * This structure can only be grown.  You cannot make it smaller...
> + */
> +struct MityDSPL138Config {
> +    u32               ConfigMagicWord;   /** == CONFIG_MAGIC_WORD */
> +    u32               ConfigVersion;     /** version of the configuration block */
> +    u32               ConfigSizeBytes;   /** configuration size, in bytes */
> +    struct tag_peripherals Peripherals;
> +};
> +
> +struct MityDSPL138ConfigBlock {
> +    union {
> +        struct    MityDSPL138Config config;
> +        u8    space[CONFIG_MITYDSP_ENV_SIZE-sizeof(int)];
> +    } Data;
> +    unsigned int    CheckSum; /** summed bytes of ConfigSizeBytes */
> +};
> +
> +extern struct MityDSPL138Config config_block;
> +extern struct I2CFactoryConfig  factory_config_block;
> +extern int get_config_block(void);
> +extern int get_factory_config_block(void);

These are not defined in this patch.

> +
> +#endif
> diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
> index 1b31a9a..1989316 100644
> --- a/arch/arm/mach-davinci/include/mach/da8xx.h
> +++ b/arch/arm/mach-davinci/include/mach/da8xx.h
> @@ -41,6 +41,7 @@ extern void __iomem *da8xx_syscfg1_base;
>  #define DA8XX_SYSCFG0_BASE    (IO_PHYS + 0x14000)
>  #define DA8XX_SYSCFG0_VIRT(x)    (da8xx_syscfg0_base + (x))
>  #define DA8XX_JTAG_ID_REG    0x18
> +#define DA8XX_MSTPRI2_REG    0x118
>  #define DA8XX_CFGCHIP0_REG    0x17c
>  #define DA8XX_CFGCHIP2_REG    0x184
>  #define DA8XX_CFGCHIP3_REG    0x188
> diff --git a/arch/arm/mach-davinci/include/mach/uncompress.h b/arch/arm/mach-davinci/include/mach/uncompress.h
> index 15a6192..db6f1cd 100644
> --- a/arch/arm/mach-davinci/include/mach/uncompress.h
> +++ b/arch/arm/mach-davinci/include/mach/uncompress.h
> @@ -88,6 +88,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
>          /* DA8xx boards */
>          DEBUG_LL_DA8XX(davinci_da830_evm,    2);
>          DEBUG_LL_DA8XX(davinci_da850_evm,    2);
> +        DEBUG_LL_DA8XX(mityomapl138,    1);

Need to thank Cyril here for making this so simple.

Thanks,
Sekhar
