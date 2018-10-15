From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 15 Oct 2018 18:37:07 +0530
Subject: [PATCH 05/19] PCI: keystone: Remove unused argument from
 ks_dw_pcie_host_init()
In-Reply-To: <20181015130721.5535-1-kishon@ti.com>
References: <20181015130721.5535-1-kishon@ti.com>
Message-ID: <20181015130721.5535-6-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional change. Remove unused "msi_intc_np" argument from
ks_dw_pcie_host_init().

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone-dw.c | 3 +--
 drivers/pci/controller/dwc/pci-keystone.c    | 2 +-
 drivers/pci/controller/dwc/pci-keystone.h    | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone-dw.c b/drivers/pci/controller/dwc/pci-keystone-dw.c
index 0682213328e9..4bd6c6e2b177 100644
--- a/drivers/pci/controller/dwc/pci-keystone-dw.c
+++ b/drivers/pci/controller/dwc/pci-keystone-dw.c
@@ -439,8 +439,7 @@ void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
  * and call dw_pcie_v3_65_host_init() API to initialize the Keystone
  * PCI host controller.
  */
-int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
-				struct device_node *msi_intc_np)
+int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie)
 {
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct pcie_port *pp = &pci->pp;
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index aa7e706fc37d..f87ade2de711 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -341,7 +341,7 @@ static int __init ks_add_pcie_port(struct keystone_pcie *ks_pcie,
 	}
 
 	pp->ops = &keystone_pcie_host_ops;
-	ret = ks_dw_pcie_host_init(ks_pcie, ks_pcie->msi_intc_np);
+	ret = ks_dw_pcie_host_init(ks_pcie);
 	if (ret) {
 		dev_err(dev, "failed to initialize host\n");
 		return ret;
diff --git a/drivers/pci/controller/dwc/pci-keystone.h b/drivers/pci/controller/dwc/pci-keystone.h
index 8a13da391543..4eacc263f157 100644
--- a/drivers/pci/controller/dwc/pci-keystone.h
+++ b/drivers/pci/controller/dwc/pci-keystone.h
@@ -41,8 +41,7 @@ void ks_dw_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie);
 void ks_dw_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie, int offset);
 void ks_dw_pcie_enable_error_irq(struct keystone_pcie *ks_pcie);
 irqreturn_t ks_dw_pcie_handle_error_irq(struct keystone_pcie *ks_pcie);
-int  ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
-			struct device_node *msi_intc_np);
+int  ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie);
 int ks_dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 		unsigned int devfn, int where, int size, u32 val);
 int ks_dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
-- 
2.17.1
