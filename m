From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 18 Jan 2010 02:38:36 +0000
Subject: [PATCH] ARM: SAMSUNG: Move GPIO common functions to plat-samsung
In-Reply-To: <1263782319-20775-1-git-send-email-ben-linux@fluff.org>
References: <1263782319-20775-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1263782319-20775-2-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kukjin Kim <kgene.kim@samsung.com>

This patch moves GPIO common functions (from plat-s3c64xx) into plat-samsung.
and adds the config option to build the plat-samsung/gpiolib for Samsung SoCs.

Signed-off-by: Adityapratap Sharma <aditya.ps@samsung.com>
Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
[ben-linux at fluff.org: remove uncessary changelogs from internal dev]
[ben-linux at fluff.org: fix aditya's email address and shorten title]
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c/include/plat/gpio-core.h |    3 +
 arch/arm/plat-s3c64xx/Kconfig              |    1 +
 arch/arm/plat-s3c64xx/gpiolib.c            |  162 +----------------------
 arch/arm/plat-samsung/Kconfig              |    7 +
 arch/arm/plat-samsung/Makefile             |    1 +
 arch/arm/plat-samsung/gpiolib.c            |  202 ++++++++++++++++++++++++++++
 6 files changed, 216 insertions(+), 160 deletions(-)
 create mode 100644 arch/arm/plat-samsung/gpiolib.c

diff --git a/arch/arm/plat-s3c/include/plat/gpio-core.h b/arch/arm/plat-s3c/include/plat/gpio-core.h
index 32af612..92c3829 100644
--- a/arch/arm/plat-s3c/include/plat/gpio-core.h
+++ b/arch/arm/plat-s3c/include/plat/gpio-core.h
@@ -80,6 +80,9 @@ extern void s3c_gpiolib_add(struct s3c_gpio_chip *chip);
  * and any other necessary functions.
  */
 
+extern void samsung_gpiolib_add_4bit(struct s3c_gpio_chip *chip);
+extern void samsung_gpiolib_add_4bit2(struct s3c_gpio_chip *chip);
+
 #ifdef CONFIG_S3C_GPIO_TRACK
 extern struct s3c_gpio_chip *s3c_gpios[S3C_GPIO_END];
 
diff --git a/arch/arm/plat-s3c64xx/Kconfig b/arch/arm/plat-s3c64xx/Kconfig
index 0fba1f9..b0808f7 100644
--- a/arch/arm/plat-s3c64xx/Kconfig
+++ b/arch/arm/plat-s3c64xx/Kconfig
@@ -22,6 +22,7 @@ config PLAT_S3C64XX
 	select S3C_GPIO_CFG_S3C64XX
 	select S3C_DEV_NAND
 	select USB_ARCH_HAS_OHCI
+	select SAMSUNG_GPIOLIB
 	help
 	  Base platform code for any Samsung S3C64XX device
 
diff --git a/arch/arm/plat-s3c64xx/gpiolib.c b/arch/arm/plat-s3c64xx/gpiolib.c
index 7785604..265e23b 100644
--- a/arch/arm/plat-s3c64xx/gpiolib.c
+++ b/arch/arm/plat-s3c64xx/gpiolib.c
@@ -49,150 +49,6 @@
  * [2] BANK has two control registers, GPxCON0 and GPxCON1
  */
 
-#define OFF_GPCON	(0x00)
-#define OFF_GPDAT	(0x04)
-
-#define con_4bit_shift(__off) ((__off) * 4)
-
-#if 1
-#define gpio_dbg(x...) do { } while(0)
-#else
-#define gpio_dbg(x...) printk(KERN_DEBUG x)
-#endif
-
-/* The s3c64xx_gpiolib_4bit routines are to control the gpio banks where
- * the gpio configuration register (GPxCON) has 4 bits per GPIO, as the
- * following example:
- *
- * base + 0x00: Control register, 4 bits per gpio
- *	        gpio n: 4 bits starting at (4*n)
- *		0000 = input, 0001 = output, others mean special-function
- * base + 0x04: Data register, 1 bit per gpio
- *		bit n: data bit n
- *
- * Note, since the data register is one bit per gpio and is at base + 0x4
- * we can use s3c_gpiolib_get and s3c_gpiolib_set to change the state of
- * the output.
-*/
-
-static int s3c64xx_gpiolib_4bit_input(struct gpio_chip *chip, unsigned offset)
-{
-	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
-	void __iomem *base = ourchip->base;
-	unsigned long con;
-
-	con = __raw_readl(base + OFF_GPCON);
-	con &= ~(0xf << con_4bit_shift(offset));
-	__raw_writel(con, base + OFF_GPCON);
-
-	gpio_dbg("%s: %p: CON now %08lx\n", __func__, base, con);
-
-	return 0;
-}
-
-static int s3c64xx_gpiolib_4bit_output(struct gpio_chip *chip,
-				       unsigned offset, int value)
-{
-	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
-	void __iomem *base = ourchip->base;
-	unsigned long con;
-	unsigned long dat;
-
-	con = __raw_readl(base + OFF_GPCON);
-	con &= ~(0xf << con_4bit_shift(offset));
-	con |= 0x1 << con_4bit_shift(offset);
-
-	dat = __raw_readl(base + OFF_GPDAT);
-	if (value)
-		dat |= 1 << offset;
-	else
-		dat &= ~(1 << offset);
-
-	__raw_writel(dat, base + OFF_GPDAT);
-	__raw_writel(con, base + OFF_GPCON);
-	__raw_writel(dat, base + OFF_GPDAT);
-
-	gpio_dbg("%s: %p: CON %08lx, DAT %08lx\n", __func__, base, con, dat);
-
-	return 0;
-}
-
-/* The next set of routines are for the case where the GPIO configuration
- * registers are 4 bits per GPIO but there is more than one register (the
- * bank has more than 8 GPIOs.
- *
- * This case is the similar to the 4 bit case, but the registers are as
- * follows:
- *
- * base + 0x00: Control register, 4 bits per gpio (lower 8 GPIOs)
- *	        gpio n: 4 bits starting at (4*n)
- *		0000 = input, 0001 = output, others mean special-function
- * base + 0x04: Control register, 4 bits per gpio (up to 8 additions GPIOs)
- *	        gpio n: 4 bits starting at (4*n)
- *		0000 = input, 0001 = output, others mean special-function
- * base + 0x08: Data register, 1 bit per gpio
- *		bit n: data bit n
- *
- * To allow us to use the s3c_gpiolib_get and s3c_gpiolib_set routines we
- * store the 'base + 0x4' address so that these routines see the data
- * register@ourchip->base + 0x04.
-*/
-
-static int s3c64xx_gpiolib_4bit2_input(struct gpio_chip *chip, unsigned offset)
-{
-	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
-	void __iomem *base = ourchip->base;
-	void __iomem *regcon = base;
-	unsigned long con;
-
-	if (offset > 7)
-		offset -= 8;
-	else
-		regcon -= 4;
-
-	con = __raw_readl(regcon);
-	con &= ~(0xf << con_4bit_shift(offset));
-	__raw_writel(con, regcon);
-
-	gpio_dbg("%s: %p: CON %08lx\n", __func__, base, con);
-
-	return 0;
-
-}
-
-static int s3c64xx_gpiolib_4bit2_output(struct gpio_chip *chip,
-				       unsigned offset, int value)
-{
-	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
-	void __iomem *base = ourchip->base;
-	void __iomem *regcon = base;
-	unsigned long con;
-	unsigned long dat;
-
-	if (offset > 7)
-		offset -= 8;
-	else
-		regcon -= 4;
-
-	con = __raw_readl(regcon);
-	con &= ~(0xf << con_4bit_shift(offset));
-	con |= 0x1 << con_4bit_shift(offset);
-
-	dat = __raw_readl(base + OFF_GPDAT);
-	if (value)
-		dat |= 1 << offset;
-	else
-		dat &= ~(1 << offset);
-
-	__raw_writel(dat, base + OFF_GPDAT);
-	__raw_writel(con, regcon);
-	__raw_writel(dat, base + OFF_GPDAT);
-
-	gpio_dbg("%s: %p: CON %08lx, DAT %08lx\n", __func__, base, con, dat);
-
-	return 0;
-}
-
 static struct s3c_gpio_cfg gpio_4bit_cfg_noint = {
 	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
 	.set_pull	= s3c_gpio_setpull_updown,
@@ -399,20 +255,6 @@ static struct s3c_gpio_chip gpio_2bit[] = {
 	},
 };
 
-static __init void s3c64xx_gpiolib_add_4bit(struct s3c_gpio_chip *chip)
-{
-	chip->chip.direction_input = s3c64xx_gpiolib_4bit_input;
-	chip->chip.direction_output = s3c64xx_gpiolib_4bit_output;
-	chip->pm = __gpio_pm(&s3c_gpio_pm_4bit);
-}
-
-static __init void s3c64xx_gpiolib_add_4bit2(struct s3c_gpio_chip *chip)
-{
-	chip->chip.direction_input = s3c64xx_gpiolib_4bit2_input;
-	chip->chip.direction_output = s3c64xx_gpiolib_4bit2_output;
-	chip->pm = __gpio_pm(&s3c_gpio_pm_4bit);
-}
-
 static __init void s3c64xx_gpiolib_add_2bit(struct s3c_gpio_chip *chip)
 {
 	chip->pm = __gpio_pm(&s3c_gpio_pm_2bit);
@@ -432,10 +274,10 @@ static __init void s3c64xx_gpiolib_add(struct s3c_gpio_chip *chips,
 static __init int s3c64xx_gpiolib_init(void)
 {
 	s3c64xx_gpiolib_add(gpio_4bit, ARRAY_SIZE(gpio_4bit),
-			    s3c64xx_gpiolib_add_4bit);
+			    samsung_gpiolib_add_4bit);
 
 	s3c64xx_gpiolib_add(gpio_4bit2, ARRAY_SIZE(gpio_4bit2),
-			    s3c64xx_gpiolib_add_4bit2);
+			    samsung_gpiolib_add_4bit2);
 
 	s3c64xx_gpiolib_add(gpio_2bit, ARRAY_SIZE(gpio_2bit),
 			    s3c64xx_gpiolib_add_2bit);
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index e6c1229..6ebbe03 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -33,6 +33,13 @@ config SAMSUNG_IRQ_UART
 
 # options for gpio configuration support
 
+config SAMSUNG_GPIOLIB
+	bool
+	help
+	  GPIOlib file contains the 4 bit modification functions for gpio
+	  configuration. GPIOlib shall be compiled only for S3C64XX and S5P
+	  series of processors.
+
 config S3C_GPIO_CFG_S3C24XX
 	bool
 	help
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index ee31038..1425a45 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -15,6 +15,7 @@ obj-y				+= clock.o
 obj-y				+= pwm-clock.o
 obj-y				+= gpio-config.o
 
+obj-$(CONFIG_SAMSUNG_GPIOLIB)	+= gpiolib.o
 obj-$(CONFIG_SAMSUNG_CLKSRC)	+= clock-clksrc.o
 
 obj-$(CONFIG_SAMSUNG_IRQ_UART)	+= irq-uart.o
diff --git a/arch/arm/plat-samsung/gpiolib.c b/arch/arm/plat-samsung/gpiolib.c
new file mode 100644
index 0000000..c1ecc94
--- /dev/null
+++ b/arch/arm/plat-samsung/gpiolib.c
@@ -0,0 +1,202 @@
+/* arch/arm/plat-samsung/gpiolib.c
+ *
+ * Copyright 2008 Openmoko, Inc.
+ * Copyright 2008 Simtec Electronics
+ *      Ben Dooks <ben@simtec.co.uk>
+ *      http://armlinux.simtec.co.uk/
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * SAMSUNG - GPIOlib support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <mach/gpio.h>
+#include <mach/gpio-core.h>
+#include <plat/gpio-cfg.h>
+#include <plat/gpio-cfg-helpers.h>
+
+#define GPIOCON_OFF	(0x00)
+#define GPIODAT_OFF	(0x04)
+
+#define con_4bit_shift(__off) ((__off) * 4)
+
+#ifndef DEBUG_GPIO
+#define gpio_dbg(x...) do { } while (0)
+#else
+#define gpio_dbg(x...) printk(KERN_DEBUG x)
+#endif
+
+/* The samsung_gpiolib_4bit routines are to control the gpio banks where
+ * the gpio configuration register (GPxCON) has 4 bits per GPIO, as the
+ * following example:
+ *
+ * base + 0x00: Control register, 4 bits per gpio
+ *		gpio n: 4 bits starting at (4*n)
+ *		0000 = input, 0001 = output, others mean special-function
+ * base + 0x04: Data register, 1 bit per gpio
+ *		bit n: data bit n
+ *
+ * Note, since the data register is one bit per gpio and is at base + 0x4
+ * we can use s3c_gpiolib_get and s3c_gpiolib_set to change the state of
+ * the output.
+*/
+
+int samsung_gpiolib_4bit_input(struct gpio_chip *chip, unsigned int offset)
+{
+	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
+	void __iomem *base = ourchip->base;
+	unsigned long con;
+
+	con = __raw_readl(base + GPIOCON_OFF);
+	con &= ~(0xf << con_4bit_shift(offset));
+	__raw_writel(con, base + GPIOCON_OFF);
+
+	gpio_dbg("%s: %p: CON now %08lx\n", __func__, base, con);
+
+	return 0;
+}
+
+int samsung_gpiolib_4bit_output(struct gpio_chip *chip,
+				unsigned int offset, int value)
+{
+	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
+	void __iomem *base = ourchip->base;
+	unsigned long con;
+	unsigned long dat;
+
+	con = __raw_readl(base + GPIOCON_OFF);
+	con &= ~(0xf << con_4bit_shift(offset));
+	con |= 0x1 << con_4bit_shift(offset);
+
+	dat = __raw_readl(base + GPIODAT_OFF);
+
+	if (value)
+		dat |= 1 << offset;
+	else
+		dat &= ~(1 << offset);
+
+	__raw_writel(dat, base + GPIODAT_OFF);
+	__raw_writel(con, base + GPIOCON_OFF);
+	__raw_writel(dat, base + GPIODAT_OFF);
+
+	gpio_dbg("%s: %p: CON %08lx, DAT %08lx\n", __func__, base, con, dat);
+
+	return 0;
+}
+
+/* The next set of routines are for the case where the GPIO configuration
+ * registers are 4 bits per GPIO but there is more than one register (the
+ * bank has more than 8 GPIOs.
+ *
+ * This case is the similar to the 4 bit case, but the registers are as
+ * follows:
+ *
+ * base + 0x00: Control register, 4 bits per gpio (lower 8 GPIOs)
+ *		gpio n: 4 bits starting at (4*n)
+ *		0000 = input, 0001 = output, others mean special-function
+ * base + 0x04: Control register, 4 bits per gpio (up to 8 additions GPIOs)
+ *		gpio n: 4 bits starting at (4*n)
+ *		0000 = input, 0001 = output, others mean special-function
+ * base + 0x08: Data register, 1 bit per gpio
+ *		bit n: data bit n
+ *
+ * To allow us to use the s3c_gpiolib_get and s3c_gpiolib_set routines we
+ * store the 'base + 0x4' address so that these routines see the data
+ * register@ourchip->base + 0x04.
+*/
+
+int samsung_gpiolib_4bit2_input(struct gpio_chip *chip, unsigned int offset)
+{
+	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
+	void __iomem *base = ourchip->base;
+	void __iomem *regcon = base;
+	unsigned long con;
+
+	if (offset > 7)
+		offset -= 8;
+	else
+		regcon -= 4;
+
+	con = __raw_readl(regcon);
+	con &= ~(0xf << con_4bit_shift(offset));
+	__raw_writel(con, regcon);
+
+	gpio_dbg("%s: %p: CON %08lx\n", __func__, base, con);
+
+	return 0;
+}
+
+int samsung_gpiolib_4bit2_output(struct gpio_chip *chip,
+				 unsigned int offset, int value)
+{
+	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
+	void __iomem *base = ourchip->base;
+	void __iomem *regcon = base;
+	unsigned long con;
+	unsigned long dat;
+	unsigned con_offset = offset;
+
+	if (con_offset > 7)
+		con_offset -= 8;
+	else
+		regcon -= 4;
+
+	con = __raw_readl(regcon);
+	con &= ~(0xf << con_4bit_shift(con_offset));
+	con |= 0x1 << con_4bit_shift(con_offset);
+
+	dat = __raw_readl(base + GPIODAT_OFF);
+
+	if (value)
+		dat |= 1 << offset;
+	else
+		dat &= ~(1 << offset);
+
+	__raw_writel(dat, base + GPIODAT_OFF);
+	__raw_writel(con, regcon);
+	__raw_writel(dat, base + GPIODAT_OFF);
+
+	gpio_dbg("%s: %p: CON %08lx, DAT %08lx\n", __func__, base, con, dat);
+
+	return 0;
+}
+
+void __init samsung_gpiolib_add_4bit(struct s3c_gpio_chip *chip)
+{
+	chip->chip.direction_input = samsung_gpiolib_4bit_input;
+	chip->chip.direction_output = samsung_gpiolib_4bit_output;
+	chip->pm = __gpio_pm(&s3c_gpio_pm_4bit);
+}
+
+void __init samsung_gpiolib_add_4bit2(struct s3c_gpio_chip *chip)
+{
+	chip->chip.direction_input = samsung_gpiolib_4bit2_input;
+	chip->chip.direction_output = samsung_gpiolib_4bit2_output;
+	chip->pm = __gpio_pm(&s3c_gpio_pm_4bit);
+}
+
+void __init samsung_gpiolib_add_4bit_chips(struct s3c_gpio_chip *chip,
+					   int nr_chips)
+{
+	for (; nr_chips > 0; nr_chips--, chip++) {
+		samsung_gpiolib_add_4bit(chip);
+		s3c_gpiolib_add(chip);
+	}
+}
+
+void __init samsung_gpiolib_add_4bit2_chips(struct s3c_gpio_chip *chip,
+					    int nr_chips)
+{
+	for (; nr_chips > 0; nr_chips--, chip++) {
+		samsung_gpiolib_add_4bit2(chip);
+		s3c_gpiolib_add(chip);
+	}
+}
-- 
1.6.0.4
