From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 6 Aug 2014 14:23:48 +0200
Subject: [PATCH v3 2/2] ARM: dts: at_xdmac: add bindings documentation
In-Reply-To: <20140725072008.GI8181@intel.com>
References: <1404825096-15724-1-git-send-email-ludovic.desroches@atmel.com>
 <1404825096-15724-3-git-send-email-ludovic.desroches@atmel.com>
 <20140725072008.GI8181@intel.com>
Message-ID: <20140806122348.GD27338@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 12:50:08PM +0530, Vinod Koul wrote:
> On Tue, Jul 08, 2014 at 03:11:36PM +0200, Ludovic Desroches wrote:
> > Add bindings documentation for the new Atmel DMA controller (XDMAC)
> > introduced with SAMA5D4.
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> >  .../devicetree/bindings/dma/atmel-xdma.txt         |   48 ++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/atmel-xdma.txt
> 
> I dont see delta with current atmel-dma bindings. Shouldn't we reuse that
> here too?

Bindings have change through the revision, I didn't notice they were so
close to the hdmac bindings. The only difference is the content of the
second cell.

I don't know if it's a sufficient reason to add a new binding.

> 
> Surely we dont want to add binding per contoller even if they are similar!
> 
> -- 
> ~Vinod
> 
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/atmel-xdma.txt b/Documentation/devicetree/bindings/dma/atmel-xdma.txt
> > new file mode 100644
> > index 0000000..647f099
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/atmel-xdma.txt
> > @@ -0,0 +1,48 @@
> > +* Atmel Extensible Direct Memory Access Controller (XDMAC)
> > +
> > +* XDMA Controller
> > +Required properties:
> > +- compatible: Should be "atmel,<chip>-dma".
> > +- reg: Should contain DMA registers location and length.
> > +- interrupts: Should contain DMA interrupt.
> > +- #dma-cells: Must be <2>, used to represent the number of integer cells in
> > +the dmas property of client devices.
> > +  - The 1st cell specifies the memory interface (16 most significant bits) and
> > +  the peripheral interface (16 less significant bits) to use.
> > +  - The 2nd cell specifies the channel configuration register:
> > +    - bit 30-24: PERID, peripheral identifier.
> > +
> > +Example:
> > +
> > +dma1: dma-controller at f0004000 {
> > +	compatible = "atmel,sama5d4-dma";
> > +	reg = <0xf0004000 0x200>;
> > +	interrupts = <50 4 0>;
> > +	#dma-cells = <2>;
> > +};
> > +
> > +
> > +* DMA clients
> > +DMA clients connected to the Atmel XDMA controller must use the format
> > +described in the dma.txt file, using a two-cell specifier for each channel.
> > +The three cells in order are:
> > +1. A phandle pointing to the DMA controller.
> > +2. The memory interface (16 most significant bits), the peripheral interface
> > +(16 less significant bits).
> > +3. Channel configuration register. Configurable fields are:
> > +  - bit 30-24: PERID, peripheral identifier.
> > +
> > +Example:
> > +
> > +i2c2: i2c at f8024000 {
> > +	compatible = "atmel,at91sam9x5-i2c";
> > +	reg = <0xf8024000 0x4000>;
> > +	interrupts = <34 4 6>;
> > +	dmas = <&dma1
> > +		(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
> > +		AT91_XDMAC_DT_PERID(6)>,
> > +	       <&dma1
> > +		(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1))
> > +		AT91_XDMAC_DT_PERID(7)>;
> > +	dma-names = "tx", "rx";
> > +};
> > -- 
> > 1.7.9.5
> > 
> 
> -- 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
