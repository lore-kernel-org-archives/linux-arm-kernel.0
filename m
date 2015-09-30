From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 30 Sep 2015 11:45:19 +0100
Subject: [PATCH v5 04/22] xen/grant: Introduce helpers to split a page into
 grant
In-Reply-To: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
References: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1443609937-25278-5-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, a grant is always based on the Xen page granularity (i.e
4KB). When Linux is using a different page granularity, a single page
will be split between multiple grants.

The new helpers will be in charge of splitting the Linux page into grants
and call a function given by the caller on each grant.

Also provide an helper to count the number of grants within a given
contiguous region.

Note that the x86/include/asm/xen/page.h is now including
xen/interface/grant_table.h rather than xen/grant_table.h. It's
necessary because xen/grant_table.h depends on asm/xen/page.h and will
break the compilation. Furthermore, only definition in
interface/grant_table.h is required.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Reviewed-by: David Vrabel <david.vrabel@citrix.com>
Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86 at kernel.org

    Changes in v4:
        - Typoes
        - Rename gnttab_one_grant into gnttab_for_one_grant
        - Add Stefano and David's reviewed-by
        - s/xen_page_to_pfn/page_to_xen_pfn/ based on the new naming

    Changes in v3:
        - Fix error reported by checkpatch.pl
        - Typoes
        - s/pfn/xen_pfn/ in gnttab_foreach_grant
        - Drop the possibility to use less data. The complexity is moved
        in netback which is the only user
        - Rename gnttab_foreach_grant into gnttab_foreach_grant_in_range
        - s/offset/start/ in gnttab_count_grant and update the
        description of the parameter
        - s/mfn/gfn base on the new terminologies
        - Add EXPORT_SYMBOL_GPL for gnttab_foreach_grant_in_range
        - Use xen_offset_in_page and XEN_PFN_DOWN whenever it's possible
        - Fix compilation on x86.

    Changes in v2:
        - Patch added
---
 arch/x86/include/asm/xen/page.h |  2 +-
 drivers/xen/grant-table.c       | 26 +++++++++++++++++++++++++
 include/xen/grant_table.h       | 42 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/xen/page.h b/arch/x86/include/asm/xen/page.h
index b922fa4..fe58e3a 100644
--- a/arch/x86/include/asm/xen/page.h
+++ b/arch/x86/include/asm/xen/page.h
@@ -12,7 +12,7 @@
 #include <asm/pgtable.h>
 
 #include <xen/interface/xen.h>
-#include <xen/grant_table.h>
+#include <xen/interface/grant_table.h>
 #include <xen/features.h>
 
 /* Xen machine address */
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index a4b702c9..dbeaa67 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -776,6 +776,32 @@ void gnttab_batch_copy(struct gnttab_copy *batch, unsigned count)
 }
 EXPORT_SYMBOL_GPL(gnttab_batch_copy);
 
+void gnttab_foreach_grant_in_range(struct page *page,
+				   unsigned int offset,
+				   unsigned int len,
+				   xen_grant_fn_t fn,
+				   void *data)
+{
+	unsigned int goffset;
+	unsigned int glen;
+	unsigned long xen_pfn;
+
+	len = min_t(unsigned int, PAGE_SIZE - offset, len);
+	goffset = xen_offset_in_page(offset);
+
+	xen_pfn = page_to_xen_pfn(page) + XEN_PFN_DOWN(offset);
+
+	while (len) {
+		glen = min_t(unsigned int, XEN_PAGE_SIZE - goffset, len);
+		fn(pfn_to_gfn(xen_pfn), goffset, glen, data);
+
+		goffset = 0;
+		xen_pfn++;
+		len -= glen;
+	}
+}
+EXPORT_SYMBOL_GPL(gnttab_foreach_grant_in_range);
+
 int gnttab_map_refs(struct gnttab_map_grant_ref *map_ops,
 		    struct gnttab_map_grant_ref *kmap_ops,
 		    struct page **pages, unsigned int count)
diff --git a/include/xen/grant_table.h b/include/xen/grant_table.h
index 4478f4b..05b5b08 100644
--- a/include/xen/grant_table.h
+++ b/include/xen/grant_table.h
@@ -45,8 +45,10 @@
 #include <asm/xen/hypervisor.h>
 
 #include <xen/features.h>
+#include <xen/page.h>
 #include <linux/mm_types.h>
 #include <linux/page-flags.h>
+#include <linux/kernel.h>
 
 #define GNTTAB_RESERVED_XENSTORE 1
 
@@ -224,4 +226,44 @@ static inline struct xen_page_foreign *xen_page_foreign(struct page *page)
 #endif
 }
 
+/* Split Linux page in chunk of the size of the grant and call fn
+ *
+ * Parameters of fn:
+ *	gfn: guest frame number
+ *	offset: offset in the grant
+ *	len: length of the data in the grant.
+ *	data: internal information
+ */
+typedef void (*xen_grant_fn_t)(unsigned long gfn, unsigned int offset,
+			       unsigned int len, void *data);
+
+void gnttab_foreach_grant_in_range(struct page *page,
+				   unsigned int offset,
+				   unsigned int len,
+				   xen_grant_fn_t fn,
+				   void *data);
+
+/* Helper to get to call fn only on the first "grant chunk" */
+static inline void gnttab_for_one_grant(struct page *page, unsigned int offset,
+					unsigned len, xen_grant_fn_t fn,
+					void *data)
+{
+	/* The first request is limited to the size of one grant */
+	len = min_t(unsigned int, XEN_PAGE_SIZE - (offset & ~XEN_PAGE_MASK),
+		    len);
+
+	gnttab_foreach_grant_in_range(page, offset, len, fn, data);
+}
+
+/* Get the number of grant in a specified region
+ *
+ * start: Offset from the beginning of the first page
+ * len: total length of data (can cross multiple page)
+ */
+static inline unsigned int gnttab_count_grant(unsigned int start,
+					      unsigned int len)
+{
+	return XEN_PFN_UP(xen_offset_in_page(start) + len);
+}
+
 #endif /* __ASM_GNTTAB_H__ */
-- 
2.1.4
