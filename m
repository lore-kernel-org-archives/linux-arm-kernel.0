From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 15 Dec 2010 03:03:48 +0100
Subject: [PATCH 12/16] ARM: pxa: Provide gpiolib ->to_irq() implementation.
In-Reply-To: <cover.1292377339.git.buytenh@wantstofly.org>
References: <cover.1292377339.git.buytenh@wantstofly.org>
Message-ID: <20101215020348.GE15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-mmp/mmp2.c              |    3 ++-
 arch/arm/mach-mmp/pxa168.c            |    3 ++-
 arch/arm/mach-mmp/pxa910.c            |    3 ++-
 arch/arm/mach-pxa/pxa25x.c            |    6 ++++--
 arch/arm/mach-pxa/pxa27x.c            |    3 ++-
 arch/arm/mach-pxa/pxa3xx.c            |    3 ++-
 arch/arm/plat-pxa/gpio.c              |   19 ++++++++++++++++++-
 arch/arm/plat-pxa/include/plat/gpio.h |    5 ++++-
 8 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index daf3993..8fcfad3 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -106,7 +106,8 @@ static void __init mmp2_init_gpio(void)
 	for (i = 0; i < 6; i++)
 		__raw_writel(0xffffffff, APMASK(i));
 
-	pxa_init_gpio(IRQ_MMP2_GPIO, 0, 167, NULL);
+	pxa_init_gpio(IRQ_MMP2_GPIO, IRQ_GPIO_START, IRQ_GPIO_START,
+		      0, 167, NULL);
 }
 
 void __init mmp2_init_irq(void)
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 72b4e76..a4bf158 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -54,7 +54,8 @@ static void __init pxa168_init_gpio(void)
 	for (i = 0; i < 4; i++)
 		__raw_writel(0xffffffff, APMASK(i));
 
-	pxa_init_gpio(IRQ_PXA168_GPIOX, 0, 127, NULL);
+	pxa_init_gpio(IRQ_PXA168_GPIOX, IRQ_GPIO_START, IRQ_GPIO_START,
+		      0, 127, NULL);
 }
 
 void __init pxa168_init_irq(void)
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 46f2d69..c0c25d0 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -91,7 +91,8 @@ static void __init pxa910_init_gpio(void)
 	for (i = 0; i < 4; i++)
 		__raw_writel(0xffffffff, APMASK(i));
 
-	pxa_init_gpio(IRQ_PXA910_AP_GPIO, 0, 127, NULL);
+	pxa_init_gpio(IRQ_PXA910_AP_GPIO, IRQ_GPIO_START, IRQ_GPIO_START,
+		      0, 127, NULL);
 }
 
 void __init pxa910_init_irq(void)
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index de53f2e..9b943f1 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -309,14 +309,16 @@ set_pwer:
 void __init pxa25x_init_irq(void)
 {
 	pxa_init_irq(32, pxa25x_set_wake);
-	pxa_init_gpio(IRQ_GPIO_2_x, 2, 84, pxa25x_set_wake);
+	pxa_init_gpio(IRQ_GPIO_2_x, IRQ_GPIO0, PXA_GPIO_IRQ_BASE,
+		      2, 84, pxa25x_set_wake);
 }
 
 #ifdef CONFIG_CPU_PXA26x
 void __init pxa26x_init_irq(void)
 {
 	pxa_init_irq(32, pxa25x_set_wake);
-	pxa_init_gpio(IRQ_GPIO_2_x, 2, 89, pxa25x_set_wake);
+	pxa_init_gpio(IRQ_GPIO_2_x, IRQ_GPIO0, PXA_GPIO_IRQ_BASE,
+		      2, 89, pxa25x_set_wake);
 }
 #endif
 
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index d1fbf29..bf0d7e9 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -367,7 +367,8 @@ static int pxa27x_set_wake(unsigned int irq, unsigned int on)
 void __init pxa27x_init_irq(void)
 {
 	pxa_init_irq(34, pxa27x_set_wake);
-	pxa_init_gpio(IRQ_GPIO_2_x, 2, 120, pxa27x_set_wake);
+	pxa_init_gpio(IRQ_GPIO_2_x, IRQ_GPIO0, PXA_GPIO_IRQ_BASE,
+		      2, 120, pxa27x_set_wake);
 }
 
 /*
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index d1c747c..41c7fc3 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -577,7 +577,8 @@ void __init pxa3xx_init_irq(void)
 
 	pxa_init_irq(56, pxa3xx_set_wake);
 	pxa_init_ext_wakeup_irq(pxa3xx_set_wake);
-	pxa_init_gpio(IRQ_GPIO_2_x, 2, 127, NULL);
+	pxa_init_gpio(IRQ_GPIO_2_x, IRQ_GPIO0, PXA_GPIO_IRQ_BASE,
+		      2, 127, NULL);
 }
 
 /*
diff --git a/arch/arm/plat-pxa/gpio.c b/arch/arm/plat-pxa/gpio.c
index 98548c6..1df5f13 100644
--- a/arch/arm/plat-pxa/gpio.c
+++ b/arch/arm/plat-pxa/gpio.c
@@ -20,6 +20,8 @@
 
 #include <mach/gpio.h>
 
+int pxa_secondary_irq_0_base;
+int pxa_secondary_irq_2_base;
 int pxa_last_gpio;
 
 struct pxa_gpio_chip {
@@ -107,6 +109,16 @@ static void pxa_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 				(value ? GPSR_OFFSET : GPCR_OFFSET));
 }
 
+static int pxa_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	int gpio = chip->base + offset;
+
+	if (gpio < 2)
+		return pxa_secondary_irq_0_base + gpio;
+	else
+		return pxa_secondary_irq_2_base + gpio;
+}
+
 static int __init pxa_init_gpio_chip(int gpio_end)
 {
 	int i, gpio, nbanks = gpio_to_bank(gpio_end) + 1;
@@ -131,6 +143,7 @@ static int __init pxa_init_gpio_chip(int gpio_end)
 		c->direction_output = pxa_gpio_direction_output;
 		c->get = pxa_gpio_get;
 		c->set = pxa_gpio_set;
+		c->to_irq = pxa_gpio_to_irq;
 
 		/* number of GPIOs on last bank may be less than 32 */
 		c->ngpio = (gpio + 31 > gpio_end) ? (gpio_end - gpio + 1) : 32;
@@ -266,11 +279,15 @@ static struct irq_chip pxa_muxed_gpio_chip = {
 	.set_type	= pxa_gpio_irq_type,
 };
 
-void __init pxa_init_gpio(int mux_irq, int start, int end, set_wake_t fn)
+void __init pxa_init_gpio(int mux_irq, int secondary_irq_0_base,
+			  int secondary_irq_2_base,
+			  int start, int end, set_wake_t fn)
 {
 	struct pxa_gpio_chip *c;
 	int gpio, irq;
 
+	pxa_secondary_irq_0_base = secondary_irq_0_base;
+	pxa_secondary_irq_2_base = secondary_irq_2_base;
 	pxa_last_gpio = end;
 
 	/* Initialize GPIO chips */
diff --git a/arch/arm/plat-pxa/include/plat/gpio.h b/arch/arm/plat-pxa/include/plat/gpio.h
index 44248cb..60c0f83 100644
--- a/arch/arm/plat-pxa/include/plat/gpio.h
+++ b/arch/arm/plat-pxa/include/plat/gpio.h
@@ -58,5 +58,8 @@ extern int pxa_last_gpio;
 
 typedef int (*set_wake_t)(unsigned int irq, unsigned int on);
 
-extern void pxa_init_gpio(int mux_irq, int start, int end, set_wake_t fn);
+extern void pxa_init_gpio(int mux_irq, int secondary_irq_0_base,
+			  int secondary_irq_2_base,
+			  int start, int end, set_wake_t fn);
+
 #endif /* __PLAT_GPIO_H */
-- 
1.7.1
