From: marex@denx.de (Marek Vasut)
Date: Mon, 24 Aug 2015 18:48:50 +0200
Subject: [PATCH linux-next v4 3/5] mtd: spi-nor: allow to tune the number
 of dummy cycles
In-Reply-To: <55DB4986.1000207@atmel.com>
References: <cover.1440410236.git.cyrille.pitchen@atmel.com>
 <201508241248.17466.marex@denx.de> <55DB4986.1000207@atmel.com>
Message-ID: <201508241848.50974.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 24, 2015 at 06:42:46 PM, Cyrille Pitchen wrote:
> Hi Marek,

Hi!

[...]

> >> - * Dummy Cycle calculation for different type of read.
> >> - * It can be used to support more commands with
> >> - * different dummy cycle requirements.
> >> - */
> >> -static inline int spi_nor_read_dummy_cycles(struct spi_nor *nor)
> >> -{
> >> -	switch (nor->flash_read) {
> >> -	case SPI_NOR_FAST:
> >> -	case SPI_NOR_DUAL:
> >> -	case SPI_NOR_QUAD:
> >> -		return 8;
> >> -	case SPI_NOR_NORMAL:
> >> -		return 0;
> >> -	}
> >> -	return 0;
> >> -}
> > 
> > You can probably just soup up this function so that it sets the
> > nor->read_dummy, no ?
> 
> Actually, this is what the patch does: spi_nor_read_dummy_cycles() was
> reused and enhanced few lines below where you've pointed out the
> "switch (nor->flash_read)" block should be move after the else block.

You know what? I'll go get some sleep, coffee doesn't cut it anymore :)

> I think when I wrote the code I've chosen to move the definition of this
> function instead of adding forward declarations of functions such as
> read_cr() or write_sr_cr(), which are now called by
> micron_set_dummy_cycles().

Yep, that's all right, sorry for the confusion.

> >> -/*
> >> 
> >>   * Write status register 1 byte
> >>   * Returns negative if error occurred.
> >>   */
> >> 
> >> @@ -1012,6 +994,81 @@ static int set_quad_mode(struct spi_nor *nor,
> >> struct flash_info *info) }
> >> 
> >>  }

[...]

> >> +/*
> >> + * Dummy Cycle calculation for different type of read.
> >> + * It can be used to support more commands with
> >> + * different dummy cycle requirements.
> >> + */
> >> +static int spi_nor_read_dummy_cycles(struct spi_nor *nor,
> >> +				     const struct flash_info *info)
> >> +{
> >> +	struct device_node *np = nor->dev->of_node;
> >> +	u32 num_dummy_cycles;
> >> +
> >> +	if (np && !of_property_read_u32(np, "m25p,num-dummy-cycles",
> >> +					&num_dummy_cycles)) {
> >> +		nor->read_dummy = num_dummy_cycles;
> >> +
> >> +		/*
> >> +		 * This switch block might be moved after the if...then...else
> >> +		 * statement but it was not tested with all Spansion or Micron
> >> +		 * memories.
> >> +		 * Now the "m25p,num-dummy-cycles" property needs to be
> >> +		 * explicitly set in the device tree so the switch statement is
> >> +		 * executed. This should avoid unwanted side effects and keep
> >> +		 * backward compatibility.
> >> +		 */
> >> +		switch (JEDEC_MFR(info)) {
> >> +		case CFI_MFR_ST:
> >> +			return micron_set_dummy_cycles(nor);
> > 
> >> +		default:
> > If you do have m25p,num-dummy-cycles set for non-micron flash, you have a
> > problem here I believe.
> > 
> >> +			break;
> >> +		}
> >> +	} else {
> > 
> > The solution would be to drop this else {} bit here, so that if you fail
> > in the DT-based configuration, you fall back to this old behavior. What
> > do you think please ? :)
> 
> Good idea!
> I also add a trace for the default case of "switch (JEDEC_MFR(info))":
> 
> dev_warn(dev, "can't set the number of dummy cycles\n");

Maybe change this to "setting the number of dummy cycles not supported by chip, 
ignoring" or something, to be explicit about the fallback and that this is not
supported by the chip. But this is just an idea, feel free to ignore it.

> So the user is notified that the driver could not use the value of
> "m25p,num-dummy-cycles" from the DT before falling back to the legacy
> code.

Yup.

> >> +		switch (nor->flash_read) {
> >> +		case SPI_NOR_FAST:
> >> +		case SPI_NOR_DUAL:
> >> +		case SPI_NOR_QUAD:
> >> +			nor->read_dummy = 8;
> >> +		case SPI_NOR_NORMAL:
> >> +			nor->read_dummy = 0;
> >> +		}
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> > 
> > [...]
> 
> thanks for the review!

Im glad it helped ;-)
