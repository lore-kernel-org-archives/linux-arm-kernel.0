From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 22 Oct 2013 14:23:32 +0800
Subject: [Patch v2 03/10] usb: chipidea: add wakeup interrupt handler
In-Reply-To: <1382423019-26184-1-git-send-email-peter.chen@freescale.com>
References: <1382423019-26184-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1382423019-26184-4-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the controller is at suspend mode, it can be waken up by
external events (like vbus, dp/dm or id change). Once we receive
the wakeup interrupt, we need to resume the controller first, eg
open clocks, disable some wakeup settings, etc. After that, the
controller can receive the normal USB interrupts.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci.h   |    1 +
 drivers/usb/chipidea/core.c |   20 ++++++++++++++++++++
 drivers/usb/chipidea/otg.c  |    5 +++++
 3 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index 6ea1892..38598b3 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -175,6 +175,7 @@ struct ci_hdrc {
 	bool				b_sess_valid_event;
 	bool				supports_runtime_pm;
 	bool				in_lpm;
+	bool				wakeup_int;
 };
 
 static inline struct ci_role_driver *ci_role(struct ci_hdrc *ci)
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index a5b8f43..a9497eb 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -190,6 +190,13 @@ static void ci_hdrc_enter_lpm(struct ci_hdrc *ci, bool enable)
 		 * than 1ms) to leave low power mode.
 		 */
 		usleep_range(1500, 2000);
+	} else if (!enable) {
+		/*
+		 * At wakeup interrupt, the phcd will be cleared by hardware
+		 * automatically, but the controller needs at least 1ms
+		 * to reflect PHY's status.
+		 */
+		usleep_range(1200, 1800);
 	}
 }
 
@@ -355,6 +362,13 @@ static irqreturn_t ci_irq(int irq, void *data)
 	irqreturn_t ret = IRQ_NONE;
 	u32 otgsc = 0;
 
+	if (ci->in_lpm) {
+		disable_irq_nosync(irq);
+		ci->wakeup_int = true;
+		pm_runtime_get(ci->dev);
+		return IRQ_HANDLED;
+	}
+
 	if (ci->is_otg)
 		otgsc = hw_read(ci, OP_OTGSC, ~0);
 
@@ -739,6 +753,12 @@ static int ci_controller_resume(struct device *dev)
 
 	ci->in_lpm = false;
 
+	if (ci->wakeup_int) {
+		ci->wakeup_int = false;
+		enable_irq(ci->irq);
+		pm_runtime_put(ci->dev);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
index 39bd7ec..54bc7c0 100644
--- a/drivers/usb/chipidea/otg.c
+++ b/drivers/usb/chipidea/otg.c
@@ -78,10 +78,15 @@ static void ci_otg_work(struct work_struct *work)
 
 	if (ci->id_event) {
 		ci->id_event = false;
+		/* Keep controller active during id switch */
+		pm_runtime_get_sync(ci->dev);
 		ci_handle_id_switch(ci);
+		pm_runtime_put_sync(ci->dev);
 	} else if (ci->b_sess_valid_event) {
 		ci->b_sess_valid_event = false;
+		pm_runtime_get_sync(ci->dev);
 		ci_handle_vbus_change(ci);
+		pm_runtime_put_sync(ci->dev);
 	} else
 		dev_err(ci->dev, "unexpected event occurs at %s\n", __func__);
 
-- 
1.7.1
