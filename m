From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 11 Jan 2016 11:24:21 +0100
Subject: [PATCH linux-next v2 03/14] mtd: spi-nor: select op codes and
 SPI NOR protocols by manufacturer
In-Reply-To: <fd5ca97795c35b3df5ffee95075e2e03a70c7e48.1452268345.git.cyrille.pitchen@atmel.com>
References: <cover.1452268345.git.cyrille.pitchen@atmel.com>
 <fd5ca97795c35b3df5ffee95075e2e03a70c7e48.1452268345.git.cyrille.pitchen@atmel.com>
Message-ID: <20160111112421.5919b531@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 8 Jan 2016 17:02:15 +0100
Cyrille Pitchen <cyrille.pitchen@atmel.com> wrote:

> This is a transitional patch to prepare the split by Manufacturer of the
> support of Single/Dual/Quad SPI modes.
> 
> Indeed every QSPI NOR manufacturer (Spansion, Micron, Macronix, Winbond)
> supports Dual or Quad SPI modes on its way. Especially the Fast Read op
> code and the SPI NOR protocols to use are not quite the same depending on
> the manufacturer.
> 
> For instance Quad commands can use either the SPI 1-1-4, 1-4-4 or 4-4-4
> protocol.
> 
> This is why this patch will be completed by fixes for each manufacturer.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 110 ++++++++++++++++++++++++++++++++----------
>  include/linux/mtd/spi-nor.h   |  12 +++--
>  2 files changed, 92 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 8967319ea7da..8793cebbe5a9 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1180,17 +1180,61 @@ static int set_quad_mode(struct spi_nor *nor, const struct flash_info *info)
>  			dev_err(nor->dev, "Macronix quad-read not enabled\n");
>  			return -EINVAL;
>  		}
> -		return status;
> +		/* Check whether Macronix QPI mode is enabled. */
> +		if (nor->read_proto != SNOR_PROTO_4_4_4)
> +			nor->read_proto = SNOR_PROTO_1_1_4;
> +		break;
> +
>  	case SNOR_MFR_MICRON:
> -		return 0;
> -	default:
> +		/* Check whether Micron Quad mode is enabled. */
> +		if (nor->read_proto != SNOR_PROTO_4_4_4)
> +			nor->read_proto = SNOR_PROTO_1_1_4;
> +		break;
> +
> +	case SNOR_MFR_SPANSION:

The following comment is not only related to your changes, but after
looking at the spi_nor_scan() function and a few other functions in the
core, I see a lot of vendor specific initialization.

Would it make sense to somehow set a default configuration in
spi_nor_scan() and then overload this default config using a
per-manufacturer ->init() method. Something like that.

struct spi_nor_manufacturer {
	int (*init)(struct spi_nor *nor, const struct flash_info *fi);
}

static const struct spi_nor_manufacturer manufacturers[] = {
	[<manuf-id>] = {
		.init = <manuf-init-callback>
	},
};

Of course you could add other methods if you think this differentiation
is needed after the initialization step.

>  		status = spansion_quad_enable(nor);
>  		if (status) {
>  			dev_err(nor->dev, "Spansion quad-read not enabled\n");
>  			return -EINVAL;
>  		}
> -		return status;
> +		nor->read_proto = SNOR_PROTO_1_1_4;
> +		break;
> +
> +	default:
> +		return -EINVAL;
>  	}
> +
> +	nor->read_opcode = SPINOR_OP_READ_1_1_4;
> +	return 0;
> +}
> +
> +static int set_dual_mode(struct spi_nor *nor, const struct flash_info *info)
> +{
> +	switch (JEDEC_MFR(info)) {
> +	case SNOR_MFR_MICRON:
> +		/* Check whether Micron Dual mode is enabled. */
> +		if (nor->read_proto != SNOR_PROTO_2_2_2)
> +			nor->read_proto = SNOR_PROTO_1_1_2;
> +		break;
> +
> +	default:
> +		nor->read_proto = SNOR_PROTO_1_1_2;
> +		break;
> +	}
> +
> +	nor->read_opcode = SPINOR_OP_READ_1_1_2;
> +	return 0;
> +}
> +
> +static int set_single_mode(struct spi_nor *nor, const struct flash_info *info)
> +{
> +	switch (JEDEC_MFR(info)) {
> +	default:
> +		nor->read_proto = SNOR_PROTO_1_1_1;
> +		break;
> +	}

You can just put

	nor->read_proto = SNOR_PROTO_1_1_1;

until you have a manufacturer specific case.

> +
> +	return 0;
>  }
>  
>  static int spi_nor_check(struct spi_nor *nor)
> @@ -1338,7 +1382,30 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>  	if (info->flags & SPI_NOR_NO_FR)
>  		nor->flash_read = SPI_NOR_NORMAL;
>  
> -	/* Quad/Dual-read mode takes precedence over fast/normal */
> +	/* Default commands */
> +	if (nor->flash_read == SPI_NOR_NORMAL)
> +		nor->read_opcode = SPINOR_OP_READ;
> +	else
> +		nor->read_opcode = SPINOR_OP_READ_FAST;
> +
> +	nor->program_opcode = SPINOR_OP_PP;
> +
> +	/*
> +	 * Quad/Dual-read mode takes precedence over fast/normal.
> +	 *
> +	 * Manufacturer specific modes are discovered when reading the JEDEC ID
> +	 * and are reported by the nor->read_proto value:
> +	 *  - SNOR_PROTO_4_4_4 is either:
> +	 *    + Micron Quad mode enabled
> +	 *    + Macronix/Winbond QPI mode enabled
> +	 *  - SNOR_PROTO_2_2_2 is either:
> +	 *    + Micron Dual mode enabled
> +	 *
> +	 * The opcodes and the protocols are updated depending on the
> +	 * manufacturer.
> +	 * The read opcode and protocol should be updated by the relevant
> +	 * function when entering Quad or Dual mode.
> +	 */
>  	if (mode == SPI_NOR_QUAD && info->flags & SPI_NOR_QUAD_READ) {
>  		ret = set_quad_mode(nor, info);
>  		if (ret) {
> @@ -1347,30 +1414,21 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>  		}
>  		nor->flash_read = SPI_NOR_QUAD;
>  	} else if (mode == SPI_NOR_DUAL && info->flags & SPI_NOR_DUAL_READ) {
> +		ret = set_dual_mode(nor, info);
> +		if (ret) {
> +			dev_err(dev, "dual mode not supported\n");
> +			return ret;
> +		}
>  		nor->flash_read = SPI_NOR_DUAL;
> +	} else if (info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)) {
> +		/* We may need to leave a Quad or Dual mode */
> +		ret = set_single_mode(nor, info);
> +		if (ret) {
> +			dev_err(dev, "failed to switch back to single mode\n");
> +			return ret;
> +		}
>  	}
>  
> -	/* Default commands */
> -	switch (nor->flash_read) {
> -	case SPI_NOR_QUAD:
> -		nor->read_opcode = SPINOR_OP_READ_1_1_4;
> -		break;
> -	case SPI_NOR_DUAL:
> -		nor->read_opcode = SPINOR_OP_READ_1_1_2;
> -		break;
> -	case SPI_NOR_FAST:
> -		nor->read_opcode = SPINOR_OP_READ_FAST;
> -		break;
> -	case SPI_NOR_NORMAL:
> -		nor->read_opcode = SPINOR_OP_READ;
> -		break;
> -	default:
> -		dev_err(dev, "No Read opcode defined\n");
> -		return -EINVAL;
> -	}
> -
> -	nor->program_opcode = SPINOR_OP_PP;
> -
>  	if (info->addr_width)
>  		nor->addr_width = info->addr_width;
>  	else if (mtd->size > 0x1000000) {
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 53932c87bcf2..89e3228ec1d0 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -42,8 +42,10 @@
>  #define SPINOR_OP_WRSR		0x01	/* Write status register 1 byte */
>  #define SPINOR_OP_READ		0x03	/* Read data bytes (low frequency) */
>  #define SPINOR_OP_READ_FAST	0x0b	/* Read data bytes (high frequency) */
> -#define SPINOR_OP_READ_1_1_2	0x3b	/* Read data bytes (Dual SPI) */
> -#define SPINOR_OP_READ_1_1_4	0x6b	/* Read data bytes (Quad SPI) */
> +#define SPINOR_OP_READ_1_1_2	0x3b	/* Read data bytes (Dual Output SPI) */
> +#define SPINOR_OP_READ_1_2_2	0xbb	/* Read data bytes (Dual I/O SPI) */
> +#define SPINOR_OP_READ_1_1_4	0x6b	/* Read data bytes (Quad Output SPI) */
> +#define SPINOR_OP_READ_1_4_4	0xeb	/* Read data bytes (Quad I/O SPI) */
>  #define SPINOR_OP_PP		0x02	/* Page program (up to 256 bytes) */
>  #define SPINOR_OP_BE_4K		0x20	/* Erase 4KiB block */
>  #define SPINOR_OP_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips */
> @@ -57,8 +59,10 @@
>  /* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
>  #define SPINOR_OP_READ4		0x13	/* Read data bytes (low frequency) */
>  #define SPINOR_OP_READ4_FAST	0x0c	/* Read data bytes (high frequency) */
> -#define SPINOR_OP_READ4_1_1_2	0x3c	/* Read data bytes (Dual SPI) */
> -#define SPINOR_OP_READ4_1_1_4	0x6c	/* Read data bytes (Quad SPI) */
> +#define SPINOR_OP_READ4_1_1_2	0x3c	/* Read data bytes (Dual Output SPI) */
> +#define SPINOR_OP_READ4_1_2_2	0xbc	/* Read data bytes (Dual I/O SPI) */
> +#define SPINOR_OP_READ4_1_1_4	0x6c	/* Read data bytes (Quad Output SPI) */
> +#define SPINOR_OP_READ4_1_4_4	0xec	/* Read data bytes (Quad I/O SPI) */
>  #define SPINOR_OP_PP_4B		0x12	/* Page program (up to 256 bytes) */
>  #define SPINOR_OP_SE_4B		0xdc	/* Sector erase (usually 64KiB) */
>  



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
