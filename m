From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 9 Oct 2013 21:48:30 +0100
Subject: [PATCH v8 17/17] grant-table: call set_phys_to_machine after mapping
 grant refs
In-Reply-To: <alpine.DEB.2.02.1310092109190.26077@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1310092109190.26077@kaball.uk.xensource.com>
Message-ID: <1381351710-1876-17-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When mapping/unmapping grant refs, call
set_phys_to_machine to update the P2M with the new mappings for
autotranslate guests.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 drivers/xen/grant-table.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 04cdeb8..a36cb03 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -49,6 +49,7 @@
 #include <xen/grant_table.h>
 #include <xen/interface/memory.h>
 #include <xen/hvc-console.h>
+#include <xen/swiotlb-xen.h>
 #include <asm/xen/hypercall.h>
 #include <asm/xen/interface.h>
 
@@ -889,8 +890,15 @@ int gnttab_map_refs(struct gnttab_map_grant_ref *map_ops,
 			gnttab_retry_eagain_gop(GNTTABOP_map_grant_ref, map_ops + i,
 						&map_ops[i].status, __func__);
 
-	if (xen_feature(XENFEAT_auto_translated_physmap))
+	if (xen_feature(XENFEAT_auto_translated_physmap)) {
+		for (i = 0; i < count; i++) {
+			if (map_ops[i].status)
+				continue;
+			set_phys_to_machine(map_ops[i].host_addr >> PAGE_SHIFT,
+					map_ops[i].dev_bus_addr >> PAGE_SHIFT);
+		}
 		return ret;
+	}
 
 	if (!in_interrupt() && paravirt_get_lazy_mode() == PARAVIRT_LAZY_NONE) {
 		arch_enter_lazy_mmu_mode();
@@ -933,8 +941,13 @@ int gnttab_unmap_refs(struct gnttab_unmap_grant_ref *unmap_ops,
 	if (ret)
 		return ret;
 
-	if (xen_feature(XENFEAT_auto_translated_physmap))
+	if (xen_feature(XENFEAT_auto_translated_physmap)) {
+		for (i = 0; i < count; i++) {
+			set_phys_to_machine(unmap_ops[i].host_addr >> PAGE_SHIFT,
+					INVALID_P2M_ENTRY);
+		}
 		return ret;
+	}
 
 	if (!in_interrupt() && paravirt_get_lazy_mode() == PARAVIRT_LAZY_NONE) {
 		arch_enter_lazy_mmu_mode();
-- 
1.7.2.5
