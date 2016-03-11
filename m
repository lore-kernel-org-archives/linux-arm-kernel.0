From: niklas.soderlund@ragnatech.se (Niklas =?iso-8859-1?Q?S=F6derlund?=)
Date: Fri, 11 Mar 2016 13:58:46 +0100
Subject: [PATCH v5 3/9] dma-mapping: add dma_{map,unmap}_resource
In-Reply-To: <20160311111522.GA3450@infradead.org>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1457404974-1800-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160308073847.GA15520@infradead.org>
 <20160310160522.GB1111@bigcity.dyn.berto.se>
 <CAPcyv4gO4EZnBuVKXT8+gsMhbHJzuK7sfr0uRcjVdJP-nUUz4A@mail.gmail.com>
 <20160311111522.GA3450@infradead.org>
Message-ID: <20160311125846.GF1111@bigcity.dyn.berto.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Thanks for your comments.

On 2016-03-11 03:15:22 -0800, Christoph Hellwig wrote:
> On Thu, Mar 10, 2016 at 10:47:10PM -0800, Dan Williams wrote:
> > I think it is confusing to use the dma_ prefix for this peer-to-peer
> > mmio functionality.  dma_addr_t is a device's view of host memory.
> > Something like bus_addr_t bus_map_resource().  Doesn't this routine
> > also need the source device in addition to the target device?  The
> > resource address is from the perspective of the host cpu, it may be a
> > different address space in the view of two devices relative to each
> > other.
> 
> Is it supposed to be per-mmio?  It's in dma-mapping ops, and has dma
> in the name, so I suspected it's for some form of peer dma.  But given
> that our dma APIs reuqire a struct page backing I have no idea how this
> even supposed to work, and this little documentation blurb still doesn't
> clear that up.
> 
> So for now I'd like to NAK this patch until the use case can be
> explained clearly, and actually works.

I can explain the use case and maybe we can figure out if this approach 
is the correct one to solve it.

The problem is that I have devices behind an IOMMU which I would like to 
use with DMA. Vinod recently moved forward with his and Linus Walleij
patch '[PATCH] dmaengine: use phys_addr_t for slave configuration' which 
clarifies that the DMA slave address provided by a client is the 
physical address. This puts the task of mapping the DMA slave address 
from a phys_addr_t to a dma_addr_t on the DMA engine.

Without an IOMMU this is easy since the phys_addr_t and dma_addr_t are 
the same and no special care is needed. However if you have a IOMMU you 
need to map the DMA slave phys_addr_t to a dma_addr_t using something 
like this. Is it not very similar to dma_map_single() where one maps 
processor virtual memory (instead if MMIO) so that it can be used with 
DMA slaves?

-- 
Regards,
Niklas S?derlund
