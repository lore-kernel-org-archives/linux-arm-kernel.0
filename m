From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 11 Jul 2013 14:27:14 +0800
Subject: [PATCH v12 06/13] usb: chipidea: add otg_cap attribute for otg capable
In-Reply-To: <1373524041-10482-1-git-send-email-peter.chen@freescale.com>
References: <1373524041-10482-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1373524041-10482-7-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we need otgsc to know vbus's status at some chipidea
controllers even it is peripheral-only mode. Besides, some
SoCs (eg, AR9331 SoC) don't have otgsc register even
the DCCPARAMS_DC and DCCPARAMS_HC are both 1 at CAP_DCCPARAMS.
We inroduce otg_cap attribute to indicate if the controller
is otg capable, defaultly, we follow the rule that if DCCPARAMS_DC
and DCCPARAMS_HC are both 1 at CAP_DCCPARAMS are otg capable, but if there
is exception, the platform can override it by device tree or platform data.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/core.c  |   35 ++++++++++++++++++++++++++++-------
 include/linux/usb/chipidea.h |   13 +++++++++++++
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 93961ff..e8ceb04 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -405,6 +405,18 @@ static inline void ci_role_destroy(struct ci_hdrc *ci)
 	ci_hdrc_host_destroy(ci);
 }
 
+static void ci_get_otg_capable(struct ci_hdrc *ci)
+{
+	if (ci->platdata->otg_cap != OTG_CAP_ATTR_IS_NOT_EXISTED)
+		ci->is_otg = (ci->platdata->otg_cap == OTG_CAP_ATTR_IS_TRUE);
+	else
+		ci->is_otg = (hw_read(ci, CAP_DCCPARAMS,
+				DCCPARAMS_DC | DCCPARAMS_HC)
+					== (DCCPARAMS_DC | DCCPARAMS_HC));
+	if (ci->is_otg)
+		dev_dbg(ci->dev, "It is OTG capable controller\n");
+}
+
 static int ci_hdrc_probe(struct platform_device *pdev)
 {
 	struct device	*dev = &pdev->dev;
@@ -461,6 +473,9 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/* To know if controller is OTG capable or not */
+	ci_get_otg_capable(ci);
+
 	if (!ci->platdata->phy_mode)
 		ci->platdata->phy_mode = of_usb_get_phy_mode(dev->of_node);
 
@@ -491,10 +506,19 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	}
 
 	if (ci->roles[CI_ROLE_HOST] && ci->roles[CI_ROLE_GADGET]) {
-		ci->is_otg = true;
-		/* ID pin needs 1ms debouce time, we delay 2ms for safe */
-		mdelay(2);
-		ci->role = ci_otg_role(ci);
+		if (ci->is_otg) {
+			/* ID pin needs 1ms debouce time, we delay 2ms for safe */
+			mdelay(2);
+			ci->role = ci_otg_role(ci);
+			ci_hdrc_otg_init(ci);
+		} else {
+			/*
+			 * If the controller is not OTG capable, but support
+			 * role switch, the defalt role is gadget, and the
+			 * user can switch it through debugfs (proc in future?)
+			 */
+			ci->role = CI_ROLE_GADGET;
+		}
 	} else {
 		ci->role = ci->roles[CI_ROLE_HOST]
 			? CI_ROLE_HOST
@@ -514,9 +538,6 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	if (ret)
 		goto stop;
 
-	if (ci->is_otg)
-		ci_hdrc_otg_init(ci);
-
 	ret = dbg_create_files(ci);
 	if (!ret)
 		return 0;
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 118bf66..0a906b4 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -7,6 +7,12 @@
 
 #include <linux/usb/otg.h>
 
+enum usb_otg_cap {
+	OTG_CAP_ATTR_IS_NOT_EXISTED = 0,
+	OTG_CAP_ATTR_IS_TRUE,
+	OTG_CAP_ATTR_IS_FALSE,
+};
+
 struct ci_hdrc;
 struct ci_hdrc_platform_data {
 	const char	*name;
@@ -25,6 +31,13 @@ struct ci_hdrc_platform_data {
 #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
 	void	(*notify_event) (struct ci_hdrc *ci, unsigned event);
 	struct regulator *reg_vbus;
+	/*
+	 * Please only set otg_cap when the otg capability can't be
+	 * judged by CAP_DCCPARAMS, eg, the DCCPARAMS_DC and DCCPARAMS_HC
+	 * are both 1 at CAP_DCCPARAMS, but the controller doesn't have
+	 * OTGSC register (eg, AR9331 SoC).
+	 */
+	enum usb_otg_cap otg_cap;
 };
 
 /* Default offset of capability registers */
-- 
1.7.0.4
