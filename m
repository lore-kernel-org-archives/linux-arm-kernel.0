From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 26 Nov 2010 14:51:25 +0000
Subject: [PATCH 2/2] ARM: SAMSUNG: Convert irq-vic-timer to irq_ functions
In-Reply-To: <1290783085-20098-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1290783085-20098-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1290783085-20098-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Conver the VIC timer interrupts to use the irq_ versions of the IRQ
operatiosn introduced in 2.6.37, storing the mask for the timer
interrupt in the chip_data of the irq_data in order to save having to
do a substraction and a shift on every operation.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-samsung/irq-vic-timer.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-samsung/irq-vic-timer.c b/arch/arm/plat-samsung/irq-vic-timer.c
index 0270519..7ce77dd 100644
--- a/arch/arm/plat-samsung/irq-vic-timer.c
+++ b/arch/arm/plat-samsung/irq-vic-timer.c
@@ -29,38 +29,41 @@ static void s3c_irq_demux_vic_timer(unsigned int irq, struct irq_desc *desc)
 
 /* We assume the IRQ_TIMER0..IRQ_TIMER4 range is continuous. */
 
-static void s3c_irq_timer_mask(unsigned int irq)
+static void s3c_irq_timer_mask(struct irq_data *data)
 {
 	u32 reg = __raw_readl(S3C64XX_TINT_CSTAT);
+	u32 mask = (u32)data->chip_data;
 
 	reg &= 0x1f;  /* mask out pending interrupts */
-	reg &= ~(1 << (irq - IRQ_TIMER0));
+	reg &= ~mask;
 	__raw_writel(reg, S3C64XX_TINT_CSTAT);
 }
 
-static void s3c_irq_timer_unmask(unsigned int irq)
+static void s3c_irq_timer_unmask(struct irq_data *data)
 {
 	u32 reg = __raw_readl(S3C64XX_TINT_CSTAT);
+	u32 mask = (u32)data->chip_data;
 
 	reg &= 0x1f;  /* mask out pending interrupts */
-	reg |= 1 << (irq - IRQ_TIMER0);
+	reg |= mask;
 	__raw_writel(reg, S3C64XX_TINT_CSTAT);
 }
 
-static void s3c_irq_timer_ack(unsigned int irq)
+static void s3c_irq_timer_ack(struct irq_data *data)
 {
 	u32 reg = __raw_readl(S3C64XX_TINT_CSTAT);
+	u32 mask = (u32)data->chip_data;
 
 	reg &= 0x1f;
-	reg |= (1 << 5) << (irq - IRQ_TIMER0);
+	reg |= mask << 5;
 	__raw_writel(reg, S3C64XX_TINT_CSTAT);
 }
 
 static struct irq_chip s3c_irq_timer = {
 	.name		= "s3c-timer",
-	.mask		= s3c_irq_timer_mask,
-	.unmask		= s3c_irq_timer_unmask,
-	.ack		= s3c_irq_timer_ack,
+	.irq_mask	= s3c_irq_timer_mask,
+	.irq_unmask	= s3c_irq_timer_unmask,
+	.irq_ack	= s3c_irq_timer_ack,
 };
 
 /**
@@ -79,6 +82,7 @@ void __init s3c_init_vic_timer_irq(unsigned int parent_irq,
 	set_irq_chained_handler(parent_irq, s3c_irq_demux_vic_timer);
 
 	set_irq_chip(timer_irq, &s3c_irq_timer);
+	set_irq_chip_data(timer_irq, (void *)(1 << (timer_irq - IRQ_TIMER0)));
 	set_irq_handler(timer_irq, handle_level_irq);
 	set_irq_flags(timer_irq, IRQF_VALID);
 
-- 
1.7.1
