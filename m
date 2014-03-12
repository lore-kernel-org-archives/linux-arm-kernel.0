From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Mar 2014 16:24:18 +0000
Subject: [PATCH 1/3] spi: bitbang: fix shift for getmosi
In-Reply-To: <1394639617-26917-2-git-send-email-m.grzeschik@pengutronix.de>
References: <1394639617-26917-1-git-send-email-m.grzeschik@pengutronix.de>
 <1394639617-26917-2-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20140312162418.GU28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 04:53:35PM +0100, Michael Grzeschik wrote:
> The driver needs to shift the word bit after reading the mosi bit.
> Otherwise the return word will have an Off-by-one bit value.

This isn't exactly new code...  do we understand why nobody has noticed
this before?

> @@ -61,10 +61,10 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
>  		spidelay(nsecs);
>  
>  		/* sample MSB (from slave) on leading edge */
> -		word <<= 1;
>  		if ((flags & SPI_MASTER_NO_RX) == 0)
>  			word |= getmiso(spi);
>  		setsck(spi, cpol);
> +		word <<= 1;
>  	}

Just looking at the context here it's not obvious to me that this is
helping - it means that the last bit we read is going to be shifted
which seems wrong, we ought to be reading into LSB.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140312/7bbc3eaf/attachment.sig>
