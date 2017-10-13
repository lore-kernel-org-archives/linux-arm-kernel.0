From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 13 Oct 2017 16:26:36 +0800
Subject: [PATCH v2 4/9] usb: xhci-mtk: support option to disable usb3 ports
In-Reply-To: <994382d16d6bdc0f3d7c11b22f1710252e056e34.1507882470.git.chunfeng.yun@mediatek.com>
References: <994382d16d6bdc0f3d7c11b22f1710252e056e34.1507882470.git.chunfeng.yun@mediatek.com>
Message-ID: <c84bf052966ee2845d3a5b676e37cfd54dbc03cf.1507882470.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to disable specific usb3 ports, it's useful when
usb3 phy is shared with PCIe or SATA, because we should disable
the corresponding usb3 port if the phy is used by PCIe or SATA.
Sometimes it's helpful to analyse and solve problems.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c |   18 +++++++++++++++---
 drivers/usb/host/xhci-mtk.h |    1 +
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 7a92bb7..97ba51e 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -92,6 +92,7 @@ static int xhci_mtk_host_enable(struct xhci_hcd_mtk *mtk)
 {
 	struct mu3c_ippc_regs __iomem *ippc = mtk->ippc_regs;
 	u32 value, check_val;
+	int u3_ports_disabed = 0;
 	int ret;
 	int i;
 
@@ -103,8 +104,13 @@ static int xhci_mtk_host_enable(struct xhci_hcd_mtk *mtk)
 	value &= ~CTRL1_IP_HOST_PDN;
 	writel(value, &ippc->ip_pw_ctr1);
 
-	/* power on and enable all u3 ports */
+	/* power on and enable u3 ports except skipped ones */
 	for (i = 0; i < mtk->num_u3_ports; i++) {
+		if ((0x1 << i) & mtk->u3p_dis_msk) {
+			u3_ports_disabed++;
+			continue;
+		}
+
 		value = readl(&ippc->u3_ctrl_p[i]);
 		value &= ~(CTRL_U3_PORT_PDN | CTRL_U3_PORT_DIS);
 		value |= CTRL_U3_PORT_HOST_SEL;
@@ -126,7 +132,7 @@ static int xhci_mtk_host_enable(struct xhci_hcd_mtk *mtk)
 	check_val = STS1_SYSPLL_STABLE | STS1_REF_RST |
 			STS1_SYS125_RST | STS1_XHCI_RST;
 
-	if (mtk->num_u3_ports)
+	if (mtk->num_u3_ports > u3_ports_disabed)
 		check_val |= STS1_U3_MAC_RST;
 
 	ret = readl_poll_timeout(&ippc->ip_pw_sts1, value,
@@ -149,8 +155,11 @@ static int xhci_mtk_host_disable(struct xhci_hcd_mtk *mtk)
 	if (!mtk->has_ippc)
 		return 0;
 
-	/* power down all u3 ports */
+	/* power down u3 ports except skipped ones */
 	for (i = 0; i < mtk->num_u3_ports; i++) {
+		if ((0x1 << i) & mtk->u3p_dis_msk)
+			continue;
+
 		value = readl(&ippc->u3_ctrl_p[i]);
 		value |= CTRL_U3_PORT_PDN;
 		writel(value, &ippc->u3_ctrl_p[i]);
@@ -573,6 +582,9 @@ static int xhci_mtk_probe(struct platform_device *pdev)
 	}
 
 	mtk->lpm_support = of_property_read_bool(node, "usb3-lpm-capable");
+	/* optional property, ignore the error if it does not exist */
+	of_property_read_u32(node, "mediatek,u3p-dis-msk",
+			     &mtk->u3p_dis_msk);
 
 	ret = usb_wakeup_of_property_parse(mtk, node);
 	if (ret)
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index 3aa5e1d..db55a12 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -121,6 +121,7 @@ struct xhci_hcd_mtk {
 	bool has_ippc;
 	int num_u2_ports;
 	int num_u3_ports;
+	int u3p_dis_msk;
 	struct regulator *vusb33;
 	struct regulator *vbus;
 	struct clk *sys_clk;	/* sys and mac clock */
-- 
1.7.9.5
