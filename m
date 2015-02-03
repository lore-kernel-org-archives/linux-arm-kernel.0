From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Feb 2015 15:52:48 +0100
Subject: [RFCv3 2/2] dma-buf: add helpers for sharing attacher constraints
 with dma-parms
In-Reply-To: <20150203144109.GR8656@n2100.arm.linux.org.uk>
References: <1422347154-15258-1-git-send-email-sumit.semwal@linaro.org>
 <4689826.8DDCrX2ZhK@wuerfel> <20150203144109.GR8656@n2100.arm.linux.org.uk>
Message-ID: <4830208.H6zxrGlT1D@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 February 2015 14:41:09 Russell King - ARM Linux wrote:
> On Tue, Feb 03, 2015 at 03:17:27PM +0100, Arnd Bergmann wrote:
> > On Tuesday 03 February 2015 09:04:03 Rob Clark wrote:
> > > Since I'm stuck w/ an iommu, instead of built in mmu, my plan was to
> > > drop use of dma-mapping entirely (incl the current call to dma_map_sg,
> > > which I just need until we can use drm_cflush on arm), and
> > > attach/detach iommu domains directly to implement context switches.
> > > At that point, dma_addr_t really has no sensible meaning for me.
> > 
> > I think what you see here is a quite common hardware setup and we really
> > lack the right abstraction for it at the moment. Everybody seems to
> > work around it with a mix of the dma-mapping API and the iommu API.
> > These are doing different things, and even though the dma-mapping API
> > can be implemented on top of the iommu API, they are not really compatible.
> 
> I'd go as far as saying that the "DMA API on top of IOMMU" is more
> intended to be for a system IOMMU for the bus in question, rather
> than a device-level IOMMU.
> 
> If an IOMMU is part of a device, then the device should handle it
> (maybe via an abstraction) and not via the DMA API.  The DMA API should
> be handing the bus addresses to the device driver which the device's
> IOMMU would need to generate.  (In other words, in this circumstance,
> the DMA API shouldn't give you the device internal address.)

Exactly. And the abstraction that people choose at the moment is the
iommu API, for better or worse. It makes a lot of sense to use this
API if the same iommu is used for other devices as well (which is
the case on Tegra and probably a lot of others). Unfortunately the
iommu API lacks support for cache management, and probably other things
as well, because this was not an issue for the original use case
(device assignment on KVM/x86).

This could be done by adding explicit or implied cache management
to the IOMMU mapping interfaces, or by extending the dma-mapping
interfaces in a way that covers the use case of the device managing
its own address space, in addition to the existing coherent and
streaming interfaces.

	Arnd
