From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Dec 2014 17:20:00 +0000
Subject: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
 of_dma_configure
In-Reply-To: <1926348.VsVWqO766S@wuerfel>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <549192D2.10008@arm.com> <20141217150158.GF870@arm.com>
 <1926348.VsVWqO766S@wuerfel>
Message-ID: <20141217172000.GC30307@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 03:38:22PM +0000, Arnd Bergmann wrote:
> On Wednesday 17 December 2014 15:01:58 Will Deacon wrote:
> > On Wed, Dec 17, 2014 at 02:27:30PM +0000, Robin Murphy wrote:
> > > I thoroughly dislike the idea, but one /could/ simply abuse the generic 
> > > bindings well within the current framework, e.g.
> > > 
> > > #1: iommus = <&smmu 0 streamID 0 0>, <&smmu 0 streamID 0 0>, ...;
> > > #2: iommus = <&smmu 1 mask value 0>;
> > > #3: iommus = <&smmu 2 start end offset>;
> > > 
> > > and have a big complicated of_xlate that knows the secret. I don't think 
> > > it would be unreasonable to constrain all masters on the same SMMU to 
> > > use the same format either - that way you can lose the type indicator 
> > > and the padding and the driver simply inspects #iommu-cells in 
> > > of_iommu_init and sets up that instance to take the right path in its 
> > > of_xlate calls later. Having a handful of single-stream-ID masters 
> > > behind the same SMMU as a whacking great bus controller with a massive 
> > > range seems like the kind of system-designer-insanity we should 
> > > emphatically NOT be looking to accommodate if we can possibly help it.
> > > 
> > > That said, for the time being I see definite use-cases for #1, which 
> > > already works, and #3, for which I really think we should be looking to 
> > > add a parallel generic "iommu-ranges" or "iommu-bus-range" binding for 
> > > bus controllers, rather than trying to overload "iommus" beyond 
> > > describing actual bus masters.
> > 
> > Yeah, let's avoid overloading the current bindings too much. Adding the
> > ranges property makes perfect sense, I'm just trying to to straighten
> > out how the "iommus" property should differ depending on the presence of
> > SMR groups.
> 
> Is a range something that is defined in the hardware spec, or is that
> just what you expect the PCI host controllers to use? 

The range would be a Linux-ism for converting a bus ID on bus foo (e.g. a
requester ID on a PCI bus) into a master ID for the IOMMU for that bus
(e.g. a stream ID for an ARM SMMU). However, I don't think the code doing
that mapping really needs knowledge about what the IDs represent.

Will
