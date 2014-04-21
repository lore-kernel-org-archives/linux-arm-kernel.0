From: ritesh.harjani@gmail.com (Ritesh Harjani)
Date: Mon, 21 Apr 2014 12:17:27 +0530
Subject: [PATCH] arm: dma-mapping: Fix mapping size value
In-Reply-To: <1398062847-5770-1-git-send-email-ritesh.harjani@gmail.com>
References: <1398062847-5770-1-git-send-email-ritesh.harjani@gmail.com>
Message-ID: <1398062847-5770-2-git-send-email-ritesh.harjani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

68efd7d2fb("arm: dma-mapping: remove order parameter from
arm_iommu_create_mapping()") is causing kernel panic
because it wrongly sets the value of mapping->size:

Unable to handle kernel NULL pointer dereference at virtual
address 000000a0
pgd = e7a84000
[000000a0] *pgd=00000000
...
PC is at bitmap_clear+0x48/0xd0
LR is at __iommu_remove_mapping+0x130/0x164

Fix it by correcting mapping->size value.

Signed-off-by: Ritesh Harjani <ritesh.harjani@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f62aa06..6b00be1 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1963,8 +1963,8 @@ arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
 	mapping->nr_bitmaps = 1;
 	mapping->extensions = extensions;
 	mapping->base = base;
-	mapping->size = bitmap_size << PAGE_SHIFT;
 	mapping->bits = BITS_PER_BYTE * bitmap_size;
+	mapping->size = mapping->bits << PAGE_SHIFT;
 
 	spin_lock_init(&mapping->lock);
 
-- 
1.8.1.3
