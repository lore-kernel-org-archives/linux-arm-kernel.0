From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 May 2014 18:14:58 +0200
Subject: [RFC] Describing arbitrary bus mastering relationships in DT
In-Reply-To: <20140501173248.GD3732@e103592.cambridge.arm.com>
References: <20140501173248.GD3732@e103592.cambridge.arm.com>
Message-ID: <6774053.rAccqTeoiQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 May 2014 18:32:48 Dave Martin wrote:
> (Note, this is a long mail -- people in a hurry may want to skip to
> "Outline binding" to get a feel for what is bring proposed, before
> returning to the background wording.)
> 
> As highlighted in some previous discussions[1], it is becoming possible
> to build ARM-based SoCs that seem to be impossible to describe using the
> DT bindings currently specified by ePAPR.  This is driven by increasing
> complexity of interconnects, the appearance of IOMMUs, MSI-capable
> interrupt controllers and multiple bus masters.
> 
> This issue is not fundamental to ARM and could apply to other SoC
> families with a similar bus architecture, but most of the current
> discussion in this area has been about how to address these
> requirements for ARM SoCs.
> 
> This RFC is an outline for some core bindings to solve part of the
> problem of describing such systems, particularly how to describe master/
> slave relationships not currently representable in DT.  It is premature
> to make a concrete proposal yet: rather I'm presenting this as a starting
> point for discussion initially.
> 
> The intent is not to rewrite existing bindings, but to define a common
> DT approach for describing otherwise problematic features of future
> systems.  Actual Linux support for this could be implemented as needed.

Thanks a lot for getting this rolling!


> ** Outline binding **
> 
> generic device node property: "slaves"
> 
> 	optional
> 
> 	type : cell array consisting of one or more phandles
> 
> 	Implies that the device represented by the containing node
> 	can issue transactions to the referenced node.
> 
> 	The referenced node is any bus or device node, and is
> 	interpreted in the usual way, including the treatment
> 	of ranges, #address-cells and #size-cells.  If the
> 	referenced node has a non-empty ranges property, the
> 	referencing node's #address-cells must be the same as
> 	that of the referenced node's device tree parent.

I guess you mean "dma-ranges" here, not "ranges", right?
I don't see how "ranges" is even relevant for this.

Don't you need arguments to the phandle? It seems that in most
cases, you need at least one of a dma-ranges like translation
or a master ID. What you need would be specific to the slave.

It may be best to make the ranges explicit here and then also
allow additional fields depending on e.g. a #dma-slave-cells
property in the slave.

For instance, a 32-bit master on a a 64-bit bus that has master-id
23 would look like

	otherbus: axi at somewhere{
		#address-cells = <2>;
		#size-cells = <2>;
	};

	somemaster at somewhere {
		#address-cells = <1>;
		#size-cells = <1>;
		slaves = <&otherbus  // phandle
				0     // local address
				0 0   // remote address
				0x1 0 // size
				23>;  // master id
	};

> Questions:
> 
> 1) Should the names "slaves" and "slave" be globally generic?
> 
>    Pro: Making them generic permits some processing to be done on the DT
>    without knowing the individual bindings for every node, such as
>    figuring out the global DMA mask.  It should also encourage adoption
>    of the bindings as a common approach.
> 
>    Con: Namespace pollution
> 
>    Otherwise, there could be a special string in the node's compatible
>    list (strictly not "simple-bus") to indicate that these properties
>    should be interpreted.
> 
>    The alternative is for the way of identifying a node's slaves to be
>    binding-specific.  This makes some generic operations on the DT
>    impossible without knowing all the bindings, such as analysing
>    reachability or determining the effective DMA mask.  This analysis
>    can be performed using generic bindings alone today, for systems
>    describable by ePAPR.  Breaking this concept feels like a backward
>    step.

How about being slightly more specific, using "dma-slaves" and
"dma-slave-names" etc?

> 2) The generic "slave" node(s) are for convenience and readability.
>    They could be made eliminated by using child nodes with
>    binding-specific names and referencing them in "slaves".  This is a
>    bit more awkward, but has the same expressive power.
> 
>    Should the generic "slave" nodes go away?

I would prefer not having to have subnodes for the simple case
where you just need to reference one slave iommu from a master
device.

It could be a recommendation for devices that have multiple slaves,
but I still haven't seen an example where this is actually needed.

> 3) Should "slave" or "slaves" be traversable for bridge- or bus-like
>    nodes?
> 
>    Saying "no" to this makes it impossible for the reachability graph of
>    the DT to contain cycles.  This is a clear benefit for any software
>    attempting to parse the DT in a robust way.  Only the first link,
>    from the initiating master to the first bridge, would be permitted
>    to be a "slaves" link.
> 
>    Ideally, we would want an IOMMU's bridge-like role to be represented
>    by some deep node in the DT: it can't usually be on the global path
>    from / since CPUs typically don't master through the IOMMU.
> 
>    Parsers could be made robust while still permitting this, by
>    truncating the search if the initial master node is reached.
>    Ill-formed DTs could contains cycles that can't be resolved in
>    this way, e.g., A -> B -> B.  For now it might be reasonable to
>    check for this in dtc.

I wouldn't be worried about cycles. We can just declare them forbidden
in the binding. Anything can break if you supply a broken DT, this
is the least of the problems.

	Arnd
