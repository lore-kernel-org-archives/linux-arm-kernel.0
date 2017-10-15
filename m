From: gerg@linux-m68k.org (Greg Ungerer)
Date: Mon, 16 Oct 2017 09:34:13 +1000
Subject: [PATCH 4/4] ARM: imx: Update spi_imx platform data to reflect
 current state
In-Reply-To: <20171013195410.30767-4-tpiepho@impinj.com>
References: <20171013195410.30767-1-tpiepho@impinj.com>
 <20171013195410.30767-4-tpiepho@impinj.com>
Message-ID: <8cdf2bc7-e0ab-b8ec-1cc5-7cc397f13197@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Trent,

On 14/10/17 05:54, Trent Piepho wrote:
> The docs for the spi_imx platform data still refer to a -32 offset used to
> specify a native chip select.  This was removed in commit 602c8f4485cd
> ("spi: imx: fix use of native chip-selects with devicetree") and no
> longer works as documented.  Update documentation.
> 
> The macro MXC_SPI_CS() is no longer is needed.
> 
> If a board uses all native chip selects, then it's not necessary to
> specify a chip select array at all, as all native is the default (this is
> how device-tree configured SPI masters work too).  Most of the spi-imx
> platform data users have their chip select arrays removed by this patch.
> 
> This patch also fixes a bug in mx31moboard introduced in the '602 commit.
> When that board was updated in commit 901f26bce64a ("ARM: imx: set
> correct chip_select in platform setup") to reflect the SPI change, only
> SPI bus 2 was updated and SPI bus 1 was left with non-sequential chip
> selects.  The mc13783 spi device on bus 1 had its chip select updated as
> if it were on bus 2.
> 
> CC: Greg Ungerer <gerg@linux-m68k.org>

Looks like a nice cleanup.
For whatever it is worth:

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg



> CC: Shawn Guo <shawnguo@kernel.org>
> CC: Sascha Hauer <kernel@pengutronix.de>
> CC: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>
> ---
>  arch/arm/mach-imx/mach-mx31_3ds.c     | 18 ++----------------
>  arch/arm/mach-imx/mach-mx31lilly.c    | 12 ++----------
>  arch/arm/mach-imx/mach-mx31lite.c     | 16 ++--------------
>  arch/arm/mach-imx/mach-mx31moboard.c  | 17 +++--------------
>  arch/arm/mach-imx/mach-pcm037_eet.c   |  5 +----
>  include/linux/platform_data/spi-imx.h | 29 +++++++++++++++++------------
>  6 files changed, 27 insertions(+), 70 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
> index 68c3f0799d5b..9d87f1dcf7bb 100644
> --- a/arch/arm/mach-imx/mach-mx31_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx31_3ds.c
> @@ -374,26 +374,12 @@ static struct imx_ssi_platform_data mx31_3ds_ssi_pdata = {
>  };
>  
>  /* SPI */
> -static int spi0_internal_chipselect[] = {
> -	MXC_SPI_CS(0),
> -	MXC_SPI_CS(1),
> -	MXC_SPI_CS(2),
> -};
> -
>  static const struct spi_imx_master spi0_pdata __initconst = {
> -	.chipselect	= spi0_internal_chipselect,
> -	.num_chipselect	= ARRAY_SIZE(spi0_internal_chipselect),
> -};
> -
> -static int spi1_internal_chipselect[] = {
> -	MXC_SPI_CS(0),
> -	MXC_SPI_CS(1),
> -	MXC_SPI_CS(2),
> +	.num_chipselect	= 3,
>  };
>  
>  static const struct spi_imx_master spi1_pdata __initconst = {
> -	.chipselect	= spi1_internal_chipselect,
> -	.num_chipselect	= ARRAY_SIZE(spi1_internal_chipselect),
> +	.num_chipselect	= 3,
>  };
>  
>  static struct spi_board_info mx31_3ds_spi_devs[] __initdata = {
> diff --git a/arch/arm/mach-imx/mach-mx31lilly.c b/arch/arm/mach-imx/mach-mx31lilly.c
> index 6fd463642954..8bf52819d4d9 100644
> --- a/arch/arm/mach-imx/mach-mx31lilly.c
> +++ b/arch/arm/mach-imx/mach-mx31lilly.c
> @@ -226,20 +226,12 @@ static void __init lilly1131_usb_init(void)
>  
>  /* SPI */
>  
> -static int spi_internal_chipselect[] = {
> -	MXC_SPI_CS(0),
> -	MXC_SPI_CS(1),
> -	MXC_SPI_CS(2),
> -};
> -
>  static const struct spi_imx_master spi0_pdata __initconst = {
> -	.chipselect = spi_internal_chipselect,
> -	.num_chipselect = ARRAY_SIZE(spi_internal_chipselect),
> +	.num_chipselect = 3,
>  };
>  
>  static const struct spi_imx_master spi1_pdata __initconst = {
> -	.chipselect = spi_internal_chipselect,
> -	.num_chipselect = ARRAY_SIZE(spi_internal_chipselect),
> +	.num_chipselect = 3,
>  };
>  
>  static struct mc13xxx_platform_data mc13783_pdata __initdata = {
> diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
> index f033a57d5694..fcbaf0070ccf 100644
> --- a/arch/arm/mach-imx/mach-mx31lite.c
> +++ b/arch/arm/mach-imx/mach-mx31lite.c
> @@ -83,15 +83,8 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
>  };
>  
>  /* SPI */
> -static int spi0_internal_chipselect[] = {
> -	MXC_SPI_CS(0),
> -	MXC_SPI_CS(1),
> -	MXC_SPI_CS(2),
> -};
> -
>  static const struct spi_imx_master spi0_pdata __initconst = {
> -	.chipselect	= spi0_internal_chipselect,
> -	.num_chipselect	= ARRAY_SIZE(spi0_internal_chipselect),
> +	.num_chipselect	= 3,
>  };
>  
>  static const struct mxc_nand_platform_data
> @@ -133,13 +126,8 @@ static struct platform_device smsc911x_device = {
>   * The MC13783 is the only hard-wired SPI device on the module.
>   */
>  
> -static int spi1_internal_chipselect[] = {
> -	MXC_SPI_CS(0),
> -};
> -
>  static const struct spi_imx_master spi1_pdata __initconst = {
> -	.chipselect	= spi1_internal_chipselect,
> -	.num_chipselect	= ARRAY_SIZE(spi1_internal_chipselect),
> +	.num_chipselect	= 1,
>  };
>  
>  static struct mc13xxx_platform_data mc13783_pdata __initdata = {
> diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
> index 7716f83aecdd..643a3d749703 100644
> --- a/arch/arm/mach-imx/mach-mx31moboard.c
> +++ b/arch/arm/mach-imx/mach-mx31moboard.c
> @@ -152,14 +152,8 @@ static const struct imxi2c_platform_data moboard_i2c1_data __initconst = {
>  	.bitrate = 100000,
>  };
>  
> -static int moboard_spi1_cs[] = {
> -	MXC_SPI_CS(0),
> -	MXC_SPI_CS(2),
> -};
> -
>  static const struct spi_imx_master moboard_spi1_pdata __initconst = {
> -	.chipselect	= moboard_spi1_cs,
> -	.num_chipselect	= ARRAY_SIZE(moboard_spi1_cs),
> +	.num_chipselect	= 3,
>  };
>  
>  static struct regulator_consumer_supply sdhc_consumers[] = {
> @@ -296,19 +290,14 @@ static struct spi_board_info moboard_spi_board_info[] __initdata = {
>  		/* irq number is run-time assigned */
>  		.max_speed_hz = 300000,
>  		.bus_num = 1,
> -		.chip_select = 1,
> +		.chip_select = 0,
>  		.platform_data = &moboard_pmic,
>  		.mode = SPI_CS_HIGH,
>  	},
>  };
>  
> -static int moboard_spi2_cs[] = {
> -	MXC_SPI_CS(0), MXC_SPI_CS(1),
> -};
> -
>  static const struct spi_imx_master moboard_spi2_pdata __initconst = {
> -	.chipselect	= moboard_spi2_cs,
> -	.num_chipselect	= ARRAY_SIZE(moboard_spi2_cs),
> +	.num_chipselect	= 2,
>  };
>  
>  #define SDHC1_CD IOMUX_TO_GPIO(MX31_PIN_ATA_CS0)
> diff --git a/arch/arm/mach-imx/mach-pcm037_eet.c b/arch/arm/mach-imx/mach-pcm037_eet.c
> index 95bd97710494..15bc956d466b 100644
> --- a/arch/arm/mach-imx/mach-pcm037_eet.c
> +++ b/arch/arm/mach-imx/mach-pcm037_eet.c
> @@ -56,11 +56,8 @@ static struct spi_board_info pcm037_spi_dev[] = {
>  };
>  
>  /* Platform Data for MXC CSPI */
> -static int pcm037_spi1_cs[] = { MXC_SPI_CS(0), MXC_SPI_CS(1), };
> -
>  static const struct spi_imx_master pcm037_spi1_pdata __initconst = {
> -	.chipselect = pcm037_spi1_cs,
> -	.num_chipselect = ARRAY_SIZE(pcm037_spi1_cs),
> +	.num_chipselect = 2,
>  };
>  
>  /* GPIO-keys input device */
> diff --git a/include/linux/platform_data/spi-imx.h b/include/linux/platform_data/spi-imx.h
> index 08be445e8eb8..9b2ed66ef7a2 100644
> --- a/include/linux/platform_data/spi-imx.h
> +++ b/include/linux/platform_data/spi-imx.h
> @@ -4,24 +4,29 @@
>  
>  /*
>   * struct spi_imx_master - device.platform_data for SPI controller devices.
> - * @chipselect: Array of chipselects for this master. Numbers >= 0 mean gpio
> - *              pins, numbers < 0 mean internal CSPI chipselects according
> - *              to MXC_SPI_CS(). Normally you want to use gpio based chip
> - *              selects as the CSPI module tries to be intelligent about
> - *              when to assert the chipselect: The CSPI module deasserts the
> - *              chipselect once it runs out of input data. The other problem
> - *              is that it is not possible to mix between high active and low
> - *              active chipselects on one single bus using the internal
> - *              chipselects. Unfortunately Freescale decided to put some
> + * @chipselect: Array of chipselects for this master or NULL.  Numbers >= 0
> + *              mean GPIO pins, -ENOENT means internal CSPI chipselect
> + *              matching the position in the array.  E.g., if chipselect[1] =
> + *              -ENOENT then a SPI slave using chip select 1 will use the
> + *              native SS1 line of the CSPI.  Omitting the array will use
> + *              all native chip selects.
> +
> + *              Normally you want to use gpio based chip selects as the CSPI
> + *              module tries to be intelligent about when to assert the
> + *              chipselect:  The CSPI module deasserts the chipselect once it
> + *              runs out of input data.  The other problem is that it is not
> + *              possible to mix between high active and low active chipselects
> + *              on one single bus using the internal chipselects.
> + *              Unfortunately, on some SoCs, Freescale decided to put some
>   *              chipselects on dedicated pins which are not usable as gpios,
>   *              so we have to support the internal chipselects.
> - * @num_chipselect: ARRAY_SIZE(chipselect)
> + *
> + * @num_chipselect: If @chipselect is specified, ARRAY_SIZE(chipselect),
> + *                  otherwise the number of native chip selects.
>   */
>  struct spi_imx_master {
>  	int	*chipselect;
>  	int	num_chipselect;
>  };
>  
> -#define MXC_SPI_CS(no)	((no) - 32)
> -
>  #endif /* __MACH_SPI_H_*/
> 
