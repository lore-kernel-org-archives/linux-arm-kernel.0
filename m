From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon,  2 Jun 2014 13:57:36 -0700
Subject: [PATCHv2 2/4] arm64: Treat handle_arch_irq as a function pointer
In-Reply-To: <1401742658-11841-1-git-send-email-lauraa@codeaurora.org>
References: <1401742658-11841-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1401742658-11841-3-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


handle_arch_irq isn't actually text, it's just a function
pointer. It doesn't need to be stored in the text section
and doing so causes problems if we ever want to make the
kernel text readonly. Move it to the data section.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/kernel/entry.S | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 39ac630..7c8ea1f 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -139,7 +139,8 @@ tsk	.req	x28		// current thread_info
  * Interrupt handling.
  */
 	.macro	irq_handler
-	ldr	x1, handle_arch_irq
+	ldr	x1, =handle_arch_irq
+	ldr	x1, [x1]
 	mov	x0, sp
 	blr	x1
 	.endm
@@ -678,5 +679,8 @@ ENTRY(sys_rt_sigreturn_wrapper)
 	b	sys_rt_sigreturn
 ENDPROC(sys_rt_sigreturn_wrapper)
 
-ENTRY(handle_arch_irq)
+	.data
+	.globl handle_arch_irq
+	.align 4
+handle_arch_irq:
 	.quad	0
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
