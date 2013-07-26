From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 26 Jul 2013 17:18:25 +0800
Subject: [PATCH v13 09/14] usb: chipidea: move otg relate things to otg file
In-Reply-To: <1374830310-21765-1-git-send-email-peter.chen@freescale.com>
References: <1374830310-21765-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1374830310-21765-10-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move otg relate things to otg file.

Tested-by: Marek Vasut <marex@denx.de>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/core.c |   63 +++++++++----------------------------------
 drivers/usb/chipidea/otg.c  |   57 +++++++++++++++++++++++++++++++++++++-
 drivers/usb/chipidea/otg.h  |    2 +
 3 files changed, 70 insertions(+), 52 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 8884af6..78c4721 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -295,40 +295,6 @@ int hw_device_reset(struct ci_hdrc *ci, u32 mode)
 	return 0;
 }
 
-/**
- * ci_otg_role - pick role based on ID pin state
- * @ci: the controller
- */
-static enum ci_role ci_otg_role(struct ci_hdrc *ci)
-{
-	u32 sts = hw_read(ci, OP_OTGSC, ~0);
-	enum ci_role role = sts & OTGSC_ID
-		? CI_ROLE_GADGET
-		: CI_ROLE_HOST;
-
-	return role;
-}
-
-/**
- * ci_role_work - perform role changing based on ID pin
- * @work: work struct
- */
-static void ci_role_work(struct work_struct *work)
-{
-	struct ci_hdrc *ci = container_of(work, struct ci_hdrc, work);
-	enum ci_role role = ci_otg_role(ci);
-
-	if (role != ci->role) {
-		dev_dbg(ci->dev, "switching from %s to %s\n",
-			ci_role(ci)->name, ci->roles[role]->name);
-
-		ci_role_stop(ci);
-		ci_role_start(ci, role);
-	}
-
-	enable_irq(ci->irq);
-}
-
 static irqreturn_t ci_irq(int irq, void *data)
 {
 	struct ci_hdrc *ci = data;
@@ -409,6 +375,8 @@ static inline void ci_role_destroy(struct ci_hdrc *ci)
 {
 	ci_hdrc_gadget_destroy(ci);
 	ci_hdrc_host_destroy(ci);
+	if (ci->is_otg)
+		ci_hdrc_otg_destory(ci);
 }
 
 static void ci_get_otg_capable(struct ci_hdrc *ci)
@@ -475,13 +443,6 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	INIT_WORK(&ci->work, ci_role_work);
-	ci->wq = create_singlethread_workqueue("ci_otg");
-	if (!ci->wq) {
-		dev_err(dev, "can't create workqueue\n");
-		return -ENODEV;
-	}
-
 	/* To know if controller is OTG capable or not */
 	ci_get_otg_capable(ci);
 
@@ -510,8 +471,15 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 
 	if (!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]) {
 		dev_err(dev, "no supported roles\n");
-		ret = -ENODEV;
-		goto rm_wq;
+		return -ENODEV;
+	}
+
+	if (ci->is_otg) {
+		ret = ci_hdrc_otg_init(ci);
+		if (ret) {
+			dev_err(dev, "init otg fails, ret = %d\n", ret);
+			goto stop;
+		}
 	}
 
 	if (ci->roles[CI_ROLE_HOST] && ci->roles[CI_ROLE_GADGET]) {
@@ -522,7 +490,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 			 */
 			mdelay(2);
 			ci->role = ci_otg_role(ci);
-			ci_hdrc_otg_init(ci);
+			ci_enable_otg_interrupt(ci, OTGSC_IDIE);
 		} else {
 			/*
 			 * If the controller is not OTG capable, but support
@@ -541,7 +509,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dev, "can't start %s role\n", ci_role(ci)->name);
 		ret = -ENODEV;
-		goto rm_wq;
+		goto stop;
 	}
 
 	platform_set_drvdata(pdev, ci);
@@ -557,9 +525,6 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	free_irq(ci->irq, ci);
 stop:
 	ci_role_destroy(ci);
-rm_wq:
-	flush_workqueue(ci->wq);
-	destroy_workqueue(ci->wq);
 
 	return ret;
 }
@@ -569,8 +534,6 @@ static int ci_hdrc_remove(struct platform_device *pdev)
 	struct ci_hdrc *ci = platform_get_drvdata(pdev);
 
 	dbg_remove_files(ci);
-	flush_workqueue(ci->wq);
-	destroy_workqueue(ci->wq);
 	free_irq(ci->irq, ci);
 	ci_role_destroy(ci);
 
diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
index abefb4d..68f2faf 100644
--- a/drivers/usb/chipidea/otg.c
+++ b/drivers/usb/chipidea/otg.c
@@ -39,12 +39,65 @@ void ci_disable_otg_interrupt(struct ci_hdrc *ci, u32 bits)
 }
 
 /**
- * ci_hdrc_otg_init - initialize otgsc bits
+ * ci_otg_role - pick role based on ID pin state
+ * @ci: the controller
+ */
+enum ci_role ci_otg_role(struct ci_hdrc *ci)
+{
+	u32 sts = hw_read(ci, OP_OTGSC, ~0);
+	enum ci_role role = sts & OTGSC_ID
+		? CI_ROLE_GADGET
+		: CI_ROLE_HOST;
+
+	return role;
+}
+
+/**
+ * ci_role_work - perform role changing based on ID pin
+ * @work: work struct
+ */
+static void ci_role_work(struct work_struct *work)
+{
+	struct ci_hdrc *ci = container_of(work, struct ci_hdrc, work);
+	enum ci_role role = ci_otg_role(ci);
+
+	if (role != ci->role) {
+		dev_dbg(ci->dev, "switching from %s to %s\n",
+			ci_role(ci)->name, ci->roles[role]->name);
+
+		ci_role_stop(ci);
+		ci_role_start(ci, role);
+	}
+
+	enable_irq(ci->irq);
+}
+
+/**
+ * ci_hdrc_otg_init - initialize otg struct
  * ci: the controller
  */
 int ci_hdrc_otg_init(struct ci_hdrc *ci)
 {
-	ci_enable_otg_interrupt(ci, OTGSC_IDIE);
+	INIT_WORK(&ci->work, ci_role_work);
+	ci->wq = create_singlethread_workqueue("ci_otg");
+	if (!ci->wq) {
+		dev_err(ci->dev, "can't create workqueue\n");
+		return -ENODEV;
+	}
 
 	return 0;
 }
+
+/**
+ * ci_hdrc_otg_destroy - destory otg struct
+ * ci: the controller
+ */
+void ci_hdrc_otg_destory(struct ci_hdrc *ci)
+{
+	if (ci->wq) {
+		flush_workqueue(ci->wq);
+		destroy_workqueue(ci->wq);
+	}
+	ci_disable_otg_interrupt(ci, OTGSC_INT_EN_BITS);
+	ci_clear_otg_interrupt(ci, OTGSC_INT_STATUS_BITS);
+}
diff --git a/drivers/usb/chipidea/otg.h b/drivers/usb/chipidea/otg.h
index f24ec37..8913062 100644
--- a/drivers/usb/chipidea/otg.h
+++ b/drivers/usb/chipidea/otg.h
@@ -15,5 +15,7 @@ int ci_hdrc_otg_init(struct ci_hdrc *ci);
 void ci_clear_otg_interrupt(struct ci_hdrc *ci, u32 bits);
 void ci_enable_otg_interrupt(struct ci_hdrc *ci, u32 bits);
 void ci_disable_otg_interrupt(struct ci_hdrc *ci, u32 bits);
+void ci_hdrc_otg_destory(struct ci_hdrc *ci);
+enum ci_role ci_otg_role(struct ci_hdrc *ci);
 
 #endif /* __DRIVERS_USB_CHIPIDEA_OTG_H */
-- 
1.7.0.4
