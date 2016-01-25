From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 16:36:25 +0100
Subject: [PATCH] drm: armada: use dma_addr_t properly
Message-ID: <1453736189-1958878-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The armada_gem driver stores a DMA address token in a resource_size_t.
This is safe because both are always at least 32 bits wide and can store
any address that is accessible by this driver.

However, it is a slight type mismatch when we assign it from/to
an sg_dma_address() value, and we get a warning in any configuration
in which resource_size_t is shorter than dma_addr_t:

drivers/gpu/drm/armada/armada_gem.c: In function 'armada_gem_alloc_private_object':
arch/arm/include/asm/dma-mapping.h:16:24: warning: large integer implicitly truncated to unsigned type [-Woverflow]
 #define DMA_ERROR_CODE (~(dma_addr_t)0x0)
                        ^
drivers/gpu/drm/armada/armada_gem.c:204:18: note: in expansion of macro 'DMA_ERROR_CODE'
  obj->dev_addr = DMA_ERROR_CODE;
                  ^

Changing the type to dma_addr_t solves both issues.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/armada/armada_gem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_gem.h b/drivers/gpu/drm/armada/armada_gem.h
index b000ea3a829a..270cff02c1cd 100644
--- a/drivers/gpu/drm/armada/armada_gem.h
+++ b/drivers/gpu/drm/armada/armada_gem.h
@@ -15,7 +15,7 @@ struct armada_gem_object {
 	struct drm_gem_object	obj;
 	void			*addr;
 	phys_addr_t		phys_addr;
-	resource_size_t		dev_addr;
+	dma_addr_t		dev_addr;
 	struct drm_mm_node	*linear;	/* for linear backed */
 	struct page		*page;		/* for page backed */
 	struct sg_table		*sgt;		/* for imported */
-- 
2.7.0
