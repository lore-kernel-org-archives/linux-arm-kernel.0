From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 20 May 2014 17:39:12 +0100
Subject: [PATCH] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140520152659.GA30404@arm.com>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
 <5080348.QmhgfQRxZW@wuerfel>
 <20140520130659.GA5041@e103592.cambridge.arm.com>
 <6382280.3uMvoxaUSK@wuerfel> <20140520152659.GA30404@arm.com>
Message-ID: <20140520163912.GC5041@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 04:26:59PM +0100, Will Deacon wrote:
> On Tue, May 20, 2014 at 02:23:47PM +0100, Arnd Bergmann wrote:
> > 	Bit#   33222222 22221111 11111100 00000000
> > 	       10987654 32109876 54321098 76543210
> > phys.hi cell:  npt000ss bbbbbbbb dddddfff rrrrrrrr
> > phys.mid cell: hhhhhhhh hhhhhhhh hhhhhhhh hhhhhhhh
> > phys.lo cell:  llllllll llllllll llllllll llllllll
> > 
> > where:
> > n is 0 if the address is relocatable, 1 otherwise
> > p is 1 if the addressable region is "prefetchable", 0 otherwise
> > t is 1 if the address is aliased (for non-relocatable I/O),
> >  below 1 MB (for Memory), or below 64 KB (for relocatable I/O).
> > ss is the space code, denoting the address space
> > bbbbbbbb is the 8-bit Bus Number
> > ddddd is the 5-bit Device Number
> > fff is the 3-bit Function Number
> > rrrrrrrr is the 8-bit Register Number
> > hh...hh is a 32-bit unsigned number
> > ll...ll is a 32-bit unsigned number
> > 
> > We can ignore n, p, t and r here, and use the same format for a DMA
> > address, then define an empty "dma-ranges" property. That would
> > imply that using b/d/f is sufficient to identify each master at the
> > iommu. Any device outside of the PCI host but connected to the same
> > iommu can use the same notation to list the logical b/d/f that gets
> > sent to the IOMMU in bus master transactions.
> > 
> > Do you think this is sufficient for the ARM SMMU, or do we need
> > something beyond that?
> 
> I think it can define the common-cases for the existing implementations,
> yes. I anticipate Stream-IDs becoming > 16-bit in the near future though,
> so we'd need extra bits if we're describing other devices coming into the
> SMMU.
> 
> Note that we already have a binding for the current SMMU driver, so I'm not
> really in a position to shift over to a new binding until the next version of
> the SMMU architecture comes along...

How much code relies on the meaning of the nptsbdf bits?

Following the general model of concatenating the master ID with the
address bits and trasting that as a single input to the IOMMU seems
reasonable -- maybe we either don't care about the attribute bits and
can replace them with master ID bits, or instead we could extend with
more master ID bits at bit 96 and up.

npts looks like memory type information.  What memory type information
we need to describe for coherent masters on ARM is a bit of an open
question.  Perhaps we can come up with a good ARM-specific interpretation
of these bits, but I wonder whether they are enough.

If there is a real PCI bus in the system of course, then we are fine
once we reach it.  The only problem is for the stuff on AMBA buses etc.

In theory, we could have to describe memory types, cacheability
attributes and coherency domains, but we may be able to squeeze the
possibilities down to a smaller set of sane memory types.

Cheers
---Dave
