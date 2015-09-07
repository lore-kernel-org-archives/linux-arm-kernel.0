From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 7 Sep 2015 16:33:52 +0100
Subject: [PATCH v4 14/20] xen/grant-table: Make it running on 64KB granularity
In-Reply-To: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
References: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1441640038-23615-15-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Xen interface is using 4KB page granularity. This means that each
grant is 4KB.

The current implementation allocates a Linux page per grant. On Linux
using 64KB page granularity, only the first 4KB of the page will be
used.

We could decrease the memory wasted by sharing the page with multiple
grant. It will require some care with the {Set,Clear}ForeignPage macro.

Note that no changes has been made in the x86 code because both Linux
and Xen will only use 4KB page granularity.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Reviewed-by: David Vrabel <david.vrabel@citrix.com>
Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>

    Changes in v3:
        - Add Stefano's reviewed-by

    Changes in v2
        - Add David's reviewed-by
---
 arch/arm/xen/p2m.c        | 6 +++---
 drivers/xen/grant-table.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/xen/p2m.c b/arch/arm/xen/p2m.c
index 887596c..0ed01f2 100644
--- a/arch/arm/xen/p2m.c
+++ b/arch/arm/xen/p2m.c
@@ -93,8 +93,8 @@ int set_foreign_p2m_mapping(struct gnttab_map_grant_ref *map_ops,
 	for (i = 0; i < count; i++) {
 		if (map_ops[i].status)
 			continue;
-		set_phys_to_machine(map_ops[i].host_addr >> PAGE_SHIFT,
-				    map_ops[i].dev_bus_addr >> PAGE_SHIFT);
+		set_phys_to_machine(map_ops[i].host_addr >> XEN_PAGE_SHIFT,
+				    map_ops[i].dev_bus_addr >> XEN_PAGE_SHIFT);
 	}
 
 	return 0;
@@ -108,7 +108,7 @@ int clear_foreign_p2m_mapping(struct gnttab_unmap_grant_ref *unmap_ops,
 	int i;
 
 	for (i = 0; i < count; i++) {
-		set_phys_to_machine(unmap_ops[i].host_addr >> PAGE_SHIFT,
+		set_phys_to_machine(unmap_ops[i].host_addr >> XEN_PAGE_SHIFT,
 				    INVALID_P2M_ENTRY);
 	}
 
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 7b4e1cf..99ed9c2 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -642,7 +642,7 @@ int gnttab_setup_auto_xlat_frames(phys_addr_t addr)
 	if (xen_auto_xlat_grant_frames.count)
 		return -EINVAL;
 
-	vaddr = xen_remap(addr, PAGE_SIZE * max_nr_gframes);
+	vaddr = xen_remap(addr, XEN_PAGE_SIZE * max_nr_gframes);
 	if (vaddr == NULL) {
 		pr_warn("Failed to ioremap gnttab share frames (addr=%pa)!\n",
 			&addr);
@@ -654,7 +654,7 @@ int gnttab_setup_auto_xlat_frames(phys_addr_t addr)
 		return -ENOMEM;
 	}
 	for (i = 0; i < max_nr_gframes; i++)
-		pfn[i] = PFN_DOWN(addr) + i;
+		pfn[i] = XEN_PFN_DOWN(addr) + i;
 
 	xen_auto_xlat_grant_frames.vaddr = vaddr;
 	xen_auto_xlat_grant_frames.pfn = pfn;
@@ -1004,7 +1004,7 @@ static void gnttab_request_version(void)
 {
 	/* Only version 1 is used, which will always be available. */
 	grant_table_version = 1;
-	grefs_per_grant_frame = PAGE_SIZE / sizeof(struct grant_entry_v1);
+	grefs_per_grant_frame = XEN_PAGE_SIZE / sizeof(struct grant_entry_v1);
 	gnttab_interface = &gnttab_v1_ops;
 
 	pr_info("Grant tables using version %d layout\n", grant_table_version);
-- 
2.1.4
