From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 2 May 2014 17:19:10 +0100
Subject: [RFC] Describing arbitrary bus mastering relationships in DT
In-Reply-To: <20140502110557.GA18452@ulmo>
References: <20140501173248.GD3732@e103592.cambridge.arm.com>
 <20140502110557.GA18452@ulmo>
Message-ID: <20140502161910.GC3805@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 01:05:58PM +0200, Thierry Reding wrote:
> On Thu, May 01, 2014 at 06:32:48PM +0100, Dave Martin wrote:
> [...]
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
> > 
> > generic device node property: "slave-names"
> > 
> > 	prohibited if there is no "slaves" property; otherwise
> > 	optional.  Recommended if the "slaves" property has
> > 	two or more entries.
> > 
> > 	type : string list with the same number of entries as
> > 		the number of cells in the value of the
> > 		"slaves" property.
> > 
> > 	Assigns symbolic names to the entries in the "slaves"
> > 	property, permitting slave connections with different
> > 	roles to be disambiguated.  See
> > 	Documentation/devicetree/bindings/resource-names.txt
> > 
> > generic device node: "slave"
> > 
> > 	optional
> > 
> > 	Implies that the device represented by the containing
> > 	node can issue transactions to the "slave" node.  "slave"
> > 	would always have these semantics; whether other child
> > 	nodes have a similar meaning is binding-specific.
> > 
> > 	property : "name"
> > 
> > 		optional
> > 
> > 		Assigns a symbolic name to this slave with
> > 		respect to the master.
> > 
> > If neither "slaves" nor any "slave" node is present, the topological
> > relationships are those defined by ePAPR: the device may or not be
> > a master, and if it is a master then it masters onto the parent node,
> > optionally propagating through the parent to the parent's parent
> > via mappings described by dma-ranges.
> 
> Let me see if I understood the above proposal by trying to translate it
> into a simple example for a specific use-case. On Tegra for example we
> have various units that can either access system memory directly or use
> the IOMMU to translate accesses for them. One such unit would be the
> display controller that scans out a framebuffer from memory.
> 
> 	dc at 0,54200000 {
> 		...
> 
> 		slave {
> 			/*
> 			 * 2 is the memory controller client ID of the
> 			 * display controller.
> 			 */
> 			iommu = <&iommu 2>;
> 
> 			...
> 		};
> 	};
> 
> Admittedly this is probably a lot more trivial than what you're looking
> for. There's no need for virtualization here, the IOMMU is simply used
> to isolate memory accesses by devices. Still it's a use-case that needs
> to be supported and one that at least Tegra and Exynos have an immediate
> need for.
> 
> So the above isn't much different from the proposed bindings, except
> that the iommu property is now nested within a slave node. I guess this
> gives us a lot more flexibility to extend the description of a slave as
> needed to represent more complex scenarios.
> 
> One thing that confuses me slightly about your proposal is that these
> subnodes describe the master interfaces of the containing nodes. Would
> it not be more appropriate to name the nodes "master" instead?
> 
> Also, are slaves/slave-names and slave subnodes mutually exclusive? It
> sounds like slaves/slave-names would be a specialization of the slave
> subnode concept for the trivial cases. Would the following be an
> equivalent description of the above example?
> 
> 	dc at 0,54200000 {
> 		...
> 
> 		slaves = <&iommu 2>;
> 	};

A slave node has the same meaning as a node referenced by a phandle
in slaves.  The only difference is where in the DT the node appears:
if the slave is shared by two masters then it probably doesn't make
sense to bury the node inside one of the masters' nodes.

I would picture the DT for your example system something like this:

	root: / {
		#address-cells = <2>;
		#address-cells = <2>;
		memory { ... };

		peripherals {
			ranges = ...;

			iommu {
				reg = < ... >;
				interrupts = < ... >;
				slaves = <&root>;
			};

			dc {
				slaves = <&iommu>;
				...
			};

			dmac at 1 {
				slaves = <&iommu>;
				...
			};

			dmac at 2 {
				slave {
					#address-cells = <2>;
					#size-cells = <2>;
					ranges = < 0 0 0 0 0 1 >;
					slaves = <&root>;
				};
			};
		};
	};

Here, for reasons best known to the hardware designers, dmac at 2 is
not connected via the IOMMU, but is only 32-bit capable, hence
we have a ranges property to describe how the root address space
is seen by dmac at 2.  (slave/#size-cells is 2 purely because we cannot
describe a size of 2^32 with #address-cells=1).

I could equally have done

	dmac at 2 {
		slaves = <&foo>;

		foo {
			#address-cells = <2>;
			#size-cells = <2>;
			ranges = < 0 0 0 0 0 1 >;
			slaves = <&root>;
		};
	};

... hence the doubt about whether "slave" nodes are really useful
in addition to "slaves" properties.

> I don't see how it could be exactly equivalent since it misses context
> regarding the type of slave that's being interacted with. Perhaps that

The compatible string on the referenced node tells you what it is.

The driver associated with the "iommu" node would provide functionality
to report the downstream mapping capabilities in this case, though it's
possible we could do parts of it in a generic way.

> could be solved by making that knowledge driver-specific (i.e. the
> driver for the Tegra display controller will know that it can only be
> the master on an IOMMU and therefore derive the slave type). Or the
> slave's type could be derived from the slave-names property.
> 
> While this proposal lacks specifics for IOMMU devices, I think it could

In case it wasn't clear, this proposoal is only about how to describe
linkage.  For IOMMUs and some other devices we also need to describe
how some other bus signals get mapped etc.

I have some ideas on these other areas, but I didn't want to dump it
all at once.

> work well to describe them in a generic way. Especially when slave nodes
> are used, arbitrarily more data can be added to describe more complex
> master interfaces (DMA windows, ...).
> 
> I still see an issue with supporting this generically with the currently
> recommended way to use IOMMUs (via the DMA mapping API). There's not
> enough granularity in the API to support this. It's probably going to
> work fine for Tegra, but I think for more complex cases drivers will
> probably need to use the IOMMU API directly.

Initially I would expect that Linux would only support rather limited
variations on this theme.

In particular, we would determine the path from each master device to
/memory, recording the mappings and components that we go through
along the way.

The simplest cases are:

  a) There is nothing on the path except static address remappings.

  b) There is nothing on the path except a single IOMMU.

> But that's an implementation detail and can probably be solved later.

There is no need why Linux should cope with anything that doesn't
match the simple cases until/unless such a system appears.  When and
if that happens, we would have a ready-made way of describing it.

Cheers
---Dave
