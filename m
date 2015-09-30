From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 30 Sep 2015 11:45:18 +0100
Subject: [PATCH v5 03/22] xen: Add Xen specific page definition
In-Reply-To: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
References: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1443609937-25278-4-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Xen hypercall interface is always using 4K page granularity on ARM
and x86 architecture.

With the incoming support of 64K page granularity for ARM64 guest, it
won't be possible to re-use the Linux page definition in Xen drivers.

Introduce Xen page definition helpers based on the Linux page
definition. They have exactly the same name but prefixed with
XEN_/xen_ prefix.

Also modify xen_page_to_gfn to use new Xen page definition.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>

    Changes in v4:
        - Typoes
        - Rename xen_page_to_pfn to page_to_xen_pfn

    Changes in v3:
        - Fix errors reported by checkpatch.pl
        - Rename pfn to xen_pfn in xen_pfn_to_page
        - Add a comment that we assume PAGE_SIZE to be a multiple of
        XEN_PAGE_SIZE
        - s/MFN/GFN/ according to new naming
        - Add Stefano's reviewed-by

    Changes in v2:
        - Add XEN_PFN_UP
        - Add a comment describing the behavior of page_to_pfn
---
 include/xen/page.h | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/xen/page.h b/include/xen/page.h
index 1daae48..96294ac 100644
--- a/include/xen/page.h
+++ b/include/xen/page.h
@@ -1,11 +1,36 @@
 #ifndef _XEN_PAGE_H
 #define _XEN_PAGE_H
 
+#include <asm/page.h>
+
+/* The hypercall interface supports only 4KB page */
+#define XEN_PAGE_SHIFT	12
+#define XEN_PAGE_SIZE	(_AC(1, UL) << XEN_PAGE_SHIFT)
+#define XEN_PAGE_MASK	(~(XEN_PAGE_SIZE-1))
+#define xen_offset_in_page(p)	((unsigned long)(p) & ~XEN_PAGE_MASK)
+
+/*
+ * We assume that PAGE_SIZE is a multiple of XEN_PAGE_SIZE
+ * XXX: Add a BUILD_BUG_ON?
+ */
+
+#define xen_pfn_to_page(xen_pfn)	\
+	((pfn_to_page(((unsigned long)(xen_pfn) << XEN_PAGE_SHIFT) >> PAGE_SHIFT)))
+#define page_to_xen_pfn(page)		\
+	(((page_to_pfn(page)) << PAGE_SHIFT) >> XEN_PAGE_SHIFT)
+
+#define XEN_PFN_PER_PAGE	(PAGE_SIZE / XEN_PAGE_SIZE)
+
+#define XEN_PFN_DOWN(x)	((x) >> XEN_PAGE_SHIFT)
+#define XEN_PFN_UP(x)	(((x) + XEN_PAGE_SIZE-1) >> XEN_PAGE_SHIFT)
+#define XEN_PFN_PHYS(x)	((phys_addr_t)(x) << XEN_PAGE_SHIFT)
+
 #include <asm/xen/page.h>
 
+/* Return the GFN associated to the first 4KB of the page */
 static inline unsigned long xen_page_to_gfn(struct page *page)
 {
-	return pfn_to_gfn(page_to_pfn(page));
+	return pfn_to_gfn(page_to_xen_pfn(page));
 }
 
 struct xen_memory_region {
-- 
2.1.4
