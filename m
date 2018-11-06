From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Tue, 6 Nov 2018 13:20:54 +0000
Subject: [PATCH 17/23] PCI: mobiveil: continue to initialize the host upon no
 PCIe link
In-Reply-To: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20181106131807.29951-18-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Sometimes there is not a PCIe Endpoint in the PCIe slot, so do
not exit when the PCIe link is not up. And degrade the print
level of link up info.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 1 -
 drivers/pci/controller/mobiveil/pcie-mobiveil.c      | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index 383b2f3947a5..4419179f64bc 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -591,7 +591,6 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 	ret = mobiveil_bringup_link(pcie);
 	if (ret) {
 		dev_info(dev, "link bring-up failed\n");
-		goto error;
 	}
 
 	/* setup the kernel resources for the newly added PCIe root bus */
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
index a25ebdd23592..71389ebbf229 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
@@ -221,7 +221,7 @@ int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
 		usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
 	}
 
-	dev_err(&pcie->pdev->dev, "link never came up\n");
+	dev_info(&pcie->pdev->dev, "link never came up\n");
 
 	return -ETIMEDOUT;
 }
-- 
2.17.1
