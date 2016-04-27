From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 27 Apr 2016 08:56:50 +0530
Subject: [PATCH] dmaengine: pl330: Fix race in pl330_get_desc()
In-Reply-To: <bc03a8073460ebac253b80466d11654ee81f540e.1461687536.git.robin.murphy@arm.com>
References: <bc03a8073460ebac253b80466d11654ee81f540e.1461687536.git.robin.murphy@arm.com>
Message-ID: <CABb+yY3JG=XyJekz==VYF+w7ptDBwgMyVJMHzO-uM_ynXKOcaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2016 at 10:00 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> The current logic in pl330_get_desc() contains a clear race condition,
> whereby if the descriptor pool is empty, we will create a new
> descriptor, add it to the pool with the lock held, *release the lock*,
> then try to remove it from the pool again.
>
> Furthermore, if that second attempt then finds the pool empty because
> someone else got there first, we conclude that something must have gone
> terribly wrong and it's the absolute end of the world.
>
We may retry or simply increase the number of descriptors allocated in
a batch from 1 to, say, NR_DEFAULT_DESC.

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 372b435..7179a4d 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2449,7 +2449,7 @@ static struct dma_pl330_desc
*pl330_get_desc(struct dma_pl330_chan *pch)

        /* If the DMAC pool is empty, alloc new */
        if (!desc) {
-               if (!add_desc(pl330, GFP_ATOMIC, 1))
+               if (!add_desc(pl330, GFP_ATOMIC, NR_DEFAULT_DESC))
                        return NULL;

                /* Try again */

> ...
> [  709.328891] dma-pl330 7ff00000.dma: pl330_get_desc:2459 ALERT!
> ** 10 printk messages dropped ** [  709.352280] dma-pl330 7ff00000.dma: __pl330_prep_dma_memcpy:2493 Unable to fetch desc
> ** 11 printk messages dropped ** [  709.372930] dma-pl330 7ff00000.dma: pl330_get_desc:2459 ALERT!
> ** 2 printk messages dropped ** [  709.372953] dma-pl330 7ff00000.dma: pl330_get_desc:2459 ALERT!
> ** 8 printk messages dropped ** [  709.374157] dma-pl330 7ff00000.dma: __pl330_prep_dma_memcpy:2493 Unable to fetch desc
> ** 41 printk messages dropped ** [  709.393095] dmatest: dma0chan4-copy1: result #4545: 'prep error' with src_off=0x3a32 dst_off=0x46dd len=0xc5c3 (0)
> ...
>
> Down with this sort of thing! The most sensible thing to do is avoid the
> allocate-add-remove dance entirely and simply use the freshly-allocated
> descriptor straight away.
>
... but you still try to first pluck from the list.
Instead of churning the code, I would suggest either check in a loop
that we have a desc OR allocate 2 or NR_DEFAULT_DESC descriptors
there. Probably we get more descriptors at the same cost of memory.

>
> I'm also seeing what looks like another occasional race under the same
> conditions where pl330_tx_submit() blows up from dma_cookie_assign()
> dereferencing a bogus tx->chan, but I think that's beyond my ability to
> figure out right now. Similarly the storm of WARNs from pl330_issue_pending()
> when using a large number of small buffers and dmatest.noverify=1. This
> one was some obvious low-hanging fruit.
>
Sorry, that part of code has changed a lot since I wrote the driver,
so more details will help me.

Thanks.
