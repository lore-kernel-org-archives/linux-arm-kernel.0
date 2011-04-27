From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 27 Apr 2011 22:48:04 +0800
Subject: [PATCH 1/2] ARM: pxa: avoid accessing interrupt registers directly
Message-ID: <1303915685-14823-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/include/mach/irqs.h      |    7 ++++++
 arch/arm/mach-pxa/include/mach/regs-intc.h |   30 ----------------------------
 arch/arm/mach-pxa/irq.c                    |    4 +-
 arch/arm/mach-pxa/pxa3xx.c                 |    5 +--
 arch/arm/mach-pxa/pxa95x.c                 |    1 -
 5 files changed, 11 insertions(+), 36 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/include/mach/regs-intc.h

diff --git a/arch/arm/mach-pxa/include/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h
index 0384024..a94c694 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -104,4 +104,11 @@
 
 #define NR_IRQS			(IRQ_BOARD_START)
 
+#ifndef __ASSEMBLY__
+struct irq_data;
+
+void pxa_mask_irq(struct irq_data *);
+void pxa_unmask_irq(struct irq_data *);
+#endif
+
 #endif /* __ASM_MACH_IRQS_H */
diff --git a/arch/arm/mach-pxa/include/mach/regs-intc.h b/arch/arm/mach-pxa/include/mach/regs-intc.h
deleted file mode 100644
index 662288e..0000000
--- a/arch/arm/mach-pxa/include/mach/regs-intc.h
+++ /dev/null
@@ -1,30 +0,0 @@
-#ifndef __ASM_MACH_REGS_INTC_H
-#define __ASM_MACH_REGS_INTC_H
-
-#include <mach/hardware.h>
-
-/*
- * Interrupt Controller
- */
-
-#define ICIP		__REG(0x40D00000)  /* Interrupt Controller IRQ Pending Register */
-#define ICMR		__REG(0x40D00004)  /* Interrupt Controller Mask Register */
-#define ICLR		__REG(0x40D00008)  /* Interrupt Controller Level Register */
-#define ICFP		__REG(0x40D0000C)  /* Interrupt Controller FIQ Pending Register */
-#define ICPR		__REG(0x40D00010)  /* Interrupt Controller Pending Register */
-#define ICCR		__REG(0x40D00014)  /* Interrupt Controller Control Register */
-#define ICHP		__REG(0x40D00018)  /* Interrupt Controller Highest Priority Register */
-
-#define ICIP2		__REG(0x40D0009C)  /* Interrupt Controller IRQ Pending Register 2 */
-#define ICMR2		__REG(0x40D000A0)  /* Interrupt Controller Mask Register 2 */
-#define ICLR2		__REG(0x40D000A4)  /* Interrupt Controller Level Register 2 */
-#define ICFP2		__REG(0x40D000A8)  /* Interrupt Controller FIQ Pending Register 2 */
-#define ICPR2		__REG(0x40D000AC)  /* Interrupt Controller Pending Register 2 */
-
-#define ICIP3		__REG(0x40D00130)  /* Interrupt Controller IRQ Pending Register 3 */
-#define ICMR3		__REG(0x40D00134)  /* Interrupt Controller Mask Register 3 */
-#define ICLR3		__REG(0x40D00138)  /* Interrupt Controller Level Register 3 */
-#define ICFP3		__REG(0x40D0013C)  /* Interrupt Controller FIQ Pending Register 3 */
-#define ICPR3		__REG(0x40D00140)  /* Interrupt Controller Pending Register 3 */
-
-#endif /* __ASM_MACH_REGS_INTC_H */
diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 6251e3f..0aeeff4 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -64,7 +64,7 @@ static inline void __iomem *irq_base(int i)
 	return (void __iomem *)io_p2v(phys_base[i]);
 }
 
-static void pxa_mask_irq(struct irq_data *d)
+void pxa_mask_irq(struct irq_data *d)
 {
 	void __iomem *base = irq_data_get_irq_chip_data(d);
 	uint32_t icmr = __raw_readl(base + ICMR);
@@ -73,7 +73,7 @@ static void pxa_mask_irq(struct irq_data *d)
 	__raw_writel(icmr, base + ICMR);
 }
 
-static void pxa_unmask_irq(struct irq_data *d)
+void pxa_unmask_irq(struct irq_data *d)
 {
 	void __iomem *base = irq_data_get_irq_chip_data(d);
 	uint32_t icmr = __raw_readl(base + ICMR);
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 8dd1073..9ec0813 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -31,7 +31,6 @@
 #include <mach/ohci.h>
 #include <mach/pm.h>
 #include <mach/dma.h>
-#include <mach/regs-intc.h>
 #include <mach/smemc.h>
 
 #include "generic.h"
@@ -328,13 +327,13 @@ static void pxa_ack_ext_wakeup(struct irq_data *d)
 
 static void pxa_mask_ext_wakeup(struct irq_data *d)
 {
-	ICMR2 &= ~(1 << ((d->irq - PXA_IRQ(0)) & 0x1f));
+	pxa_mask_irq(d);
 	PECR &= ~PECR_IE(d->irq - IRQ_WAKEUP0);
 }
 
 static void pxa_unmask_ext_wakeup(struct irq_data *d)
 {
-	ICMR2 |= 1 << ((d->irq - PXA_IRQ(0)) & 0x1f);
+	pxa_unmask_irq(d);
 	PECR |= PECR_IE(d->irq - IRQ_WAKEUP0);
 }
 
diff --git a/arch/arm/mach-pxa/pxa95x.c b/arch/arm/mach-pxa/pxa95x.c
index 23b229b..3f74a46 100644
--- a/arch/arm/mach-pxa/pxa95x.c
+++ b/arch/arm/mach-pxa/pxa95x.c
@@ -27,7 +27,6 @@
 #include <mach/reset.h>
 #include <mach/pm.h>
 #include <mach/dma.h>
-#include <mach/regs-intc.h>
 
 #include "generic.h"
 #include "devices.h"
-- 
1.7.1
