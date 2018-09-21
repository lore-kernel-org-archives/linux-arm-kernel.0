From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:19 +0530
Subject: [RFC PATCH 04/40] PCI: keystone: Do not initiate link training
 multiple times
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-5-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 886bc5ceb5cc3ad4b219502d72 ("PCI: designware: Add generic
dw_pcie_wait_for_link()") while adding a generic dw_pcie_wait_for_link()
performed a special handling (initiate link training multiple times) for
keystone which is not required. This also resulted in unncessarily waiting
for more time to establish the link even when no PCI device is connected.

Remove it and make it look similar to other dwc based PCIe drivers.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index fec46cfccba5..aa7e706fc37d 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -86,21 +86,18 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, quirk_limit_mrrs);
 static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 {
 	struct dw_pcie *pci = ks_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
 	struct device *dev = pci->dev;
-	unsigned int retries;
 
 	if (dw_pcie_link_up(pci)) {
 		dev_info(dev, "Link already up\n");
 		return 0;
 	}
 
+	ks_dw_pcie_initiate_link_train(ks_pcie);
+
 	/* check if the link is up or not */
-	for (retries = 0; retries < 5; retries++) {
-		ks_dw_pcie_initiate_link_train(ks_pcie);
-		if (!dw_pcie_wait_for_link(pci))
-			return 0;
-	}
+	if (!dw_pcie_wait_for_link(pci))
+		return 0;
 
 	dev_err(dev, "phy link never came up\n");
 	return -ETIMEDOUT;
-- 
2.17.1
