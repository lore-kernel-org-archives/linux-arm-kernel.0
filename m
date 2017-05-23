From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 23 May 2017 13:30:55 +0900
Subject: [PATCH v3 1/4] arm64: kgdb: fix single stepping
In-Reply-To: <20170523043058.5463-1-takahiro.akashi@linaro.org>
References: <20170523043058.5463-1-takahiro.akashi@linaro.org>
Message-ID: <20170523043058.5463-2-takahiro.akashi@linaro.org>
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
---
 arch/arm64/kernel/kgdb.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 2122cd187f19..b9176b324e5a 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -197,12 +197,6 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		atomic_set(&kgdb_cpu_doing_single_step, -1);
 		kgdb_single_step =  0;
 
-		/*
-		 * Received continue command, disable single step
-		 */
-		if (kernel_active_single_step())
-			kernel_disable_single_step();
-
 		err = 0;
 		break;
 	case 's':
@@ -217,7 +211,6 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		kgdb_arch_update_addr(linux_regs, remcom_in_buffer);
 		atomic_set(&kgdb_cpu_doing_single_step, raw_smp_processor_id());
 		kgdb_single_step =  1;
-
 		/*
 		 * Enable single step handling
 		 */
@@ -252,6 +245,8 @@ static int kgdb_step_brk_fn(struct pt_regs *regs, unsigned int esr)
 	if (!kgdb_single_step)
 		return DBG_HOOK_ERROR;
 
+	kernel_disable_single_step();
+
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
 	return 0;
 }
-- 
2.11.1
