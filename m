From: chaos.youn@samsung.com (Changhwan Youn)
Date: Tue, 19 Apr 2011 10:45:26 +0900
Subject: [PATCH 3/3] ARM: EXYNOS4: add entry and exit functions for external
	interrupt chained handler
In-Reply-To: <1303177526-11744-1-git-send-email-chaos.youn@samsung.com>
References: <1303177526-11744-1-git-send-email-chaos.youn@samsung.com>
Message-ID: <1303177526-11744-4-git-send-email-chaos.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This functions are added for properly controlling primary controller
in exnternal interrupt chained handler.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
---
 arch/arm/mach-exynos4/irq-eint.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-exynos4/irq-eint.c b/arch/arm/mach-exynos4/irq-eint.c
index 4f7ad4a..f9d9b48 100644
--- a/arch/arm/mach-exynos4/irq-eint.c
+++ b/arch/arm/mach-exynos4/irq-eint.c
@@ -22,6 +22,7 @@
 #include <plat/gpio-cfg.h>
 
 #include <mach/regs-gpio.h>
+#include <asm/mach/irq.h>
 
 static DEFINE_SPINLOCK(eint_lock);
 
@@ -184,8 +185,12 @@ static inline void exynos4_irq_demux_eint(unsigned int start)
 
 static void exynos4_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
 {
+	struct irq_chip *chip = get_irq_chip(irq);
+
+	chained_irq_enter(chip, desc);
 	exynos4_irq_demux_eint(IRQ_EINT(16));
 	exynos4_irq_demux_eint(IRQ_EINT(24));
+	chained_irq_exit(chip, desc);
 }
 
 static void exynos4_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
@@ -193,14 +198,9 @@ static void exynos4_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
 	u32 *irq_data = get_irq_data(irq);
 	struct irq_chip *chip = get_irq_chip(irq);
 
-	chip->irq_mask(&desc->irq_data);
-
-	if (chip->irq_ack)
-		chip->irq_ack(&desc->irq_data);
-
+	chained_irq_enter(chip, desc);
 	generic_handle_irq(*irq_data);
-
-	chip->irq_unmask(&desc->irq_data);
+	chained_irq_exit(chip, desc);
 }
 
 int __init exynos4_init_irq_eint(void)
-- 
1.7.1
