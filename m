From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 16 Sep 2016 12:48:23 +0300
Subject: [PATCHv9 0/6] dmaengine: rcar-dmac: add iommu support for slave
 transfers
In-Reply-To: <3152956.IVRykDnfF6@wuerfel>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
 <20160915162650.GZ13920@localhost> <3152956.IVRykDnfF6@wuerfel>
Message-ID: <2210422.ogrYIr1eQU@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Friday 16 Sep 2016 11:07:48 Arnd Bergmann wrote:
> On Thursday, September 15, 2016 9:56:51 PM CEST Vinod Koul wrote:
> > On Wed, Aug 10, 2016 at 11:07:10PM +0530, Vinod Koul wrote:
> >> On Wed, Aug 10, 2016 at 01:22:13PM +0200, Niklas S?derlund wrote:
> >>> Hi,
> >>> 
> >>> This series tries to solve the problem with DMA with device registers
> >>> (MMIO registers) that are behind an IOMMU for the rcar-dmac driver. A
> >>> recent patch '9575632 (dmaengine: make slave address physical)'
> >>> clarifies that DMA slave address provided by clients is the physical
> >>> address. This puts the task of mapping the DMA slave address from a
> >>> phys_addr_t to a dma_addr_t on the DMA engine.
> >>> 
> >>> Without an IOMMU this is easy since the phys_addr_t and dma_addr_t are
> >>> the same and no special care is needed. However if you have a IOMMU
> >>> you need to map the DMA slave phys_addr_t to a dma_addr_t using
> >>> something like this.
> >>> 
> >>> This series is based on top of v4.8-rc1. And I'm hoping to be able to
> >>> collect a Ack from Russell King on patch 4/6 that adds the ARM
> >>> specific part and then be able to take the whole series through the
> >>> dmaengine tree. If this is not the best route I'm more then happy to
> >>> do it another way.
> >>> 
> >>> It's tested on a Koelsch with CONFIG_IPMMU_VMSA and by enabling the
> >>> ipmmu_ds node in r8a7791.dtsi. I verified operation by interacting
> >>> with /dev/mmcblk1, i2c and the serial console which are devices behind
> >>> the iommu.
> >> 
> >> As I said in last one, the dmaengine parts look fine to me. But to go
> >> thru dmaengine tree I would need ACK on non dmaengine patches.
> > 
> > I havent heard back from this one and I am inclined to merge this one now.
> > If anyone has any objects, please speak up now...
> > 
> > Also ACKs welcome...
> 
> I had not looked at the series earlier, but this version looks entirely
> reasonable to me, so
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> 
> One concern I have is that we might get an awkward situation if we ever
> encounter one DMA engine hardware that is used in different systems that all
> have an IOMMU, but on some of them the connection between the DMA master and
> the slave FIFO bypasses the IOMMU while on others the IOMMU is required.

Do you mean systems where some of the channels of a specific DMA engine go 
through the IOMMU while others do not ? We indeed have no solution today for 
such a situation.

The problem is a bit broader than that, we'll also have an issue with DMA 
engines that have different channels served by different IOMMUs. I recall 
discussing this in the past with you, and the solution you proposed was to add 
a channel index to struct dma_attrs seems good to me. To support the case 
where some channels don't go through an IOMMU we would only need support for 
null entries in the IOMMUs list associated with a device (for instance in the 
DT case null entries in the iommus property).

Now I see that struct dma_attrs has been replaced by unsigned long in

commit 00085f1efa387a8ce100e3734920f7639c80caa3
Author: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date:   Wed Aug 3 13:46:00 2016 -0700

    dma-mapping: use unsigned long for dma_attrs

We still have enough bits to reserve some of them for a channel number, but 
I'm not very happy with that patch as I can see how a future proposal to 
handle the channel number through the DMA attributes will get rejected on the 
grounds of bits starvation then :-(

> I don't have any idea for how this could be handled in a generic way, so my
> best answer here is to hope we never get there, and if we do, handle it
> using some local hack in the driver.

-- 
Regards,

Laurent Pinchart
