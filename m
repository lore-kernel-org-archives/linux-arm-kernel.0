From: cov@codeaurora.org (Christopher Covington)
Date: Tue,  1 Nov 2016 11:10:57 -0600
Subject: [RFC v2 3/7] arm64: Use unsigned long for VDSO
In-Reply-To: <20161101171101.24704-1-cov@codeaurora.org>
References: <20161101171101.24704-1-cov@codeaurora.org>
Message-ID: <20161101171101.24704-3-cov@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use an unsigned long type for the base address of the VDSO in order to be
compatible with the new generic VDSO remap and unmap functions originating
from PowerPC and now also used by 32-bit ARM.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 arch/arm64/include/asm/mmu.h | 2 +-
 arch/arm64/kernel/vdso.c     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 8d9fce0..5b00198 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -18,7 +18,7 @@
 
 typedef struct {
 	atomic64_t	id;
-	void		*vdso;
+	unsigned long	vdso;
 } mm_context_t;
 
 /*
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index a2c2478..4b10e72 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -97,7 +97,7 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
 
 	if (down_write_killable(&mm->mmap_sem))
 		return -EINTR;
-	current->mm->context.vdso = (void *)addr;
+	current->mm->context.vdso = addr;
 
 	/* Map vectors page at the high address. */
 	ret = _install_special_mapping(mm, addr, PAGE_SIZE,
@@ -178,7 +178,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 		goto up_fail;
 
 	vdso_base += PAGE_SIZE;
-	mm->context.vdso = (void *)vdso_base;
+	mm->context.vdso = vdso_base;
 	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
 				       VM_READ|VM_EXEC|
 				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
@@ -191,7 +191,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 	return 0;
 
 up_fail:
-	mm->context.vdso = NULL;
+	mm->context.vdso = 0;
 	up_write(&mm->mmap_sem);
 	return PTR_ERR(ret);
 }
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
