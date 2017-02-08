From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 08 Feb 2017 16:49:30 -0600
Subject: [PATCH v1 1/3] PCI: xilinx: Configure PCIe MPS settings
In-Reply-To: <20170208224632.14351.89895.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170208224632.14351.89895.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170208224930.14351.91597.stgit@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Helgaas <bhelgaas@google.com>

Make sure PCIe MPS settings are valid when we enumerate a new hierarchy.

Based-on-patch-by: Jon Mason <jon.mason@broadcom.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-xilinx.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index c8616fadccf1..7f030f5d750b 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -632,7 +632,7 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct xilinx_pcie_port *port;
-	struct pci_bus *bus;
+	struct pci_bus *bus, *child;
 	int err;
 	resource_size_t iobase = 0;
 	LIST_HEAD(res);
@@ -686,6 +686,8 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 #ifndef CONFIG_MICROBLAZE
 	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
 #endif
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
 	pci_bus_add_devices(bus);
 	return 0;
 
