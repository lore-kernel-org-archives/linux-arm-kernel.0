From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 04 Feb 2014 18:04:56 +0100
Subject: [RFC/RFT 1/2] ARM: mm: introduce arch hooks for dma address
 translation routines
In-Reply-To: <52F11788.4030500@ti.com>
References: <1391470107-15927-1-git-send-email-santosh.shilimkar@ti.com>
 <201402041715.54538.arnd@arndb.de> <52F11788.4030500@ti.com>
Message-ID: <3284212.inOfNqnVqs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 February 2014 11:38:32 Santosh Shilimkar wrote:
> On Tuesday 04 February 2014 11:15 AM, Arnd Bergmann wrote:
> > On Tuesday 04 February 2014, Santosh Shilimkar wrote:

> > I think this is going into a wrong direction. DMA translation is not
> > at all a platform-specific thing, but rather bus specific. The most
> > common scenario is that you have some 64-bit capable buses and some
> > buses that are limited to 32-bit DMA (or less if you are unfortunate).
> >
> I may be wrong but you could have 64 bit bus but 32 bit DMA controllers.
> That is one of the case I am dealing with.

You are absolutely right. In fact you could have any combination of
bus widths between a device and the RAM and the correct way to deal
with this is probably to follow the dma-ranges properties of each
device in-between and take the intersection (that may not be the
right term in English, but I think you know what I mean).

> > I guess for the legacy cases (omap1, iop13xx, ks8695), we can
> > hardcode dma_map_ops for all devices to get this right. For everything
> > else, I'd suggest defaulting to the arm_dma_ops unless we get
> > other information from DT. This means we have to create standardized
> > properties to handle any combination of these:
> > 
> Thats the case and the $subject series doesn't change that.
> 
> > 1. DMA is coherent
> > 2. DMA space is offset from phys space
> > 3. DMA space is smaller than 32-bit
> > 4. DMA space is larger than 32-bit
> > 5. DMA goes through an IOMMU
> > 
> > The dma-ranges property can deal with 2-4. Highbank already introduced
> > a "dma-coherent" flag for 1, and we can decide to generalize that.
> > I don't know what the state of IOMMU support is, but we have to come
> > up with something better than what we had on PowerPC, because we now
> > have to deal with a combination of different IOMMUs in the same system,
> > whereas the most complex case on PowerPC was some devices all going
> > through one IOMMU and the other devices being linearly mapped.
> > 
> Just to be clear, the patch set is not fiddling with dma_ops as such.
> The dma_ops needs few accessors to convert addresses and these accessors
> are different on few platforms. And hence needs to be patched.

well, iop13xx is certainly not going to be multiplatform any time
soon, so we don't have to worry about those. ks8695 won't be multiplatform
unless I do it I suspect. I don't know about the plans for OMAP1,
but since only the OHCI device is special there, it would be trivial
to do a separate dma_map_ops for that device, or to extend arm_dma_ops
to read the offset in a per-device variable as we probably have to
do for DT/multiplatform as well.

> We will try to look at "dma-ranges" to see if it can address my case.
> Thanks for the pointer

Ok.

	Arnd
