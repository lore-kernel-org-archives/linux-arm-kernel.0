From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 11 Apr 2016 20:31:03 +0800
Subject: [PATCH] scatterlist: use sg_dma_len() in sg_set_page()
In-Reply-To: <570B7CE8.3020307@arm.com>
References: <1460342864-27891-1-git-send-email-shawnguo@kernel.org>
 <570B7CE8.3020307@arm.com>
Message-ID: <20160411123103.GC13735@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 11:31:04AM +0100, Robin Murphy wrote:
> Hi Shawn,
> 
> On 11/04/16 03:47, Shawn Guo wrote:
> >The macro sg_dma_len(sg) is commonly used to retrieve length of sg,
> >which could be 'dma_length' or 'length' field, depending on whether
> >NEED_SG_DMA_LENGTH is enabled or not.  On the other hand, many driver
> >code use helper function sg_set_page() to set an sg entry pointing at
> >a page, with offset and length set up in one call.  But sg_set_page()
> >does not consider NEED_SG_DMA_LENGTH case and only set up 'length'
> >field.  This causes problem on platforms like ARM64, where
> >NEED_SG_DMA_LENGTH is enabled by default, i.e. sg_set_page() sets up
> >'length' while sg_dma_len(sg) returns 'dma_length' field.
> >
> >The patch changes sg_set_page() to use sg_dma_len() for sg length setup
> >as well, so that NEED_SG_DMA_LENGTH case can be handled.
> >
> >Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> >---
> >  include/linux/scatterlist.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> >index 556ec1ea2574..b0e32ea594c3 100644
> >--- a/include/linux/scatterlist.h
> >+++ b/include/linux/scatterlist.h
> >@@ -114,7 +114,7 @@ static inline void sg_set_page(struct scatterlist *sg, struct page *page,
> >  {
> >  	sg_assign_page(sg, page);
> >  	sg->offset = offset;
> >-	sg->length = len;
> >+	sg_dma_len(sg) = len;
> 
> This looks wrong. If a driver is building a scatterlist, then it
> needs to fill in the page, offset and length fields to describe the
> physical layout - leaving sg->length uninitialised would be a recipe
> for disaster - then pass it to the DMA API. Only the DMA API
> implementation should be setting dma_addr and dma_len, and they may
> not correspond to the physical layout at all (e.g. an IOMMU could
> concatenate the entire list into a single much longer segment at
> whatever arbitrary DMA address it chooses).

Thanks for the hint, Robin.  Yes, you're right, the proposed change is
just wrong.  I just found the correct fix to my problem, i.e. commit
70bc916b2c80 (staging: android: ion: Set the length of the DMA sg entries
in buffer).  It should be applied for stable kernel, IMO.

Shawn
