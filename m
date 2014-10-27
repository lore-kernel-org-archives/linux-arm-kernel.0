From: wangyijing@huawei.com (Yijing Wang)
Date: Mon, 27 Oct 2014 15:48:45 +0800
Subject: [PATCH 08/10] PCI: xilinx: Save MSI controller in pci_sys_data
In-Reply-To: <1414396127-30023-1-git-send-email-wangyijing@huawei.com>
References: <1414396127-30023-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1414396127-30023-9-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Save MSI controller in pci_sys_data instead of
assigning MSI controller pointer to every pci bus
in .add_bus().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/host/pcie-xilinx.c |   19 ++++---------------
 1 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index ce19133..5a3e5a0 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -431,20 +431,6 @@ static void xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
 	pcie_write(port, msg_addr, XILINX_PCIE_REG_MSIBASE2);
 }
 
-/**
- * xilinx_pcie_add_bus - Add MSI chip info to PCIe bus
- * @bus: PCIe bus
- */
-static void xilinx_pcie_add_bus(struct pci_bus *bus)
-{
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		struct xilinx_pcie_port *port = sys_to_pcie(bus->sysdata);
-
-		xilinx_pcie_msi_controller.dev = port->dev;
-		bus->msi = &xilinx_pcie_msi_controller;
-	}
-}
-
 /* INTx Functions */
 
 /**
@@ -924,10 +910,13 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 		.private_data	= (void **)&port,
 		.setup		= xilinx_pcie_setup,
 		.map_irq	= of_irq_parse_and_map_pci,
-		.add_bus	= xilinx_pcie_add_bus,
 		.scan		= xilinx_pcie_scan_bus,
 		.ops		= &xilinx_pcie_ops,
 	};
+#ifdef CONFIG_PCI_MSI
+	xilinx_pcie_msi_controller.dev = port->dev;
+	hw.msi_ctrl = &xilinx_pcie_msi_controller;
+#endif
 	pci_common_init_dev(dev, &hw);
 
 	return 0;
-- 
1.7.1
