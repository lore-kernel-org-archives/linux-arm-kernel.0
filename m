From: yunhui.cui@nxp.com (Yunhui Cui)
Date: Mon, 1 Feb 2016 11:23:16 +0000
Subject: [PATCH 3/3] mtd:spi-nor:fsl-quadspi:Add fast-read mode support
In-Reply-To: <56AB7C6E.2050300@atmel.com>
References: <1454067669-35274-1-git-send-email-B56489@freescale.com>
 <1454067669-35274-4-git-send-email-B56489@freescale.com>
 <56AB7C6E.2050300@atmel.com>
Message-ID: <AM3PR04MB14416F884013EEE1E889AEB994DE0@AM3PR04MB1441.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cyrille,

Thanks for your suggestions very much, I'll resend version 2 patch set.

Best Regards
Yunhui

-----Original Message-----
From: Cyrille Pitchen [mailto:cyrille.pitchen at atmel.com] 
Sent: Friday, January 29, 2016 10:51 PM
To: Yunhui Cui; dwmw2 at infradead.org; computersforpeace at gmail.com; han.xu at freescale.com
Cc: linux-mtd at lists.infradead.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Yao Yuan
Subject: Re: [PATCH 3/3] mtd:spi-nor:fsl-quadspi:Add fast-read mode support

Hi Yunhui,

Le 29/01/2016 12:41, Yunhui Cui a ?crit :
> The qspi driver add generic fast-read mode for different flash 
> venders, including Micron family. Also add some special operations for 
> Micron flash read/write in spi-nor.c.
> 
> Signed-off-by: Yunhui Cui <B56489@freescale.com>
> ---
>  drivers/mtd/spi-nor/fsl-quadspi.c | 27 +++++++++++++++++++++------
>  drivers/mtd/spi-nor/spi-nor.c     |  6 +++++-
>  2 files changed, 26 insertions(+), 7 deletions(-)
> 
[...]
> diff --git a/drivers/mtd/spi-nor/spi-nor.c 
> b/drivers/mtd/spi-nor/spi-nor.c index ed0c19c..79a025c 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -763,7 +763,8 @@ static const struct flash_info spi_nor_ids[] = {
>  	{ "n25q064",     INFO(0x20ba17, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_QUAD_READ) },
>  	{ "n25q064a",    INFO(0x20bb17, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_QUAD_READ) },
>  	{ "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256, SPI_NOR_QUAD_READ) },
> -	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, SPI_NOR_QUAD_READ) },
> +	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, SPI_NOR_FAST |
> +			SPI_NOR_QUAD_READ) },
>  	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_QUAD_READ) },
>  	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
>  	{ "n25q512ax3",  INFO(0x20ba20, 0, 64 * 1024, 1024, SECT_4K | 
> USE_FSR | SPI_NOR_QUAD_READ) },
This modification looks wrong.

First SPI_NOR_FAST is part of enum read_mode (from spi-nor.h) and is not intended to be used as a flag, unlike SPI_NOR_QUAD_READ (defined in spi-nor.c just below the flags field of struct flash_info).

Also, creating a new flag to choose between the Read and the Fast Read commands is not needed: see my last comment below.


> @@ -1233,6 +1234,7 @@ int spi_nor_scan(struct spi_nor *nor, const char 
> *name, enum read_mode mode)
>  
>  	if (JEDEC_MFR(info) == SNOR_MFR_ATMEL ||
>  	    JEDEC_MFR(info) == SNOR_MFR_INTEL ||
> +	    JEDEC_MFR(info) == SNOR_MFR_MICRON ||
>  	    JEDEC_MFR(info) == SNOR_MFR_SST) {
>  		write_enable(nor);
>  		write_sr(nor, 0);
This update is not related with the support of fast-read mode, it deals with the write protection. Hence it should be moved into a dedicated patch.

Also be careful as some bits of the Status Register are non-volatile on Micron memories. This modification may change their values but I guess you only want to clear the write enable/disable (7) bit.


> @@ -1317,6 +1319,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>  		nor->flash_read = SPI_NOR_QUAD;
>  	} else if (mode == SPI_NOR_DUAL && info->flags & SPI_NOR_DUAL_READ) {
>  		nor->flash_read = SPI_NOR_DUAL;
> +	} else if (mode == SPI_NOR_FAST && info->flags & SPI_NOR_FAST) {
> +		nor->flash_read = SPI_NOR_FAST;
>  	}
>  
>  	/* Default commands */
> 
The spi-nor framework already checks the "m25p,fast-read" DT property to choose between the Read (0x03) and Fast Read (0x0b) command.

So the fsl-quadspi.c driver should rely on this existing property to choose which of SPI_NOR_FAST or SPI_NOR_QUAD is used as the mode argument of spi_nor_scan(). As long as mode is neither SPI_NOR_QUAD nor SPI_NOR_DUAL, the choice of the read op code is done according to whether the "m25p,fast-read" DT property is set or not.


Best regards,

Cyrille
