From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Wed, 21 Apr 2010 10:16:29 +0300
Subject: [PATCH v4 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <0D753D10438DA54287A00B0270842697636D7F4E7F@AUSP01VMBX24.collaborationhost.net>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D7F4E7F@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100421071629.GL19534@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 20, 2010 at 12:24:26PM -0500, H Hartley Sweeten wrote:
> On Tuesday, April 20, 2010 8:12 AM, Mika Westerberg wrote:
> > This patch adds an SPI master driver for the Cirrus EP93xx SPI controller found
> > in EP93xx chips (EP9301, EP9302, EP9307, EP9312 and EP9315).
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> 
> Mika,
> 
> I'm still looking this over but I have one quick comment.
> 
> > +/**
> > + * ep93xx_spi_select_device() - select given SPI device
> > + * @espi: ep93xx SPI controller struct
> > + * @spi: SPI device to select
> > + *
> > + * Function asserts chipselect line as specified in @spi->chip_select in board
> > + * specific manner.
> > + *
> > + * Note that this function is called from a thread context and can sleep.
> > + */
> > +static inline void ep93xx_spi_select_device(const struct ep93xx_spi *espi,
> > +					    struct spi_device *spi)
> > +{
> > +	if (espi->cs_control)
> > +		espi->cs_control(spi, !!(spi->mode & SPI_CS_HIGH));
> > +}
> > +
> > +/**
> > + * ep93xx_spi_deselect_device() - deselects given SPI device
> > + * @espi: ep93xx SPI controller struct
> > + * @spi: SPI device to deselect
> > + *
> > + * Function deasserts chipselect line as specified in @spi->chip_select in board
> > + * specific manner.
> > + *
> > + * Note that this function is called from a thread context and can sleep.
> > + */
> > +static inline void ep93xx_spi_deselect_device(const struct ep93xx_spi *espi,
> > +					      struct spi_device *spi)
> > +{
> > +	if (espi->cs_control)
> > +		espi->cs_control(spi, !(spi->mode & SPI_CS_HIGH));
> > +}
> 
> These two functions can be combined.
> 
> /**
>  * ep93xx_spi_chip_select() - select/deselect a given SPI device
>  * @espi: ep93xx SPI controller struct
>  * @spi: SPI device to select
>  * @assert: flag to assert the chip select line
>  *
>  * Note that this function is called from a thread context and can sleep.
>  */
> static void ep93xx_spi_chip_select(const struct ep93xx_spi *espi,
> 					     struct spi_device *spi, int assert)
> {
> 	int value = (spi->mode & SPI_CS_HIGH) ? !!assert : !assert;
> 
> 	if (espi->cs_control)
> 		espi->cs_control(spi, value);
> }
> 
> Then just do:
> 
> ep93xx_spi_select_device(espi, msg->spi, 1);	/* assert the spi chip select */
> 
> ep93xx_spi_select_device(espi, msg->spi, 0);	/* deassert the spi chip select */


I think it is more readable to do:

	ep93xx_spi_select_device(espi, msg->spi);

and

	ep93xx_spi_deselect_device(espi, msg->spi);

It can be seen from the function names what we are doing.

Thanks,
MW
