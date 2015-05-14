From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 14 May 2015 18:01:03 +0100
Subject: [RFC 23/23] arm/xen: Add support for 64KB page granularity
In-Reply-To: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1431622863-28575-24-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hypercall interface is always using 4KB page granularity. This is
requiring to use xen page definition macro when we deal with hypercall.

Note that pfn_to_mfn is working with a Xen pfn (i.e 4KB). We may want to
rename pfn_mfn to make this explicit.

We also allocate a 64KB page for the shared page even though only the
first 4KB is used. I don't think this is really important for now as it
helps to have the pointer 4KB aligned (XENMEM_add_to_physmap is taking a
Xen PFN).

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/include/asm/xen/page.h | 12 ++++++------
 arch/arm/xen/enlighten.c        |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/page.h
index 1bee8ca..ab6eb9a 100644
--- a/arch/arm/include/asm/xen/page.h
+++ b/arch/arm/include/asm/xen/page.h
@@ -56,19 +56,19 @@ static inline unsigned long mfn_to_pfn(unsigned long mfn)
 
 static inline xmaddr_t phys_to_machine(xpaddr_t phys)
 {
-	unsigned offset = phys.paddr & ~PAGE_MASK;
-	return XMADDR(PFN_PHYS(pfn_to_mfn(PFN_DOWN(phys.paddr))) | offset);
+	unsigned offset = phys.paddr & ~XEN_PAGE_MASK;
+	return XMADDR(XEN_PFN_PHYS(pfn_to_mfn(XEN_PFN_DOWN(phys.paddr))) | offset);
 }
 
 static inline xpaddr_t machine_to_phys(xmaddr_t machine)
 {
-	unsigned offset = machine.maddr & ~PAGE_MASK;
-	return XPADDR(PFN_PHYS(mfn_to_pfn(PFN_DOWN(machine.maddr))) | offset);
+	unsigned offset = machine.maddr & ~XEN_PAGE_MASK;
+	return XPADDR(XEN_PFN_PHYS(mfn_to_pfn(XEN_PFN_DOWN(machine.maddr))) | offset);
 }
 /* VIRT <-> MACHINE conversion */
 #define virt_to_machine(v)	(phys_to_machine(XPADDR(__pa(v))))
-#define virt_to_mfn(v)		(pfn_to_mfn(virt_to_pfn(v)))
-#define mfn_to_virt(m)		(__va(mfn_to_pfn(m) << PAGE_SHIFT))
+#define virt_to_mfn(v)		(pfn_to_mfn(virt_to_phys(v) >> XEN_PAGE_SHIFT))
+#define mfn_to_virt(m)		(__va(mfn_to_pfn(m) << XEN_PAGE_SHIFT))
 
 static inline xmaddr_t arbitrary_virt_to_machine(void *vaddr)
 {
diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 224081c..dcfe251 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -93,8 +93,8 @@ static void xen_percpu_init(void)
 	pr_info("Xen: initializing cpu%d\n", cpu);
 	vcpup = per_cpu_ptr(xen_vcpu_info, cpu);
 
-	info.mfn = __pa(vcpup) >> PAGE_SHIFT;
-	info.offset = offset_in_page(vcpup);
+	info.mfn = __pa(vcpup) >> XEN_PAGE_SHIFT;
+	info.offset = xen_offset_in_page(vcpup);
 
 	err = HYPERVISOR_vcpu_op(VCPUOP_register_vcpu_info, cpu, &info);
 	BUG_ON(err);
@@ -204,7 +204,7 @@ static int __init xen_guest_init(void)
 	xatp.domid = DOMID_SELF;
 	xatp.idx = 0;
 	xatp.space = XENMAPSPACE_shared_info;
-	xatp.gpfn = __pa(shared_info_page) >> PAGE_SHIFT;
+	xatp.gpfn = __pa(shared_info_page) >> XEN_PAGE_SHIFT;
 	if (HYPERVISOR_memory_op(XENMEM_add_to_physmap, &xatp))
 		BUG();
 
-- 
2.1.4
