From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 11 Dec 2017 18:56:35 +0000
Subject: [PATCH] ARM: pxa/lubbock: add GPIO driver for LUB_MISC_WR register
Message-ID: <E1eOTFj-0008MB-Fj@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a gpio driver for the lubbock miscellaneous write IO register so we
can take advantage of subsystems modelled around gpiolib, rather than
having to provide platform specific callbacks.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-pxa/Kconfig   |  1 +
 arch/arm/mach-pxa/lubbock.c | 24 ++++++++++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index ce7d97babb0f..a68b34183107 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -40,6 +40,7 @@ config MACH_PXA3XX_DT
 
 config ARCH_LUBBOCK
 	bool "Intel DBPXA250 Development Platform (aka Lubbock)"
+	select GPIO_REG
 	select PXA25x
 	select SA1111
 
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index df45682e99a5..fe2ef9b78602 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -13,6 +13,7 @@
  */
 #include <linux/clkdev.h>
 #include <linux/gpio.h>
+#include <linux/gpio/gpio-reg.h>
 #include <linux/gpio/machine.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -110,20 +111,18 @@ static unsigned long lubbock_pin_config[] __initdata = {
 };
 
 #define LUB_HEXLED		__LUB_REG(LUBBOCK_FPGA_PHYS + 0x010)
-#define LUB_MISC_WR		__LUB_REG(LUBBOCK_FPGA_PHYS + 0x080)
 
 void lubbock_set_hexled(uint32_t value)
 {
 	LUB_HEXLED = value;
 }
 
+static struct gpio_chip *lubbock_misc_wr_gc;
+
 void lubbock_set_misc_wr(unsigned int mask, unsigned int set)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
-	LUB_MISC_WR = (LUB_MISC_WR & ~mask) | (set & mask);
-	local_irq_restore(flags);
+	unsigned long m = mask, v = set;
+	lubbock_misc_wr_gc->set_multiple(lubbock_misc_wr_gc, &m, &v);
 }
 EXPORT_SYMBOL(lubbock_set_misc_wr);
 
@@ -452,9 +451,9 @@ static void lubbock_irda_transceiver_mode(struct device *dev, int mode)
 
 	local_irq_save(flags);
 	if (mode & IR_SIRMODE) {
-		LUB_MISC_WR &= ~(1 << 4);
+		lubbock_set_misc_wr(BIT(4), 0);
 	} else if (mode & IR_FIRMODE) {
-		LUB_MISC_WR |= 1 << 4;
+		lubbock_set_misc_wr(BIT(4), BIT(4));
 	}
 	pxa2xx_transceiver_mode(dev, mode);
 	local_irq_restore(flags);
@@ -472,6 +471,15 @@ static void __init lubbock_init(void)
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(lubbock_pin_config));
 
+	lubbock_misc_wr_gc = gpio_reg_init(NULL, (void *)&LUB_MISC_WR,
+					   -1, 16, "lubbock", 0, LUB_MISC_WR,
+					   NULL, NULL, NULL);
+	if (IS_ERR(lubbock_misc_wr_gc)) {
+		pr_err("Lubbock: unable to register lubbock GPIOs: %ld\n",
+		       PTR_ERR(lubbock_misc_wr_gc));
+		lubbock_misc_wr_gc = NULL;
+	}
+
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
-- 
2.7.4
