From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Jun 2012 15:07:44 +0800
Subject: [PATCH] ARM: fiq: change FIQ_START to a variable
Message-ID: <1340867264-23043-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit a2be01b (ARM: only include mach/irqs.h for !SPARSE_IRQ)
makes mach/irqs.h only be included for !SPARSE_IRQ build.  There are
a nubmer of platforms have FIQ_START defined in mach/irqs.h for FIQ
support.

  arch/arm/mach-rpc/include/mach/irqs.h:#define FIQ_START         64
  arch/arm/mach-s3c24xx/include/mach/irqs.h:#define FIQ_START             IRQ_EINT0
  arch/arm/plat-mxc/include/mach/irqs.h:#define FIQ_START 0

If SPARSE_IRQ is enabled for any of these platforms, the following
compile error will be seen.

  arch/arm/kernel/fiq.c: In function ?enable_fiq?:
  arch/arm/kernel/fiq.c:127:19: error: ?FIQ_START? undeclared (first use in this function)
  arch/arm/kernel/fiq.c:127:19: note: each undeclared identifier is reported only once for each function it appears in
  arch/arm/kernel/fiq.c: In function ?disable_fiq?:
  arch/arm/kernel/fiq.c:132:20: error: ?FIQ_START? undeclared (first use in this function)

The patch changes fiq code to have init_FIQ take FIQ_START from
platforms as a parameter and assign it to variable fiq_start which
is to replace FIQ_START uses in enable_fiq/disable_fiq.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/asm/mach/irq.h |    2 +-
 arch/arm/kernel/fiq.c           |    9 ++++++---
 arch/arm/mach-rpc/irq.c         |    2 +-
 arch/arm/plat-mxc/avic.c        |    2 +-
 arch/arm/plat-mxc/tzic.c        |    2 +-
 arch/arm/plat-s3c24xx/irq.c     |    2 +-
 6 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/mach/irq.h b/arch/arm/include/asm/mach/irq.h
index febe495..15cb035 100644
--- a/arch/arm/include/asm/mach/irq.h
+++ b/arch/arm/include/asm/mach/irq.h
@@ -17,7 +17,7 @@ struct seq_file;
 /*
  * This is internal.  Do not use it.
  */
-extern void init_FIQ(void);
+extern void init_FIQ(int);
 extern int show_fiq_list(struct seq_file *, int);
 
 #ifdef CONFIG_MULTI_IRQ_HANDLER
diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index c32f845..2adda11 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -122,14 +122,16 @@ void release_fiq(struct fiq_handler *f)
 	while (current_fiq->fiq_op(current_fiq->dev_id, 0));
 }
 
+static int fiq_start;
+
 void enable_fiq(int fiq)
 {
-	enable_irq(fiq + FIQ_START);
+	enable_irq(fiq + fiq_start);
 }
 
 void disable_fiq(int fiq)
 {
-	disable_irq(fiq + FIQ_START);
+	disable_irq(fiq + fiq_start);
 }
 
 EXPORT_SYMBOL(set_fiq_handler);
@@ -140,7 +142,8 @@ EXPORT_SYMBOL(release_fiq);
 EXPORT_SYMBOL(enable_fiq);
 EXPORT_SYMBOL(disable_fiq);
 
-void __init init_FIQ(void)
+void __init init_FIQ(int start)
 {
 	no_fiq_insn = *(unsigned long *)0xffff001c;
+	fiq_start = start;
 }
diff --git a/arch/arm/mach-rpc/irq.c b/arch/arm/mach-rpc/irq.c
index cf0e669..3e4fa84 100644
--- a/arch/arm/mach-rpc/irq.c
+++ b/arch/arm/mach-rpc/irq.c
@@ -163,6 +163,6 @@ void __init rpc_init_irq(void)
 		}
 	}
 
-	init_FIQ();
+	init_FIQ(FIQ_START);
 }
 
diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
index e612cc1..f3d671f 100644
--- a/arch/arm/plat-mxc/avic.c
+++ b/arch/arm/plat-mxc/avic.c
@@ -217,7 +217,7 @@ void __init mxc_init_irq(void __iomem *irqbase)
 
 #ifdef CONFIG_FIQ
 	/* Initialize FIQ */
-	init_FIQ();
+	init_FIQ(FIQ_START);
 #endif
 
 	printk(KERN_INFO "MXC IRQ initialized\n");
diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
index abc90e4..c60a7e4 100644
--- a/arch/arm/plat-mxc/tzic.c
+++ b/arch/arm/plat-mxc/tzic.c
@@ -192,7 +192,7 @@ void __init tzic_init_irq(void __iomem *irqbase)
 
 #ifdef CONFIG_FIQ
 	/* Initialize FIQ */
-	init_FIQ();
+	init_FIQ(FIQ_START);
 #endif
 
 	pr_info("TrustZone Interrupt Controller (TZIC) initialized\n");
diff --git a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c
index bc42c04..fe57bbb 100644
--- a/arch/arm/plat-s3c24xx/irq.c
+++ b/arch/arm/plat-s3c24xx/irq.c
@@ -533,7 +533,7 @@ void __init s3c24xx_init_irq(void)
 	int i;
 
 #ifdef CONFIG_FIQ
-	init_FIQ();
+	init_FIQ(FIQ_START);
 #endif
 
 	irqdbf("s3c2410_init_irq: clearing interrupt status flags\n");
-- 
1.7.5.4
