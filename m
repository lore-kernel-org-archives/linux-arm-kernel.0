From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 12 Aug 2013 09:22:52 +0800
Subject: [PATCH v15 06/13] usb: chipidea: add flag CI_HDRC_DUAL_ROLE_NOT_OTG
In-Reply-To: <1376270579-13493-1-git-send-email-peter.chen@freescale.com>
References: <1376270579-13493-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1376270579-13493-7-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we need otgsc to know vbus's status at some chipidea
controllers even it is peripheral-only mode. Besides, some
SoCs (eg, AR9331 SoC) don't have otgsc register even
the DCCPARAMS_DC and DCCPARAMS_HC are both 1 at CAP_DCCPARAMS.

We inroduce flag CI_HDRC_DUAL_ROLE_NOT_OTG to indicate if the
controller is dual role, but not supports OTG. If this flag is
not set, we follow the rule that if DCCPARAMS_DC and DCCPARAMS_HC
are both 1 at CAP_DCCPARAMS, then this controller is otg capable.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/core.c  |   37 ++++++++++++++++++++++++++++++-------
 include/linux/usb/chipidea.h |    5 +++++
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index bfc9aef..56294e0 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -426,6 +426,18 @@ static inline void ci_role_destroy(struct ci_hdrc *ci)
 	ci_hdrc_host_destroy(ci);
 }
 
+static void ci_get_otg_capable(struct ci_hdrc *ci)
+{
+	if (ci->platdata->flags & CI_HDRC_DUAL_ROLE_NOT_OTG)
+		ci->is_otg = false;
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
@@ -482,6 +494,8 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	ci_get_otg_capable(ci);
+
 	if (!ci->platdata->phy_mode)
 		ci->platdata->phy_mode = of_usb_get_phy_mode(dev->of_node);
 
@@ -514,10 +528,22 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	}
 
 	if (ci->roles[CI_ROLE_HOST] && ci->roles[CI_ROLE_GADGET]) {
-		ci->is_otg = true;
-		/* ID pin needs 1ms debouce time, we delay 2ms for safe */
-		mdelay(2);
-		ci->role = ci_otg_role(ci);
+		if (ci->is_otg) {
+			/*
+			 * ID pin needs 1ms debouce time,
+			 * we delay 2ms for safe.
+			 */
+			mdelay(2);
+			ci->role = ci_otg_role(ci);
+			ci_hdrc_otg_init(ci);
+		} else {
+			/*
+			 * If the controller is not OTG capable, but support
+			 * role switch, the defalt role is gadget, and the
+			 * user can switch it through debugfs.
+			 */
+			ci->role = CI_ROLE_GADGET;
+		}
 	} else {
 		ci->role = ci->roles[CI_ROLE_HOST]
 			? CI_ROLE_HOST
@@ -536,9 +562,6 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	if (ret)
 		goto stop;
 
-	if (ci->is_otg)
-		ci_hdrc_otg_init(ci);
-
 	ret = dbg_create_files(ci);
 	if (!ret)
 		return 0;
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index ce4e1aa..10a607c 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -20,6 +20,11 @@ struct ci_hdrc_platform_data {
 #define CI_HDRC_REQUIRE_TRANSCEIVER	BIT(1)
 #define CI_HDRC_PULLUP_ON_VBUS		BIT(2)
 #define CI_HDRC_DISABLE_STREAMING	BIT(3)
+	/*
+	 * Only set it when DCCPARAMS.DC==1 and DCCPARAMS.HC==1,
+	 * but otg is not supported (no register otgsc).
+	 */
+#define CI_HDRC_DUAL_ROLE_NOT_OTG	BIT(4)
 	enum usb_dr_mode	dr_mode;
 #define CI_HDRC_CONTROLLER_RESET_EVENT		0
 #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
-- 
1.7.1
