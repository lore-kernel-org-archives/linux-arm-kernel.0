From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 5 Nov 2013 09:55:18 +0800
Subject: [PATCH v3 03/10] usb: chipidea: add wakeup interrupt handler
In-Reply-To: <1383616525-10769-1-git-send-email-peter.chen@freescale.com>
References: <1383616525-10769-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1383616525-10769-4-git-send-email-peter.chen@freescale.com>
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
index f296d66..3e848b1 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -177,6 +177,7 @@ struct ci_hdrc {
 	bool				imx28_write_fix;
 	bool				supports_runtime_pm;
 	bool				in_lpm;
+	bool				wakeup_int;
 };
 
 static inline struct ci_role_driver *ci_role(struct ci_hdrc *ci)
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index b05470f..4ba9e68 100644
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
 
@@ -744,6 +758,12 @@ static int ci_controller_resume(struct device *dev)
 
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
