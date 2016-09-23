From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 23 Sep 2016 16:33:25 +0900
Subject: [PATCH v2 1/3] arm64: kgdb: fix single stepping
In-Reply-To: <20160923073327.9657-1-takahiro.akashi@linaro.org>
References: <20160923073327.9657-1-takahiro.akashi@linaro.org>
Message-ID: <20160923073327.9657-2-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After entering kgdb mode, the first 'stepi' can succeed, but the following
'stepi' never executes the next instruction.

This is because a software step cannot get enabled as the software step
bit(SS) in SPSR, which is cleared by the first single stepping, will not
be set again for the following 's' commands.
Please note that this bit, as well as the software step control bit(SS)
in MDSCR, must be set before resuming the execution.
kernel_active_single_step() called by kgdb_arch_handle_exception() checks
only for the bit in MDSCR, and so kgdb_enable_single_step() will never be
called.

This patch removes kgdb_disable_single_step() from 'c' command handling
and enables/disables a single step explicitly at every entry and exit
of 's' command handling.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: <stable@vger.kernel.org> # 3.15-
---
 arch/arm64/kernel/kgdb.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 8c57f64..afe5f90 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -189,14 +189,6 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		 * over and over again.
 		 */
 		kgdb_arch_update_addr(linux_regs, remcom_in_buffer);
-		atomic_set(&kgdb_cpu_doing_single_step, -1);
-		kgdb_single_step =  0;
-
-		/*
-		 * Received continue command, disable single step
-		 */
-		if (kernel_active_single_step())
-			kernel_disable_single_step();
 
 		err = 0;
 		break;
@@ -211,8 +203,6 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		 */
 		kgdb_arch_update_addr(linux_regs, remcom_in_buffer);
 		atomic_set(&kgdb_cpu_doing_single_step, raw_smp_processor_id());
-		kgdb_single_step =  1;
-
 		/*
 		 * Enable single step handling
 		 */
@@ -244,6 +234,9 @@ NOKPROBE_SYMBOL(kgdb_compiled_brk_fn);
 
 static int kgdb_step_brk_fn(struct pt_regs *regs, unsigned int esr)
 {
+	kernel_disable_single_step();
+	atomic_set(&kgdb_cpu_doing_single_step, -1);
+
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
 	return 0;
 }
-- 
2.10.0
