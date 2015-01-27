From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 27 Jan 2015 16:00:03 -0500
Subject: [PATCH v5 6/8] PCI: update dma configuration from DT
In-Reply-To: <1422392405-32196-1-git-send-email-m-karicheri2@ti.com>
References: <1422392405-32196-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1422392405-32196-7-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If there is a DT node available for the root bridge's parent device,
use the dma configuration from that device node. For example, keystone
PCI devices would require dma_pfn_offset to be set correctly in the
device structure of the pci device in order to have the correct dma mask.
The DT node will have dma-ranges defined for this. Also support using
the DT property dma-coherent to allow coherent DMA operation by the
PCI device.

This patch use the new helper function of_pci_dma_configure() to update
the device dma configuration.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/pci/probe.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 23212f8..d7dcd6c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/of_pci.h>
 #include <linux/pci_hotplug.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -1520,6 +1521,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	dev->dev.dma_mask = &dev->dma_mask;
 	dev->dev.dma_parms = &dev->dma_parms;
 	dev->dev.coherent_dma_mask = 0xffffffffull;
+	of_pci_dma_configure(dev);
 
 	pci_set_dma_max_seg_size(dev, 65536);
 	pci_set_dma_seg_boundary(dev, 0xffffffff);
-- 
1.7.9.5
