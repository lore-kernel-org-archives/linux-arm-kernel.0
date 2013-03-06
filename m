From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 6 Mar 2013 17:56:38 +0800
Subject: [PATCH v11 7/9] usb: chipidea: delete the delayed work
In-Reply-To: <1362563800-16673-1-git-send-email-peter.chen@freescale.com>
References: <1362563800-16673-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1362563800-16673-8-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After moving vbus operation to host, we no matter need to delayed operation.
But, the connection notification to gadget is needed as gadget's start
is only enable vbus operation, but it doesn't need to delayed.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci.h   |    1 -
 drivers/usb/chipidea/core.c |   22 +++-------------------
 2 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index 8826cdb..35ca5ee 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -144,7 +144,6 @@ struct ci13xxx {
 	enum ci_role			role;
 	bool				is_otg;
 	struct work_struct		work;
-	struct delayed_work		dwork;
 	struct workqueue_struct		*wq;
 
 	struct dma_pool			*qh_pool;
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index e0ff335..464e075 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -405,22 +405,6 @@ static void ci_otg_work(struct work_struct *work)
 	enable_irq(ci->irq);
 }
 
-static void ci_delayed_work(struct work_struct *work)
-{
-	struct delayed_work *dwork = to_delayed_work(work);
-	struct ci13xxx *ci = container_of(dwork, struct ci13xxx, dwork);
-
-	/*
-	 * If it is gadget mode, the vbus operation should be done like below:
-	 * 1. Enable vbus detect
-	 * 2. If it has already connected to host, notify udc
-	 */
-	if (ci->role == CI_ROLE_GADGET) {
-		ci_enable_otg_interrupt(ci, OTGSC_BSVIE);
-		ci_handle_vbus_change(ci);
-	}
-}
-
 static inline void ci_role_destroy(struct ci13xxx *ci)
 {
 	ci_hdrc_gadget_destroy(ci);
@@ -615,7 +599,6 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	}
 
 	INIT_WORK(&ci->work, ci_otg_work);
-	INIT_DELAYED_WORK(&ci->dwork, ci_delayed_work);
 	ci->wq = create_singlethread_workqueue("ci_otg");
 	if (!ci->wq) {
 		dev_err(dev, "can't create workqueue\n");
@@ -678,8 +661,9 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_irq;
 
-	/* Defer some operations */
-	queue_delayed_work(ci->wq, &ci->dwork, msecs_to_jiffies(200));
+	/* If it is connected to host, tell gadget the connection */
+	if (ci->role == CI_ROLE_GADGET)
+		ci_handle_vbus_change(ci);
 
 	return ret;
 
-- 
1.7.0.4
