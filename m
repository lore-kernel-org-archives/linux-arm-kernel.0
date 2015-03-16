From: agraf@suse.de (Alexander Graf)
Date: Mon, 16 Mar 2015 17:32:22 +0100
Subject: [PATCH 1/2] arm64: fix implementation of mmap2 compat syscall
In-Reply-To: <1426523543-4124-1-git-send-email-agraf@suse.de>
References: <1426523543-4124-1-git-send-email-agraf@suse.de>
Message-ID: <1426523543-4124-2-git-send-email-agraf@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andreas Schwab <schwab@suse.de>

The arm mmap2 syscall takes the offset in units of 4K, thus with 64K pages
the offset needs to be scaled to units of pages.

Signed-off-by: Andreas Schwab <schwab@suse.de>
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/arm64/include/asm/unistd32.h |  2 +-
 arch/arm64/kernel/entry32.S       | 18 ++++++++++++++++++
 arch/arm64/kernel/sys32.c         |  6 ++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 2722442..cef934a 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -406,7 +406,7 @@ __SYSCALL(__NR_vfork, sys_vfork)
 #define __NR_ugetrlimit 191	/* SuS compliant getrlimit */
 __SYSCALL(__NR_ugetrlimit, compat_sys_getrlimit)		/* SuS compliant getrlimit */
 #define __NR_mmap2 192
-__SYSCALL(__NR_mmap2, sys_mmap_pgoff)
+__SYSCALL(__NR_mmap2, compat_sys_mmap2_wrapper)
 #define __NR_truncate64 193
 __SYSCALL(__NR_truncate64, compat_sys_truncate64_wrapper)
 #define __NR_ftruncate64 194
diff --git a/arch/arm64/kernel/entry32.S b/arch/arm64/kernel/entry32.S
index 9a8f6ae..17f3296 100644
--- a/arch/arm64/kernel/entry32.S
+++ b/arch/arm64/kernel/entry32.S
@@ -19,9 +19,12 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/const.h>
 
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
+#include <asm/errno.h>
+#include <asm/page.h>
 
 /*
  * System call wrappers for the AArch32 compatibility layer.
@@ -54,6 +57,21 @@ ENTRY(compat_sys_fstatfs64_wrapper)
 ENDPROC(compat_sys_fstatfs64_wrapper)
 
 /*
+ * Note: off_4k (w5) is always units of 4K.  If we can't do the requested
+ * offset, we return EINVAL.
+ */
+#if PAGE_SHIFT > 12
+ENTRY(compat_sys_mmap2_wrapper)
+	tst	w5, #~PAGE_MASK >> 12
+	b.ne	1f
+	lsr	w5, w5, #PAGE_SHIFT - 12
+	b	sys_mmap_pgoff
+1:	mov	x0, #-EINVAL
+	ret	lr
+ENDPROC(compat_sys_mmap2_wrapper)
+#endif
+
+/*
  * Wrappers for AArch32 syscalls that either take 64-bit parameters
  * in registers or that take 32-bit parameters which require sign
  * extension.
diff --git a/arch/arm64/kernel/sys32.c b/arch/arm64/kernel/sys32.c
index 2d5ab3c..7800bb1 100644
--- a/arch/arm64/kernel/sys32.c
+++ b/arch/arm64/kernel/sys32.c
@@ -24,6 +24,7 @@
 
 #include <linux/compiler.h>
 #include <linux/syscalls.h>
+#include <asm/page.h>
 
 asmlinkage long compat_sys_sigreturn_wrapper(void);
 asmlinkage long compat_sys_rt_sigreturn_wrapper(void);
@@ -37,6 +38,11 @@ asmlinkage long compat_sys_readahead_wrapper(void);
 asmlinkage long compat_sys_fadvise64_64_wrapper(void);
 asmlinkage long compat_sys_sync_file_range2_wrapper(void);
 asmlinkage long compat_sys_fallocate_wrapper(void);
+#if PAGE_SHIFT > 12
+asmlinkage long compat_sys_mmap2_wrapper(void);
+#else
+#define compat_sys_mmap2_wrapper sys_mmap_pgoff
+#endif
 
 #undef __SYSCALL
 #define __SYSCALL(nr, sym)	[nr] = sym,
-- 
2.1.4
