From: alex.shi@linaro.org (Alex Shi)
Date: Fri,  9 Mar 2018 17:06:57 +0800
Subject: [PATCH 14/39] arm64: Move BP hardening to check_and_switch_context
In-Reply-To: <20180309090722.26279-1-alex.shi@linaro.org>
References: <20180309090722.26279-1-alex.shi@linaro.org>
Message-ID: <20180309090722.26279-15-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

commit a8e4c0a919ae upstream.

We call arm64_apply_bp_hardening() from post_ttbr_update_workaround,
which has the unexpected consequence of being triggered on every
exception return to userspace when ARM64_SW_TTBR0_PAN is selected,
even if no context switch actually occured.

This is a bit suboptimal, and it would be more logical to only
invalidate the branch predictor when we actually switch to
a different mm.

In order to solve this, move the call to arm64_apply_bp_hardening()
into check_and_switch_context(), where we're guaranteed to pick
a different mm context.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/mm/context.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 66eaa00ce35b..ee04cc7fc398 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -183,6 +183,7 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
 
 switch_mm_fastpath:
+	arm64_apply_bp_hardening();
 	cpu_switch_mm(mm->pgd, mm);
 }
 
@@ -193,8 +194,6 @@ asmlinkage void post_ttbr_update_workaround(void)
 			"ic iallu; dsb nsh; isb",
 			ARM64_WORKAROUND_CAVIUM_27456,
 			CONFIG_CAVIUM_ERRATUM_27456));
-
-	arm64_apply_bp_hardening();
 }
 
 static int asids_init(void)
-- 
2.16.2.440.gc6284da
