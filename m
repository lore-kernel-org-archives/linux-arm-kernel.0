From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 2 Jun 2014 12:44:51 +0100
Subject: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <4830064.JvgTAs8Xty@wuerfel>
References: <1400877395-4235-1-git-send-email-thierry.reding@gmail.com>
 <20140530112226.GA3949@e103592.cambridge.arm.com>
 <4830064.JvgTAs8Xty@wuerfel>
Message-ID: <20140602114450.GF3855@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 09:01:19PM +0200, Arnd Bergmann wrote:
> On Friday 30 May 2014 12:22:32 Dave Martin wrote:
> > > +
> > > +Examples:
> > > +=========
> > > +
> > > +Single-master IOMMU:
> > > +--------------------
> > > +
> > > +	iommu {
> > > +		#address-cells = <0>;
> > > +		#size-cells = <0>;
> > > +	};
> > > +
> > > +	master {
> > > +		iommus = <&/iommu>;
> > > +	};
> > > +
> > > +Multiple-master IOMMU with fixed associations:
> > > +----------------------------------------------
> > > +
> > > +	/* multiple-master IOMMU */
> > > +	iommu {
> > > +		/*
> > > +		 * Masters are statically associated with this IOMMU and
> > > +		 * address translation is always enabled.
> > > +		 */
> > > +		#address-cells = <0>;
> > > +		#size-cells = <0>;
> > 
> > In this example, can different translations be set up for the different
> > masters?
> > 
> > With no cells available to contain any sort of ID, it looks like this
> > is not possible.
> 
> Correct, this example is for an IOMMU that does not use IDs but has a
> shared address space for all devices.
> 
> > > +Multiple-master IOMMU with configurable DMA window:
> > > +---------------------------------------------------
> > > +
> > > +	/ {
> > > +		#address-cells = <1>;
> > > +		#size-cells = <1>;
> > > +
> > > +		iommu {
> > > +			/* master ID, address of DMA window */
> > > +			#address-cells = <2>;
> > > +			#size-cells = <2>;
> > > +		};
> > > +
> > > +		master {
> > > +			/* master ID 42, 4 GiB DMA window starting at 0 */
> > > +			iommus = <&/iommu  42 0  0x1 0x0>;
> > 
> > I'm still concerned that in order to deal with future cases we will have
> > to invent multiple ways to parse the "iommus" property.  For example, if
> > we have a PCEe RC mastering through an IOMMU, it will pass a huge set
> > of possible master IDs to the IOMMU, not just noe or two.
> > 
> > Do you have a solution in mind for that which doesn't break backwards
> > compatibility?
> 
> I think we can treat PCI as a special case here and have an interface
> that gets used by the PCI core code to talk to the IOMMU core code
> when setting up a the dma_map_ops for a PCI function. As long as the
> IOMMU driver understands what PCI is, we don't have to describe the
> mapping in detail.

PCI is only an example, but I admit it's likely to be the most important
example of a peripheral using a huge ID space.

There may still be integration-specific parameters which would need to
be fed in via DT regarding how IDs coming out of the RC map onto the
IOMMU and GIC.

> 
> > One option is to include an extra cell to the IOMMUs property
> > that indicates how to parse it.  For now, only a single value would
> > be defined.  For example:
> > 
> > 	iommus = <&/iommu IOMMU_SIMPLE 42>;
> > 
> > Then maybe later
> > 
> > 	iommus = <&/iommu IOMMU_RANGE 0x10000 0x10000>;
> > 
> > (I'm not suggesting what IOMMU_RANGE might mean.)
> > 
> 
> This can really be left up to the specific IOMMU driver itself.
> We can have drivers that support both #address-cells=<1>
> and #address-cells=<2> and behave differently based on that.
> I don't see a reason to define that across IOMMU implementations.

There's a risk we have to come up with multiple solutions to the same
problem there -- i.e., one solution per IOMMU implementation and then
another solution for the GIC.

Ideally that would be avoided, but the number of times this problem
would need to be solved is probably not that large.

Cheers
---Dave
