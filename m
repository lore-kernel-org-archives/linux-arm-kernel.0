From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 26 Jul 2013 18:05:27 +0800
Subject: [PATCH v6 05/11] irqchip: mmp: avoid to include irqs head file
In-Reply-To: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1374833133-21119-6-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since <mach/irqs.h> in irq-mmp.c blocks the multiplatform build,
remove it instead.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/irqchip/irq-mmp.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 1f81432..2cb7cd0 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -24,8 +24,6 @@
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
 
-#include <mach/irqs.h>
-
 #include "irqchip.h"
 
 #define MAX_ICU_NR		16
@@ -249,7 +247,7 @@ void __init icu_init_irq(void)
 /* MMP2 (ARMv7) */
 void __init mmp2_init_icu(void)
 {
-	int irq;
+	int irq, end;
 
 	max_icu_nr = 8;
 	mmp_icu_base = ioremap(0xd4282000, 0x1000);
@@ -263,11 +261,12 @@ void __init mmp2_init_icu(void)
 						   &icu_data[0]);
 	icu_data[1].reg_status = mmp_icu_base + 0x150;
 	icu_data[1].reg_mask = mmp_icu_base + 0x168;
-	icu_data[1].clr_mfp_irq_base = IRQ_MMP2_PMIC_BASE;
-	icu_data[1].clr_mfp_hwirq = IRQ_MMP2_PMIC - IRQ_MMP2_PMIC_BASE;
+	icu_data[1].clr_mfp_irq_base = icu_data[0].virq_base +
+				icu_data[0].nr_irqs;
+	icu_data[1].clr_mfp_hwirq = 1;		/* offset to IRQ_MMP2_PMIC_BASE */
 	icu_data[1].nr_irqs = 2;
 	icu_data[1].cascade_irq = 4;
-	icu_data[1].virq_base = IRQ_MMP2_PMIC_BASE;
+	icu_data[1].virq_base = icu_data[0].virq_base + icu_data[0].nr_irqs;
 	icu_data[1].domain = irq_domain_add_legacy(NULL, icu_data[1].nr_irqs,
 						   icu_data[1].virq_base, 0,
 						   &irq_domain_simple_ops,
@@ -276,7 +275,7 @@ void __init mmp2_init_icu(void)
 	icu_data[2].reg_mask = mmp_icu_base + 0x16c;
 	icu_data[2].nr_irqs = 2;
 	icu_data[2].cascade_irq = 5;
-	icu_data[2].virq_base = IRQ_MMP2_RTC_BASE;
+	icu_data[2].virq_base = icu_data[1].virq_base + icu_data[1].nr_irqs;
 	icu_data[2].domain = irq_domain_add_legacy(NULL, icu_data[2].nr_irqs,
 						   icu_data[2].virq_base, 0,
 						   &irq_domain_simple_ops,
@@ -285,7 +284,7 @@ void __init mmp2_init_icu(void)
 	icu_data[3].reg_mask = mmp_icu_base + 0x17c;
 	icu_data[3].nr_irqs = 3;
 	icu_data[3].cascade_irq = 9;
-	icu_data[3].virq_base = IRQ_MMP2_KEYPAD_BASE;
+	icu_data[3].virq_base = icu_data[2].virq_base + icu_data[2].nr_irqs;
 	icu_data[3].domain = irq_domain_add_legacy(NULL, icu_data[3].nr_irqs,
 						   icu_data[3].virq_base, 0,
 						   &irq_domain_simple_ops,
@@ -294,7 +293,7 @@ void __init mmp2_init_icu(void)
 	icu_data[4].reg_mask = mmp_icu_base + 0x170;
 	icu_data[4].nr_irqs = 5;
 	icu_data[4].cascade_irq = 17;
-	icu_data[4].virq_base = IRQ_MMP2_TWSI_BASE;
+	icu_data[4].virq_base = icu_data[3].virq_base + icu_data[3].nr_irqs;
 	icu_data[4].domain = irq_domain_add_legacy(NULL, icu_data[4].nr_irqs,
 						   icu_data[4].virq_base, 0,
 						   &irq_domain_simple_ops,
@@ -303,7 +302,7 @@ void __init mmp2_init_icu(void)
 	icu_data[5].reg_mask = mmp_icu_base + 0x174;
 	icu_data[5].nr_irqs = 15;
 	icu_data[5].cascade_irq = 35;
-	icu_data[5].virq_base = IRQ_MMP2_MISC_BASE;
+	icu_data[5].virq_base = icu_data[4].virq_base + icu_data[4].nr_irqs;
 	icu_data[5].domain = irq_domain_add_legacy(NULL, icu_data[5].nr_irqs,
 						   icu_data[5].virq_base, 0,
 						   &irq_domain_simple_ops,
@@ -312,7 +311,7 @@ void __init mmp2_init_icu(void)
 	icu_data[6].reg_mask = mmp_icu_base + 0x178;
 	icu_data[6].nr_irqs = 2;
 	icu_data[6].cascade_irq = 51;
-	icu_data[6].virq_base = IRQ_MMP2_MIPI_HSI1_BASE;
+	icu_data[6].virq_base = icu_data[5].virq_base + icu_data[5].nr_irqs;
 	icu_data[6].domain = irq_domain_add_legacy(NULL, icu_data[6].nr_irqs,
 						   icu_data[6].virq_base, 0,
 						   &irq_domain_simple_ops,
@@ -321,28 +320,26 @@ void __init mmp2_init_icu(void)
 	icu_data[7].reg_mask = mmp_icu_base + 0x184;
 	icu_data[7].nr_irqs = 2;
 	icu_data[7].cascade_irq = 55;
-	icu_data[7].virq_base = IRQ_MMP2_MIPI_HSI0_BASE;
+	icu_data[7].virq_base = icu_data[6].virq_base + icu_data[6].nr_irqs;
 	icu_data[7].domain = irq_domain_add_legacy(NULL, icu_data[7].nr_irqs,
 						   icu_data[7].virq_base, 0,
 						   &irq_domain_simple_ops,
 						   &icu_data[7]);
-	for (irq = 0; irq < IRQ_MMP2_MUX_END; irq++) {
+	end = icu_data[7].virq_base + icu_data[7].nr_irqs;
+	for (irq = 0; irq < end; irq++) {
 		icu_mask_irq(irq_get_irq_data(irq));
-		switch (irq) {
-		case IRQ_MMP2_PMIC_MUX:
-		case IRQ_MMP2_RTC_MUX:
-		case IRQ_MMP2_KEYPAD_MUX:
-		case IRQ_MMP2_TWSI_MUX:
-		case IRQ_MMP2_MISC_MUX:
-		case IRQ_MMP2_MIPI_HSI1_MUX:
-		case IRQ_MMP2_MIPI_HSI0_MUX:
+		if (irq == icu_data[1].cascade_irq ||
+		    irq == icu_data[2].cascade_irq ||
+		    irq == icu_data[3].cascade_irq ||
+		    irq == icu_data[4].cascade_irq ||
+		    irq == icu_data[5].cascade_irq ||
+		    irq == icu_data[6].cascade_irq ||
+		    irq == icu_data[7].cascade_irq) {
 			irq_set_chip(irq, &icu_irq_chip);
 			irq_set_chained_handler(irq, icu_mux_irq_demux);
-			break;
-		default:
+		} else {
 			irq_set_chip_and_handler(irq, &icu_irq_chip,
 						 handle_level_irq);
-			break;
 		}
 		set_irq_flags(irq, IRQF_VALID);
 	}
-- 
1.8.1.2
