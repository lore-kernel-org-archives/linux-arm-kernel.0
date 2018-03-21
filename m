From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 21 Mar 2018 14:12:38 +0800
Subject: [usb-next PATCH] usb: xhci: skip phys initialization of shared hcd
Message-ID: <1ece0d5508a00bca67d16e64310a071646b59c7d.1521612280.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The phys has already been initialized when add primary hcd,
including usb2 phys and usb3 phys also if exist, so needn't
re-parse "phys" property again.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c  | 1 +
 drivers/usb/host/xhci-plat.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 7334da9..6bb23fb 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -554,6 +554,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
 		xhci->shared_hcd->can_do_streams = 1;
 
+	xhci->shared_hcd->skip_phy_initialization = 1;
 	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
 	if (ret)
 		goto dealloc_usb2_hcd;
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 6700e5e..65a4294 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -294,6 +294,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
 		xhci->shared_hcd->can_do_streams = 1;
 
+	xhci->shared_hcd->skip_phy_initialization = 1;
 	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
 	if (ret)
 		goto dealloc_usb2_hcd;
-- 
1.9.1
