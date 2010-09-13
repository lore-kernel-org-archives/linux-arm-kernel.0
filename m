From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Mon, 13 Sep 2010 13:51:18 +0800
Subject: [PATCH 2/2] ARM: update HARDIRQ_BITS
In-Reply-To: <1284357078-16248-1-git-send-email-haojian.zhuang@marvell.com>
References: <1284357078-16248-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1284357078-16248-2-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the direct dependancy between HARDIRQ_BITS and NR_IRQS since SPARSE IRQ
is introduced in ARM architecture already.

Now if CONFIG_SPARSE_IRQ is enabled, check whether nr_irqs beyond the
limitation of HARDIRQ_BITS. If CONFIG_SPARSE_IRQ isn't enabled, check
whether HARDIRQ_BITS beyond the limitation of NR_IRQS.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/include/asm/hardirq.h |    9 +++------
 arch/arm/kernel/irq.c          |    4 ++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index 6d7485a..52c5624 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -12,14 +12,10 @@ typedef struct {
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-#if NR_IRQS > 512
+/* Restrict hardirq numbers not to exceed 1024. */
 #define HARDIRQ_BITS	10
-#elif NR_IRQS > 256
-#define HARDIRQ_BITS	9
-#else
-#define HARDIRQ_BITS	8
-#endif
 
+#ifndef CONFIG_SPARSE_IRQ
 /*
  * The hardirq mask has to be large enough to have space
  * for potentially all IRQ sources in the system nesting
@@ -28,6 +24,7 @@ typedef struct {
 #if (1 << HARDIRQ_BITS) < NR_IRQS
 # error HARDIRQ_BITS is too low!
 #endif
+#endif
 
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
 
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index c0d5c3b..82c9219 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -169,6 +169,10 @@ void __init init_IRQ(void)
 int __init arch_probe_nr_irqs(void)
 {
 	nr_irqs = arch_nr_irqs ? arch_nr_irqs : NR_IRQS;
+	if (nr_irqs < (1 << HARDIRQ_BITS)) {
+		printk(KERN_ERR "HARD_IRQBITS is too low. nr_irqs is %d\n", nr_irqs);
+		return -EINVAL;
+	}
 	return 0;
 }
 #endif
-- 
1.5.6.5
