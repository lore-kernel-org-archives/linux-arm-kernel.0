From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri,  8 Jul 2011 18:20:18 +0800
Subject: [PATCH] ARM: mmp: remove builtin gpio driver support
In-Reply-To: <1310120428-22700-1-git-send-email-haojian.zhuang@marvell.com>
References: <1310120428-22700-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1310120428-22700-2-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove builtin gpio driver support form mmp.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/include/mach/gpio.h |   27 +++------------------------
 arch/arm/mach-mmp/mmp2.c              |   17 -----------------
 arch/arm/mach-mmp/pxa168.c            |   17 -----------------
 arch/arm/mach-mmp/pxa910.c            |   17 -----------------
 arch/arm/plat-pxa/Makefile            |    2 ++
 5 files changed, 5 insertions(+), 75 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/gpio.h b/arch/arm/mach-mmp/include/mach/gpio.h
index 7bfb827..829f165 100644
--- a/arch/arm/mach-mmp/include/mach/gpio.h
+++ b/arch/arm/mach-mmp/include/mach/gpio.h
@@ -1,36 +1,15 @@
 #ifndef __ASM_MACH_GPIO_H
 #define __ASM_MACH_GPIO_H
 
-#include <mach/addr-map.h>
-#include <mach/irqs.h>
 #include <asm-generic/gpio.h>
 
-#define GPIO_REGS_VIRT	(APB_VIRT_BASE + 0x19000)
-
-#define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
-#define GPIO_REG(x)	(*((volatile u32 *)(GPIO_REGS_VIRT + (x))))
-
-#define NR_BUILTIN_GPIO		IRQ_GPIO_NUM
-
 #define gpio_to_bank(gpio)	((gpio) >> 5)
-#define gpio_to_irq(gpio)	(IRQ_GPIO_START + (gpio))
-#define irq_to_gpio(irq)	((irq) - IRQ_GPIO_START)
+#define bank_to_gpio(nr)	(nr << 5)
+#define GPIO_bit(gpio)		(1 << ((gpio) & 0x1f))
 
+#define gpio_to_irq(nr)		__gpio_to_irq(nr)
 
 #define __gpio_is_inverted(gpio)	(0)
 #define __gpio_is_occupied(gpio)	(0)
 
-/* NOTE: these macros are defined here to make optimization of
- * gpio_{get,set}_value() to work when 'gpio' is a constant.
- * Usage of these macros otherwise is no longer recommended,
- * use generic GPIO API whenever possible.
- */
-#define GPIO_bit(gpio)	(1 << ((gpio) & 0x1f))
-
-#define GPLR(x)		GPIO_REG(BANK_OFF(gpio_to_bank(x)) + 0x00)
-#define GPDR(x)		GPIO_REG(BANK_OFF(gpio_to_bank(x)) + 0x0c)
-#define GPSR(x)		GPIO_REG(BANK_OFF(gpio_to_bank(x)) + 0x18)
-#define GPCR(x)		GPIO_REG(BANK_OFF(gpio_to_bank(x)) + 0x24)
-
-#include <plat/gpio.h>
 #endif /* __ASM_MACH_GPIO_H */
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 8e6c3ac..d3f9b3b 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -34,8 +34,6 @@
 
 #define MFPR_VIRT_BASE	(APB_VIRT_BASE + 0x1e000)
 
-#define APMASK(i)	(GPIO_REGS_VIRT + BANK_OFF(i) + 0x9c)
-
 static struct mfp_addr_map mmp2_addr_map[] __initdata = {
 
 	MFP_ADDR_X(GPIO0, GPIO58, 0x54),
@@ -95,24 +93,9 @@ void mmp2_clear_pmic_int(void)
 	__raw_writel(data, mfpr_pmic);
 }
 
-static void __init mmp2_init_gpio(void)
-{
-	int i;
-
-	/* enable GPIO clock */
-	__raw_writel(APBC_APBCLK | APBC_FNCLK, APBC_MMP2_GPIO);
-
-	/* unmask GPIO edge detection for all 6 banks -- APMASKx */
-	for (i = 0; i < 6; i++)
-		__raw_writel(0xffffffff, APMASK(i));
-
-	pxa_init_gpio(IRQ_MMP2_GPIO, 0, 167, NULL);
-}
-
 void __init mmp2_init_irq(void)
 {
 	mmp2_init_icu();
-	mmp2_init_gpio();
 }
 
 static void sdhc_clk_enable(struct clk *clk)
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 72b4e76..4f41ea2 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -41,26 +41,9 @@ static struct mfp_addr_map pxa168_mfp_addr_map[] __initdata =
 	MFP_ADDR_END,
 };
 
-#define APMASK(i)	(GPIO_REGS_VIRT + BANK_OFF(i) + 0x09c)
-
-static void __init pxa168_init_gpio(void)
-{
-	int i;
-
-	/* enable GPIO clock */
-	__raw_writel(APBC_APBCLK | APBC_FNCLK, APBC_PXA168_GPIO);
-
-	/* unmask GPIO edge detection for all 4 banks - APMASKx */
-	for (i = 0; i < 4; i++)
-		__raw_writel(0xffffffff, APMASK(i));
-
-	pxa_init_gpio(IRQ_PXA168_GPIOX, 0, 127, NULL);
-}
-
 void __init pxa168_init_irq(void)
 {
 	icu_init_irq();
-	pxa168_init_gpio();
 }
 
 /* APB peripheral clocks */
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 8f92ccd..e71a45a 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -78,26 +78,9 @@ static struct mfp_addr_map pxa910_mfp_addr_map[] __initdata =
 	MFP_ADDR_END,
 };
 
-#define APMASK(i)	(GPIO_REGS_VIRT + BANK_OFF(i) + 0x09c)
-
-static void __init pxa910_init_gpio(void)
-{
-	int i;
-
-	/* enable GPIO clock */
-	__raw_writel(APBC_APBCLK | APBC_FNCLK, APBC_PXA910_GPIO);
-
-	/* unmask GPIO edge detection for all 4 banks - APMASKx */
-	for (i = 0; i < 4; i++)
-		__raw_writel(0xffffffff, APMASK(i));
-
-	pxa_init_gpio(IRQ_PXA910_AP_GPIO, 0, 127, NULL);
-}
-
 void __init pxa910_init_irq(void)
 {
 	icu_init_irq();
-	pxa910_init_gpio();
 }
 
 /* APB peripheral clocks */
diff --git a/arch/arm/plat-pxa/Makefile b/arch/arm/plat-pxa/Makefile
index 3aca5ba..8e432b1 100644
--- a/arch/arm/plat-pxa/Makefile
+++ b/arch/arm/plat-pxa/Makefile
@@ -4,7 +4,9 @@
 
 obj-y	:= dma.o
 
+ifeq ($(CONFIG_OF),)
 obj-$(CONFIG_GENERIC_GPIO)	+= gpio.o
+endif
 obj-$(CONFIG_PXA3xx)		+= mfp.o
 obj-$(CONFIG_PXA95x)		+= mfp.o
 obj-$(CONFIG_ARCH_MMP)		+= mfp.o
-- 
1.5.6.5
