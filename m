From: thgarnie@google.com (Thomas Garnier)
Date: Wed,  8 Mar 2017 13:38:44 -0800
Subject: [PATCH v1 4/4] arm64/syscalls: Specific usage of
 verify_pre_usermode_state
In-Reply-To: <20170308213844.131877-1-thgarnie@google.com>
References: <20170308213844.131877-1-thgarnie@google.com>
Message-ID: <20170308213844.131877-4-thgarnie@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement specific usage of verify_pre_usermode_state for user-mode
returns for arm64.
---
Based on next-20170308
---
 arch/arm64/Kconfig        | 1 +
 arch/arm64/kernel/entry.S | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 896eba61e5ed..da54774838d8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -24,6 +24,7 @@ config ARM64
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_NO_SYSCALL_VERIFY_PRE_USERMODE_STATE
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
 	select ARM_GIC
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 43512d4d7df2..b3d1d9e5c7c1 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -744,6 +744,7 @@ ENDPROC(cpu_switch_to)
 ret_fast_syscall:
 	disable_irq				// disable interrupts
 	str	x0, [sp, #S_X0]			// returned x0
+	bl 	verify_pre_usermode_state
 	ldr	x1, [tsk, #TSK_TI_FLAGS]	// re-check for syscall tracing
 	and	x2, x1, #_TIF_SYSCALL_WORK
 	cbnz	x2, ret_fast_syscall_trace
@@ -771,6 +772,7 @@ work_pending:
  */
 ret_to_user:
 	disable_irq				// disable interrupts
+	bl 	verify_pre_usermode_state
 	ldr	x1, [tsk, #TSK_TI_FLAGS]
 	and	x2, x1, #_TIF_WORK_MASK
 	cbnz	x2, work_pending
-- 
2.12.0.246.ga2ecc84866-goog
