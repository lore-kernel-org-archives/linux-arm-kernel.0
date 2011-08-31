From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Wed, 31 Aug 2011 19:12:29 +0530
Subject: [PATCH v6 13/25] gpio/omap: use pinctrl offset instead of macro
In-Reply-To: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1314798161-19523-14-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Charulatha V <charu@ti.com>

Use regs->pinctrl field instead of using the macro OMAP1510_GPIO_PIN_CONTROL

Signed-off-by: Charulatha V <charu@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |    1 +
 arch/arm/plat-omap/include/plat/gpio.h |    1 +
 drivers/gpio/gpio-omap.c               |    8 +++-----
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 2adfece..950e467 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -85,6 +85,7 @@ static struct omap_gpio_reg_offs omap15xx_gpio_regs = {
 	.irqenable	= OMAP1510_GPIO_INT_MASK,
 	.irqenable_inv	= true,
 	.irqctrl	= OMAP1510_GPIO_INT_CONTROL,
+	.pinctrl	= OMAP1510_GPIO_PIN_CONTROL,
 };
 
 static struct __initdata omap_gpio_platform_data omap15xx_gpio_config = {
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 92a6262..a4e5ef3 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -198,6 +198,7 @@ struct omap_gpio_reg_offs {
 	u16 irqctrl;
 	u16 edgectrl1;
 	u16 edgectrl2;
+	u16 pinctrl;
 
 	bool irqenable_inv;
 };
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index fa2fb4f..e2a8b09 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -481,15 +481,13 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	 */
 	_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
 
-#ifdef CONFIG_ARCH_OMAP15XX
-	if (bank->method == METHOD_GPIO_1510) {
-		void __iomem *reg;
+	if (bank->regs->pinctrl) {
+		void __iomem *reg = bank->base + bank->regs->pinctrl;
 
 		/* Claim the pin for MPU */
-		reg = bank->base + OMAP1510_GPIO_PIN_CONTROL;
 		__raw_writel(__raw_readl(reg) | (1 << offset), reg);
 	}
-#endif
+
 	if (bank->regs->ctrl && !bank->mod_usage) {
 		void __iomem *reg = bank->base + bank->regs->ctrl;
 		u32 ctrl;
-- 
1.7.0.4
