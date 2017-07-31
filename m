From: j-keerthy@ti.com (Keerthy)
Date: Mon, 31 Jul 2017 10:01:36 +0530
Subject: [PATCH v2] soc: ti: knav: Add a NULL pointer check for kdev in
 knav_pool_create
Message-ID: <1501475496-10267-1-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

knav_pool_create is an exported function. In the event of a call
before knav_queue_probe, we encounter a NULL pointer dereference
in the following line. Hence return -EPROBE_DEFER to the caller till
the kdev pointer is non-NULL.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * Fixed returning an int to returning pointer.

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
+		return ERR_PTR(-EPROBE_DEFER);
+
 	if (!kdev->dev)
 		return ERR_PTR(-ENODEV);
 
-- 
1.9.1
