From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 28 May 2013 10:21:47 +0800
Subject: [PATCH v2 5/5] ARM: mmp: avoid to include head file in mach-mmp
In-Reply-To: <1369707707-30295-1-git-send-email-haojian.zhuang@gmail.com>
References: <1369707707-30295-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1369707707-30295-6-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pxa910_set_wake() & mmp2_set_wake() are both declared in head files
of arch/arm/mach-mmp/include/mach directory. If we include these
head files in irq-mmp driver, it blocks the multiplatform build.

So adjust the code.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/mmp2.c    |  3 +++
 arch/arm/mach-mmp/pxa910.c  |  3 +++
 drivers/irqchip/irq-mmp.c   | 15 +--------------
 include/linux/irqchip/mmp.h |  2 ++
 4 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 08245c7..2e5ce13 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/irqchip/mmp.h>
 #include <linux/platform_device.h>
 
@@ -26,6 +27,7 @@
 #include <mach/mfp.h>
 #include <mach/devices.h>
 #include <mach/mmp2.h>
+#include <mach/pm-mmp2.h>
 
 #include "common.h"
 
@@ -94,6 +96,7 @@ void mmp2_clear_pmic_int(void)
 void __init mmp2_init_irq(void)
 {
 	mmp2_init_icu();
+	icu_irq_chip.irq_set_wake = mmp2_set_wake;
 }
 
 static int __init mmp2_init(void)
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 4ce3e16..78b6e22 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/irqchip/mmp.h>
 #include <linux/platform_device.h>
 
@@ -23,6 +24,7 @@
 #include <mach/dma.h>
 #include <mach/mfp.h>
 #include <mach/devices.h>
+#include <mach/pm-pxa910.h>
 #include <mach/pxa910.h>
 
 #include "common.h"
@@ -80,6 +82,7 @@ static struct mfp_addr_map pxa910_mfp_addr_map[] __initdata =
 void __init pxa910_init_irq(void)
 {
 	icu_init_irq();
+	icu_irq_chip.irq_set_wake = pxa910_set_wake;
 }
 
 static int __init pxa910_init(void)
diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 90fe265..b2ec91a 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -25,13 +25,6 @@
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
 
-#ifdef CONFIG_CPU_MMP2
-#include <mach/pm-mmp2.h>
-#endif
-#ifdef CONFIG_CPU_PXA910
-#include <mach/pm-pxa910.h>
-#endif
-
 #include "irqchip.h"
 
 #define MAX_ICU_NR		16
@@ -131,7 +124,7 @@ static void icu_unmask_irq(struct irq_data *d)
 	}
 }
 
-static struct irq_chip icu_irq_chip = {
+struct irq_chip icu_irq_chip = {
 	.name		= "icu_irq",
 	.irq_mask	= icu_mask_irq,
 	.irq_mask_ack	= icu_mask_ack_irq,
@@ -250,9 +243,6 @@ void __init icu_init_irq(void)
 	}
 	irq_set_default_host(icu_data[0].domain);
 	set_handle_irq(mmp_handle_irq);
-#ifdef CONFIG_CPU_PXA910
-	icu_irq_chip.irq_set_wake = pxa910_set_wake;
-#endif
 }
 
 /* MMP2 (ARMv7) */
@@ -357,9 +347,6 @@ void __init mmp2_init_icu(void)
 	}
 	irq_set_default_host(icu_data[0].domain);
 	set_handle_irq(mmp2_handle_irq);
-#ifdef CONFIG_CPU_MMP2
-	icu_irq_chip.irq_set_wake = mmp2_set_wake;
-#endif
 }
 
 #ifdef CONFIG_OF
diff --git a/include/linux/irqchip/mmp.h b/include/linux/irqchip/mmp.h
index fb492a5..98558b7 100644
--- a/include/linux/irqchip/mmp.h
+++ b/include/linux/irqchip/mmp.h
@@ -236,4 +236,6 @@
 #define IRQ_BOARD_START			(IRQ_GPIO_START + MMP_NR_BUILTIN_GPIO)
 #define MMP_NR_IRQS			IRQ_BOARD_START
 
+extern struct irq_chip icu_irq_chip;
+
 #endif /* __ASM_MACH_IRQS_H */
-- 
1.8.1.2
