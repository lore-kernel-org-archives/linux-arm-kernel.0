From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 17 Oct 2016 17:16:02 -0700
Subject: [PATCH] extcon: qcom-spmi-misc: Sync the extcon state on interrupt
Message-ID: <20161018001602.18617-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver was changed after submission to use the new style APIs
like extcon_set_state(). Unfortunately, that only sets the state,
and doesn't notify any consumers that the cable state has
changed. Use extcon_set_state_sync() here instead so that we
notify cable consumers of the state change. This fixes USB
host-device role switching on the db8074 platform.

Fixes: 38085c987f52 ("extcon: Add support for qcom SPMI PMIC USB id detection hardware")
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/extcon/extcon-qcom-spmi-misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-qcom-spmi-misc.c b/drivers/extcon/extcon-qcom-spmi-misc.c
index ca957a5f4291..b8cde096a808 100644
--- a/drivers/extcon/extcon-qcom-spmi-misc.c
+++ b/drivers/extcon/extcon-qcom-spmi-misc.c
@@ -51,7 +51,7 @@ static void qcom_usb_extcon_detect_cable(struct work_struct *work)
 	if (ret)
 		return;
 
-	extcon_set_state(info->edev, EXTCON_USB_HOST, !id);
+	extcon_set_state_sync(info->edev, EXTCON_USB_HOST, !id);
 }
 
 static irqreturn_t qcom_usb_irq_handler(int irq, void *dev_id)
-- 
2.10.0.297.gf6727b0
