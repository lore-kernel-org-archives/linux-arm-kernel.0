From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 Dec 2013 13:42:17 +0000
Subject: [PATCH] spi:fsl-dspi:add support of DSPI IP in big endian
In-Reply-To: <1388388474-8662-1-git-send-email-b44548@freescale.com>
References: <1388388474-8662-1-git-send-email-b44548@freescale.com>
Message-ID: <20131230134217.GC31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 30, 2013 at 03:27:54PM +0800, Chao Fu wrote:

> +#define DSPI_BITWISE16(d, v)	(d->big_endian ? cpu_to_be16(v) : cpu_to_le16(v))
> +#define DSPI_BITWISE32(d, v)	(d->big_endian ? cpu_to_be32(v) : cpu_to_le32(v))
> +
> +#define dspi_readb(c)		readb(c)
> +#define dspi_readw(c)		({ u16 __v = (__force u16) __raw_readw(c); __iormb(); __v; })
> +#define dspi_readl(c)		({ u32 __v = (__force u32) __raw_readl(c); __iormb(); __v; })
> +#define dspi_writeb(v, c)	writeb(v, c)
> +#define dspi_writew(v, c)	({ __iowmb(); __raw_writew((__force u16) v, c); })
> +#define dspi_writel(v, c)	({ __iowmb(); __raw_writel((__force u32) v, c); })
> +

For type safety and general legibility make these inline functions
instead of macros, the generated code should be the same.  It's also not
clear why you're adding iowmb()s that weren't in the code before, and
see below...

> @@ -110,9 +120,10 @@ struct fsl_dspi {
>  
>  	void __iomem		*base;
>  	int			irq;
> -	struct clk 		*clk;
> +	struct clk		*clk;
>  
> -	struct spi_transfer 	*cur_transfer;
> +	bool			big_endian;
> +	struct spi_transfer	*cur_transfer;

Seems like there's some whitespace changes crept in here and elsewhere
which makes things harder to review.

>  static inline int is_double_byte_mode(struct fsl_dspi *dspi)
>  {
> -	return ((readl(dspi->base + SPI_CTAR(dspi->cs)) & SPI_FRAME_BITS_MASK)
> -			== SPI_FRAME_BITS(8)) ? 0 : 1;
> +	return
> +	((DSPI_BITWISE32(dspi, dspi_readl(dspi->base + SPI_CTAR(dspi->cs)))
> +	& SPI_FRAME_BITS_MASK)
> +		== SPI_FRAME_BITS(8)) ? 0 : 1;

The indentation here is a bit messed up, the return shouldn't be
indented to the same level as the argument.  More importantly the whole
thing is just becoming even harder to read with the addition of
DSPI_BITWISE32.  Would it not be clearer if the driver always worked
CPU native and the endianness of the hardware were hidden by the I/O
accessor functions?

> -	pr_warn("Can not find valid baud rate,speed_hz is %d,clkrate is %ld\
> +	pr_warn("Can not find valid baud rate,speed_hz is %d,clkrate is %ld
>  		,we use the max prescaler value.\n", speed_hz, clkrate);

This seems unrelated and will mess up the formatting of the resulting
print (which ought to be a dev_warn()).

> +	dspi->big_endian = of_property_read_bool(np, "big-endian");
> +

This needs an update to the DT binding document.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131230/ade2df78/attachment-0001.sig>
