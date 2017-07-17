From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 17 Jul 2017 18:36:23 -0400
Subject: [PATCH] nvme: Acknowledge completion queue on each iteration
Message-ID: <1500330983-27501-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code is moving the completion queue doorbell after processing all completed
events and sending callbacks to the block layer on each iteration.

This is causing a performance drop when a lot of jobs are queued towards
the HW. Move the completion queue doorbell on each loop instead and allow new
jobs to be queued by the HW.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/nvme/host/pci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d10d2f2..33d9b5b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -810,13 +810,12 @@ static void nvme_process_cq(struct nvme_queue *nvmeq)
 
 	while (nvme_read_cqe(nvmeq, &cqe)) {
 		nvme_handle_cqe(nvmeq, &cqe);
+		nvme_ring_cq_doorbell(nvmeq);
 		consumed++;
 	}
 
-	if (consumed) {
-		nvme_ring_cq_doorbell(nvmeq);
+	if (consumed)
 		nvmeq->cqe_seen = 1;
-	}
 }
 
 static irqreturn_t nvme_irq(int irq, void *data)
-- 
1.9.1
