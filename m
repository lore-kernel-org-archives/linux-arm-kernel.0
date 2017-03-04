From: singhalsimran0@gmail.com (simran singhal)
Date: Sat,  4 Mar 2017 22:16:55 +0530
Subject: [PATCH 3/3] staging: vc04_services: Clean up tests if NULL returned
 on failure
In-Reply-To: <1488646015-7059-1-git-send-email-singhalsimran0@gmail.com>
References: <1488646015-7059-1-git-send-email-singhalsimran0@gmail.com>
Message-ID: <1488646015-7059-4-git-send-email-singhalsimran0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some functions like kmalloc/kzalloc return NULL on failure.
When NULL represents failure, !x is commonly used.

This was done using Coccinelle:
@@
expression *e;
identifier l1;
@@

e = \(kmalloc\|kzalloc\|kcalloc\|devm_kzalloc\)(...);
...
- e == NULL
+ !e

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
index e0ba0ed..7fa0310 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
@@ -52,7 +52,7 @@ int vchiu_queue_init(VCHIU_QUEUE_T *queue, int size)
 	sema_init(&queue->push, 0);
 
 	queue->storage = kzalloc(size * sizeof(VCHIQ_HEADER_T *), GFP_KERNEL);
-	if (queue->storage == NULL) {
+	if (!queue->storage) {
 		vchiu_queue_delete(queue);
 		return 0;
 	}
-- 
2.7.4
