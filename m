From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Feb 2015 14:41:09 +0000
Subject: [RFCv3 2/2] dma-buf: add helpers for sharing attacher
 constraints with dma-parms
In-Reply-To: <4689826.8DDCrX2ZhK@wuerfel>
References: <1422347154-15258-1-git-send-email-sumit.semwal@linaro.org>
 <20150203074856.GF14009@phenom.ffwll.local>
 <CAF6AEGu0-TgyE4BjiaSWXQCSk31VU7dogq=6xDRUhi79rGgbxg@mail.gmail.com>
 <4689826.8DDCrX2ZhK@wuerfel>
Message-ID: <20150203144109.GR8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 03, 2015 at 03:17:27PM +0100, Arnd Bergmann wrote:
> On Tuesday 03 February 2015 09:04:03 Rob Clark wrote:
> > Since I'm stuck w/ an iommu, instead of built in mmu, my plan was to
> > drop use of dma-mapping entirely (incl the current call to dma_map_sg,
> > which I just need until we can use drm_cflush on arm), and
> > attach/detach iommu domains directly to implement context switches.
> > At that point, dma_addr_t really has no sensible meaning for me.
> 
> I think what you see here is a quite common hardware setup and we really
> lack the right abstraction for it at the moment. Everybody seems to
> work around it with a mix of the dma-mapping API and the iommu API.
> These are doing different things, and even though the dma-mapping API
> can be implemented on top of the iommu API, they are not really compatible.

I'd go as far as saying that the "DMA API on top of IOMMU" is more
intended to be for a system IOMMU for the bus in question, rather
than a device-level IOMMU.

If an IOMMU is part of a device, then the device should handle it
(maybe via an abstraction) and not via the DMA API.  The DMA API should
be handing the bus addresses to the device driver which the device's
IOMMU would need to generate.  (In other words, in this circumstance,
the DMA API shouldn't give you the device internal address.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
