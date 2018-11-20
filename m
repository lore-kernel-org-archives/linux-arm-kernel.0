From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Tue, 20 Nov 2018 09:26:44 +0000
Subject: [PATCHv2 11/25] PCI: mobiveil: only fix up the Class Code field
In-Reply-To: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20181120092615.11680-12-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Fix up the Class Code to PCI bridge, do not change the Revision ID.
And move the fixup to mobiveil_host_init function.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge
IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - Added fixes entry.

 drivers/pci/controller/pcie-mobiveil.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 78e575e71f4d..8eee1ab7ee24 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -653,6 +653,12 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 				   type, resource_size(win->res));
 	}
 
+	/* fixup for PCIe class register */
+	value = csr_readl(pcie, PAB_INTP_AXI_PIO_CLASS);
+	value &= 0xff;
+	value |= (PCI_CLASS_BRIDGE_PCI << 16);
+	csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
+
 	/* setup MSI hardware registers */
 	mobiveil_pcie_enable_msi(pcie);
 
@@ -896,9 +902,6 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 		goto error;
 	}
 
-	/* fixup for PCIe class register */
-	csr_writel(pcie, 0x060402ab, PAB_INTP_AXI_PIO_CLASS);
-
 	/* initialize the IRQ domains */
 	ret = mobiveil_pcie_init_irq_domain(pcie);
 	if (ret) {
-- 
2.17.1
