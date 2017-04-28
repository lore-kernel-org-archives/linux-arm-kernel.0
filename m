From: thgarnie@google.com (Thomas Garnier)
Date: Fri, 28 Apr 2017 08:32:13 -0700
Subject: [PATCH v9 4/4] arm64/syscalls: Optimize address limit check
In-Reply-To: <20170428153213.137279-1-thgarnie@google.com>
References: <20170428153213.137279-1-thgarnie@google.com>
Message-ID: <20170428153213.137279-4-thgarnie@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disable the generic address limit check in favor of an architecture
specific optimized implementation.

The address limit is checked on each syscall return path to user-mode.
If it was changed, a generic handler is called to stop the kernel on an
explicit check.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
Based on next-20170426
---
 arch/arm64/Kconfig        |  1 +
 arch/arm64/kernel/entry.S | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3dcd7ec69bca..ae82b1f067da 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -6,6 +6,7 @@ config ARM64
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_MCFG if ACPI
 	select ACPI_SPCR_TABLE if ACPI
+	select ADDR_LIMIT_CHECK
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 43512d4d7df2..c895c4402d32 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -744,6 +744,8 @@ ENDPROC(cpu_switch_to)
 ret_fast_syscall:
 	disable_irq				// disable interrupts
 	str	x0, [sp, #S_X0]			// returned x0
+	ldr	x2, [tsk, #TSK_TI_ADDR_LIMIT]	// check addr limit change
+	tbnz	x2, #63, addr_limit_fail
 	ldr	x1, [tsk, #TSK_TI_FLAGS]	// re-check for syscall tracing
 	and	x2, x1, #_TIF_SYSCALL_WORK
 	cbnz	x2, ret_fast_syscall_trace
@@ -771,6 +773,8 @@ work_pending:
  */
 ret_to_user:
 	disable_irq				// disable interrupts
+	ldr	x2, [tsk, #TSK_TI_ADDR_LIMIT]	// check addr limit change
+	tbnz	x2, #63, addr_limit_fail
 	ldr	x1, [tsk, #TSK_TI_FLAGS]
 	and	x2, x1, #_TIF_WORK_MASK
 	cbnz	x2, work_pending
@@ -780,6 +784,14 @@ finish_ret_to_user:
 ENDPROC(ret_to_user)
 
 /*
+ * Address limit was incorrect before returning in user-mode which could be
+ * used to elevate privileges. Call the generic handler to stop the kernel on
+ * the appropriate check. This function does not return.
+ */
+addr_limit_fail:
+	b	addr_limit_check_failed
+
+/*
  * This is how we return from a fork.
  */
 ENTRY(ret_from_fork)
-- 
2.13.0.rc0.306.g87b477812d-goog
