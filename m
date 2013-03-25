From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Mar 2013 18:18:06 +0000
Subject: [PATCH 3/3] ARM: cacheflush: add new iovec-based cache flushing
 system call
In-Reply-To: <1364235486-17738-1-git-send-email-will.deacon@arm.com>
References: <1364235486-17738-1-git-send-email-will.deacon@arm.com>
Message-ID: <1364235486-17738-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cacheflush system call flushes a contiguous range, specified by a
pair of addresses. This means that user applications wishing to flush
discrete ranges must issue multiple system calls, since attempting to
flush past a vma results in range truncation.

This patch introduces a new private system call for ARM, cacheflush_iov,
which processes a range of addresses described in an iovec structure.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/uapi/asm/unistd.h |  1 +
 arch/arm/kernel/traps.c            | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm/include/uapi/asm/unistd.h b/arch/arm/include/uapi/asm/unistd.h
index af33b44..bcad38c 100644
--- a/arch/arm/include/uapi/asm/unistd.h
+++ b/arch/arm/include/uapi/asm/unistd.h
@@ -421,6 +421,7 @@
 #define __ARM_NR_usr26			(__ARM_NR_BASE+3)
 #define __ARM_NR_usr32			(__ARM_NR_BASE+4)
 #define __ARM_NR_set_tls		(__ARM_NR_BASE+5)
+#define __ARM_NR_cacheflush_iov		(__ARM_NR_BASE+6)
 
 /*
  * *NOTE*: This is a ghost syscall private to the kernel.  Only the
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index da5e268..f83eed6 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/sched.h>
+#include <linux/slab.h>
 
 #include <linux/atomic.h>
 #include <asm/cacheflush.h>
@@ -515,6 +516,37 @@ do_cache_op(unsigned long start, unsigned long end, int flags)
 	return flush_cache_user_range(start, end);
 }
 
+static inline int
+do_cache_op_iov(const struct iovec __user *uiov, unsigned long cnt, int flags)
+{
+	int i, ret = 0;
+	unsigned long len = cnt * sizeof(struct iovec);
+	struct iovec *iov = kmalloc(len, GFP_KERNEL);
+
+	if (iov == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (copy_from_user(iov, uiov, len)) {
+		ret = -EFAULT;
+		goto out_free;
+	}
+
+	for (i = 0; i < cnt; ++i) {
+		unsigned long start = (unsigned long __force)iov[i].iov_base;
+		unsigned long end = start + iov[i].iov_len;
+		ret = do_cache_op(start, end, flags);
+		if (ret)
+			break;
+	}
+
+out_free:
+	kfree(iov);
+out:
+	return ret;
+}
+
 /*
  * Handle all unrecognised system calls.
  *  0x9f0000 - 0x9fffff are some more esoteric system calls
@@ -560,6 +592,10 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs)
 	case NR(cacheflush):
 		return do_cache_op(regs->ARM_r0, regs->ARM_r1, regs->ARM_r2);
 
+	case NR(cacheflush_iov):
+		return do_cache_op_iov((const struct iovec __user *)regs->ARM_r0,
+					regs->ARM_r1, regs->ARM_r2);
+
 	case NR(usr26):
 		if (!(elf_hwcap & HWCAP_26BIT))
 			break;
-- 
1.8.0
