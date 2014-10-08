From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 8 Oct 2014 14:04:56 +0100
Subject: [PATCH v3 2/2] xen/arm: introduce GNTTABOP_cache_flush
In-Reply-To: <alpine.DEB.2.02.1410081400520.17038@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1410081400520.17038@kaball.uk.xensource.com>
Message-ID: <1412773496-15364-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce support for new hypercall GNTTABOP_cache_flush.
Use it to perform cache flashing on pages used for dma when necessary.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---
Changes in v3:
- fix the cache maintenance op call to match what Linux does natively;
- update the hypercall interface to match Xen.

Changes in v2:
- update the hypercall interface to match Xen;
- call the interface on a single page at a time.
---
 arch/arm/xen/mm32.c                 |   27 +++++++++++++++++++++++----
 include/xen/interface/grant_table.h |   19 +++++++++++++++++++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/arch/arm/xen/mm32.c b/arch/arm/xen/mm32.c
index a5a93fc..ec2eb02 100644
--- a/arch/arm/xen/mm32.c
+++ b/arch/arm/xen/mm32.c
@@ -4,6 +4,9 @@
 #include <linux/highmem.h>
 
 #include <xen/features.h>
+#include <xen/interface/grant_table.h>
+
+#include <asm/xen/hypercall.h>
 
 
 /* functions called by SWIOTLB */
@@ -22,16 +25,32 @@ static void dma_cache_maint(dma_addr_t handle, unsigned long offset,
 		size_t len = left;
 		void *vaddr;
 	
+		if (len + offset > PAGE_SIZE)
+			len = PAGE_SIZE - offset;
+
 		if (!pfn_valid(pfn))
 		{
-			/* TODO: cache flush */
+			struct gnttab_cache_flush cflush;
+
+			cflush.op = 0;
+			cflush.a.dev_bus_addr = pfn << PAGE_SHIFT;
+			cflush.offset = offset;
+			cflush.length = len;
+
+			if (op == dmac_unmap_area && dir != DMA_TO_DEVICE)
+				cflush.op = GNTTAB_CACHE_INVAL;
+			if (op == dmac_map_area) {
+				if (dir == DMA_FROM_DEVICE)
+					cflush.op = GNTTAB_CACHE_INVAL;
+				else
+					cflush.op = GNTTAB_CACHE_CLEAN;
+			}
+			if (cflush.op)
+				HYPERVISOR_grant_table_op(GNTTABOP_cache_flush, &cflush, 1);
 		} else {
 			struct page *page = pfn_to_page(pfn);
 
 			if (PageHighMem(page)) {
-				if (len + offset > PAGE_SIZE)
-					len = PAGE_SIZE - offset;
-
 				if (cache_is_vipt_nonaliasing()) {
 					vaddr = kmap_atomic(page);
 					op(vaddr + offset, len, dir);
diff --git a/include/xen/interface/grant_table.h b/include/xen/interface/grant_table.h
index e40fae9..bcce564 100644
--- a/include/xen/interface/grant_table.h
+++ b/include/xen/interface/grant_table.h
@@ -479,6 +479,25 @@ struct gnttab_get_version {
 DEFINE_GUEST_HANDLE_STRUCT(gnttab_get_version);
 
 /*
+ * Issue one or more cache maintenance operations on a portion of a
+ * page granted to the calling domain by a foreign domain.
+ */
+#define GNTTABOP_cache_flush          12
+struct gnttab_cache_flush {
+    union {
+        uint64_t dev_bus_addr;
+        grant_ref_t ref;
+    } a;
+    uint16_t offset;   /* offset from start of grant */
+    uint16_t length;   /* size within the grant */
+#define GNTTAB_CACHE_CLEAN          (1<<0)
+#define GNTTAB_CACHE_INVAL          (1<<1)
+#define GNTTAB_CACHE_SOURCE_GREF    (1<<31)
+    uint32_t op;
+};
+DEFINE_GUEST_HANDLE_STRUCT(gnttab_cache_flush);
+
+/*
  * Bitfield values for update_pin_status.flags.
  */
  /* Map the grant entry for access by I/O devices. */
-- 
1.7.10.4
