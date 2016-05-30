From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 30 May 2016 10:52:28 +0800
Subject: [PATCH 7/9] arm64: entry: save the x0 back into the stack before
 disabling the interrupt
In-Reply-To: <1464576750-25160-1-git-send-email-shijie.huang@arm.com>
References: <1464576750-25160-1-git-send-email-shijie.huang@arm.com>
Message-ID: <1464576750-25160-8-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We will add the hardirq flags trace code in the disable_irq, the trace
code may changes the x0, so save the x0 back into the stack before
disabling the interrupt,

This patch makes preparation for the later patch.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 arch/arm64/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 63bf7ad..7005789 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -672,8 +672,8 @@ ENDPROC(cpu_switch_to)
  * and this includes saving x0 back into the kernel stack.
  */
 ret_fast_syscall:
-	disable_irq				// disable interrupts
 	str	x0, [sp, #S_X0]			// returned x0
+	disable_irq				// disable interrupts
 	ldr	x1, [tsk, #TI_FLAGS]		// re-check for syscall tracing
 	and	x2, x1, #_TIF_SYSCALL_WORK
 	cbnz	x2, ret_fast_syscall_trace
-- 
2.5.5
