From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:36:43 +0100
Subject: [PATCH 18/54] ARM: h720x: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130133643.GS15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-h720x/common.c    |   38 +++++++++++++++++++-------------------
 arch/arm/mach-h720x/cpu-h7202.c |   14 +++++++-------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-h720x/common.c b/arch/arm/mach-h720x/common.c
index bdb3f67..1f28c90 100644
--- a/arch/arm/mach-h720x/common.c
+++ b/arch/arm/mach-h720x/common.c
@@ -52,17 +52,17 @@ unsigned long h720x_gettimeoffset(void)
 /*
  * mask Global irq's
  */
-static void mask_global_irq (unsigned int irq )
+static void mask_global_irq(struct irq_data *d)
 {
-	CPU_REG (IRQC_VIRT, IRQC_IER) &= ~(1 << irq);
+	CPU_REG (IRQC_VIRT, IRQC_IER) &= ~(1 << d->irq);
 }
 
 /*
  * unmask Global irq's
  */
-static void unmask_global_irq (unsigned int irq )
+static void unmask_global_irq(struct irq_data *d)
 {
-	CPU_REG (IRQC_VIRT, IRQC_IER) |= (1 << irq);
+	CPU_REG (IRQC_VIRT, IRQC_IER) |= (1 << d->irq);
 }
 
 
@@ -70,10 +70,10 @@ static void unmask_global_irq (unsigned int irq )
  * ack GPIO irq's
  * Ack only for edge triggered int's valid
  */
-static void inline ack_gpio_irq(u32 irq)
+static void inline ack_gpio_irq(struct irq_data *d)
 {
-	u32 reg_base = GPIO_VIRT(IRQ_TO_REGNO(irq));
-	u32 bit = IRQ_TO_BIT(irq);
+	u32 reg_base = GPIO_VIRT(IRQ_TO_REGNO(d->irq));
+	u32 bit = IRQ_TO_BIT(d->irq);
 	if ( (CPU_REG (reg_base, GPIO_EDGE) & bit))
 		CPU_REG (reg_base, GPIO_CLR) = bit;
 }
@@ -81,20 +81,20 @@ static void inline ack_gpio_irq(u32 irq)
 /*
  * mask GPIO irq's
  */
-static void inline mask_gpio_irq(u32 irq)
+static void inline mask_gpio_irq(struct irq_data *d)
 {
-	u32 reg_base = GPIO_VIRT(IRQ_TO_REGNO(irq));
-	u32 bit = IRQ_TO_BIT(irq);
+	u32 reg_base = GPIO_VIRT(IRQ_TO_REGNO(d->irq));
+	u32 bit = IRQ_TO_BIT(d->irq);
 	CPU_REG (reg_base, GPIO_MASK) &= ~bit;
 }
 
 /*
  * unmask GPIO irq's
  */
-static void inline unmask_gpio_irq(u32 irq)
+static void inline unmask_gpio_irq(struct irq_data *d)
 {
-	u32 reg_base = GPIO_VIRT(IRQ_TO_REGNO(irq));
-	u32 bit = IRQ_TO_BIT(irq);
+	u32 reg_base = GPIO_VIRT(IRQ_TO_REGNO(d->irq));
+	u32 bit = IRQ_TO_BIT(d->irq);
 	CPU_REG (reg_base, GPIO_MASK) |= bit;
 }
 
@@ -170,15 +170,15 @@ h720x_gpioe_demux_handler(unsigned int irq_unused, struct irq_desc *desc)
 #endif
 
 static struct irq_chip h720x_global_chip = {
-	.ack = mask_global_irq,
-	.mask = mask_global_irq,
-	.unmask = unmask_global_irq,
+	.irq_ack = mask_global_irq,
+	.irq_mask = mask_global_irq,
+	.irq_unmask = unmask_global_irq,
 };
 
 static struct irq_chip h720x_gpio_chip = {
-	.ack = ack_gpio_irq,
-	.mask = mask_gpio_irq,
-	.unmask = unmask_gpio_irq,
+	.irq_ack = ack_gpio_irq,
+	.irq_mask = mask_gpio_irq,
+	.irq_unmask = unmask_gpio_irq,
 };
 
 /*
diff --git a/arch/arm/mach-h720x/cpu-h7202.c b/arch/arm/mach-h720x/cpu-h7202.c
index fd33a19..ac3f914 100644
--- a/arch/arm/mach-h720x/cpu-h7202.c
+++ b/arch/arm/mach-h720x/cpu-h7202.c
@@ -141,27 +141,27 @@ h7202_timer_interrupt(int irq, void *dev_id)
 /*
  * mask multiplexed timer IRQs
  */
-static void inline mask_timerx_irq (u32 irq)
+static void inline mask_timerx_irq(struct irq_data *d)
 {
 	unsigned int bit;
-	bit = 2 << ((irq == IRQ_TIMER64B) ? 4 : (irq - IRQ_TIMER1));
+	bit = 2 << ((d->irq == IRQ_TIMER64B) ? 4 : (d->irq - IRQ_TIMER1));
 	CPU_REG (TIMER_VIRT, TIMER_TOPCTRL) &= ~bit;
 }
 
 /*
  * unmask multiplexed timer IRQs
  */
-static void inline unmask_timerx_irq (u32 irq)
+static void inline unmask_timerx_irq(struct irq_data *d)
 {
 	unsigned int bit;
-	bit = 2 << ((irq == IRQ_TIMER64B) ? 4 : (irq - IRQ_TIMER1));
+	bit = 2 << ((d->irq == IRQ_TIMER64B) ? 4 : (d->irq - IRQ_TIMER1));
 	CPU_REG (TIMER_VIRT, TIMER_TOPCTRL) |= bit;
 }
 
 static struct irq_chip h7202_timerx_chip = {
-	.ack = mask_timerx_irq,
-	.mask = mask_timerx_irq,
-	.unmask = unmask_timerx_irq,
+	.irq_ack = mask_timerx_irq,
+	.irq_mask = mask_timerx_irq,
+	.irq_unmask = unmask_timerx_irq,
 };
 
 static struct irqaction h7202_timer_irq = {
-- 
1.7.1
