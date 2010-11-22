From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 22 Nov 2010 16:26:50 +0800
Subject: [PATCH] ARM: Allow machine to specify it's own IRQ handlers at
	run-time
Message-ID: <AANLkTi=Unb_08zF8jStBJvbFeo01QprPt=ag0CrE1oLB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

I wonder if it's still acceptable for a patch like below to have a dynamic IRQ
handler at run-time. There is some changes to the irq_handler, esp. some
SMP changes.

Magnus had some similar patches to have a run-time irq_handler, which is
a bit more complicated, but I'm also very happy with.

commit d57e464929c9b2b50cda07e8683679583adf0fee
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Mon Nov 22 16:13:51 2010 +0800

    ARM: Allow machine to specify it's own IRQ handlers at run-time

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

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a19a526..c2c9838 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1017,6 +1017,11 @@ config CPU_HAS_PMU
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
index d97a964..7d55356 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -40,6 +40,9 @@ struct machine_desc {
 	void			(*init_irq)(void);
 	struct sys_timer	*timer;		/* system tick timer	*/
 	void			(*init_machine)(void);
+#ifdef CONFIG_MULTI_IRQ_HANDLER
+	void			(*handle_irq)(struct pt_regs *);
+#endif
 };

 /*
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
index c09e357..8ed4f7c 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -29,6 +29,7 @@
 /*
  * Interrupt handling.  Preserves r7, r8, r9
  */
+#ifndef CONFIG_MULTI_IRQ_HANDLER
 	.macro	irq_handler
 	get_irqnr_preamble r5, lr
 1:	get_irqnr_and_base r0, r6, r5, lr
@@ -62,6 +63,14 @@
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
@@ -1245,3 +1254,9 @@ cr_alignment:
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
index 336f14e..a834c6c 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -876,6 +876,12 @@ void __init setup_arch(char **cmdline_p)
 	system_timer = mdesc->timer;
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
