From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 01 Jul 2013 19:24:16 +0200
Subject: [PATCH] DMA: Fix Marvell Orion and mv_xor after MEMSET removal
In-Reply-To: <20130701151720.GC19937@titan.lakedaemon.net>
References: <1372690589-2218-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <51D19CD1.3030900@gmail.com> <20130701151720.GC19937@titan.lakedaemon.net>
Message-ID: <6583540.4QCOENPlIG@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, July 01, 2013 11:17:20 AM Jason Cooper wrote:
> On Mon, Jul 01, 2013 at 05:14:25PM +0200, Sebastian Hesselbarth wrote:
> > On 07/01/13 17:04, Jason Cooper wrote:
> > >On Mon, Jul 01, 2013 at 04:56:29PM +0200, Sebastian Hesselbarth wrote:
> > >>Commit 834cbfe966bece50afded79da8e975d255bf0772
> > >>  ("drivers/dma: remove unused support for MEMSET operations")
> > >>removes MEMSET from dmaengine but does not completely removes it from
> > >>Marvell Orion (arch/arm/plat-orion) and XOR (drivers/dma/mv_xor).
> > >>This also fixes some compiler warnings about now obsolete functions by
> > >>removing those.
> > >>
> > >>Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > >>---
> > >>Cc: Jason Cooper <jason@lakedaemon.net>
> > >>Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > >>Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > >>Cc: Andrew Morton <akpm@linux-foundation.org>
> > >>Cc: linux-arm-kernel at lists.infradead.org
> > >>Cc: linux-kernel at vger.kernel.org
> > >>---
> > >>  arch/arm/plat-orion/common.c |    6 ------
> > >>  drivers/dma/mv_xor.c         |   25 +------------------------
> > >>  2 files changed, 1 insertions(+), 30 deletions(-)
> > >
> > >Please take a look at the email from lkml I just forwarded to you.  I
> > >believe this solves your problem, but I don't have time to look closely
> > >atm.
> > 
> > Jason,
> > 
> > I have seen the forwarded patch before. I don't know what version this
> > is based on. Some of the modifications are in next-20130701, some are
> > not. I have stripped the Marvell modifications from the patch you
> > forwarded and fixed all remaining issues.
> > 
> > Also, I will sent a follow-up patch to remove memset references from
> > Marvell SoC dts/dtsi and the binding documentation soon.
> > 
> > I guess, Bartolomiej should pick them up and resend his patch set, or
> > leave Marvell alone and you pick them up.
> 
> If Bartolomiej doesn't take it, please split your changes into two
> patches, one for plat-orion, and one for drivers.

Andrew has already applied incremental patch fixing build problems to his
tree (though it is not yet in linux-next):

	http://www.ozlabs.org/~akpm/mmots/broken-out/drivers-dma-remove-unused-support-for-memset-operations-v3.patch

The rest of changes from Sebastian are contained in another incremental
patch which I've attached to this mail. They can be also folded into
the first patch (which is what Andrew will probably do before sending them
to Linus).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH] DMA: Fix mv_xor after MEMSET removal

Commit 834cbfe ("drivers/dma: remove unused support for MEMSET operations")
removes MEMSET from dmaengine but does not completely removes it from
drivers/dma/mv_xor.

This also fixes some compiler warnings about now obsolete functions by
removing those.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
[bzolnier: splitted off changes from bigger patch]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/dma/mv_xor.c |   23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

Index: b/drivers/dma/mv_xor.c
===================================================================
--- a/drivers/dma/mv_xor.c	2013-07-01 18:53:12.113317468 +0200
+++ b/drivers/dma/mv_xor.c	2013-07-01 18:56:07.273317119 +0200
@@ -89,11 +89,6 @@ static void mv_desc_clear_next_desc(stru
 	hw_desc->phy_next_desc = 0;
 }
 
-static void mv_desc_set_block_fill_val(struct mv_xor_desc_slot *desc, u32 val)
-{
-	desc->value = val;
-}
-
 static void mv_desc_set_dest_addr(struct mv_xor_desc_slot *desc,
 				  dma_addr_t addr)
 {
@@ -128,22 +123,6 @@ static void mv_chan_set_next_descriptor(
 	__raw_writel(next_desc_addr, XOR_NEXT_DESC(chan));
 }
 
-static void mv_chan_set_dest_pointer(struct mv_xor_chan *chan, u32 desc_addr)
-{
-	__raw_writel(desc_addr, XOR_DEST_POINTER(chan));
-}
-
-static void mv_chan_set_block_size(struct mv_xor_chan *chan, u32 block_size)
-{
-	__raw_writel(block_size, XOR_BLOCK_SIZE(chan));
-}
-
-static void mv_chan_set_value(struct mv_xor_chan *chan, u32 value)
-{
-	__raw_writel(value, XOR_INIT_VALUE_LOW(chan));
-	__raw_writel(value, XOR_INIT_VALUE_HIGH(chan));
-}
-
 static void mv_chan_unmask_interrupts(struct mv_xor_chan *chan)
 {
 	u32 val = __raw_readl(XOR_INTR_MASK(chan));
@@ -1134,7 +1113,7 @@ mv_xor_channel_add(struct mv_xor_device
 			goto err_free_irq;
 	}
 
-	dev_info(&pdev->dev, "Marvell XOR: ( %s%s%s%s)\n",
+	dev_info(&pdev->dev, "Marvell XOR: ( %s%s%s)\n",
 		 dma_has_cap(DMA_XOR, dma_dev->cap_mask) ? "xor " : "",
 		 dma_has_cap(DMA_MEMCPY, dma_dev->cap_mask) ? "cpy " : "",
 		 dma_has_cap(DMA_INTERRUPT, dma_dev->cap_mask) ? "intr " : "");
