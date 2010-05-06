From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:16 -0700
Subject: [PATCH 25/34] Davinci: gpio - register layout invariant inlines
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-26-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

This patch renders the inlined gpio accessors in gpio.h independent of the
underlying controller's register layout.  This is done by including three new
fields in davinci_gpio_controller to hold the addresses of the set, clear, and
in data registers.

Other changes:

1. davinci_gpio_regs structure definition moved to gpio.c.  This structure is
no longer common across all davinci socs (davinci_gpio_controller is).

2. controller base address calculation code (gpio2controller()) moved to
gpio.c as this was no longer necessary for the inline implementation.

3. modified inline range checks to use davinci_soc_info.gpio_num instead of
DAVINCI_N_GPIO.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Tested-by: Sandeep Paulraj <s-paulraj@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/gpio.c                |   41 ++++++++++++++++-
 arch/arm/mach-davinci/include/mach/common.h |    4 ++
 arch/arm/mach-davinci/include/mach/gpio.h   |   65 +++++++++-----------------
 3 files changed, 65 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-davinci/gpio.c b/arch/arm/mach-davinci/gpio.c
index c77683c..d241b4f 100644
--- a/arch/arm/mach-davinci/gpio.c
+++ b/arch/arm/mach-davinci/gpio.c
@@ -20,6 +20,19 @@
 
 #include <asm/mach/irq.h>
 
+struct davinci_gpio_regs {
+	u32	dir;
+	u32	out_data;
+	u32	set_data;
+	u32	clr_data;
+	u32	in_data;
+	u32	set_rising;
+	u32	clr_rising;
+	u32	set_falling;
+	u32	clr_falling;
+	u32	intstat;
+};
+
 static DEFINE_SPINLOCK(gpio_lock);
 
 #define chip2controller(chip)	\
@@ -27,10 +40,24 @@ static DEFINE_SPINLOCK(gpio_lock);
 
 static struct davinci_gpio_controller chips[DIV_ROUND_UP(DAVINCI_N_GPIO, 32)];
 
-/* create a non-inlined version */
 static struct davinci_gpio_regs __iomem __init *gpio2regs(unsigned gpio)
 {
-	return __gpio_to_controller(gpio);
+	void __iomem *ptr;
+	void __iomem *base = davinci_soc_info.gpio_base;
+
+	if (gpio < 32 * 1)
+		ptr = base + 0x10;
+	else if (gpio < 32 * 2)
+		ptr = base + 0x38;
+	else if (gpio < 32 * 3)
+		ptr = base + 0x60;
+	else if (gpio < 32 * 4)
+		ptr = base + 0x88;
+	else if (gpio < 32 * 5)
+		ptr = base + 0xb0;
+	else
+		ptr = NULL;
+	return ptr;
 }
 
 static inline struct davinci_gpio_regs __iomem *irq2regs(int irq)
@@ -116,6 +143,7 @@ static int __init davinci_gpio_setup(void)
 	int i, base;
 	unsigned ngpio;
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
+	struct davinci_gpio_regs *regs;
 
 	/*
 	 * The gpio banks conceptually expose a segmented bitmap,
@@ -144,11 +172,18 @@ static int __init davinci_gpio_setup(void)
 		if (chips[i].chip.ngpio > 32)
 			chips[i].chip.ngpio = 32;
 
-		chips[i].regs = gpio2regs(base);
+		regs = gpio2regs(base);
+		chips[i].regs = regs;
+		chips[i].set_data = &regs->set_data;
+		chips[i].clr_data = &regs->clr_data;
+		chips[i].in_data = &regs->in_data;
 
 		gpiochip_add(&chips[i].chip);
 	}
 
+	soc_info->gpio_ctlrs = chips;
+	soc_info->gpio_ctlrs_num = DIV_ROUND_UP(ngpio, 32);
+
 	davinci_gpio_irq_setup();
 	return 0;
 }
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 884dc72..1d72883 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -37,6 +37,8 @@ struct davinci_timer_info {
 	unsigned int			clocksource_id;
 };
 
+struct davinci_gpio_controller;
+
 /* SoC specific init support */
 struct davinci_soc_info {
 	struct map_desc			*io_desc;
@@ -61,6 +63,8 @@ struct davinci_soc_info {
 	unsigned			gpio_num;
 	unsigned			gpio_irq;
 	unsigned			gpio_unbanked;
+	struct davinci_gpio_controller	*gpio_ctlrs;
+	int				gpio_ctlrs_num;
 	struct platform_device		*serial_dev;
 	struct emac_platform_data	*emac_pdata;
 	dma_addr_t			sram_dma;
diff --git a/arch/arm/mach-davinci/include/mach/gpio.h b/arch/arm/mach-davinci/include/mach/gpio.h
index bdab001..82591d0 100644
--- a/arch/arm/mach-davinci/include/mach/gpio.h
+++ b/arch/arm/mach-davinci/include/mach/gpio.h
@@ -45,23 +45,13 @@
 /* Convert GPIO signal to GPIO pin number */
 #define GPIO_TO_PIN(bank, gpio)	(16 * (bank) + (gpio))
 
-struct davinci_gpio_regs {
-	u32	dir;
-	u32	out_data;
-	u32	set_data;
-	u32	clr_data;
-	u32	in_data;
-	u32	set_rising;
-	u32	clr_rising;
-	u32	set_falling;
-	u32	clr_falling;
-	u32	intstat;
-};
-
 struct davinci_gpio_controller {
-	struct davinci_gpio_regs __iomem *regs;
 	struct gpio_chip	chip;
 	int			irq_base;
+	void __iomem		*regs;
+	void __iomem		*set_data;
+	void __iomem		*clr_data;
+	void __iomem		*in_data;
 };
 
 /* The __gpio_to_controller() and __gpio_mask() functions inline to constants
@@ -73,25 +63,16 @@ struct davinci_gpio_controller {
  *
  * These are NOT part of the cross-platform GPIO interface
  */
-static inline struct davinci_gpio_regs __iomem *
+static inline struct davinci_gpio_controller *
 __gpio_to_controller(unsigned gpio)
 {
-	void __iomem *ptr;
-	void __iomem *base = davinci_soc_info.gpio_base;
-
-	if (gpio < 32 * 1)
-		ptr = base + 0x10;
-	else if (gpio < 32 * 2)
-		ptr = base + 0x38;
-	else if (gpio < 32 * 3)
-		ptr = base + 0x60;
-	else if (gpio < 32 * 4)
-		ptr = base + 0x88;
-	else if (gpio < 32 * 5)
-		ptr = base + 0xb0;
-	else
-		ptr = NULL;
-	return ptr;
+	struct davinci_gpio_controller *ctlrs = davinci_soc_info.gpio_ctlrs;
+	int index = gpio / 32;
+
+	if (!ctlrs || index >= davinci_soc_info.gpio_ctlrs_num)
+		return NULL;
+
+	return ctlrs + index;
 }
 
 static inline u32 __gpio_mask(unsigned gpio)
@@ -107,16 +88,16 @@ static inline u32 __gpio_mask(unsigned gpio)
  */
 static inline void gpio_set_value(unsigned gpio, int value)
 {
-	if (__builtin_constant_p(value) && gpio < DAVINCI_N_GPIO) {
-		struct davinci_gpio_regs	__iomem *g;
-		u32			mask;
+	if (__builtin_constant_p(value) && gpio < davinci_soc_info.gpio_num) {
+		struct davinci_gpio_controller *ctlr;
+		u32				mask;
 
-		g = __gpio_to_controller(gpio);
+		ctlr = __gpio_to_controller(gpio);
 		mask = __gpio_mask(gpio);
 		if (value)
-			__raw_writel(mask, &g->set_data);
+			__raw_writel(mask, ctlr->set_data);
 		else
-			__raw_writel(mask, &g->clr_data);
+			__raw_writel(mask, ctlr->clr_data);
 		return;
 	}
 
@@ -134,18 +115,18 @@ static inline void gpio_set_value(unsigned gpio, int value)
  */
 static inline int gpio_get_value(unsigned gpio)
 {
-	struct davinci_gpio_regs	__iomem *g;
+	struct davinci_gpio_controller *ctlr;
 
-	if (!__builtin_constant_p(gpio) || gpio >= DAVINCI_N_GPIO)
+	if (!__builtin_constant_p(gpio) || gpio >= davinci_soc_info.gpio_num)
 		return __gpio_get_value(gpio);
 
-	g = __gpio_to_controller(gpio);
-	return __gpio_mask(gpio) & __raw_readl(&g->in_data);
+	ctlr = __gpio_to_controller(gpio);
+	return __gpio_mask(gpio) & __raw_readl(ctlr->in_data);
 }
 
 static inline int gpio_cansleep(unsigned gpio)
 {
-	if (__builtin_constant_p(gpio) && gpio < DAVINCI_N_GPIO)
+	if (__builtin_constant_p(gpio) && gpio < davinci_soc_info.gpio_num)
 		return 0;
 	else
 		return __gpio_cansleep(gpio);
-- 
1.7.0.2
