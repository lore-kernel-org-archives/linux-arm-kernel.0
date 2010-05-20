From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 20 May 2010 07:51:10 +0200
Subject: [PATCH 3/4] ARM: S5PC100: use common plat-s5p external interrupt code
In-Reply-To: <1274334671-21838-1-git-send-email-m.szyprowski@samsung.com>
References: <1274334671-21838-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1274334671-21838-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pc100/Kconfig                  |    1 +
 arch/arm/mach-s5pc100/gpiolib.c                |    3 +-
 arch/arm/mach-s5pc100/include/mach/gpio.h      |    7 +++++
 arch/arm/mach-s5pc100/include/mach/irqs.h      |    6 +---
 arch/arm/mach-s5pc100/include/mach/regs-gpio.h |   33 +++++++++++++----------
 5 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index fe1216b..2eb9497 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -10,6 +10,7 @@ if ARCH_S5PC100
 config CPU_S5PC100
 	bool
 	select PLAT_S5P
+	select S5P_EXT_INT
 	help
 	  Enable S5PC100 CPU support
 
diff --git a/arch/arm/mach-s5pc100/gpiolib.c b/arch/arm/mach-s5pc100/gpiolib.c
index 88dd913..0fab7f2 100644
--- a/arch/arm/mach-s5pc100/gpiolib.c
+++ b/arch/arm/mach-s5pc100/gpiolib.c
@@ -61,7 +61,6 @@
  * L3	8	4Bit	None
  */
 
-#if 0
 static int s5pc100_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset)
 {
 	return S3C_IRQ_GPIO(chip->base + offset);
@@ -85,7 +84,7 @@ static int s5pc100_gpiolib_to_eint(struct gpio_chip *chip, unsigned int offset)
 		return IRQ_EINT(24 + offset);
 	return -EINVAL;
 }
-#endif
+
 static struct s3c_gpio_cfg gpio_cfg = {
 	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
 	.set_pull	= s3c_gpio_setpull_updown,
diff --git a/arch/arm/mach-s5pc100/include/mach/gpio.h b/arch/arm/mach-s5pc100/include/mach/gpio.h
index 29a8a12..71ae1f5 100644
--- a/arch/arm/mach-s5pc100/include/mach/gpio.h
+++ b/arch/arm/mach-s5pc100/include/mach/gpio.h
@@ -146,6 +146,13 @@ enum s5p_gpio_number {
 /* define the number of gpios we need to the one after the MP04() range */
 #define ARCH_NR_GPIOS		(S5PC100_GPIO_END + 1)
 
+#define EINT_MODE		S3C_GPIO_SFN(0x2)
+
+#define EINT_GPIO_0(x)		S5PC100_GPH0(x)
+#define EINT_GPIO_1(x)		S5PC100_GPH1(x)
+#define EINT_GPIO_2(x)		S5PC100_GPH2(x)
+#define EINT_GPIO_3(x)		S5PC100_GPH3(x)
+
 #include <asm-generic/gpio.h>
 
 #endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/irqs.h b/arch/arm/mach-s5pc100/include/mach/irqs.h
index 84c74ac..28aa551 100644
--- a/arch/arm/mach-s5pc100/include/mach/irqs.h
+++ b/arch/arm/mach-s5pc100/include/mach/irqs.h
@@ -97,10 +97,8 @@
 #define IRQ_SDMFIQ		S5P_IRQ_VIC2(31)
 #define IRQ_VIC_END		S5P_IRQ_VIC2(31)
 
-#define S5P_IRQ_EINT_BASE	(IRQ_VIC_END + 1)
-
-#define IRQ_EINT(x)             ((x) < 16 ? S5P_IRQ_VIC0(x) : \
-					(S5P_IRQ_EINT_BASE + (x)-16))
+#define S5P_EINT_BASE1		(S5P_IRQ_VIC0(0))
+#define S5P_EINT_BASE2		(IRQ_VIC_END + 1)
 
 #define S3C_IRQ_GPIO_BASE	(IRQ_EINT(31) + 1)
 #define S3C_IRQ_GPIO(x)		(S3C_IRQ_GPIO_BASE + (x))
diff --git a/arch/arm/mach-s5pc100/include/mach/regs-gpio.h b/arch/arm/mach-s5pc100/include/mach/regs-gpio.h
index cd6200a..dd6295e 100644
--- a/arch/arm/mach-s5pc100/include/mach/regs-gpio.h
+++ b/arch/arm/mach-s5pc100/include/mach/regs-gpio.h
@@ -47,24 +47,29 @@
 #define S5PC100_GPL2_BASE	(S5PC100_GPIO_BASE + 0x0360)
 #define S5PC100_GPL3_BASE	(S5PC100_GPIO_BASE + 0x0380)
 #define S5PC100_GPL4_BASE	(S5PC100_GPIO_BASE + 0x03A0)
-#define S5PC100_EINT_BASE	(S5PC100_GPIO_BASE + 0x0E00)
 
-#define S5PC100_UHOST		(S5PC100_GPIO_BASE + 0x0B68)
-#define S5PC100_PDNEN		(S5PC100_GPIO_BASE + 0x0F80)
+#define S5PC100EINT30CON		(S5P_VA_GPIO + 0xE00)
+#define S5P_EINT_CON(x)			(S5PC100EINT30CON + ((x) * 0x4))
 
-/* PDNEN */
-#define S5PC100_PDNEN_CFG_PDNEN	(1 << 1)
-#define S5PC100_PDNEN_CFG_AUTO	(0 << 1)
-#define S5PC100_PDNEN_POWERDOWN	(1 << 0)
-#define S5PC100_PDNEN_NORMAL	(0 << 0)
+#define S5PC100EINT30FLTCON0		(S5P_VA_GPIO + 0xE80)
+#define S5P_EINT_FLTCON(x)		(S5PC100EINT30FLTCON0 + ((x) * 0x4))
 
-/* Common part */
-/* External interrupt base is same@both s5pc100 and s5pc110 */
-#define S5P_EINT_BASE			(S5PC100_EINT_BASE)
+#define S5PC100EINT30MASK		(S5P_VA_GPIO + 0xF00)
+#define S5P_EINT_MASK(x)		(S5PC100EINT30MASK + ((x) * 0x4))
 
-#define S5PC100_GPx_INPUT(__gpio)	(0x0 << ((__gpio) * 4))
-#define S5PC100_GPx_OUTPUT(__gpio)	(0x1 << ((__gpio) * 4))
-#define S5PC100_GPx_CONMASK(__gpio)	(0xf << ((__gpio) * 4))
+#define S5PC100EINT30PEND		(S5P_VA_GPIO + 0xF40)
+#define S5P_EINT_PEND(x)		(S5PC100EINT30PEND + ((x) * 0x4))
+
+#define EINT_REG_NR(x)			(EINT_OFFSET(x) >> 3)
+
+#define eint_irq_to_bit(irq)		(1 << (EINT_OFFSET(irq) & 0x7))
+
+/* values for S5P_EXTINT0 */
+#define S5P_EXTINT_LOWLEV		(0x00)
+#define S5P_EXTINT_HILEV		(0x01)
+#define S5P_EXTINT_FALLEDGE		(0x02)
+#define S5P_EXTINT_RISEEDGE		(0x03)
+#define S5P_EXTINT_BOTHEDGE		(0x04)
 
 #endif /* __ASM_MACH_S5PC100_REGS_GPIO_H */
 
-- 
1.6.4
