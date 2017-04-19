From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Apr 2017 20:24:01 +0200
Subject: [PATCH] [RFC] gpu: host1x: shut up warning about DMA API misuse
Message-ID: <20170419182413.866327-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When dma_addr_t and phys_addr_t are not the same size, we get a warning
from the dma_alloc_wc function:

drivers/gpu/host1x/cdma.c: In function 'host1x_pushbuffer_init':
drivers/gpu/host1x/cdma.c:94:48: error: passing argument 3 of 'dma_alloc_wc' from incompatible pointer type [-Werror=incompatible-pointer-types]
   pb->mapped = dma_alloc_wc(host1x->dev, size, &pb->phys,
                                                ^
In file included from drivers/gpu/host1x/cdma.c:22:0:
include/linux/dma-mapping.h:761:37: note: expected 'dma_addr_t * {aka long long unsigned int *}' but argument is of type 'phys_addr_t * {aka unsigned int *}'
 static noinline_if_stackbloat void *dma_alloc_wc(struct device *dev, size_t size,
                                     ^~~~~~~~~~~~
drivers/gpu/host1x/cdma.c:113:48: error: passing argument 3 of 'dma_alloc_wc' from incompatible pointer type [-Werror=incompatible-pointer-types]
   pb->mapped = dma_alloc_wc(host1x->dev, size, &pb->phys,
                                                ^
In file included from drivers/gpu/host1x/cdma.c:22:0:
include/linux/dma-mapping.h:761:37: note: expected 'dma_addr_t * {aka long long unsigned int *}' but argument is of type 'phys_addr_t * {aka unsigned int *}'
 static noinline_if_stackbloat void *dma_alloc_wc(struct device *dev, size_t size,
                                     ^~~~~~~~~~~~

The problem here is that dma_alloc_wc() returns a pointer to a dma_addr_t
that may already be translated by an IOMMU, but the driver passes this
into iommu_map() as a physical address. This works by accident only when
the IOMMU does not get registered with the DMA API and there is a 1:1
mapping between physical addresses as seen by the CPU and the device.

The fundamental problem here is the lack of a generic API to do what the
driver wants: allocating CPU-visible memory for use by a device through
user-defined IOMMU settings. Neither the dma-mapping API nor the IOMMU
API can do this by itself, and combining the two is not well-defined.

This patch addresses the type mismatch by adding a third pointer into the
push_buffer structure: in addition to the address as seen from the CPU
and the address inside of the local IOMMU domain, the pb->alloc pointer
is the token returned by dma_alloc_wc(), and this is what we later need
to pass into dma_free_wc().

The address we pass into iommu_map() however is the physical address
computed from virt_to_phys(), assuming that the pointer we have here
is part of the linear mapping (which is also questionable, e.g. when we
have a non-coherent device on ARM32 this may be false). Also, when
the DMA API uses the IOMMU to allocate the pointer for the default
domain, we end up with two IOMMU mappings for the same physical address.

Fixes: 404bfb78daf3 ("gpu: host1x: Add IOMMU support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/host1x/cdma.c | 26 ++++++++++----------------
 drivers/gpu/host1x/cdma.h |  1 +
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
index 28541b280739..286edeca7ba1 100644
--- a/drivers/gpu/host1x/cdma.c
+++ b/drivers/gpu/host1x/cdma.c
@@ -59,7 +59,7 @@ static void host1x_pushbuffer_destroy(struct push_buffer *pb)
 		free_iova(&host1x->iova, iova_pfn(&host1x->iova, pb->dma));
 	}
 
-	dma_free_wc(host1x->dev, pb->alloc_size, pb->mapped, pb->phys);
+	dma_free_wc(host1x->dev, pb->alloc_size, pb->mapped, pb->alloc);
 
 	pb->mapped = NULL;
 	pb->phys = 0;
@@ -81,20 +81,21 @@ static int host1x_pushbuffer_init(struct push_buffer *pb)
 	pb->size = HOST1X_PUSHBUFFER_SLOTS * 8;
 
 	size = pb->size + 4;
+	if (host1x->domain)
+		size = iova_align(&host1x->iova, size);
 
 	/* initialize buffer pointers */
 	pb->fence = pb->size - 8;
 	pb->pos = 0;
 
-	if (host1x->domain) {
-		unsigned long shift;
+	pb->mapped = dma_alloc_wc(host1x->dev, size, &pb->alloc, GFP_KERNEL);
+	if (!pb->mapped)
+		return -ENOMEM;
 
-		size = iova_align(&host1x->iova, size);
+	pb->phys = virt_to_phys(pb->mapped);
 
-		pb->mapped = dma_alloc_wc(host1x->dev, size, &pb->phys,
-					  GFP_KERNEL);
-		if (!pb->mapped)
-			return -ENOMEM;
+	if (host1x->domain) {
+		unsigned long shift;
 
 		shift = iova_shift(&host1x->iova);
 		alloc = alloc_iova(&host1x->iova, size >> shift,
@@ -109,13 +110,6 @@ static int host1x_pushbuffer_init(struct push_buffer *pb)
 				IOMMU_READ);
 		if (err)
 			goto iommu_free_iova;
-	} else {
-		pb->mapped = dma_alloc_wc(host1x->dev, size, &pb->phys,
-					  GFP_KERNEL);
-		if (!pb->mapped)
-			return -ENOMEM;
-
-		pb->dma = pb->phys;
 	}
 
 	pb->alloc_size = size;
@@ -127,7 +121,7 @@ static int host1x_pushbuffer_init(struct push_buffer *pb)
 iommu_free_iova:
 	__free_iova(&host1x->iova, alloc);
 iommu_free_mem:
-	dma_free_wc(host1x->dev, pb->alloc_size, pb->mapped, pb->phys);
+	dma_free_wc(host1x->dev, pb->alloc_size, pb->mapped, pb->alloc);
 
 	return err;
 }
diff --git a/drivers/gpu/host1x/cdma.h b/drivers/gpu/host1x/cdma.h
index ec170a78f4e1..8479192d4265 100644
--- a/drivers/gpu/host1x/cdma.h
+++ b/drivers/gpu/host1x/cdma.h
@@ -43,6 +43,7 @@ struct host1x_job;
 
 struct push_buffer {
 	void *mapped;			/* mapped pushbuffer memory */
+	dma_addr_t alloc;		/* device address in root domain */
 	dma_addr_t dma;			/* device address of pushbuffer */
 	phys_addr_t phys;		/* physical address of pushbuffer */
 	u32 fence;			/* index we've written */
-- 
2.9.0
