From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:58 +0800
Subject: [PATCH v3 59/62] xen/arm: Add a hypercall for device mmio mapping
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-60-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

It needs to map platform or amba device mmio to Dom0 on ARM. But when
booting with ACPI, it can't get the mmio region in Xen due to lack of
AML interpreter to parse DSDT table. Therefore, let Dom0 call a
hypercall to map mmio region when it adds the devices.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/arch/arm/mm.c           |  4 ++++
 xen/arch/arm/p2m.c          | 34 ++++++++++++++++++++++++++++++++++
 xen/include/asm-arm/p2m.h   |  5 +++++
 xen/include/public/memory.h |  1 +
 4 files changed, 44 insertions(+)

diff --git a/xen/arch/arm/mm.c b/xen/arch/arm/mm.c
index 8b6d915..fbe0406 100644
--- a/xen/arch/arm/mm.c
+++ b/xen/arch/arm/mm.c
@@ -1138,6 +1138,10 @@ int xenmem_add_to_physmap_one(
         rcu_unlock_domain(od);
         break;
     }
+    case XENMAPSPACE_dev_mmio:
+        rc = map_dev_mmio_region(d, gpfn, 1, idx);
+        return rc;
+        break;
 
     default:
         return -ENOSYS;
diff --git a/xen/arch/arm/p2m.c b/xen/arch/arm/p2m.c
index 7a108d8..b44ad76 100644
--- a/xen/arch/arm/p2m.c
+++ b/xen/arch/arm/p2m.c
@@ -7,6 +7,7 @@
 #include <xen/bitops.h>
 #include <xen/vm_event.h>
 #include <xen/mem_access.h>
+#include <xen/iocap.h>
 #include <public/vm_event.h>
 #include <asm/flushtlb.h>
 #include <asm/gic.h>
@@ -1192,6 +1193,39 @@ int unmap_mmio_regions(struct domain *d,
                              d->arch.p2m.default_access);
 }
 
+int map_dev_mmio_region(struct domain *d,
+                        unsigned long start_gfn,
+                        unsigned long nr,
+                        unsigned long mfn)
+{
+    int res;
+
+    if(!iomem_access_permitted(d, start_gfn, start_gfn + nr))
+        return 0;
+
+    res = iomem_permit_access(d, start_gfn, (start_gfn + nr));
+    if ( res )
+    {
+        printk(XENLOG_ERR "Unable to permit to dom%d access to"
+               " 0x%"PRIx64" - 0x%"PRIx64"\n",
+               d->domain_id,
+               start_gfn << PAGE_SHIFT, (start_gfn + nr) << PAGE_SHIFT);
+        return res;
+    }
+
+    res = map_mmio_regions(d, start_gfn, nr, mfn);
+    if ( res < 0 )
+    {
+        printk(XENLOG_ERR "Unable to map 0x%"PRIx64
+               " - 0x%"PRIx64" in domain %d\n",
+               start_gfn << PAGE_SHIFT, (start_gfn + nr) << PAGE_SHIFT,
+               d->domain_id);
+        return res;
+    }
+
+    return 0;
+}
+
 int guest_physmap_add_entry(struct domain *d,
                             unsigned long gpfn,
                             unsigned long mfn,
diff --git a/xen/include/asm-arm/p2m.h b/xen/include/asm-arm/p2m.h
index b6215f9..5e9d0a1 100644
--- a/xen/include/asm-arm/p2m.h
+++ b/xen/include/asm-arm/p2m.h
@@ -168,6 +168,11 @@ int unmap_regions(struct domain *d,
                     unsigned long nr_mfns,
                     unsigned long mfn);
 
+int map_dev_mmio_region(struct domain *d,
+                        unsigned long start_gfn,
+                        unsigned long nr,
+                        unsigned long mfn);
+
 int guest_physmap_add_entry(struct domain *d,
                             unsigned long gfn,
                             unsigned long mfn,
diff --git a/xen/include/public/memory.h b/xen/include/public/memory.h
index 4df38d6..c19da1a 100644
--- a/xen/include/public/memory.h
+++ b/xen/include/public/memory.h
@@ -220,6 +220,7 @@ DEFINE_XEN_GUEST_HANDLE(xen_machphys_mapping_t);
 #define XENMAPSPACE_gmfn_range   3 /* GMFN range, XENMEM_add_to_physmap only. */
 #define XENMAPSPACE_gmfn_foreign 4 /* GMFN from another dom,
                                     * XENMEM_add_to_physmap_batch only. */
+#define XENMAPSPACE_dev_mmio     5 /* device mmio region */
 /* ` } */
 
 /*
-- 
2.1.0
