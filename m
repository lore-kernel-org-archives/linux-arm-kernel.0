From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 2 May 2014 13:05:58 +0200
Subject: [RFC] Describing arbitrary bus mastering relationships in DT
In-Reply-To: <20140501173248.GD3732@e103592.cambridge.arm.com>
References: <20140501173248.GD3732@e103592.cambridge.arm.com>
Message-ID: <20140502110557.GA18452@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 01, 2014 at 06:32:48PM +0100, Dave Martin wrote:
[...]
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
> 
> generic device node property: "slave-names"
> 
> 	prohibited if there is no "slaves" property; otherwise
> 	optional.  Recommended if the "slaves" property has
> 	two or more entries.
> 
> 	type : string list with the same number of entries as
> 		the number of cells in the value of the
> 		"slaves" property.
> 
> 	Assigns symbolic names to the entries in the "slaves"
> 	property, permitting slave connections with different
> 	roles to be disambiguated.  See
> 	Documentation/devicetree/bindings/resource-names.txt
> 
> generic device node: "slave"
> 
> 	optional
> 
> 	Implies that the device represented by the containing
> 	node can issue transactions to the "slave" node.  "slave"
> 	would always have these semantics; whether other child
> 	nodes have a similar meaning is binding-specific.
> 
> 	property : "name"
> 
> 		optional
> 
> 		Assigns a symbolic name to this slave with
> 		respect to the master.
> 
> If neither "slaves" nor any "slave" node is present, the topological
> relationships are those defined by ePAPR: the device may or not be
> a master, and if it is a master then it masters onto the parent node,
> optionally propagating through the parent to the parent's parent
> via mappings described by dma-ranges.

Let me see if I understood the above proposal by trying to translate it
into a simple example for a specific use-case. On Tegra for example we
have various units that can either access system memory directly or use
the IOMMU to translate accesses for them. One such unit would be the
display controller that scans out a framebuffer from memory.

	dc at 0,54200000 {
		...

		slave {
			/*
			 * 2 is the memory controller client ID of the
			 * display controller.
			 */
			iommu = <&iommu 2>;

			...
		};
	};

Admittedly this is probably a lot more trivial than what you're looking
for. There's no need for virtualization here, the IOMMU is simply used
to isolate memory accesses by devices. Still it's a use-case that needs
to be supported and one that at least Tegra and Exynos have an immediate
need for.

So the above isn't much different from the proposed bindings, except
that the iommu property is now nested within a slave node. I guess this
gives us a lot more flexibility to extend the description of a slave as
needed to represent more complex scenarios.

One thing that confuses me slightly about your proposal is that these
subnodes describe the master interfaces of the containing nodes. Would
it not be more appropriate to name the nodes "master" instead?

Also, are slaves/slave-names and slave subnodes mutually exclusive? It
sounds like slaves/slave-names would be a specialization of the slave
subnode concept for the trivial cases. Would the following be an
equivalent description of the above example?

	dc at 0,54200000 {
		...

		slaves = <&iommu 2>;
	};

I don't see how it could be exactly equivalent since it misses context
regarding the type of slave that's being interacted with. Perhaps that
could be solved by making that knowledge driver-specific (i.e. the
driver for the Tegra display controller will know that it can only be
the master on an IOMMU and therefore derive the slave type). Or the
slave's type could be derived from the slave-names property.

While this proposal lacks specifics for IOMMU devices, I think it could
work well to describe them in a generic way. Especially when slave nodes
are used, arbitrarily more data can be added to describe more complex
master interfaces (DMA windows, ...).

I still see an issue with supporting this generically with the currently
recommended way to use IOMMUs (via the DMA mapping API). There's not
enough granularity in the API to support this. It's probably going to
work fine for Tegra, but I think for more complex cases drivers will
probably need to use the IOMMU API directly.

But that's an implementation detail and can probably be solved later.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140502/a79bbac7/attachment-0001.sig>
