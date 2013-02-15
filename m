From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Feb 2013 12:44:59 +0000
Subject: [PATCH 29/40] ab8500-charger: Run detect workaround only on AB8500
In-Reply-To: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
References: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1360932310-30065-30-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@stericsson.com>

Only AB8500 has this hardware bug, so these works only need to be run
there.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Marcus COOPER <marcus.xm.cooper@stericsson.com>
Reviewed-by: Martin SJOBLOM <martin.w.sjoblom@stericsson.com>
Reviewed-by: Jonas ABERG <jonas.aberg@stericsson.com>
---
 drivers/power/ab8500_charger.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/power/ab8500_charger.c b/drivers/power/ab8500_charger.c
index 64accb2..8530028 100644
--- a/drivers/power/ab8500_charger.c
+++ b/drivers/power/ab8500_charger.c
@@ -441,7 +441,8 @@ static void ab8500_charger_set_usb_connected(struct ab8500_charger *di,
 			mutex_lock(&di->charger_attached_mutex);
 			mutex_unlock(&di->charger_attached_mutex);
 
-			queue_delayed_work(di->charger_wq,
+			if (is_ab8500(di->parent))
+				queue_delayed_work(di->charger_wq,
 					   &di->usb_charger_attached_work,
 					   HZ);
 		} else {
@@ -2622,7 +2623,9 @@ static irqreturn_t ab8500_charger_mainchplugdet_handler(int irq, void *_di)
 
 	mutex_lock(&di->charger_attached_mutex);
 	mutex_unlock(&di->charger_attached_mutex);
-	queue_delayed_work(di->charger_wq,
+
+	if (is_ab8500(di->parent))
+		queue_delayed_work(di->charger_wq,
 			   &di->ac_charger_attached_work,
 			   HZ);
 	return IRQ_HANDLED;
@@ -3690,14 +3693,16 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	ch_stat = ab8500_charger_detect_chargers(di, false);
 
 	if ((ch_stat & AC_PW_CONN) == AC_PW_CONN) {
-		queue_delayed_work(di->charger_wq,
-				   &di->ac_charger_attached_work,
-				   HZ);
+		if (is_ab8500(di->parent))
+			queue_delayed_work(di->charger_wq,
+					   &di->ac_charger_attached_work,
+					   HZ);
 	}
 	if ((ch_stat & USB_PW_CONN) == USB_PW_CONN) {
-		queue_delayed_work(di->charger_wq,
-				   &di->usb_charger_attached_work,
-				   HZ);
+		if (is_ab8500(di->parent))
+			queue_delayed_work(di->charger_wq,
+					   &di->usb_charger_attached_work,
+					   HZ);
 	}
 
 	mutex_unlock(&di->charger_attached_mutex);
-- 
1.7.10.4
