From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Tue, 20 Nov 2018 09:26:50 +0000
Subject: [PATCHv2 12/25] PCI: mobiveil: move out the link up waiting from
 mobiveil_host_init
In-Reply-To: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20181120092615.11680-13-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Host initial sequence does not depend on PCIe link up, so move it
to the place just before the enumeration.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - no change

 drivers/pci/controller/pcie-mobiveil.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 8eee1ab7ee24..c2848c22b466 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -582,15 +582,8 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
 static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 {
 	u32 value, pab_ctrl, type;
-	int err;
 	struct resource_entry *win;
 
-	err = mobiveil_bringup_link(pcie);
-	if (err) {
-		dev_info(&pcie->pdev->dev, "link bring-up failed\n");
-		return err;
-	}
-
 	/*
 	 * program Bus Master Enable Bit in Command Register in PAB Config
 	 * Space
@@ -662,7 +655,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 	/* setup MSI hardware registers */
 	mobiveil_pcie_enable_msi(pcie);
 
-	return err;
+	return 0;
 }
 
 static void mobiveil_mask_intx_irq(struct irq_data *data)
@@ -922,6 +915,12 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
 
+	ret = mobiveil_bringup_link(pcie);
+	if (ret) {
+		dev_info(dev, "link bring-up failed\n");
+		goto error;
+	}
+
 	/* setup the kernel resources for the newly added PCIe root bus */
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret)
-- 
2.17.1
