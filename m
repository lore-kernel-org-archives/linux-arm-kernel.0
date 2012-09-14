From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 14 Sep 2012 12:13:20 +0100
Subject: [PATCH v4 18/24] xen: allow privcmd for HVM guests
In-Reply-To: <alpine.DEB.2.02.1209141145150.29232@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1209141145150.29232@kaball.uk.xensource.com>
Message-ID: <1347621207-11294-18-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the "return -ENOSYS" for auto_translated_physmap
guests from privcmd_mmap, thus it allows ARM guests to issue privcmd
mmap calls. However privcmd mmap calls are still going to fail for HVM
and hybrid guests on x86 because the xen_remap_domain_mfn_range
implementation is currently PV only.

Changes in v2:

- better commit message;
- return -EINVAL from xen_remap_domain_mfn_range if
  auto_translated_physmap.


Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/xen/mmu.c    |    3 +++
 drivers/xen/privcmd.c |    4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/xen/mmu.c b/arch/x86/xen/mmu.c
index 5141d80..984cf66 100644
--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -2337,6 +2337,9 @@ int xen_remap_domain_mfn_range(struct vm_area_struct *vma,
 	unsigned long range;
 	int err = 0;
 
+	if (xen_feature(XENFEAT_auto_translated_physmap))
+		return -EINVAL;
+
 	prot = __pgprot(pgprot_val(prot) | _PAGE_IOMAP);
 
 	BUG_ON(!((vma->vm_flags & (VM_PFNMAP | VM_RESERVED | VM_IO)) ==
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index ccee0f1..85226cb 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -380,10 +380,6 @@ static struct vm_operations_struct privcmd_vm_ops = {
 
 static int privcmd_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	/* Unsupported for auto-translate guests. */
-	if (xen_feature(XENFEAT_auto_translated_physmap))
-		return -ENOSYS;
-
 	/* DONTCOPY is essential for Xen because copy_page_range doesn't know
 	 * how to recreate these mappings */
 	vma->vm_flags |= VM_RESERVED | VM_IO | VM_DONTCOPY | VM_PFNMAP;
-- 
1.7.2.5
