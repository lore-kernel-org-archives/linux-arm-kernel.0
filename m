From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Sat, 9 Dec 2017 16:45:32 +0800
Subject: [PATCH 3/7] usb: xhci-mtk: use APIs of mtu_wakeup to support remote
 wakeup
In-Reply-To: <1512809136-2779-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1512809136-2779-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1512809136-2779-4-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some platforms, there are two xHCI IPs, but the old way of
usb wakeup doesn't support it, so use the new APIs of mtu_wakeup
to support it.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c | 39 +++++++++++++++++++++++----------------
 drivers/usb/host/xhci-mtk.h |  2 ++
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index b62a1d2..3176a10 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -19,6 +19,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/soc/mediatek/usb-wakeup.h>
 
 #include "xhci.h"
 #include "xhci-mtk.h"
@@ -366,7 +367,9 @@ static void usb_wakeup_line_state_dis(struct xhci_hcd_mtk *mtk)
 
 static void usb_wakeup_enable(struct xhci_hcd_mtk *mtk)
 {
-	if (mtk->wakeup_src == SSUSB_WK_IP_SLEEP)
+	if (mtk->wakeup)
+		mtu_wakeup_enable(mtk->uwk);
+	else if (mtk->wakeup_src == SSUSB_WK_IP_SLEEP)
 		usb_wakeup_ip_sleep_en(mtk);
 	else if (mtk->wakeup_src == SSUSB_WK_LINE_STATE)
 		usb_wakeup_line_state_en(mtk);
@@ -374,7 +377,9 @@ static void usb_wakeup_enable(struct xhci_hcd_mtk *mtk)
 
 static void usb_wakeup_disable(struct xhci_hcd_mtk *mtk)
 {
-	if (mtk->wakeup_src == SSUSB_WK_IP_SLEEP)
+	if (mtk->wakeup)
+		mtu_wakeup_disable(mtk->uwk);
+	else if (mtk->wakeup_src == SSUSB_WK_IP_SLEEP)
 		usb_wakeup_ip_sleep_dis(mtk);
 	else if (mtk->wakeup_src == SSUSB_WK_LINE_STATE)
 		usb_wakeup_line_state_dis(mtk);
@@ -383,24 +388,26 @@ static void usb_wakeup_disable(struct xhci_hcd_mtk *mtk)
 static int usb_wakeup_of_property_parse(struct xhci_hcd_mtk *mtk,
 				struct device_node *dn)
 {
-	struct device *dev = mtk->dev;
+	/* try the new way first */
+	mtk->wakeup = of_property_read_bool(dn, "wakeup-source");
+	if (mtk->wakeup) {
+		mtk->uwk = devm_of_uwk_get_by_index(mtk->dev, dn, 0);
+		if (IS_ERR(mtk->uwk))
+			dev_err(mtk->dev, "fail to get uwk\n");
+
+		return PTR_ERR_OR_ZERO(mtk->uwk);
+	}
 
-	/*
-	* wakeup function is optional, so it is not an error if this property
-	* does not exist, and in such case, no need to get relative
-	* properties anymore.
-	*/
+	/* wakeup function is optional (deprecated, use the new way instead) */
 	of_property_read_u32(dn, "mediatek,wakeup-src", &mtk->wakeup_src);
-	if (!mtk->wakeup_src)
-		return 0;
-
-	mtk->pericfg = syscon_regmap_lookup_by_phandle(dn,
+	if (mtk->wakeup_src) {
+		mtk->pericfg = syscon_regmap_lookup_by_phandle(dn,
 						"mediatek,syscon-wakeup");
-	if (IS_ERR(mtk->pericfg)) {
-		dev_err(dev, "fail to get pericfg regs\n");
-		return PTR_ERR(mtk->pericfg);
+		if (IS_ERR(mtk->pericfg)) {
+			dev_err(mtk->dev, "fail to get pericfg regs\n");
+			return PTR_ERR(mtk->pericfg);
+		}
 	}
-
 	return 0;
 }
 
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index 6b74ce5..95bd6ca 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -124,6 +124,8 @@ struct xhci_hcd_mtk {
 	int num_phys;
 	int wakeup_src;
 	bool lpm_support;
+	struct mtu_wakeup *uwk;
+	bool wakeup;
 };
 
 static inline struct xhci_hcd_mtk *hcd_to_mtk(struct usb_hcd *hcd)
-- 
1.9.1
