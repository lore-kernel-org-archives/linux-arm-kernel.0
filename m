From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 13 Apr 2013 08:21:39 +0400
Subject: [PATCH 1/2] GPIO: clps711x: Rewrite driver for using generic GPIO code
Message-ID: <1365826900-30136-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides rewritten driver for CLPS711X GPIO which uses
generic GPIO code.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/configs/clps711x_defconfig            |   1 +
 arch/arm/mach-clps711x/Makefile                |   5 +-
 arch/arm/mach-clps711x/board-autcpu12.c        |   2 +
 arch/arm/mach-clps711x/board-cdb89712.c        |   2 +
 arch/arm/mach-clps711x/board-edb7211.c         |   7 +
 arch/arm/mach-clps711x/board-p720t.c           |  10 +-
 arch/arm/mach-clps711x/devices.c               |  56 ++++++
 arch/arm/mach-clps711x/devices.h               |  12 ++
 arch/arm/mach-clps711x/include/mach/clps711x.h |  23 +--
 drivers/gpio/Kconfig                           |   5 +-
 drivers/gpio/gpio-clps711x.c                   | 228 +++++++------------------
 11 files changed, 164 insertions(+), 187 deletions(-)
 create mode 100644 arch/arm/mach-clps711x/devices.c
 create mode 100644 arch/arm/mach-clps711x/devices.h

diff --git a/arch/arm/configs/clps711x_defconfig b/arch/arm/configs/clps711x_defconfig
index 1cd94c3..e9a1747 100644
--- a/arch/arm/configs/clps711x_defconfig
+++ b/arch/arm/configs/clps711x_defconfig
@@ -64,6 +64,7 @@ CONFIG_CS89x0_PLATFORM=y
 CONFIG_SERIAL_CLPS711X_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_SPI=y
+CONFIG_GPIO_CLPS711X=y
 CONFIG_GPIO_GENERIC_PLATFORM=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
diff --git a/arch/arm/mach-clps711x/Makefile b/arch/arm/mach-clps711x/Makefile
index 992995a..f30ed2b 100644
--- a/arch/arm/mach-clps711x/Makefile
+++ b/arch/arm/mach-clps711x/Makefile
@@ -4,10 +4,7 @@
 
 # Object file lists.
 
-obj-y			:= common.o
-obj-m			:=
-obj-n			:=
-obj-			:=
+obj-y				:= common.o devices.o
 
 obj-$(CONFIG_ARCH_AUTCPU12)	+= board-autcpu12.o
 obj-$(CONFIG_ARCH_CDB89712)	+= board-cdb89712.o
diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
index f385847..1e22cb4 100644
--- a/arch/arm/mach-clps711x/board-autcpu12.c
+++ b/arch/arm/mach-clps711x/board-autcpu12.c
@@ -43,6 +43,7 @@
 #include <mach/autcpu12.h>
 
 #include "common.h"
+#include "devices.h"
 
 #define AUTCPU12_CS8900_BASE	(CS2_PHYS_BASE + 0x300)
 #define AUTCPU12_CS8900_IRQ	(IRQ_EINT3)
@@ -149,6 +150,7 @@ static struct platform_device autcpu12_mmgpio_pdev __initdata = {
 
 static void __init autcpu12_init(void)
 {
+	clps711x_devices_init();
 	platform_device_register_simple("video-clps711x", 0, NULL, 0);
 	platform_device_register_simple("cs89x0", 0, autcpu12_cs8900_resource,
 					ARRAY_SIZE(autcpu12_cs8900_resource));
diff --git a/arch/arm/mach-clps711x/board-cdb89712.c b/arch/arm/mach-clps711x/board-cdb89712.c
index baab7da..a80ae57 100644
--- a/arch/arm/mach-clps711x/board-cdb89712.c
+++ b/arch/arm/mach-clps711x/board-cdb89712.c
@@ -39,6 +39,7 @@
 #include <asm/mach/map.h>
 
 #include "common.h"
+#include "devices.h"
 
 #define CDB89712_CS8900_BASE	(CS2_PHYS_BASE + 0x300)
 #define CDB89712_CS8900_IRQ	(IRQ_EINT3)
@@ -127,6 +128,7 @@ static struct platform_device cdb89712_sram_pdev __initdata = {
 
 static void __init cdb89712_init(void)
 {
+	clps711x_devices_init();
 	platform_device_register(&cdb89712_flash_pdev);
 	platform_device_register(&cdb89712_bootrom_pdev);
 	platform_device_register(&cdb89712_sram_pdev);
diff --git a/arch/arm/mach-clps711x/board-edb7211.c b/arch/arm/mach-clps711x/board-edb7211.c
index 5f928e9..e1c5573 100644
--- a/arch/arm/mach-clps711x/board-edb7211.c
+++ b/arch/arm/mach-clps711x/board-edb7211.c
@@ -29,6 +29,7 @@
 #include <mach/hardware.h>
 
 #include "common.h"
+#include "devices.h"
 
 #define VIDEORAM_SIZE		SZ_128K
 
@@ -151,6 +152,11 @@ fixup_edb7211(struct tag *tags, char **cmdline, struct meminfo *mi)
 
 static void __init edb7211_init(void)
 {
+	clps711x_devices_init();
+}
+
+static void __init edb7211_init_late(void)
+{
 	gpio_request_array(edb7211_gpios, ARRAY_SIZE(edb7211_gpios));
 
 	platform_device_register(&edb7211_flash_pdev);
@@ -175,6 +181,7 @@ MACHINE_START(EDB7211, "CL-EDB7211 (EP7211 eval board)")
 	.init_irq	= clps711x_init_irq,
 	.init_time	= clps711x_timer_init,
 	.init_machine	= edb7211_init,
+	.init_late	= edb7211_init_late,
 	.handle_irq	= clps711x_handle_irq,
 	.restart	= clps711x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-clps711x/board-p720t.c b/arch/arm/mach-clps711x/board-p720t.c
index 8d3ee67..48d0737 100644
--- a/arch/arm/mach-clps711x/board-p720t.c
+++ b/arch/arm/mach-clps711x/board-p720t.c
@@ -43,6 +43,7 @@
 #include <video/platform_lcd.h>
 
 #include "common.h"
+#include "devices.h"
 
 #define P720T_USERLED		CLPS711X_GPIO(3, 0)
 #define P720T_NAND_CLE		CLPS711X_GPIO(4, 0)
@@ -199,6 +200,11 @@ static struct gpio_led_platform_data p720t_gpio_led_pdata __initdata = {
 
 static void __init p720t_init(void)
 {
+	clps711x_devices_init();
+}
+
+static void __init p720t_init_late(void)
+{
 	platform_device_register(&p720t_nand_pdev);
 	platform_device_register_data(&platform_bus, "platform-lcd", 0,
 				      &p720t_lcd_power_pdata,
@@ -207,10 +213,6 @@ static void __init p720t_init(void)
 				      &p720t_lcd_backlight_pdata,
 				      sizeof(p720t_lcd_backlight_pdata));
 	platform_device_register_simple("video-clps711x", 0, NULL, 0);
-}
-
-static void __init p720t_init_late(void)
-{
 	platform_device_register_data(&platform_bus, "leds-gpio", 0,
 				      &p720t_gpio_led_pdata,
 				      sizeof(p720t_gpio_led_pdata));
diff --git a/arch/arm/mach-clps711x/devices.c b/arch/arm/mach-clps711x/devices.c
new file mode 100644
index 0000000..100ddec
--- /dev/null
+++ b/arch/arm/mach-clps711x/devices.c
@@ -0,0 +1,56 @@
+/*
+ *  CLPS711X common devices definitions
+ *
+ *  Copyright (C) 2013 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/io.h>
+#include <linux/sizes.h>
+#include <linux/platform_device.h>
+
+#include <mach/hardware.h>
+
+static void __init clps711x_add_gpio(void)
+{
+	const struct resource clps711x_gpio0_res[] = {
+		DEFINE_RES_MEM(PADR, SZ_1),
+		DEFINE_RES_MEM(PADDR, SZ_1),
+	};
+	const struct resource clps711x_gpio1_res[] = {
+		DEFINE_RES_MEM(PBDR, SZ_1),
+		DEFINE_RES_MEM(PBDDR, SZ_1),
+	};
+	const struct resource clps711x_gpio2_res[] = {
+		DEFINE_RES_MEM(PCDR, SZ_1),
+		DEFINE_RES_MEM(PCDDR, SZ_1),
+	};
+	const struct resource clps711x_gpio3_res[] = {
+		DEFINE_RES_MEM(PDDR, SZ_1),
+		DEFINE_RES_MEM(PDDDR, SZ_1),
+	};
+	const struct resource clps711x_gpio4_res[] = {
+		DEFINE_RES_MEM(PEDR, SZ_1),
+		DEFINE_RES_MEM(PEDDR, SZ_1),
+	};
+
+	platform_device_register_simple("clps711x-gpio", 0, clps711x_gpio0_res,
+					ARRAY_SIZE(clps711x_gpio0_res));
+	platform_device_register_simple("clps711x-gpio", 1, clps711x_gpio1_res,
+					ARRAY_SIZE(clps711x_gpio1_res));
+	platform_device_register_simple("clps711x-gpio", 2, clps711x_gpio2_res,
+					ARRAY_SIZE(clps711x_gpio2_res));
+	platform_device_register_simple("clps711x-gpio", 3, clps711x_gpio3_res,
+					ARRAY_SIZE(clps711x_gpio3_res));
+	platform_device_register_simple("clps711x-gpio", 4, clps711x_gpio4_res,
+					ARRAY_SIZE(clps711x_gpio4_res));
+}
+
+void __init clps711x_devices_init(void)
+{
+	clps711x_add_gpio();
+}
diff --git a/arch/arm/mach-clps711x/devices.h b/arch/arm/mach-clps711x/devices.h
new file mode 100644
index 0000000..a5efc17
--- /dev/null
+++ b/arch/arm/mach-clps711x/devices.h
@@ -0,0 +1,12 @@
+/*
+ *  CLPS711X common devices definitions
+ *
+ *  Copyright (C) 2013 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+void clps711x_devices_init(void);
diff --git a/arch/arm/mach-clps711x/include/mach/clps711x.h b/arch/arm/mach-clps711x/include/mach/clps711x.h
index 01d1b95..9279f0a 100644
--- a/arch/arm/mach-clps711x/include/mach/clps711x.h
+++ b/arch/arm/mach-clps711x/include/mach/clps711x.h
@@ -23,16 +23,19 @@
 
 #define CLPS711X_PHYS_BASE	(0x80000000)
 
-#define PADR		(0x0000)
-#define PBDR		(0x0001)
-#define PCDR		(0x0002)
-#define PDDR		(0x0003)
-#define PADDR		(0x0040)
-#define PBDDR		(0x0041)
-#define PCDDR		(0x0042)
-#define PDDDR		(0x0043)
-#define PEDR		(0x0083)
-#define PEDDR		(0x00c3)
+#define CLPS711X_REGS(x)	(CLPS711X_PHYS_BASE + (x))
+
+#define PADR		CLPS711X_REGS(0x0000)
+#define PBDR		CLPS711X_REGS(0x0001)
+#define PCDR		CLPS711X_REGS(0x0002)
+#define PDDR		CLPS711X_REGS(0x0003)
+#define PADDR		CLPS711X_REGS(0x0040)
+#define PBDDR		CLPS711X_REGS(0x0041)
+#define PCDDR		CLPS711X_REGS(0x0042)
+#define PDDDR		CLPS711X_REGS(0x0043)
+#define PEDR		CLPS711X_REGS(0x0083)
+#define PEDDR		CLPS711X_REGS(0x00c3)
+
 #define SYSCON1		(0x0100)
 #define SYSFLG1		(0x0140)
 #define MEMCFG1		(0x0180)
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 723091d..47973c1 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -110,8 +110,11 @@ config GPIO_MAX730X
 comment "Memory mapped GPIO drivers:"
 
 config GPIO_CLPS711X
-	def_bool y
+	tristate "CLPS711X GPIO support"
 	depends on ARCH_CLPS711X
+	select GPIO_GENERIC
+	help
+	  Say yes here to support GPIO on CLPS711X SoCs.
 
 config GPIO_GENERIC_PLATFORM
 	tristate "Generic memory-mapped GPIO controller support (MMIO platform device)"
diff --git a/drivers/gpio/gpio-clps711x.c b/drivers/gpio/gpio-clps711x.c
index ce63b75..3c71815 100644
--- a/drivers/gpio/gpio-clps711x.c
+++ b/drivers/gpio/gpio-clps711x.c
@@ -1,7 +1,7 @@
 /*
  *  CLPS711X GPIO driver
  *
- *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
+ *  Copyright (C) 2013 Alexander Shiyan <shc_work@mail.ru>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -9,191 +9,83 @@
  * (at your option) any later version.
  */
 
-#include <linux/io.h>
-#include <linux/slab.h>
 #include <linux/gpio.h>
 #include <linux/module.h>
-#include <linux/spinlock.h>
+#include <linux/basic_mmio_gpio.h>
 #include <linux/platform_device.h>
 
-#include <mach/hardware.h>
-
-#define CLPS711X_GPIO_PORTS	5
-#define CLPS711X_GPIO_NAME	"gpio-clps711x"
-
-struct clps711x_gpio {
-	struct gpio_chip	chip[CLPS711X_GPIO_PORTS];
-	spinlock_t		lock;
-};
-
-static void __iomem *clps711x_ports[] = {
-	CLPS711X_VIRT_BASE + PADR,
-	CLPS711X_VIRT_BASE + PBDR,
-	CLPS711X_VIRT_BASE + PCDR,
-	CLPS711X_VIRT_BASE + PDDR,
-	CLPS711X_VIRT_BASE + PEDR,
-};
-
-static void __iomem *clps711x_pdirs[] = {
-	CLPS711X_VIRT_BASE + PADDR,
-	CLPS711X_VIRT_BASE + PBDDR,
-	CLPS711X_VIRT_BASE + PCDDR,
-	CLPS711X_VIRT_BASE + PDDDR,
-	CLPS711X_VIRT_BASE + PEDDR,
-};
-
-#define clps711x_port(x)	clps711x_ports[x->base / 8]
-#define clps711x_pdir(x)	clps711x_pdirs[x->base / 8]
-
-static int gpio_clps711x_get(struct gpio_chip *chip, unsigned offset)
+static int clps711x_gpio_probe(struct platform_device *pdev)
 {
-	return !!(readb(clps711x_port(chip)) & (1 << offset));
-}
+	void __iomem *dat, *dir;
+	struct bgpio_chip *bgc;
+	struct resource *res;
+	int err, id = pdev->id;
 
-static void gpio_clps711x_set(struct gpio_chip *chip, unsigned offset,
-			      int value)
-{
-	int tmp;
-	unsigned long flags;
-	struct clps711x_gpio *gpio = dev_get_drvdata(chip->dev);
+	if ((id < 0) || (id > 4))
+		return -ENODEV;
 
-	spin_lock_irqsave(&gpio->lock, flags);
-	tmp = readb(clps711x_port(chip)) & ~(1 << offset);
-	if (value)
-		tmp |= 1 << offset;
-	writeb(tmp, clps711x_port(chip));
-	spin_unlock_irqrestore(&gpio->lock, flags);
-}
-
-static int gpio_clps711x_dir_in(struct gpio_chip *chip, unsigned offset)
-{
-	int tmp;
-	unsigned long flags;
-	struct clps711x_gpio *gpio = dev_get_drvdata(chip->dev);
-
-	spin_lock_irqsave(&gpio->lock, flags);
-	tmp = readb(clps711x_pdir(chip)) & ~(1 << offset);
-	writeb(tmp, clps711x_pdir(chip));
-	spin_unlock_irqrestore(&gpio->lock, flags);
-
-	return 0;
-}
-
-static int gpio_clps711x_dir_out(struct gpio_chip *chip, unsigned offset,
-				 int value)
-{
-	int tmp;
-	unsigned long flags;
-	struct clps711x_gpio *gpio = dev_get_drvdata(chip->dev);
-
-	spin_lock_irqsave(&gpio->lock, flags);
-	tmp = readb(clps711x_pdir(chip)) | (1 << offset);
-	writeb(tmp, clps711x_pdir(chip));
-	tmp = readb(clps711x_port(chip)) & ~(1 << offset);
-	if (value)
-		tmp |= 1 << offset;
-	writeb(tmp, clps711x_port(chip));
-	spin_unlock_irqrestore(&gpio->lock, flags);
+	bgc = devm_kzalloc(&pdev->dev, sizeof(*bgc), GFP_KERNEL);
+	if (!bgc)
+		return -ENOMEM;
 
-	return 0;
-}
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dat = devm_request_and_ioremap(&pdev->dev, res);
+	if (!dat)
+		return -ENXIO;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	dir = devm_request_and_ioremap(&pdev->dev, res);
+	if (!dir)
+		return -ENXIO;
+
+	switch (id) {
+	case 3:
+		/* PORTD is inverted logic for direction register */
+		err = bgpio_init(bgc, &pdev->dev, 1, dat, NULL, NULL,
+				 NULL, dir, 0);
+		break;
+	default:
+		err = bgpio_init(bgc, &pdev->dev, 1, dat, NULL, NULL,
+				 dir, NULL, 0);
+		break;
+	}
 
-static int gpio_clps711x_dir_in_inv(struct gpio_chip *chip, unsigned offset)
-{
-	int tmp;
-	unsigned long flags;
-	struct clps711x_gpio *gpio = dev_get_drvdata(chip->dev);
+	if (err)
+		return err;
+
+	switch (id) {
+	case 4:
+		/* PORTE is 3 lines only */
+		bgc->gc.ngpio = 3;
+		break;
+	default:
+		bgc->gc.ngpio = 8;
+		break;
+	}
 
-	spin_lock_irqsave(&gpio->lock, flags);
-	tmp = readb(clps711x_pdir(chip)) | (1 << offset);
-	writeb(tmp, clps711x_pdir(chip));
-	spin_unlock_irqrestore(&gpio->lock, flags);
+	bgc->gc.base = id * 8;
+	platform_set_drvdata(pdev, bgc);
 
-	return 0;
+	return gpiochip_add(&bgc->gc);
 }
 
-static int gpio_clps711x_dir_out_inv(struct gpio_chip *chip, unsigned offset,
-				     int value)
+static int clps711x_gpio_remove(struct platform_device *pdev)
 {
-	int tmp;
-	unsigned long flags;
-	struct clps711x_gpio *gpio = dev_get_drvdata(chip->dev);
-
-	spin_lock_irqsave(&gpio->lock, flags);
-	tmp = readb(clps711x_pdir(chip)) & ~(1 << offset);
-	writeb(tmp, clps711x_pdir(chip));
-	tmp = readb(clps711x_port(chip)) & ~(1 << offset);
-	if (value)
-		tmp |= 1 << offset;
-	writeb(tmp, clps711x_port(chip));
-	spin_unlock_irqrestore(&gpio->lock, flags);
+	struct bgpio_chip *bgc = platform_get_drvdata(pdev);
 
-	return 0;
+	return bgpio_remove(bgc);
 }
 
-static struct {
-	char	*name;
-	int	nr;
-	int	inv_dir;
-} clps711x_gpio_ports[] __initconst = {
-	{ "PORTA", 8, 0, },
-	{ "PORTB", 8, 0, },
-	{ "PORTC", 8, 0, },
-	{ "PORTD", 8, 1, },
-	{ "PORTE", 3, 0, },
+static struct platform_driver clps711x_gpio_driver = {
+	.driver	= {
+		.name	= "clps711x-gpio",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= clps711x_gpio_probe,
+	.remove	= clps711x_gpio_remove,
 };
+module_platform_driver(clps711x_gpio_driver);
 
-static int __init gpio_clps711x_init(void)
-{
-	int i;
-	struct platform_device *pdev;
-	struct clps711x_gpio *gpio;
-
-	pdev = platform_device_alloc(CLPS711X_GPIO_NAME, 0);
-	if (!pdev) {
-		pr_err("Cannot create platform device: %s\n",
-		       CLPS711X_GPIO_NAME);
-		return -ENOMEM;
-	}
-
-	platform_device_add(pdev);
-
-	gpio = devm_kzalloc(&pdev->dev, sizeof(struct clps711x_gpio),
-			    GFP_KERNEL);
-	if (!gpio) {
-		dev_err(&pdev->dev, "GPIO allocating memory error\n");
-		platform_device_unregister(pdev);
-		return -ENOMEM;
-	}
-
-	platform_set_drvdata(pdev, gpio);
-
-	spin_lock_init(&gpio->lock);
-
-	for (i = 0; i < CLPS711X_GPIO_PORTS; i++) {
-		gpio->chip[i].owner		= THIS_MODULE;
-		gpio->chip[i].dev		= &pdev->dev;
-		gpio->chip[i].label		= clps711x_gpio_ports[i].name;
-		gpio->chip[i].base		= i * 8;
-		gpio->chip[i].ngpio		= clps711x_gpio_ports[i].nr;
-		gpio->chip[i].get		= gpio_clps711x_get;
-		gpio->chip[i].set		= gpio_clps711x_set;
-		if (!clps711x_gpio_ports[i].inv_dir) {
-			gpio->chip[i].direction_input = gpio_clps711x_dir_in;
-			gpio->chip[i].direction_output = gpio_clps711x_dir_out;
-		} else {
-			gpio->chip[i].direction_input = gpio_clps711x_dir_in_inv;
-			gpio->chip[i].direction_output = gpio_clps711x_dir_out_inv;
-		}
-		WARN_ON(gpiochip_add(&gpio->chip[i]));
-	}
-
-	dev_info(&pdev->dev, "GPIO driver initialized\n");
-
-	return 0;
-}
-arch_initcall(gpio_clps711x_init);
-
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
 MODULE_DESCRIPTION("CLPS711X GPIO driver");
-- 
1.8.1.5
