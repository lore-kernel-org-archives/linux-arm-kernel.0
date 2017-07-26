From: dsafonov@virtuozzo.com (Dmitry Safonov)
Date: Wed, 26 Jul 2017 20:07:37 +0300
Subject: [PATCH] arm64/vdso: Support mremap() for vDSO
Message-ID: <20170726170737.21696-1-dsafonov@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vDSO VMA address is saved in mm_context for the purpose of using
restorer from vDSO page to return to userspace after signal handling.

In Checkpoint Restore in Userspace (CRIU) project we place vDSO VMA
on restore back to the place where it was on the dump.
With the exception for x86 (where there is API to map vDSO with
arch_prctl()), we move vDSO inherited from CRIU task to restoree
position by mremap().

CRIU does support arm64 architecture, but kernel doesn't update
context.vdso pointer after mremap(). Which results in translation
fault after signal handling on restored application:
https://github.com/xemul/criu/issues/288

Make vDSO code track the VMA address by supplying .mremap() fops
the same way it's done for x86 and arm32 by:
commit b059a453b1cf ("x86/vdso: Add mremap hook to vm_special_mapping")
commit 280e87e98c09 ("ARM: 8683/1: ARM32: Support mremap() for sigpage/vDSO").

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Pavel Emelyanov <xemul@virtuozzo.com>
Cc: Christopher Covington <cov@codeaurora.org>
Signed-off-by: Dmitry Safonov <dsafonov@virtuozzo.com>
---
 arch/arm64/kernel/vdso.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index e8f759f764f2..2d419006ad43 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -110,12 +110,27 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
 }
 #endif /* CONFIG_COMPAT */
 
+static int vdso_mremap(const struct vm_special_mapping *sm,
+		struct vm_area_struct *new_vma)
+{
+	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
+	unsigned long vdso_size = vdso_end - vdso_start;
+
+	if (vdso_size != new_size)
+		return -EINVAL;
+
+	current->mm->context.vdso = (void *)new_vma->vm_start;
+
+	return 0;
+}
+
 static struct vm_special_mapping vdso_spec[2] __ro_after_init = {
 	{
 		.name	= "[vvar]",
 	},
 	{
 		.name	= "[vdso]",
+		.mremap = vdso_mremap,
 	},
 };
 
-- 
2.13.3
