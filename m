From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 Jul 2015 16:20:17 +0100
Subject: [PATCH] arm64: Better native ptrace support for compat tasks
Message-ID: <1436887217-13158-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compat ptrace interface allows access to the TLS register, hardware
breakpoints and watchpoints, syscall number. However, a native task
using the native ptrace interface to debug compat tasks (e.g. multi-arch
gdb) only has access to the general and VFP register sets. The compat
ptrace interface cannot be accessed from a native task.

This patch adds a new user_aarch32_ptrace_view which contains the TLS,
hardware breakpoint/watchpoint and syscall number regsets in addition to
the existing GPR and VFP regsets. This view is backwards compatible with
the previous kernels. Core dumping of 32-bit tasks and compat ptrace are
not affected since the original user_aarch32_view is preserved.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Yao Qi <yao.qi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/ptrace.c | 92 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index d882b833dbdb..1971f491bb90 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -826,6 +826,30 @@ static int compat_vfp_set(struct task_struct *target,
 	return ret;
 }
 
+static int compat_tls_get(struct task_struct *target,
+			  const struct user_regset *regset, unsigned int pos,
+			  unsigned int count, void *kbuf, void __user *ubuf)
+{
+	compat_ulong_t tls = (compat_ulong_t)target->thread.tp_value;
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, &tls, 0, -1);
+}
+
+static int compat_tls_set(struct task_struct *target,
+			  const struct user_regset *regset, unsigned int pos,
+			  unsigned int count, const void *kbuf,
+			  const void __user *ubuf)
+{
+	int ret;
+	compat_ulong_t tls;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &tls, 0, -1);
+	if (ret)
+		return ret;
+
+	target->thread.tp_value = tls;
+	return ret;
+}
+
 static const struct user_regset aarch32_regsets[] = {
 	[REGSET_COMPAT_GPR] = {
 		.core_note_type = NT_PRSTATUS,
@@ -850,6 +874,64 @@ static const struct user_regset_view user_aarch32_view = {
 	.regsets = aarch32_regsets, .n = ARRAY_SIZE(aarch32_regsets)
 };
 
+static const struct user_regset aarch32_ptrace_regsets[] = {
+	[REGSET_GPR] = {
+		.core_note_type = NT_PRSTATUS,
+		.n = COMPAT_ELF_NGREG,
+		.size = sizeof(compat_elf_greg_t),
+		.align = sizeof(compat_elf_greg_t),
+		.get = compat_gpr_get,
+		.set = compat_gpr_set
+	},
+	[REGSET_FPR] = {
+		.core_note_type = NT_ARM_VFP,
+		.n = VFP_STATE_SIZE / sizeof(compat_ulong_t),
+		.size = sizeof(compat_ulong_t),
+		.align = sizeof(compat_ulong_t),
+		.get = compat_vfp_get,
+		.set = compat_vfp_set
+	},
+	[REGSET_TLS] = {
+		.core_note_type = NT_ARM_TLS,
+		.n = 1,
+		.size = sizeof(compat_ulong_t),
+		.align = sizeof(compat_ulong_t),
+		.get = compat_tls_get,
+		.set = compat_tls_set,
+	},
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	[REGSET_HW_BREAK] = {
+		.core_note_type = NT_ARM_HW_BREAK,
+		.n = sizeof(struct user_hwdebug_state) / sizeof(u32),
+		.size = sizeof(u32),
+		.align = sizeof(u32),
+		.get = hw_break_get,
+		.set = hw_break_set,
+	},
+	[REGSET_HW_WATCH] = {
+		.core_note_type = NT_ARM_HW_WATCH,
+		.n = sizeof(struct user_hwdebug_state) / sizeof(u32),
+		.size = sizeof(u32),
+		.align = sizeof(u32),
+		.get = hw_break_get,
+		.set = hw_break_set,
+	},
+#endif
+	[REGSET_SYSTEM_CALL] = {
+		.core_note_type = NT_ARM_SYSTEM_CALL,
+		.n = 1,
+		.size = sizeof(int),
+		.align = sizeof(int),
+		.get = system_call_get,
+		.set = system_call_set,
+	},
+};
+
+static const struct user_regset_view user_aarch32_ptrace_view = {
+	.name = "aarch32", .e_machine = EM_ARM,
+	.regsets = aarch32_ptrace_regsets, .n = ARRAY_SIZE(aarch32_ptrace_regsets)
+};
+
 static int compat_ptrace_read_user(struct task_struct *tsk, compat_ulong_t off,
 				   compat_ulong_t __user *ret)
 {
@@ -1109,8 +1191,16 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
 #ifdef CONFIG_COMPAT
-	if (is_compat_thread(task_thread_info(task)))
+	/*
+	 * Core dumping of 32-bit tasks or compat ptrace requests must use the
+	 * user_aarch32_view compatible with arm32. Native ptrace requests on
+	 * 32-bit children use an extended user_aarch32_ptrace_view to allow
+	 * access to the TLS register.
+	 */
+	if (is_compat_task())
 		return &user_aarch32_view;
+	else if (is_compat_thread(task_thread_info(task)))
+		return &user_aarch32_ptrace_view;
 #endif
 	return &user_aarch64_view;
 }
