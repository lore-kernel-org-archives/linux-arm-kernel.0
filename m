From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 27 Mar 2015 13:35:50 +0200
Subject: [PATCH 0/5] dmaengine: Fix memory leak amongs virt-dma users
Message-ID: <1427456155-28990-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Due to the implementation of some of the drivers using virt-dma they leak memory
by design.
All it takes is to stop a transfer which is not yet completed, this includes
cyclic (audio) channels also.
These drivers tend to remove the vdesc->node from the virt-dma lists when they
start the transfer. In terminate all vchan_get_all_descriptors() will not find
the transfer which is still running (not in any of the lists) so the free_desc
callback will not be called on them leaving us with memory leak.

There are other drivers leaking memory IMHO, but I was not sure how to fix them:
sun6i-dma,
sa11x0-dma,
k3dma

Others are already doing something to prevent the leak by either directly
freeing the desc or by adding back the vdesc->node to a list.

Regards,
Peter
---
Peter Ujfalusi (4):
  dmaengine: omap-dma: Fix memory leak when terminating running transfer
  dmaengine: bcm2835-dma: Fix memory leak when stopping a running
    transfer
  dmaengine: hsu: Fix memory leak when stopping a running transfer
  dmaengine: moxart-dma: Fix memory leak when stopping a running
    transfer

Petr Kulhavy (1):
  dmaengine: edma: fix memory leak when terminating running transfers

 drivers/dma/bcm2835-dma.c | 1 +
 drivers/dma/edma.c        | 7 +++++++
 drivers/dma/hsu/hsu.c     | 5 ++++-
 drivers/dma/moxart-dma.c  | 4 +++-
 drivers/dma/omap-dma.c    | 1 +
 5 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.3.3
