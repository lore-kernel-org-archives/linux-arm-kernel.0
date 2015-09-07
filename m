From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 7 Sep 2015 16:33:58 +0100
Subject: [PATCH v4 20/20] arm/xen: Add support for 64KB page granularity
In-Reply-To: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
References: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1441640038-23615-21-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hypercall interface is always using 4KB page granularity. This is
requiring to use xen page definition macro when we deal with hypercall.

Note that pfn_to_gfn is working with a Xen pfn (i.e 4KB). We may want to
rename pfn_gfn to make this explicit.

We also allocate a 64KB page for the shared page even though only the
first 4KB is used. I don't think this is really important for now as it
helps to have the pointer 4KB aligned (XENMEM_add_to_physmap is taking a
Xen PFN).

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---
Cc: Russell King <linux@arm.linux.org.uk>

Stefano, I've dropped your reviewed-by given I've updated the doc and do
changes to avoid usage of XEN_PAGE_SHIFT

    Changes in v4:
        - Add Stefano's Reviewed-by

    Changes in v3:
        - s/MFN/GFN/ base on the new naming
        - Use virt_to_gfn to avoid use XEN_PAGE_SHIFT
        - Drop Stefano's reviewed-by
        - Add some docs in arch/arm/asm/xen/page.h

    Changes in v2
        - Add Stefano's reviewed-by
---
 arch/arm/include/asm/xen/page.h | 15 +++++++++++++--
 arch/arm/xen/enlighten.c        |  6 +++---
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/page.h
index 98c9fc3..e3d94cf 100644
--- a/arch/arm/include/asm/xen/page.h
+++ b/arch/arm/include/asm/xen/page.h
@@ -28,6 +28,17 @@ typedef struct xpaddr {
 
 #define INVALID_P2M_ENTRY      (~0UL)
 
+/*
+ * The pseudo-physical frame (pfn) used in all the helpers is always based
+ * on Xen page granularity (i.e 4KB).
+ *
+ * A Linux page may be split across multiple non-contiguous Xen page so we
+ * have to keep track with frame based on 4KB page granularity.
+ *
+ * PV drivers should never make a direct usage of those helpers (particularly
+ * pfn_to_gfn and gfn_to_pfn).
+ */
+
 unsigned long __pfn_to_mfn(unsigned long pfn);
 extern struct rb_root phys_to_mach;
 
@@ -64,8 +75,8 @@ static inline unsigned long bfn_to_pfn(unsigned long bfn)
 #define bfn_to_local_pfn(bfn)	bfn_to_pfn(bfn)
 
 /* VIRT <-> GUEST conversion */
-#define virt_to_gfn(v)		(pfn_to_gfn(virt_to_pfn(v)))
-#define gfn_to_virt(m)		(__va(gfn_to_pfn(m) << PAGE_SHIFT))
+#define virt_to_gfn(v)		(pfn_to_gfn(virt_to_phys(v) >> XEN_PAGE_SHIFT))
+#define gfn_to_virt(m)		(__va(gfn_to_pfn(m) << XEN_PAGE_SHIFT))
 
 /* Only used in PV code. But ARM guests are always HVM. */
 static inline xmaddr_t arbitrary_virt_to_machine(void *vaddr)
diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index eeeab07..50b4769 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -89,8 +89,8 @@ static void xen_percpu_init(void)
 	pr_info("Xen: initializing cpu%d\n", cpu);
 	vcpup = per_cpu_ptr(xen_vcpu_info, cpu);
 
-	info.mfn = __pa(vcpup) >> PAGE_SHIFT;
-	info.offset = offset_in_page(vcpup);
+	info.mfn = virt_to_gfn(vcpup);
+	info.offset = xen_offset_in_page(vcpup);
 
 	err = HYPERVISOR_vcpu_op(VCPUOP_register_vcpu_info, cpu, &info);
 	BUG_ON(err);
@@ -213,7 +213,7 @@ static int __init xen_guest_init(void)
 	xatp.domid = DOMID_SELF;
 	xatp.idx = 0;
 	xatp.space = XENMAPSPACE_shared_info;
-	xatp.gpfn = __pa(shared_info_page) >> PAGE_SHIFT;
+	xatp.gpfn = virt_to_gfn(shared_info_page);
 	if (HYPERVISOR_memory_op(XENMEM_add_to_physmap, &xatp))
 		BUG();
 
-- 
2.1.4
