From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 29 Aug 2018 10:55:13 +0800
Subject: [PATCH 1/6] usb: xhci-mtk: resume USB3 roothub first
Message-ID: <3bcc220aa54bfebc39cea54cd736388ad37ee0c5.1535510898.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Give USB3 devices a better chance to enumerate at USB3 speeds if
they are connected to a suspended host.
Porting from "671ffdf xhci: resume USB 3 roothub first"

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 7334da9..71d0d33 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -642,10 +642,10 @@ static int __maybe_unused xhci_mtk_resume(struct device *dev)
 	xhci_mtk_host_enable(mtk);
 
 	xhci_dbg(xhci, "%s: restart port polling\n", __func__);
-	set_bit(HCD_FLAG_POLL_RH, &hcd->flags);
-	usb_hcd_poll_rh_status(hcd);
 	set_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
 	usb_hcd_poll_rh_status(xhci->shared_hcd);
+	set_bit(HCD_FLAG_POLL_RH, &hcd->flags);
+	usb_hcd_poll_rh_status(hcd);
 	return 0;
 }
 
-- 
1.9.1
