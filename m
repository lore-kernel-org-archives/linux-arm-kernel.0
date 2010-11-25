From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 25 Nov 2010 15:18:29 +0000
Subject: [PATCH 3/3] ARM: S3C64XX: Use chip_data to store the shift for EINTs
In-Reply-To: <1290698309-7691-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1290698309-7691-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1290698309-7691-3-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes all the functions that use the shift slightly smaller, one
instruction in most cases but more for ack() and maskack().

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/irq-eint.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/irq-eint.c b/arch/arm/mach-s3c64xx/irq-eint.c
index 169ee29..2ead818 100644
--- a/arch/arm/mach-s3c64xx/irq-eint.c
+++ b/arch/arm/mach-s3c64xx/irq-eint.c
@@ -30,14 +30,14 @@
 #include <plat/pm.h>
 
 #define eint_offset(irq)	((irq) - IRQ_EINT(0))
-#define eint_irq_to_bit(irq)	(1 << eint_offset(irq))
+#define eint_irq_to_bit(irq)	((u32)(1 << eint_offset(irq)))
 
 static inline void s3c_irq_eint_mask(struct irq_data *data)
 {
 	u32 mask;
 
 	mask = __raw_readl(S3C64XX_EINT0MASK);
-	mask |= eint_irq_to_bit(data->irq);
+	mask |= (u32)data->chip_data;
 	__raw_writel(mask, S3C64XX_EINT0MASK);
 }
 
@@ -46,13 +46,13 @@ static void s3c_irq_eint_unmask(struct irq_data *data)
 	u32 mask;
 
 	mask = __raw_readl(S3C64XX_EINT0MASK);
-	mask &= ~eint_irq_to_bit(data->irq);
+	mask &= ~((u32)data->chip_data);
 	__raw_writel(mask, S3C64XX_EINT0MASK);
 }
 
 static inline void s3c_irq_eint_ack(struct irq_data *data)
 {
-	__raw_writel(eint_irq_to_bit(data->irq), S3C64XX_EINT0PEND);
+	__raw_writel((u32)data->chip_data, S3C64XX_EINT0PEND);
 }
 
 static void s3c_irq_eint_maskack(struct irq_data *data)
@@ -198,6 +198,7 @@ static int __init s3c64xx_init_irq_eint(void)
 
 	for (irq = IRQ_EINT(0); irq <= IRQ_EINT(27); irq++) {
 		set_irq_chip(irq, &s3c_irq_eint);
+		set_irq_chip_data(irq, (void *)eint_irq_to_bit(irq));
 		set_irq_handler(irq, handle_level_irq);
 		set_irq_flags(irq, IRQF_VALID);
 	}
-- 
1.7.1
