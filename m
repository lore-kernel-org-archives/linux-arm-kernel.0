From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 17 Oct 2018 13:11:07 +0530
Subject: [PATCH v2 14/21] PCI: keystone: Get number of outbound windows from DT
In-Reply-To: <20181017074114.28239-1-kishon@ti.com>
References: <20181017074114.28239-1-kishon@ti.com>
Message-ID: <20181017074114.28239-15-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of having a fixed outbound window count, get the number of
outbound windows from device tree.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 1f14de0ef27f..608e40c4b991 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -54,7 +54,6 @@
 
 #define OB_SIZE				0x030
 #define CFG_PCIM_WIN_SZ_IDX		3
-#define CFG_PCIM_WIN_CNT		32
 #define SPACE0_REMOTE_CFG_OFFSET	0x1000
 #define OB_OFFSET_INDEX(n)		(0x200 + (8 * (n)))
 #define OB_OFFSET_HI(n)			(0x204 + (8 * (n)))
@@ -111,6 +110,7 @@ struct keystone_pcie {
 	int			num_msi_host_irqs;
 	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
 	int			num_lanes;
+	u32			num_viewport;
 	struct phy		**phy;
 	struct device_link	**link;
 	struct			device_node *msi_intc_np;
@@ -341,6 +341,7 @@ static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
 
 static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 {
+	u32 num_viewport = ks_pcie->num_viewport;
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct pcie_port *pp = &pci->pp;
 	u32 start = pp->mem->start, end = pp->mem->end;
@@ -359,7 +360,7 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 	tr_size = (1 << (CFG_PCIM_WIN_SZ_IDX & 0x7)) * SZ_1M;
 
 	/* Using Direct 1:1 mapping of RC <-> PCI memory space */
-	for (i = 0; (i < CFG_PCIM_WIN_CNT) && (start < end); i++) {
+	for (i = 0; (i < num_viewport) && (start < end); i++) {
 		ks_pcie_app_writel(ks_pcie, OB_OFFSET_INDEX(i), start | 1);
 		ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i), 0);
 		start += tr_size;
@@ -898,6 +899,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
 	struct device_link **link;
+	u32 num_viewport;
 	struct phy **phy;
 	u32 num_lanes;
 	char name[10];
@@ -915,6 +917,12 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &ks_pcie_dw_pcie_ops;
 
+	ret = of_property_read_u32(np, "num-viewport", &num_viewport);
+	if (ret < 0) {
+		dev_err(dev, "unable to read *num-viewport* property\n");
+		return ret;
+	}
+
 	ret = of_property_read_u32(np, "num-lanes", &num_lanes);
 	if (ret)
 		num_lanes = 1;
@@ -949,6 +957,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	ks_pcie->pci = pci;
 	ks_pcie->link = link;
 	ks_pcie->num_lanes = num_lanes;
+	ks_pcie->num_viewport = num_viewport;
 	ks_pcie->phy = phy;
 
 	ret = ks_pcie_enable_phy(ks_pcie);
-- 
2.17.1
