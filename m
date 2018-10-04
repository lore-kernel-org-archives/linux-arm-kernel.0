From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Thu, 4 Oct 2018 11:14:53 +0200
Subject: [PATCH 2/4] mtd: spi-nor: add support for octal mode data transfer
In-Reply-To: <1538642920-3843-3-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1538642920-3843-3-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <20181004111453.1ef576f9@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  4 Oct 2018 14:18:38 +0530
Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Add support for octal mode data transfer for Micron mt35xu512aba.
> 
> Unfortunately, this flash is only complaint to SFDP JESD216B and does
> not seem to support newer JESD216C standard that provides auto detection
> of Octal mode capabilities and opcodes. Therefore, this capability is
> manually added using new SPI_NOR_OCTAL_READ flag.
> 
> Added support of Octal mode parsing for 'm25p80' spi-nor flash interface.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
>  drivers/mtd/devices/m25p80.c  |  9 ++++++++-
>  drivers/mtd/spi-nor/spi-nor.c | 14 +++++++++++++-
>  include/linux/mtd/spi-nor.h   |  8 ++++++++

You mix a lot of changes in a single patch, please try to split it up:

1/ Add new opcodes and patch spi_nor_convert_3to4_read/program() and
   spi_nor_init_params()
2/ Modify m25p80.c to support octal mode
3/ Add a new entry for mt35xu512aba

>  3 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index fe260cc..e22aa2b 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -182,7 +182,14 @@ static int m25p_probe(struct spi_mem *spimem)
>  	spi_mem_set_drvdata(spimem, flash);
>  	flash->spimem = spimem;
>  
> -	if (spi->mode & SPI_RX_QUAD) {
> +	if (spi->mode & SPI_RX_OCTAL) {
> +		hwcaps.mask |= SNOR_HWCAPS_READ_1_1_8;
> +
> +		if (spi->mode & SPI_TX_OCTAL)
> +			hwcaps.mask |= (SNOR_HWCAPS_READ_1_8_8 |
> +					SNOR_HWCAPS_PP_1_1_8 |
> +					SNOR_HWCAPS_PP_1_8_8);
> +	} else if (spi->mode & SPI_RX_QUAD) {
>  		hwcaps.mask |= SNOR_HWCAPS_READ_1_1_4;
>  
>  		if (spi->mode & SPI_TX_QUAD)
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 6042df8..0587b9c 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -89,6 +89,7 @@ struct flash_info {
>  #define NO_CHIP_ERASE		BIT(12) /* Chip does not support chip erase */
>  #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
>  #define USE_CLSR		BIT(14)	/* use CLSR command */
> +#define SPI_NOR_OCTAL_READ	BIT(15)	/* Flash supports Octal Read */
>  
>  	int	(*quad_enable)(struct spi_nor *nor);
>  };
> @@ -208,6 +209,8 @@ static inline u8 spi_nor_convert_3to4_read(u8 opcode)
>  		{ SPINOR_OP_READ_1_2_2,	SPINOR_OP_READ_1_2_2_4B },
>  		{ SPINOR_OP_READ_1_1_4,	SPINOR_OP_READ_1_1_4_4B },
>  		{ SPINOR_OP_READ_1_4_4,	SPINOR_OP_READ_1_4_4_4B },
> +		{ SPINOR_OP_READ_1_1_8,	SPINOR_OP_READ_1_1_8_4B },
> +		{ SPINOR_OP_READ_1_8_8,	SPINOR_OP_READ_1_8_8_4B },
>  
>  		{ SPINOR_OP_READ_1_1_1_DTR,	SPINOR_OP_READ_1_1_1_DTR_4B },
>  		{ SPINOR_OP_READ_1_2_2_DTR,	SPINOR_OP_READ_1_2_2_DTR_4B },
> @@ -224,6 +227,8 @@ static inline u8 spi_nor_convert_3to4_program(u8 opcode)
>  		{ SPINOR_OP_PP,		SPINOR_OP_PP_4B },
>  		{ SPINOR_OP_PP_1_1_4,	SPINOR_OP_PP_1_1_4_4B },
>  		{ SPINOR_OP_PP_1_4_4,	SPINOR_OP_PP_1_4_4_4B },
> +		{ SPINOR_OP_PP_1_1_8,	SPINOR_OP_PP_1_1_8_4B },
> +		{ SPINOR_OP_PP_1_8_8,	SPINOR_OP_PP_1_8_8_4B },
>  	};
>  
>  	return spi_nor_convert_opcode(opcode, spi_nor_3to4_program,
> @@ -1114,7 +1119,7 @@ static const struct flash_info spi_nor_ids[] = {
>  	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
>  
>  	/* Micron */
> -	{ "mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512, SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES) },
> +	{ "mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512, SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
>  
>  	/* PMC */
>  	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2, SECT_4K_PMC) },
> @@ -2493,6 +2498,13 @@ static int spi_nor_init_params(struct spi_nor *nor,
>  					  SNOR_PROTO_1_1_4);
>  	}
>  
> +	if (info->flags & SPI_NOR_OCTAL_READ) {
> +		params->hwcaps.mask |= SNOR_HWCAPS_READ_1_1_8;
> +		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_8],
> +					  0, 8, SPINOR_OP_READ_1_1_8,
> +					  SNOR_PROTO_1_1_8);
> +	}
> +
>  	/* Page Program settings. */
>  	params->hwcaps.mask |= SNOR_HWCAPS_PP;
>  	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP],
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index f43bfc5..b23c69d 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -50,9 +50,13 @@
>  #define SPINOR_OP_READ_1_2_2	0xbb	/* Read data bytes (Dual I/O SPI) */
>  #define SPINOR_OP_READ_1_1_4	0x6b	/* Read data bytes (Quad Output SPI) */
>  #define SPINOR_OP_READ_1_4_4	0xeb	/* Read data bytes (Quad I/O SPI) */
> +#define SPINOR_OP_READ_1_1_8	0x8b	/* Read data bytes (Octal Output SPI) */
> +#define SPINOR_OP_READ_1_8_8	0xcb	/* Read data bytes (Octal I/O SPI) */
>  #define SPINOR_OP_PP		0x02	/* Page program (up to 256 bytes) */
>  #define SPINOR_OP_PP_1_1_4	0x32	/* Quad page program */
>  #define SPINOR_OP_PP_1_4_4	0x38	/* Quad page program */
> +#define SPINOR_OP_PP_1_1_8	0x82	/* Octal page program */
> +#define SPINOR_OP_PP_1_8_8	0xc2	/* Octal page program */
>  #define SPINOR_OP_BE_4K		0x20	/* Erase 4KiB block */
>  #define SPINOR_OP_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips */
>  #define SPINOR_OP_BE_32K	0x52	/* Erase 32KiB block */
> @@ -73,9 +77,13 @@
>  #define SPINOR_OP_READ_1_2_2_4B	0xbc	/* Read data bytes (Dual I/O SPI) */
>  #define SPINOR_OP_READ_1_1_4_4B	0x6c	/* Read data bytes (Quad Output SPI) */
>  #define SPINOR_OP_READ_1_4_4_4B	0xec	/* Read data bytes (Quad I/O SPI) */
> +#define SPINOR_OP_READ_1_1_8_4B	0x7c	/* Read data bytes (Octal Output SPI) */
> +#define SPINOR_OP_READ_1_8_8_4B	0xcc	/* Read data bytes (Octal I/O SPI) */
>  #define SPINOR_OP_PP_4B		0x12	/* Page program (up to 256 bytes) */
>  #define SPINOR_OP_PP_1_1_4_4B	0x34	/* Quad page program */
>  #define SPINOR_OP_PP_1_4_4_4B	0x3e	/* Quad page program */
> +#define SPINOR_OP_PP_1_1_8_4B	0x84	/* Octal page program */
> +#define SPINOR_OP_PP_1_8_8_4B	0x8e	/* Octal page program */
>  #define SPINOR_OP_BE_4K_4B	0x21	/* Erase 4KiB block */
>  #define SPINOR_OP_BE_32K_4B	0x5c	/* Erase 32KiB block */
>  #define SPINOR_OP_SE_4B		0xdc	/* Sector erase (usually 64KiB) */
