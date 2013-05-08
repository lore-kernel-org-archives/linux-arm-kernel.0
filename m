From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 May 2013 09:24:44 +0200
Subject: [PATCH] USB: set device dma_mask without reference to global data
In-Reply-To: <CAL411-pY_i19otiE2pLux6eR_OFHhfhK=+6BF=H6wABDsGCP6Q@mail.gmail.com>
References: <1367967232-10128-1-git-send-email-swarren@wwwdotorg.org>
 <5189B7BF.8070607@wwwdotorg.org>
 <CAL411-pY_i19otiE2pLux6eR_OFHhfhK=+6BF=H6wABDsGCP6Q@mail.gmail.com>
Message-ID: <201305080924.44622.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 May 2013, Peter Chen wrote:
> >
> > This probably could be initialized from some DT property. However,
> > there's no such property defined right now, and considering that DT is
> > supposed to be an ABI, we'd always need the code in this patch as a
> > fallback for DTs that were created before any such property was defined.
> >
> > Equally, since the data is SoC-specific rather than board-specific, and
> > is even fairly unlikely to vary between SoC versions since these values
> > are all 0xffffffff anyway, I don't really see much point in putting it
> > into DT, rather than just putting the static data into the driver.
> 
> I mean there is already dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> at function of_platform_device_create, why can't add
> dev->dev.dma_mask = &dev->dev.coherent_dma_mask after that?
> 
> If DT core can do above things, can we delete dma_mask assignment
> at every driver?

It probably should. The main thing is that the dma_mask setting in
of_platform (and elsewhere) is a mess and that nobody so far had the
guts to try to get it right for good.

Setting a 32 bit DMA mask is /probably/ the right default on all
ARM systems, but there are caveats:

- Once you get to systems with larger than 32 bit addressing (powerpc64,
  arm64, arm32 with LPAE), it's not so obvious: you may have some devices
  that need a 32 bit mask and some that need a 64 bit mask.

- Some (very rare these days, thankfully) devices require a mask that is
  less than 32 bits. Since that knowledge is device specific, not platform
  specific, it should probably stay in the driver.

- There are cases (I know them only on powerpc, but they probably exist
  on ARM and other places too) where the mapping from bus addresses to
  physical addresses is not linear. There is a device-tree binding for
  a "dma-ranges" property that can accurately describe the specific
  mapping. Actually using this on architecture independent code requires
  not only setting the dma_mask but also supporting the remapping
  in the dma_map_ops.

- Things get more interesting in combination with an IOMMU. If we have
  an IOMMU, I think we should set the dma_mask pointer to the mask of
  the IOMMU and set the map_ops accordingly.

- Whether we actually need coherent_dma_mask these days is another hard
  question to answer. I suspect that the only thing really needing it
  was some version of the Itanium based Altix machine for its PCI
  devices and we'd be better off finding a simpler solution for platform
  devices. For all practical purposes I think coherent_dma_mask must be
  the same as dma_mask.

	Arnd
