From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 12 Nov 2018 11:57:13 +0000
Subject: [PATCH v6 22/24] arm64: Skip preemption when exiting an NMI
In-Reply-To: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1542023835-21446-23-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Handling of an NMI should not set any TIF flags. For NMIs received from
EL0 the current exit path is safe to use.

However, an NMI received at EL1 could have interrupted some task context
that has set the TIF_NEED_RESCHED flag. Preempting a task should not
happen as a result of an NMI.

Skip preemption after handling an NMI from EL1.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/entry.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index eb8120e..e02ee55 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -636,6 +636,14 @@ el1_irq:
 
 #ifdef CONFIG_PREEMPT
 	ldr	w24, [tsk, #TSK_TI_PREEMPT]	// get preempt count
+alternative_if ARM64_HAS_IRQ_PRIO_MASKING
+	/*
+	 * DA_F were cleared at start of handling. If anything is set in DAIF,
+	 * we come back from an NMI, so skip preemption
+	 */
+	mrs	x0, daif
+	orr	w24, w24, w0
+alternative_else_nop_endif
 	cbnz	w24, 1f				// preempt count != 0
 	ldr	x0, [tsk, #TSK_TI_FLAGS]	// get flags
 	tbz	x0, #TIF_NEED_RESCHED, 1f	// needs rescheduling?
-- 
1.9.1
