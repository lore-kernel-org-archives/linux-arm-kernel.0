From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 30 Sep 2015 11:45:20 +0100
Subject: [PATCH v5 05/22] xen/grant: Add helper
 gnttab_page_grant_foreign_access_ref_one
In-Reply-To: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
References: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1443609937-25278-6-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many PV drivers contain the idiom:

pfn = page_to_gfn(...) /* Or similar */
gnttab_grant_foreign_access_ref

Replace it by a new helper. Note that when Linux is using a different
page granularity than Xen, the helper only gives access to the first 4KB
grant.

This is useful where drivers are allocating a full Linux page for each
grant.

Also include xen/interface/grant_table.h rather than xen/grant_table.h in
asm/page.h for x86 to fix a compilation issue [1]. Only the former is
useful in order to get the structure definition.

[1] Interdependency between asm/page.h and xen/grant_table.h which result
to page_mfn not being defined when necessary.

Signed-off-by: Julien Grall <julien.grall@linaro.org>
Reviewed-by: David Vrabel <david.vrabel@citrix.com>
Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>

    Changes in v3:
        - Rename gnttab_page_grant_foreign_access_ref into
        gnttab_page_grant_foreign_access_ref_one
        - Fix typo in the commit message
        - s/mfn/gfn based on the new naming
        - Add David and Stefano's reviewed-by

    Changes in v2:
        - Patch added
---
 include/xen/grant_table.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/xen/grant_table.h b/include/xen/grant_table.h
index 05b5b08..e17a4b3 100644
--- a/include/xen/grant_table.h
+++ b/include/xen/grant_table.h
@@ -131,6 +131,15 @@ void gnttab_cancel_free_callback(struct gnttab_free_callback *callback);
 void gnttab_grant_foreign_access_ref(grant_ref_t ref, domid_t domid,
 				     unsigned long frame, int readonly);
 
+/* Give access to the first 4K of the page */
+static inline void gnttab_page_grant_foreign_access_ref_one(
+	grant_ref_t ref, domid_t domid,
+	struct page *page, int readonly)
+{
+	gnttab_grant_foreign_access_ref(ref, domid, xen_page_to_gfn(page),
+					readonly);
+}
+
 void gnttab_grant_foreign_transfer_ref(grant_ref_t, domid_t domid,
 				       unsigned long pfn);
 
-- 
2.1.4
