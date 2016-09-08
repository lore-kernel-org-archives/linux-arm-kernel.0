From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  8 Sep 2016 13:55:39 +0100
Subject: [PATCH 6/6] arm64: simplify contextidr_thread_switch
In-Reply-To: <1473339339-32334-1-git-send-email-mark.rutland@arm.com>
References: <1473339339-32334-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1473339339-32334-7-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_PID_IN_CONTEXTIDR is not selected, we use an empty stub
definition of contextidr_thread_switch(). As everything we rely upon
exists regardless of CONFIG_PID_IN_CONTEXTIDR, we don't strictly require
an empty stub.

By using IS_ENABLED() rather than ifdeffery, we avoid duplication, and
get compiler coverage on all the code even when CONFIG_PID_IN_CONTEXTIDR
is not selected and the code is optimised away.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/mmu_context.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index e5c24b4..a501853 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -30,17 +30,14 @@
 #include <asm/sysreg.h>
 #include <asm/tlbflush.h>
 
-#ifdef CONFIG_PID_IN_CONTEXTIDR
 static inline void contextidr_thread_switch(struct task_struct *next)
 {
+	if (!IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR))
+		return;
+
 	write_sysreg(task_pid_nr(next), contextidr_el1);
 	isb();
 }
-#else
-static inline void contextidr_thread_switch(struct task_struct *next)
-{
-}
-#endif
 
 /*
  * Set TTBR0 to empty_zero_page. No translations will be possible via TTBR0.
-- 
1.9.1
