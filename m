From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 28 Jan 2015 18:00:21 -0500
Subject: [PATCH] soc: ti: knav_qmss_queue: export API calls for use by user
 driver
Message-ID: <1422486021-23874-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently only few of the API calls are exported. This creates problem
when the knav* modules are built as modules and another user module
such as netcp_core try to use these API calls and they are also built
as module. This patch export these APIs to address the issue.

This is needed to support allmodconfig for ARM

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/soc/ti/knav_qmss_queue.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 8e6a95d..6d8646d 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -626,6 +626,7 @@ int knav_queue_push(void *qhandle, dma_addr_t dma,
 	atomic_inc(&qh->stats.pushes);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(knav_queue_push);
 
 /**
  * knav_queue_pop()	- pop data (or descriptor) from the head of a queue
@@ -663,6 +664,7 @@ dma_addr_t knav_queue_pop(void *qhandle, unsigned *size)
 	atomic_inc(&qh->stats.pops);
 	return dma;
 }
+EXPORT_SYMBOL_GPL(knav_queue_pop);
 
 /* carve out descriptors and push into queue */
 static void kdesc_fill_pool(struct knav_pool *pool)
@@ -717,12 +719,14 @@ dma_addr_t knav_pool_desc_virt_to_dma(void *ph, void *virt)
 	struct knav_pool *pool = ph;
 	return pool->region->dma_start + (virt - pool->region->virt_start);
 }
+EXPORT_SYMBOL_GPL(knav_pool_desc_virt_to_dma);
 
 void *knav_pool_desc_dma_to_virt(void *ph, dma_addr_t dma)
 {
 	struct knav_pool *pool = ph;
 	return pool->region->virt_start + (dma - pool->region->dma_start);
 }
+EXPORT_SYMBOL_GPL(knav_pool_desc_dma_to_virt);
 
 /**
  * knav_pool_create()	- Create a pool of descriptors
@@ -878,6 +882,7 @@ void *knav_pool_desc_get(void *ph)
 	data = knav_pool_desc_dma_to_virt(pool, dma);
 	return data;
 }
+EXPORT_SYMBOL_GPL(knav_pool_desc_get);
 
 /**
  * knav_pool_desc_put()	- return a descriptor to the pool
@@ -890,6 +895,7 @@ void knav_pool_desc_put(void *ph, void *desc)
 	dma = knav_pool_desc_virt_to_dma(pool, desc);
 	knav_queue_push(pool->queue, dma, pool->region->desc_size, 0);
 }
+EXPORT_SYMBOL_GPL(knav_pool_desc_put);
 
 /**
  * knav_pool_desc_map()	- Map descriptor for DMA transfer
@@ -916,6 +922,7 @@ int knav_pool_desc_map(void *ph, void *desc, unsigned size,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(knav_pool_desc_map);
 
 /**
  * knav_pool_desc_unmap()	- Unmap descriptor after DMA transfer
@@ -938,6 +945,7 @@ void *knav_pool_desc_unmap(void *ph, dma_addr_t dma, unsigned dma_sz)
 	prefetch(desc);
 	return desc;
 }
+EXPORT_SYMBOL_GPL(knav_pool_desc_unmap);
 
 /**
  * knav_pool_count()	- Get the number of descriptors in pool.
@@ -949,6 +957,7 @@ int knav_pool_count(void *ph)
 	struct knav_pool *pool = ph;
 	return knav_queue_get_count(pool->queue);
 }
+EXPORT_SYMBOL_GPL(knav_pool_count);
 
 static void knav_queue_setup_region(struct knav_device *kdev,
 					struct knav_region *region)
-- 
1.7.9.5
