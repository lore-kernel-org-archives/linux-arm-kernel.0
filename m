From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 21 May 2014 10:26:11 +0200
Subject: [PATCH] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <5612206.Fzsy1mf3q3@wuerfel>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
 <8663464.40PHEumOar@wuerfel>
 <20140520152458.GB5041@e103592.cambridge.arm.com>
 <5612206.Fzsy1mf3q3@wuerfel>
Message-ID: <20140521082606.GB11068@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 10:26:12PM +0200, Arnd Bergmann wrote:
> On Tuesday 20 May 2014 16:24:59 Dave Martin wrote:
> > On Tue, May 20, 2014 at 02:41:18PM +0200, Arnd Bergmann wrote:
> > > On Tuesday 20 May 2014 14:02:43 Thierry Reding wrote:
[...]
> > > > Multiple-master IOMMU:
> > > > ----------------------
> > > > 
> > > > 	iommu {
> > > > 		/* the specifier represents the ID of the master */
> > > > 		#address-cells = <1>;
> > > > 		#size-cells = <0>;
> > 
> > How do we know the size of the input address to the IOMMU?  Do we
> > get cases for example where the IOMMU only accepts a 32-bit input
> > address, but some 64-bit capable masters are connected through it?
> 
> I was stuck on this question for a while before, but then I realized
> that it doesn't matter at all: It's the IOMMU driver itself that
> manages the address space, and it doesn't matter if a slave can
> address a larger range than the IOMMU can accept. If the IOMMU
> needs to deal with the opposite case (64-bit input addresses
> but a 32-bit master), that limitation can be put into the specifier.

Isn't this what DMA masks are for? Couldn't the IOMMU simply use the
master device's DMA mask to do the right thing here?

As such I don't think this information needs to be in device tree at
all. The DMA mask should typically be set by the driver in the first
place because it has knowledge about the capabilities of the device.
A different way of saying that is that the DMA mask is implied by the
device's compatible string.

> > For determining dma masks, it is the output address that it
> > important.  Santosh's code can probably be taught to handle this,
> > if given an additional traversal rule for following "iommus"
> > properties.  However, deploying an IOMMU whose output address size
> > is smaller than the 
> 
> Something seems to be missing here. I don't think we want to handle
> the case where the IOMMU output cannot the entire memory address
> space. If necessary, that would mean using both an IOMMU driver
> and swiotlb, but I think it's a reasonable assumption that hardware
> isn't /that/ crazy.

Similarily, should the IOMMU not be treated like any other device here?
Its DMA mask should determine what address range it can access.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/7d8e7b76/attachment.sig>
