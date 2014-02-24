From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Feb 2014 12:00:21 +0100
Subject: DMABOUNCE in pci-rcar
Message-ID: <201402241200.21944.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

I noticed during randconfig testing that you enabled DMABOUNCE for the
pci-rcar-gen2 driver as posted in this patch https://lkml.org/lkml/2014/2/5/30

I didn't see the original post unfortunately, but I fear we have to
revert it and come up with a better solution, as your approach seems
wrong on a number of levels:

* We really don't want any new users of DMABOUNCE on ARM but instead leave
  it to the PXA/IXP/SA1100 based platforms using it today.

* If your SoCs have an IOMMU, you should really use it, as that would
  give you much better performance than bounce buffers anyway

* If the hardware is so screwed up that you have to use bounce buffers,
  use the SWIOTLB code that is reasonably modern.

* The window base and size in the driver should not be hardcoded, as
  this is likely not a device specific property but rather an artifact of
  how it's connected. Use the standard "dma-ranges" property.

* You should not need your own dma_map_ops in the driver. What you
  do there isn't really specific to your host but should live in some
  place where it can be shared with other drivers.

* The implementation of the dma_map_ops is wrong: at the very least,
  you cannot use the dma_mask of the pci host when translating
  calls from the device, since each pci device can have a different
  dma mask that is set by the driver if it needs larger or smaller
  than 32-bit DMA space.

* The block bounce code can't be enabled if CONFIG_BLOCK is disabled,
  this is how I noticed your changes.

* The block layer assumes that it will bounce any highmem pages,
  but that isn't necessarily what you want here: if you have 2GB
  of lowmem space (CONFIG_VMSPLIT_2G) or more, you will also have
  lowmem pages that need bouncing.

* (completely unrelated, I noticed you set up a bogus I/O space
  window. Don't do that, you will get get a panic if a device happens
  to use it. Not providing an resource should work fine though)

On the bright side, your other changes in the same series all look
good. Thanks especially for sorting out the probe() function, I was
already wondering if we could change that the way you did.

	Arnd
