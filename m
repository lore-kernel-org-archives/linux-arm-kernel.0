From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 20 Oct 2015 17:00:18 +0900
Subject: [PATCH v2 1/2] arm64: revamp unwind_frame for interrupt stack
In-Reply-To: <1445328019-23330-1-git-send-email-takahiro.akashi@linaro.org>
References: <1445328019-23330-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1445328019-23330-2-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows unwind_frame() to traverse from interrupt stack
to process stack correctly by having a dummy stack frame for irq
exception entry created at its prologue.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kernel/entry.S      |   22 ++++++++++++++++++++--
 arch/arm64/kernel/stacktrace.c |   14 +++++++++++++-
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index c8e0bcf..779f807 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -186,8 +186,26 @@ alternative_endif
 	and	x23, x23, #~(IRQ_STACK_SIZE - 1)
 	cmp	x20, x23			// check irq re-enterance
 	mov	x19, sp
-	csel	x23, x19, x24, eq		// x24 = top of irq stack
-	mov	sp, x23
+	beq	1f
+	mov	sp, x24				// x24 = top of irq stack
+	stp	x29, x19, [sp, #-16]!		// for sanity check
+	stp	x29, x22, [sp, #-16]!		// dummy stack frame
+	mov	x29, sp
+1:
+	/*
+	 * Layout of interrupt stack after this macro is invoked:
+	 *
+	 *     |                |
+	 *-0x20+----------------+ <= dummy stack frame
+	 *     |      fp        |    : fp on process stack
+	 *-0x18+----------------+
+	 *     |      lr        |    : return address
+	 *-0x10+----------------+
+	 *     |    fp (copy)   |    : for sanity check
+	 * -0x8+----------------+
+	 *     |      sp        |    : sp on process stack
+	 *  0x0+----------------+
+	 */
 	.endm
 
 	/*
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 407991b..03611a1 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -43,12 +43,24 @@ int notrace unwind_frame(struct stackframe *frame)
 	low  = frame->sp;
 	high = ALIGN(low, THREAD_SIZE);
 
-	if (fp < low || fp > high - 0x18 || fp & 0xf)
+	if (fp < low || fp > high - 0x20 || fp & 0xf)
 		return -EINVAL;
 
 	frame->sp = fp + 0x10;
 	frame->fp = *(unsigned long *)(fp);
 	/*
+	 * check whether we are going to walk trough from interrupt stack
+	 * to process stack
+	 * If the previous frame is the initial (dummy) stack frame on
+	 * interrupt stack, frame->sp now points to just below the frame
+	 * (dummy frame + 0x10).
+	 * See entry.S
+	 */
+#define STACK_LOW(addr) round_down((addr), THREAD_SIZE)
+	if ((STACK_LOW(frame->sp) != STACK_LOW(frame->fp)) &&
+			(frame->fp == *(unsigned long *)frame->sp))
+		frame->sp = *((unsigned long *)(frame->sp + 8));
+	/*
 	 * -4 here because we care about the PC at time of bl,
 	 * not where the return will go.
 	 */
-- 
1.7.9.5
