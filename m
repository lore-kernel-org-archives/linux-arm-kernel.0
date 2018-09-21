From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:41 +0530
Subject: [RFC PATCH 26/40] PCI: keystone: Explicitly set the PCIe mode
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-27-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Explicitly set the PCIe mode to BOOTCFG_DEVCFG instead of always
relying on the default values. This is required when EP mode has to
be explicitly written to BOOTCFG_DEVCFG register.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 37 +++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 13e865f82f96..e8328039a017 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -80,6 +80,15 @@
 #define PCIE_RC_K2L			0xb00a
 #define PCIE_RC_K2G			0xb00b
 
+#define KS_PCIE_DEV_TYPE_MASK		(0x3 << 1)
+#define KS_PCIE_DEV_TYPE(mode)		((mode) << 1)
+
+#define EP				0x0
+#define LEG_EP				0x1
+#define RC				0x2
+
+#define KS_PCIE_SYSCLOCKOUTEN		BIT(0)
+
 #define to_keystone_pcie(x)		dev_get_drvdata((x)->dev)
 
 static int ks_pcie_start_link(struct dw_pcie *pci);
@@ -749,6 +758,30 @@ static int ks_pcie_enable_phy(struct keystone_pcie *ks_pcie)
 	return ret;
 }
 
+static int ks_pcie_set_mode(struct device *dev)
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
+	mask = KS_PCIE_DEV_TYPE_MASK | KS_PCIE_SYSCLOCKOUTEN;
+	val = KS_PCIE_DEV_TYPE(RC) | KS_PCIE_SYSCLOCKOUTEN;
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
 static int __init ks_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -865,6 +898,10 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
+	ret = ks_pcie_set_mode(dev);
+	if (ret < 0)
+		goto err_get_sync;
+
 	ret = ks_pcie_add_pcie_port(ks_pcie, pdev);
 	if (ret < 0)
 		goto err_get_sync;
-- 
2.17.1
