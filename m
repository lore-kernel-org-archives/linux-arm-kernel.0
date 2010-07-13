From: eric.miao@canonical.com (Eric Miao)
Date: Tue, 13 Jul 2010 23:33:17 +0800
Subject: [PATCH 02/13] [ARM] Allow machine to specify it's own IRQ handlers at
	run-time
In-Reply-To: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
References: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
Message-ID: <1279035208-7249-3-git-send-email-eric.miao@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Normally different ARM platform has different way to decode the IRQ
hardware status and demultiplex to the corresponding IRQ handler.
This is highly optimized by macro irq_handler in entry-armv.S, and
each machine class defines their own macro to decode the IRQ number.
However, this prevents multiple machine classes to be built into a
single kernel.

By allowing each machine to specify thier own handler, and making
function pointer 'handle_arch_irq' to point to it at run time, this
can be solved. And introduce CONFIG_MULTI_IRQ_HANDLER to allow both
solutions to work.

Comparing with the highly optimized macro of irq_handler, the new
function must be written with care not to lose too much performance.
And the IPI stuff on SMP is expected to move to the provided arch
IRQ handler as well.

Signed-off-by: Eric Miao <eric.miao@canonical.com>
Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                 |    5 +++++
 arch/arm/include/asm/mach/arch.h |    3 +++
 arch/arm/include/asm/mach/irq.h  |    4 ++++
 arch/arm/kernel/entry-armv.S     |   15 +++++++++++++++
 arch/arm/kernel/setup.c          |    6 ++++++
 5 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1243099..926e3fa 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -957,6 +957,11 @@ config CPU_HAS_PMU
 	default y
 	bool
 
+config MULTI_IRQ_HANDLER
+	bool
+	help
+	  Allow each machine to specify it's own IRQ handler at run time.
+
 if !MMU
 source "arch/arm/Kconfig-nommu"
 endif
diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index d43bdb5..8562ed6 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -31,6 +31,9 @@ struct machine_class {
 	void			(*map_io)(void);/* IO mapping function */
 	void			(*init_irq)(void);
 	struct sys_timer	*timer;
+#ifdef CONFIG_MULTI_IRQ_HANDLER
+	void			(*handle_irq)(struct pt_regs *);
+#endif
 };
 
 struct machine_desc {
diff --git a/arch/arm/include/asm/mach/irq.h b/arch/arm/include/asm/mach/irq.h
index ce3eee9..6ecdad9 100644
--- a/arch/arm/include/asm/mach/irq.h
+++ b/arch/arm/include/asm/mach/irq.h
@@ -22,6 +22,10 @@ extern void (*init_arch_irq)(void);
 extern void init_FIQ(void);
 extern int show_fiq_list(struct seq_file *, void *);
 
+#ifdef CONFIG_MULTI_IRQ_HANDLER
+extern void (*handle_arch_irq)(struct pt_regs *);
+#endif
+
 /*
  * This is for easy migration, but should be changed in the source
  */
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 7ee48e7..ecb8492 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -28,6 +28,7 @@
 /*
  * Interrupt handling.  Preserves r7, r8, r9
  */
+#ifndef CONFIG_MULTI_IRQ_HANDLER
 	.macro	irq_handler
 	get_irqnr_preamble r5, lr
 1:	get_irqnr_and_base r0, r6, r5, lr
@@ -59,6 +60,14 @@
 #endif
 
 	.endm
+#else
+	.macro	irq_handler
+	ldr	r4, =handle_arch_irq
+	mov	r0, sp
+	mov	lr, pc
+	ldr	pc, [r4]
+	.endm
+#endif	/* CONFIG_MULTI_IRQ_HANDLER */
 
 #ifdef CONFIG_KPROBES
 	.section	.kprobes.text,"ax",%progbits
@@ -1251,3 +1260,9 @@ cr_alignment:
 	.space	4
 cr_no_alignment:
 	.space	4
+
+#ifdef CONFIG_MULTI_IRQ_HANDLER
+	.globl	handle_arch_irq
+handle_arch_irq:
+	.long	0
+#endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index b5233ab..b6a0262 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -741,6 +741,12 @@ void __init setup_arch(char **cmdline_p)
 	system_timer = mdesc->timer ? : (class ? class->timer : NULL);
 	init_machine = mdesc->init_machine;
 
+#ifdef CONFIG_MULTI_IRQ_HANDLER
+	handle_arch_irq = class ? class->handle_irq : NULL;
+	if (!handle_arch_irq)
+		panic("No machine class specific IRQ handler defined\n");
+#endif
+
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
 	conswitchp = &vga_con;
-- 
1.7.1
