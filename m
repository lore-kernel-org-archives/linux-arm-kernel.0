From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 5 Nov 2014 17:39:57 +0100
Subject: [PATCH v2 06/11] memory: atmel-ebi: add DT bindings documentation
In-Reply-To: <CACh+v5N8dXaH3ZNGr=MKXbQRU7nOMPLvxT0rEsZrbSKj20b_Dg@mail.gmail.com>
References: <1415203287-21517-1-git-send-email-boris.brezillon@free-electrons.com>
 <1415203287-21517-7-git-send-email-boris.brezillon@free-electrons.com>
 <CACh+v5N8dXaH3ZNGr=MKXbQRU7nOMPLvxT0rEsZrbSKj20b_Dg@mail.gmail.com>
Message-ID: <20141105173957.1726d369@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 5 Nov 2014 17:22:57 +0100
Jean-Jacques Hiblot <jjhiblot@traphandler.com> wrote:

> Hi Boris,
> 
> 2014-11-05 17:01 GMT+01:00 Boris Brezillon <boris.brezillon@free-electrons.com>:
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  .../bindings/memory-controllers/atmel-ebi.txt      | 153 +++++++++++++++++++++
> >  1 file changed, 153 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/atmel-ebi.txt
> >
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/atmel-ebi.txt b/Documentation/devicetree/bindings/memory-controllers/atmel-ebi.txt
> > new file mode 100644
> > index 0000000..dc2c34f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/memory-controllers/atmel-ebi.txt
> > @@ -0,0 +1,153 @@
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

[...]

> > +
> > +Optional child cs node properties:
> > +- atmel,generic-dev            boolean property specifying if the device is
> > +                               a generic device.
> > +                               The following properties are only parsed if
> > +                               this property is present.
> > +                               Specialized devices are attached to specialized
> > +                               controllers which should configure the bus
> > +                               appropriately.
> 
> What do you mean by specialized devices ? Can you give an example ?

The ones I have in mind are NAND chips: the NAND controller can
automatically discover the required timings and configure the SMC
accordingly. In that case there's no need to specify timings in the DT,
because they will/should be dynalically configured by the NAND
controller driver.

But more generally, the datasheet describe 2 modes for some CS ports:
1) the generic mode, which bind the device to the generic SMC engine
2) the specialized mode which binds it to a specific HW block

This mode can be configured in CCFG_EBICSA, and the specialized mode
supported by each CS depends on each SoC.
For example, for the at91sam9x5:
CS1 => DDR2SDR controller
CS3 => NAND Flash Controller/Logic

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
