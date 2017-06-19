From: ynorov@caviumnetworks.com (Yury Norov)
Date: Mon, 19 Jun 2017 18:50:01 +0300
Subject: [PATCH 18/20] arm64: ptrace: handle ptrace_request differently for
 aarch32 and ilp32
In-Reply-To: <20170619155003.13218-1-ynorov@caviumnetworks.com>
References: <20170619155003.13218-1-ynorov@caviumnetworks.com>
Message-ID: <20170619155003.13218-19-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ILP32 has context-related structures different from both aarch32 and
aarch64/lp64. In this patch compat_arch_ptrace() renamed to
compat_a32_ptrace(), and compat_arch_ptrace() only makes choice between
compat_a32_ptrace() and new compat_ilp32_ptrace() handler.

compat_ilp32_ptrace() calls generic compat_ptrace_request() for all
requests except PTRACE_GETSIGMASK and PTRACE_SETSIGMASK, which need
special handling.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
Signed-off-by: Chengming Zhou <zhouchengming1@huawei.com>
---
 arch/arm64/kernel/ptrace.c | 65 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index e2b7c040bf84..28f96765e8cc 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -765,9 +765,11 @@ static const struct user_regset_view user_aarch64_view = {
 	.regsets = aarch64_regsets, .n = ARRAY_SIZE(aarch64_regsets)
 };
 
-#ifdef CONFIG_AARCH32_EL0
+#ifdef CONFIG_COMPAT
 #include <linux/compat.h>
+#endif
 
+#ifdef CONFIG_AARCH32_EL0
 enum compat_regset {
 	REGSET_COMPAT_GPR,
 	REGSET_COMPAT_VFP,
@@ -1223,7 +1225,7 @@ static int compat_ptrace_sethbpregs(struct task_struct *tsk, compat_long_t num,
 }
 #endif	/* CONFIG_HAVE_HW_BREAKPOINT */
 
-long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+static long compat_a32_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
 {
 	unsigned long addr = caddr;
@@ -1300,8 +1302,67 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 	return ret;
 }
+
+#else
+#define  compat_a32_ptrace(child, request, caddr, cdata)	(0)
 #endif /* CONFIG_AARCH32_EL0 */
 
+#ifdef CONFIG_ARM64_ILP32
+#include <asm/signal32_common.h>
+
+static long compat_ilp32_ptrace(struct task_struct *child, compat_long_t request,
+			compat_ulong_t caddr, compat_ulong_t cdata)
+{
+	sigset_t new_set;
+
+	switch (request) {
+	case PTRACE_GETSIGMASK:
+		if (caddr != sizeof(compat_sigset_t))
+			return -EINVAL;
+
+		return put_sigset_t((compat_sigset_t __user *) (u64) cdata,
+					&child->blocked);
+
+	case PTRACE_SETSIGMASK:
+		if (caddr != sizeof(compat_sigset_t))
+			return -EINVAL;
+
+		if (get_sigset_t(&new_set, (compat_sigset_t __user *) (u64) cdata))
+			return -EFAULT;
+
+		sigdelsetmask(&new_set, sigmask(SIGKILL)|sigmask(SIGSTOP));
+
+		/*
+		 * Every thread does recalc_sigpending() after resume, so
+		 * retarget_shared_pending() and recalc_sigpending() are not
+		 * called here.
+		 */
+		spin_lock_irq(&child->sighand->siglock);
+		child->blocked = new_set;
+		spin_unlock_irq(&child->sighand->siglock);
+
+		return 0;
+
+	default:
+		return compat_ptrace_request(child, request, caddr, cdata);
+	}
+}
+
+#else
+#define compat_ilp32_ptrace(child, request, caddr, cdata)	(0)
+#endif
+
+#ifdef CONFIG_COMPAT
+long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+			compat_ulong_t caddr, compat_ulong_t cdata)
+{
+	if (is_a32_compat_task())
+		return compat_a32_ptrace(child, request, caddr, cdata);
+
+	return compat_ilp32_ptrace(child, request, caddr, cdata);
+}
+#endif
+
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
 #ifdef CONFIG_AARCH32_EL0
-- 
2.11.0
