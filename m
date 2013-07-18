From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 18 Jul 2013 13:57:33 +0200
Subject: [PATCH] reset: allow drivers to request probe deferral
Message-ID: <1374148653-14009-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the requested reset controller is not yet available, have reset_control_get
and device_reset return -EPROBE_DEFER so the driver can decide to request
probe deferral.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index d1b6089..b3d99a1 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -167,7 +167,7 @@ struct reset_control *reset_control_get(struct device *dev, const char *id)
 
 	if (!rcdev) {
 		mutex_unlock(&reset_controller_list_mutex);
-		return ERR_PTR(-ENODEV);
+		return ERR_PTR(-EPROBE_DEFER);
 	}
 
 	rstc_id = rcdev->of_xlate(rcdev, &args);
-- 
1.8.3.2
