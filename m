From: yangyingliang@huawei.com (Yang Yingliang)
Date: Wed, 1 Jun 2016 11:05:59 +0800
Subject: [RFC PATCH 1/4] arm64: vdso: introdce a macro for checking the address
In-Reply-To: <1464750362-14188-1-git-send-email-yangyingliang@huawei.com>
References: <1464750362-14188-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <1464750362-14188-2-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a RANGE_OK macro for validation checking of the
address given by user.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/arm64/kernel/asm-offsets.c       |  3 +++
 arch/arm64/kernel/vdso/gettimeofday.S | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 574081f..b72c2df 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -98,11 +98,14 @@ int main(void)
   BLANK();
   DEFINE(TVAL_TV_SEC,		offsetof(struct timeval, tv_sec));
   DEFINE(TVAL_TV_USEC,		offsetof(struct timeval, tv_usec));
+  DEFINE(TVAL_SZ,		sizeof(struct timeval));
   DEFINE(TSPEC_TV_SEC,		offsetof(struct timespec, tv_sec));
   DEFINE(TSPEC_TV_NSEC,		offsetof(struct timespec, tv_nsec));
+  DEFINE(TSPEC_SZ,		sizeof(struct timespec));
   BLANK();
   DEFINE(TZ_MINWEST,		offsetof(struct timezone, tz_minuteswest));
   DEFINE(TZ_DSTTIME,		offsetof(struct timezone, tz_dsttime));
+  DEFINE(TZ_SZ,			sizeof(struct timezone));
   BLANK();
 #ifdef CONFIG_KVM_ARM_HOST
   DEFINE(VCPU_CONTEXT,		offsetof(struct kvm_vcpu, arch.ctxt));
diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index efa79e8..05ccaca 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -21,10 +21,31 @@
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
 #include <asm/unistd.h>
+#include <asm/memory.h>
 
 #define NSEC_PER_SEC_LO16	0xca00
 #define NSEC_PER_SEC_HI16	0x3b9a
 
+#define USER_DS		TASK_SIZE_64
+/*
+ * Test whether a block of memory is a valid user space address.
+ * Returns 1 if the range is valid, 0 otherwise.
+ *
+ * This is equivalent to the following test:
+ * (u65)addr + (u65)size <= USER_DS
+ *
+ * This needs 65-bit arithmetic.
+ *
+ * x##n - addr
+ * sz - size
+ * x3 - USER_DS
+ * x4 - return value
+ */
+#define RANGE_OK(n, sz)	mov	x3, #USER_DS;		\
+			adds	x4, x##n, sz;		\
+			ccmp	x4, x3, #0x2, cc;	\
+			cset	x4, ls
+
 vdso_data	.req	x6
 use_syscall	.req	w7
 seqcnt		.req	w8
-- 
2.5.0
