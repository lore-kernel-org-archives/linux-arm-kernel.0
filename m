From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 12 Apr 2011 15:44:17 +0800
Subject: [PATCH] pxa270 rtc wakeup event fix
In-Reply-To: <201104082136.52297.marek.vasut@gmail.com>
References: <4D9F3AE4.2040101@gmail.com>
	<201104082136.52297.marek.vasut@gmail.com>
Message-ID: <BANLkTi=dUVins-kj2H6t6vwQKPKG8-PzQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nick,

Thanks for spotting this. The problem is really IRQ_TO_GPIO() macro
doesn't behave as assumed. A better approach would be to return -1
when none-GPIO IRQs are mapped back, let me know if you are OK w/
the patch below:

diff --git a/arch/arm/mach-pxa/include/mach/gpio.h
b/arch/arm/mach-pxa/include/mach/gpio.h
index b024a8b..b9f4ed1 100644
--- a/arch/arm/mach-pxa/include/mach/gpio.h
+++ b/arch/arm/mach-pxa/include/mach/gpio.h
@@ -103,7 +103,20 @@

 #define gpio_to_bank(gpio)	((gpio) >> 5)
 #define gpio_to_irq(gpio)	IRQ_GPIO(gpio)
-#define irq_to_gpio(irq)	IRQ_TO_GPIO(irq)
+
+static inline int irq_to_gpio(unsigned int irq)
+{
+	int gpio;
+
+	if (irq == IRQ_GPIO0 || irq == IRQ_GPIO1)
+		return irq - IRQ_GPIO0;
+
+	gpio = irq - PXA_GPIO_IRQ_BASE;
+	if (gpio >= 2 && gpio < NR_BUILTIN_GPIO)
+		return gpio;
+
+	return -1;
+}

 #ifdef CONFIG_CPU_PXA26x
 /* GPIO86/87/88/89 on PXA26x have their direction bits in GPDR2 inverted,
diff --git a/arch/arm/mach-pxa/include/mach/irqs.h
b/arch/arm/mach-pxa/include/mach/irqs.h
index a4285fc..0384024 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -93,9 +93,6 @@
 #define GPIO_2_x_TO_IRQ(x)	(PXA_GPIO_IRQ_BASE + (x))
 #define IRQ_GPIO(x)	(((x) < 2) ? (IRQ_GPIO0 + (x)) : GPIO_2_x_TO_IRQ(x))

-#define IRQ_TO_GPIO_2_x(i)	((i) - PXA_GPIO_IRQ_BASE)
-#define IRQ_TO_GPIO(i)	(((i) < IRQ_GPIO(2)) ? ((i) - IRQ_GPIO0) :
IRQ_TO_GPIO_2_x(i))
-
 /*
  * The following interrupts are for board specific purposes. Since
  * the kernel can only run on one machine@a time, we can re-use
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 6bde595..a4af8c5 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -285,7 +285,7 @@ static inline void pxa25x_init_pm(void) {}

 static int pxa25x_set_wake(struct irq_data *d, unsigned int on)
 {
-	int gpio = IRQ_TO_GPIO(d->irq);
+	int gpio = irq_to_gpio(d->irq);
 	uint32_t mask = 0;

 	if (gpio >= 0 && gpio < 85)
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 1cb5d0f..909756e 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -345,7 +345,7 @@ static inline void pxa27x_init_pm(void) {}
  */
 static int pxa27x_set_wake(struct irq_data *d, unsigned int on)
 {
-	int gpio = IRQ_TO_GPIO(d->irq);
+	int gpio = irq_to_gpio(d->irq);
 	uint32_t mask;

 	if (gpio >= 0 && gpio < 128)
