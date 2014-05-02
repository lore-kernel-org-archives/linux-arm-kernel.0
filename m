From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 May 2014 22:36:43 +0200
Subject: [RFC] Describing arbitrary bus mastering relationships in DT
In-Reply-To: <20140502173120.GD3805@e103592.cambridge.arm.com>
References: <20140501173248.GD3732@e103592.cambridge.arm.com>
 <6774053.rAccqTeoiQ@wuerfel>
 <20140502173120.GD3805@e103592.cambridge.arm.com>
Message-ID: <4327552.i65x7H2WQr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 May 2014 18:31:20 Dave Martin wrote:
> No, but I didn't state it very clearly.
> 
> In this:
> 
>         parent {
>                 child {
>                         ranges = < ... >;
>                         dma-ranges = < ... >;
>                 };
>         };

The ranges and dma-ranges properties belong into parent, not child here.
I guess that's what you meant at least.

> There are two transaction flows being described.  There are transactions
> from parent -> child, for which "ranges" describes the mappings, and
> there are transactions from child -> parent, for which "dma-ranges"
> describes the mappings.

Right.

> The name "dma-ranges" obfuscates this symmetry, so it took me a while
> to figure out what it really means -- maybe I'm still confused, but
> I think that's the gist of it.
> 
> 
> For the purposes of cross-links, my plan was that we interpret all
> those links as "forward" (i.e., parent -> child) links, where the
> referencing node is deemed to be the parent, and the referenced node is
> deemed to be the child. Just as in the ePAPR case, the associated mapping
> is then described by "ranges".

That seems counterintuitive to me. When a device initiates a transaction,
it should look at the "dma-ranges" of its parent. The "slaves" property
would be a way to redirect the parent for these transactions, but it
doesn't mean that the device suddenly translates ranges as seen from
its parent.

In other words, "ranges" should always move from CPU to MMIO target
(slave), while "dma-ranges" should always move from a DMA master towards
memory. If you want to represent a device-to-device DMA, you may have
to move up a few levels using "dma-ranges" and then move down again
using "ranges".

> > Don't you need arguments to the phandle? It seems that in most
> > cases, you need at least one of a dma-ranges like translation
> > or a master ID. What you need would be specific to the slave.
> 
> For any 1:N relationship between nodes, you can describe the
> _relationship_ by putting properties on the nodes at the "1" end.  This
> is precisely how "ranges" and "dma-ranges" work.

That doesn't seem very helpful or intuitive though. If I have
an IOMMU that N DMA masters can target, I don't want to have
information about all the masters in the IOMMU, that information
belongs into the masters, but the format in which it is stored
must be specific to the IOMMU.

> The N:M case can be resolved by inserting simple-bus nodes into any
> links with non-default mappings: i.e., you split each affected link in
> two, with a simple-bus node in the middle describing the mapping:

Ok, ignoring those oddball cases for now, I'd like to first
try to come to a more useful representation for the common case.

> root: / {
>         ranges;
>         ...
> 
>         master at 1 {
>                 slave {
>                         ranges = < ... >;
>                         slaves = <&root>;
>                 };
>         };

The "ranges" property here is really weird. I understand you
mean this to be a device that has a unique mapping into its
the slave (the root device here). I would reduce this to one
of two cases:

a) it sits on an intermediate bus by itself, and that bus
has the non-default mapping:

/ {
	dma-ranges;
	ranges;

	bus at x {
		ranges;
		dma-ranges = < ... >; // this is the mapping
		master at 1 {
			...
		};
	};

b) the device itself is strange, but it's a property of the
device that the driver knows about (e.g. it can only do
a 30-bit DMA mask rather than 32 bit, for a realistic case),
so we don't have represent this at all and let the driver
deal with the translation:

/ {
	dma-ranges;
	ranges;

	master at 1 {
		...
	};

};

>         master at 2 {
>                 slave {
>                         slaves = < &root &master2_dma_slave >;
>                         slave-names = "config-fetch", "dma";
> 
>                	   master2_dma_slave: dma-slave {
>                                 ranges = < ... >;
>                                 slaves = <&root>;
>                         };
>                 };
>         };

As I said before, I'd consider this a non-issue until anyone
can come up with a case that needs the complexity.

A possible representation would be to have two masters
as child nodes of the actual device to avoid having a 'slaves'
property with multiple entries, and if the device is the only
one with a weird translation, that can go to some other bus
node we make up for this purpose:

/ {
	ranges;
	dma-ranges;

	fake-bus {
		dma-ranges = < ... >;
		slaves = < &{/} >; // is the default, so can be ommitted
	};

	bus {
		ranges;
		// no dma-ranges --> no default DMA translation

		device at 1 {
			master at 1 {
				// hopefully will never be
				// needed in real life
				slaves = < &{/fake-bus}>;
			};

			master at 2 {
				slaves = < &{/} >;
			};
		};
	};
};

>         master at 3 {
>                 slaves = <&root>;
>         };
> };

Here, the slave is the parent device, which is the default
anyway, so I wouldn't require listing anything at all,
besides an empty dma-ranges in the parent node.

If we can get away with just a single entry in 'slaves' all
the time, we could actually rename that property to 'dma-parent',
for consistency with 'interrupt-parent' and a few other things.

Freescale already has 'fsl,iommu-parent' for this case, a
'dma-parent' would be a generalization of that, but less general
than your 'slaves' property.

> > It may be best to make the ranges explicit here and then also
> > allow additional fields depending on e.g. a #dma-slave-cells
> > property in the slave.
> > 
> > For instance, a 32-bit master on a a 64-bit bus that has master-id
> > 23 would look like
> > 
> >       otherbus: axi at somewhere{
> >               #address-cells = <2>;
> >               #size-cells = <2>;
> >       };
> > 
> >       somemaster at somewhere {
> >               #address-cells = <1>;
> >               #size-cells = <1>;
> >               slaves = <&otherbus  // phandle
> >                               0     // local address
> >                               0 0   // remote address
> >                               0x1 0 // size
> >                               23>;  // master id
> >       };
> 
> I thought about this possibility, but was worried that the "slaves"
> property would become awkward to parse, where except for the "master id"
> concept, all these attributes are well described by ePAPR already for
> bus nodes if we can figure out how to piggyback on them -- hence my
> alternative approach explained above.
> 
> How to describe the "master id" is particularly problematic and may
> be a separate discussion.  It can get munged or remapped as it
> passes through the interconnect: for example, a PCI device's ID 
> accompanying an MSI write may be translated once as it passes from
> the PCI RC to an IOMMU, then again before it reaches the GIC.

Hmm, that would actually mean we'd have to do complex "dma-ranges"
properties with more than one entry, which I had hoped to avoid.

> In the "windowed IOMMU" case, address bits are effectively being
> mapped to ID bits as they reach IOMMU.
> 
> An IOMMU also does a complete mapping of ID+address -> ID'+address'
> (although programmable rather than static and unprobeable, so the
> actual mappings for an IOMMU won't be in the DT).

right.

> > > 2) The generic "slave" node(s) are for convenience and readability.
> > >    They could be made eliminated by using child nodes with
> > >    binding-specific names and referencing them in "slaves".  This is a
> > >    bit more awkward, but has the same expressive power.
> > > 
> > >    Should the generic "slave" nodes go away?
> > 
> > I would prefer not having to have subnodes for the simple case
> > where you just need to reference one slave iommu from a master
> > device.
> 
> My expectation is that subnodes would only be useful in special cases in
> any case.
> 
> We can remove the special "slave" name, because there's nothing to
> stop us referencing other random nested nodes with the "slaves" property.

Ok.

> > I wouldn't be worried about cycles. We can just declare them forbidden
> > in the binding. Anything can break if you supply a broken DT, this
> > is the least of the problems.
> 
> That's my thought.  If there turns out to be a really good reason to
> describe cycles then we can cross that bridge* when we come to it,
> but it's best to forbid it until/unless the need for it is proven.
> 
> (*no pun intended)

Right.

> Note that a certain kind of trivial cycle will always be created
> when a node refers back to its parent:
> 
> root: / {
>         ranges;
> 
>         iommu {
>                 reg = < ... >;
>                 slaves = <&root>;
>         };
> };
> 
> ePAPR says that if there is no "ranges" property, then the parent
> node cannot access any address of the child -- we can interpret
> this as saying that transactions do not propagate.  "ranges" with
> an empty value imples a complete 1:1 mapping, which we can interpret
> as transactions being forwarded without any transformation.
> 
> Crucially, "iommu" must not have a "ranges" property in this case,
> because this would permit a static routing cycle root -> iommu ->
> root.

Makes sense.

	Arnd
