From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 4 Dec 2015 10:40:07 +0800
Subject: [PATCH] usb: xhci-mtk: fix AHB bus hang up caused by roothubs polling
Message-ID: <1449196807-31785-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when ip fail to enter sleep mode, register access protection will
be disabed, at the same time if all clocks are disabled, access
register will hang up AHB bus.
the common case causes ip sleep fail is that after all ports enter
U3 but before ip enters sleep mode, a port receives a resume
signal('K'). this will happens when such as clicks mouse to try to
do remote wakeup to stop system enter suspend.
so stop polling roothubs to avoid access xHCI register on bus
suspend, and restart it when bus resume.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index c9ab6a4..38635fb 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -696,9 +696,24 @@ static int xhci_mtk_remove(struct platform_device *dev)
 }
 
 #ifdef CONFIG_PM_SLEEP
+/*
+ * if ip sleep fail, and all clocks are disabled, access register will hang
+ * AHB bus, so stop poll roothubs to avoid regs access on bus suspend.
+ * and no need to check whether ip sleep fail or not; this will cause SPM to
+ * wakeup system immediately after system suspend complete if ip sleep
+ * fail, it is what we wanted.
+ */
 static int xhci_mtk_suspend(struct device *dev)
 {
 	struct xhci_hcd_mtk *mtk = dev_get_drvdata(dev);
+	struct usb_hcd *hcd = mtk->hcd;
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+
+	xhci_dbg(xhci, "%s: stop port polling\n", __func__);
+	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
+	del_timer_sync(&hcd->rh_timer);
+	clear_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
+	del_timer_sync(&xhci->shared_hcd->rh_timer);
 
 	xhci_mtk_host_disable(mtk);
 	xhci_mtk_phy_power_off(mtk);
@@ -710,11 +725,19 @@ static int xhci_mtk_suspend(struct device *dev)
 static int xhci_mtk_resume(struct device *dev)
 {
 	struct xhci_hcd_mtk *mtk = dev_get_drvdata(dev);
+	struct usb_hcd *hcd = mtk->hcd;
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 
 	usb_wakeup_disable(mtk);
 	xhci_mtk_clks_enable(mtk);
 	xhci_mtk_phy_power_on(mtk);
 	xhci_mtk_host_enable(mtk);
+
+	xhci_dbg(xhci, "%s: restart port polling\n", __func__);
+	set_bit(HCD_FLAG_POLL_RH, &hcd->flags);
+	usb_hcd_poll_rh_status(hcd);
+	set_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
+	usb_hcd_poll_rh_status(xhci->shared_hcd);
 	return 0;
 }
 
-- 
1.8.1.1.dirty
