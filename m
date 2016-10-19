From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 19 Oct 2016 10:28:22 +0800
Subject: [PATCH v7, 3/8] usb: xhci-mtk: make IPPC register optional
In-Reply-To: <1476844107-31087-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1476844107-31087-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1476844107-31087-4-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make IPPC register optional to support host side of dual-role mode,
due to it is moved into common glue layer for simplification.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c |   38 +++++++++++++++++++++++++++++++-------
 drivers/usb/host/xhci-mtk.h |    1 +
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 79959f1..1094ebd 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -94,6 +94,9 @@ static int xhci_mtk_host_enable(struct xhci_hcd_mtk *mtk)
 	int ret;
 	int i;
 
+	if (!mtk->has_ippc)
+		return 0;
+
 	/* power on host ip */
 	value = readl(&ippc->ip_pw_ctr1);
 	value &= ~CTRL1_IP_HOST_PDN;
@@ -139,6 +142,9 @@ static int xhci_mtk_host_disable(struct xhci_hcd_mtk *mtk)
 	int ret;
 	int i;
 
+	if (!mtk->has_ippc)
+		return 0;
+
 	/* power down all u3 ports */
 	for (i = 0; i < mtk->num_u3_ports; i++) {
 		value = readl(&ippc->u3_ctrl_p[i]);
@@ -173,6 +179,9 @@ static int xhci_mtk_ssusb_config(struct xhci_hcd_mtk *mtk)
 	struct mu3c_ippc_regs __iomem *ippc = mtk->ippc_regs;
 	u32 value;
 
+	if (!mtk->has_ippc)
+		return 0;
+
 	/* reset whole ip */
 	value = readl(&ippc->ip_pw_ctr0);
 	value |= CTRL0_IP_SW_RST;
@@ -475,6 +484,7 @@ static void xhci_mtk_quirks(struct device *dev, struct xhci_hcd *xhci)
 /* called during probe() after chip reset completes */
 static int xhci_mtk_setup(struct usb_hcd *hcd)
 {
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
 	int ret;
 
@@ -482,12 +492,21 @@ static int xhci_mtk_setup(struct usb_hcd *hcd)
 		ret = xhci_mtk_ssusb_config(mtk);
 		if (ret)
 			return ret;
+	}
+
+	ret = xhci_gen_setup(hcd, xhci_mtk_quirks);
+	if (ret)
+		return ret;
+
+	if (usb_hcd_is_primary_hcd(hcd)) {
+		mtk->num_u3_ports = xhci->num_usb3_ports;
+		mtk->num_u2_ports = xhci->num_usb2_ports;
 		ret = xhci_mtk_sch_init(mtk);
 		if (ret)
 			return ret;
 	}
 
-	return xhci_gen_setup(hcd, xhci_mtk_quirks);
+	return ret;
 }
 
 static int xhci_mtk_probe(struct platform_device *pdev)
@@ -586,7 +605,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	mtk->hcd = platform_get_drvdata(pdev);
 	platform_set_drvdata(pdev, mtk);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mac");
 	hcd->regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(hcd->regs)) {
 		ret = PTR_ERR(hcd->regs);
@@ -595,11 +614,16 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	mtk->ippc_regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(mtk->ippc_regs)) {
-		ret = PTR_ERR(mtk->ippc_regs);
-		goto put_usb2_hcd;
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ippc");
+	if (res) {	/* ippc register is optional */
+		mtk->ippc_regs = devm_ioremap_resource(dev, res);
+		if (IS_ERR(mtk->ippc_regs)) {
+			ret = PTR_ERR(mtk->ippc_regs);
+			goto put_usb2_hcd;
+		}
+		mtk->has_ippc = true;
+	} else {
+		mtk->has_ippc = false;
 	}
 
 	for (phy_num = 0; phy_num < mtk->num_phys; phy_num++) {
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index 7da677c..2845c49 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -118,6 +118,7 @@ struct xhci_hcd_mtk {
 	struct usb_hcd *hcd;
 	struct mu3h_sch_bw_info *sch_array;
 	struct mu3c_ippc_regs __iomem *ippc_regs;
+	bool has_ippc;
 	int num_u2_ports;
 	int num_u3_ports;
 	struct regulator *vusb33;
-- 
1.7.9.5
