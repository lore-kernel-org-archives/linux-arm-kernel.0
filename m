From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 4 Dec 2014 11:47:57 +0100
Subject: [PATCH v5 06/11] memory: atmel-ebi: add DT bindings documentation
In-Reply-To: <548037CF.7090500@atmel.com>
References: <1417639455-17410-1-git-send-email-boris.brezillon@free-electrons.com>
 <1417639455-17410-7-git-send-email-boris.brezillon@free-electrons.com>
 <548037CF.7090500@atmel.com>
Message-ID: <20141204114757.1fa5cd9a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 4 Dec 2014 11:30:39 +0100
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> Le 03/12/2014 21:44, Boris Brezillon a ?crit :
> > The EBI (External Bus Interface) is used to access external peripherals
> > (NOR, SRAM, NAND, and other specific devices like ethernet controllers).
> > Each device is assigned a CS line and an address range and can have its
> > own configuration (timings, access mode, bus width, ...).
> > This driver provides a generic DT binding to configure a device according
> > to its requirements.
> > For specific device controllers (like the NAND one) the SMC timings
> > should be configured by the controller driver through the matrix and smc
> > syscon regmaps.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  .../bindings/memory-controllers/atmel-ebi.txt      | 155 +++++++++++++++++++++
> >  1 file changed, 155 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/atmel-ebi.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/atmel-ebi.txt b/Documentation/devicetree/bindings/memory-controllers/atmel-ebi.txt
> > new file mode 100644
> > index 0000000..3749ea1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/memory-controllers/atmel-ebi.txt
> > @@ -0,0 +1,155 @@
> > +* Device tree bindings for Atmel EBI
> > +
> > +The External Bus Interface (EBI) controller is a bus where you can connect
> > +asynchronous (NAND, NOR, SRAM, ....) and synchronous memories (SDR/DDR SDRAMs).
> > +The EBI provides a glue-less interface to asynchronous memories though the SMC
> > +(Static Memory Controller).
> > +Synchronous memories (and some asynchronous memories like NANDs) can be
> > +attached to specialized controllers which are responsible for configuring the
> > +bus appropriately according to the connected device.
> > +In the other hand, the bus interface can be automated for simple asynchronous
> > +devices.
> > +
> > +Required properties:
> > +
> > +- compatible:		"atmel,at91sam9260-ebi"
> > +			"atmel,at91sam9261-ebi"
> > +			"atmel,at91sam9263-ebi0"
> > +			"atmel,at91sam9263-ebi1"
> > +			"atmel,at91sam9g45-ebi"
> > +			"atmel,at91sam9x5-ebi"
> > +			"atmel,sama5d3-ebi"
> > +
> > +- reg:			Contains offset/length value for EBI memory mapping.
> > +			This property might contain several entries if the EBI
> > +			memory range is not contiguous
> > +
> > +- #address-cells:	Must be 2.
> > +			The first cell encodes the CS.
> > +			The second cell encode the offset into the CS memory
> > +			range.
> > +
> > +- #size-cells:		Must be set to 1.
> > +
> > +- ranges:		Encodes CS to memory region association.
> > +
> > +- clocks:		Clock feeding the EBI controller.
> > +			See clock-bindings.txt
> > +
> > +Child chip-select (cs) nodes contain the memory devices nodes connected to
> > +such as NOR (e.g. cfi-flash) and NAND.
> > +There might be board specific devices like FPGAs.
> > +You'll define you device requirements in these child nodes.
> > +
> > +Required child cs node properties:
> > +
> > +- #address-cells:	Must be 2.
> > +
> > +- #size-cells:		Must be 1.
> > +
> > +- ranges:		Empty property indicating that child nodes can inherit
> > +			memory layout.
> > +
> > +Optional child cs node properties:
> > +- atmel,generic-dev		boolean property specifying if the device is
> > +				a generic device.
> 
> Here, you mean: "atmel,specialized-logic" and the corresponding text...
> 

Yep, apparently I squashed the doc fixes in the wrong commit :-(.
I'll fix that.

Thanks,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
