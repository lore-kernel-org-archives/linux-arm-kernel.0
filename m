From: broonie@kernel.org (Mark Brown)
Date: Thu, 7 May 2015 11:30:10 +0100
Subject: [PATCH 2/2] spi: sirf: add support for USP-based SPI
In-Reply-To: <1430982791-8681-2-git-send-email-21cnbao@gmail.com>
References: <1430982791-8681-1-git-send-email-21cnbao@gmail.com>
 <1430982791-8681-2-git-send-email-21cnbao@gmail.com>
Message-ID: <20150507103010.GK22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 07, 2015 at 07:13:11AM +0000, Barry Song wrote:

This all looks mostly fine, there are a few comments below but they're
all coding style things rather than anything else so should be easy
enough to address.

> +#define SIRFSOC_SPI_FIFO_LEVEL_MASK(s)	((s->spi_type == SIRF_REAL_SPI) ? \
> +					0xFF : ((s->is_atlas7_usp == 1) ? \
> +					0x1FF : 0x7F))

This pattern isn't very legible and isn't going to scale if there's more
types added (eg, some new variant with a bigger FIFO).  Can you make
these static inline functions with switch and if statements instead?  It
looks like they should all fit into that pattern.  

It'd probably help make the patch easier to read if the changes to use
these functions were added as separate patches - add the functions and
convert everything to use them, then in a separate patch add the options
for the new variants.

> +	.spi_dummy_delay_ctrl	= 0x144,
> +};
> +struct sirf_spi_register sirf_usp_spi = {

Can we have blank lines between the structs please?  Also the structs
should be declared as static const so they're not in the global
namespace.

> +		if (sspi->spi_type == SIRF_REAL_SPI) {
> +			u32 regval = readl(sspi->base + spi_reg->spi_ctrl);
> +
> +			writel(regval, sspi->base + spi_reg->spi_ctrl);

...

> +		} else {
> +			u32 regval = readl(sspi->base +
> +					spi_reg->usp_pin_io_data);

Please write this as a switch statement so it's easier to handle an new
variants.  Similarly for any other things that handle variants with if
statements.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150507/dcf1df74/attachment.sig>
