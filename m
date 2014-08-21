From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 20 Aug 2014 18:20:33 -0700
Subject: [PATCHv3 1/7] arm64: Treat handle_arch_irq as a function pointer
In-Reply-To: <1408584039-12735-1-git-send-email-lauraa@codeaurora.org>
References: <1408584039-12735-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1408584039-12735-2-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

handle_arch_irq isn't actually text, it's just a function pointer.
It doesn't need to be stored in the text section and doing so
causes problesm if we ever want to make the kernel text read only.
Declare handle_arch_irq as a proper function pointer stored in
the data section.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/include/asm/irq.h | 1 -
 arch/arm64/kernel/entry.S    | 6 ++----
 arch/arm64/kernel/irq.c      | 2 ++
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index e1f7ecd..1eebf5b 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -3,7 +3,6 @@
 
 #include <asm-generic/irq.h>
 
-extern void (*handle_arch_irq)(struct pt_regs *);
 extern void migrate_irqs(void);
 extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index f0b5e51..854379a 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -168,7 +168,8 @@ tsk	.req	x28		// current thread_info
  * Interrupt handling.
  */
 	.macro	irq_handler
-	ldr	x1, handle_arch_irq
+	adrp x1, handle_arch_irq
+	ldr x1, [x1, #:lo12:handle_arch_irq]
 	mov	x0, sp
 	blr	x1
 	.endm
@@ -696,6 +697,3 @@ ENTRY(sys_rt_sigreturn_wrapper)
 	mov	x0, sp
 	b	sys_rt_sigreturn
 ENDPROC(sys_rt_sigreturn_wrapper)
-
-ENTRY(handle_arch_irq)
-	.quad	0
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 0f08dfd..e4fedbc 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -67,6 +67,8 @@ void handle_IRQ(unsigned int irq, struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
+void (*handle_arch_irq)(struct pt_regs *) = NULL;
+
 void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 {
 	if (handle_arch_irq)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
