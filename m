From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:27 +0530
Subject: [RFC PATCH 12/40] PCI: keystone: Use syscon APIs to get device id
 from control module
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-13-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Control module registers should be read using syscon APIs.
pci-keystone.c uses platform_get_resource to get control module registers.
Fix it here by using syscon APIs to get device id from control module.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 46 +++++++++++++++--------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index e19ba065ebd5..505e13b1197d 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -15,12 +15,14 @@
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/init.h>
+#include <linux/mfd/syscon.h>
 #include <linux/msi.h>
 #include <linux/of_irq.h>
 #include <linux/of.h>
 #include <linux/of_pci.h>
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
+#include <linux/regmap.h>
 #include <linux/resource.h>
 #include <linux/signal.h>
 
@@ -28,6 +30,9 @@
 
 #define DRIVER_NAME	"keystone-pcie"
 
+#define PCIE_VENDORID_MASK	0xffff
+#define PCIE_DEVICEID_SHIFT	16
+
 /* DEV_STAT_CTRL */
 #define PCIE_CAP_BASE		0x70
 
@@ -92,8 +97,6 @@ static void ks_pcie_stop_link(struct dw_pcie *pci);
 struct keystone_pcie {
 	struct dw_pcie		*pci;
 	struct	clk		*clk;
-	/* PCI Device ID */
-	u32			device_id;
 	int			msi_host_irq;
 	struct			device_node *msi_intc_np;
 	struct irq_domain	*legacy_irq_domain;
@@ -588,6 +591,29 @@ static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
 	return 0;
 }
 
+static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
+{
+	int ret;
+	unsigned int id;
+	struct regmap *devctrl_regs;
+	struct dw_pcie *pci = ks_pcie->pci;
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
+
+	devctrl_regs = syscon_regmap_lookup_by_phandle(np, "ti,syscon-pcie-id");
+	if (IS_ERR(devctrl_regs))
+		return PTR_ERR(devctrl_regs);
+
+	ret = regmap_read(devctrl_regs, 0, &id);
+	if (ret)
+		return ret;
+
+	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, id & PCIE_VENDORID_MASK);
+	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, id >> PCIE_DEVICEID_SHIFT);
+
+	return 0;
+}
+
 static int __init ks_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -608,8 +634,9 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
 			pci->dbi_base + PCI_IO_BASE);
 
-	/* update the Vendor ID */
-	writew(ks_pcie->device_id, pci->dbi_base + PCI_DEVICE_ID);
+	ret = ks_pcie_init_id(ks_pcie);
+	if (ret < 0)
+		return ret;
 
 	/*
 	 * PCIe access errors that result into OCP errors are caught by ARM as
@@ -738,8 +765,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
-	struct resource *res;
-	void __iomem *reg_p;
 	struct phy *phy;
 	int ret;
 	int irq;
@@ -768,15 +793,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	/* index 2 is to read PCI DEVICE_ID */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	reg_p = devm_ioremap_resource(dev, res);
-	if (IS_ERR(reg_p))
-		return PTR_ERR(reg_p);
-	ks_pcie->device_id = readl(reg_p) >> 16;
-	devm_iounmap(dev, reg_p);
-	devm_release_mem_region(dev, res->start, resource_size(res));
-
 	ks_pcie->np = dev->of_node;
 
 	irq = platform_get_irq(pdev, 0);
-- 
2.17.1
