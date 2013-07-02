From: coelho@ti.com (Luciano Coelho)
Date: Tue, 2 Jul 2013 17:55:44 +0300
Subject: [PATCH v2 5/9] wlcore: always use one-shot IRQ
In-Reply-To: <1372776948-24840-1-git-send-email-coelho@ti.com>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
Message-ID: <1372776948-24840-6-git-send-email-coelho@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we are now using threaded IRQs without the primary handler, we
need to set IRQF_ONESHOT, otherwise our request will fail.

Signed-off-by: Luciano Coelho <coelho@ti.com>
---
 drivers/net/wireless/ti/wlcore/main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index d306cd5..bc1cff3 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -5927,7 +5927,8 @@ static void wlcore_nvs_cb(const struct firmware *fw, void *context)
 
 	wl->irq = platform_get_irq(pdev, 0);
 	wl->if_ops = pdev_data->if_ops;
-	wl->irq_flags = pdata->irq_flags;
+	/* Since we don't use the primary handler, we must set ONESHOT */
+	wl->irq_flags = pdata->irq_flags | IRQF_ONESHOT;
 
 	ret = request_threaded_irq(wl->irq, NULL, wlcore_irq,
 				   wl->irq_flags, pdev->name, wl);
-- 
1.7.10.4
