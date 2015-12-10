From: james.morse@arm.com (James Morse)
Date: Thu, 10 Dec 2015 10:22:41 +0000
Subject: [PATCH v8 8/4] arm64: don't call C code with el0's fp register
In-Reply-To: <1449742961-11432-1-git-send-email-james.morse@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1449742961-11432-1-git-send-email-james.morse@arm.com>
Message-ID: <1449742961-11432-4-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On entry from el0, we save all the registers on the kernel stack, and
restore them before returning. x29 remains unchanged when we call out
to C code, which will store x29 as the frame-pointer on the stack.

Instead, write 0 into x29 after entry from el0, to avoid any risk of
tracing into user space.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/entry.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 9a0450344335..8dd009b4cab2 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -93,6 +93,8 @@
 	and	tsk, tsk, #~(THREAD_SIZE - 1)	// Ensure MDSCR_EL1.SS is clear,
 	ldr	x19, [tsk, #TI_FLAGS]		// since we can unmask debug
 	disable_step_tsk x19, x20		// exceptions when scheduling.
+
+	mov	x29, xzr			// fp pointed to user-space
 	.else
 	add	x21, sp, #S_FRAME_SIZE
 	.endif
-- 
2.6.2
