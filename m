From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 May 2014 16:26:59 +0100
Subject: [PATCH] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <6382280.3uMvoxaUSK@wuerfel>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
 <5080348.QmhgfQRxZW@wuerfel>
 <20140520130659.GA5041@e103592.cambridge.arm.com>
 <6382280.3uMvoxaUSK@wuerfel>
Message-ID: <20140520152659.GA30404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 02:23:47PM +0100, Arnd Bergmann wrote:
> 	Bit#   33222222 22221111 11111100 00000000
> 	       10987654 32109876 54321098 76543210
> phys.hi cell:  npt000ss bbbbbbbb dddddfff rrrrrrrr
> phys.mid cell: hhhhhhhh hhhhhhhh hhhhhhhh hhhhhhhh
> phys.lo cell:  llllllll llllllll llllllll llllllll
> 
> where:
> n is 0 if the address is relocatable, 1 otherwise
> p is 1 if the addressable region is "prefetchable", 0 otherwise
> t is 1 if the address is aliased (for non-relocatable I/O),
>  below 1 MB (for Memory), or below 64 KB (for relocatable I/O).
> ss is the space code, denoting the address space
> bbbbbbbb is the 8-bit Bus Number
> ddddd is the 5-bit Device Number
> fff is the 3-bit Function Number
> rrrrrrrr is the 8-bit Register Number
> hh...hh is a 32-bit unsigned number
> ll...ll is a 32-bit unsigned number
> 
> We can ignore n, p, t and r here, and use the same format for a DMA
> address, then define an empty "dma-ranges" property. That would
> imply that using b/d/f is sufficient to identify each master at the
> iommu. Any device outside of the PCI host but connected to the same
> iommu can use the same notation to list the logical b/d/f that gets
> sent to the IOMMU in bus master transactions.
> 
> Do you think this is sufficient for the ARM SMMU, or do we need
> something beyond that?

I think it can define the common-cases for the existing implementations,
yes. I anticipate Stream-IDs becoming > 16-bit in the near future though,
so we'd need extra bits if we're describing other devices coming into the
SMMU.

Note that we already have a binding for the current SMMU driver, so I'm not
really in a position to shift over to a new binding until the next version of
the SMMU architecture comes along...

Will
