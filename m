From: j-keerthy@ti.com (Keerthy)
Date: Fri, 28 Jul 2017 13:09:16 +0530
Subject: [PATCH] soc: ti: knav: Add a NULL pointer check for kdev in
 knav_pool_create
Message-ID: <1501227556-21087-1-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

knav_pool_create is an exported function. In the event of a call
before knav_queue_probe, we encounter a NULL pointer dereference
in the following line. Hence return -EPROBE_DEFER to the caller till
the kdev pointer is non-NULL.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 279e7c5..d91626b 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -745,6 +745,9 @@ void *knav_pool_create(const char *name,
 	bool slot_found;
 	int ret;
 
+	if (!kdev)
+		return -EPROBE_DEFER;
+
 	if (!kdev->dev)
 		return ERR_PTR(-ENODEV);
 
-- 
1.9.1
