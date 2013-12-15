From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 15 Dec 2013 08:28:11 +0400
Subject: [PATCH v3 04/10] arm: sa1100: use new functions that hide PWER access
In-Reply-To: <1387081697-21841-1-git-send-email-dbaryshkov@gmail.com>
References: <1387081697-21841-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1387081697-21841-5-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to continue cleaning up of the sa11x0 IRQ driver, split away
PWER setting. Now irq driver asks core to enable either irq wake event
or to enable GPIO wake event, instead of accessing PWER directly.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/irq.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 68e8f9d..341d296 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -33,6 +33,7 @@
 static int GPIO_IRQ_rising_edge;
 static int GPIO_IRQ_falling_edge;
 static int GPIO_IRQ_mask = (1 << 11) - 1;
+static int GPIO_IRQ_wake_mask;
 
 /*
  * To get the GPIO number from an IRQ number
@@ -91,10 +92,11 @@ static void sa1100_low_gpio_unmask(struct irq_data *d)
 static int sa1100_low_gpio_wake(struct irq_data *d, unsigned int on)
 {
 	if (on)
-		PWER |= 1 << d->irq;
+		GPIO_IRQ_wake_mask |= BIT(d->irq);
 	else
-		PWER &= ~(1 << d->irq);
-	return 0;
+		GPIO_IRQ_wake_mask &= ~BIT(d->irq);
+
+	return sa11x0_gpio_set_wake(d->irq, on);
 }
 
 static struct irq_chip sa1100_low_gpio_chip = {
@@ -172,10 +174,11 @@ static void sa1100_high_gpio_unmask(struct irq_data *d)
 static int sa1100_high_gpio_wake(struct irq_data *d, unsigned int on)
 {
 	if (on)
-		PWER |= GPIO11_27_MASK(d->irq);
+		GPIO_IRQ_wake_mask |= GPIO11_27_MASK(d->irq);
 	else
-		PWER &= ~GPIO11_27_MASK(d->irq);
-	return 0;
+		GPIO_IRQ_wake_mask &= ~GPIO11_27_MASK(d->irq);
+
+	return sa11x0_gpio_set_wake(GPIO_11_27_IRQ(d->irq), on);
 }
 
 static struct irq_chip sa1100_high_gpio_chip = {
@@ -206,14 +209,7 @@ static void sa1100_unmask_irq(struct irq_data *d)
  */
 static int sa1100_set_wake(struct irq_data *d, unsigned int on)
 {
-	if (d->irq == IRQ_RTCAlrm) {
-		if (on)
-			PWER |= PWER_RTC;
-		else
-			PWER &= ~PWER_RTC;
-		return 0;
-	}
-	return -EINVAL;
+	return sa11x0_sc_set_wake(d->irq, on);
 }
 
 static struct irq_chip sa1100_normal_chip = {
@@ -253,8 +249,8 @@ static int sa1100irq_suspend(void)
 	/*
 	 * Set the appropriate edges for wakeup.
 	 */
-	GRER = PWER & GPIO_IRQ_rising_edge;
-	GFER = PWER & GPIO_IRQ_falling_edge;
+	GRER = GPIO_IRQ_wake_mask & GPIO_IRQ_rising_edge;
+	GFER = GPIO_IRQ_wake_mask & GPIO_IRQ_falling_edge;
 	
 	/*
 	 * Clear any pending GPIO interrupts.
-- 
1.8.5.1
