From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 21 Apr 2010 11:47:13 -0500
Subject: [PATCH v4 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <20100421071629.GL19534@gw.healthdatacare.com>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D7F4E7F@AUSP01VMBX24.collaborationhost.net>
	<20100421071629.GL19534@gw.healthdatacare.com>
Message-ID: <0D753D10438DA54287A00B0270842697636D8C84DA@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 21, 2010 12:16 AM, Mika Westerberg wrote:
>> 
>> These two functions can be combined.
>> 
>> /**
>>  * ep93xx_spi_chip_select() - select/deselect a given SPI device
>>  * @espi: ep93xx SPI controller struct
>>  * @spi: SPI device to select
>>  * @assert: flag to assert the chip select line
>>  *
>>  * Note that this function is called from a thread context and can sleep.
>>  */
>> static void ep93xx_spi_chip_select(const struct ep93xx_spi *espi,
>> 					     struct spi_device *spi, int assert)
>> {
>> 	int value = (spi->mode & SPI_CS_HIGH) ? !!assert : !assert;
>> 
>> 	if (espi->cs_control)
>> 		espi->cs_control(spi, value);
>> }
>> 
>> Then just do:
>> 
>> ep93xx_spi_select_device(espi, msg->spi, 1);	/* assert the spi chip select */
>> 
>> ep93xx_spi_select_device(espi, msg->spi, 0);	/* deassert the spi chip select */
>
>
> I think it is more readable to do:
>
>	ep93xx_spi_select_device(espi, msg->spi);
>
> and
>
>	ep93xx_spi_deselect_device(espi, msg->spi);
>
> It can be seen from the function names what we are doing.

So rename the combined function to ep93xx_spi_cs_control and pass the "control"
parameter as a bool; true = selected, false = deselected.

Having the two almost identical functions is a bit redundant.  It also gives you
two places to have to maintain basically the same operation.  I think this is
what Grant was referring to with his previous comment.

Regards,
Hartley
