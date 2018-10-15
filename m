From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 15 Oct 2018 18:37:05 +0530
Subject: [PATCH 03/19] PCI: keystone: Move dw_pcie_setup_rc out of
 ks_pcie_establish_link()
In-Reply-To: <20181015130721.5535-1-kishon@ti.com>
References: <20181015130721.5535-1-kishon@ti.com>
Message-ID: <20181015130721.5535-4-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional change. Move dw_pcie_setup_rc out of
ks_pcie_establish_link() so that ks_pcie_establish_link can be used only
to start the link.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 5d9c5d199ada..afb948372077 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -86,12 +86,9 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, quirk_limit_mrrs);
 static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 {
 	struct dw_pcie *pci = ks_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
 	struct device *dev = pci->dev;
 	unsigned int retries;
 
-	dw_pcie_setup_rc(pp);
-
 	if (dw_pcie_link_up(pci)) {
 		dev_info(dev, "Link already up\n");
 		return 0;
@@ -266,6 +263,8 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
+	dw_pcie_setup_rc(pp);
+
 	ks_pcie_establish_link(ks_pcie);
 	ks_dw_pcie_setup_rc_app_regs(ks_pcie);
 	ks_pcie_setup_interrupts(ks_pcie);
-- 
2.17.1
