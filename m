From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 3 Dec 2013 11:45:12 +0000
Subject: [RFC PATCH] Documentation: devicetree: add description for
 generic bus properties
In-Reply-To: <20131203000740.GA30818@obsidianresearch.com>
References: <20131127172806.GC2291@e103592.cambridge.arm.com>
 <20131128203322.GB14689@mithrandir>
 <20131128211009.GA26447@obsidianresearch.com>
 <20131128222232.GF14689@mithrandir>
 <20131128233147.GA19387@obsidianresearch.com>
 <20131129115815.GC3136@e103592.cambridge.arm.com>
 <20131129184341.GA25451@obsidianresearch.com>
 <20131202202543.GC2312@e103592.cambridge.arm.com>
 <20131203000740.GA30818@obsidianresearch.com>
Message-ID: <20131203114506.GA2281@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 02, 2013 at 05:07:40PM -0700, Jason Gunthorpe wrote:
> On Mon, Dec 02, 2013 at 08:25:43PM +0000, Dave Martin wrote:
> > > This might be easier to parse as well, since you know everything under
> > > 'axi' is related to interconnect and not jumbled with other stuff.
> > 
> > That is true, but I do have a concern that bolting more and more
> > info onto the side of DT may leave us with a mess, while the "main"
> > tree becomes increasingly fictional.
> > 
> > You make a lot of good points -- apologies for not responding in detail
> > to all of them yet, but I tie myself in knots trying to say too many
> > different things at the same time.
> 
> I think the main point is to observe that we are encoding a directed
> graph onto DT, so long as the original graph can be extracted the
> DT encoding can be whatever people like :)

Sure, we're just juggling different descriptions for the same thing here.
The fact that our different representations do seem to agree on that
is reassuring...

> > In a multi-master system this isn't enough, because a node might have
> > to have multiple parents in order to express all the master/slave
> > relationships.
> 
> Right, DT is a tree, not a graph - and this is already a minor problem
> we've seen modeling some IP blocks on the Marvell chips. They also
> have multiple ports into the various system busses.
> 
> > In that case, we can choose one of the parents as the canonical one
> > (e.g., the immediate master on the path from the coherent CPUs), or if
> > there is no obvious canonical parent the child node can be a
> > freestanding node in the tree (i.e., with no reg or ranges properties,
> > either in the / { } junkyard, or in some location that makes topological
> > sense for the device in question).  The DT herarchy retains real
> > meaning since the direction of master/slave relationships is fixed,
> > but the DT becomes a tree of connected trees, rather than a single
> > tree.
> 
> I'm not sure this will really be a problem in practice:
> 
> Consider:
>  - All IP blocks we care about are going to have a CPU MMIO port for
>    control.
>  - The 'soc' tree is the MMIO hierarchy from the CPU perspective
>  - IP blocks should try to DT model as a single node when possible
> 
> In that case, the location of a DT node for a multiport IP is now well
> defined: It is the path from the CPU to the MMIO port, expressed in
> DT.
> 
> Further, every 'switch' is going to have MMIO to control the switch,
> so the switch node DT locations are also well defined.
> 
> Basically, I think the main 'soc' tree's layout is mostly unambiguous
> and covers all the relevant blocks.
> 
> You woun't get a forest of DT trees because every block must be MMIO
> reachable.
> 
> It is also the same core DT tree with my suggestion or yours.

Absolutely: I didn't argue this very well.

The CPU's-eye view of the system determines a natural hierarchy for
everything or almost.

It's possible that there is some bus or switch that only non-CPUs
can see.  But if the CPU has no control interface for it, that
suggests that bus is transparent enough that it needs no control --
and might not need to be represented in the DT at all.

As a rule, we should never put anything in the DT that does not
need to be described.

But if we end up with deviations from this rule, floating nodes
give us an escape route.

Suppose you have a cluster of DSPs used to implement a GPU.  They
might have their own front-side bus which they control themselves.
In this situation, it might be more natural to represent that whole
side cluster as a separate floating subtree within /.

But that's all very hypothetical.  In most cases, you just call
that monstrosity "gpu" and make it look like a device -- even in
the hardware.

> 
> Your edge encoding also makes sense, but I think this is where I would
> disagree the most:
> 
> > Slave device mapping, tree form:
> > 	a {
> > 		b {
> > 			reg = < REG >;
> > 		};
> > 	};
> > 
> > Slave device mapping, detached form:
> > 	a {
> > 		slave-reg = < &b REG >;
> > 	};
> > 
> > 	b {
> > 	};
> 
> This now requires the OS to parse this dataset just to access standard
> MMIO, and you have to change the standard existing code that parses
> ranges and reg to support this extended format.
> 
> Both of those reasons seem like major downsides to me. If the OS
> doesn't support advanced features (IOMMU, power management, etc) it
> should not require DT parsing beyond the standard items. This may
> become relevant when re-using a kernel DT in uboot for instance.

You're right that this is a change.  However, I think that no existing
DT needs to change, and few DTs will use it -- similar to the argument
about why DT will normally look like a single tree.

In real systems, I think multi-master slaves which are accessed
directly and not via some multi-master shared bus are not that common.

A partial dodge would be to introduce a dummy bus node:

	a {
		b {
			reg = < REG >;
		};
	};

becomes

	a {
		slave-ranges = < &b_bus RANGE >;
	};

	b_bus {
		// #slave-cells = <0> is the default
		compatible = "simple-bus";

		b {
			reg = < REG' >;
		};
	};

Where RANGE maps REG into a's address space, and REG' is REG rebased
to address 0.

Now, we can refer indirectly to b as many times as we like, without
using the slave-reg thing.

This still needs special parsing though -- but again, only for cases
that we already can't describe with DT.


The common situation will be that all shared slaves are really under
some shared bus, and that bus really has some natural location in
the DT.  So for cases simple enough not to require these extensions,
I think there would still be no change.

> On the other hand, this is a great way to actually express the correct
> address mapping path for every reg window - but isn't that a separate
> issue from the IOMMU/DMA problem? You still need to describe the DMA
> bus mastering ports on IP directly.

Those problems aren't identical, but they seem closely related.

My thought was that this gives us most of the language required to
describe the mastering links for bus-mastering devices.

> 
> The side-table concept would keep the parsing completely contained
> within the IOMMU/etc drivers, and not have it leak out into existing
> core DT code, but it doesn't completely tidy multiple slave ports.
> 
> Also, I was thinking after I sent the last email that this is a good
> time to be thinking about a future need for describing NUMA affinites
> in DT. That is basically the same directed graph we are talking about
> here. Trying some modeling samples with that in mind would be a good
> idea..
> 
> You should also think about places to encode parameters like
> master/slave QOS and other edge-specific tunables..

The idea that some things are properties of and edge or link, not a
node or device, overlaps with my thinking about IOMMU.  This may
apply to any device that behaves like some adaptor or passthrough.

One option is to create subnodes for these links.  I did not elaborate
this previously, but I think allowing "slave" to be a node for the
more complex cases where we need to add more info might help here:

	dma {
		slave {
			compatible = "slave-link", "simple-bus";
			ranges = < ... >;
			iommu-foo = < ... >;

			slave = < &shared_bus SLAVE-PORT >;
		}
	};

The best way to describe multiple master ports on the DMA controller
would need some thought.


One option would to extend the address space on the slave node with
additional cell(s) to carry port identifiers.  ePAPR already does
things in this sort of way in the interrupt-map and interrupt-map-mask
properties, to describe PCI interrupt routing.

> 
> > I may try to come up with a partial description of the Zync SoC, but
> > I was getting myself confused when I tried it earlier ;)
> 
> The Zynq is interesting because all the information is public - and it
> is a good example of the various AXI building blocks. Imagine some
> IOMMUs in there and you have a complete scenario to talk about..

Indeed.  I was impressed to see a non-trivial block diagram that wasn't
pasted straight out of some marketing powerpoint :)

It's a good example for discussion here, particularly if we add some
IOMMUs to the mix.

> It even has a coherent AXI port available for IP to hook up to. :)

You mean the ACP port connecting the PL Fabric back to the CPU cluster?
I'm guessing the PL Fabric is the interface to the FPGA logic.


Now I need to go back to your proposal and the IOMMU thread and try to
understand better how the approaches map onto each other.

Cheers
---Dave
