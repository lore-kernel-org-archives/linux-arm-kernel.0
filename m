From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 31 Aug 2009 08:40:47 -0700
Subject: [PATCH v2 2/4] iop-adma: fix lockdep false positive
In-Reply-To: <20090831153946.1068.86702.stgit@dwillia2-linux.ch.intel.com>
References: <20090831153946.1068.86702.stgit@dwillia2-linux.ch.intel.com>
Message-ID: <20090831154047.1068.35013.stgit@dwillia2-linux.ch.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

lockdep correctly identifies a potential recursive locking case for
iop_chan->lock, but in the dependency submission case we expect that the same
class will be acquired for both the parent dependency and the child channel.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dma/iop-adma.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index ce45f3f..9c752bd 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -288,7 +288,12 @@ static void iop_adma_tasklet(unsigned long data)
 {
 	struct iop_adma_chan *iop_chan = (struct iop_adma_chan *) data;
 
-	spin_lock(&iop_chan->lock);
+	/* lockdep will flag depedency submissions as potentially
+	 * recursive locking, this is not the case as a dependency
+	 * submission will never recurse a channels submit routine.
+	 * There are checks in async_tx.c to prevent this.
+	 */
+	spin_lock_nested(&iop_chan->lock, SINGLE_DEPTH_NESTING);
 	__iop_adma_slot_cleanup(iop_chan);
 	spin_unlock(&iop_chan->lock);
 }
