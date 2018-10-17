From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 17 Oct 2018 13:11:12 +0530
Subject: [PATCH v2 19/21] PCI: keystone: Add debug error message for all errors
In-Reply-To: <20181017074114.28239-1-kishon@ti.com>
References: <20181017074114.28239-1-kishon@ti.com>
Message-ID: <20181017074114.28239-20-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 025dd3daeda77f61a280da87ae701 ("PCI: keystone: Add error IRQ
handler") added dev_err() message only for ERR_AXI and ERR_FATAL. Add
debug error message for ERR_SYS, ERR_NONFATAL, ERR_CORR and ERR_AER here.

While at that avoid using ERR_IRQ_STATUS_RAW and use ERR_IRQ_STATUS
instead.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 32 ++++++++++++++++-------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index c0bba7b604fa..e9e646acc2d5 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -79,7 +79,6 @@
 #define ERR_SYS		BIT(0)	/* System (fatal, non-fatal, or correctable) */
 #define ERR_IRQ_ALL	(ERR_AER | ERR_AXI | ERR_CORR | \
 			 ERR_NONFATAL | ERR_FATAL | ERR_SYS)
-#define ERR_FATAL_IRQ	(ERR_FATAL | ERR_AXI)
 #define ERR_IRQ_STATUS			0x1c4
 #define ERR_IRQ_ENABLE_SET		0x1c8
 #define ERR_IRQ_ENABLE_CLR		0x1cc
@@ -246,18 +245,33 @@ static void ks_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
 
 static irqreturn_t ks_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
 {
-	u32 status;
+	u32 reg;
+	struct device *dev = ks_pcie->pci->dev;
 
-	status = ks_pcie_app_readl(ks_pcie, ERR_IRQ_STATUS);
-	if (!status)
+	reg = ks_pcie_app_readl(ks_pcie, ERR_IRQ_STATUS);
+	if (!reg)
 		return IRQ_NONE;
 
-	if (status & ERR_FATAL_IRQ)
-		dev_err(ks_pcie->pci->dev, "fatal error (status %#010x)\n",
-			status);
+	if (reg & ERR_SYS)
+		dev_err(dev, "System Error\n");
+
+	if (reg & ERR_FATAL)
+		dev_err(dev, "Fatal Error\n");
+
+	if (reg & ERR_NONFATAL)
+		dev_dbg(dev, "Non Fatal Error\n");
+
+	if (reg & ERR_CORR)
+		dev_dbg(dev, "Correctable Error\n");
+
+	if (reg & ERR_AXI)
+		dev_err(dev, "AXI tag lookup fatal Error\n");
+
+	if (reg & ERR_AER)
+		dev_err(dev, "ECRC Error\n");
+
+	ks_pcie_app_writel(ks_pcie, ERR_IRQ_STATUS, reg);
 
-	/* Ack the IRQ; status bits are RW1C */
-	ks_pcie_app_writel(ks_pcie, ERR_IRQ_STATUS, status);
 	return IRQ_HANDLED;
 }
 
-- 
2.17.1
