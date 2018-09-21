From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:36 +0530
Subject: [RFC PATCH 21/40] PCI: keystone: Add debug error message for all
 errors
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-22-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 025dd3daeda77f61a280da87ae701 ("PCI: keystone: Add error IRQ
handler") added dev_err() message only for ERR_AXI and ERR_FATAL. Add
debug error message for ERR_SYS, ERR_NONFATAL, ERR_CORR and ERR_AER here.

While at that avoid using ERR_IRQ_STATUS_RAW and use ERR_IRQ_STATUS
instead.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 45 +++++++++++++----------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 240c39c58b0f..a3dec74da70c 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -74,8 +74,6 @@
 #define ERR_SYS		BIT(0)	/* System (fatal, non-fatal, or correctable) */
 #define ERR_IRQ_ALL	(ERR_AER | ERR_AXI | ERR_CORR | \
 			 ERR_NONFATAL | ERR_FATAL | ERR_SYS)
-#define ERR_FATAL_IRQ	(ERR_FATAL | ERR_AXI)
-#define ERR_IRQ_STATUS_RAW		0x1c0
 #define ERR_IRQ_STATUS			0x1c4
 #define ERR_IRQ_ENABLE_SET		0x1c8
 #define ERR_IRQ_ENABLE_CLR		0x1cc
@@ -180,23 +178,6 @@ static void ks_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
 	ks_pcie_app_writel(ks_pcie, ERR_IRQ_ENABLE_SET, ERR_IRQ_ALL);
 }
 
-static irqreturn_t ks_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
-{
-	u32 status;
-
-	status = ks_pcie_app_readl(ks_pcie, ERR_IRQ_STATUS_RAW) & ERR_IRQ_ALL;
-	if (!status)
-		return IRQ_NONE;
-
-	if (status & ERR_FATAL_IRQ)
-		dev_err(ks_pcie->pci->dev, "fatal error (status %#010x)\n",
-			status);
-
-	/* Ack the IRQ; status bits are RW1C */
-	ks_pcie_app_writel(ks_pcie, ERR_IRQ_STATUS, status);
-	return IRQ_HANDLED;
-}
-
 /**
  * ks_pcie_set_dbi_mode() - Set DBI mode to access overlaid BAR mask
  * registers
@@ -636,9 +617,33 @@ static const struct dw_pcie_host_ops ks_pcie_host_ops = {
 
 static irqreturn_t ks_pcie_err_irq_handler(int irq, void *priv)
 {
+	u32 reg;
 	struct keystone_pcie *ks_pcie = priv;
+	struct device *dev = ks_pcie->pci->dev;
 
-	return ks_pcie_handle_error_irq(ks_pcie);
+	reg = ks_pcie_app_readl(ks_pcie, ERR_IRQ_STATUS);
+
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
+
+	return IRQ_HANDLED;
 }
 
 static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
-- 
2.17.1
