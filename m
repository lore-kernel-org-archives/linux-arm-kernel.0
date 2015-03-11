From: schwab@suse.de (Andreas Schwab)
Date: Wed, 11 Mar 2015 14:35:39 +0100
Subject: [PATCH] arm64: Enable CONFIG_COMPAT also for 64k page size
In-Reply-To: <C0CF99B1-8706-4D9B-87E0-13A7C6C619D6@suse.de> (Alexander Graf's
 message of "Wed, 11 Mar 2015 08:08:41 -0500")
References: <1417707993-82290-1-git-send-email-agraf@suse.de>
 <20141208101026.GD27367@arm.com> <550025E0.7030008@suse.de>
 <5396604.TRferrWZgF@wuerfel>
 <C0CF99B1-8706-4D9B-87E0-13A7C6C619D6@suse.de>
Message-ID: <mvmegovejx0.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 29457829093014f39c7d1c926c9b86b6cb5709db Mon Sep 17 00:00:00 2001
From: Andreas Schwab <schwab@suse.de>
Date: Mon, 9 Mar 2015 17:27:36 +0100
Subject: [PATCH] arm64: fix implementation of mmap2 compat syscall

The arm mmap2 syscall takes the offset in units of 4K, thus with 64K pages
the offset needs to be scaled to units of pages.
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
index 2d5ab3c..61e416d 100644
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
+#if PAGE_SIZE > 12
+asmlinkage long compat_sys_mmap2_wrapper(void);
+#else
+#define compat_sys_mmap2_wrapper sys_mmap_pgoff
+#endif
 
 #undef __SYSCALL
 #define __SYSCALL(nr, sym)	[nr] = sym,
-- 
2.3.2


Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
