From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 22 Aug 2013 12:34:53 -0700
Subject: [PATCH V1 3/5] mtd: m25p80: add the quad-read support
In-Reply-To: <1376885403-12156-4-git-send-email-b32955@freescale.com>
References: <1376885403-12156-1-git-send-email-b32955@freescale.com>
 <1376885403-12156-4-git-send-email-b32955@freescale.com>
Message-ID: <20130822193453.GB10038@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding others (keep devicetree at vger.kernel.org in the loop)

On Mon, Aug 19, 2013 at 12:10:01PM +0800, Huang Shijie wrote:
> This patch adds the quad read support:
> 
> (1) Add the relative commands:
>       OPCODE_QIOR, OPCODE_4QIOR, OPCODE_RDCR,
> 
>     also add the relative macro for the Configuartion Register.
> 
> (2) add the "m25p,quad-read" property for the m25p80 driver
>     If the dts has the "m25p,quad-read" property, the kernel will
>     set the Quad bit of the configuration register, and when the
>     setting is suceeded, we set the read opcode with OPCODE_QIOR.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  Documentation/devicetree/bindings/mtd/m25p80.txt |    5 ++
>  drivers/mtd/devices/m25p80.c                     |   51 ++++++++++++++++++++++
>  include/linux/mtd/spi-nor.h                      |    6 +++
>  3 files changed, 62 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/m25p80.txt b/Documentation/devicetree/bindings/mtd/m25p80.txt
> index 6d3d576..b33313f 100644
> --- a/Documentation/devicetree/bindings/mtd/m25p80.txt
> +++ b/Documentation/devicetree/bindings/mtd/m25p80.txt
> @@ -17,6 +17,11 @@ Optional properties:
>                     Refer to your chips' datasheet to check if this is supported
>                     by your chip.
>  
> +- m25p,quad-read : Use the "quad read" opcode to read data from the chip instead
> +                   of the usual "read" opcode. This opcode is not supported by
> +                   all chips and support for it can not be detected at runtime.
> +                   Refer to your chips' datasheet to check if this is supported
> +                   by your chip.

Why can't this be detected at runtime? We added a "no fast read" flag to
the device table, so why not "dual/quad mode supported"? And believe it
or not, not all m25p80 users have device tree. So it isn't very logical
to tie this support to device-tree only.

>  Example:
>  
>  	flash: m25p80 at 0 {
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index f3598c1..4bc9b1b 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -103,6 +103,40 @@ static int write_sr(struct m25p *flash, u8 val)
>  }
>  
>  /*
> + * Read the configuration register, returning its value in the location
> + * Return the configuration register value.
> + * Returns negative if error occurred.
> + */
> +static int read_cr(struct m25p *flash)
> +{
> +	u8 code = OPCODE_RDCR;
> +	int ret;
> +	u8 val;
> +
> +	ret = spi_write_then_read(flash->spi, &code, 1, &val, 1);
> +	if (ret < 0) {
> +		dev_err(&flash->spi->dev, "error %d reading CR\n", ret);
> +		return ret;
> +	}
> +	return val;
> +}
> +
> +/*
> + * Write status register and configuration register with 2 bytes
> + * The first byte will be written to the status register, while the second byte
> + * will be written to the configuration register.
> + * Returns negative if error occurred.
> + */
> +static int write_sr_cr(struct m25p *flash, u16 val)
> +{
> +	flash->command[0] = OPCODE_WRSR;
> +	flash->command[1] = 0;
> +	flash->command[2] = (val >> 8);
> +
> +	return spi_write(flash->spi, flash->command, 3);
> +}
> +
> +/*
>   * Set write enable latch with Write Enable command.
>   * Returns negative if error occurred.
>   */
> @@ -880,6 +914,8 @@ static int m25p_probe(struct spi_device *spi)
>  	unsigned			i;
>  	struct mtd_part_parser_data	ppdata;
>  	struct device_node __maybe_unused *np = spi->dev.of_node;
> +	u16 sr_cr;
> +	int ret;
>  
>  #ifdef CONFIG_MTD_OF_PARTS
>  	if (!of_device_is_available(np))
> @@ -1014,6 +1050,21 @@ static int m25p_probe(struct spi_device *spi)
>  	else
>  		flash->read_opcode = OPCODE_NORM_READ;
>  
> +	/* Try to enable the Quad Read */
> +	if (np && of_property_read_bool(np, "m25p,quad-read")) {
> +		/* The configuration register is set by the second byte. */
> +		sr_cr = CR_QUAD << 8;
> +
> +		/* Write the QUAD bit to the Configuration Register. */
> +		write_enable(flash);
> +		if (write_sr_cr(flash, sr_cr) == 0) {
> +			/* read back and check it */
> +			ret = read_cr(flash);
> +			if (ret > 0 && (ret & CR_QUAD))
> +				flash->read_opcode = OPCODE_QIOR;

This is not correct. You are assuming that the SPI master knows to read
with 4 IO lines, instead of the traditional 1 line; IOW, you are
assuming that:
(1) if the slave DT node has "quad-read", then the whole system supports
    it (bad design; you're putting assumptions about the "parent" node
    in the child)
(2) the controller driver will act as your new driver does -- that it
    will decode these commands and recognize that the quad read command
    should be run on 4 IO lines, not just 1

What you're really missing from device-tree (and the SPI subystem in
general) is how to detect those SPI controllers which support dual and
quad mode transfers, and how to communicate that a particular SPI
transaction should be performed on 1 or 4 IO lines. We shouldn't have
this just hacked in via assumptions.

See Wang Yuhang's patch set for adding proper dual/quad support to the
SPI subsystem. It seems to be addressing (1) and (2) in a better way.

  http://thread.gmane.org/gmane.linux.kernel.spi.devel/14420

(I can't find patch 2/2)

> +		}
> +	}
> +
>  	flash->program_opcode = OPCODE_PP;
>  
>  	if (info->addr_width)
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index b420a5b..d5b189d 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -39,6 +39,9 @@
>  
>  /* Used for Spansion flashes only. */
>  #define	OPCODE_BRWR		0x17	/* Bank register write */
> +#define OPCODE_QIOR		0xeb	/* Quad read */
> +#define OPCODE_4QIOR		0xec	/* Quad read */

Use tab between 'define' and 'OPCODE...', like OPCODE_RDCR below.

> +#define	OPCODE_RDCR		0x35	/* Read configuration register */
>  
>  /* Status Register bits. */
>  #define	SR_WIP			1	/* Write in progress */
> @@ -49,4 +52,7 @@
>  #define	SR_BP2			0x10	/* Block protect 2 */
>  #define	SR_SRWD			0x80	/* SR write protect */
>  
> +/* Configuration Register bits. */
> +#define CR_QUAD			0x2	/* Quad I/O */
> +
>  #endif /* __LINUX_MTD_SPI_NOR_H */

Brian
