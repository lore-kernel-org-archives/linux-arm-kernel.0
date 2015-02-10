From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 10 Feb 2015 17:06:49 +0100
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <20150210165201.634bc04b@bbrezillon>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <1422527620-8308-4-git-send-email-boris.brezillon@free-electrons.com>
 <20150210153628.GF9432@leverpostej>
 <20150210165201.634bc04b@bbrezillon>
Message-ID: <20150210170649.48607904@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm fixing my own answer :-)

On Tue, 10 Feb 2015 16:52:01 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hi Mark,
> 
> On Tue, 10 Feb 2015 15:36:28 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > Hi Boris,
> > 
> > On Thu, Jan 29, 2015 at 10:33:38AM +0000, Boris Brezillon wrote:
> > > Add documentation for the virtual irq demuxer.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > ---
> > >  .../bindings/interrupt-controller/dumb-demux.txt   | 41 ++++++++++++++++++++++
> > >  1 file changed, 41 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt b/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> > > new file mode 100644
> > > index 0000000..b9a7830
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> > > @@ -0,0 +1,41 @@
> > > +* Virtual Interrupt Demultiplexer
> > > +
> > > +This virtual demultiplexer simply forward all incoming interrupts to its
> > > +enabled/unmasked children.
> > > +It is only intended to be used by hardware that do not provide a proper way
> > > +to demultiplex a source interrupt, and thus have to wake all their children
> > > +up so that they can possibly handle the interrupt (if needed).
> > > +This can be seen as an alternative to shared interrupts when at least one
> > > +of the interrupt children is a timer (and require the irq to stay enabled
> > > +on suspend) while others are not. This will prevent calling irq handlers of
> > > +non timer devices while they are suspended.
> > 
> > This sounds like a DT-workaround for a Linux implementation problem, and
> > I don't think this the right way to solve your problem.
> 
> I understand your concern, but why are you answering while I asked for

                             but why are you answering now, while ....

> DT maintainers reviews for several days (if not several weeks).
> 
> > 
> > Why does this have to be in DT at all? Why can we not fix the core to
> > handle these details?
> 
> We already discussed that with Rob and Thomas, and hiding such a
> demuxer chip is not an easy task.
> I'm open to any suggestion to do that, though I'd like you (I mean DT
> guys) to provide a working implementation (or at least a viable concept)
> that would silently demultiplex an irq.
> 
> > 
> > I am very much not keen on this binding.
> 
> Yes, but do you have anything else to propose.
> We're experiencing this warning for 2 releases now, and this is time to
> find a solution (even if it's not a perfect one).
> 
> > 
> > > +
> > > +Required properties:
> > > +- compatible: Should be "virtual,irq-demux".
> > > +- interrupt-controller: Identifies the node as an interrupt controller.
> > > +- interrupts-extended or interrupt-parent and interrupts: Reference the source
> > > +  interrupt connected to this dumb demuxer.
> > > +- #interrupt-cells: The number of cells to define the interrupts (should be 1).
> > > +  The only cell is the IRQ number.
> > > +- irqs: u32 bitfield specifying the interrupts provided by the demuxer.
> > 
> > Arbitrary limitation?
> 
> I first proposed to make this field unlimited, but Thomas suggested to
> keep it limited to 32 bits (and I didn't complain since my HW needs
> far less than 32 interrupts).

Here is the first implementation I proposed [1], where the 'irqs'
property was an array of u32, each entry containing an irq id.

[1]https://lkml.org/lkml/2015/1/8/233

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
