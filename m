From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 2 May 2014 18:31:20 +0100
Subject: [RFC] Describing arbitrary bus mastering relationships in DT
In-Reply-To: <6774053.rAccqTeoiQ@wuerfel>
References: <20140501173248.GD3732@e103592.cambridge.arm.com>
 <6774053.rAccqTeoiQ@wuerfel>
Message-ID: <20140502173120.GD3805@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 06:14:58PM +0200, Arnd Bergmann wrote:
> On Thursday 01 May 2014 18:32:48 Dave Martin wrote:
> > (Note, this is a long mail -- people in a hurry may want to skip to
> > "Outline binding" to get a feel for what is bring proposed, before
> > returning to the background wording.)
> > 
> > As highlighted in some previous discussions[1], it is becoming possible
> > to build ARM-based SoCs that seem to be impossible to describe using the
> > DT bindings currently specified by ePAPR.  This is driven by increasing
> > complexity of interconnects, the appearance of IOMMUs, MSI-capable
> > interrupt controllers and multiple bus masters.
> > 
> > This issue is not fundamental to ARM and could apply to other SoC
> > families with a similar bus architecture, but most of the current
> > discussion in this area has been about how to address these
> > requirements for ARM SoCs.
> > 
> > This RFC is an outline for some core bindings to solve part of the
> > problem of describing such systems, particularly how to describe master/
> > slave relationships not currently representable in DT.  It is premature
> > to make a concrete proposal yet: rather I'm presenting this as a starting
> > point for discussion initially.
> > 
> > The intent is not to rewrite existing bindings, but to define a common
> > DT approach for describing otherwise problematic features of future
> > systems.  Actual Linux support for this could be implemented as needed.
> 
> Thanks a lot for getting this rolling!
> 
> 
> > ** Outline binding **
> > 
> > generic device node property: "slaves"
> > 
> > 	optional
> > 
> > 	type : cell array consisting of one or more phandles
> > 
> > 	Implies that the device represented by the containing node
> > 	can issue transactions to the referenced node.
> > 
> > 	The referenced node is any bus or device node, and is
> > 	interpreted in the usual way, including the treatment
> > 	of ranges, #address-cells and #size-cells.  If the
> > 	referenced node has a non-empty ranges property, the
> > 	referencing node's #address-cells must be the same as
> > 	that of the referenced node's device tree parent.
> 
> I guess you mean "dma-ranges" here, not "ranges", right?
> I don't see how "ranges" is even relevant for this.

No, but I didn't state it very clearly.

In this:

	parent {
		child {
			ranges = < ... >;
			dma-ranges = < ... >;
		};
	};

There are two transaction flows being described.  There are transactions
from parent -> child, for which "ranges" describes the mappings, and
there are transactions from child -> parent, for which "dma-ranges"
describes the mappings.

The name "dma-ranges" obfuscates this symmetry, so it took me a while
to figure out what it really means -- maybe I'm still confused, but
I think that's the gist of it.


For the purposes of cross-links, my plan was that we interpret all
those links as "forward" (i.e., parent -> child) links, where the
referencing node is deemed to be the parent, and the referenced node is
deemed to be the child. Just as in the ePAPR case, the associated mapping
is then described by "ranges".

> Don't you need arguments to the phandle? It seems that in most
> cases, you need at least one of a dma-ranges like translation
> or a master ID. What you need would be specific to the slave.

For any 1:N relationship between nodes, you can describe the
_relationship_ by putting properties on the nodes at the "1" end.  This
is precisely how "ranges" and "dma-ranges" work.

The N:M case can be resolved by inserting simple-bus nodes into any
links with non-default mappings: i.e., you split each affected link in
two, with a simple-bus node in the middle describing the mapping:

root: / {
	ranges;
	...

	master at 1 {
		slave {
			ranges = < ... >;
			slaves = <&root>;
		};
	};

	master at 2 {
		slave {
			slaves = < &root &master2_dma_slave >;
			slave-names = "config-fetch", "dma";

		master2_dma_slave: dma-slave {
				ranges = < ... >;
				slaves = <&root>;
			};
		};
	};

	master at 3 {
		slaves = <&root>;
	};
};


Here, there are three master devices, one with two different mastering
roles.

master at 2's configuration data fetch mechanism accesses the root bus
node, but with some remapping.  master at 2 also does bulk DMA, which
has no remapping.

master at 1 masters on / with its own remapping.  master at 3 masters on
/ with no remapping.

(This is a silly made-up system: I don't claim I've seen something like
this.)


> 
> It may be best to make the ranges explicit here and then also
> allow additional fields depending on e.g. a #dma-slave-cells
> property in the slave.
> 
> For instance, a 32-bit master on a a 64-bit bus that has master-id
> 23 would look like
> 
> 	otherbus: axi at somewhere{
> 		#address-cells = <2>;
> 		#size-cells = <2>;
> 	};
> 
> 	somemaster at somewhere {
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		slaves = <&otherbus  // phandle
> 				0     // local address
> 				0 0   // remote address
> 				0x1 0 // size
> 				23>;  // master id
> 	};

I thought about this possibility, but was worried that the "slaves"
property would become awkward to parse, where except for the "master id"
concept, all these attributes are well described by ePAPR already for
bus nodes if we can figure out how to piggyback on them -- hence my
alternative approach explained above.

How to describe the "master id" is particularly problematic and may
be a separate discussion.  It can get munged or remapped as it
passes through the interconnect: for example, a PCI device's ID 
accompanying an MSI write may be translated once as it passes from
the PCI RC to an IOMMU, then again before it reaches the GIC.

In the "windowed IOMMU" case, address bits are effectively being
mapped to ID bits as they reach IOMMU.

An IOMMU also does a complete mapping of ID+address -> ID'+address'
(although programmable rather than static and unprobeable, so the
actual mappings for an IOMMU won't be in the DT).

> 
> > Questions:
> > 
> > 1) Should the names "slaves" and "slave" be globally generic?
> > 
> >    Pro: Making them generic permits some processing to be done on the DT
> >    without knowing the individual bindings for every node, such as
> >    figuring out the global DMA mask.  It should also encourage adoption
> >    of the bindings as a common approach.
> > 
> >    Con: Namespace pollution
> > 
> >    Otherwise, there could be a special string in the node's compatible
> >    list (strictly not "simple-bus") to indicate that these properties
> >    should be interpreted.
> > 
> >    The alternative is for the way of identifying a node's slaves to be
> >    binding-specific.  This makes some generic operations on the DT
> >    impossible without knowing all the bindings, such as analysing
> >    reachability or determining the effective DMA mask.  This analysis
> >    can be performed using generic bindings alone today, for systems
> >    describable by ePAPR.  Breaking this concept feels like a backward
> >    step.
> 
> How about being slightly more specific, using "dma-slaves" and
> "dma-slave-names" etc?

I avoided the word "dma" because I found it confusing initially.

In the hardware there is no difference at all between "dma" and
bus mastering by CPUs, at least not in the ARM SoC world.

"DMA" suggests a relatively dumb peripheral doing grunt work on behalf
of a CPU.  Viewing pagetable fetches and polygon rendering or
RenderScript-style computataion offload done by a GPU as "DMA" seems a
bit of a stretch.

That said, DT is intended for use by OSes, so if it is CPU-centric,
that's OK (it already is CPU-centric, anyway).  A name is just a name;
so long as bindings are understandable, the choice of name shouldn't
matter too much.

> > 2) The generic "slave" node(s) are for convenience and readability.
> >    They could be made eliminated by using child nodes with
> >    binding-specific names and referencing them in "slaves".  This is a
> >    bit more awkward, but has the same expressive power.
> > 
> >    Should the generic "slave" nodes go away?
> 
> I would prefer not having to have subnodes for the simple case
> where you just need to reference one slave iommu from a master
> device.

My expectation is that subnodes would only be useful in special cases in
any case.

We can remove the special "slave" name, because there's nothing to
stop us referencing other random nested nodes with the "slaves" property.

> 
> It could be a recommendation for devices that have multiple slaves,
> but I still haven't seen an example where this is actually needed.
> 
> > 3) Should "slave" or "slaves" be traversable for bridge- or bus-like
> >    nodes?
> > 
> >    Saying "no" to this makes it impossible for the reachability graph of
> >    the DT to contain cycles.  This is a clear benefit for any software
> >    attempting to parse the DT in a robust way.  Only the first link,
> >    from the initiating master to the first bridge, would be permitted
> >    to be a "slaves" link.
> > 
> >    Ideally, we would want an IOMMU's bridge-like role to be represented
> >    by some deep node in the DT: it can't usually be on the global path
> >    from / since CPUs typically don't master through the IOMMU.
> > 
> >    Parsers could be made robust while still permitting this, by
> >    truncating the search if the initial master node is reached.
> >    Ill-formed DTs could contains cycles that can't be resolved in
> >    this way, e.g., A -> B -> B.  For now it might be reasonable to
> >    check for this in dtc.
> 
> I wouldn't be worried about cycles. We can just declare them forbidden
> in the binding. Anything can break if you supply a broken DT, this
> is the least of the problems.

That's my thought.  If there turns out to be a really good reason to
describe cycles then we can cross that bridge* when we come to it,
but it's best to forbid it until/unless the need for it is proven.

(*no pun intended)

Note that a certain kind of trivial cycle will always be created
when a node refers back to its parent:

root: / {
	ranges;

	iommu {
		reg = < ... >;
		slaves = <&root>;
	};
};

ePAPR says that if there is no "ranges" property, then the parent
node cannot access any address of the child -- we can interpret
this as saying that transactions do not propagate.  "ranges" with
an empty value imples a complete 1:1 mapping, which we can interpret
as transactions being forwarded without any transformation.

Crucially, "iommu" must not have a "ranges" property in this case,
because this would permit a static routing cycle root -> iommu ->
root.


Providing that the only devices that master on iommu are not
themselves bridges reachable from /, there is no cycle --
a given transaction will issued to the iommu will sooner or later hit
something that is not a bridge and disappear.

Note that there is no cycle through the "reg" property on iommu:
"reg" indicates a sink for transactions; "slaves" indicates a
source of transactions, and "ranges" indicates a propagator of
transactions.

"dma-ranges" indicates that the children of the node _might_ be
sources of transactions (but that does not mean that they definitely
are) -- and that the parent node acts as a bridge for those transactions,
forwarding them back to its own parent or children depending on the
address.

Cheers
---Dave
