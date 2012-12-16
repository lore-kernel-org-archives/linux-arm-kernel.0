From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Sun, 16 Dec 2012 00:25:57 +0000
Subject: [PATCH] missing ->mmap_sem around find_vma() in swp_emulate.c
Message-ID: <20121216002557.GY4939@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

find_vma() is *not* safe when somebody else is removing vmas.  Not just
the return value might get bogus just as you are getting it (this instance
doesn't try to dereference the resulting vma), the search itself can get
buggered in rather spectacular ways.  IOW, ->mmap_sem really, really is
not optional here.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
index df74518..ab1017b 100644
--- a/arch/arm/kernel/swp_emulate.c
+++ b/arch/arm/kernel/swp_emulate.c
@@ -109,10 +109,12 @@ static void set_segfault(struct pt_regs *regs, unsigned long addr)
 {
 	siginfo_t info;
 
+	down_read(&current->mm->mmap_sem);
 	if (find_vma(current->mm, addr) == NULL)
 		info.si_code = SEGV_MAPERR;
 	else
 		info.si_code = SEGV_ACCERR;
+	up_read(&current->mm->mmap_sem);
 
 	info.si_signo = SIGSEGV;
 	info.si_errno = 0;
