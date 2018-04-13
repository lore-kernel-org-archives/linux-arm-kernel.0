From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Fri, 13 Apr 2018 20:12:51 +0200
Subject: [PATCH 2/3] dt-bindings: add binding for at91-usart in spi mode
In-Reply-To: <8e6c447d-dce5-f9af-e5b2-8d1d863159d6@microchip.com>
References: <20180413161117.20274-1-radu.pirea@microchip.com>
 <20180413161117.20274-3-radu.pirea@microchip.com>
 <20180413162327.GE22187@piout.net>
 <8e6c447d-dce5-f9af-e5b2-8d1d863159d6@microchip.com>
Message-ID: <20180413181251.GG22187@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/04/2018 19:12:54+0200, Nicolas Ferre wrote:
> > > diff --git a/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt b/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
> > > new file mode 100644
> > > index 000000000000..92d33ccdffae
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
> > > @@ -0,0 +1,24 @@
> > > +* Universal Synchronous Asynchronous Receiver/Transmitter (USART) in SPI mode
> > > +
> > > +Required properties:
> > > +- #size-cells      : Must be <0>
> > > +- #address-cells   : Must be <1>
> > > +- compatible: Should be "microchip,at91sam9g45-usart-spi" or "microchip,sama5d2-usart-spi"
> > > +- reg: Should contain registers location and length
> > > +- interrupts: Should contain interrupt
> > > +- clocks: phandles to input clocks.
> > > +- clock-names: tuple listing input clock names.
> > > +	Required elements: "usart"
> > > +- cs-gpios: chipselects (internal cs not supported)
> > > +
> > > +Example:
> > > +	spi0: spi at f001c000 {
> > > +		#address-cells = <1>;
> > > +		#size-cells = <0>;
> > > +		compatible = "microchip,sama5d2-usart-spi", "microchip,at91sam9g45-usart-spi";
> > 
> > I'm pretty sure this will be considered configuration rather than
> > hardware description. Why don't you do something like the flexcom mode
> > selection?
> 
> Because we are not in the same situation as having a glue layer that would
> select one of the already existing peripherals with associated drivers
> above.
> This layout of the hardware is completely different from the USART one and
> it seems to makes sense to address it with a different hardware description
> and so a different compatible string.
> 

But then, you can end up with two drivers trying to use the same IP
because nothing prevents you from writing a DT with both a usart and an
spi node enabled for the same IP. request_mem_region() will not help
here because then the working driver will depend on the probing order.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
