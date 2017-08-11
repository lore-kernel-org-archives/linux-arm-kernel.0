From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 11 Aug 2017 17:29:57 +0100
Subject: [PATCH 2/2] of: Restrict DMA configuration
In-Reply-To: <0819179085df6c41c70e83a2c5c138b95c0386b3.1502468875.git.robin.murphy@arm.com>
References: <0819179085df6c41c70e83a2c5c138b95c0386b3.1502468875.git.robin.murphy@arm.com>
Message-ID: <82633e62b64e28dc18bc466319065b92faf2414f.1502468875.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moving DMA configuration to happen later at driver probe time had the
unnoticed side-effect that we now perform DMA configuration for *every*
device represented in DT, rather than only those explicitly created by
the of_platform and PCI code.

As Christoph points out, this is not really the best thing to do. Whilst
there may well be other DMA-capable buses that can benefit from having
their children automatically configured after the bridge has probed,
there are also plenty of others like USB, MDIO, etc. that definitely do
not support DMA and should not be indiscriminately processed.

The good news is that DT already gives us the ammunition to do the right
thing - anything lacking a "dma-ranges" property should be considered
not to have a mapping of DMA address space from its children to its
parent, thus anything for which of_dma_get_range() does not succeed does
not need DMA configuration.

The bad news is that strictly enforcing that would likely break just
about every FDT platform out there, since most authors have either not
considered the property at all or have mistakenly assumed that omitting
"dma-ranges" is equivalent to including the empty property. Thus we have
little choice but to special-case platform, AMBA and PCI devices so they
continue to receive configuration unconditionally as before. At least
anything new will have to get it right in future...

Fixes: 09515ef5ddad ("of/acpi: Configure dma operations at probe time for platform/amba/pci bus devices")
Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/of/device.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index e0a28ea341fe..04c4c952dc57 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -9,6 +9,9 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/amba/bus.h>
 
 #include <asm/errno.h>
 #include "of_private.h"
@@ -84,31 +87,28 @@ int of_device_add(struct platform_device *ofdev)
  */
 int of_dma_configure(struct device *dev, struct device_node *np)
 {
-	u64 dma_addr, paddr, size;
+	u64 dma_addr, paddr, size = 0;
 	int ret;
 	bool coherent;
 	unsigned long offset;
 	const struct iommu_ops *iommu;
 	u64 mask;
 
-	/*
-	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
-	 * setup the correct supported mask.
-	 */
-	if (!dev->coherent_dma_mask)
-		dev->coherent_dma_mask = DMA_BIT_MASK(32);
-
-	/*
-	 * Set it to coherent_dma_mask by default if the architecture
-	 * code has not set it.
-	 */
-	if (!dev->dma_mask)
-		dev->dma_mask = &dev->coherent_dma_mask;
-
 	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
 	if (ret < 0) {
+		/*
+		 * For legacy reasons, we have to assume some devices need
+		 * DMA configuration regardless of whether "dma-ranges" is
+		 * correctly specified or not.
+		 */
+		if (!dev_is_pci(dev) &&
+#ifdef CONFIG_ARM_AMBA
+		    dev->bus != &amba_bustype &&
+#endif
+		    dev->bus != &platform_bus_type)
+			return ret == -ENODEV ? 0 : ret;
+
 		dma_addr = offset = 0;
-		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
 	} else {
 		offset = PFN_DOWN(paddr - dma_addr);
 
@@ -129,6 +129,22 @@ int of_dma_configure(struct device *dev, struct device_node *np)
 		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
 	}
 
+	/*
+	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
+	 * setup the correct supported mask.
+	 */
+	if (!dev->coherent_dma_mask)
+		dev->coherent_dma_mask = DMA_BIT_MASK(32);
+	/*
+	 * Set it to coherent_dma_mask by default if the architecture
+	 * code has not set it.
+	 */
+	if (!dev->dma_mask)
+		dev->dma_mask = &dev->coherent_dma_mask;
+
+	if (!size)
+		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
+
 	dev->dma_pfn_offset = offset;
 
 	/*
-- 
2.13.4.dirty
