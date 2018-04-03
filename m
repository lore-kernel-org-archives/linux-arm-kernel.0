From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  3 Apr 2018 11:22:51 +0100
Subject: [PATCH] arm64: only advance singlestep for user instruction traps
Message-ID: <20180403102251.42309-1-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our arm64_skip_faulting_instruction() helper advances the userspace
singlestep state machine, but this is also called by the kernel BRK
handler, as used for WARN*().

Thus, if we happen to hit a WARN*() while the user singlestep state
machine is in the active-no-pending state, we'll advance to the
active-pending state without having executed a user instruction, and
will take a step exception earlier than expected when we return to
userspace.

Let's fix this by only advancing the state machine when skipping a user
instruction.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/traps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index ba964da31a25..75625a401a4e 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -277,7 +277,8 @@ void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
 	 * If we were single stepping, we want to get the step exception after
 	 * we return from the trap.
 	 */
-	user_fastforward_single_step(current);
+	if (user_mode(regs))
+		user_fastforward_single_step(current);
 }
 
 static LIST_HEAD(undef_hook);
-- 
2.11.0
