From: hch@lst.de (Christoph Hellwig)
Date: Wed, 14 Nov 2018 17:12:39 +0100
Subject: [PATCH 06/10] swiotlb: use swiotlb_map_page in
 swiotlb_map_sg_attrs
In-Reply-To: <20181114141311.GA26677@lst.de>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-7-hch@lst.de>
 <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com>
 <20181109074955.GA27489@lst.de>
 <CALAqxLVSDkv4faF3ta_ue9AA9s8B=-8cAMxC_sow+wZYtrfxeQ@mail.gmail.com>
 <20181114141311.GA26677@lst.de>
Message-ID: <20181114161239.GA29462@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2018 at 03:13:11PM +0100, Christoph Hellwig wrote:
> Does the patch below make a difference for you?  Assigning an
> address to the S/G list is the only functional difference I could
> spot.  Drivers really should never look at the S/G list on an
> error return, but..

And that was obviously just the second half of the patch, so here
is the full one:

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 5731daa09a32..a896f46d0c31 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -786,10 +786,13 @@ swiotlb_map_sg_attrs(struct device *dev, struct scatterlist *sgl, int nelems,
 	int i;
 
 	for_each_sg(sgl, sg, nelems, i) {
-		sg->dma_address = swiotlb_map_page(dev, sg_page(sg), sg->offset,
+		dma_addr_t dma_addr;
+
+		dma_addr = swiotlb_map_page(dev, sg_page(sg), sg->offset,
 				sg->length, dir, attrs);
-		if (sg->dma_address == DIRECT_MAPPING_ERROR)
+		if (dma_addr == DIRECT_MAPPING_ERROR)
 			goto out_error;
+		sg->dma_address = dma_addr;
 		sg_dma_len(sg) = sg->length;
 	}
 
