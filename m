From: marex@denx.de (Marek Vasut)
Date: Mon, 24 Aug 2015 12:48:17 +0200
Subject: [PATCH linux-next v4 3/5] mtd: spi-nor: allow to tune the number
 of dummy cycles
In-Reply-To: <b0d8470fdd46e89ef692e27dc2600b880c1d5dde.1440410236.git.cyrille.pitchen@atmel.com>
References: <cover.1440410236.git.cyrille.pitchen@atmel.com>
 <b0d8470fdd46e89ef692e27dc2600b880c1d5dde.1440410236.git.cyrille.pitchen@atmel.com>
Message-ID: <201508241248.17466.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 24, 2015 at 12:13:58 PM, Cyrille Pitchen wrote:
> The number of dummy cycles used during Fast Read commands can be reduced
> to improve transfer performances. Each manufacturer has a dedicated set of
> registers to provide the memory with the exact number of dummy cycles it
> should expect. Both the memory and the (Q)SPI controller must agree on
> this number of dummy cycles.
> 
> The number of dummy cycles can be found into the memory datasheet and
> mostly depends on the SPI clock frequency, the Fast Read op code and the
> Single/Dual Data Rate mode.
> 
> Probing JEDEC Serial Flash Discoverable Parameters (SFDP) tables would
> only provide the driver with a high enough number of dummy cycles for each
> Fast Read command to be used for all clock frequencies: this solution
> would not be optimized.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>

Hi!

>  drivers/mtd/spi-nor/spi-nor.c | 97
> ++++++++++++++++++++++++++++++++++--------- include/linux/mtd/spi-nor.h  
> |  2 +
>  2 files changed, 80 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index e2a6029dc056..869e098a6841 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -119,24 +119,6 @@ static int read_cr(struct spi_nor *nor)
>  }
> 
>  /*
> - * Dummy Cycle calculation for different type of read.
> - * It can be used to support more commands with
> - * different dummy cycle requirements.
> - */
> -static inline int spi_nor_read_dummy_cycles(struct spi_nor *nor)
> -{
> -	switch (nor->flash_read) {
> -	case SPI_NOR_FAST:
> -	case SPI_NOR_DUAL:
> -	case SPI_NOR_QUAD:
> -		return 8;
> -	case SPI_NOR_NORMAL:
> -		return 0;
> -	}
> -	return 0;
> -}

You can probably just soup up this function so that it sets the
nor->read_dummy, no ?

> -/*
>   * Write status register 1 byte
>   * Returns negative if error occurred.
>   */
> @@ -1012,6 +994,81 @@ static int set_quad_mode(struct spi_nor *nor, struct
> flash_info *info) }
>  }
> 
> +static int micron_set_dummy_cycles(struct spi_nor *nor)
> +{
> +	int ret;
> +	u8 val, mask;
> +
> +	/* read the Volatile Configuration Register (VCR) */

NIT: If this is a sentence, start it with capital letter and end it with 
fullstop :)

> +	ret = nor->read_reg(nor, SPINOR_OP_RD_VCR, &val, 1);
> +	if (ret < 0) {
> +		dev_err(nor->dev, "error %d reading VCR\n", ret);
> +		return ret;
> +	}
> +
> +	write_enable(nor);
> +
> +	/* update the number of dummy into the VCR */

DTTO

> +	mask = GENMASK(7, 4);
> +	val &= ~mask;
> +	val |= (nor->read_dummy << 4) & mask;
> +	ret = nor->write_reg(nor, SPINOR_OP_WR_VCR, &val, 1, 0);
> +	if (ret < 0) {
> +		dev_err(nor->dev, "error while writing VCR register\n");
> +		return ret;
> +	}
> +
> +	ret = spi_nor_wait_till_ready(nor);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/*
> + * Dummy Cycle calculation for different type of read.
> + * It can be used to support more commands with
> + * different dummy cycle requirements.
> + */
> +static int spi_nor_read_dummy_cycles(struct spi_nor *nor,
> +				     const struct flash_info *info)
> +{
> +	struct device_node *np = nor->dev->of_node;
> +	u32 num_dummy_cycles;
> +
> +	if (np && !of_property_read_u32(np, "m25p,num-dummy-cycles",
> +					&num_dummy_cycles)) {
> +		nor->read_dummy = num_dummy_cycles;
> +
> +		/*
> +		 * This switch block might be moved after the if...then...else
> +		 * statement but it was not tested with all Spansion or Micron
> +		 * memories.
> +		 * Now the "m25p,num-dummy-cycles" property needs to be
> +		 * explicitly set in the device tree so the switch statement is
> +		 * executed. This should avoid unwanted side effects and keep
> +		 * backward compatibility.
> +		 */
> +		switch (JEDEC_MFR(info)) {
> +		case CFI_MFR_ST:
> +			return micron_set_dummy_cycles(nor);
> +		default:

If you do have m25p,num-dummy-cycles set for non-micron flash, you have a 
problem here I believe.

> +			break;
> +		}
> +	} else {

The solution would be to drop this else {} bit here, so that if you fail in
the DT-based configuration, you fall back to this old behavior. What do you 
think please ? :)

> +		switch (nor->flash_read) {
> +		case SPI_NOR_FAST:
> +		case SPI_NOR_DUAL:
> +		case SPI_NOR_QUAD:
> +			nor->read_dummy = 8;
> +		case SPI_NOR_NORMAL:
> +			nor->read_dummy = 0;
> +		}
> +	}
> +
> +	return 0;
> +}

[...]
