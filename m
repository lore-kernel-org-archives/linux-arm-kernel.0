From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 30 May 2014 21:01:19 +0200
Subject: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140530112226.GA3949@e103592.cambridge.arm.com>
References: <1400877395-4235-1-git-send-email-thierry.reding@gmail.com>
 <20140530112226.GA3949@e103592.cambridge.arm.com>
Message-ID: <4830064.JvgTAs8Xty@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 30 May 2014 12:22:32 Dave Martin wrote:
> > +
> > +Examples:
> > +=========
> > +
> > +Single-master IOMMU:
> > +--------------------
> > +
> > +	iommu {
> > +		#address-cells = <0>;
> > +		#size-cells = <0>;
> > +	};
> > +
> > +	master {
> > +		iommus = <&/iommu>;
> > +	};
> > +
> > +Multiple-master IOMMU with fixed associations:
> > +----------------------------------------------
> > +
> > +	/* multiple-master IOMMU */
> > +	iommu {
> > +		/*
> > +		 * Masters are statically associated with this IOMMU and
> > +		 * address translation is always enabled.
> > +		 */
> > +		#address-cells = <0>;
> > +		#size-cells = <0>;
> 
> In this example, can different translations be set up for the different
> masters?
> 
> With no cells available to contain any sort of ID, it looks like this
> is not possible.

Correct, this example is for an IOMMU that does not use IDs but has a
shared address space for all devices.

> > +Multiple-master IOMMU with configurable DMA window:
> > +---------------------------------------------------
> > +
> > +	/ {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +
> > +		iommu {
> > +			/* master ID, address of DMA window */
> > +			#address-cells = <2>;
> > +			#size-cells = <2>;
> > +		};
> > +
> > +		master {
> > +			/* master ID 42, 4 GiB DMA window starting at 0 */
> > +			iommus = <&/iommu  42 0  0x1 0x0>;
> 
> I'm still concerned that in order to deal with future cases we will have
> to invent multiple ways to parse the "iommus" property.  For example, if
> we have a PCEe RC mastering through an IOMMU, it will pass a huge set
> of possible master IDs to the IOMMU, not just noe or two.
> 
> Do you have a solution in mind for that which doesn't break backwards
> compatibility?

I think we can treat PCI as a special case here and have an interface
that gets used by the PCI core code to talk to the IOMMU core code
when setting up a the dma_map_ops for a PCI function. As long as the
IOMMU driver understands what PCI is, we don't have to describe the
mapping in detail.

> One option is to include an extra cell to the IOMMUs property
> that indicates how to parse it.  For now, only a single value would
> be defined.  For example:
> 
> 	iommus = <&/iommu IOMMU_SIMPLE 42>;
> 
> Then maybe later
> 
> 	iommus = <&/iommu IOMMU_RANGE 0x10000 0x10000>;
> 
> (I'm not suggesting what IOMMU_RANGE might mean.)
> 

This can really be left up to the specific IOMMU driver itself.
We can have drivers that support both #address-cells=<1>
and #address-cells=<2> and behave differently based on that.
I don't see a reason to define that across IOMMU implementations.

> Other options are to introduce a new property name
> 
> 	range-iommus = <&/iommu 0x10000 0x10000>;
> 
> or control the parsing of incompatible iommus properties via a compatible
> string somewhere.

Introducing a new compatible string is always an option as the last resort.

	Arnd
