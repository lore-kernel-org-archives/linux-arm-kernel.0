From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 23 Feb 2012 17:48:24 +0000
Subject: [PATCH-WIP 03/13] xen/arm: mmu.h and page.h related definitions
In-Reply-To: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
References: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
Message-ID: <1330019314-20865-3-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/include/asm/xen/mmu.h  |   61 +++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/xen/page.h |   14 +++++++--
 2 files changed, 72 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/include/asm/xen/mmu.h

diff --git a/arch/arm/include/asm/xen/mmu.h b/arch/arm/include/asm/xen/mmu.h
new file mode 100644
index 0000000..23e9962
--- /dev/null
+++ b/arch/arm/include/asm/xen/mmu.h
@@ -0,0 +1,61 @@
+#ifndef _ASM_ARM_XEN_MMU_H
+#define _ASM_ARM_XEN_MMU_H
+
+#include <asm/page.h>
+#include <linux/types.h>
+#include <xen/interface/grant_table.h>
+
+/* Xen machine address */
+typedef struct xmaddr {
+	phys_addr_t maddr;
+} xmaddr_t;
+
+/* Xen pseudo-physical address */
+typedef struct xpaddr {
+	phys_addr_t paddr;
+} xpaddr_t;
+
+#define XMADDR(x)	((xmaddr_t) { .maddr = (x) })
+#define XPADDR(x)	((xpaddr_t) { .paddr = (x) })
+
+static inline xmaddr_t phys_to_machine(xpaddr_t phys)
+{
+	unsigned offset = phys.paddr & ~PAGE_MASK;
+	return XMADDR(PFN_PHYS(pfn_to_mfn(PFN_DOWN(phys.paddr))) | offset);
+}
+
+static inline xpaddr_t machine_to_phys(xmaddr_t machine)
+{
+	unsigned offset = machine.maddr & ~PAGE_MASK;
+	return XPADDR(PFN_PHYS(mfn_to_pfn(PFN_DOWN(machine.maddr))) | offset);
+}
+/* VIRT <-> MACHINE conversion */
+#define virt_to_machine(v)	(phys_to_machine(XPADDR(__pa(v))))
+#define virt_to_pfn(v)          (PFN_DOWN(__pa(v)))
+#define virt_to_mfn(v)		(pfn_to_mfn(virt_to_pfn(v)))
+#define mfn_to_virt(m)		(__va(mfn_to_pfn(m) << PAGE_SHIFT))
+
+static inline xmaddr_t arbitrary_virt_to_machine(void *vaddr)
+{
+	/* XXX: assuming it is mapped in the kernel 1:1 */
+	return virt_to_machine(vaddr);
+}
+
+/* XXX: this shouldn't be here */
+static inline pte_t *lookup_address(unsigned long address, unsigned int *level)
+{
+	BUG();
+	return NULL;
+}
+
+static inline int m2p_add_override(unsigned long mfn, struct page *page,
+		struct gnttab_map_grant_ref *kmap_op)
+{
+	return 0;
+}
+
+static inline int m2p_remove_override(struct page *page, bool clear_pte)
+{
+	return 0;
+}
+#endif
diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/page.h
index 17bfb55..5ee3dbe 100644
--- a/arch/arm/include/asm/xen/page.h
+++ b/arch/arm/include/asm/xen/page.h
@@ -1,8 +1,16 @@
 #ifndef _ASM_ARM_XEN_PAGE_H
 #define _ASM_ARM_XEN_PAGE_H
 
-#define mfn_to_virt(m)		(~0)
-#define mfn_to_pfn(m)		(~0)
-#define pfn_to_mfn(m)		(~0)
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <linux/types.h>
+
+#define pfn_to_mfn(pfn)			(pfn)
+#define phys_to_machine_mapping_valid	(1)
+#define mfn_to_pfn(mfn)			(mfn)
+#define mfn_to_virt(m)			(__va(mfn_to_pfn(m) << PAGE_SHIFT))
+
+#define pte_mfn	    pte_pfn
+#define mfn_pte	    pfn_pte
 
 #endif /* _ASM_ARM_XEN_PAGE_H */
-- 
1.7.2.5
