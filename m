From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Sat, 9 Dec 2017 16:45:33 +0800
Subject: [PATCH 4/7] usb: mtu3: use APIs of mtu_wakeup to support remote wakeup
In-Reply-To: <1512809136-2779-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1512809136-2779-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1512809136-2779-5-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some platforms, there are two SSUSB IPs, but the old way of
usb wakeup doesn't support it, so use the new APIs of mtu_wakeup
to support it.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h      |  2 ++
 drivers/usb/mtu3/mtu3_host.c | 39 +++++++++++++++++++++++----------------
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 3c888d9..9f3eb79 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -255,6 +255,8 @@ struct ssusb_mtk {
 	/* usb wakeup for host mode */
 	bool wakeup_en;
 	struct regmap *pericfg;
+	struct mtu_wakeup *uwk;
+	bool new_wakeup;
 };
 
 /**
diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
index 7e948c0..f769b65 100644
--- a/drivers/usb/mtu3/mtu3_host.c
+++ b/drivers/usb/mtu3/mtu3_host.c
@@ -14,6 +14,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
+#include <linux/soc/mediatek/usb-wakeup.h>
 
 #include "mtu3.h"
 #include "mtu3_dr.h"
@@ -56,24 +57,26 @@ static void ssusb_wakeup_ip_sleep_dis(struct ssusb_mtk *ssusb)
 int ssusb_wakeup_of_property_parse(struct ssusb_mtk *ssusb,
 				struct device_node *dn)
 {
-	struct device *dev = ssusb->dev;
+	/* try the new way first */
+	ssusb->new_wakeup = of_property_read_bool(dn, "wakeup-source");
+	if (ssusb->new_wakeup) {
+		ssusb->uwk = devm_of_uwk_get_by_index(ssusb->dev, dn, 0);
+		if (IS_ERR(ssusb->uwk))
+			dev_err(ssusb->dev, "fail to get mtu_wakeup\n");
+
+		return PTR_ERR_OR_ZERO(ssusb->uwk);
+	}
 
-	/*
-	 * Wakeup function is optional, so it is not an error if this property
-	 * does not exist, and in such case, no need to get relative
-	 * properties anymore.
-	 */
+	/* Wakeup function is optional. (deprecated, use the new way instead) */
 	ssusb->wakeup_en = of_property_read_bool(dn, "mediatek,enable-wakeup");
-	if (!ssusb->wakeup_en)
-		return 0;
-
-	ssusb->pericfg = syscon_regmap_lookup_by_phandle(dn,
+	if (ssusb->wakeup_en) {
+		ssusb->pericfg = syscon_regmap_lookup_by_phandle(dn,
 						"mediatek,syscon-wakeup");
-	if (IS_ERR(ssusb->pericfg)) {
-		dev_err(dev, "fail to get pericfg regs\n");
-		return PTR_ERR(ssusb->pericfg);
+		if (IS_ERR(ssusb->pericfg)) {
+			dev_err(ssusb->dev, "fail to get pericfg regs\n");
+			return PTR_ERR(ssusb->pericfg);
+		}
 	}
-
 	return 0;
 }
 
@@ -235,7 +238,9 @@ void ssusb_host_exit(struct ssusb_mtk *ssusb)
 
 int ssusb_wakeup_enable(struct ssusb_mtk *ssusb)
 {
-	if (ssusb->wakeup_en)
+	if (ssusb->new_wakeup)
+		mtu_wakeup_enable(ssusb->uwk);
+	else if (ssusb->wakeup_en)
 		ssusb_wakeup_ip_sleep_en(ssusb);
 
 	return 0;
@@ -243,6 +248,8 @@ int ssusb_wakeup_enable(struct ssusb_mtk *ssusb)
 
 void ssusb_wakeup_disable(struct ssusb_mtk *ssusb)
 {
-	if (ssusb->wakeup_en)
+	if (ssusb->new_wakeup)
+		mtu_wakeup_disable(ssusb->uwk);
+	else if (ssusb->wakeup_en)
 		ssusb_wakeup_ip_sleep_dis(ssusb);
 }
-- 
1.9.1
