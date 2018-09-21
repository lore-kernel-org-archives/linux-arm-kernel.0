From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:33 +0530
Subject: [RFC PATCH 18/40] PCI: keystone: Get number of OB windows from DT and
 cleanup MEM space configuration
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-19-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of having a fixed outbound window count, get the number of
outbound windows from device tree. Also cleanup memory space configuration
here by adding macros for constants.

While at that also use BIT() macro for OB_XLAT_EN_VAL.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 86 +++++++++++++----------
 1 file changed, 49 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 3ead1162235f..d5304c4a1eb5 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -41,7 +41,7 @@
 #define LTSSM_STATE_MASK		0x1f
 #define LTSSM_STATE_L0			0x11
 #define DBI_CS2_EN_VAL			0x20
-#define OB_XLAT_EN_VAL		        2
+#define OB_XLAT_EN_VAL		        BIT(1)
 
 /* Application registers */
 #define CMD_STATUS			0x004
@@ -53,10 +53,7 @@
 #define CFG_TYPE1			BIT(24)
 
 #define OB_SIZE				0x030
-#define CFG_PCIM_WIN_SZ_IDX		3
-#define CFG_PCIM_WIN_CNT		32
-#define OB_OFFSET_INDEX(n)		(0x200 + (8 * n))
-#define OB_OFFSET_HI(n)			(0x204 + (8 * n))
+#define OB_WIN_SIZE			8	/* 8MB */
 
 /* IRQ register defines */
 #define IRQ_EOI				0x050
@@ -85,6 +82,11 @@
 #define ERR_IRQ_ENABLE_SET		0x1c8
 #define ERR_IRQ_ENABLE_CLR		0x1cc
 
+#define OB_OFFSET_INDEX(n)		(0x200 + (8 * (n)))
+#define OB_ENABLEN			BIT(0)
+
+#define OB_OFFSET_HI(n)			(0x204 + (8 * (n)))
+
 /* Config space registers */
 #define DEBUG0				0x728
 
@@ -102,6 +104,7 @@ static void ks_pcie_stop_link(struct dw_pcie *pci);
 struct keystone_pcie {
 	struct dw_pcie		*pci;
 	int			num_lanes;
+	u32			num_viewport;
 	struct phy		**phy;
 	struct device_link	**link;
 	int			msi_host_irq;
@@ -236,37 +239,6 @@ static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
 	} while (val & DBI_CS2_EN_VAL);
 }
 
-static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
-{
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
-	u32 start = pp->mem->start, end = pp->mem->end;
-	int i, tr_size;
-	u32 val;
-
-	/* Disable BARs for inbound access */
-	ks_pcie_set_dbi_mode(ks_pcie);
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
-	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0);
-	ks_pcie_clear_dbi_mode(ks_pcie);
-
-	/* Set outbound translation size per window division */
-	ks_pcie_app_writel(ks_pcie, OB_SIZE, CFG_PCIM_WIN_SZ_IDX & 0x7);
-
-	tr_size = (1 << (CFG_PCIM_WIN_SZ_IDX & 0x7)) * SZ_1M;
-
-	/* Using Direct 1:1 mapping of RC <-> PCI memory space */
-	for (i = 0; (i < CFG_PCIM_WIN_CNT) && (start < end); i++) {
-		ks_pcie_app_writel(ks_pcie, OB_OFFSET_INDEX(i), start | 1);
-		ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i), 0);
-		start += tr_size;
-	}
-
-	/* Enable OB translation */
-	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
-	ks_pcie_app_writel(ks_pcie, CMD_STATUS, OB_XLAT_EN_VAL | val);
-}
-
 static int ks_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 				 unsigned int devfn, int where, int size,
 				 u32 *val)
@@ -562,6 +534,33 @@ static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
 	return 0;
 }
 
+static void ks_pcie_setup_mem_space(struct keystone_pcie *ks_pcie)
+{
+	u32 val;
+	u32 num_viewport = ks_pcie->num_viewport;
+	struct dw_pcie *pci = ks_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	u64 start = pp->mem->start;
+	u64 end = pp->mem->end;
+	int i;
+
+	val = ilog2(OB_WIN_SIZE);
+	ks_pcie_app_writel(ks_pcie, OB_SIZE, val);
+
+	/* Using Direct 1:1 mapping of RC <-> PCI memory space */
+	for (i = 0; i < num_viewport && (start < end); i++) {
+		ks_pcie_app_writel(ks_pcie, OB_OFFSET_INDEX(i),
+				   lower_32_bits(start) | OB_ENABLEN);
+		ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i),
+				   upper_32_bits(start));
+		start += OB_WIN_SIZE;
+	}
+
+	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
+	val |= OB_XLAT_EN_VAL;
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
+}
+
 static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
 {
 	int ret;
@@ -601,7 +600,12 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 
-	ks_pcie_setup_rc_app_regs(ks_pcie);
+	ks_pcie_set_dbi_mode(ks_pcie);
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0);
+	ks_pcie_clear_dbi_mode(ks_pcie);
+
+	ks_pcie_setup_mem_space(ks_pcie);
 	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
 			pci->dbi_base + PCI_IO_BASE);
 
@@ -770,6 +774,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
 	struct device_link **link;
+	u32 num_viewport;
 	struct phy **phy;
 	u32 num_lanes;
 	char name[10];
@@ -788,6 +793,12 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
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
@@ -831,6 +842,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	ks_pcie->link = link;
 	ks_pcie->np = np;
 	ks_pcie->num_lanes = num_lanes;
+	ks_pcie->num_viewport = num_viewport;
 	ks_pcie->phy = phy;
 
 	irq = platform_get_irq(pdev, 0);
-- 
2.17.1
