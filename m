From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 29 Jul 2014 22:08:43 -0700
Subject: [PATCH v2 03/10] mtd: spi-nor: add DDR quad read support
In-Reply-To: <1398657227-20721-4-git-send-email-b32955@freescale.com>
References: <1398657227-20721-1-git-send-email-b32955@freescale.com>
 <1398657227-20721-4-git-send-email-b32955@freescale.com>
Message-ID: <20140730050843.GE11952@brian-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Huang,

Sorry to address this series so late.

I have a few questions about how you determine support for these DDR
modes.

On Mon, Apr 28, 2014 at 11:53:40AM +0800, Huang Shijie wrote:
> This patch adds the DDR quad read support by the following:

To Mark / linux-spi:

Are DDR modes in the scope of drivers/spi/ at all, so that we could
someday wire it up through m25p80.c? Or is 'DDR' such a distortion of
the meaning of 'SPI' such that it will be restricted only to SPI NOR
dedicated controllers?

>   [1] add SPI_NOR_DDR_QUAD read mode.
> 
>   [2] add DDR Quad read opcodes:
>        SPINOR_OP_READ_1_4_4_D / SPINOR_OP_READ4_1_4_4_D
> 
>   [3] add set_ddr_quad_mode() to initialize for the DDR quad read.
>       Currently it only works for Spansion NOR.
> 
>   [3] about the dummy cycles.
>       We set the dummy with 8 for DDR quad read by default.

Why? That seems wrong. You need to know for sure how many cycles should
be used, not just guess a default.

>       The m25p80.c can not support the DDR quad read, but the SPI NOR controller
>       can set the dummy value in its child DT node, and the SPI NOR framework
>       can parse it out.

Why does the dummy value belong in device tree? I think this can be
handled in software. You might, however, want a few other hardware
description parameters in device tree to help you.

So I think spi-nor.c needs to know a few things:

 1. Does the hardware/driver support DDR clocking?
 2. What granularity of dummy cycles are supported? So m25p80.c needs to
    communicate that it only supports dummy cycles of multiples of 8,
    and fsl-quadspi supports single clock cycles.

And spi-nor.c should be able to do the following:

 3. Set how many dummy cycles should be used.
 4. Write to the configuration register, to choose a Latency Code
    according to what the flash supports. I see modes that support 3, 6,
    7, or 8. We'd probably just go for the fastest mode, which requires
    8, right?

So far, none of this seems to require a DT binding, unless there's
something I'm missing about your fsl-quadspi controller.

> Test this patch for Spansion s25fl128s NOR flash.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c |   54 +++++++++++++++++++++++++++++++++++++++-
>  include/linux/mtd/spi-nor.h   |    8 ++++-
>  2 files changed, 58 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index f374e44..e0bc11a 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -73,7 +73,20 @@ static int read_cr(struct spi_nor *nor)
>   */
>  static inline int spi_nor_read_dummy_cycles(struct spi_nor *nor)
>  {
> +	u32 dummy;
> +
>  	switch (nor->flash_read) {
> +	case SPI_NOR_DDR_QUAD:
> +		/*
> +		 * The m25p80.c can not support the DDR quad read.
> +		 * We set the dummy cycles to 8 by default. The SPI NOR
> +		 * controller driver can set it in its child DT node.
> +		 * We parse it out here.
> +		 */
> +		if (nor->np && !of_property_read_u32(nor->np,
> +				"spi-nor,ddr-quad-read-dummy", &dummy)) {
> +			return dummy;
> +		}
>  	case SPI_NOR_FAST:
>  	case SPI_NOR_DUAL:
>  	case SPI_NOR_QUAD:
> @@ -402,6 +415,7 @@ struct flash_info {
>  #define	SECT_4K_PMC		0x10	/* SPINOR_OP_BE_4K_PMC works uniformly */
>  #define	SPI_NOR_DUAL_READ	0x20    /* Flash supports Dual Read */
>  #define	SPI_NOR_QUAD_READ	0x40    /* Flash supports Quad Read */
> +#define	SPI_NOR_DDR_QUAD_READ	0x80    /* Flash supports DDR Quad Read */
>  };
>  
>  #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors, _flags)	\
> @@ -846,6 +860,24 @@ static int spansion_quad_enable(struct spi_nor *nor)
>  	return 0;
>  }
>  
> +static int set_ddr_quad_mode(struct spi_nor *nor, u32 jedec_id)
> +{
> +	int status;
> +
> +	switch (JEDEC_MFR(jedec_id)) {
> +	case CFI_MFR_AMD: /* Spansion, actually */
> +		status = spansion_quad_enable(nor);
> +		if (status) {
> +			dev_err(nor->dev,
> +				"Spansion DDR quad-read not enabled\n");
> +			return status;
> +		}
> +		return status;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int set_quad_mode(struct spi_nor *nor, u32 jedec_id)
>  {
>  	int status;
> @@ -1016,8 +1048,15 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
>  	if (info->flags & SPI_NOR_NO_FR)
>  		nor->flash_read = SPI_NOR_NORMAL;
>  
> -	/* Quad/Dual-read mode takes precedence over fast/normal */
> -	if (mode == SPI_NOR_QUAD && info->flags & SPI_NOR_QUAD_READ) {
> +	/* DDR Quad/Quad/Dual-read mode takes precedence over fast/normal */
> +	if (mode == SPI_NOR_DDR_QUAD && info->flags & SPI_NOR_DDR_QUAD_READ) {

Hmm, I think I should probably take another look at the design of
spi-nor.c... Why does spi_nor_scan() take a single 'mode' argument? The
driver should be communicating which (multiple) modes it supports, not
selecting a single mode. spi-nor.c is the only one which knows what the
*flash* supports, so it should be combining knowledge from the
controller driver with its own knowledge of the flash.

> +		ret = set_ddr_quad_mode(nor, info->jedec_id);
> +		if (ret) {
> +			dev_err(dev, "DDR quad mode not supported\n");
> +			return ret;

A ramification of my comment above is that we should not be returning an
error in a situation like this; we should be able to fall back to
another known-supported mode, like SDR QUAD, SDR DUAL, or just plain
SPI -- if they're supported by the driver -- and spi-nor.c doesn't
currently have enough information to do this.

> +		}
> +		nor->flash_read = SPI_NOR_DDR_QUAD;
> +	} else if (mode == SPI_NOR_QUAD && info->flags & SPI_NOR_QUAD_READ) {
>  		ret = set_quad_mode(nor, info->jedec_id);
>  		if (ret) {
>  			dev_err(dev, "quad mode not supported\n");
> @@ -1030,6 +1069,14 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
>  
>  	/* Default commands */
>  	switch (nor->flash_read) {
> +	case SPI_NOR_DDR_QUAD:
> +		if (JEDEC_MFR(info->jedec_id) == CFI_MFR_AMD) { /* Spansion */
> +			nor->read_opcode = SPINOR_OP_READ_1_4_4_D;
> +		} else {
> +			dev_err(dev, "DDR Quad Read is not supported.\n");
> +			return -EINVAL;
> +		}
> +		break;
>  	case SPI_NOR_QUAD:
>  		nor->read_opcode = SPINOR_OP_READ_1_1_4;
>  		break;
> @@ -1057,6 +1104,9 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
>  		if (JEDEC_MFR(info->jedec_id) == CFI_MFR_AMD) {
>  			/* Dedicated 4-byte command set */
>  			switch (nor->flash_read) {
> +			case SPI_NOR_DDR_QUAD:
> +				nor->read_opcode = SPINOR_OP_READ4_1_4_4_D;
> +				break;
>  			case SPI_NOR_QUAD:
>  				nor->read_opcode = SPINOR_OP_READ4_1_1_4;
>  				break;
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 48fe9fc..d191a6b 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -12,10 +12,11 @@
>  
>  /*
>   * Note on opcode nomenclature: some opcodes have a format like
> - * SPINOR_OP_FUNCTION{4,}_x_y_z. The numbers x, y, and z stand for the number
> + * SPINOR_OP_FUNCTION{4,}_x_y_z{_D}. The numbers x, y, and z stand for the number
>   * of I/O lines used for the opcode, address, and data (respectively). The
>   * FUNCTION has an optional suffix of '4', to represent an opcode which
> - * requires a 4-byte (32-bit) address.
> + * requires a 4-byte (32-bit) address. The suffix of 'D' stands for the
> + * DDR mode.
>   */
>  
>  /* Flash opcodes. */
> @@ -26,6 +27,7 @@
>  #define SPINOR_OP_READ_FAST	0x0b	/* Read data bytes (high frequency) */
>  #define SPINOR_OP_READ_1_1_2	0x3b	/* Read data bytes (Dual SPI) */
>  #define SPINOR_OP_READ_1_1_4	0x6b	/* Read data bytes (Quad SPI) */
> +#define SPINOR_OP_READ_1_4_4_D	0xed	/* Read data bytes (DDR Quad SPI) */
>  #define SPINOR_OP_PP		0x02	/* Page program (up to 256 bytes) */
>  #define SPINOR_OP_BE_4K		0x20	/* Erase 4KiB block */
>  #define SPINOR_OP_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips */
> @@ -40,6 +42,7 @@
>  #define SPINOR_OP_READ4_FAST	0x0c	/* Read data bytes (high frequency) */
>  #define SPINOR_OP_READ4_1_1_2	0x3c	/* Read data bytes (Dual SPI) */
>  #define SPINOR_OP_READ4_1_1_4	0x6c	/* Read data bytes (Quad SPI) */
> +#define SPINOR_OP_READ4_1_4_4_D	0xee	/* Read data bytes (DDR Quad SPI) */
>  #define SPINOR_OP_PP_4B		0x12	/* Page program (up to 256 bytes) */
>  #define SPINOR_OP_SE_4B		0xdc	/* Sector erase (usually 64KiB) */
>  
> @@ -74,6 +77,7 @@ enum read_mode {
>  	SPI_NOR_FAST,
>  	SPI_NOR_DUAL,
>  	SPI_NOR_QUAD,
> +	SPI_NOR_DDR_QUAD,
>  };
>  
>  /**

So, I'll have to take another hard look at spi-nor.c soon. I think we
may need to work on the abstractions here a bit more before I merge any
new features like this.

Regards,
Brian

P.S. Is there a good reason we've defined a whole read_xfer/write_xfer
API that is completely unused?
