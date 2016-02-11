From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Thu, 11 Feb 2016 21:58:09 +0530
Subject: [PATCH V4 3/5] PCI: xilinx: Modifying AXI PCIe Host Bridge driver to
 work on both Zynq and Microblaze
In-Reply-To: <1455208091-15556-1-git-send-email-bharatku@xilinx.com>
References: <1455208091-15556-1-git-send-email-bharatku@xilinx.com>
Message-ID: <1455208091-15556-4-git-send-email-bharatku@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modifying Xilinx AXI PCIe Host Bridge Soft IP driver to work on both
Zynq and Microblaze Architectures.
With these modifications drivers/pci/host/pcie-xilinx.c, will
work on both Zynq and Microblaze Architectures.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
Changes:
Added #ifdef to pci_fixup_irqs which is ARM specific API.
---
 drivers/pci/host/pcie-xilinx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 13fec35..8ad50fe 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -704,7 +704,9 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 #endif
 	pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
+#ifndef CONFIG_MICROBLAZE
 	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+#endif
 	pci_bus_add_devices(bus);
 	platform_set_drvdata(pdev, port);
 
-- 
2.1.1
