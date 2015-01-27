From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 27 Jan 2015 16:00:05 -0500
Subject: [PATCH v5 8/8] of: limit dma_mask of the device based on dma-range
 size
In-Reply-To: <1422392405-32196-1-git-send-email-m-karicheri2@ti.com>
References: <1422392405-32196-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1422392405-32196-9-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

limit the device dma_mask to the min of default dma_mask and
mask calculate from the dma-range size.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/of/device.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 17504f4..bcb8a35 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -128,6 +128,9 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 	dev_dbg(dev, "device is%sbehind an iommu\n",
 		iommu ? " " : " not ");
 
+	/* limit dma_mask to the lower of the two values */
+	*dev->dma_mask = min((*dev->dma_mask), (dma_addr + size - 1));
+
 	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
 }
 EXPORT_SYMBOL_GPL(of_dma_configure);
-- 
1.7.9.5
