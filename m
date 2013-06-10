From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Jun 2013 19:34:40 +0100
Subject: [PATCH 4/9] ARM: dma-mapping: NULLify dev->archdata.mapping pointer
 on detach
In-Reply-To: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
Message-ID: <1370889285-22799-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code only clobbers a local variable, so the device is left
with a stale mapping pointer.

Cc: Hiroshi Doyu <hdoyu@nvidia.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index d119de7..10282db 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1921,7 +1921,7 @@ void arm_iommu_detach_device(struct device *dev)
 
 	iommu_detach_device(mapping->domain, dev);
 	kref_put(&mapping->kref, release_iommu_mapping);
-	mapping = NULL;
+	dev->archdata.mapping = NULL;
 	set_dma_ops(dev, NULL);
 
 	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
-- 
1.8.2.2
