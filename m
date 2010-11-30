From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:41:12 +0100
Subject: [PATCH 41/54] ARM: sa1100: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130134112.GP15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-sa1100/irq.c      |   84 +++++++++++++++++++-------------------
 arch/arm/mach-sa1100/neponset.c |    8 ++--
 2 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 3093d46..3d85dfa 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -37,14 +37,14 @@ static int GPIO_IRQ_mask = (1 << 11) - 1;
 #define GPIO_11_27_IRQ(i)	((i) - 21)
 #define GPIO11_27_MASK(irq)	(1 << GPIO_11_27_IRQ(irq))
 
-static int sa1100_gpio_type(unsigned int irq, unsigned int type)
+static int sa1100_gpio_type(struct irq_data *d, unsigned int type)
 {
 	unsigned int mask;
 
-	if (irq <= 10)
-		mask = 1 << irq;
+	if (d->irq <= 10)
+		mask = 1 << d->irq;
 	else
-		mask = GPIO11_27_MASK(irq);
+		mask = GPIO11_27_MASK(d->irq);
 
 	if (type == IRQ_TYPE_PROBE) {
 		if ((GPIO_IRQ_rising_edge | GPIO_IRQ_falling_edge) & mask)
@@ -70,37 +70,37 @@ static int sa1100_gpio_type(unsigned int irq, unsigned int type)
 /*
  * GPIO IRQs must be acknowledged.  This is for IRQs from 0 to 10.
  */
-static void sa1100_low_gpio_ack(unsigned int irq)
+static void sa1100_low_gpio_ack(struct irq_data *d)
 {
-	GEDR = (1 << irq);
+	GEDR = (1 << d->irq);
 }
 
-static void sa1100_low_gpio_mask(unsigned int irq)
+static void sa1100_low_gpio_mask(struct irq_data *d)
 {
-	ICMR &= ~(1 << irq);
+	ICMR &= ~(1 << d->irq);
 }
 
-static void sa1100_low_gpio_unmask(unsigned int irq)
+static void sa1100_low_gpio_unmask(struct irq_data *d)
 {
-	ICMR |= 1 << irq;
+	ICMR |= 1 << d->irq;
 }
 
-static int sa1100_low_gpio_wake(unsigned int irq, unsigned int on)
+static int sa1100_low_gpio_wake(struct irq_data *d, unsigned int on)
 {
 	if (on)
-		PWER |= 1 << irq;
+		PWER |= 1 << d->irq;
 	else
-		PWER &= ~(1 << irq);
+		PWER &= ~(1 << d->irq);
 	return 0;
 }
 
 static struct irq_chip sa1100_low_gpio_chip = {
 	.name		= "GPIO-l",
-	.ack		= sa1100_low_gpio_ack,
-	.mask		= sa1100_low_gpio_mask,
-	.unmask		= sa1100_low_gpio_unmask,
-	.set_type	= sa1100_gpio_type,
-	.set_wake	= sa1100_low_gpio_wake,
+	.irq_ack	= sa1100_low_gpio_ack,
+	.irq_mask	= sa1100_low_gpio_mask,
+	.irq_unmask	= sa1100_low_gpio_unmask,
+	.irq_set_type	= sa1100_gpio_type,
+	.irq_set_wake	= sa1100_low_gpio_wake,
 };
 
 /*
@@ -139,16 +139,16 @@ sa1100_high_gpio_handler(unsigned int irq, struct irq_desc *desc)
  * In addition, the IRQs are all collected up into one bit in the
  * interrupt controller registers.
  */
-static void sa1100_high_gpio_ack(unsigned int irq)
+static void sa1100_high_gpio_ack(struct irq_data *d)
 {
-	unsigned int mask = GPIO11_27_MASK(irq);
+	unsigned int mask = GPIO11_27_MASK(d->irq);
 
 	GEDR = mask;
 }
 
-static void sa1100_high_gpio_mask(unsigned int irq)
+static void sa1100_high_gpio_mask(struct irq_data *d)
 {
-	unsigned int mask = GPIO11_27_MASK(irq);
+	unsigned int mask = GPIO11_27_MASK(d->irq);
 
 	GPIO_IRQ_mask &= ~mask;
 
@@ -156,9 +156,9 @@ static void sa1100_high_gpio_mask(unsigned int irq)
 	GFER &= ~mask;
 }
 
-static void sa1100_high_gpio_unmask(unsigned int irq)
+static void sa1100_high_gpio_unmask(struct irq_data *d)
 {
-	unsigned int mask = GPIO11_27_MASK(irq);
+	unsigned int mask = GPIO11_27_MASK(d->irq);
 
 	GPIO_IRQ_mask |= mask;
 
@@ -166,44 +166,44 @@ static void sa1100_high_gpio_unmask(unsigned int irq)
 	GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
 }
 
-static int sa1100_high_gpio_wake(unsigned int irq, unsigned int on)
+static int sa1100_high_gpio_wake(struct irq_data *d, unsigned int on)
 {
 	if (on)
-		PWER |= GPIO11_27_MASK(irq);
+		PWER |= GPIO11_27_MASK(d->irq);
 	else
-		PWER &= ~GPIO11_27_MASK(irq);
+		PWER &= ~GPIO11_27_MASK(d->irq);
 	return 0;
 }
 
 static struct irq_chip sa1100_high_gpio_chip = {
 	.name		= "GPIO-h",
-	.ack		= sa1100_high_gpio_ack,
-	.mask		= sa1100_high_gpio_mask,
-	.unmask		= sa1100_high_gpio_unmask,
-	.set_type	= sa1100_gpio_type,
-	.set_wake	= sa1100_high_gpio_wake,
+	.irq_ack	= sa1100_high_gpio_ack,
+	.irq_mask	= sa1100_high_gpio_mask,
+	.irq_unmask	= sa1100_high_gpio_unmask,
+	.irq_set_type	= sa1100_gpio_type,
+	.irq_set_wake	= sa1100_high_gpio_wake,
 };
 
 /*
  * We don't need to ACK IRQs on the SA1100 unless they're GPIOs
  * this is for internal IRQs i.e. from 11 to 31.
  */
-static void sa1100_mask_irq(unsigned int irq)
+static void sa1100_mask_irq(struct irq_data *d)
 {
-	ICMR &= ~(1 << irq);
+	ICMR &= ~(1 << d->irq);
 }
 
-static void sa1100_unmask_irq(unsigned int irq)
+static void sa1100_unmask_irq(struct irq_data *d)
 {
-	ICMR |= (1 << irq);
+	ICMR |= (1 << d->irq);
 }
 
 /*
  * Apart form GPIOs, only the RTC alarm can be a wakeup event.
  */
-static int sa1100_set_wake(unsigned int irq, unsigned int on)
+static int sa1100_set_wake(struct irq_data *d, unsigned int on)
 {
-	if (irq == IRQ_RTCAlrm) {
+	if (d->irq == IRQ_RTCAlrm) {
 		if (on)
 			PWER |= PWER_RTC;
 		else
@@ -215,10 +215,10 @@ static int sa1100_set_wake(unsigned int irq, unsigned int on)
 
 static struct irq_chip sa1100_normal_chip = {
 	.name		= "SC",
-	.ack		= sa1100_mask_irq,
-	.mask		= sa1100_mask_irq,
-	.unmask		= sa1100_unmask_irq,
-	.set_wake	= sa1100_set_wake,
+	.irq_ack	= sa1100_mask_irq,
+	.irq_mask	= sa1100_mask_irq,
+	.irq_unmask	= sa1100_unmask_irq,
+	.irq_set_wake	= sa1100_set_wake,
 };
 
 static struct resource irq_resource = {
diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index c601a75..4aad01f 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -35,7 +35,7 @@ neponset_irq_handler(unsigned int irq, struct irq_desc *desc)
 		/*
 		 * Acknowledge the parent IRQ.
 		 */
-		desc->chip->ack(irq);
+		desc->irq_data.chip->irq_ack(&desc->irq_data);
 
 		/*
 		 * Read the interrupt reason register.  Let's have all
@@ -53,7 +53,7 @@ neponset_irq_handler(unsigned int irq, struct irq_desc *desc)
 		 * recheck the register for any pending IRQs.
 		 */
 		if (irr & (IRR_ETHERNET | IRR_USAR)) {
-			desc->chip->mask(irq);
+			desc->irq_data.chip->irq_mask(&desc->irq_data);
 
 			/*
 			 * Ack the interrupt now to prevent re-entering
@@ -61,7 +61,7 @@ neponset_irq_handler(unsigned int irq, struct irq_desc *desc)
 			 * since we'll check the IRR register prior to
 			 * leaving.
 			 */
-			desc->chip->ack(irq);
+			desc->irq_data.chip->irq_ack(&desc->irq_data);
 
 			if (irr & IRR_ETHERNET) {
 				generic_handle_irq(IRQ_NEPONSET_SMC9196);
@@ -71,7 +71,7 @@ neponset_irq_handler(unsigned int irq, struct irq_desc *desc)
 				generic_handle_irq(IRQ_NEPONSET_USAR);
 			}
 
-			desc->chip->unmask(irq);
+			desc->irq_data.chip->irq_unmask(&desc->irq_data);
 		}
 
 		if (irr & IRR_SA1111) {
-- 
1.7.1
