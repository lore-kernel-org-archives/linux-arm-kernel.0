From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:18 +0530
Subject: [RFC PATCH 03/40] PCI: keystone: Move dw_pcie_setup_rc out of
 ks_pcie_establish_link()
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-4-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional change. Move dw_pcie_setup_rc out of
ks_pcie_establish_link() so that ks_pcie_establish_link only does what it
is supposed to do. This will be required for adding EP support which
will invoke ks_pcie_establish_link as part of start_link ops.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 5d9c5d199ada..fec46cfccba5 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -90,8 +90,6 @@ static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 	struct device *dev = pci->dev;
 	unsigned int retries;
 
-	dw_pcie_setup_rc(pp);
-
 	if (dw_pcie_link_up(pci)) {
 		dev_info(dev, "Link already up\n");
 		return 0;
@@ -266,6 +264,8 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
+	dw_pcie_setup_rc(pp);
+
 	ks_pcie_establish_link(ks_pcie);
 	ks_dw_pcie_setup_rc_app_regs(ks_pcie);
 	ks_pcie_setup_interrupts(ks_pcie);
-- 
2.17.1
