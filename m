From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 06 Mar 2012 22:36:07 +0000
Subject: [PATCH 8/9] dmaengine: fix cookie handling in iop-adma.c and
 ppc4xx/adma.c
In-Reply-To: <20120306223321.GD15201@n2100.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
Message-ID: <E1S52zH-0002N9-GU@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dan Williams said:
> > Russell King wrote:
> > Firstly, we have DMA_MIN_COOKIE which has value 1 - so any cookies below
> > that aren't valid. ?That seems sane.
> >
> > We seem to have different behaviours:
> >
> > - ? ? ? cookie = c->cookie;
> > - ? ? ? cookie++;
> > - ? ? ? if (cookie < 0)
> > - ? ? ? ? ? ? ? cookie = 1;
> > - ? ? ? c->cookie = cookie;
> > - ? ? ? tx->cookie = cookie;
> >
> > c->cookie here is initialized to zero, so the first cookie given out will
> > be 1. ?This is how most DMA engine drivers implement this.
> >
> > Then we have this:
> >
> > ? ? ? ? ? ? ? ?cookie = chan->common.cookie;
> > ? ? ? ? ? ? ? ?cookie++;
> > ? ? ? ? ? ? ? ?if (cookie <= 1)
> > ? ? ? ? ? ? ? ? ? ? ? ?cookie = 2;
> >
> > ? ? ? ? ? ? ? ?/* initialize the completed cookie to be less than
> > ? ? ? ? ? ? ? ? * the most recently used cookie
> > ? ? ? ? ? ? ? ? */
> > ? ? ? ? ? ? ? ?chan->common.completed_cookie = cookie - 1;
> > ? ? ? ? ? ? ? ?chan->common.cookie = sw_desc->async_tx.cookie = cookie;
> >
> > Again, chan->common.cookie starts off at 0. ?The first cookie given out
> > will be 2, and 1 will never be used. ?There are three drivers which
> > implement it this way.
> >
> > Why is there this difference, and can these three be corrected to behave
> > the same way as the first (and therefore the assignment of cookies
> > consolidated?)
>
> Yes, they should be consolidated, and I believe they have drifted only
> because there were no good common helpers and murphy's law took over.

So lets fix this up to use the common dma_cookie_assign() helper.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/iop-adma.c    |   12 ++----------
 drivers/dma/ppc4xx/adma.c |    6 +-----
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index b1e3be08..4370b10 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -1622,16 +1622,12 @@ static void iop_chan_start_null_memcpy(struct iop_adma_chan *iop_chan)
 		iop_desc_set_dest_addr(grp_start, iop_chan, 0);
 		iop_desc_set_memcpy_src_addr(grp_start, 0);
 
-		cookie = iop_chan->common.cookie;
-		cookie++;
-		if (cookie <= 1)
-			cookie = 2;
+		cookie = dma_cookie_assign(&sw_desc->async_tx);
 
 		/* initialize the completed cookie to be less than
 		 * the most recently used cookie
 		 */
 		iop_chan->common.completed_cookie = cookie - 1;
-		iop_chan->common.cookie = sw_desc->async_tx.cookie = cookie;
 
 		/* channel should not be busy */
 		BUG_ON(iop_chan_is_busy(iop_chan));
@@ -1679,16 +1675,12 @@ static void iop_chan_start_null_xor(struct iop_adma_chan *iop_chan)
 		iop_desc_set_xor_src_addr(grp_start, 0, 0);
 		iop_desc_set_xor_src_addr(grp_start, 1, 0);
 
-		cookie = iop_chan->common.cookie;
-		cookie++;
-		if (cookie <= 1)
-			cookie = 2;
+		cookie = dma_cookie_assign(&sw_desc->async_tx);
 
 		/* initialize the completed cookie to be less than
 		 * the most recently used cookie
 		 */
 		iop_chan->common.completed_cookie = cookie - 1;
-		iop_chan->common.cookie = sw_desc->async_tx.cookie = cookie;
 
 		/* channel should not be busy */
 		BUG_ON(iop_chan_is_busy(iop_chan));
diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 86239ea..9752062 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -4022,16 +4022,12 @@ static void ppc440spe_chan_start_null_xor(struct ppc440spe_adma_chan *chan)
 		async_tx_ack(&sw_desc->async_tx);
 		ppc440spe_desc_init_null_xor(group_start);
 
-		cookie = chan->common.cookie;
-		cookie++;
-		if (cookie <= 1)
-			cookie = 2;
+		cookie = dma_cookie_assign(&sw_desc->async_tx);
 
 		/* initialize the completed cookie to be less than
 		 * the most recently used cookie
 		 */
 		chan->common.completed_cookie = cookie - 1;
-		chan->common.cookie = sw_desc->async_tx.cookie = cookie;
 
 		/* channel should not be busy */
 		BUG_ON(ppc440spe_chan_is_busy(chan));
-- 
1.7.4.4
