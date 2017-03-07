From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 7 Mar 2017 15:22:51 +0530
Subject: [PATCH v2 6/7] PCI: dwc: designware: Modify _unroll() to _ob_unroll()
In-Reply-To: <1488880372-7390-1-git-send-email-kishon@ti.com>
References: <1488880372-7390-1-git-send-email-kishon@ti.com>
Message-ID: <1488880372-7390-7-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional change. Rename dw_pcie_writel_unroll/dw_pcie_readl_unroll
to dw_pcie_writel_ob_unroll/dw_pcie_readl_ob_unroll respectively as these
functions are used to perform only outbound configurations. This will
enable to seamlessly add functions for inbound configurations required
for endpoint mode.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pcie-designware.c |   51 ++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
index 557ee53..006afba 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -92,16 +92,16 @@ void dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
 		dev_err(pci->dev, "write DBI address failed\n");
 }
 
-static u32 dw_pcie_readl_unroll(struct dw_pcie *pci, void __iomem *base,
-				u32 index, u32 reg)
+static u32 dw_pcie_readl_ob_unroll(struct dw_pcie *pci, void __iomem *base,
+				   u32 index, u32 reg)
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
 
 	return dw_pcie_read_dbi(pci, base, offset + reg, 0x4);
 }
 
-static void dw_pcie_writel_unroll(struct dw_pcie *pci, void __iomem *base,
-				  u32 index, u32 reg, u32 val)
+static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, void __iomem *base,
+				     u32 index, u32 reg, u32 val)
 {
 	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
 
@@ -118,24 +118,26 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 		cpu_addr = pci->ops->cpu_addr_fixup(cpu_addr);
 
 	if (pci->iatu_unroll_enabled) {
-		dw_pcie_writel_unroll(pci, base, index, PCIE_ATU_UNR_LOWER_BASE,
-				      lower_32_bits(cpu_addr));
-		dw_pcie_writel_unroll(pci, base, index, PCIE_ATU_UNR_UPPER_BASE,
-				      upper_32_bits(cpu_addr));
-		dw_pcie_writel_unroll(pci, base, index, PCIE_ATU_UNR_LIMIT,
-				      lower_32_bits(cpu_addr + size - 1));
-		dw_pcie_writel_unroll(pci, base, index,
-				      PCIE_ATU_UNR_LOWER_TARGET,
-				      lower_32_bits(pci_addr));
-		dw_pcie_writel_unroll(pci, base, index,
-				      PCIE_ATU_UNR_UPPER_TARGET,
-				      upper_32_bits(pci_addr));
-		dw_pcie_writel_unroll(pci, base, index,
-				      PCIE_ATU_UNR_REGION_CTRL1,
-				      type);
-		dw_pcie_writel_unroll(pci, base, index,
-				      PCIE_ATU_UNR_REGION_CTRL2,
-				      PCIE_ATU_ENABLE);
+		dw_pcie_writel_ob_unroll(pci, base, index,
+					 PCIE_ATU_UNR_LOWER_BASE,
+					 lower_32_bits(cpu_addr));
+		dw_pcie_writel_ob_unroll(pci, base, index,
+					 PCIE_ATU_UNR_UPPER_BASE,
+					 upper_32_bits(cpu_addr));
+		dw_pcie_writel_ob_unroll(pci, base, index, PCIE_ATU_UNR_LIMIT,
+					 lower_32_bits(cpu_addr + size - 1));
+		dw_pcie_writel_ob_unroll(pci, base, index,
+					 PCIE_ATU_UNR_LOWER_TARGET,
+					 lower_32_bits(pci_addr));
+		dw_pcie_writel_ob_unroll(pci, base, index,
+					 PCIE_ATU_UNR_UPPER_TARGET,
+					 upper_32_bits(pci_addr));
+		dw_pcie_writel_ob_unroll(pci, base, index,
+					 PCIE_ATU_UNR_REGION_CTRL1,
+					 type);
+		dw_pcie_writel_ob_unroll(pci, base, index,
+					 PCIE_ATU_UNR_REGION_CTRL2,
+					 PCIE_ATU_ENABLE);
 	} else {
 		dw_pcie_write_dbi(pci, base, PCIE_ATU_VIEWPORT, 0x4,
 				  PCIE_ATU_REGION_OUTBOUND | index);
@@ -160,8 +162,9 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 	 */
 	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
 		if (pci->iatu_unroll_enabled)
-			val = dw_pcie_readl_unroll(pci, base, index,
-						   PCIE_ATU_UNR_REGION_CTRL2);
+			val =
+			dw_pcie_readl_ob_unroll(pci, base, index,
+						PCIE_ATU_UNR_REGION_CTRL2);
 		else
 			val = dw_pcie_read_dbi(pci, base, PCIE_ATU_CR2, 0x4);
 
-- 
1.7.9.5
