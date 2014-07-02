From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Jul 2014 15:40:50 +0100
Subject: [PATCH v7 8/9] ARM: vdso initialization, mapping, and
 synchronization
In-Reply-To: <CALCETrWeTeeuz4vW6wrhtDrdg54O-hhFbspfKEEunRZ0zf7ZBg@mail.gmail.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <1403493118-7597-9-git-send-email-nathan_lynch@mentor.com>
 <53B1D8AC.7060104@mit.edu> <20140701090309.GC28164@arm.com>
 <53B2C178.30607@mentor.com> <20140701141541.GP28164@arm.com>
 <CALCETrWeTeeuz4vW6wrhtDrdg54O-hhFbspfKEEunRZ0zf7ZBg@mail.gmail.com>
Message-ID: <20140702144050.GD24879@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Tue, Jul 01, 2014 at 03:17:23PM +0100, Andy Lutomirski wrote:
> On Tue, Jul 1, 2014 at 7:15 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Jul 01, 2014 at 03:11:04PM +0100, Nathan Lynch wrote:
> >> I believe Andy is suggesting separate VMAs (with different VM flags) for
> >> the VDSO's data and code.  So, breakpoints in code would work, but
> >> attempts to modify the data page via ptrace() would fail outright
> >> instead of silently COWing.
> >
> > Ah, yes. That makes a lot of sense for the data page -- we should do
> > something similar on arm64 too, since the CoW will break everything for the
> > task being debugged. We could also drop the EXEC flags too.
> 
> If you do this, I have a slight preference for the new vma being
> called "[vvar]" to match x86.  It'll make the CRIU people happy if and
> when they port it to ARM.

I quickly hacked something (see below) and now I see the following in
/proc/$$/maps:

7fa1574000-7fa1575000 r-xp 00000000 00:00 0                              [vdso]
7fa1575000-7fa1576000 r--p 00000000 00:00 0                              [vvar]

Is that what you're after?

Will

--->8

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 50384fec56c4..84cafbc3eb54 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -138,11 +138,12 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 				int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
-	unsigned long vdso_base, vdso_mapping_len;
+	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
 	int ret;
 
+	vdso_text_len = vdso_pages << PAGE_SHIFT;
 	/* Be sure to map the data page */
-	vdso_mapping_len = (vdso_pages + 1) << PAGE_SHIFT;
+	vdso_mapping_len = vdso_text_len + PAGE_SIZE;
 
 	down_write(&mm->mmap_sem);
 	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
@@ -152,35 +153,52 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 	}
 	mm->context.vdso = (void *)vdso_base;
 
-	ret = install_special_mapping(mm, vdso_base, vdso_mapping_len,
+	ret = install_special_mapping(mm, vdso_base, vdso_text_len,
 				      VM_READ|VM_EXEC|
 				      VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
 				      vdso_pagelist);
-	if (ret) {
-		mm->context.vdso = NULL;
+	if (ret)
+		goto up_fail;
+
+	vdso_base += vdso_text_len;
+	ret = install_special_mapping(mm, vdso_base, PAGE_SIZE,
+				      VM_READ|VM_MAYREAD,
+				      vdso_pagelist + vdso_pages);
+	if (ret)
 		goto up_fail;
-	}
 
-up_fail:
 	up_write(&mm->mmap_sem);
+	return 0;
 
+up_fail:
+	mm->context.vdso = NULL;
+	up_write(&mm->mmap_sem);
 	return ret;
 }
 
 const char *arch_vma_name(struct vm_area_struct *vma)
 {
+	unsigned long vdso_text;
+
+	if (!vma->vm_mm)
+		return NULL;
+
+	vdso_text = (unsigned long)vma->vm_mm->context.vdso;
+
 	/*
 	 * We can re-use the vdso pointer in mm_context_t for identifying
 	 * the vectors page for compat applications. The vDSO will always
 	 * sit above TASK_UNMAPPED_BASE and so we don't need to worry about
 	 * it conflicting with the vectors base.
 	 */
-	if (vma->vm_mm && vma->vm_start == (long)vma->vm_mm->context.vdso) {
+	if (vma->vm_start == vdso_text) {
 #ifdef CONFIG_COMPAT
 		if (vma->vm_start == AARCH32_VECTORS_BASE)
 			return "[vectors]";
 #endif
 		return "[vdso]";
+	} else if (vma->vm_start == (vdso_text + (vdso_pages << PAGE_SHIFT))) {
+		return "[vvar]";
 	}
 
 	return NULL;
