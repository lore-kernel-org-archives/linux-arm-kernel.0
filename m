From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Dec 2015 14:38:39 +0100
Subject: [RFC v02 00/15] dmaengine: New 'universal' API for requesting
 channel
In-Reply-To: <565ECD3F.3070500@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <103520159.g0xhtFsXUi@wuerfel> <565ECD3F.3070500@ti.com>
Message-ID: <15116008.0PghG2Imaa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 December 2015 12:51:43 Peter Ujfalusi wrote:
> On 12/01/2015 04:24 PM, Arnd Bergmann wrote:
> > On Tuesday 01 December 2015 15:45:32 Peter Ujfalusi wrote:
> >>>> static struct dma_filter_map da830_edma_map[] = {
> >>>>         DMA_FILTER_ENTRY("davinci-mcasp.0", "rx", EDMA_CTLR_CHAN(0, 0)),
> >>>>         DMA_FILTER_ENTRY("davinci-mcasp.0", "tx", EDMA_CTLR_CHAN(0, 1)),
> >>>>         DMA_FILTER_ENTRY("davinci-mcasp.1", "rx", EDMA_CTLR_CHAN(0, 2)),
> >>>>         DMA_FILTER_ENTRY("davinci-mcasp.1", "tx", EDMA_CTLR_CHAN(0, 3)),
> >>>>         DMA_FILTER_ENTRY("davinci-mcasp.2", "rx", EDMA_CTLR_CHAN(0, 4)),
> >>>>         DMA_FILTER_ENTRY("davinci-mcasp.2", "tx", EDMA_CTLR_CHAN(0, 5)),
> >>>>         DMA_FILTER_ENTRY("spi_davinci.0", "rx", EDMA_CTLR_CHAN(0, 14)),
> >>>>         DMA_FILTER_ENTRY("spi_davinci.0", "tx", EDMA_CTLR_CHAN(0, 15)),
> >>>>         DMA_FILTER_ENTRY("da830-mmc.0", "rx", EDMA_CTLR_CHAN(0, 16)),
> >>>>         DMA_FILTER_ENTRY("da830-mmc.0", "tx", EDMA_CTLR_CHAN(0, 17)),
> >>>>         DMA_FILTER_ENTRY("spi_davinci.1", "rx", EDMA_CTLR_CHAN(0, 18)),
> >>>>         DMA_FILTER_ENTRY("spi_davinci.1", "tx", EDMA_CTLR_CHAN(0, 19)),
> >>>
> >>> Does this ".2" and so prevent driver to use auto ID for platform devices?
> >>
> >> Yes, as all the infra around the traditional board files with platform_device
> >> creation does. Ideally we could have 'phandle' pointing from this table to the
> >> device in question (or other way around), but I'm not aware of anything we can
> >> use.
> > 
> > I was thinking that we could use a pointer to the device structure, but
> > if you have that, you can also just read the name from it.
> 
> Hrm to have pdev pointer instead of the devname string? In the core we could
> get the pdev from the caller's device with to_platform_device(dev) and simply
> compare the pointers...
> 
> One of the issue I see (in mach-davinci and mach-omap1/2) is that the pdevs
> are scattered around in the c files so gathering the pointers to a place where
> we can see them to be able to use it in the dma_filter_map is not going to be
> light weight task.
> Furthermore we have the omap_hwmod for OMAP2+ which creates the actual pdevs
> and resources from the omap_hwmod data structures so getting out the DMA event
> numbers there is not going to be easy either...
> 
> I'll hold back the RFC v3 to see if we should switch to pdev pointer or stay
> with the devname strings here.

Sorry, what I meant to say above is that I had already concluded that using
device pointers was a bad idea and we should stay with names.

	Arnd
