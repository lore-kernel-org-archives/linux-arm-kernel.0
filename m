From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  4 Mar 2015 20:33:08 +0100
Subject: [RFC PATCH 14/18] ARM: msm: pass gpio irq range as resource
In-Reply-To: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
Message-ID: <1425497592-1831064-15-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IRQ numbers that are used by the gpio driver are hardware
specific, and since this driver does not use irq domains, we
have to pass them as platform resources in order to perform
gpio configuration at runtime.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-msm/devices-msm7x00.c |  5 +++++
 arch/arm/mach-msm/devices-msm7x30.c |  5 +++++
 arch/arm/mach-msm/devices-qsd8x50.c |  5 +++++
 arch/arm/mach-msm/gpio-msm-v1.c     | 15 +++++++++------
 4 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-msm/devices-msm7x00.c b/arch/arm/mach-msm/devices-msm7x00.c
index b7308e7a301b..38c16313f433 100644
--- a/arch/arm/mach-msm/devices-msm7x00.c
+++ b/arch/arm/mach-msm/devices-msm7x00.c
@@ -99,6 +99,11 @@ static struct resource msm_gpio_resources[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
+		.start	= NR_MSM_IRQS,
+		.end	= NR_MSM_IRQS + NR_GPIO_IRQS - 1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
 		.start	= 0xa9200800,
 		.end	= 0xa9200800 + SZ_4K - 1,
 		.flags	= IORESOURCE_MEM,
diff --git a/arch/arm/mach-msm/devices-msm7x30.c b/arch/arm/mach-msm/devices-msm7x30.c
index 2d36c54b9523..197d2b8afa20 100644
--- a/arch/arm/mach-msm/devices-msm7x30.c
+++ b/arch/arm/mach-msm/devices-msm7x30.c
@@ -80,6 +80,11 @@ static struct resource msm_gpio_resources[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
+		.start	= NR_MSM_IRQS,
+		.end	= NR_MSM_IRQS + NR_GPIO_IRQS - 1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
 		.start	= 0xac001000,
 		.end	= 0xac001000 + SZ_4K - 1,
 		.flags	= IORESOURCE_MEM,
diff --git a/arch/arm/mach-msm/devices-qsd8x50.c b/arch/arm/mach-msm/devices-qsd8x50.c
index 5f280467f207..3fd28b702591 100644
--- a/arch/arm/mach-msm/devices-qsd8x50.c
+++ b/arch/arm/mach-msm/devices-qsd8x50.c
@@ -90,6 +90,11 @@ static struct resource msm_gpio_resources[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 	{
+		.start	= NR_MSM_IRQS,
+		.end	= NR_MSM_IRQS + NR_GPIO_IRQS - 1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
 		.start	= 0xa9000800,
 		.end	= 0xa9000800 + SZ_4K - 1,
 		.flags	= IORESOURCE_MEM,
diff --git a/arch/arm/mach-msm/gpio-msm-v1.c b/arch/arm/mach-msm/gpio-msm-v1.c
index 589115c1faa2..2700f9bda455 100644
--- a/arch/arm/mach-msm/gpio-msm-v1.c
+++ b/arch/arm/mach-msm/gpio-msm-v1.c
@@ -274,7 +274,7 @@
 #define MSM7X30_GPIO_INT_STATUS_6	MSM_GPIO1_REG(0xE0)
 #define MSM7X30_GPIO_INT_STATUS_7	MSM_GPIO1_REG(0x234)
 
-#define FIRST_GPIO_IRQ MSM_GPIO_TO_INT(0)
+static int msm_gpio_first_irq;
 
 #define MSM_GPIO_BANK(soc, bank, first, last)				\
 	{								\
@@ -446,7 +446,7 @@ static void msm_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 
 static int msm_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 {
-	return MSM_GPIO_TO_INT(chip->base + offset);
+	return chip->base + offset - msm_gpio_first_irq;
 }
 
 static int msm_gpio_request(struct gpio_chip *chip, unsigned offset)
@@ -618,9 +618,9 @@ static void msm_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			j = fls(mask) - 1;
 			/* printk("%s %08x %08x bit %d gpio %d irq %d\n",
 				__func__, v, m, j, msm_chip->chip.start + j,
-				FIRST_GPIO_IRQ + msm_chip->chip.start + j); */
+				msm_gpio_first_irq + msm_chip->chip.start + j); */
 			val &= ~mask;
-			generic_handle_irq(FIRST_GPIO_IRQ +
+			generic_handle_irq(msm_gpio_first_irq +
 					   msm_chip->chip.base + j);
 		}
 	}
@@ -668,8 +668,11 @@ static int gpio_msm_v1_probe(struct platform_device *pdev)
 	if (IS_ERR(base2))
 		return PTR_ERR(base2);
 
-	for (i = FIRST_GPIO_IRQ; i < FIRST_GPIO_IRQ + NR_GPIO_IRQS; i++) {
-		if (i - FIRST_GPIO_IRQ >=
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 2);
+	msm_gpio_first_irq = res->start;
+
+	for (i = msm_gpio_first_irq; i <= res->end; i++) {
+		if (i - msm_gpio_first_irq >=
 			msm_gpio_chips[j].chip.base +
 			msm_gpio_chips[j].chip.ngpio)
 			j++;
-- 
2.1.0.rc2
