From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Thu, 14 Jun 2018 10:32:20 +0200
Subject: [PATCH v7 3/6] mfd: at91-usart: added mfd driver for usart
In-Reply-To: <1086330e-40e4-8d9b-50aa-1ae9bf48aa22@microchip.com>
References: <20180613163621.23995-1-radu.pirea@microchip.com>
 <20180613163621.23995-4-radu.pirea@microchip.com>
 <20180614075849.dfiqwcu6rtzgpzq7@rfolt0960.corp.atmel.com>
 <1086330e-40e4-8d9b-50aa-1ae9bf48aa22@microchip.com>
Message-ID: <20180614083220.GU10521@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/06/2018 11:22:25+0300, Radu Pirea wrote:
> On 06/14/2018 10:58 AM, Ludovic Desroches wrote:
> > > +static int at91_usart_mode_probe(struct platform_device *pdev)
> > > +{
> > > +	struct mfd_cell cell;
> > > +	u32 opmode = AT91_USART_MODE_SERIAL;
> > > +
> > > +	device_property_read_u32(&pdev->dev, "atmel,usart-mode", &opmode);
> > > +
> > > +	switch (opmode) {
> > > +	case AT91_USART_MODE_SPI:
> > > +		cell = at91_usart_spi_subdev;
> > > +		break;
> > > +	case AT91_USART_MODE_SERIAL:
> > > +		cell = at91_usart_serial_subdev;
> > > +		break;
> > > +	default:
> > > +		break;
> > 
> > If there is an invalid opmode from the DT, you will pass a non initialized cell
> > to mfd_add_device().
> > 
> > Regards
> > 
> > Ludovic
> 
> Hi Ludovic,
> 
> Tnx. That's true. How is better to do if atmel,usart-mode has an invalid
> value? To initialize cell with at91_usart_serial_subdev or to print an error
> message and return -EINVAL?
> 

Returning an error is probably the correct choice because it means the
DT has an invalid value (something was done and is wrong).

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
