From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 13 Apr 2011 09:44:43 +0800
Subject: [PATCH] ARM: pxa: convert incorrect IRQ_TO_IRQ() to irq_to_gpio()
Message-ID: <1302659083-5772-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the failure to register the IRQ_RTCAlrm alarm as a wakeup
event.  It is misinterpreted as a gpio irq not a PWER bitmask. Fixed
this by converting the incorrect IRQ_TO_IRQ() to a correct version of
irq_to_gpio().

Reported-by: Nick Bane <nickbane1@gmail.com>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/include/mach/gpio.h |   15 ++++++++++++++-
 arch/arm/mach-pxa/include/mach/irqs.h |    3 ---
 arch/arm/mach-pxa/pxa25x.c            |    2 +-
 arch/arm/mach-pxa/pxa27x.c            |    2 +-
 drivers/pcmcia/pxa2xx_trizeps4.c      |   12 ++++++------
 5 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/gpio.h b/arch/arm/mach-pxa/include/mach/gpio.h
index 48ef925..c463950 100644
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
diff --git a/arch/arm/mach-pxa/include/mach/irqs.h b/arch/arm/mach-pxa/include/mach/irqs.h
index a4285fc..0384024 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -93,9 +93,6 @@
 #define GPIO_2_x_TO_IRQ(x)	(PXA_GPIO_IRQ_BASE + (x))
 #define IRQ_GPIO(x)	(((x) < 2) ? (IRQ_GPIO0 + (x)) : GPIO_2_x_TO_IRQ(x))
 
-#define IRQ_TO_GPIO_2_x(i)	((i) - PXA_GPIO_IRQ_BASE)
-#define IRQ_TO_GPIO(i)	(((i) < IRQ_GPIO(2)) ? ((i) - IRQ_GPIO0) : IRQ_TO_GPIO_2_x(i))
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
diff --git a/drivers/pcmcia/pxa2xx_trizeps4.c b/drivers/pcmcia/pxa2xx_trizeps4.c
index 5bb4e1a..b829e65 100644
--- a/drivers/pcmcia/pxa2xx_trizeps4.c
+++ b/drivers/pcmcia/pxa2xx_trizeps4.c
@@ -69,15 +69,15 @@ static int trizeps_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	for (i = 0; i < ARRAY_SIZE(irqs); i++) {
 		if (irqs[i].sock != skt->nr)
 			continue;
-		if (gpio_request(IRQ_TO_GPIO(irqs[i].irq), irqs[i].str) < 0) {
+		if (gpio_request(irq_to_gpio(irqs[i].irq), irqs[i].str) < 0) {
 			pr_err("%s: sock %d unable to request gpio %d\n",
-				__func__, skt->nr, IRQ_TO_GPIO(irqs[i].irq));
+				__func__, skt->nr, irq_to_gpio(irqs[i].irq));
 			ret = -EBUSY;
 			goto error;
 		}
-		if (gpio_direction_input(IRQ_TO_GPIO(irqs[i].irq)) < 0) {
+		if (gpio_direction_input(irq_to_gpio(irqs[i].irq)) < 0) {
 			pr_err("%s: sock %d unable to set input gpio %d\n",
-				__func__, skt->nr, IRQ_TO_GPIO(irqs[i].irq));
+				__func__, skt->nr, irq_to_gpio(irqs[i].irq));
 			ret = -EINVAL;
 			goto error;
 		}
@@ -86,7 +86,7 @@ static int trizeps_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 
 error:
 	for (; i >= 0; i--) {
-		gpio_free(IRQ_TO_GPIO(irqs[i].irq));
+		gpio_free(irq_to_gpio(irqs[i].irq));
 	}
 	return (ret);
 }
@@ -97,7 +97,7 @@ static void trizeps_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 	/* free allocated gpio's */
 	gpio_free(GPIO_PRDY);
 	for (i = 0; i < ARRAY_SIZE(irqs); i++)
-		gpio_free(IRQ_TO_GPIO(irqs[i].irq));
+		gpio_free(irq_to_gpio(irqs[i].irq));
 }
 
 static unsigned long trizeps_pcmcia_status[2];
-- 
1.7.1
