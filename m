From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed,  8 Sep 2010 12:39:46 +0300
Subject: [PATCH v2 1/5] h1940: use gpiolib for latch access
In-Reply-To: <4C86C70E.7030009@fluff.org>
References: <4C86C70E.7030009@fluff.org>
Message-ID: <1283938786-15214-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds gpiolib support for h1940 latch.
With this patch it's possible to use leds-gpio and uda1380
drivers (they require gpiolib support for appropriate pins).
And now it's possible to drop leds-h1940 driver.

v2: removed unnecessary direction_input callback,
minor formatting cleanup

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c2410/h1940-bluetooth.c          |   13 ++++-
 arch/arm/mach-s3c2410/include/mach/h1940-latch.h |   57 ++++++-------------
 arch/arm/mach-s3c2410/mach-h1940.c               |   64 ++++++++++++++++++++--
 arch/arm/plat-s3c24xx/Kconfig                    |    1 +
 4 files changed, 87 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-s3c2410/h1940-bluetooth.c b/arch/arm/mach-s3c2410/h1940-bluetooth.c
index 8cdeb14..8aa2f19 100644
--- a/arch/arm/mach-s3c2410/h1940-bluetooth.c
+++ b/arch/arm/mach-s3c2410/h1940-bluetooth.c
@@ -30,7 +30,7 @@ static void h1940bt_enable(int on)
 {
 	if (on) {
 		/* Power on the chip */
-		h1940_latch_control(0, H1940_LATCH_BLUETOOTH_POWER);
+		gpio_set_value(H1940_LATCH_BLUETOOTH_POWER, 1);
 		/* Reset the chip */
 		mdelay(10);
 
@@ -43,7 +43,7 @@ static void h1940bt_enable(int on)
 		mdelay(10);
 		gpio_set_value(S3C2410_GPH(1), 0);
 		mdelay(10);
-		h1940_latch_control(H1940_LATCH_BLUETOOTH_POWER, 0);
+		gpio_set_value(H1940_LATCH_BLUETOOTH_POWER, 0);
 	}
 }
 
@@ -64,7 +64,14 @@ static int __devinit h1940bt_probe(struct platform_device *pdev)
 
 	ret = gpio_request(S3C2410_GPH(1), dev_name(&pdev->dev));
 	if (ret) {
-		dev_err(&pdev->dev, "could not get GPH1\n");\
+		dev_err(&pdev->dev, "could not get GPH1\n");
+		return ret;
+	}
+
+	ret = gpio_request(H1940_LATCH_BLUETOOTH_POWER, dev_name(&pdev->dev));
+	if (ret) {
+		gpio_free(S3C2410_GPH(1));
+		dev_err(&pdev->dev, "could not get BT_POWER\n");
 		return ret;
 	}
 
diff --git a/arch/arm/mach-s3c2410/include/mach/h1940-latch.h b/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
index d8a8327..73586f2 100644
--- a/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
+++ b/arch/arm/mach-s3c2410/include/mach/h1940-latch.h
@@ -14,51 +14,30 @@
 #ifndef __ASM_ARCH_H1940_LATCH_H
 #define __ASM_ARCH_H1940_LATCH_H
 
+#include <mach/gpio.h>
 
-#ifndef __ASSEMBLY__
-#define H1940_LATCH		((void __force __iomem *)0xF8000000)
-#else
-#define H1940_LATCH		0xF8000000
-#endif
-
-#define H1940_PA_LATCH		(S3C2410_CS2)
+#define H1940_LATCH_GPIO(x)		(S3C_GPIO_END + (x))
 
 /* SD layer latch */
 
-#define H1940_LATCH_SDQ1		(1<<16)
-#define H1940_LATCH_LCD_P1		(1<<17)
-#define H1940_LATCH_LCD_P2		(1<<18)
-#define H1940_LATCH_LCD_P3		(1<<19)
-#define H1940_LATCH_MAX1698_nSHUTDOWN	(1<<20)		/* LCD backlight */
-#define H1940_LATCH_LED_RED		(1<<21)
-#define H1940_LATCH_SDQ7		(1<<22)
-#define H1940_LATCH_USB_DP		(1<<23)
+#define H1940_LATCH_SDQ1		H1940_LATCH_GPIO(0)
+#define H1940_LATCH_LCD_P1		H1940_LATCH_GPIO(1)
+#define H1940_LATCH_LCD_P2		H1940_LATCH_GPIO(2)
+#define H1940_LATCH_LCD_P3		H1940_LATCH_GPIO(3)
+#define H1940_LATCH_MAX1698_nSHUTDOWN	H1940_LATCH_GPIO(4)
+#define H1940_LATCH_LED_RED		H1940_LATCH_GPIO(5)
+#define H1940_LATCH_SDQ7		H1940_LATCH_GPIO(6)
+#define H1940_LATCH_USB_DP		H1940_LATCH_GPIO(7)
 
 /* CPU layer latch */
 
-#define H1940_LATCH_UDA_POWER		(1<<24)
-#define H1940_LATCH_AUDIO_POWER		(1<<25)
-#define H1940_LATCH_SM803_ENABLE	(1<<26)
-#define H1940_LATCH_LCD_P4		(1<<27)
-#define H1940_LATCH_CPUQ5		(1<<28)		/* untraced */
-#define H1940_LATCH_BLUETOOTH_POWER	(1<<29)		/* active high */
-#define H1940_LATCH_LED_GREEN		(1<<30)
-#define H1940_LATCH_LED_FLASH		(1<<31)
-
-/* default settings */
-
-#define H1940_LATCH_DEFAULT		\
-	H1940_LATCH_LCD_P4		| \
-	H1940_LATCH_SM803_ENABLE	| \
-	H1940_LATCH_SDQ1		| \
-	H1940_LATCH_LCD_P1		| \
-	H1940_LATCH_LCD_P2		| \
-	H1940_LATCH_LCD_P3		| \
-	H1940_LATCH_MAX1698_nSHUTDOWN   | \
-	H1940_LATCH_CPUQ5
-
-/* control functions */
-
-extern void h1940_latch_control(unsigned int clear, unsigned int set);
+#define H1940_LATCH_UDA_POWER		H1940_LATCH_GPIO(8)
+#define H1940_LATCH_AUDIO_POWER		H1940_LATCH_GPIO(9)
+#define H1940_LATCH_SM803_ENABLE	H1940_LATCH_GPIO(10)
+#define H1940_LATCH_LCD_P4		H1940_LATCH_GPIO(11)
+#define H1940_LATCH_CPUQ5		H1940_LATCH_GPIO(12)
+#define H1940_LATCH_BLUETOOTH_POWER	H1940_LATCH_GPIO(13)
+#define H1940_LATCH_LED_GREEN		H1940_LATCH_GPIO(14)
+#define H1940_LATCH_LED_FLASH		H1940_LATCH_GPIO(15)
 
 #endif /* __ASM_ARCH_H1940_LATCH_H */
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index 3ba3bab..f0493bd 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -59,6 +59,12 @@
 #include <plat/mci.h>
 #include <plat/ts.h>
 
+#define H1940_LATCH		((void __force __iomem *)0xF8000000)
+
+#define H1940_PA_LATCH		S3C2410_CS2
+
+#define H1940_LATCH_BIT(x)	(1 << ((x) + 16 - S3C_GPIO_END))
+
 static struct map_desc h1940_iodesc[] __initdata = {
 	[0] = {
 		.virtual	= (unsigned long)H1940_LATCH,
@@ -100,9 +106,16 @@ static struct s3c2410_uartcfg h1940_uartcfgs[] __initdata = {
 
 /* Board control latch control */
 
-static unsigned int latch_state = H1940_LATCH_DEFAULT;
+static unsigned int latch_state = H1940_LATCH_BIT(H1940_LATCH_LCD_P4) |
+	H1940_LATCH_BIT(H1940_LATCH_SM803_ENABLE)	|
+	H1940_LATCH_BIT(H1940_LATCH_SDQ1)			|
+	H1940_LATCH_BIT(H1940_LATCH_LCD_P1)			|
+	H1940_LATCH_BIT(H1940_LATCH_LCD_P2)			|
+	H1940_LATCH_BIT(H1940_LATCH_LCD_P3)			|
+	H1940_LATCH_BIT(H1940_LATCH_MAX1698_nSHUTDOWN)   |
+	H1940_LATCH_BIT(H1940_LATCH_CPUQ5);
 
-void h1940_latch_control(unsigned int clear, unsigned int set)
+static void h1940_latch_control(unsigned int clear, unsigned int set)
 {
 	unsigned long flags;
 
@@ -116,7 +129,42 @@ void h1940_latch_control(unsigned int clear, unsigned int set)
 	local_irq_restore(flags);
 }
 
-EXPORT_SYMBOL_GPL(h1940_latch_control);
+static inline int h1940_gpiolib_to_latch(int offset)
+{
+	return 1 << (offset + 16);
+}
+
+static void h1940_gpiolib_latch_set(struct gpio_chip *chip,
+					unsigned offset, int value)
+{
+	int latch_bit = h1940_gpiolib_to_latch(offset);
+
+	h1940_latch_control(value ? 0 : latch_bit,
+		value ? latch_bit : 0);
+}
+
+static int h1940_gpiolib_latch_output(struct gpio_chip *chip,
+					unsigned offset, int value)
+{
+	h1940_gpiolib_latch_set(chip, offset, value);
+	return 0;
+}
+
+static int h1940_gpiolib_latch_get(struct gpio_chip *chip,
+					unsigned offset)
+{
+	return (latch_state >> (offset + 16)) & 1;
+}
+
+struct gpio_chip h1940_latch_gpiochip = {
+	.base			= H1940_LATCH_GPIO(0),
+	.owner			= THIS_MODULE,
+	.label			= "H1940_LATCH",
+	.ngpio			= 16,
+	.direction_output	= h1940_gpiolib_latch_output,
+	.set			= h1940_gpiolib_latch_set,
+	.get			= h1940_gpiolib_latch_get,
+};
 
 static void h1940_udc_pullup(enum s3c2410_udc_cmd_e cmd)
 {
@@ -125,10 +173,10 @@ static void h1940_udc_pullup(enum s3c2410_udc_cmd_e cmd)
 	switch (cmd)
 	{
 		case S3C2410_UDC_P_ENABLE :
-			h1940_latch_control(0, H1940_LATCH_USB_DP);
+			gpio_set_value(H1940_LATCH_USB_DP, 1);
 			break;
 		case S3C2410_UDC_P_DISABLE :
-			h1940_latch_control(H1940_LATCH_USB_DP, 0);
+			gpio_set_value(H1940_LATCH_USB_DP, 0);
 			break;
 		case S3C2410_UDC_P_RESET :
 			break;
@@ -303,6 +351,8 @@ static void __init h1940_map_io(void)
 	memcpy(phys_to_virt(H1940_SUSPEND_RESUMEAT), h1940_pm_return, 1024);
 #endif
 	s3c_pm_init();
+
+	WARN_ON(gpiochip_add(&h1940_latch_gpiochip));
 }
 
 /* H1940 and RX3715 need to reserve this for suspend */
@@ -342,9 +392,11 @@ static void __init h1940_init(void)
 	gpio_request(S3C2410_GPC(0), "LCD power");
 	gpio_request(S3C2410_GPC(5), "LCD power");
 	gpio_request(S3C2410_GPC(6), "LCD power");
-
 	gpio_direction_input(S3C2410_GPC(6));
 
+	gpio_request(H1940_LATCH_USB_DP, "USB pullup");
+	gpio_direction_output(H1940_LATCH_USB_DP, 0);
+
 	platform_add_devices(h1940_devices, ARRAY_SIZE(h1940_devices));
 }
 
diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
index 984bf66..5a27b1b 100644
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ b/arch/arm/plat-s3c24xx/Kconfig
@@ -69,6 +69,7 @@ config S3C24XX_GPIO_EXTRA
 	int
 	default 128 if S3C24XX_GPIO_EXTRA128
 	default 64 if S3C24XX_GPIO_EXTRA64
+	default 16 if ARCH_H1940
 	default 0
 
 config S3C24XX_GPIO_EXTRA64
-- 
1.7.2.2
