From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Tue, 6 Nov 2018 13:21:25 +0000
Subject: [PATCH 22/23] PCI: mobiveil: add PCIe RC driver for NXP LX series SoCs
In-Reply-To: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20181106131807.29951-23-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This PCIe controller is based on the Mobiveil GPEX IP, which is
compatible with the PCI Express? Base Specification, Revision 4.0.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/mobiveil/Kconfig       |  10 +
 drivers/pci/controller/mobiveil/Makefile      |   1 +
 drivers/pci/controller/mobiveil/pci-lx.c      | 222 ++++++++++++++++++
 .../controller/mobiveil/pcie-mobiveil-host.c  |   5 +-
 .../pci/controller/mobiveil/pcie-mobiveil.h   |  15 +-
 5 files changed, 249 insertions(+), 4 deletions(-)
 create mode 100644 drivers/pci/controller/mobiveil/pci-lx.c

diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
index 64343c07bfed..1025448f6d0c 100644
--- a/drivers/pci/controller/mobiveil/Kconfig
+++ b/drivers/pci/controller/mobiveil/Kconfig
@@ -21,4 +21,14 @@ config PCIE_MOBIVEIL_PLAT
 	  Soft IP. It has up to 8 outbound and inbound windows
 	  for address translation and it is a PCIe Gen4 IP.
 
+config PCI_LX
+	bool "Freescale LX PCIe controller"
+	depends on PCI
+	depends on OF && (ARM64 || ARCH_LAYERSCAPE)
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIE_MOBIVEIL_HOST
+	help
+	  Say Y here if you want PCIe controller support on LX SoCs.
+	  The PCIe controller can work in RC or EP mode according to
+	  RCW[HOST_AGT_PEX] setting.
 endmenu
diff --git a/drivers/pci/controller/mobiveil/Makefile b/drivers/pci/controller/mobiveil/Makefile
index 9fb6d1c6504d..e5318a334149 100644
--- a/drivers/pci/controller/mobiveil/Makefile
+++ b/drivers/pci/controller/mobiveil/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
 obj-$(CONFIG_PCIE_MOBIVEIL_HOST) += pcie-mobiveil-host.o
 obj-$(CONFIG_PCIE_MOBIVEIL_PLAT) += pcie-mobiveil-plat.o
+obj-$(CONFIG_PCI_LX) += pci-lx.o
diff --git a/drivers/pci/controller/mobiveil/pci-lx.c b/drivers/pci/controller/mobiveil/pci-lx.c
new file mode 100644
index 000000000000..5308255dc725
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/pci-lx.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for NXP LX SoCs
+ *
+ * Copyright 2018 NXP
+ *
+ * Author: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+
+#include "pcie-mobiveil.h"
+
+/* LUT and PF control registers */
+#define PCIE_LUT_OFF			(0x80000)
+#define PCIE_PF_OFF			(0xc0000)
+#define PCIE_PF_INT_STAT		(0x18)
+#define PF_INT_STAT_PABRST		(31)
+
+#define PCIE_PF_DBG			(0x7fc)
+#define PF_DBG_LTSSM_MASK		(0x3f)
+#define PF_DBG_WE			(31)
+#define PF_DBG_PABR			(27)
+
+#define LX_PCIE_LTSSM_L0		0x2d /* L0 state */
+
+struct lx_pcie {
+	struct mobiveil_pcie *pci;
+	int irq;
+};
+
+#define to_lx_pcie(x)	platform_get_drvdata((x)->pdev)
+
+static inline u32 lx_pcie_lut_readl(struct lx_pcie *pcie, u32 off)
+{
+	return ioread32(pcie->pci->csr_axi_slave_base + PCIE_LUT_OFF + off);
+}
+
+static inline void lx_pcie_lut_writel(struct lx_pcie *pcie, u32 off, u32 val)
+{
+	iowrite32(val, pcie->pci->csr_axi_slave_base + PCIE_LUT_OFF + off);
+}
+
+static inline u32 lx_pcie_pf_readl(struct lx_pcie *pcie, u32 off)
+{
+	return ioread32(pcie->pci->csr_axi_slave_base + PCIE_PF_OFF + off);
+}
+
+static inline void lx_pcie_pf_writel(struct lx_pcie *pcie, u32 off, u32 val)
+{
+	iowrite32(val, pcie->pci->csr_axi_slave_base + PCIE_PF_OFF + off);
+}
+
+static bool lx_pcie_is_bridge(struct lx_pcie *pcie)
+{
+	struct mobiveil_pcie *mv_pci = pcie->pci;
+	u32 header_type;
+
+	header_type = csr_readb(mv_pci, PCI_HEADER_TYPE);
+	header_type &= 0x7f;
+
+	return header_type == PCI_HEADER_TYPE_BRIDGE;
+}
+
+static int lx_pcie_link_up(struct mobiveil_pcie *pci)
+{
+	struct lx_pcie *pcie = to_lx_pcie(pci);
+	u32 state;
+
+	state = lx_pcie_pf_readl(pcie, PCIE_PF_DBG);
+	state =	state & PF_DBG_LTSSM_MASK;
+
+	if (state == LX_PCIE_LTSSM_L0)
+		return 1;
+
+	return 0;
+}
+
+static int lx_pcie_interrupt_init(struct mobiveil_pcie *pcie)
+{
+	return 0;
+}
+
+static struct mobiveil_rp_ops lx_pcie_rp_ops = {
+	.interrupt_init = lx_pcie_interrupt_init,
+};
+
+static const struct mobiveil_pab_ops lx_pcie_pab_ops = {
+	.link_up = lx_pcie_link_up,
+};
+
+static const struct of_device_id lx_pcie_of_match[] = {
+	{ .compatible = "fsl,lx2160a-pcie", },
+	{ },
+};
+
+static void lx_pcie_reinit_hw(struct lx_pcie *pcie)
+{
+	struct mobiveil_pcie *mv_pci = pcie->pci;
+	u32 val, act_stat;
+
+	/* Poll for pab_csb_reset to clear , PAB activity to set */
+	do {
+		val = lx_pcie_pf_readl(pcie, PCIE_PF_INT_STAT);
+		act_stat = csr_readl(mv_pci, PAB_ACTIVITY_STAT);
+
+	} while (((val & (1 << PF_INT_STAT_PABRST)) == 0) || act_stat);
+
+	while (!lx_pcie_link_up(mv_pci))
+		;
+
+	/* clear PEX_RESET bit in PEX_PF0_DBG register */
+	val = lx_pcie_pf_readl(pcie, PCIE_PF_DBG);
+	val |= 1 << PF_DBG_WE;
+	lx_pcie_pf_writel(pcie, PCIE_PF_DBG, val);
+
+	val = lx_pcie_pf_readl(pcie, PCIE_PF_DBG);
+	val |= 1 << PF_DBG_PABR;
+	lx_pcie_pf_writel(pcie, PCIE_PF_DBG, val);
+
+	val = lx_pcie_pf_readl(pcie, PCIE_PF_DBG);
+	val &= ~(1 << PF_DBG_WE);
+	lx_pcie_pf_writel(pcie, PCIE_PF_DBG, val);
+
+	mobiveil_host_init(mv_pci, true);
+}
+
+static irqreturn_t lx_pcie_handler(int irq, void *dev_id)
+{
+	struct lx_pcie *pcie = (struct lx_pcie *)dev_id;
+	struct mobiveil_pcie *mv_pci = pcie->pci;
+	u32 val;
+	u16 ctrl;
+
+	val = csr_readl(mv_pci, PAB_INTP_AMBA_MISC_STAT);
+	if (!val)
+		return IRQ_NONE;
+
+	if (val & PAB_INTP_RESET) {
+		ctrl = csr_readw(mv_pci, PCI_BRIDGE_CONTROL);
+		ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
+		csr_writew(mv_pci, ctrl, PCI_BRIDGE_CONTROL);
+		lx_pcie_reinit_hw(pcie);
+	}
+
+	csr_writel(mv_pci, val, PAB_INTP_AMBA_MISC_STAT);
+
+	return IRQ_HANDLED;
+}
+
+static int __init lx_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mobiveil_pcie *mv_pci;
+	struct lx_pcie *pcie;
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	if (!of_parse_phandle(np, "msi-parent", 0)) {
+		dev_err(dev, "failed to find msi-parent\n");
+		return -EINVAL;
+	}
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	mv_pci = devm_kzalloc(dev, sizeof(*mv_pci), GFP_KERNEL);
+	if (!mv_pci)
+		return -ENOMEM;
+
+	mv_pci->pdev = pdev;
+	mv_pci->ops = &lx_pcie_pab_ops;
+	mv_pci->rp.ops = &lx_pcie_rp_ops;
+	pcie->pci = mv_pci;
+
+	platform_set_drvdata(pdev, pcie);
+
+	pcie->irq = platform_get_irq_byname(pdev, "intr");
+	if (pcie->irq < 0) {
+		dev_err(&pdev->dev, "Can't get intr irq.\n");
+		return pcie->irq;
+	}
+	ret = devm_request_irq(dev, pcie->irq, lx_pcie_handler,
+			       IRQF_SHARED, pdev->name, pcie);
+	if (ret) {
+		dev_err(dev, "Can't register LX PCIe IRQ.\n");
+		return  ret;
+	}
+
+	ret = mobiveil_pcie_host_probe(mv_pci);
+	if (ret) {
+		dev_err(dev, "pci-lx: fail to probe!\n");
+		return  ret;
+	}
+
+	if (!lx_pcie_is_bridge(pcie))
+		return -ENODEV;
+
+	return 0;
+}
+
+static struct platform_driver lx_pcie_driver = {
+	.driver = {
+		.name = "lx-pcie",
+		.of_match_table = lx_pcie_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+builtin_platform_driver_probe(lx_pcie_driver, lx_pcie_probe);
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index b1d67a697ecc..eade5a8002d1 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -249,8 +249,9 @@ int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit)
 	pab_ctrl |= (1 << AMBA_PIO_ENABLE_SHIFT) | (1 << PEX_PIO_ENABLE_SHIFT);
 	csr_writel(pcie, pab_ctrl, PAB_CTRL);
 
-	csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
-		   PAB_INTP_AMBA_MISC_ENB);
+	value = PAB_INTP_INTX_MASK | PAB_INTP_MSI | PAB_INTP_RESET |
+		PAB_INTP_PCIE_UE | PAB_INTP_IE_PMREDI | PAB_INTP_IE_EC;
+	csr_writel(pcie, value, PAB_INTP_AMBA_MISC_ENB);
 
 	/*
 	 * program PIO Enable Bit to 1 and Config Window Enable Bit to 1 in
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
index 51195db09347..ddd736fa2042 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -41,6 +41,8 @@
 #define  PAGE_LO_MASK			0x3ff
 #define  PAGE_SEL_OFFSET_SHIFT		10
 
+#define PAB_ACTIVITY_STAT		0x81c
+
 #define PAB_AXI_PIO_CTRL		0x0840
 #define  APIO_EN_MASK			0xf
 
@@ -49,8 +51,17 @@
 
 #define PAB_INTP_AMBA_MISC_ENB		0x0b0c
 #define PAB_INTP_AMBA_MISC_STAT		0x0b1c
-#define  PAB_INTP_INTX_MASK		0x01e0
-#define  PAB_INTP_MSI_MASK		0x8
+#define  PAB_INTP_RESET			(0x1 << 1)
+#define  PAB_INTP_MSI			(0x1 << 3)
+#define  PAB_INTP_INTA			(0x1 << 5)
+#define  PAB_INTP_INTB			(0x1 << 6)
+#define  PAB_INTP_INTC			(0x1 << 7)
+#define  PAB_INTP_INTD			(0x1 << 8)
+#define  PAB_INTP_PCIE_UE		(0x1 << 9)
+#define  PAB_INTP_IE_PMREDI		(0x1 << 29)
+#define  PAB_INTP_IE_EC			(0x1 << 30)
+#define  PAB_INTP_INTX_MASK		(PAB_INTP_INTA | PAB_INTP_INTB |\
+					PAB_INTP_INTC | PAB_INTP_INTD)
 
 #define PAB_AXI_AMAP_CTRL(win)		PAB_REG_ADDR(0x0ba0, win)
 #define  WIN_ENABLE_SHIFT		0
-- 
2.17.1
