From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Thu, 29 Dec 2016 23:45:04 +0300
Subject: [PATCH 2/2] rcar-pcie: set host bridge's DMA mask
In-Reply-To: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
Message-ID: <1483044304-2085-2-git-send-email-nikita.yoush@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This gives platform DMA mapping code a chance to disallow setting device
DMA mask to something that host bridge can't support.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/pci/host/pcie-rcar.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index aca85be..b1edc3c 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -451,6 +451,7 @@ static int rcar_pcie_enable(struct rcar_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct pci_bus *bus, *child;
+	struct pci_host_bridge *bridge;
 	LIST_HEAD(res);
 
 	/* Try setting 5 GT/s link speed */
@@ -480,6 +481,10 @@ static int rcar_pcie_enable(struct rcar_pcie *pcie)
 	list_for_each_entry(child, &bus->children, node)
 		pcie_bus_configure_settings(child);
 
+	bridge = pci_find_host_bridge(bus);
+	bridge->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	bridge->dev.dma_mask = &bridge->dev.coherent_dma_mask;
+
 	pci_bus_add_devices(bus);
 
 	return 0;
-- 
2.1.4
