From: tom.leiming@gmail.com (Ming Lei)
Date: Sun, 27 Oct 2013 19:51:15 +0800
Subject: ARM/kirkwood: v3.12-rc6: kernel BUG at mm/util.c:390!
In-Reply-To: <20131026143617.GA14034@mudshark.cambridge.arm.com>
References: <20131024200730.GB17447@blackmetal.musicnaut.iki.fi>
 <20131026143617.GA14034@mudshark.cambridge.arm.com>
Message-ID: <20131027195115.208f40f3@tom-ThinkPad-T410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 26 Oct 2013 15:36:17 +0100
Will Deacon <will.deacon@arm.com> wrote:

> On Thu, Oct 24, 2013 at 09:07:30PM +0100, Aaro Koskinen wrote:
> 
> > [   36.477203] Backtrace:
> > [   36.535603] [<c009237c>] (page_mapping+0x0/0x50) from [<c0010dd8>] (flush_kernel_dcache_page+0x14/0x98)
> > [   36.661070] [<c0010dc4>] (flush_kernel_dcache_page+0x0/0x98) from [<c0172b60>] (sg_miter_stop+0xc8/0x10c)
> > [   36.792813]  r4:df8a9a64 r3:00000003
> > [   36.857524] [<c0172a98>] (sg_miter_stop+0x0/0x10c) from [<c0172f20>] (sg_miter_next+0x14/0x13c)
> 
> ... assumedly for scatter/gather DMA. How is your block driver allocating
> its buffers? If you're using the DMA API, I can't see how this would happen.

Lots of SCSI commands(inquiry, ...) pass kmalloc buffer to block layer,
then the sg buffer copy helpers and flush_kernel_dcache_page() may see
slab page.

That has been here from commit b1adaf65ba03( [SCSI] block: add sg buffer copy
helper functions).

So how about letting below patch to workaround the issue?

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index a685c8a..eea8806 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -577,7 +577,7 @@ void sg_miter_stop(struct sg_mapping_iter *miter)
 		miter->__offset += miter->consumed;
 		miter->__remaining -= miter->consumed;
 
-		if (miter->__flags & SG_MITER_TO_SG)
+		if ((miter->__flags & SG_MITER_TO_SG) && !PageSlab(page))
 			flush_kernel_dcache_page(miter->page);
 
 		if (miter->__flags & SG_MITER_ATOMIC) {



Thanks,
-- 
Ming Lei
