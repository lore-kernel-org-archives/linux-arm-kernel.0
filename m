From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:25 +0530
Subject: [RFC PATCH 10/40] PCI: keystone: Use uniform function naming
 convention
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-11-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional change. Some function names begin with ks_dw_pcie_*
and some function names begin with ks_pcie_*. Modify it so that
all function names begin with ks_pcie_*.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 267 ++++++++++------------
 1 file changed, 120 insertions(+), 147 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index c54d18ea263a..e19ba065ebd5 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -104,7 +104,7 @@ struct keystone_pcie {
 	struct resource		app;
 };
 
-static phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp)
+static phys_addr_t ks_pcie_get_msi_addr(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
@@ -112,17 +112,18 @@ static phys_addr_t ks_dw_pcie_get_msi_addr(struct pcie_port *pp)
 	return ks_pcie->app.start + MSI_IRQ;
 }
 
-static u32 ks_dw_app_readl(struct keystone_pcie *ks_pcie, u32 offset)
+static u32 ks_pcie_app_readl(struct keystone_pcie *ks_pcie, u32 offset)
 {
 	return readl(ks_pcie->va_app_base + offset);
 }
 
-static void ks_dw_app_writel(struct keystone_pcie *ks_pcie, u32 offset, u32 val)
+static void ks_pcie_app_writel(struct keystone_pcie *ks_pcie, u32 offset,
+			       u32 val)
 {
 	writel(val, ks_pcie->va_app_base + offset);
 }
 
-static void ks_dw_pcie_msi_irq_ack(int irq, struct pcie_port *pp)
+static void ks_pcie_msi_irq_ack(int irq, struct pcie_port *pp)
 {
 	u32 reg_offset, bit_pos;
 	struct keystone_pcie *ks_pcie;
@@ -133,11 +134,11 @@ static void ks_dw_pcie_msi_irq_ack(int irq, struct pcie_port *pp)
 
 	reg_offset = irq % 8;
 	bit_pos = irq >> 3;
-	ks_dw_app_writel(ks_pcie, MSI_IRQ_STATUS(reg_offset), BIT(bit_pos));
-	ks_dw_app_writel(ks_pcie, IRQ_EOI, MSI_IRQ_OFFSET + reg_offset);
+	ks_pcie_app_writel(ks_pcie, MSI_IRQ_STATUS(reg_offset), BIT(bit_pos));
+	ks_pcie_app_writel(ks_pcie, IRQ_EOI, MSI_IRQ_OFFSET + reg_offset);
 }
 
-static void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
+static void ks_pcie_msi_set_irq(struct pcie_port *pp, int irq)
 {
 	u32 reg_offset, bit_pos;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -145,11 +146,11 @@ static void ks_dw_pcie_msi_set_irq(struct pcie_port *pp, int irq)
 
 	reg_offset = irq % 8;
 	bit_pos = irq >> 3;
-	ks_dw_app_writel(ks_pcie, MSI_IRQ_ENABLE_SET(reg_offset),
-			 BIT(bit_pos));
+	ks_pcie_app_writel(ks_pcie, MSI_IRQ_ENABLE_SET(reg_offset),
+			   BIT(bit_pos));
 }
 
-static void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
+static void ks_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 {
 	u32 reg_offset, bit_pos;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -157,25 +158,25 @@ static void ks_dw_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 
 	reg_offset = irq % 8;
 	bit_pos = irq >> 3;
-	ks_dw_app_writel(ks_pcie, MSI_IRQ_ENABLE_CLR(reg_offset),
-			 BIT(bit_pos));
+	ks_pcie_app_writel(ks_pcie, MSI_IRQ_ENABLE_CLR(reg_offset),
+			   BIT(bit_pos));
 }
 
-static int ks_dw_pcie_msi_host_init(struct pcie_port *pp)
+static int ks_pcie_msi_host_init(struct pcie_port *pp)
 {
 	return dw_pcie_allocate_domains(pp);
 }
 
-static void ks_dw_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
+static void ks_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
 {
-	ks_dw_app_writel(ks_pcie, ERR_IRQ_ENABLE_SET, ERR_IRQ_ALL);
+	ks_pcie_app_writel(ks_pcie, ERR_IRQ_ENABLE_SET, ERR_IRQ_ALL);
 }
 
-static irqreturn_t ks_dw_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
+static irqreturn_t ks_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
 {
 	u32 status;
 
-	status = ks_dw_app_readl(ks_pcie, ERR_IRQ_STATUS_RAW) & ERR_IRQ_ALL;
+	status = ks_pcie_app_readl(ks_pcie, ERR_IRQ_STATUS_RAW) & ERR_IRQ_ALL;
 	if (!status)
 		return IRQ_NONE;
 
@@ -184,48 +185,48 @@ static irqreturn_t ks_dw_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
 			status);
 
 	/* Ack the IRQ; status bits are RW1C */
-	ks_dw_app_writel(ks_pcie, ERR_IRQ_STATUS, status);
+	ks_pcie_app_writel(ks_pcie, ERR_IRQ_STATUS, status);
 	return IRQ_HANDLED;
 }
 
 /**
- * ks_dw_pcie_set_dbi_mode() - Set DBI mode to access overlaid BAR mask
+ * ks_pcie_set_dbi_mode() - Set DBI mode to access overlaid BAR mask
  * registers
  *
  * Since modification of dbi_cs2 involves different clock domain, read the
  * status back to ensure the transition is complete.
  */
-static void ks_dw_pcie_set_dbi_mode(struct keystone_pcie *ks_pcie)
+static void ks_pcie_set_dbi_mode(struct keystone_pcie *ks_pcie)
 {
 	u32 val;
 
-	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
-	ks_dw_app_writel(ks_pcie, CMD_STATUS, DBI_CS2_EN_VAL | val);
+	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, DBI_CS2_EN_VAL | val);
 
 	do {
-		val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
+		val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
 	} while (!(val & DBI_CS2_EN_VAL));
 }
 
 /**
- * ks_dw_pcie_clear_dbi_mode() - Disable DBI mode
+ * ks_pcie_clear_dbi_mode() - Disable DBI mode
  *
  * Since modification of dbi_cs2 involves different clock domain, read the
  * status back to ensure the transition is complete.
  */
-static void ks_dw_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
+static void ks_pcie_clear_dbi_mode(struct keystone_pcie *ks_pcie)
 {
 	u32 val;
 
-	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
-	ks_dw_app_writel(ks_pcie, CMD_STATUS, ~DBI_CS2_EN_VAL & val);
+	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, ~DBI_CS2_EN_VAL & val);
 
 	do {
-		val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
+		val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
 	} while (val & DBI_CS2_EN_VAL);
 }
 
-static void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
+static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 {
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct pcie_port *pp = &pci->pp;
@@ -234,26 +235,26 @@ static void ks_dw_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 	u32 val;
 
 	/* Disable BARs for inbound access */
-	ks_dw_pcie_set_dbi_mode(ks_pcie);
+	ks_pcie_set_dbi_mode(ks_pcie);
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0);
-	ks_dw_pcie_clear_dbi_mode(ks_pcie);
+	ks_pcie_clear_dbi_mode(ks_pcie);
 
 	/* Set outbound translation size per window division */
-	ks_dw_app_writel(ks_pcie, OB_SIZE, CFG_PCIM_WIN_SZ_IDX & 0x7);
+	ks_pcie_app_writel(ks_pcie, OB_SIZE, CFG_PCIM_WIN_SZ_IDX & 0x7);
 
 	tr_size = (1 << (CFG_PCIM_WIN_SZ_IDX & 0x7)) * SZ_1M;
 
 	/* Using Direct 1:1 mapping of RC <-> PCI memory space */
 	for (i = 0; (i < CFG_PCIM_WIN_CNT) && (start < end); i++) {
-		ks_dw_app_writel(ks_pcie, OB_OFFSET_INDEX(i), start | 1);
-		ks_dw_app_writel(ks_pcie, OB_OFFSET_HI(i), 0);
+		ks_pcie_app_writel(ks_pcie, OB_OFFSET_INDEX(i), start | 1);
+		ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i), 0);
 		start += tr_size;
 	}
 
 	/* Enable OB translation */
-	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
-	ks_dw_app_writel(ks_pcie, CMD_STATUS, OB_XLAT_EN_VAL | val);
+	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, OB_XLAT_EN_VAL | val);
 }
 
 /**
@@ -294,13 +295,13 @@ static void __iomem *ks_pcie_cfg_setup(struct keystone_pcie *ks_pcie, u8 bus,
 	if (bus != 1)
 		regval |= BIT(24);
 
-	ks_dw_app_writel(ks_pcie, CFG_SETUP, regval);
+	ks_pcie_app_writel(ks_pcie, CFG_SETUP, regval);
 	return pp->va_cfg0_base;
 }
 
-static int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-				    unsigned int devfn, int where, int size,
-				    u32 *val)
+static int ks_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
+				 unsigned int devfn, int where, int size,
+				 u32 *val)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
@@ -312,9 +313,9 @@ static int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	return dw_pcie_read(addr + where, size, val);
 }
 
-static int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-				    unsigned int devfn, int where, int size,
-				    u32 val)
+static int ks_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
+				 unsigned int devfn, int where, int size,
+				 u32 val)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
@@ -327,23 +328,23 @@ static int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 }
 
 /**
- * ks_dw_pcie_v3_65_scan_bus() - keystone scan_bus post initialization
+ * ks_pcie_v3_65_scan_bus() - keystone scan_bus post initialization
  *
  * This sets BAR0 to enable inbound access for MSI_IRQ register
  */
-static void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
+static void ks_pcie_v3_65_scan_bus(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
 	/* Configure and set up BAR0 */
-	ks_dw_pcie_set_dbi_mode(ks_pcie);
+	ks_pcie_set_dbi_mode(ks_pcie);
 
 	/* Enable BAR0 */
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 1);
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, SZ_4K - 1);
 
-	ks_dw_pcie_clear_dbi_mode(ks_pcie);
+	ks_pcie_clear_dbi_mode(ks_pcie);
 
 	 /*
 	  * For BAR0, just setting bus address for inbound writes (MSI) should
@@ -353,9 +354,9 @@ static void ks_dw_pcie_v3_65_scan_bus(struct pcie_port *pp)
 }
 
 /**
- * ks_dw_pcie_link_up() - Check if link up
+ * ks_pcie_link_up() - Check if link up
  */
-static int ks_dw_pcie_link_up(struct dw_pcie *pci)
+static int ks_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 val;
 
@@ -363,65 +364,7 @@ static int ks_dw_pcie_link_up(struct dw_pcie *pci)
 	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
 }
 
-static void ks_dw_pcie_stop_link(struct keystone_pcie *ks_pcie)
-{
-	u32 val;
-
-	/* Disable Link training */
-	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
-	val &= ~LTSSM_EN_VAL;
-	ks_dw_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
-}
-
-static void ks_dw_pcie_start_link(struct keystone_pcie *ks_pcie)
-{
-	u32 val;
-
-	/* Initiate Link Training */
-	val = ks_dw_app_readl(ks_pcie, CMD_STATUS);
-	ks_dw_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
-}
-
-/**
- * ks_dw_pcie_host_init() - initialize host for v3_65 dw hardware
- *
- * Ioremap the register resources, initialize legacy irq domain
- * and call dw_pcie_v3_65_host_init() API to initialize the Keystone
- * PCI host controller.
- */
-static int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie)
-{
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
-	struct device *dev = pci->dev;
-	struct platform_device *pdev = to_platform_device(dev);
-	struct resource *res;
-
-	/* Index 0 is the config reg. space address */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pci->dbi_base))
-		return PTR_ERR(pci->dbi_base);
-
-	/*
-	 * We set these same and is used in pcie rd/wr_other_conf
-	 * functions
-	 */
-	pp->va_cfg0_base = pci->dbi_base + SPACE0_REMOTE_CFG_OFFSET;
-	pp->va_cfg1_base = pp->va_cfg0_base;
-
-	/* Index 1 is the application reg. space address */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(ks_pcie->va_app_base))
-		return PTR_ERR(ks_pcie->va_app_base);
-
-	ks_pcie->app = *res;
-
-	return dw_pcie_host_init(pp);
-}
-
-static void quirk_limit_mrrs(struct pci_dev *dev)
+static void ks_pcie_quirk(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
 	struct pci_dev *bridge;
@@ -462,7 +405,7 @@ static void quirk_limit_mrrs(struct pci_dev *dev)
 		}
 	}
 }
-DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, quirk_limit_mrrs);
+DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, ks_pcie_quirk);
 
 static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 {
@@ -480,7 +423,7 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	reg = ks_dw_app_readl(ks_pcie, MSI_IRQ_STATUS(offset));
+	reg = ks_pcie_app_readl(ks_pcie, MSI_IRQ_STATUS(offset));
 	for (pos = 0; pos < 4; pos++) {
 		if (!(reg & BIT(pos)))
 			continue;
@@ -514,14 +457,14 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	for (i = 0; i < PCI_NUM_INTX; i++) {
-		reg = ks_dw_app_readl(ks_pcie, IRQ_STATUS(i));
+		reg = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(i));
 		if (!(reg & INTx_EN))
 			continue;
 
 		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, i);
 		generic_handle_irq(virq);
-		ks_dw_app_writel(ks_pcie, IRQ_STATUS(i), INTx_EN);
-		ks_dw_app_writel(ks_pcie, IRQ_EOI, i);
+		ks_pcie_app_writel(ks_pcie, IRQ_STATUS(i), INTx_EN);
+		ks_pcie_app_writel(ks_pcie, IRQ_EOI, i);
 	}
 
 	chained_irq_exit(chip, desc);
@@ -620,7 +563,7 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
 	ks_pcie->legacy_irq_domain = legacy_irq_domain;
 
 	for (i = 0; i < PCI_NUM_INTX; i++)
-		ks_dw_app_writel(ks_pcie, IRQ_ENABLE_SET(i), INTx_EN);
+		ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET(i), INTx_EN);
 
 	return 0;
 }
@@ -630,8 +573,8 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
  * bus error instead of returning 0xffffffff. This handler always returns 0
  * for this kind of faults.
  */
-static int keystone_pcie_fault(unsigned long addr, unsigned int fsr,
-				struct pt_regs *regs)
+static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
+			 struct pt_regs *regs)
 {
 	unsigned long instr = *(unsigned long *) instruction_pointer(regs);
 
@@ -661,7 +604,7 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 
-	ks_dw_pcie_setup_rc_app_regs(ks_pcie);
+	ks_pcie_setup_rc_app_regs(ks_pcie);
 	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
 			pci->dbi_base + PCI_IO_BASE);
 
@@ -672,46 +615,69 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	 * PCIe access errors that result into OCP errors are caught by ARM as
 	 * "External aborts"
 	 */
-	hook_fault_code(17, keystone_pcie_fault, SIGBUS, 0,
+	hook_fault_code(17, ks_pcie_fault, SIGBUS, 0,
 			"Asynchronous external abort");
 
 	ks_pcie_start_link(pci);
 	return dw_pcie_wait_for_link(pci);
 }
 
-static const struct dw_pcie_host_ops keystone_pcie_host_ops = {
-	.rd_other_conf = ks_dw_pcie_rd_other_conf,
-	.wr_other_conf = ks_dw_pcie_wr_other_conf,
+static const struct dw_pcie_host_ops ks_pcie_host_ops = {
+	.rd_other_conf = ks_pcie_rd_other_conf,
+	.wr_other_conf = ks_pcie_wr_other_conf,
 	.host_init = ks_pcie_host_init,
-	.msi_set_irq = ks_dw_pcie_msi_set_irq,
-	.msi_clear_irq = ks_dw_pcie_msi_clear_irq,
-	.get_msi_addr = ks_dw_pcie_get_msi_addr,
-	.msi_host_init = ks_dw_pcie_msi_host_init,
-	.msi_irq_ack = ks_dw_pcie_msi_irq_ack,
-	.scan_bus = ks_dw_pcie_v3_65_scan_bus,
+	.msi_set_irq = ks_pcie_msi_set_irq,
+	.msi_clear_irq = ks_pcie_msi_clear_irq,
+	.get_msi_addr = ks_pcie_get_msi_addr,
+	.msi_host_init = ks_pcie_msi_host_init,
+	.msi_irq_ack = ks_pcie_msi_irq_ack,
+	.scan_bus = ks_pcie_v3_65_scan_bus,
 };
 
-static irqreturn_t pcie_err_irq_handler(int irq, void *priv)
+static irqreturn_t ks_pcie_err_irq_handler(int irq, void *priv)
 {
 	struct keystone_pcie *ks_pcie = priv;
 
-	return ks_dw_pcie_handle_error_irq(ks_pcie);
+	return ks_pcie_handle_error_irq(ks_pcie);
 }
 
-static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
-			 struct platform_device *pdev)
+static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
+					struct platform_device *pdev)
 {
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct pcie_port *pp = &pci->pp;
 	struct device *dev = &pdev->dev;
+	struct resource *res;
 	int ret;
 
-	pp->ops = &keystone_pcie_host_ops;
-	ret = ks_dw_pcie_host_init(ks_pcie);
+	/* Index 0 is the config reg. space address */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
+
+	/*
+	 * We set these same and is used in pcie rd/wr_other_conf
+	 * functions
+	 */
+	pp->va_cfg0_base = pci->dbi_base + SPACE0_REMOTE_CFG_OFFSET;
+	pp->va_cfg1_base = pp->va_cfg0_base;
+
+	/* Index 1 is the application reg. space address */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ks_pcie->va_app_base))
+		return PTR_ERR(ks_pcie->va_app_base);
+
+	ks_pcie->app = *res;
+
+	pp->ops = &ks_pcie_host_ops;
+	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "failed to initialize host\n");
 		return ret;
 	}
+
 	return 0;
 }
 
@@ -723,8 +689,20 @@ static const struct of_device_id ks_pcie_of_match[] = {
 	{ },
 };
 
+static void ks_pcie_stop_link(struct dw_pcie *pci)
+{
+	u32 val;
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+
+	/* Disable Link training */
+	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
+	val &= ~LTSSM_EN_VAL;
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
+}
+
 static int ks_pcie_start_link(struct dw_pcie *pci)
 {
+	u32 val;
 	struct device *dev = pci->dev;
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
@@ -733,22 +711,17 @@ static int ks_pcie_start_link(struct dw_pcie *pci)
 		return 0;
 	}
 
-	ks_dw_pcie_start_link(ks_pcie);
+	/* Initiate Link Training */
+	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
 
 	return 0;
 }
 
-static void ks_pcie_stop_link(struct dw_pcie *pci)
-{
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-
-	ks_dw_pcie_stop_link(ks_pcie);
-}
-
-static const struct dw_pcie_ops dw_pcie_ops = {
+static const struct dw_pcie_ops ks_pcie_dw_pcie_ops = {
 	.start_link = ks_pcie_start_link,
 	.stop_link = ks_pcie_stop_link,
-	.link_up = ks_dw_pcie_link_up,
+	.link_up = ks_pcie_link_up,
 };
 
 static int __exit ks_pcie_remove(struct platform_device *pdev)
@@ -780,7 +753,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pci->dev = dev;
-	pci->ops = &dw_pcie_ops;
+	pci->ops = &ks_pcie_dw_pcie_ops;
 
 	ks_pcie->pci = pci;
 
@@ -812,7 +785,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		return irq;
 	}
 
-	ret = devm_request_irq(dev, irq, pcie_err_irq_handler, IRQF_SHARED,
+	ret = devm_request_irq(dev, irq, ks_pcie_err_irq_handler, IRQF_SHARED,
 			       "ks-pcie-error-irq", ks_pcie);
 	if (ret < 0) {
 		dev_err(dev, "failed to request error IRQ %d\n", irq);
@@ -829,11 +802,11 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = ks_add_pcie_port(ks_pcie, pdev);
+	ret = ks_pcie_add_pcie_port(ks_pcie, pdev);
 	if (ret < 0)
 		goto fail_clk;
 
-	ks_dw_pcie_enable_error_irq(ks_pcie);
+	ks_pcie_enable_error_irq(ks_pcie);
 
 	return 0;
 fail_clk:
-- 
2.17.1
