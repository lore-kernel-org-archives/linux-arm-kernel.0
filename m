From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 26 Apr 2017 16:59:34 +0800
Subject: [PATCH v2] usb: chipidea: properly handle host or gadget
 initialization failure
Message-ID: <20170426085934.3140-1-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If ci_hdrc_host_init() or ci_hdrc_gadget_init() returns error and the
error != -ENXIO, as Peter pointed out, "it stands for initialization
for host or gadget has failed", so we'd better return failure rather
continue.

And before destroying the otg, i.e ci_hdrc_otg_destroy(ci), we should
also check ci->roles[CI_ROLE_GADGET].

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
Since v1:
 - check ci->roles[CI_ROLE_GADGET] before destroying the otg, suggested
   by Peter.

 drivers/usb/chipidea/core.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 79ad8e91632e..0192a26ec0f9 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -821,7 +821,7 @@ static inline void ci_role_destroy(struct ci_hdrc *ci)
 {
 	ci_hdrc_gadget_destroy(ci);
 	ci_hdrc_host_destroy(ci);
-	if (ci->is_otg)
+	if (ci->is_otg && ci->roles[CI_ROLE_GADGET])
 		ci_hdrc_otg_destroy(ci);
 }
 
@@ -930,27 +930,35 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	/* initialize role(s) before the interrupt is requested */
 	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
 		ret = ci_hdrc_host_init(ci);
-		if (ret)
-			dev_info(dev, "doesn't support host\n");
+		if (ret) {
+			if (ret == -ENXIO)
+				dev_info(dev, "doesn't support host\n");
+			else
+				goto deinit_phy;
+		}
 	}
 
 	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_PERIPHERAL) {
 		ret = ci_hdrc_gadget_init(ci);
-		if (ret)
-			dev_info(dev, "doesn't support gadget\n");
+		if (ret) {
+			if (ret == -ENXIO)
+				dev_info(dev, "doesn't support gadget\n");
+			else
+				goto deinit_host;
+		}
 	}
 
 	if (!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]) {
 		dev_err(dev, "no supported roles\n");
 		ret = -ENODEV;
-		goto deinit_phy;
+		goto deinit_gadget;
 	}
 
 	if (ci->is_otg && ci->roles[CI_ROLE_GADGET]) {
 		ret = ci_hdrc_otg_init(ci);
 		if (ret) {
 			dev_err(dev, "init otg fails, ret = %d\n", ret);
-			goto stop;
+			goto deinit_gadget;
 		}
 	}
 
@@ -1013,7 +1021,12 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		return 0;
 
 stop:
-	ci_role_destroy(ci);
+	if (ci->is_otg && ci->roles[CI_ROLE_GADGET])
+		ci_hdrc_otg_destroy(ci);
+deinit_gadget:
+	ci_hdrc_gadget_destroy(ci);
+deinit_host:
+	ci_hdrc_host_destroy(ci);
 deinit_phy:
 	ci_usb_phy_exit(ci);
 ulpi_exit:
-- 
2.11.0
