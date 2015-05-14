From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 14 May 2015 18:00:51 +0100
Subject: [RFC 11/23] xen: Add Xen specific page definition
In-Reply-To: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1431622863-28575-12-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Xen hypercall interface is always using 4K page granularity on ARM
and x86 architecture.

With the incoming support of 64K page granularity for ARM64 guest, it
won't be possible to re-use the Linux page definition in Xen drivers.

Introduce Xen page definition helpers based on the Linux page
definition. They have exactly the same name but prefixed with
XEN_/xen_ prefix.

Also modify page_to_pfn to use new Xen page definition.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>
---
 include/xen/page.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/xen/page.h b/include/xen/page.h
index c5ed20b..89ae01c 100644
--- a/include/xen/page.h
+++ b/include/xen/page.h
@@ -1,11 +1,28 @@
 #ifndef _XEN_PAGE_H
 #define _XEN_PAGE_H
 
+#include <asm/page.h>
+
+/* The hypercall interface supports only 4KB page */
+#define XEN_PAGE_SHIFT	12
+#define XEN_PAGE_SIZE	(_AC(1,UL) << XEN_PAGE_SHIFT)
+#define XEN_PAGE_MASK	(~(XEN_PAGE_SIZE-1))
+#define xen_offset_in_page(p)	((unsigned long)(p) & ~XEN_PAGE_MASK)
+#define xen_pfn_to_page(pfn)	\
+	((pfn_to_page(((unsigned long)(pfn) << XEN_PAGE_SHIFT) >> PAGE_SHIFT)))
+#define xen_page_to_pfn(page)	\
+	(((page_to_pfn(page)) << PAGE_SHIFT) >> XEN_PAGE_SHIFT)
+
+#define XEN_PFN_PER_PAGE	(PAGE_SIZE / XEN_PAGE_SIZE)
+
+#define XEN_PFN_DOWN(x)	((x) >> XEN_PAGE_SHIFT)
+#define XEN_PFN_PHYS(x)	((phys_addr_t)(x) << XEN_PAGE_SHIFT)
+
 #include <asm/xen/page.h>
 
 static inline unsigned long page_to_mfn(struct page *page)
 {
-	return pfn_to_mfn(page_to_pfn(page));
+	return pfn_to_mfn(xen_page_to_pfn(page));
 }
 
 struct xen_memory_region {
-- 
2.1.4
