From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 15 Oct 2010 11:01:05 +0200
Subject: [PATCH v4] imx-esdhc: update devices registration
In-Reply-To: <1286904825-6432-1-git-send-email-eric@eukrea.com>
References: <20101012153155.GE4470@pengutronix.de>
	<1286904825-6432-1-git-send-email-eric@eukrea.com>
Message-ID: <20101015090105.GK6747@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Tue, Oct 12, 2010 at 07:33:45PM +0200, Eric B?nard wrote:
> Tested on i.MX25 and i.MX35 and i.MX51
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
Looks good now, but the patch doesn't apply for me:

	Applying: imx-esdhc: update devices registration
	fatal: sha1 information is lacking or useless
	(arch/arm/mach-mx5/devices-imx51.h).
	Repository lacks necessary blobs to fall back on 3-way merge.
	Cannot fall back to three-way merge.
	Patch failed at 0001 imx-esdhc: update devices registration
	When you have resolved this problem run "git am --resolved".
	If you would prefer to skip this patch, instead run "git am --skip".
	To restore the original branch and stop patching run "git am --abort".
	Press any key to continue...

Best regards
Uwe

> ---
> v4 : rename to ESDHC and remove non necessary defines
> v3 : remove generic bits from the structure
> v2 : remove SSI3 fixes which leaked in previous patch
> 
>  arch/arm/mach-mx25/devices-imx25.h              |    7 +--
>  arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c   |    2 +-
>  arch/arm/mach-mx3/devices-imx35.h               |    9 +---
>  arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c    |    2 +-
>  arch/arm/mach-mx3/mach-pcm043.c                 |    2 +-
>  arch/arm/mach-mx5/devices-imx51.h               |   11 +---
>  arch/arm/plat-mxc/devices/platform-esdhc.c      |   56 +++++++++++++++++++---
>  arch/arm/plat-mxc/include/mach/devices-common.h |   10 +++-
>  arch/arm/plat-mxc/include/mach/mx25.h           |    4 +-
>  arch/arm/plat-mxc/include/mach/mx35.h           |    6 +-
>  arch/arm/plat-mxc/include/mach/mx51.h           |   16 +++---
>  11 files changed, 80 insertions(+), 45 deletions(-)
> 
> diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
> index 733aaee..93afa10 100644
> --- a/arch/arm/mach-mx25/devices-imx25.h
> +++ b/arch/arm/mach-mx25/devices-imx25.h
> @@ -49,7 +49,6 @@ extern const struct imx_spi_imx_data imx25_spi_imx_data[] __initconst;
>  #define imx25_add_spi_imx1(pdata)	imx25_add_spi_imx(1, pdata)
>  #define imx25_add_spi_imx2(pdata)	imx25_add_spi_imx(2, pdata)
>  
> -#define imx25_add_esdhc0(pdata)	\
> -	imx_add_esdhc(0, MX25_ESDHC1_BASE_ADDR, SZ_16K, MX25_INT_MMC_SDHC1, pdata)
> -#define imx25_add_esdhc1(pdata)	\
> -	imx_add_esdhc(1, MX25_ESDHC2_BASE_ADDR, SZ_16K, MX25_INT_MMC_SDHC2, pdata)
> +extern const struct imx_esdhc_imx_data imx25_esdhc_data[] __initconst;
> +#define imx25_add_esdhc(id, pdata)	\
> +	imx_add_esdhc(&imx25_esdhc_data[id], pdata)
> diff --git a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
> index c1fe048..54a7cf9 100644
> --- a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
> +++ b/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
> @@ -245,7 +245,7 @@ void __init eukrea_mbimxsd25_baseboard_init(void)
>  	imx25_add_imx_ssi(0, &eukrea_mbimxsd_ssi_pdata);
>  
>  	imx25_add_flexcan1(NULL);
> -	imx25_add_esdhc0(NULL);
> +	imx25_add_esdhc(0, NULL);
>  
>  	gpio_request(GPIO_LED1, "LED1");
>  	gpio_direction_output(GPIO_LED1, 1);
> diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
> index 509b346..5eb917b 100644
> --- a/arch/arm/mach-mx3/devices-imx35.h
> +++ b/arch/arm/mach-mx3/devices-imx35.h
> @@ -46,9 +46,6 @@ extern const struct imx_spi_imx_data imx35_cspi_data[] __initconst;
>  #define imx35_add_spi_imx0(pdata)	imx35_add_cspi(0, pdata)
>  #define imx35_add_spi_imx1(pdata)	imx35_add_cspi(1, pdata)
>  
> -#define imx35_add_esdhc0(pdata)	\
> -	imx_add_esdhc(0, MX35_ESDHC1_BASE_ADDR, SZ_16K, MX35_INT_MMC_SDHC1, pdata)
> -#define imx35_add_esdhc1(pdata)	\
> -	imx_add_esdhc(1, MX35_ESDHC2_BASE_ADDR, SZ_16K, MX35_INT_MMC_SDHC2, pdata)
> -#define imx35_add_esdhc2(pdata)	\
> -	imx_add_esdhc(2, MX35_ESDHC3_BASE_ADDR, SZ_16K, MX35_INT_MMC_SDHC3, pdata)
> +extern const struct imx_esdhc_imx_data imx35_esdhc_data[] __initconst;
> +#define imx35_add_esdhc(id, pdata)	\
> +	imx_add_esdhc(&imx35_esdhc_data[id], pdata)
> diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
> index 8869599..e8946e0 100644
> --- a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
> +++ b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
> @@ -255,7 +255,7 @@ void __init eukrea_mbimxsd35_baseboard_init(void)
>  	imx35_add_imx_ssi(0, &eukrea_mbimxsd_ssi_pdata);
>  
>  	imx35_add_flexcan1(NULL);
> -	imx35_add_esdhc0(NULL);
> +	imx35_add_esdhc(0, NULL);
>  
>  	gpio_request(GPIO_LED1, "LED1");
>  	gpio_direction_output(GPIO_LED1, 1);
> diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
> index e790a00..a9397a4 100644
> --- a/arch/arm/mach-mx3/mach-pcm043.c
> +++ b/arch/arm/mach-mx3/mach-pcm043.c
> @@ -395,7 +395,7 @@ static void __init mxc_board_init(void)
>  		mxc_register_device(&mxc_otg_udc_device, &otg_device_pdata);
>  
>  	imx35_add_flexcan1(NULL);
> -	imx35_add_esdhc0(NULL);
> +	imx35_add_esdhc(0, NULL);
>  }
>  
>  static void __init pcm043_timer_init(void)
> diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
> index 547432d..5cc910e 100644
> --- a/arch/arm/mach-mx5/devices-imx51.h
> +++ b/arch/arm/mach-mx5/devices-imx51.h
> @@ -37,11 +37,6 @@ extern const struct imx_spi_imx_data imx51_ecspi_data[] __initconst;
>  #define imx51_add_ecspi(id, pdata)	\
>  	imx_add_spi_imx(&imx51_ecspi_data[id], pdata)
>  
> -#define imx51_add_esdhc0(pdata)	\
> -	imx_add_esdhc(0, MX51_MMC_SDHC1_BASE_ADDR, SZ_16K, MX51_MXC_INT_MMC_SDHC1, pdata)
> -#define imx51_add_esdhc1(pdata)	\
> -	imx_add_esdhc(1, MX51_MMC_SDHC2_BASE_ADDR, SZ_16K, MX51_MXC_INT_MMC_SDHC2, pdata)
> -#define imx51_add_esdhc2(pdata)	\
> -	imx_add_esdhc(2, MX51_MMC_SDHC3_BASE_ADDR, SZ_16K, MX51_MXC_INT_MMC_SDHC3, pdata)
> -#define imx51_add_esdhc3(pdata)	\
> -	imx_add_esdhc(3, MX51_MMC_SDHC4_BASE_ADDR, SZ_16K, MX51_MXC_INT_MMC_SDHC4, pdata)
> +extern const struct imx_esdhc_imx_data imx51_esdhc_data[] __initconst;
> +#define imx51_add_esdhc(id, pdata)	\
> +	imx_add_esdhc(&imx51_esdhc_data[id], pdata)
> diff --git a/arch/arm/plat-mxc/devices/platform-esdhc.c b/arch/arm/plat-mxc/devices/platform-esdhc.c
> index 68db2a2..2605bfa 100644
> --- a/arch/arm/plat-mxc/devices/platform-esdhc.c
> +++ b/arch/arm/plat-mxc/devices/platform-esdhc.c
> @@ -6,26 +6,66 @@
>   * Free Software Foundation.
>   */
>  
> +#include <mach/hardware.h>
>  #include <mach/devices-common.h>
>  #include <mach/esdhc.h>
>  
> -struct platform_device *__init imx_add_esdhc(int id,
> -		resource_size_t iobase, resource_size_t iosize,
> -		resource_size_t irq,
> +#define imx_esdhc_imx_data_entry_single(soc, _id, hwid) \
> +	{								\
> +		.id = _id,						\
> +		.iobase = soc ## _ESDHC ## hwid ## _BASE_ADDR,	\
> +		.irq = soc ## _INT_ESDHC ## hwid,			\
> +	}
> +
> +#define imx_esdhc_imx_data_entry(soc, id, hwid)	\
> +	[id] = imx_esdhc_imx_data_entry_single(soc, id, hwid)
> +
> +#ifdef CONFIG_ARCH_MX25
> +const struct imx_esdhc_imx_data imx25_esdhc_data[] __initconst = {
> +#define imx25_esdhc_data_entry(_id, _hwid)				\
> +	imx_esdhc_imx_data_entry(MX25, _id, _hwid)
> +	imx25_esdhc_data_entry(0, 1),
> +	imx25_esdhc_data_entry(1, 2),
> +};
> +#endif /* ifdef CONFIG_ARCH_MX25 */
> +
> +#ifdef CONFIG_ARCH_MX35
> +const struct imx_esdhc_imx_data imx35_esdhc_data[] __initconst = {
> +#define imx35_esdhc_data_entry(_id, _hwid)                           \
> +	imx_esdhc_imx_data_entry(MX35, _id, _hwid)
> +	imx35_esdhc_data_entry(0, 1),
> +	imx35_esdhc_data_entry(1, 2),
> +	imx35_esdhc_data_entry(2, 3),
> +};
> +#endif /* ifdef CONFIG_ARCH_MX35 */
> +
> +#ifdef CONFIG_ARCH_MX51
> +const struct imx_esdhc_imx_data imx51_esdhc_data[] __initconst = {
> +#define imx51_esdhc_data_entry(_id, _hwid)				\
> +	imx_esdhc_imx_data_entry(MX51, _id, _hwid)
> +	imx51_esdhc_data_entry(0, 1),
> +	imx51_esdhc_data_entry(1, 2),
> +	imx51_esdhc_data_entry(2, 3),
> +	imx51_esdhc_data_entry(3, 4),
> +};
> +#endif /* ifdef CONFIG_ARCH_MX51 */
> +
> +struct platform_device *__init imx_add_esdhc(
> +		const struct imx_esdhc_imx_data *data,
>  		const struct esdhc_platform_data *pdata)
>  {
>  	struct resource res[] = {
>  		{
> -			.start = iobase,
> -			.end = iobase + iosize - 1,
> +			.start = data->iobase,
> +			.end = data->iobase + SZ_16K - 1,
>  			.flags = IORESOURCE_MEM,
>  		}, {
> -			.start = irq,
> -			.end = irq,
> +			.start = data->irq,
> +			.end = data->irq,
>  			.flags = IORESOURCE_IRQ,
>  		},
>  	};
>  
> -	return imx_add_platform_device("sdhci-esdhc-imx", id, res,
> +	return imx_add_platform_device("sdhci-esdhc-imx", data->id, res,
>  			ARRAY_SIZE(res), pdata, sizeof(*pdata));
>  }
> diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
> index 0498978..86d7575 100644
> --- a/arch/arm/plat-mxc/include/mach/devices-common.h
> +++ b/arch/arm/plat-mxc/include/mach/devices-common.h
> @@ -108,7 +108,11 @@ struct platform_device *__init imx_add_spi_imx(
>  		const struct spi_imx_master *pdata);
>  
>  #include <mach/esdhc.h>
> -struct platform_device *__init imx_add_esdhc(int id,
> -		resource_size_t iobase, resource_size_t iosize,
> -		resource_size_t irq,
> +struct imx_esdhc_imx_data {
> +	int id;
> +	resource_size_t iobase;
> +	resource_size_t irq;
> +};
> +struct platform_device *__init imx_add_esdhc(
> +		const struct imx_esdhc_imx_data *data,
>  		const struct esdhc_platform_data *pdata);
> diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
> index 153dd1b..8e00793 100644
> --- a/arch/arm/plat-mxc/include/mach/mx25.h
> +++ b/arch/arm/plat-mxc/include/mach/mx25.h
> @@ -61,8 +61,8 @@
>  #define MX25_INT_I2C1		3
>  #define MX25_INT_I2C2		4
>  #define MX25_INT_UART4		5
> -#define MX25_INT_MMC_SDHC2	8
> -#define MX25_INT_MMC_SDHC1	9
> +#define MX25_INT_ESDHC2		8
> +#define MX25_INT_ESDHC1		9
>  #define MX25_INT_I2C3		10
>  #define MX25_INT_SSI2		11
>  #define MX25_INT_SSI1		12
> diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
> index cb071b7..ff905cb 100644
> --- a/arch/arm/plat-mxc/include/mach/mx35.h
> +++ b/arch/arm/plat-mxc/include/mach/mx35.h
> @@ -128,9 +128,9 @@
>  #define MX35_INT_I2C3		3
>  #define MX35_INT_I2C2		4
>  #define MX35_INT_RTIC		6
> -#define MX35_INT_MMC_SDHC1	7
> -#define MX35_INT_MMC_SDHC2	8
> -#define MX35_INT_MMC_SDHC3	9
> +#define MX35_INT_ESDHC1		7
> +#define MX35_INT_ESDHC2		8
> +#define MX35_INT_ESDHC3		9
>  #define MX35_INT_I2C1		10
>  #define MX35_INT_SSI1		11
>  #define MX35_INT_SSI2		12
> diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
> index c54b5c3..2af7a10 100644
> --- a/arch/arm/plat-mxc/include/mach/mx51.h
> +++ b/arch/arm/plat-mxc/include/mach/mx51.h
> @@ -64,13 +64,13 @@
>  #define MX51_SPBA0_BASE_ADDR_VIRT	0xfb100000
>  #define MX51_SPBA0_SIZE			SZ_1M
>  
> -#define MX51_MMC_SDHC1_BASE_ADDR	(MX51_SPBA0_BASE_ADDR + 0x04000)
> -#define MX51_MMC_SDHC2_BASE_ADDR	(MX51_SPBA0_BASE_ADDR + 0x08000)
> +#define MX51_ESDHC1_BASE_ADDR		(MX51_SPBA0_BASE_ADDR + 0x04000)
> +#define MX51_ESDHC2_BASE_ADDR		(MX51_SPBA0_BASE_ADDR + 0x08000)
>  #define MX51_UART3_BASE_ADDR		(MX51_SPBA0_BASE_ADDR + 0x0c000)
>  #define MX51_ECSPI1_BASE_ADDR		(MX51_SPBA0_BASE_ADDR + 0x10000)
>  #define MX51_SSI2_BASE_ADDR		(MX51_SPBA0_BASE_ADDR + 0x14000)
> -#define MX51_MMC_SDHC3_BASE_ADDR	(MX51_SPBA0_BASE_ADDR + 0x20000)
> -#define MX51_MMC_SDHC4_BASE_ADDR	(MX51_SPBA0_BASE_ADDR + 0x24000)
> +#define MX51_ESDHC3_BASE_ADDR		(MX51_SPBA0_BASE_ADDR + 0x20000)
> +#define MX51_ESDHC4_BASE_ADDR		(MX51_SPBA0_BASE_ADDR + 0x24000)
>  #define MX51_SPDIF_BASE_ADDR		(MX51_SPBA0_BASE_ADDR + 0x28000)
>  #define MX51_ATA_DMA_BASE_ADDR		(MX51_SPBA0_BASE_ADDR + 0x30000)
>  #define MX51_SLIM_DMA_BASE_ADDR		(MX51_SPBA0_BASE_ADDR + 0x34000)
> @@ -280,10 +280,10 @@
>   */
>  #define MX51_MXC_INT_BASE		0
>  #define MX51_MXC_INT_RESV0		0
> -#define MX51_MXC_INT_MMC_SDHC1		1
> -#define MX51_MXC_INT_MMC_SDHC2		2
> -#define MX51_MXC_INT_MMC_SDHC3		3
> -#define MX51_MXC_INT_MMC_SDHC4		4
> +#define MX51_INT_ESDHC1			1
> +#define MX51_INT_ESDHC2			2
> +#define MX51_INT_ESDHC3			3
> +#define MX51_INT_ESDHC4			4
>  #define MX51_MXC_INT_RESV5		5
>  #define MX51_INT_SDMA			6
>  #define MX51_MXC_INT_IOMUX		7
> -- 
> 1.7.0.4
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
