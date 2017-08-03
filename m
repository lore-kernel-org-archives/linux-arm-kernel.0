From: Dave.Martin@arm.com (Dave Martin)
Date: Thu,  3 Aug 2017 17:23:21 +0100
Subject: [PATCH 3/5] arm64: fpsimd: Consistently use __this_cpu_ ops where
 appropriate
In-Reply-To: <1501777403-9782-1-git-send-email-Dave.Martin@arm.com>
References: <1501777403-9782-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1501777403-9782-4-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__this_cpu_ ops are not used consistently with regard to this_cpu_
ops in a couple of places in fpsimd.c.

Since preemption is explicitly disabled in
fpsimd_restore_current_state() and fpsimd_update_current_state(),
this patch converts this_cpu_ ops in those functions to __this_cpu_
ops.  This doesn't save cost on arm64, but benefits from additional
assertions in the core code.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/fpsimd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 06da8ea..d7e5f8a 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -194,7 +194,7 @@ void fpsimd_restore_current_state(void)
 		struct fpsimd_state *st = &current->thread.fpsimd_state;
 
 		fpsimd_load_state(st);
-		this_cpu_write(fpsimd_last_state, st);
+		__this_cpu_write(fpsimd_last_state, st);
 		st->cpu = smp_processor_id();
 	}
 	preempt_enable();
@@ -214,7 +214,7 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		struct fpsimd_state *st = &current->thread.fpsimd_state;
 
-		this_cpu_write(fpsimd_last_state, st);
+		__this_cpu_write(fpsimd_last_state, st);
 		st->cpu = smp_processor_id();
 	}
 	preempt_enable();
-- 
2.1.4
