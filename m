From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon,  3 Jun 2013 17:30:38 +0800
Subject: [PATCH v3 04/11] ARM: mmp: avoid to include head file in mach-mmp
In-Reply-To: <1370251845-31373-1-git-send-email-haojian.zhuang@gmail.com>
References: <1370251845-31373-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1370251845-31373-5-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pxa910_set_wake() & mmp2_set_wake() are both declared in head files
of arch/arm/mach-mmp/include/mach directory. If we include these
head files in irq-mmp driver, it blocks the multiplatform build.
So adjust the code.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/mmp2.c   |  4 ++++
 arch/arm/mach-mmp/pxa910.c |  4 ++++
 drivers/irqchip/irq-mmp.c  | 15 +--------------
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index c7592f1..4dbf3e0 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/platform_device.h>
 
 #include <asm/hardware/cache-tauros2.h>
@@ -26,6 +27,7 @@
 #include <mach/mfp.h>
 #include <mach/devices.h>
 #include <mach/mmp2.h>
+#include <mach/pm-mmp2.h>
 
 #include "common.h"
 
@@ -91,9 +93,11 @@ void mmp2_clear_pmic_int(void)
 	__raw_writel(data, mfpr_pmic);
 }
 
+extern struct irq_chip icu_irq_chip;
 void __init mmp2_init_irq(void)
 {
 	mmp2_init_icu();
+	icu_irq_chip.irq_set_wake = mmp2_set_wake;
 }
 
 static int __init mmp2_init(void)
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index a586742..df7e33f 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/platform_device.h>
 
 #include <asm/hardware/cache-tauros2.h>
@@ -23,6 +24,7 @@
 #include <mach/dma.h>
 #include <mach/mfp.h>
 #include <mach/devices.h>
+#include <mach/pm-pxa910.h>
 #include <mach/pxa910.h>
 
 #include "common.h"
@@ -77,9 +79,11 @@ static struct mfp_addr_map pxa910_mfp_addr_map[] __initdata =
 	MFP_ADDR_END,
 };
 
+extern struct irq_chip icu_irq_chip;
 void __init pxa910_init_irq(void)
 {
 	icu_init_irq();
+	icu_irq_chip.irq_set_wake = pxa910_set_wake;
 }
 
 static int __init pxa910_init(void)
diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 84d51ff..1f81432 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -26,13 +26,6 @@
 
 #include <mach/irqs.h>
 
-#ifdef CONFIG_CPU_MMP2
-#include <mach/pm-mmp2.h>
-#endif
-#ifdef CONFIG_CPU_PXA910
-#include <mach/pm-pxa910.h>
-#endif
-
 #include "irqchip.h"
 
 #define MAX_ICU_NR		16
@@ -132,7 +125,7 @@ static void icu_unmask_irq(struct irq_data *d)
 	}
 }
 
-static struct irq_chip icu_irq_chip = {
+struct irq_chip icu_irq_chip = {
 	.name		= "icu_irq",
 	.irq_mask	= icu_mask_irq,
 	.irq_mask_ack	= icu_mask_ack_irq,
@@ -251,9 +244,6 @@ void __init icu_init_irq(void)
 	}
 	irq_set_default_host(icu_data[0].domain);
 	set_handle_irq(mmp_handle_irq);
-#ifdef CONFIG_CPU_PXA910
-	icu_irq_chip.irq_set_wake = pxa910_set_wake;
-#endif
 }
 
 /* MMP2 (ARMv7) */
@@ -358,9 +348,6 @@ void __init mmp2_init_icu(void)
 	}
 	irq_set_default_host(icu_data[0].domain);
 	set_handle_irq(mmp2_handle_irq);
-#ifdef CONFIG_CPU_MMP2
-	icu_irq_chip.irq_set_wake = mmp2_set_wake;
-#endif
 }
 
 #ifdef CONFIG_OF
-- 
1.8.1.2
