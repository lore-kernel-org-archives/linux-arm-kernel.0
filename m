From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 17 Apr 2014 17:47:02 -0700
Subject: [PATCH 2/3] arm64: Treat handle_arch_irq as a function pointer
In-Reply-To: <1397782023-28114-1-git-send-email-lauraa@codeaurora.org>
References: <1397782023-28114-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1397782023-28114-3-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

handle_arch_irq isn't actually text, it's just a function
pointer. It doesn't need to be stored in the text section
and doing so causes problems if we ever want to make the
kernel text readonly. Move it to the data section.

Change-Id: I682ff82f5c8c429129dd81bbcc91571f278c62e2
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/kernel/entry.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 39ac630..5051f30 100644
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
@@ -678,5 +679,6 @@ ENTRY(sys_rt_sigreturn_wrapper)
 	b	sys_rt_sigreturn
 ENDPROC(sys_rt_sigreturn_wrapper)
 
+.data
 ENTRY(handle_arch_irq)
 	.quad	0
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
