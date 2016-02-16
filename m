From: wuninsu@gmail.com (Insu Yun)
Date: Mon, 15 Feb 2016 21:46:37 -0500
Subject: [PATCH] s5p_mfc: handling failed allocation for workqueue
Message-ID: <1455590797-8522-1-git-send-email-wuninsu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

create_singlethread_workqueue() can be failed in memory pressure.

Signed-off-by: Insu Yun <wuninsu@gmail.com>
---
 drivers/media/platform/s5p-mfc/s5p_mfc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index 927ab49..631aea814 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -1239,6 +1239,10 @@ static int s5p_mfc_probe(struct platform_device *pdev)
 
 	dev->hw_lock = 0;
 	dev->watchdog_workqueue = create_singlethread_workqueue(S5P_MFC_NAME);
+	if (!dev->watchdog_workqueue) {
+		ret = -ENOMEM;
+		goto err_enc_reg;
+	}
 	INIT_WORK(&dev->watchdog_work, s5p_mfc_watchdog_worker);
 	atomic_set(&dev->watchdog_cnt, 0);
 	init_timer(&dev->watchdog_timer);
-- 
1.9.1
