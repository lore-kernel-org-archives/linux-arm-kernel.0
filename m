From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 27 Oct 2017 11:50:47 +0100
Subject: [PATCH v4 05/28] arm64: fpsimd: Simplify uses of {set,
 clear}_ti_thread_flag()
In-Reply-To: <1509101470-7881-1-git-send-email-Dave.Martin@arm.com>
References: <1509101470-7881-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1509101470-7881-6-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The existing FPSIMD context switch code contains a couple of
instances of {set,clear}_ti_thread(task_thread_info(task)).  Since
there are thread flag manipulators that operate directly on
task_struct, this verbosity isn't strictly needed.

For consistency, this patch simplifies the affected calls.  This
should have no impact on behaviour.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/fpsimd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 5d547de..7a865c8 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -159,11 +159,9 @@ void fpsimd_thread_switch(struct task_struct *next)
 
 		if (__this_cpu_read(fpsimd_last_state) == st
 		    && st->cpu == smp_processor_id())
-			clear_ti_thread_flag(task_thread_info(next),
-					     TIF_FOREIGN_FPSTATE);
+			clear_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE);
 		else
-			set_ti_thread_flag(task_thread_info(next),
-					   TIF_FOREIGN_FPSTATE);
+			set_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE);
 	}
 }
 
-- 
2.1.4
