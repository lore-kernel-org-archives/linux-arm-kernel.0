From: simon.kagstrom@netinsight.net (Simon =?UTF-8?B?S8OlZ3N0csO2bQ==?=)
Date: Mon, 17 Mar 2014 10:43:33 +0100
Subject: BUG_ON for DMA-bounce and bidirectional mappings (e100 on IXP4xx)
In-Reply-To: <20140304123714.7e1fe704@marrow.netinsight.se>
References: <20140304112459.354f0980@marrow.netinsight.se>
 <20140304104528.GQ21483@n2100.arm.linux.org.uk>
 <20140304123714.7e1fe704@marrow.netinsight.se>
Message-ID: <20140317104333.31e75981@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again!

On Tue, 4 Mar 2014 12:37:14 +0100
Simon K?gstr?m <simon.kagstrom@netinsight.net> wrote:

> On Tue, 4 Mar 2014 10:45:28 +0000
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Tue, Mar 04, 2014 at 11:24:59AM +0100, Simon K?gstr?m wrote:
> > > We have a IXP4xx-based board which has an e100 NIC. During bootup, we
> > > trigger a BUG_ON in dmabounce.c because the mapped direction doesn't
> > > match the synced one. e100.c maps buffers bidirectional, but the sync
> > > is done fromdevice.
> > [...]
> [...]
> And the dma_debug code explicitly skips the check if the direction is
> DMA_BIDIRECTIONAL:
>
>   static void check_sync(struct device *dev,
> 		       struct dma_debug_entry *ref,
> 		       bool to_cpu)
>   {
> 	[...]
> 	if (entry->direction == DMA_BIDIRECTIONAL)
> 		goto out;
> 
> 	if (ref->direction != entry->direction) {
> 		err_printk(dev, entry, "DMA-API: device driver syncs "
> 				"DMA memory with different direction "
> 				"[device address=0x%016llx] [size=%llu bytes] "
> 				"[mapped with %s] [synced with %s]\n",
> 				(unsigned long long)ref->dev_addr, entry->size,
> 				dir2name[entry->direction],
> 				dir2name[ref->direction]);
> 	}
> 	[...]
>   }
> 
> Krzysztofs patch does the same for dmabounce.c, from the dma-debug code
> it seems to me that it would make sense there as well?

I'd like to bring this issue up again. To me it seems Krzysztofs patch
(pasted below again) would align the ARM dmabounce behaviour with the
DMA API verifier code. Seems to make sense for my part at least.
Comments?

// Simon

--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -375,7 +375,7 @@ static int __dmabounce_sync_for_cpu(struct device *dev, dma_addr_t addr,
 
 	off = addr - buf->safe_dma_addr;
 
-	BUG_ON(buf->direction != dir);
+	BUG_ON(buf->direction != dir && buf->direction != DMA_BIDIRECTIONAL);
 
 	dev_dbg(dev, "%s: unsafe buffer %p (dma=%#x off=%#lx) mapped to %p (dma=%#x)\n",
 		__func__, buf->ptr, virt_to_dma(dev, buf->ptr), off,
@@ -415,7 +415,7 @@ static int __dmabounce_sync_for_device(struct device *dev, dma_addr_t addr,
 
 	off = addr - buf->safe_dma_addr;
 
-	BUG_ON(buf->direction != dir);
+	BUG_ON(buf->direction != dir && buf->direction != DMA_BIDIRECTIONAL);
 
 	dev_dbg(dev, "%s: unsafe buffer %p (dma=%#x off=%#lx) mapped to %p (dma=%#x)\n",
 		__func__, buf->ptr, virt_to_dma(dev, buf->ptr), off,
