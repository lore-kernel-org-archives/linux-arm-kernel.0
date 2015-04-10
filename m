From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Apr 2015 23:53:53 +0200
Subject: [PATCH] Add support for CONFIG_ARM64_DMA_USE_IOMMU.
In-Reply-To: <CAOHikRC4w7N8DFh0WyjzUDuscmwP6xYeSDBF404P4RMYcCip2g@mail.gmail.com>
References: <1422379495-10268-1-git-send-email-stripathi@apm.com>
 <201503220231.40375.arnd@arndb.de>
 <CAOHikRC4w7N8DFh0WyjzUDuscmwP6xYeSDBF404P4RMYcCip2g@mail.gmail.com>
Message-ID: <2336087.ba2dFNn0Gn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 March 2015 21:28:45 Suman Tripathi wrote:
> > My first suggestion would be to separate this from IOMMU support
> > completely
> > as you don't really have an IOMMU. The easiest way to deal with hardware
> > like this is to use swiotlb with a fixed mapping. This is also the only
> > way to deal with any devices that may have multiple outstanding DMAs
> > (PCI, SATA, USB, ...).
> I guess you are talking about the swiotlb force idea ?  That's really
> good but I think we should make configuring  swiotlb force per device
> otherwise it applies to all devices ??

Sorry for the late reply, I was still catching up on email after
my vacation.

The swiotlb is automatically enabled for all devices that have a DMA mask
smaller than the available memory. There is no need to force that at
all. All you have to do is to put devices that have the same limitation
regarding their DMA space on a common device node, and set the dma-ranges
property of the bus node to correctly describe the mapping.

For devices that have a real iommu, or that are on a 64-bit DMA capable
bus, you model that bus correctly in DT and set the dma-ranges to
cover that address space.

The default dma_mask is 32-bit wide, so for devices that have exactly
32-bit (4GB) visibility into physical memory, you don't actually need
to do anything. Only devices that you want to access a larger address
space have to be on a bus node with the larger dma-ranges, and they
need to call dma_set_mask_and_coherent() with the mask that the device
supports itself (which may be more than the bus can handle).

	Arnd
