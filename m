From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 Jan 2014 17:52:08 +0000
Subject: [PATCH v2 1/2] spi:fsl-dspi:add support of DSPI IP in big endian
In-Reply-To: <1389161655-21856-1-git-send-email-b44548@freescale.com>
References: <1389161655-21856-1-git-send-email-b44548@freescale.com>
Message-ID: <20140109175208.GK12858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 02:14:14PM +0800, Chao Fu wrote:

This looks a lot nicer - a few things below though.

> +#define DSPI_BITWISE16(d, v)	(d->big_endian ? cpu_to_be16(v) : cpu_to_le16(v))
> +#define DSPI_BITWISE32(d, v)	(d->big_endian ? cpu_to_be32(v) : cpu_to_le32(v))

These should probably be inline for the same reason as the I/O
functions, perhaps even being done as part of the I/O functions.

> +static inline u16 dspi_readw(void __iomem *addr)
> +{
> +	u16 __v = (__force u16) __raw_readw(addr);
> +	__iormb();
> +
> +	return __v;
> +}

Why does this need a barrier and why does it not take care of the
endianness translation?  A quick glance through shows most if not all of
the callers doing the translation.

> +static inline void dspi_writew(u16 val, void __iomem *addr)
> +{
> +	__iowmb();
> +	__raw_writew((__force u16) val, addr);
> +}

Again the memory barrier seems odd, especially the barrier *before*
doing the write.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140109/4e66f9b4/attachment.sig>
