From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Thu, 22 Nov 2012 16:50:01 -0800
Subject: [PATCH 08/10] ARM: FIQ: Implement !CONFIG_FIQ stubs
In-Reply-To: <20121123003849.GA973@lizard.mcd25758.sjc.wayport.net>
References: <20121123003849.GA973@lizard.mcd25758.sjc.wayport.net>
Message-ID: <1353631803-4853-8-git-send-email-anton.vorontsov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simply removes ugly #ifdefs from C code.

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 arch/arm/include/asm/mach/irq.h | 5 +++++
 arch/arm/kernel/irq.c           | 2 --
 arch/arm/plat-mxc/avic.c        | 2 --
 arch/arm/plat-mxc/tzic.c        | 2 --
 arch/arm/plat-s3c24xx/irq.c     | 2 --
 5 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/mach/irq.h b/arch/arm/include/asm/mach/irq.h
index febe495..420d211 100644
--- a/arch/arm/include/asm/mach/irq.h
+++ b/arch/arm/include/asm/mach/irq.h
@@ -17,8 +17,13 @@ struct seq_file;
 /*
  * This is internal.  Do not use it.
  */
+#ifdef CONFIG_FIQ
 extern void init_FIQ(void);
 extern int show_fiq_list(struct seq_file *, int);
+#else
+static inline void init_FIQ(void) {}
+static inline int show_fiq_list(struct seq_file *p, int prec) { return 0; }
+#endif
 
 #ifdef CONFIG_MULTI_IRQ_HANDLER
 extern void (*handle_arch_irq)(struct pt_regs *);
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 8961650..00911e5 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -45,9 +45,7 @@ unsigned long irq_err_count;
 
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
-#ifdef CONFIG_FIQ
 	show_fiq_list(p, prec);
-#endif
 #ifdef CONFIG_SMP
 	show_ipi_list(p, prec);
 #endif
diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
index 19701ec..426980c 100644
--- a/arch/arm/plat-mxc/avic.c
+++ b/arch/arm/plat-mxc/avic.c
@@ -216,10 +216,8 @@ void __init mxc_init_irq(void __iomem *irqbase)
 	for (i = 0; i < 8; i++)
 		__raw_writel(0, avic_base + AVIC_NIPRIORITY(i));
 
-#ifdef CONFIG_FIQ
 	/* Initialize FIQ */
 	init_FIQ();
-#endif
 
 	printk(KERN_INFO "MXC IRQ initialized\n");
 }
diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
index d09b573..8a5a633 100644
--- a/arch/arm/plat-mxc/tzic.c
+++ b/arch/arm/plat-mxc/tzic.c
@@ -191,10 +191,8 @@ void __init tzic_init_irq(void __iomem *irqbase)
 	for (i = 0; i < 4; i++, irq_base += 32)
 		tzic_init_gc(i, irq_base);
 
-#ifdef CONFIG_FIQ
 	/* Initialize FIQ */
 	init_FIQ();
-#endif
 
 	pr_info("TrustZone Interrupt Controller (TZIC) initialized\n");
 }
diff --git a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c
index e0de92a..531d6a4 100644
--- a/arch/arm/plat-s3c24xx/irq.c
+++ b/arch/arm/plat-s3c24xx/irq.c
@@ -532,9 +532,7 @@ void __init s3c24xx_init_irq(void)
 	int irqno;
 	int i;
 
-#ifdef CONFIG_FIQ
 	init_FIQ();
-#endif
 
 	irqdbf("s3c2410_init_irq: clearing interrupt status flags\n");
 
-- 
1.8.0
