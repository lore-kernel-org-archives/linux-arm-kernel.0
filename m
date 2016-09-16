From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 16 Sep 2016 16:01:27 +0300
Subject: [PATCHv9 0/6] dmaengine: rcar-dmac: add iommu support for slave
 transfers
In-Reply-To: <cea119f1-18d5-675d-ee33-c22b0c8e7693@arm.com>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
 <1757972.L4qX7sAfEW@avalon> <cea119f1-18d5-675d-ee33-c22b0c8e7693@arm.com>
Message-ID: <37825584.xpDRDpS72S@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Friday 16 Sep 2016 13:49:21 Robin Murphy wrote:
> On 16/09/16 13:05, Laurent Pinchart wrote:
> [...]
> 
> >>>> One concern I have is that we might get an awkward situation if we ever
> >>>> encounter one DMA engine hardware that is used in different systems
> >>>> that all have an IOMMU, but on some of them the connection between the
> >>>> DMA master and the slave FIFO bypasses the IOMMU while on others the
> >>>> IOMMU is required.
> >>> 
> >>> Do you mean systems where some of the channels of a specific DMA engine
> >>> go through the IOMMU while others do not ? We indeed have no solution
> >>> today for such a situation.
> >>> 
> >>> The problem is a bit broader than that, we'll also have an issue with
> >>> DMA engines that have different channels served by different IOMMUs. I
> >>> recall discussing this in the past with you, and the solution you
> >>> proposed was to add a channel index to struct dma_attrs seems good to
> >>> me. To support the case where some channels don't go through an IOMMU we
> >>> would only need support for null entries in the IOMMUs list associated
> >>> with a device (for instance in the DT case null entries in the iommus
> >>> property).
> >> 
> >> I think at that point we just create the channels as child devices of
> >> the main dmaengine device so they each get their own DMA ops, and can do
> >> whatever. The Qualcomm HIDMA driver already does that for a very similar
> >> reason (so that the IOMMU can map individual channels into different
> >> guest VMs).
> > 
> > That's another option, but it seems more like a workaround to me, instead
> > of a proper solution to fix the more global problem of multiple memory
> > paths within a single device. I have other hardware devices that can act
> > as bus masters through different paths (for instance a display-related
> > device that fetches data and commands through different paths). Luckily
> > so far all those paths are served by the same IOMMU, but there's no
> > guarantee this will remain true in the future. Furthermore, even today,
> > the IOMMU connected to that device has the ability to selectively enable
> > and disable its ports. I have to keep them all enabled due to the lack of
> > channel information in the DMA mapping and IOMMU APIs, leading to
> > increased power consumption.
> 
> Indeed, I think both the Exynos and Rockchip IOMMU drivers already do
> cater for a device mastering though multiple discrete IOMMUs, not being
> the fancy multi-port multi-context ones like yours and mine.
> 
> I guess what we could really do with is a decent abstraction of
> multi-master peripherals at the device level; a "threads within the same
> process" sort of granularity, as it were. I'd envisage it more along the
> lines of how we handle NUMA, i.e. dma_map_page_attrs(...) becomes a
> wrapper for dma_map_page_attrs_multi(..., CHANNEL_ALL), and trickier
> users can call the latter with the a more specific channel(s) argument
> (maybe it's a bitmask rather than an index).

That's pretty much what I've discussed with Arnd in the past, except that we 
were planning to add the channel to struct dma_attrs. Hence my disappointment 
seeing the structure go away.

> Meanwhile, dev->archdata.dma_ops may point to a device-specific array of
> dma_map_ops, which the DMA API backend iterates over if necessary.
> 
> Strangely, that doesn't actually sound too horrible.

-- 
Regards,

Laurent Pinchart
