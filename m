From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 06 Sep 2010 11:12:23 +0200
Subject: [PATCH 2/6] ARM: S5PC110: add support for gpio interrupts
In-Reply-To: <1283764347-460-1-git-send-email-m.szyprowski@samsung.com>
References: <1283764347-460-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1283764347-460-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S5PV210/S5PC110 series can use common s5p gpio interrupt code. This
patch adds required defines and code to make use of it.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/gpiolib.c           |    6 +++++-
 arch/arm/mach-s5pv210/include/mach/irqs.h |    6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s5pv210/gpiolib.c b/arch/arm/mach-s5pv210/gpiolib.c
index 0d45911..29dfb89 100644
--- a/arch/arm/mach-s5pv210/gpiolib.c
+++ b/arch/arm/mach-s5pv210/gpiolib.c
@@ -150,6 +150,7 @@ static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
 			.label	= "GPG3",
 		},
 	}, {
+		.config	= &gpio_cfg_noint,
 		.chip	= {
 			.base	= S5PV210_GPI(0),
 			.ngpio	= S5PV210_GPIO_I_NR,
@@ -259,11 +260,14 @@ static __init int s5pv210_gpiolib_init(void)
 {
 	struct s3c_gpio_chip *chip = s5pv210_gpio_4bit;
 	int nr_chips = ARRAY_SIZE(s5pv210_gpio_4bit);
+	int gpioint_group = 0;
 	int i = 0;
 
 	for (i = 0; i < nr_chips; i++, chip++) {
-		if (chip->config == NULL)
+		if (chip->config == NULL) {
 			chip->config = &gpio_cfg;
+			chip->group = gpioint_group++;
+		}
 		if (chip->base == NULL)
 			chip->base = S5PV210_BANK_BASE(i);
 	}
diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
index cdb8ae4..bb7f277 100644
--- a/arch/arm/mach-s5pv210/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
@@ -121,8 +121,12 @@
 #define S5P_EINT_BASE1		(S5P_IRQ_VIC0(0))
 #define S5P_EINT_BASE2		(IRQ_VIC_END + 1)
 
+/* GPIO interrupt */
+#define S5P_GPIOINT_BASE	(IRQ_EINT(31) + 1)
+#define S5P_GPIOINT_GROUP_MAXNR	22
+
 /* Set the default NR_IRQS */
-#define NR_IRQS			(IRQ_EINT(31) + 1)
+#define NR_IRQS			(IRQ_EINT(31) + S5P_GPIOINT_COUNT + 1)
 
 /* Compatibility */
 #define IRQ_LCD_FIFO		IRQ_LCD0
-- 
1.7.2.2
