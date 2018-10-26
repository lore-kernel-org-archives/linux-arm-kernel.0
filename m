From: nsaenzjulienne@suse.de (Nicolas Saenz Julienne)
Date: Fri, 26 Oct 2018 15:48:09 +0200
Subject: [PATCH RFC 14/18] staging: vchiq_util: get rid of unneeded memory
 barriers
In-Reply-To: <20181026134813.7775-1-nsaenzjulienne@suse.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
Message-ID: <20181026134813.7775-15-nsaenzjulienne@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the memory operations featured in this file modify/access memory
that is only accessed by the CPU. So we can assume that all the memory
barrier handling done by the completion routines is good enough for us.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_util.c          | 32 -------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
index 44b954daa74a..4b8554bc647e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
@@ -84,20 +84,7 @@ void vchiu_queue_push(VCHIU_QUEUE_T *queue, VCHIQ_HEADER_T *header)
 			flush_signals(current);
 	}
 
-	/*
-	 * Write to queue->storage must be visible after read from
-	 * queue->read
-	 */
-	smp_mb();
-
 	queue->storage[queue->write & (queue->size - 1)] = header;
-
-	/*
-	 * Write to queue->storage must be visible before write to
-	 * queue->write
-	 */
-	smp_wmb();
-
 	queue->write++;
 
 	complete(&queue->push);
@@ -112,12 +99,6 @@ VCHIQ_HEADER_T *vchiu_queue_peek(VCHIU_QUEUE_T *queue)
 
 	complete(&queue->push); // We haven't removed anything from the queue.
 
-	/*
-	 * Read from queue->storage must be visible after read from
-	 * queue->write
-	 */
-	smp_rmb();
-
 	return queue->storage[queue->read & (queue->size - 1)];
 }
 
@@ -130,20 +111,7 @@ VCHIQ_HEADER_T *vchiu_queue_pop(VCHIU_QUEUE_T *queue)
 			flush_signals(current);
 	}
 
-	/*
-	 * Read from queue->storage must be visible after read from
-	 * queue->write
-	 */
-	smp_rmb();
-
 	header = queue->storage[queue->read & (queue->size - 1)];
-
-	/*
-	 * Read from queue->storage must be visible before write to
-	 * queue->read
-	 */
-	smp_mb();
-
 	queue->read++;
 
 	complete(&queue->pop);
-- 
2.19.1
