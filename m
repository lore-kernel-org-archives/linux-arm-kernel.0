From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 26 Jul 2013 18:05:26 +0800
Subject: [PATCH v6 04/11] ARM: mmp: avoid to include head file in mach-mmp
In-Reply-To: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1374833133-21119-5-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pxa910_set_wake() & mmp2_set_wake() are both declared in head files
of arch/arm/mach-mmp/include/mach directory. If we include these
head files in irq-mmp driver, it blocks the multiplatform build.
So adjust the code.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/mmp2.c    |  4 ++++
 arch/arm/mach-mmp/pxa910.c  |  4 ++++
 drivers/irqchip/irq-mmp.c   | 15 +--------------
 include/linux/irqchip/mmp.h |  6 ++++++
 4 files changed, 15 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/irqchip/mmp.h

diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index c7592f1..09fbe7d 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -13,6 +13,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip/mmp.h>
 #include <linux/platform_device.h>
 
 #include <asm/hardware/cache-tauros2.h>
@@ -26,6 +28,7 @@
 #include <mach/mfp.h>
 #include <mach/devices.h>
 #include <mach/mmp2.h>
+#include <mach/pm-mmp2.h>
 
 #include "common.h"
 
@@ -94,6 +97,7 @@ void mmp2_clear_pmic_int(void)
 void __init mmp2_init_irq(void)
 {
 	mmp2_init_icu();
+	icu_irq_chip.irq_set_wake = mmp2_set_wake;
 }
 
 static int __init mmp2_init(void)
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index a586742..96e125b 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -12,6 +12,8 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip/mmp.h>
 #include <linux/platform_device.h>
 
 #include <asm/hardware/cache-tauros2.h>
@@ -23,6 +25,7 @@
 #include <mach/dma.h>
 #include <mach/mfp.h>
 #include <mach/devices.h>
+#include <mach/pm-pxa910.h>
 #include <mach/pxa910.h>
 
 #include "common.h"
@@ -80,6 +83,7 @@ static struct mfp_addr_map pxa910_mfp_addr_map[] __initdata =
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
diff --git a/include/linux/irqchip/mmp.h b/include/linux/irqchip/mmp.h
new file mode 100644
index 0000000..c78a892
--- /dev/null
+++ b/include/linux/irqchip/mmp.h
@@ -0,0 +1,6 @@
+#ifndef	__IRQCHIP_MMP_H
+#define	__IRQCHIP_MMP_H
+
+extern struct irq_chip icu_irq_chip;
+
+#endif	/* __IRQCHIP_MMP_H */
-- 
1.8.1.2
