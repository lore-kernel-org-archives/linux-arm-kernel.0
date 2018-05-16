From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 16 May 2018 11:19:06 +0300
Subject: [PATCH 21/24] arm64: ptrace: handle ptrace_request differently for
 aarch32 and ilp32
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
Message-ID: <20180516081910.10067-22-ynorov@caviumnetworks.com>
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
Signed-off-by: Bamvor Jian Zhang <bamv2005@gmail.com>
---
 arch/arm64/kernel/ptrace.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 4d0a541d049b..da7f47c7e586 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1038,9 +1038,11 @@ static const struct user_regset_view user_aarch64_view = {
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
@@ -1503,7 +1505,7 @@ static int compat_ptrace_sethbpregs(struct task_struct *tsk, compat_long_t num,
 }
 #endif	/* CONFIG_HAVE_HW_BREAKPOINT */
 
-long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+static long compat_a32_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
 {
 	unsigned long addr = caddr;
@@ -1580,8 +1582,23 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 	return ret;
 }
+
+#else
+#define  compat_a32_ptrace(child, request, caddr, cdata)	(0)
 #endif /* CONFIG_AARCH32_EL0 */
 
+#ifdef CONFIG_COMPAT
+long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+			compat_ulong_t caddr, compat_ulong_t cdata)
+{
+	if (is_a32_compat_task())
+		return compat_a32_ptrace(child, request, caddr, cdata);
+
+	/* ILP32 */
+	return compat_ptrace_request(child, request, caddr, cdata);
+}
+#endif
+
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
 #ifdef CONFIG_AARCH32_EL0
-- 
2.17.0
