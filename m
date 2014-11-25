From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 25 Nov 2014 22:09:47 +0300
Subject: [PATCH v2 3/8] ARM: sa1100: replace irq numbers with names in irq
 driver
In-Reply-To: <1416942592-23059-1-git-send-email-dbaryshkov@gmail.com>
References: <1416942592-23059-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1416942592-23059-4-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for further changes replace direct IRQ numbers with
pre-defined names. This imposes no real code changes.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/irq.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 4a1bd5e..0b29d27 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -37,14 +37,14 @@ static int GPIO_IRQ_mask = (1 << 11) - 1;
 /*
  * To get the GPIO number from an IRQ number
  */
-#define GPIO_11_27_IRQ(i)	((i) - 21)
+#define GPIO_11_27_IRQ(i)	((i) + 11 - IRQ_GPIO11)
 #define GPIO11_27_MASK(irq)	(1 << GPIO_11_27_IRQ(irq))
 
 static int sa1100_gpio_type(struct irq_data *d, unsigned int type)
 {
 	unsigned int mask;
 
-	if (d->irq <= 10)
+	if (d->irq <= IRQ_GPIO10)
 		mask = 1 << d->irq;
 	else
 		mask = GPIO11_27_MASK(d->irq);
@@ -71,7 +71,7 @@ static int sa1100_gpio_type(struct irq_data *d, unsigned int type)
 }
 
 /*
- * GPIO IRQs must be acknowledged.  This is for IRQs from 0 to 10.
+ * GPIO IRQs must be acknowledged.  This is for IRQs from GPIO0 to 10.
  */
 static void sa1100_low_gpio_ack(struct irq_data *d)
 {
@@ -189,7 +189,7 @@ static struct irq_chip sa1100_high_gpio_chip = {
 
 /*
  * We don't need to ACK IRQs on the SA1100 unless they're GPIOs
- * this is for internal IRQs i.e. from 11 to 31.
+ * this is for internal IRQs i.e. from IRQ LCD to RTCAlrm.
  */
 static void sa1100_mask_irq(struct irq_data *d)
 {
@@ -332,19 +332,19 @@ void __init sa1100_init_irq(void)
 	 */
 	ICCR = 1;
 
-	for (irq = 0; irq <= 10; irq++) {
+	for (irq = IRQ_GPIO0; irq <= IRQ_GPIO10; irq++) {
 		irq_set_chip_and_handler(irq, &sa1100_low_gpio_chip,
 					 handle_edge_irq);
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 	}
 
-	for (irq = 12; irq <= 31; irq++) {
+	for (irq = IRQ_LCD; irq <= IRQ_RTCAlrm; irq++) {
 		irq_set_chip_and_handler(irq, &sa1100_normal_chip,
 					 handle_level_irq);
 		set_irq_flags(irq, IRQF_VALID);
 	}
 
-	for (irq = 32; irq <= 48; irq++) {
+	for (irq = IRQ_GPIO11; irq <= IRQ_GPIO27; irq++) {
 		irq_set_chip_and_handler(irq, &sa1100_high_gpio_chip,
 					 handle_edge_irq);
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-- 
2.1.3
