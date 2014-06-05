From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 Jun 2014 11:42:12 +0200
Subject: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140604213159.GB18780@mithrandir>
References: <1400877395-4235-1-git-send-email-thierry.reding@gmail.com>
 <4830064.JvgTAs8Xty@wuerfel> <20140604213159.GB18780@mithrandir>
Message-ID: <6794037.0YTCc6JFQV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 June 2014 23:32:00 Thierry Reding wrote:
> On Fri, May 30, 2014 at 09:01:19PM +0200, Arnd Bergmann wrote:
> > On Friday 30 May 2014 12:22:32 Dave Martin wrote:
> > > > +
> > > > +Examples:
> > > > +=========
> > > > +
> > > > +Single-master IOMMU:
> > > > +--------------------
> > > > +
> > > > + iommu {
> > > > +         #address-cells = <0>;
> > > > +         #size-cells = <0>;
> > > > + };
> > > > +
> > > > + master {
> > > > +         iommus = <&/iommu>;
> > > > + };
> > > > +
> > > > +Multiple-master IOMMU with fixed associations:
> > > > +----------------------------------------------
> > > > +
> > > > + /* multiple-master IOMMU */
> > > > + iommu {
> > > > +         /*
> > > > +          * Masters are statically associated with this IOMMU and
> > > > +          * address translation is always enabled.
> > > > +          */
> > > > +         #address-cells = <0>;
> > > > +         #size-cells = <0>;
> > > 
> > > In this example, can different translations be set up for the different
> > > masters?
> > > 
> > > With no cells available to contain any sort of ID, it looks like this
> > > is not possible.
> > 
> > Correct, this example is for an IOMMU that does not use IDs but has a
> > shared address space for all devices.
> 
> Couldn't these device all still have separate address spaces?

No. If they had separate address spaces, they would require a more
sophisticated IOMMU. A simple IOMMU without IDs can only be used
for overcoming address space limits (e.g. for 32-bit DMA masters on
systems with more than 4GB RAM) but not for strict isolation.

You basically have one page table shared across all devices connected
to the IOMMU, and every call to dma_alloc_coherent or dma_map_*
allocates a new IOVA that isn't used by any of the other devices
already, but you can't prevent a malicious user from getting a device
to do DMA to an IOVA that has been set up for another device.

You could have one such IOMMU per device of course, but I guess that's
not what you mean.

	Arnd
