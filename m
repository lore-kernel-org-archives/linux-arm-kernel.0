From: lost.distance@yahoo.com (Paul Parsons)
Date: Tue, 26 Apr 2011 16:54:42 +0000
Subject: [PATCH] pxa/hx4700: Add hx4700 LED support
Message-ID: <E1QElXA-0006c4-DQ@outmx08.plus.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add hx4700 LED support. LED hx4700:amber blinks while the battery is charging. LED hx4700:green lights when the battery is full. LED hx4700:blue is a placeholder for absent bluetooth/wlan support. They are enabled via CONFIG_LEDS_ASIC3, and can be tested via /sys/class/leds.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---
diff -uprN clean-2.6.39-rc4/arch/arm/mach-pxa/hx4700.c linux-2.6.39-rc4/arch/arm/mach-pxa/hx4700.c
--- clean-2.6.39-rc4/arch/arm/mach-pxa/hx4700.c	2011-04-26 16:59:10.658257822 +0100
+++ linux-2.6.39-rc4/arch/arm/mach-pxa/hx4700.c	2011-04-26 17:01:27.402595767 +0100
@@ -23,6 +23,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/lcd.h>
+#include <linux/leds.h>
 #include <linux/mfd/htc-egpio.h>
 #include <linux/mfd/asic3.h>
 #include <linux/mtd/physmap.h>
@@ -801,6 +802,57 @@ static struct i2c_board_info __initdata 
 };
 
 /*
+ * LEDs
+ */
+
+#ifdef CONFIG_LEDS_ASIC3
+static struct asic3_led_platform_data asic3_led_info = {
+	.led0 = {
+		.name = "hx4700:amber",
+		.default_trigger = "ds2760-battery.0-charging",
+		.cdev = NULL,
+		.clock = ASIC3_CLOCK_LED0,
+		.base = ASIC3_LED_0_Base,
+		.timebase = (LED_EN|0x2),
+		.periodtime = 16,
+		.dutytime = 8,
+		.autostopcount = 0,
+	},
+	.led1 = {
+		.name = "hx4700:green",
+		.default_trigger = "ds2760-battery.0-full",
+		.cdev = NULL,
+		.clock = ASIC3_CLOCK_LED1,
+		.base = ASIC3_LED_1_Base,
+		.timebase = (LED_EN|0x0),
+		.periodtime = 16,
+		.dutytime = 16,
+		.autostopcount = 0,
+	},
+	.led2 = {
+		.name = "hx4700:blue",
+		.default_trigger = "hx4700-radio",
+		.cdev = NULL,
+		.clock = ASIC3_CLOCK_LED2,
+		.base = ASIC3_LED_2_Base,
+		.timebase = (LED_EN|0x0),
+		.periodtime = 16,
+		.dutytime = 16,
+		.autostopcount = 0,
+	},
+};
+
+static struct platform_device leds_asic3 = {
+	.name = "leds-asic3",
+	.id   = -1,
+	.dev  = {
+		.parent        = &asic3.dev,
+		.platform_data = &asic3_led_info,
+	},
+};
+#endif
+
+/*
  * PCMCIA
  */
 
@@ -826,6 +878,9 @@ static struct platform_device *devices[]
 	&gpio_vbus,
 	&power_supply,
 	&strataflash,
+#ifdef CONFIG_LEDS_ASIC3
+	&leds_asic3,
+#endif
 	&pcmcia,
 };
 
diff -uprN clean-2.6.39-rc4/drivers/leds/Kconfig linux-2.6.39-rc4/drivers/leds/Kconfig
--- clean-2.6.39-rc4/drivers/leds/Kconfig	2011-04-26 16:59:16.473163820 +0100
+++ linux-2.6.39-rc4/drivers/leds/Kconfig	2011-04-26 17:01:27.402595767 +0100
@@ -379,6 +379,13 @@ config LEDS_NETXBIG
 	  and 5Big Network v2 boards. The LEDs are wired to a CPLD and are
 	  controlled through a GPIO extension bus.
 
+config LEDS_ASIC3
+	bool "LED Support for the HTC ASIC3"
+	depends on MFD_ASIC3
+	default y
+	help
+	  This option enables support for the LEDs on the HTC ASIC3.
+
 config LEDS_TRIGGERS
 	bool "LED Trigger support"
 	depends on LEDS_CLASS
diff -uprN clean-2.6.39-rc4/drivers/leds/Makefile linux-2.6.39-rc4/drivers/leds/Makefile
--- clean-2.6.39-rc4/drivers/leds/Makefile	2011-04-26 16:59:16.473163820 +0100
+++ linux-2.6.39-rc4/drivers/leds/Makefile	2011-04-26 17:01:27.402595767 +0100
@@ -42,6 +42,7 @@ obj-$(CONFIG_LEDS_DELL_NETBOOKS)	+= dell
 obj-$(CONFIG_LEDS_MC13783)		+= leds-mc13783.o
 obj-$(CONFIG_LEDS_NS2)			+= leds-ns2.o
 obj-$(CONFIG_LEDS_NETXBIG)		+= leds-netxbig.o
+obj-$(CONFIG_LEDS_ASIC3)		+= leds-asic3.o
 
 # LED SPI Drivers
 obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
diff -uprN clean-2.6.39-rc4/drivers/leds/leds-asic3.c linux-2.6.39-rc4/drivers/leds/leds-asic3.c
--- clean-2.6.39-rc4/drivers/leds/leds-asic3.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.39-rc4/drivers/leds/leds-asic3.c	2011-04-26 17:01:40.797289761 +0100
@@ -0,0 +1,151 @@
+/*
+ *  Copyright (C) 2011 Paul Parsons <lost.distance@yahoo.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/leds.h>
+#include <linux/slab.h>
+
+#include <linux/mfd/asic3.h>
+
+/*
+ *	The HTC ASIC3 LED GPIOs are inputs, not outputs.
+ *	Hence we turn the LEDs on/off via the TimeBase register.
+ */
+
+static void asic3_led_set(struct led_classdev *led_cdev, enum led_brightness value)
+{
+	struct platform_device *pdev = to_platform_device(led_cdev->dev->parent);
+	struct asic3 *asic = dev_get_drvdata(pdev->dev.parent);
+	struct asic3_led_platform_data *pdata = pdev->dev.platform_data;
+	struct asic3_led *led;
+	unsigned timebase;
+
+	if (led_cdev == pdata->led0.cdev)
+		led = &pdata->led0;
+	else if (led_cdev == pdata->led1.cdev)
+		led = &pdata->led1;
+	else if (led_cdev == pdata->led2.cdev)
+		led = &pdata->led2;
+	else
+		return;		/* NOTREACHED */
+
+	timebase = (value == LED_OFF) ? 0 : led->timebase;
+	asic3_write_register(asic, (led->base+ASIC3_LED_TimeBase), timebase);
+}
+
+static int __devinit led_init(
+	struct platform_device *pdev,
+	struct asic3 *asic,
+	struct asic3_led *led)
+{
+	int ret;
+
+	led->cdev = kzalloc(sizeof(struct led_classdev), GFP_KERNEL);
+	if (! led->cdev)
+		return (-ENOMEM);
+
+	led->cdev->name = led->name;
+	led->cdev->default_trigger = led->default_trigger;
+	led->cdev->brightness_set = asic3_led_set;
+
+	ret = led_classdev_register(&pdev->dev, led->cdev);
+	if (ret < 0) {
+		kfree(led->cdev);
+		return (ret);
+	}
+
+	asic3_clk_enable(asic, led->clock);
+
+	asic3_write_register(asic, (led->base+ASIC3_LED_PeriodTime), led->periodtime);
+	asic3_write_register(asic, (led->base+ASIC3_LED_DutyTime), led->dutytime);
+	asic3_write_register(asic, (led->base+ASIC3_LED_AutoStopCount), led->autostopcount);
+	asic3_write_register(asic, (led->base+ASIC3_LED_TimeBase), 0);	/* disable */
+
+	return (0);
+}
+
+static void led_term(struct asic3 *asic, struct asic3_led *led)
+{
+	asic3_write_register(asic, (led->base+ASIC3_LED_TimeBase), 0);	/* disable */
+
+	asic3_clk_disable(asic, led->clock);
+
+	led_classdev_unregister(led->cdev);
+
+	kfree(led->cdev);
+}
+
+static int __devinit asic3_led_probe(struct platform_device *pdev)
+{
+	struct asic3 *asic = dev_get_drvdata(pdev->dev.parent);
+	struct asic3_led_platform_data *pdata = pdev->dev.platform_data;
+	int ret;
+
+	ret = led_init(pdev, asic, &pdata->led0);
+	if (ret < 0)
+		goto out0;
+
+	ret = led_init(pdev, asic, &pdata->led1);
+	if (ret < 0)
+		goto out1;
+
+	ret = led_init(pdev, asic, &pdata->led2);
+	if (ret < 0)
+		goto out2;
+
+	return (ret);
+
+out2:
+	led_term(asic, &pdata->led1);
+out1:
+	led_term(asic, &pdata->led0);
+out0:
+	return (ret);
+}
+
+static int __devexit asic3_led_remove(struct platform_device *pdev)
+{
+	struct asic3 *asic = dev_get_drvdata(pdev->dev.parent);
+	struct asic3_led_platform_data *pdata = pdev->dev.platform_data;
+
+	led_term(asic, &pdata->led2);
+	led_term(asic, &pdata->led1);
+	led_term(asic, &pdata->led0);
+
+	return (0);
+}
+
+static struct platform_driver asic3_led_driver = {
+	.probe		= asic3_led_probe,
+	.remove		= __devexit_p(asic3_led_remove),
+	.driver		= {
+		.name	= "leds-asic3",
+		.owner	= THIS_MODULE,
+	},
+};
+
+MODULE_ALIAS("platform:leds-asic3");
+
+static int __init asic3_led_init(void)
+{
+	return platform_driver_register(&asic3_led_driver);
+}
+
+static void __exit asic3_led_exit(void)
+{
+	platform_driver_unregister(&asic3_led_driver);
+}
+
+module_init(asic3_led_init);
+module_exit(asic3_led_exit);
+
+MODULE_AUTHOR("Paul Parsons <lost.distance@yahoo.com>");
+MODULE_DESCRIPTION("HTC ASIC3 LED driver");
+MODULE_LICENSE("GPL");
diff -uprN clean-2.6.39-rc4/drivers/mfd/asic3.c linux-2.6.39-rc4/drivers/mfd/asic3.c
--- clean-2.6.39-rc4/drivers/mfd/asic3.c	2011-04-26 16:59:18.330091819 +0100
+++ linux-2.6.39-rc4/drivers/mfd/asic3.c	2011-04-26 17:01:27.402595767 +0100
@@ -30,21 +30,6 @@
 #include <linux/mfd/ds1wm.h>
 #include <linux/mfd/tmio.h>
 
-enum {
-	ASIC3_CLOCK_SPI,
-	ASIC3_CLOCK_OWM,
-	ASIC3_CLOCK_PWM0,
-	ASIC3_CLOCK_PWM1,
-	ASIC3_CLOCK_LED0,
-	ASIC3_CLOCK_LED1,
-	ASIC3_CLOCK_LED2,
-	ASIC3_CLOCK_SD_HOST,
-	ASIC3_CLOCK_SD_BUS,
-	ASIC3_CLOCK_SMBUS,
-	ASIC3_CLOCK_EX0,
-	ASIC3_CLOCK_EX1,
-};
-
 struct asic3_clk {
 	int enabled;
 	unsigned int cdex;
@@ -88,19 +73,19 @@ struct asic3 {
 
 static int asic3_gpio_get(struct gpio_chip *chip, unsigned offset);
 
-static inline void asic3_write_register(struct asic3 *asic,
-				 unsigned int reg, u32 value)
+void asic3_write_register(struct asic3 *asic, unsigned int reg, u32 value)
 {
 	iowrite16(value, asic->mapping +
 		  (reg >> asic->bus_shift));
 }
+EXPORT_SYMBOL_GPL(asic3_write_register);
 
-static inline u32 asic3_read_register(struct asic3 *asic,
-			       unsigned int reg)
+u32 asic3_read_register(struct asic3 *asic, unsigned int reg)
 {
 	return ioread16(asic->mapping +
 			(reg >> asic->bus_shift));
 }
+EXPORT_SYMBOL_GPL(asic3_read_register);
 
 static void asic3_set_register(struct asic3 *asic, u32 reg, u32 bits, bool set)
 {
@@ -584,11 +569,13 @@ static int asic3_gpio_remove(struct plat
 	return gpiochip_remove(&asic->gpio);
 }
 
-static int asic3_clk_enable(struct asic3 *asic, struct asic3_clk *clk)
+void asic3_clk_enable(struct asic3 *asic, enum asic3_clock clock)
 {
+	struct asic3_clk *clk;
 	unsigned long flags;
 	u32 cdex;
 
+	clk = &asic->clocks[clock];
 	spin_lock_irqsave(&asic->lock, flags);
 	if (clk->enabled++ == 0) {
 		cdex = asic3_read_register(asic, ASIC3_OFFSET(CLOCK, CDEX));
@@ -596,15 +583,16 @@ static int asic3_clk_enable(struct asic3
 		asic3_write_register(asic, ASIC3_OFFSET(CLOCK, CDEX), cdex);
 	}
 	spin_unlock_irqrestore(&asic->lock, flags);
-
-	return 0;
 }
+EXPORT_SYMBOL_GPL(asic3_clk_enable);
 
-static void asic3_clk_disable(struct asic3 *asic, struct asic3_clk *clk)
+void asic3_clk_disable(struct asic3 *asic, enum asic3_clock clock)
 {
+	struct asic3_clk *clk;
 	unsigned long flags;
 	u32 cdex;
 
+	clk = &asic->clocks[clock];
 	WARN_ON(clk->enabled == 0);
 
 	spin_lock_irqsave(&asic->lock, flags);
@@ -615,6 +603,7 @@ static void asic3_clk_disable(struct asi
 	}
 	spin_unlock_irqrestore(&asic->lock, flags);
 }
+EXPORT_SYMBOL_GPL(asic3_clk_disable);
 
 /* MFD cells (SPI, PWM, LED, DS1WM, MMC) */
 static struct ds1wm_driver_data ds1wm_pdata = {
@@ -639,9 +628,9 @@ static int ds1wm_enable(struct platform_
 	struct asic3 *asic = dev_get_drvdata(pdev->dev.parent);
 
 	/* Turn on external clocks and the OWM clock */
-	asic3_clk_enable(asic, &asic->clocks[ASIC3_CLOCK_EX0]);
-	asic3_clk_enable(asic, &asic->clocks[ASIC3_CLOCK_EX1]);
-	asic3_clk_enable(asic, &asic->clocks[ASIC3_CLOCK_OWM]);
+	asic3_clk_enable(asic, ASIC3_CLOCK_EX0);
+	asic3_clk_enable(asic, ASIC3_CLOCK_EX1);
+	asic3_clk_enable(asic, ASIC3_CLOCK_OWM);
 	msleep(1);
 
 	/* Reset and enable DS1WM */
@@ -665,9 +654,9 @@ static int ds1wm_disable(struct platform
 	asic3_set_register(asic, ASIC3_OFFSET(EXTCF, SELECT),
 			   ASIC3_EXTCF_OWM_EN, 0);
 
-	asic3_clk_disable(asic, &asic->clocks[ASIC3_CLOCK_OWM]);
-	asic3_clk_disable(asic, &asic->clocks[ASIC3_CLOCK_EX0]);
-	asic3_clk_disable(asic, &asic->clocks[ASIC3_CLOCK_EX1]);
+	asic3_clk_disable(asic, ASIC3_CLOCK_OWM);
+	asic3_clk_disable(asic, ASIC3_CLOCK_EX0);
+	asic3_clk_disable(asic, ASIC3_CLOCK_EX1);
 
 	return 0;
 }
@@ -728,19 +717,19 @@ static int asic3_mmc_enable(struct platf
 	asic3_set_register(asic, ASIC3_OFFSET(SDHWCTRL, SDCONF),
 			   ASIC3_SDHWCTRL_PCLR, 0);
 
-	asic3_clk_enable(asic, &asic->clocks[ASIC3_CLOCK_EX0]);
+	asic3_clk_enable(asic, ASIC3_CLOCK_EX0);
 	/* CLK32 used for card detection and for interruption detection
 	 * when HCLK is stopped.
 	 */
-	asic3_clk_enable(asic, &asic->clocks[ASIC3_CLOCK_EX1]);
+	asic3_clk_enable(asic, ASIC3_CLOCK_EX1);
 	msleep(1);
 
 	/* HCLK 24.576 MHz, BCLK 12.288 MHz: */
 	asic3_write_register(asic, ASIC3_OFFSET(CLOCK, SEL),
 		CLOCK_SEL_CX | CLOCK_SEL_SD_HCLK_SEL);
 
-	asic3_clk_enable(asic, &asic->clocks[ASIC3_CLOCK_SD_HOST]);
-	asic3_clk_enable(asic, &asic->clocks[ASIC3_CLOCK_SD_BUS]);
+	asic3_clk_enable(asic, ASIC3_CLOCK_SD_HOST);
+	asic3_clk_enable(asic, ASIC3_CLOCK_SD_BUS);
 	msleep(1);
 
 	asic3_set_register(asic, ASIC3_OFFSET(EXTCF, SELECT),
@@ -766,10 +755,10 @@ static int asic3_mmc_disable(struct plat
 			   ASIC3_SDHWCTRL_SUSPEND, 1);
 
 	/* Disable clocks */
-	asic3_clk_disable(asic, &asic->clocks[ASIC3_CLOCK_SD_HOST]);
-	asic3_clk_disable(asic, &asic->clocks[ASIC3_CLOCK_SD_BUS]);
-	asic3_clk_disable(asic, &asic->clocks[ASIC3_CLOCK_EX0]);
-	asic3_clk_disable(asic, &asic->clocks[ASIC3_CLOCK_EX1]);
+	asic3_clk_disable(asic, ASIC3_CLOCK_SD_HOST);
+	asic3_clk_disable(asic, ASIC3_CLOCK_SD_BUS);
+	asic3_clk_disable(asic, ASIC3_CLOCK_EX0);
+	asic3_clk_disable(asic, ASIC3_CLOCK_EX1);
 	return 0;
 }
 
@@ -883,6 +872,7 @@ static int __init asic3_probe(struct pla
 		goto out_unmap;
 	}
 
+	asic->gpio.label = "asic3";
 	asic->gpio.base = pdata->gpio_base;
 	asic->gpio.ngpio = ASIC3_NUM_GPIOS;
 	asic->gpio.get = asic3_gpio_get;
diff -uprN clean-2.6.39-rc4/include/linux/mfd/asic3.h linux-2.6.39-rc4/include/linux/mfd/asic3.h
--- clean-2.6.39-rc4/include/linux/mfd/asic3.h	2011-03-15 01:20:32.000000000 +0000
+++ linux-2.6.39-rc4/include/linux/mfd/asic3.h	2011-04-26 17:01:27.402595767 +0100
@@ -111,9 +111,9 @@ struct asic3_platform_data {
 #define ASIC3_GPIOA11_PWM0		ASIC3_CONFIG_GPIO(11, 1, 1, 0)
 #define ASIC3_GPIOA12_PWM1		ASIC3_CONFIG_GPIO(12, 1, 1, 0)
 #define ASIC3_GPIOA15_CONTROL_CX	ASIC3_CONFIG_GPIO(15, 1, 1, 0)
-#define ASIC3_GPIOC0_LED0		ASIC3_CONFIG_GPIO(32, 1, 1, 0)
-#define ASIC3_GPIOC1_LED1		ASIC3_CONFIG_GPIO(33, 1, 1, 0)
-#define ASIC3_GPIOC2_LED2		ASIC3_CONFIG_GPIO(34, 1, 1, 0)
+#define ASIC3_GPIOC0_LED0		ASIC3_CONFIG_GPIO(32, 1, 0, 0)
+#define ASIC3_GPIOC1_LED1		ASIC3_CONFIG_GPIO(33, 1, 0, 0)
+#define ASIC3_GPIOC2_LED2		ASIC3_CONFIG_GPIO(34, 1, 0, 0)
 #define ASIC3_GPIOC3_SPI_RXD		ASIC3_CONFIG_GPIO(35, 1, 0, 0)
 #define ASIC3_GPIOC4_CF_nCD		ASIC3_CONFIG_GPIO(36, 1, 0, 0)
 #define ASIC3_GPIOC4_SPI_TXD		ASIC3_CONFIG_GPIO(36, 1, 1, 0)
@@ -171,6 +171,40 @@ struct asic3_platform_data {
 #define LED_AUTOSTOP	(1 << 5) /* LED ON/OFF auto stop 0:disable, 1:enable */
 #define LED_ALWAYS	(1 << 6) /* LED Interrupt Mask 0:No mask, 1:mask */
 
+struct led_classdev;
+struct asic3_led {
+	const char	*name;
+	const char	*default_trigger;
+	struct led_classdev *cdev;
+	int		clock;          /* ASIC3_CLOCK_LED? */
+	unsigned	base;           /* ASIC3_LED_?_Base */
+	unsigned 	timebase;       /* ASIC3_LED_TimeBase */
+	unsigned	periodtime;     /* ASIC3_LED_PeriodTime */
+	unsigned	dutytime;       /* ASIC3_LED_DutyTime */
+	unsigned	autostopcount;  /* ASIC3_LED_AutoStopCount */
+};
+
+struct asic3_led_platform_data {
+	struct asic3_led led0;          /* LED0 */
+	struct asic3_led led1;          /* LED1 */
+	struct asic3_led led2;          /* LED2 */
+};
+
+enum asic3_clock {
+	ASIC3_CLOCK_SPI,
+	ASIC3_CLOCK_OWM,
+	ASIC3_CLOCK_PWM0,
+	ASIC3_CLOCK_PWM1,
+	ASIC3_CLOCK_LED0,
+	ASIC3_CLOCK_LED1,
+	ASIC3_CLOCK_LED2,
+	ASIC3_CLOCK_SD_HOST,
+	ASIC3_CLOCK_SD_BUS,
+	ASIC3_CLOCK_SMBUS,
+	ASIC3_CLOCK_EX0,
+	ASIC3_CLOCK_EX1,
+};
+
 #define ASIC3_CLOCK_BASE	   0x0A00
 #define ASIC3_CLOCK_CDEX           0x00
 #define ASIC3_CLOCK_SEL            0x04
@@ -293,4 +327,12 @@ struct asic3_platform_data {
 #define ASIC3_MAP_SIZE_32BIT	0x2000
 #define ASIC3_MAP_SIZE_16BIT	0x1000
 
+/* Functions needed by leds-asic3 */
+
+struct asic3;
+extern void asic3_write_register(struct asic3 *asic, unsigned int reg, u32 value);
+extern u32 asic3_read_register(struct asic3 *asic, unsigned int reg);
+extern void asic3_clk_enable(struct asic3 *asic, enum asic3_clock clock);
+extern void asic3_clk_disable(struct asic3 *asic, enum asic3_clock clock);
+
 #endif /* __ASIC3_H__ */
