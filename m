From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 29 Nov 2013 11:58:15 +0000
Subject: [RFC PATCH] Documentation: devicetree: add description for
 generic bus properties
In-Reply-To: <20131128233147.GA19387@obsidianresearch.com>
References: <20131127172806.GC2291@e103592.cambridge.arm.com>
 <20131128203322.GB14689@mithrandir>
 <20131128211009.GA26447@obsidianresearch.com>
 <20131128222232.GF14689@mithrandir>
 <20131128233147.GA19387@obsidianresearch.com>
Message-ID: <20131129115815.GC3136@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 28, 2013 at 04:31:47PM -0700, Jason Gunthorpe wrote:
> On Thu, Nov 28, 2013 at 11:22:33PM +0100, Thierry Reding wrote:
> > On Thu, Nov 28, 2013 at 02:10:09PM -0700, Jason Gunthorpe wrote:
> > > On Thu, Nov 28, 2013 at 09:33:23PM +0100, Thierry Reding wrote:
> > > 
> > > > >   - Describing masters that master through multiple different buses
> > > > > 
> > > > >   - How on Earth this fits in with the Linux device model (it doesn't)
> > > > > 
> > > > >   - Interaction with IOMMU bindings (currently under discussion)
> > > > 
> > > > This is all very vague. Perhaps everyone else knows what this is all
> > > > about, in which case it'd be great if somebody could clue me in.
> > > 
> > > It looks like an approach to describe an AXI physical bus topology in
> > > DT..
> > 
> > Thanks for explaining this. It makes a whole lot more sense now.
> 
> Hopefully the ARM guys concur, this was just my impression from
> reviewing their patches and having recently done some design work with
> AXI..

Yes and no.  We are trying to describe a real topology here, but only
because there are salient features that the kernel genuinely does
need to know about if we want to be able to abstract this kind of thing.

It's not just about AXI.

Things like CCI-400 ("cache coherent interconnect") and its successors 
have real run-time control requirements on each connection to the bus.
(The "port" terminology is used in the CCI documentation, but in any
case the concept of a link between a device and a bus should be a pretty
generic concept, not tied to a specific name or a specific interconnect.)

If I need to turn on the bus interface for device X, in need to know
how to tell the bus which interface to poke -- hence the need for
a "port ID".  Of course, we're free to choose other names.

The master-slave link concept is not supposed to be a new concept at
all: DT already has this concept.  All we are aiming to add here is the
ability to describe cross-links that ePAPR cannot describe directly.

> 
> > > axi
> > > {
> > >    /* Describe a DAG of AXI connections here. */
> > >    cpu { downstream = &ax_switch,}
> > >    axi_switch {downstream = &memory,&low_speed}
> > >    memory {}
> > >    dma {downstream = &memory}
> > >    low_speed {}
> > > }
> > 
> > Correct me if I'm wrong, but the switch would be what the specification
> > refers to as "interconnect", while a port would correspond to what is
> > called an "interface" in the specification?
> 
> That seems correct, but for this purpose we are not interested in
> boring dumb interconnect but fancy interconnect with address remapping
> capabilities, or cache coherency (eg the SCU/L2 cache is modeled as
> switch/interconnect in a AXI DAG).

Bear in mind that "fancy interconnect with address remapping
capabilities" probably means at least two independent components on an
ARM SoC.

To avoid excessive code fragmentation we'd want a driver for each, not a
driver per every possible pairing.  The pairing could be different on
every port even in a single SoC, though I hope we will never see that.

> I called it a switch because the job of the interconnect block is to
> take an AXI input packet on a slave interface and route it to the
> proper master interface with internal arbitration between slave
> interfaces. In my world that is a called a switch ;)

In axi { axi_switch {} }, are you describing two levels of bus, or
one?  I'm guessing one, but then the nested node looks a bit weird.

> AXI is basically an on-chip point-to-point switched fabric like PCI-E,
> and the stuff that travels on AXI looks fairly similar to PCI-E TLPs..
> 
> If you refer to the PDF I linked I broadly modeled the above DT
> fragment on that diagram, each axi sub node (vertex) represents an
> 'interconnect' and 'downstream' is a master->slave interface pair (edge).
> 
> Fundamentally AXI is inherently a DAG, but unlike what we are used to
> in other platforms you don't have to go through a fused
> CPU/cache/memory controller unit to access memory, so there are
> software visible asymmetries depending on how the DMA flows through
> the AXI DAG.

Just to call this out, the linkage is *not* guaranteed to be acyclic.

If you connect pass-through devices (i.e., buses) round in a cycle,
you may get transactions going round and round forever, so we should
never see that in a system.

However, there's nothing to stop a DMA controller's master side being
looped back so that it can access its own slave interface.  This is the
normal situation for coherent DMA, since the whole point there is
that the DMA controller should shares its system view closely with
the CPUs, including some levels of cache.

(This does mean that the DMA may be able to program itself -- but I don't
claim that this is useful.  Rather, it's a side-effect of providing a
coherent system view.)

> > > Which is why I think encoding the AXI DAG directly in DT is probably
> > > the most future proof way to model this stuff - it sticks close to the
> > > tools ARM provides to the SOC designers, so it is very likely to be
> > > able to model arbitary SOC designs.
> > 
> > I'm not sure I agree with you fully here. At least I think that if what
> > we want to describe is an AXI bus topology, then we should be describing
> > it in terms of the AXI specification.
> 
> Right, that was what I was trying to describe :) 
> 
> The DAG would be vertexes that are 'interconnect' and directed edges
> that are 'master -> slave interface' pairs.
> 
> This would be an addendum/side-table dataset to the standard 'soc' CPU
> address map tree, that would only be needed to program address
> mapping/iommu hardware.
> 
> And it isn't really AXI specific, x86 style platforms can have a DAG
> too, it is just much simpler, as there is only 1 vertex - the IOMMU.

Agree -- this concept of a master/slave link is a really generic concept,

The complete set of properties associated with each link will be
specific to each different interconnect, and possibly from port to port:
_that_ stuff would be described by separate, non-generic properties
defined per interconnect type.

But to do DMA mapping, you should only need to know what master/slave
links exist, and any associated mappings.

> 
> > I mean, even though device tree is supposed to describe hardware, there
> > needs to be a limit to the amount of detail we put into it. After all it
> > isn't a hardware description language, but rather a language to describe
> > the hardware in a way that makes sense for operating system software to
> > use it.
> 
> Right - which is why I said the usual 'soc' node should remain as-is
> typical today - a tree formed by viewing the AXI DAG from the CPU
> vertex. That 100% matches the OS perspective of the system for CPU
> originated MMIO.

Do you mean the top-level bus node in the DT and its contents, or
something else?

If so, agreed ...

> The AXI DAG side-table would be used to resolve weirdness with 'bus
> master' DMA programming. The OS can detect all the required
> configuration and properties by tracing a path through the DAG from
> the source of the DMA to the target - that tells you what IOMMUs are
> involved, if the path is cache coherent, etc.

... that could work, although putting the links in the natural places
in the DT directly feels cleaner that stashing a crib table elsewhere
in the DT.  That's partly cosmetic, I think both could work?

> 
> > Perhaps this is just another way of saying what Greg has already said.
> > If we continue down this road, we'll eventually end up having to
> > describe all sorts of nitty gritty details. And we'll need even more
> 
> Greg's point makes sense, but the HW guys are not designing things
> this way for kicks - there are real physics based reasons for some of
> these choices...
> 
> eg An all-to-all bus cross bar (eg like Intel's ring bus) is engery
> expensive compared to a purpose built muxed bus tree. Doing coherency
> look ups on DMA traffic costs energy, etc.
> 
> > code to deal with those descriptions and the hardware they represent. At
> > some point we need to start pushing some of the complexity back into
> > hardware so that we can keep a sane code-base.
> 
> Some of this is a consequence of the push to have the firmware
> minimal. As soon as you say the kernel has to configure the address
> map you've created a big complexity for it..
> 
> Jason
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
