From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 16 Mar 2015 11:52:44 +0000
Subject: [PATCH 2/3] dmaengine: pl330: make unexported functions static
In-Reply-To: <1426506765-10085-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1426506765-10085-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1426506765-10085-3-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whilst running sparse on pl330 driver it was noticed there are
two functions that are not static but not exported to any other
users in the kernel.

Fix the following warnings by making 'pl330_pause' and the
'pl330_get_current_xferred_count' static:

pl330.c:2165:5: warning: symbol 'pl330_pause' was not declared. Should it be static?
pl330.c:2206:5: warning: symbol 'pl330_get_current_xferred_count' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
Vinod Koul <vinod.koul@intel.com>
Dan Williams <dan.j.williams@intel.com>
DMA List <dmaengine@vger.kernel.org>
Maxime Ripard <maxime.ripard@free-electrons.com>
Jassi Brar <jassisinghbrar@gmail.com>
Liviu Dudau <Liviu.Dudau@arm.com>
Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
---
 drivers/dma/pl330.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index f76c94c..d6f677e 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2162,7 +2162,7 @@ static int pl330_terminate_all(struct dma_chan *chan)
  * DMA transfer again. This pause feature was implemented to
  * allow safely read residue before channel termination.
  */
-int pl330_pause(struct dma_chan *chan)
+static int pl330_pause(struct dma_chan *chan)
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
 	struct pl330_dmac *pl330 = pch->dmac;
@@ -2203,8 +2203,8 @@ static void pl330_free_chan_resources(struct dma_chan *chan)
 	pm_runtime_put_autosuspend(pch->dmac->ddma.dev);
 }
 
-int pl330_get_current_xferred_count(struct dma_pl330_chan *pch,
-		struct dma_pl330_desc *desc)
+static int pl330_get_current_xferred_count(struct dma_pl330_chan *pch,
+					   struct dma_pl330_desc *desc)
 {
 	struct pl330_thread *thrd = pch->thread;
 	struct pl330_dmac *pl330 = pch->dmac;
-- 
2.1.4
