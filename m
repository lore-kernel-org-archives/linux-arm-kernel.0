From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 8 Jan 2016 02:34:31 +0300
Subject: [PATCH v6 13/21] arm64: ptrace: handle ptrace_request differently for
 aarch32 and ilp32
In-Reply-To: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
References: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1452209679-19445-14-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/kernel/ptrace.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index c166548..f95fb89 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1108,7 +1108,7 @@ static int compat_ptrace_sethbpregs(struct task_struct *tsk, compat_long_t num,
 }
 #endif	/* CONFIG_HAVE_HW_BREAKPOINT */
 
-long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+long compat_a32_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
 {
 	unsigned long addr = caddr;
@@ -1185,8 +1185,25 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 	return ret;
 }
+#else
+
+#define compat_a32_ptrace(child, request, caddr, cdata) (-1)
+
 #endif /* CONFIG_AARCH32_EL0 */
 
+#ifdef CONFIG_COMPAT
+
+long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+			compat_ulong_t caddr, compat_ulong_t cdata)
+{
+	if (is_a32_compat_task())
+		return compat_a32_ptrace(child, request, caddr, cdata);
+
+	return compat_ptrace_request(child, request, caddr, cdata);
+}
+
+#endif /* CONFIG_COMPAT */
+
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
 #ifdef CONFIG_AARCH32_EL0
-- 
2.5.0
