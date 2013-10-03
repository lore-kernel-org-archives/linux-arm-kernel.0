From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu,  3 Oct 2013 14:47:44 +0900
Subject: [PATCH v2 1/3] arm64: check for number of arguments in
 syscall_get/set_arguments()
In-Reply-To: <1380779266-11753-1-git-send-email-takahiro.akashi@linaro.org>
References: <1380779266-11753-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1380779266-11753-2-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In ftrace_syscall_enter(),
    syscall_get_arguments(..., 0, n, ...)
        if (i == 0) { <handle orig_x0> ...; n--;}
        memcpy(..., n * sizeof(args[0]));
If 'number of arguments(n)' is zero and 'argument index(i)' is also zero in
syscall_get_arguments(), none of arguments should be copied by memcpy().
Otherwise 'n--' can be a big positive number and unexpected amount of data
will be copied. Tracing system calls which take no argument, say sync(void),
may hit this case and eventually make the system corrupted.
This patch fixes the issue both in syscall_get_arguments() and
syscall_set_arguments().

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/include/asm/syscall.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index c89821f..01bb8cc 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -63,6 +63,9 @@ static inline void syscall_get_arguments(struct task_struct *task,
 					 unsigned int i, unsigned int n,
 					 unsigned long *args)
 {
+	if (n == 0)
+		return;
+
 	if (i + n > SYSCALL_MAX_ARGS) {
 		unsigned long *args_bad = args + SYSCALL_MAX_ARGS - i;
 		unsigned int n_bad = n + i - SYSCALL_MAX_ARGS;
@@ -86,6 +89,9 @@ static inline void syscall_set_arguments(struct task_struct *task,
 					 unsigned int i, unsigned int n,
 					 const unsigned long *args)
 {
+	if (n == 0)
+		return;
+
 	if (i + n > SYSCALL_MAX_ARGS) {
 		pr_warning("%s called with max args %d, handling only %d\n",
 			   __func__, i + n, SYSCALL_MAX_ARGS);
-- 
1.7.9.5
