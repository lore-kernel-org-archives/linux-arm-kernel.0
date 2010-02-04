From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 4 Feb 2010 11:12:37 -0800
Subject: [RFC PATCH 3/3] [ARM] Allow boards to specify the exact number of
	IRQs needed
Message-ID: <f17812d71002041112x6f8308b5q6bc37f6608a3efc9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 988a6a2bd322d83eba42c05cb6cb77a74cba056b
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Thu Feb 4 11:06:35 2010 -0800

    [ARM] Allow boards to specify the exact number of IRQs needed

    This will only take effect if SPARSE_IRQ is enabled, any board that
    depends on this _only_ has to explicitly select SPARSE_IRQ.

    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index a1ea728..825ee34 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -19,6 +19,7 @@

 #ifndef __ASSEMBLY__
 struct irqaction;
+extern int arch_nr_irqs;
 extern void migrate_irqs(void);

 extern void asm_do_IRQ(unsigned int, struct pt_regs *);
diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index c59842d..a9128b4 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -20,6 +20,7 @@ struct machine_desc {
 	 * by assembler code in head.S, head-common.S
 	 */
 	unsigned int		nr;		/* architecture number	*/
+	unsigned int		num_irqs;	/* number of IRQs */
 	unsigned int		phys_io;	/* start of physical io	*/
 	unsigned int		io_pg_offst;	/* byte offset for io
 						 * page tabe entry	*/
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index e62f39b..e23d248 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -168,7 +168,7 @@ void __init init_IRQ(void)
 #ifdef CONFIG_SPARSE_IRQ
 int __init arch_probe_nr_irqs(void)
 {
-	nr_irqs = NR_IRQS;
+	nr_irqs = arch_nr_irqs ? arch_nr_irqs : NR_IRQS;
 	return 0;
 }
 #endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c6c57b6..803ed95 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -755,6 +755,7 @@ void __init setup_arch(char **cmdline_p)
 	/*
 	 * Set up various architecture-specific pointers
 	 */
+	arch_nr_irqs = mdesc->num_irqs;
 	init_arch_irq = mdesc->init_irq;
 	system_timer = mdesc->timer;
 	init_machine = mdesc->init_machine;
