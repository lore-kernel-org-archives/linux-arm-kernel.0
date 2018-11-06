From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Tue, 6 Nov 2018 13:19:25 +0000
Subject: [PATCH 03/23] PCI: mobiveil: correct the returned error number
In-Reply-To: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20181106131807.29951-4-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This patch corrected the returned error number by convention,
and removed a unnecessary error check.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/pcie-mobiveil.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index b87471f08a40..563210e731d3 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -819,7 +819,7 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
 
 	if (!pcie->intx_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
-		return -ENODEV;
+		return -ENOMEM;
 	}
 
 	raw_spin_lock_init(&pcie->intx_mask_lock);
@@ -845,11 +845,9 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 	/* allocate the PCIe port */
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
-		return -ENODEV;
+		return -ENOMEM;
 
 	pcie = pci_host_bridge_priv(bridge);
-	if (!pcie)
-		return -ENOMEM;
 
 	pcie->pdev = pdev;
 
@@ -866,7 +864,7 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 						    &pcie->resources, &iobase);
 	if (ret) {
 		dev_err(dev, "Getting bridge resources failed\n");
-		return -ENOMEM;
+		return ret;
 	}
 
 	/*
-- 
2.17.1
