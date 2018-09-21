From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:46 +0530
Subject: [RFC PATCH 31/40] PCI: keystone: Add support for PCIe in AM654x
 Platforms
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-32-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PCIe RC support for AM654x Platforms in pci-keystone.c

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/Kconfig        |   2 +-
 drivers/pci/controller/dwc/pci-keystone.c | 118 +++++++++++++++++++---
 2 files changed, 107 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 91b0194240a5..42f5bfa0f2fe 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -104,7 +104,7 @@ config PCIE_SPEAR13XX
 
 config PCI_KEYSTONE
 	bool "TI Keystone PCIe controller"
-	depends on ARCH_KEYSTONE || (ARM && COMPILE_TEST)
+	depends on ARCH_KEYSTONE || ARCH_K3 || (ARM && COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 91337e9c87a5..fe7daab6a518 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -18,6 +18,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/msi.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
@@ -89,11 +90,19 @@
 
 #define KS_PCIE_SYSCLOCKOUTEN		BIT(0)
 
+#define AM654_PCIE_DEV_TYPE_MASK	0x3
+#define AM654_WIN_SIZE			SZ_64K
+
 #define to_keystone_pcie(x)		dev_get_drvdata((x)->dev)
 
 static int ks_pcie_start_link(struct dw_pcie *pci);
 static void ks_pcie_stop_link(struct dw_pcie *pci);
 
+struct ks_pcie_of_data {
+	const struct dw_pcie_host_ops *host_ops;
+	unsigned int version;
+};
+
 struct keystone_pcie {
 	struct dw_pcie		*pci;
 	int			num_lanes;
@@ -173,6 +182,16 @@ static int ks_pcie_msi_host_init(struct pcie_port *pp)
 	return dw_pcie_allocate_domains(pp);
 }
 
+static int ks_pcie_am654_msi_host_init(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
+
+	dev_vdbg(dev, "dummy function so that DW core doesn't configure MSI\n");
+
+	return 0;
+}
+
 static void ks_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
 {
 	ks_pcie_app_writel(ks_pcie, ERR_IRQ_ENABLE_SET, ERR_IRQ_ALL);
@@ -409,6 +428,8 @@ static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
 
 	intc_np = of_get_child_by_name(np, "msi-interrupt-controller");
 	if (!intc_np) {
+		if (of_device_is_compatible(np, "ti,am654-pcie-rc"))
+			return 0;
 		dev_WARN(dev, "msi-interrupt-controller node is absent\n");
 		return -EINVAL;
 	}
@@ -520,11 +541,16 @@ static void ks_pcie_setup_mem_space(struct keystone_pcie *ks_pcie)
 	u32 val;
 	u32 num_viewport = ks_pcie->num_viewport;
 	struct dw_pcie *pci = ks_pcie->pci;
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
 	struct pcie_port *pp = &pci->pp;
 	u64 start = pp->mem->start;
 	u64 end = pp->mem->end;
 	int i;
 
+	if (of_device_is_compatible(np, "ti,am654-pcie-rc"))
+		return;
+
 	val = ilog2(OB_WIN_SIZE);
 	ks_pcie_app_writel(ks_pcie, OB_SIZE, val);
 
@@ -559,8 +585,10 @@ static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
 	if (ret)
 		return ret;
 
+	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, id & PCIE_VENDORID_MASK);
 	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, id >> PCIE_DEVICEID_SHIFT);
+	dw_pcie_dbi_ro_wr_dis(pci);
 
 	return 0;
 }
@@ -619,6 +647,11 @@ static const struct dw_pcie_host_ops ks_pcie_host_ops = {
 	.scan_bus = ks_pcie_v3_65_scan_bus,
 };
 
+static const struct dw_pcie_host_ops ks_pcie_am654_host_ops = {
+	.host_init = ks_pcie_host_init,
+	.msi_host_init = ks_pcie_am654_msi_host_init,
+};
+
 static irqreturn_t ks_pcie_err_irq_handler(int irq, void *priv)
 {
 	u32 reg;
@@ -666,7 +699,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
 
 	pp->va_cfg1_base = pp->va_cfg0_base;
 
-	pp->ops = &ks_pcie_host_ops;
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "failed to initialize host\n");
@@ -676,14 +708,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
 	return 0;
 }
 
-static const struct of_device_id ks_pcie_of_match[] = {
-	{
-		.type = "pci",
-		.compatible = "ti,keystone-pcie",
-	},
-	{ },
-};
-
 static void ks_pcie_stop_link(struct dw_pcie *pci)
 {
 	u32 val;
@@ -786,13 +810,59 @@ static int ks_pcie_set_mode(struct device *dev)
 	return 0;
 }
 
+static int ks_pcie_am654_set_mode(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct regmap *syscon;
+	u32 val;
+	u32 mask;
+	int ret = 0;
+
+	syscon = syscon_regmap_lookup_by_phandle(np, "ti,syscon-pcie-mode");
+	if (IS_ERR(syscon))
+		return 0;
+
+	mask = AM654_PCIE_DEV_TYPE_MASK;
+	val = RC;
+
+	ret = regmap_update_bits(syscon, 0, mask, val);
+	if (ret) {
+		dev_err(dev, "failed to set pcie mode\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct ks_pcie_of_data ks_pcie_am654_rc_of_data = {
+	.host_ops = &ks_pcie_am654_host_ops,
+	.version = 0x490A,
+};
+
+static const struct of_device_id ks_pcie_of_match[] = {
+	{
+		.type = "pci",
+		.compatible = "ti,keystone-pcie",
+	},
+	{
+		.data = &ks_pcie_am654_rc_of_data,
+		.compatible = "ti,am654-pcie-rc",
+	},
+	{ },
+};
+
 static int __init ks_pcie_probe(struct platform_device *pdev)
 {
+	const struct dw_pcie_host_ops *host_ops = &ks_pcie_host_ops;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	const struct ks_pcie_of_data *data;
+	const struct of_device_id *match;
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
+	unsigned int version = 0x365A;
 	struct device_link **link;
+	void __iomem *atu_base;
 	struct resource *res;
 	void __iomem *base;
 	u32 num_viewport;
@@ -803,6 +873,13 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	int irq;
 	int i;
 
+	match = of_match_device(of_match_ptr(ks_pcie_of_match), dev);
+	data = (struct ks_pcie_of_data *)match->data;
+	if (data) {
+		version = data->version;
+		host_ops = data->host_ops;
+	}
+
 	ks_pcie = devm_kzalloc(dev, sizeof(*ks_pcie), GFP_KERNEL);
 	if (!ks_pcie)
 		return -ENOMEM;
@@ -826,6 +903,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	pci->dbi_base = base;
 	pci->dev = dev;
 	pci->ops = &ks_pcie_dw_pcie_ops;
+	pci->version = version;
 
 	ret = of_property_read_u32(np, "num-viewport", &num_viewport);
 	if (ret < 0) {
@@ -902,10 +980,26 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
-	ret = ks_pcie_set_mode(dev);
-	if (ret < 0)
-		goto err_get_sync;
+	if (pci->version >= 0x480A) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
+		atu_base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(atu_base)) {
+			ret = PTR_ERR(atu_base);
+			goto err_get_sync;
+		}
+
+		pci->atu_base = atu_base;
+
+		ret = ks_pcie_am654_set_mode(dev);
+		if (ret < 0)
+			goto err_get_sync;
+	} else {
+		ret = ks_pcie_set_mode(dev);
+		if (ret < 0)
+			goto err_get_sync;
+	}
 
+	pci->pp.ops = host_ops;
 	ret = ks_pcie_add_pcie_port(ks_pcie, pdev);
 	if (ret < 0)
 		goto err_get_sync;
-- 
2.17.1
