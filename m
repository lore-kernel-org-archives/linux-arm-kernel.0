From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 1 May 2014 18:32:48 +0100
Subject: [RFC] Describing arbitrary bus mastering relationships in DT
Message-ID: <20140501173248.GD3732@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Note, this is a long mail -- people in a hurry may want to skip to
"Outline binding" to get a feel for what is bring proposed, before
returning to the background wording.)

As highlighted in some previous discussions[1], it is becoming possible
to build ARM-based SoCs that seem to be impossible to describe using the
DT bindings currently specified by ePAPR.  This is driven by increasing
complexity of interconnects, the appearance of IOMMUs, MSI-capable
interrupt controllers and multiple bus masters.

This issue is not fundamental to ARM and could apply to other SoC
families with a similar bus architecture, but most of the current
discussion in this area has been about how to address these
requirements for ARM SoCs.

This RFC is an outline for some core bindings to solve part of the
problem of describing such systems, particularly how to describe master/
slave relationships not currently representable in DT.  It is premature
to make a concrete proposal yet: rather I'm presenting this as a starting
point for discussion initially.

The intent is not to rewrite existing bindings, but to define a common
DT approach for describing otherwise problematic features of future
systems.  Actual Linux support for this could be implemented as needed.


** Preamble **

ePAPR assumes that all bus mastering is from a node to one of its
child nodes, or from a node to its parent node.

The actual bus mastering relationships in SoCs using a unidirectional
bus architecture such as AMBA usually do not follow this model.
However, historically interconnects have been so simple in their
behaviour that the discrepancies are transparent to software: thus
it has been possible to get away with not describing the true hardware
relationships.

There is a risk that every exception to the tree structure will
be solved with a different ad-hoc, binding-specific solution if
no uniform approach is adopted.

This RFC sketches bindings for an additional way of specifying
a master-slave link, for cases where there is no possible arrangement
of nodes that maps all master/slave relationships consistently
onto the DT.

This aims to allow for correct description of the topological
relationships of all bus masters, as well as bridge-like components
such as IOMMUs and other bus adaptors, any of which may be shared
in many-to-many configurations in an ARM SoC.


[1] see for example "[PATCH v12 11/31] documentation: iommu: add binding
document of Exynos System MMU"
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/251231.html


** Outline binding **

generic device node property: "slaves"

	optional

	type : cell array consisting of one or more phandles

	Implies that the device represented by the containing node
	can issue transactions to the referenced node.

	The referenced node is any bus or device node, and is
	interpreted in the usual way, including the treatment
	of ranges, #address-cells and #size-cells.  If the
	referenced node has a non-empty ranges property, the
	referencing node's #address-cells must be the same as
	that of the referenced node's device tree parent.

generic device node property: "slave-names"

	prohibited if there is no "slaves" property; otherwise
	optional.  Recommended if the "slaves" property has
	two or more entries.

	type : string list with the same number of entries as
		the number of cells in the value of the
		"slaves" property.

	Assigns symbolic names to the entries in the "slaves"
	property, permitting slave connections with different
	roles to be disambiguated.  See
	Documentation/devicetree/bindings/resource-names.txt

generic device node: "slave"

	optional

	Implies that the device represented by the containing
	node can issue transactions to the "slave" node.  "slave"
	would always have these semantics; whether other child
	nodes have a similar meaning is binding-specific.

	property : "name"

		optional

		Assigns a symbolic name to this slave with
		respect to the master.

If neither "slaves" nor any "slave" node is present, the topological
relationships are those defined by ePAPR: the device may or not be
a master, and if it is a master then it masters onto the parent node,
optionally propagating through the parent to the parent's parent
via mappings described by dma-ranges.


Rationale:

The intention is that by substituting a master's node for /, and
adding traversal rules for "slaves" properties and "slave" nodes in
addition to the usual devicetree parent/child relationship rules, the
path from any master to any addressable slave can be determined, along
with any mappings associated with it.

This allows the potentially unique address mappings for a particular
master to be determined, as well as allowing per-device and global DMA
masks to be derived from the device tree.

Slave references via this binding would be strictly unidirectional,
so any dma-ranges property on the slave end is ignored and the
master is not considered to be addressable by the slave (unless
there is another, separate path in the DT from the slave back to
the master).

I consider this reasonable because the bidirectional bus case is
already well described by ePAPR; so, the slaves convention should
only be used for unidirectional links that break the ePAPR mould.


Questions:

1) Should the names "slaves" and "slave" be globally generic?

   Pro: Making them generic permits some processing to be done on the DT
   without knowing the individual bindings for every node, such as
   figuring out the global DMA mask.  It should also encourage adoption
   of the bindings as a common approach.

   Con: Namespace pollution

   Otherwise, there could be a special string in the node's compatible
   list (strictly not "simple-bus") to indicate that these properties
   should be interpreted.

   The alternative is for the way of identifying a node's slaves to be
   binding-specific.  This makes some generic operations on the DT
   impossible without knowing all the bindings, such as analysing
   reachability or determining the effective DMA mask.  This analysis
   can be performed using generic bindings alone today, for systems
   describable by ePAPR.  Breaking this concept feels like a backward
   step.

2) The generic "slave" node(s) are for convenience and readability.
   They could be made eliminated by using child nodes with
   binding-specific names and referencing them in "slaves".  This is a
   bit more awkward, but has the same expressive power.

   Should the generic "slave" nodes go away?

3) Should "slave" or "slaves" be traversable for bridge- or bus-like
   nodes?

   Saying "no" to this makes it impossible for the reachability graph of
   the DT to contain cycles.  This is a clear benefit for any software
   attempting to parse the DT in a robust way.  Only the first link,
   from the initiating master to the first bridge, would be permitted
   to be a "slaves" link.

   Ideally, we would want an IOMMU's bridge-like role to be represented
   by some deep node in the DT: it can't usually be on the global path
   from / since CPUs typically don't master through the IOMMU.

   Parsers could be made robust while still permitting this, by
   truncating the search if the initial master node is reached.
   Ill-formed DTs could contains cycles that can't be resolved in
   this way, e.g., A -> B -> B.  For now it might be reasonable to
   check for this in dtc.

4) Is the location of the memory node going to cause problems?

   Even in complex systems, it is usually topologically correct (or
   at least correct enough) to put memory in /.  ePAPR does not actually
   say that the memory must be at / or that there must be only one
   memory node, but some software may be relying on this even if it's
   not correct with respect to the topology.

   Linux's early FDT parsing would probably be affected by moving this
   node, since it appears at least to ignore ranges properties.  It
   is highly likely that firmware and bootloaders that manipulate
   /memory would get confused if it was moved out of /.
