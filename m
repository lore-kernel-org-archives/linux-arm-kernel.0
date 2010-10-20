From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Wed, 20 Oct 2010 14:26:59 +0300
Subject: [patch 8/9] efikamx: add spi nor support
In-Reply-To: <20101019205301.326830829@rtp-net.org>
References: <20101019204253.162641893@rtp-net.org>
	<20101019205301.326830829@rtp-net.org>
Message-ID: <20101020112659.GK2562@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Oct 19, Arnaud Patard wrote:
> On efikamx, uboot is stored on a nor spi flash. Add support for it
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Index: linux-2.6/arch/arm/mach-mx5/board-mx51_efikamx.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-mx5/board-mx51_efikamx.c	2010-10-16 14:21:24.000000000 +0200
> +++ linux-2.6/arch/arm/mach-mx5/board-mx51_efikamx.c	2010-10-16 15:34:12.000000000 +0200
> @@ -24,6 +24,8 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/fsl_devices.h>
> +#include <linux/spi/flash.h>
> +#include <linux/spi/spi.h>
>  
>  #include <mach/common.h>
>  #include <mach/hardware.h>
> @@ -52,6 +54,9 @@
>  
>  #define EFIKAMX_POWER_KEY	(1*32+31)
>  
> +#define EFIKAMX_SPI_CS0		(3*32+24)
> +#define EFIKAMX_SPI_CS1		(3*32+25)

It is just a style thing, but could you make this (3*32 + 24). Makes it
easier on the eyes to read "4th gpio bank, 24th pin"

>  /* the pci ids pin have pull up. they're driven low according to board id */
>  #define MX51_PAD_PCBID0	IOMUX_PAD(0x518, 0x130, 3, 0x0,   0, PAD_CTL_PUS_100K_UP)
>  #define MX51_PAD_PCBID1	IOMUX_PAD(0x51C, 0x134, 3, 0x0,   0, PAD_CTL_PUS_100K_UP)
> @@ -99,6 +104,14 @@
>  
>  	/* power key */
>  	MX51_PAD_PWRKEY,
> +
> +	/* spi */
> +	MX51_PAD_CSPI1_MOSI__ECSPI1_MOSI,
> +	MX51_PAD_CSPI1_MISO__ECSPI1_MISO,
> +	MX51_PAD_CSPI1_SS0__GPIO_4_24,
> +	MX51_PAD_CSPI1_SS1__GPIO_4_25,
> +	MX51_PAD_CSPI1_RDY__ECSPI1_RDY,
> +	MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK,
>  };
>  
>  /* Serial ports */
> @@ -252,6 +265,47 @@
>  	},
>  };
>  
> +static struct mtd_partition mx51_efikamx_spi_nor_partitions[] = {
> +	{
> +	 .name = "u-boot",

"bootloader" ?

> +	 .offset = 0,
> +	 .size = SZ_256K,
> +	},
> +	{
> +	  .name = "config",
> +	  .offset = MTDPART_OFS_APPEND,
> +	  .size = SZ_64K,
> +	},
> +};
> +
> +static struct flash_platform_data mx51_efikamx_spi_flash_data = {
> +	.name		= "spi_flash",
> +	.parts		= mx51_efikamx_spi_nor_partitions,
> +	.nr_parts	= ARRAY_SIZE(mx51_efikamx_spi_nor_partitions),
> +	.type		= "sst25vf032b",
> +};
> +
> +static struct spi_board_info mx51_efikamx_spi_board_info[] __initdata = {
> +	{
> +		.modalias = "m25p80",
> +		.max_speed_hz = 25000000,
> +		.bus_num = 0,
> +		.chip_select = 1,
> +		.platform_data = &mx51_efikamx_spi_flash_data,
> +		.irq = -1,
> +	},
> +};
> +
> +static int mx51_efikamx_spi_cs[] = {
> +	EFIKAMX_SPI_CS0,
> +	EFIKAMX_SPI_CS1,
> +};
> +
> +static const struct spi_imx_master mx51_efikamx_spi_pdata __initconst = {
> +	.chipselect     = mx51_efikamx_spi_cs,
> +	.num_chipselect = ARRAY_SIZE(mx51_efikamx_spi_cs),
> +};
> +
>  static void __init mxc_board_init(void)
>  {
>  	mxc_iomux_v3_setup_multiple_pads(mx51efikamx_pads,
> @@ -269,6 +323,10 @@
>  
>  	platform_device_register(&mx51_efikamx_leds_device);
>  	platform_device_register(&mx51_efikamx_powerkey_device);
> +
> +	spi_register_board_info(mx51_efikamx_spi_board_info,
> +		ARRAY_SIZE(mx51_efikamx_spi_board_info));
> +	imx51_add_ecspi(0, &mx51_efikamx_spi_pdata);
>  }
>  
>  static void __init mx51_efikamx_timer_init(void)
> Index: linux-2.6/arch/arm/mach-mx5/Kconfig
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-mx5/Kconfig	2010-10-16 14:21:24.000000000 +0200
> +++ linux-2.6/arch/arm/mach-mx5/Kconfig	2010-10-16 14:21:28.000000000 +0200
> @@ -81,6 +81,7 @@
>  	bool "Support MX51 Genesi Efika MX nettop"
>  	select IMX_HAVE_PLATFORM_IMX_UART
>  	select IMX_HAVE_PLATFORM_ESDHC
> +	select IMX_HAVE_PLATFORM_SPI_IMX
>  	help
>  	  Include support for Genesi Efika MX nettop. This includes specific
>  	  configurations for the board and its peripherals.
> 
> 
