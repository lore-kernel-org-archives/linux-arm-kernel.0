From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Jul 2012 16:33:59 +0100
Subject: [PATCH 17/24] xen: allow privcmd for HVM guests
In-Reply-To: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
Message-ID: <1343316846-25860-17-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order for privcmd mmap to work correctly, xen_remap_domain_mfn_range
needs to be implemented for HVM guests.
If it is not, mmap is going to fail later on.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 drivers/xen/privcmd.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

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
