From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 27 Sep 2017 18:58:32 +0800
Subject: [PATCH 03/12] usb: mtu3: remove dummy wakeup debounce clocks
In-Reply-To: <fe8df8503f602586bcea4b1598eb09678b1525e3.1506509658.git.chunfeng.yun@mediatek.com>
References: <fe8df8503f602586bcea4b1598eb09678b1525e3.1506509658.git.chunfeng.yun@mediatek.com>
Message-ID: <6713eb6ffe4160efe9219cba5be81a228d4b30a3.1506509658.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wakeup debounce clocks for each ports in fact are not
needed, so remove them.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h      |    4 ---
 drivers/usb/mtu3/mtu3_host.c |   57 +++---------------------------------------
 2 files changed, 4 insertions(+), 57 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 112723d..6d3278e 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -214,8 +214,6 @@ struct otg_switch_mtk {
  *		disable u3port0, bit1==1 to disable u3port1,... etc
  * @dbgfs_root: only used when supports manual dual-role switch via debugfs
  * @wakeup_en: it's true when supports remote wakeup in host mode
- * @wk_deb_p0: port0's wakeup debounce clock
- * @wk_deb_p1: it's optional, and depends on port1 is supported or not
  */
 struct ssusb_mtk {
 	struct device *dev;
@@ -238,8 +236,6 @@ struct ssusb_mtk {
 	struct dentry *dbgfs_root;
 	/* usb wakeup for host mode */
 	bool wakeup_en;
-	struct clk *wk_deb_p0;
-	struct clk *wk_deb_p1;
 	struct regmap *pericfg;
 };
 
diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
index 4dd9508..edcc591 100644
--- a/drivers/usb/mtu3/mtu3_host.c
+++ b/drivers/usb/mtu3/mtu3_host.c
@@ -79,20 +79,6 @@ int ssusb_wakeup_of_property_parse(struct ssusb_mtk *ssusb,
 	if (!ssusb->wakeup_en)
 		return 0;
 
-	ssusb->wk_deb_p0 = devm_clk_get(dev, "wakeup_deb_p0");
-	if (IS_ERR(ssusb->wk_deb_p0)) {
-		dev_err(dev, "fail to get wakeup_deb_p0\n");
-		return PTR_ERR(ssusb->wk_deb_p0);
-	}
-
-	if (of_property_read_bool(dn, "wakeup_deb_p1")) {
-		ssusb->wk_deb_p1 = devm_clk_get(dev, "wakeup_deb_p1");
-		if (IS_ERR(ssusb->wk_deb_p1)) {
-			dev_err(dev, "fail to get wakeup_deb_p1\n");
-			return PTR_ERR(ssusb->wk_deb_p1);
-		}
-	}
-
 	ssusb->pericfg = syscon_regmap_lookup_by_phandle(dn,
 						"mediatek,syscon-wakeup");
 	if (IS_ERR(ssusb->pericfg)) {
@@ -103,36 +89,6 @@ int ssusb_wakeup_of_property_parse(struct ssusb_mtk *ssusb,
 	return 0;
 }
 
-static int ssusb_wakeup_clks_enable(struct ssusb_mtk *ssusb)
-{
-	int ret;
-
-	ret = clk_prepare_enable(ssusb->wk_deb_p0);
-	if (ret) {
-		dev_err(ssusb->dev, "failed to enable wk_deb_p0\n");
-		goto usb_p0_err;
-	}
-
-	ret = clk_prepare_enable(ssusb->wk_deb_p1);
-	if (ret) {
-		dev_err(ssusb->dev, "failed to enable wk_deb_p1\n");
-		goto usb_p1_err;
-	}
-
-	return 0;
-
-usb_p1_err:
-	clk_disable_unprepare(ssusb->wk_deb_p0);
-usb_p0_err:
-	return -EINVAL;
-}
-
-static void ssusb_wakeup_clks_disable(struct ssusb_mtk *ssusb)
-{
-	clk_disable_unprepare(ssusb->wk_deb_p1);
-	clk_disable_unprepare(ssusb->wk_deb_p0);
-}
-
 static void host_ports_num_get(struct ssusb_mtk *ssusb)
 {
 	u32 xhci_cap;
@@ -286,19 +242,14 @@ void ssusb_host_exit(struct ssusb_mtk *ssusb)
 
 int ssusb_wakeup_enable(struct ssusb_mtk *ssusb)
 {
-	int ret = 0;
-
-	if (ssusb->wakeup_en) {
-		ret = ssusb_wakeup_clks_enable(ssusb);
+	if (ssusb->wakeup_en)
 		ssusb_wakeup_ip_sleep_en(ssusb);
-	}
-	return ret;
+
+	return 0;
 }
 
 void ssusb_wakeup_disable(struct ssusb_mtk *ssusb)
 {
-	if (ssusb->wakeup_en) {
+	if (ssusb->wakeup_en)
 		ssusb_wakeup_ip_sleep_dis(ssusb);
-		ssusb_wakeup_clks_disable(ssusb);
-	}
 }
-- 
1.7.9.5
