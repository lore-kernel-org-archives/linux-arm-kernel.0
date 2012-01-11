From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 11 Jan 2012 09:12:31 +0100
Subject: [PATCH V2 2/4] CS89x0 : add CS89x0 platform device to the
 iMX21ADS board
In-Reply-To: <1326237255-23630-1-git-send-email-jaccon.bastiaansen@gmail.com>
References: <1326237255-23630-1-git-send-email-jaccon.bastiaansen@gmail.com>
Message-ID: <20120111081231.GK14252@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jan 11, 2012 at 12:14:15AM +0100, Jaccon Bastiaansen wrote:
> Add CS89x0 networking support to the iMX21ADS board by using the
> platform driver support in the CS89x0 driver.
> 
> Signed-off-by: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
> ---
>  arch/arm/configs/imx_v4_v5_defconfig |    2 ++
>  arch/arm/mach-imx/mach-mx21ads.c     |   25 ++++++++++++++++++++++---
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
> index 11a4192..fc0106f 100644
> --- a/arch/arm/configs/imx_v4_v5_defconfig
> +++ b/arch/arm/configs/imx_v4_v5_defconfig
> @@ -81,6 +81,8 @@ CONFIG_NET_ETHERNET=y
>  CONFIG_SMC91X=y
>  CONFIG_DM9000=y
>  CONFIG_SMC911X=y
> +CONFIG_CS89x0=y
> +CONFIG_CS89x0_PLATFORM=y
>  # CONFIG_NETDEV_1000 is not set
>  # CONFIG_NETDEV_10000 is not set
>  # CONFIG_INPUT_MOUSEDEV is not set
> diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
> index 25f8402..faefdf8 100644
> --- a/arch/arm/mach-imx/mach-mx21ads.c
> +++ b/arch/arm/mach-imx/mach-mx21ads.c
> @@ -38,7 +38,6 @@
>  		(MX21ADS_MMIO_BASE_ADDR + (offset))
>  
>  #define MX21ADS_CS8900A_IRQ         IRQ_GPIOE(11)
> -#define MX21ADS_CS8900A_IOBASE_REG  MX21ADS_REG_ADDR(0x000000)
>  #define MX21ADS_ST16C255_IOBASE_REG MX21ADS_REG_ADDR(0x200000)
>  #define MX21ADS_VERSION_REG         MX21ADS_REG_ADDR(0x400000)
>  #define MX21ADS_IO_REG              MX21ADS_REG_ADDR(0x800000)
> @@ -159,6 +158,26 @@ static struct platform_device mx21ads_nor_mtd_device = {
>  	.resource = &mx21ads_flash_resource,
>  };
>  
> +static struct resource mx21ads_cs8900_resources[] = {
> +	{
> +		.start = MX21_CS1_BASE_ADDR,
> +		.end = MX21_CS1_BASE_ADDR + 0x200000 - 1,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	{
> +		.start = MX21ADS_CS8900A_IRQ,
> +		.end = MX21ADS_CS8900A_IRQ,
> +		.flags = IORESOURCE_IRQ,
> +	}
> +};
> +
> +static struct platform_device mx21ads_cs8900_device = {
> +	.name = "cs89x0",
> +	.id = 0,
> +	.num_resources = ARRAY_SIZE(mx21ads_cs8900_resources),
> +	.resource = mx21ads_cs8900_resources
> +};
> +
Nowadays we prefer dynamic initialisation over static structs. (A struct
platform_device takes 300 and a few bytes IIRC and just occupies memory
if you boot a machine different from mx21ads.) So the right incantation
is:

	static const struct resource mx21ads_cs8900_resources[] __initconst = {
		...
	};

	static const struct platform_device_info mx21ads_cs8900_devinfo __initconst = {
		.name = "cs89x0",
		.id = 0;
		.res = mx21ads_cs8900_resources,
		.num_res = ARRAY_SIZE(mx21ads_cs8900_resources),
	};

	platform_device_register_full(&mx21ads_cs8900_devinfo);

>  static const struct imxuart_platform_data uart_pdata_rts __initconst = {
>  	.flags = IMXUART_HAVE_RTSCTS,
>  };
> @@ -254,14 +273,13 @@ mx21ads_nand_board_info __initconst = {
>  static struct map_desc mx21ads_io_desc[] __initdata = {
>  	/*
>  	 * Memory-mapped I/O on MX21ADS Base board:
> -	 *   - CS8900A Ethernet controller
>  	 *   - ST16C2552CJ UART
>  	 *   - CPU and Base board version
>  	 *   - Base board I/O register
>  	 */
>  	{
>  		.virtual = MX21ADS_MMIO_BASE_ADDR,
> -		.pfn = __phys_to_pfn(MX21_CS1_BASE_ADDR),
> +		.pfn = __phys_to_pfn(MX21_CS1_BASE_ADDR + 0x200000),
>  		.length = MX21ADS_MMIO_SIZE,
>  		.type = MT_DEVICE,
>  	},
Maybe add a comment here why an offset is used here and maybe use a
nice #define for it instead of a bare number.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
