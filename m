From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 17 Oct 2018 13:11:08 +0530
Subject: [PATCH v2 15/21] PCI: keystone: Cleanup outbound window configuration
In-Reply-To: <20181017074114.28239-1-kishon@ti.com>
References: <20181017074114.28239-1-kishon@ti.com>
Message-ID: <20181017074114.28239-16-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Outbound translation window is configured in order to access the
PCIe card's MEM space. Cleanup outbound translation configuration
here by using BIT() macros, adding a macro for window size and
using lower_32_bits/upper_32_bits macros for configuring the 64 bit
offset in the outbound translation region.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 32 ++++++++++++-----------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 608e40c4b991..3576a184b9eb 100644
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
@@ -53,10 +53,11 @@
 #define CFG_TYPE1			BIT(24)
 
 #define OB_SIZE				0x030
-#define CFG_PCIM_WIN_SZ_IDX		3
 #define SPACE0_REMOTE_CFG_OFFSET	0x1000
 #define OB_OFFSET_INDEX(n)		(0x200 + (8 * (n)))
 #define OB_OFFSET_HI(n)			(0x204 + (8 * (n)))
+#define OB_ENABLEN			BIT(0)
+#define OB_WIN_SIZE			8	/* 8MB */
 
 /* IRQ register defines */
 #define IRQ_EOI				0x050
@@ -341,12 +342,13 @@ static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
 
 static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 {
+	u32 val;
 	u32 num_viewport = ks_pcie->num_viewport;
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct pcie_port *pp = &pci->pp;
-	u32 start = pp->mem->start, end = pp->mem->end;
-	int i, tr_size;
-	u32 val;
+	u64 start = pp->mem->start;
+	u64 end = pp->mem->end;
+	int i;
 
 	/* Disable BARs for inbound access */
 	ks_pcie_set_dbi_mode(ks_pcie);
@@ -354,21 +356,21 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0);
 	ks_pcie_clear_dbi_mode(ks_pcie);
 
-	/* Set outbound translation size per window division */
-	ks_pcie_app_writel(ks_pcie, OB_SIZE, CFG_PCIM_WIN_SZ_IDX & 0x7);
-
-	tr_size = (1 << (CFG_PCIM_WIN_SZ_IDX & 0x7)) * SZ_1M;
+	val = ilog2(OB_WIN_SIZE);
+	ks_pcie_app_writel(ks_pcie, OB_SIZE, val);
 
 	/* Using Direct 1:1 mapping of RC <-> PCI memory space */
-	for (i = 0; (i < num_viewport) && (start < end); i++) {
-		ks_pcie_app_writel(ks_pcie, OB_OFFSET_INDEX(i), start | 1);
-		ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i), 0);
-		start += tr_size;
+	for (i = 0; i < num_viewport && (start < end); i++) {
+		ks_pcie_app_writel(ks_pcie, OB_OFFSET_INDEX(i),
+				   lower_32_bits(start) | OB_ENABLEN);
+		ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i),
+				   upper_32_bits(start));
+		start += OB_WIN_SIZE;
 	}
 
-	/* Enable OB translation */
 	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
-	ks_pcie_app_writel(ks_pcie, CMD_STATUS, OB_XLAT_EN_VAL | val);
+	val |= OB_XLAT_EN_VAL;
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
 }
 
 static int ks_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-- 
2.17.1
