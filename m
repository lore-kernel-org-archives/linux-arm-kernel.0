From: sunil.kovvuri@gmail.com (Sunil Goutham)
Date: Thu, 10 Dec 2015 13:25:20 +0530
Subject: [PATCH v2 2/2] net: thunderx: Enable CQE count threshold interrupt
In-Reply-To: <y>
References: <y>
Message-ID: <1449734120-8912-3-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

This feature is introduced in pass-2 chip and with this CQ interrupt
coalescing will work based on both timer and count.

Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |    2 +-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
index b11fc09..d0d1b54 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
@@ -299,7 +299,7 @@ static int nicvf_init_cmp_queue(struct nicvf *nic,
 		return err;
 
 	cq->desc = cq->dmem.base;
-	cq->thresh = CMP_QUEUE_CQE_THRESH;
+	cq->thresh = pass1_silicon(nic->pdev) ? 0 : CMP_QUEUE_CQE_THRESH;
 	nic->cq_coalesce_usecs = (CMP_QUEUE_TIMER_THRESH * 0.05) - 1;
 
 	return 0;
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.h b/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
index a4f6667..c5030a7 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.h
@@ -75,7 +75,7 @@
  */
 #define CMP_QSIZE		CMP_QUEUE_SIZE2
 #define CMP_QUEUE_LEN		(1ULL << (CMP_QSIZE + 10))
-#define CMP_QUEUE_CQE_THRESH	0
+#define CMP_QUEUE_CQE_THRESH	(NAPI_POLL_WEIGHT / 2)
 #define CMP_QUEUE_TIMER_THRESH	80 /* ~2usec */
 
 #define RBDR_SIZE		RBDR_SIZE0
-- 
1.7.1
