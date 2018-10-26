From: nsaenzjulienne@suse.de (Nicolas Saenz Julienne)
Date: Fri, 26 Oct 2018 15:48:07 +0200
Subject: [PATCH RFC 12/18] staging: vchiq_util: use completions instead of
 semaphores
In-Reply-To: <20181026134813.7775-1-nsaenzjulienne@suse.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
Message-ID: <20181026134813.7775-13-nsaenzjulienne@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is preferred in the kernel to avoid using semaphores to wait for
events, as they are optimised for the opposite situation; where the
common case is that they are available and may block only occasionally.
FYI see this thread: https://lkml.org/lkml/2008/4/11/323.

Also completions are semantically more explicit in this case.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_util.c             | 16 ++++++++--------
 .../interface/vchiq_arm/vchiq_util.h             |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
index 2e52f07bbaa9..44b954daa74a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
@@ -48,8 +48,8 @@ int vchiu_queue_init(VCHIU_QUEUE_T *queue, int size)
 	queue->write = 0;
 	queue->initialized = 1;
 
-	sema_init(&queue->pop, 0);
-	sema_init(&queue->push, 0);
+	init_completion(&queue->pop);
+	init_completion(&queue->push);
 
 	queue->storage = kcalloc(size, sizeof(VCHIQ_HEADER_T *), GFP_KERNEL);
 	if (!queue->storage) {
@@ -80,7 +80,7 @@ void vchiu_queue_push(VCHIU_QUEUE_T *queue, VCHIQ_HEADER_T *header)
 		return;
 
 	while (queue->write == queue->read + queue->size) {
-		if (down_interruptible(&queue->pop) != 0)
+		if (wait_for_completion_interruptible(&queue->pop))
 			flush_signals(current);
 	}
 
@@ -100,17 +100,17 @@ void vchiu_queue_push(VCHIU_QUEUE_T *queue, VCHIQ_HEADER_T *header)
 
 	queue->write++;
 
-	up(&queue->push);
+	complete(&queue->push);
 }
 
 VCHIQ_HEADER_T *vchiu_queue_peek(VCHIU_QUEUE_T *queue)
 {
 	while (queue->write == queue->read) {
-		if (down_interruptible(&queue->push) != 0)
+		if (wait_for_completion_interruptible(&queue->push))
 			flush_signals(current);
 	}
 
-	up(&queue->push); // We haven't removed anything from the queue.
+	complete(&queue->push); // We haven't removed anything from the queue.
 
 	/*
 	 * Read from queue->storage must be visible after read from
@@ -126,7 +126,7 @@ VCHIQ_HEADER_T *vchiu_queue_pop(VCHIU_QUEUE_T *queue)
 	VCHIQ_HEADER_T *header;
 
 	while (queue->write == queue->read) {
-		if (down_interruptible(&queue->push) != 0)
+		if (wait_for_completion_interruptible(&queue->push))
 			flush_signals(current);
 	}
 
@@ -146,7 +146,7 @@ VCHIQ_HEADER_T *vchiu_queue_pop(VCHIU_QUEUE_T *queue)
 
 	queue->read++;
 
-	up(&queue->pop);
+	complete(&queue->pop);
 
 	return header;
 }
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.h
index 5a1540d349d3..b226227fe5bc 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.h
@@ -35,7 +35,7 @@
 #define VCHIQ_UTIL_H
 
 #include <linux/types.h>
-#include <linux/semaphore.h>
+#include <linux/completion.h>
 #include <linux/mutex.h>
 #include <linux/bitops.h>
 #include <linux/kthread.h>
@@ -60,8 +60,8 @@ typedef struct {
 	int write;
 	int initialized;
 
-	struct semaphore pop;
-	struct semaphore push;
+	struct completion pop;
+	struct completion push;
 
 	VCHIQ_HEADER_T **storage;
 } VCHIU_QUEUE_T;
-- 
2.19.1
