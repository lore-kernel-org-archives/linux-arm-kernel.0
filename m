From: jwboyer@redhat.com (Josh Boyer)
Date: Mon, 18 Nov 2013 08:48:07 -0500
Subject: [PATCH] arm/xen: Export phys_to_mach to fix Xen module link errors
Message-ID: <20131118134806.GA1908@hansolo.jdub.homelinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Various xen drivers fail to link when built as modules with the following
error:

ERROR: "phys_to_mach" [drivers/xen/xen-gntalloc.ko] undefined!
ERROR: "phys_to_mach" [drivers/net/xen-netfront.ko] undefined!
ERROR: "phys_to_mach" [drivers/net/xen-netback/xen-netback.ko] undefined!
ERROR: "phys_to_mach" [drivers/block/xen-blkfront.ko] undefined!

The mfn_to_pfn and pfn_to_mfn functions get inlined in these modules and
those functions require phys_to_mach.  Export the symbol to fix the link
errors.

Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
---
 arch/arm/xen/p2m.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/xen/p2m.c b/arch/arm/xen/p2m.c
index 23732cd..0f842e8 100644
--- a/arch/arm/xen/p2m.c
+++ b/arch/arm/xen/p2m.c
@@ -27,6 +27,7 @@ struct xen_p2m_entry {
 
 rwlock_t p2m_lock;
 struct rb_root phys_to_mach = RB_ROOT;
+EXPORT_SYMBOL_GPL(phys_to_mach);
 static struct rb_root mach_to_phys = RB_ROOT;
 
 static int xen_add_phys_to_mach_entry(struct xen_p2m_entry *new)
-- 
1.8.3.1
