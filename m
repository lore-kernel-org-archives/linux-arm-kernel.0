From: lost.distance@yahoo.com (Paul Parsons)
Date: Thu, 11 Aug 2011 16:26:30 +0000
Subject: [PATCH v2 2/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x SSP/SPI)
	driver
Message-ID: <E1QrY5Y-00012n-7c@outmx01.plus.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Synaptics NavPoint connected to a PXA27x SSP port in SPI
slave mode. The driver implements a simple navigation pad. The four raised dots
are mapped to UP/DOWN/LEFT/RIGHT buttons and the centre of the touchpad is
mapped to the ENTER button.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---

V2: Split into 2 parts for hx4700 specific code and navpoint driver. Added
GPIO23_SSP1_SCLK_IN and GPIO102_NAVPOINT_PWR to mfp-pxa27x.h. Replaced power
on/off callback with gpio number. Added msleep() to SSP port ready loop.

diff -uprN clean-3.0.1/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h linux-3.0.1/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
--- clean-3.0.1/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h	2011-08-05 05:59:21.000000000 +0100
+++ linux-3.0.1/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h	2011-08-11 16:49:00.004450942 +0100
@@ -206,6 +206,7 @@
 #define GPIO113_I2S_SYSCLK	MFP_CFG_OUT(GPIO113, AF1, DRIVE_LOW)
 
 /* SSP 1 */
+#define GPIO23_SSP1_SCLK_IN	MFP_CFG_IN(GPIO23, AF2)
 #define GPIO23_SSP1_SCLK	MFP_CFG_OUT(GPIO23, AF2, DRIVE_LOW)
 #define GPIO29_SSP1_SCLK	MFP_CFG_IN(GPIO29, AF3)
 #define GPIO27_SSP1_SYSCLK	MFP_CFG_OUT(GPIO27, AF1, DRIVE_LOW)
@@ -434,6 +435,9 @@
 #define GPIO112_nMSINS		MFP_CFG_IN(GPIO112, AF2)
 #define GPIO32_MSSCLK		MFP_CFG_OUT(GPIO32, AF1, DRIVE_LOW)
 
+/* Touchpad Controller */
+#define GPIO102_NAVPOINT_PWR	MFP_CFG_OUT(GPIO102, AF0, DRIVE_LOW)
+
 /* commonly used pin configurations */
 #define GPIOxx_LCD_16BPP	\
 	GPIO58_LCD_LDD_0,	\
diff -uprN clean-3.0.1/drivers/input/mouse/Kconfig linux-3.0.1/drivers/input/mouse/Kconfig
--- clean-3.0.1/drivers/input/mouse/Kconfig	2011-08-05 05:59:21.000000000 +0100
+++ linux-3.0.1/drivers/input/mouse/Kconfig	2011-08-11 16:49:00.004450942 +0100
@@ -322,4 +322,14 @@ config MOUSE_SYNAPTICS_I2C
 	  To compile this driver as a module, choose M here: the
 	  module will be called synaptics_i2c.
 
+config MOUSE_NAVPOINT_PXA27x
+	bool "Synaptics NavPoint (PXA27x SSP/SPI)"
+	depends on PXA27x && PXA_SSP
+	help
+	  This option enables support for the Synaptics NavPoint connected to
+	  a PXA27x SSP port in SPI slave mode. The driver implements a simple
+	  navigation pad. The four raised dots are mapped to UP/DOWN/LEFT/RIGHT
+	  buttons and the centre of the touchpad is mapped to the ENTER button.
+	  Say Y to enable the Synaptics NavPoint on the HP iPAQ hx4700.
+
 endif
diff -uprN clean-3.0.1/drivers/input/mouse/Makefile linux-3.0.1/drivers/input/mouse/Makefile
--- clean-3.0.1/drivers/input/mouse/Makefile	2011-08-05 05:59:21.000000000 +0100
+++ linux-3.0.1/drivers/input/mouse/Makefile	2011-08-11 16:49:00.004450942 +0100
@@ -19,6 +19,7 @@ obj-$(CONFIG_MOUSE_RISCPC)		+= rpcmouse.
 obj-$(CONFIG_MOUSE_SERIAL)		+= sermouse.o
 obj-$(CONFIG_MOUSE_SYNAPTICS_I2C)	+= synaptics_i2c.o
 obj-$(CONFIG_MOUSE_VSXXXAA)		+= vsxxxaa.o
+obj-$(CONFIG_MOUSE_NAVPOINT_PXA27x)	+= navpoint.o
 
 psmouse-objs := psmouse-base.o synaptics.o
 
diff -uprN clean-3.0.1/drivers/input/mouse/navpoint.c linux-3.0.1/drivers/input/mouse/navpoint.c
--- clean-3.0.1/drivers/input/mouse/navpoint.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-3.0.1/drivers/input/mouse/navpoint.c	2011-08-11 16:50:35.093084330 +0100
@@ -0,0 +1,317 @@
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
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/input.h>
+#include <linux/input/navpoint.h>
+#include <linux/interrupt.h>
+#include <linux/pxa2xx_ssp.h>
+#include <linux/slab.h>
+
+/*
+ *	Synaptics NavPoint (PXA27x SSP/SPI) driver.
+ */
+
+struct driver_data {
+	struct ssp_device *ssp;
+	int		gpio;
+	struct input_dev *input;
+	int		index;
+	uint8_t		data[8];
+	int		pressed;	/* 1 = pressed, 0 = released */
+	unsigned	code;		/* Key code of the last key pressed */
+};
+
+static const u32 sscr0 = 0
+	| SSCR0_TUM		/* TIM = 1; No TUR interrupts */
+	| SSCR0_RIM		/* RIM = 1; No ROR interrupts */
+	| SSCR0_SSE		/* SSE = 1; SSP enabled */
+	| SSCR0_Motorola	/* FRF = 0; Motorola SPI */
+	| SSCR0_DataSize(16)	/* DSS = 15; Data size = 16-bit */
+	;
+static const u32 sscr1 = 0
+	| SSCR1_SCFR		/* SCFR = 1; SSPSCLK only during transfers */
+	| SSCR1_SCLKDIR		/* SCLKDIR = 1; Slave mode */
+	| SSCR1_SFRMDIR		/* SFRMDIR = 1; Slave mode */
+	| SSCR1_RWOT		/* RWOT = 1; Receive without transmit mode */
+	| SSCR1_RxTresh(1)	/* RFT = 0; Receive FIFO threshold = 1 */
+	| SSCR1_SPH		/* SPH = 1; SSPSCLK inactive 0.5 + 1 cycles */
+	| SSCR1_RIE		/* RIE = 1; Receive FIFO interrupt enabled */
+	;
+static const u32 sssr = 0
+	| SSSR_BCE		/* BCE = 1; Clear BCE */
+	| SSSR_TUR		/* TUR = 1; Clear TUR */
+	| SSSR_EOC		/* EOC = 1; Clear EOC */
+	| SSSR_TINT		/* TINT = 1; Clear TINT */
+	| SSSR_PINT		/* PINT = 1; Clear PINT */
+	| SSSR_ROR		/* ROR = 1; Clear ROR */
+	;
+
+/*
+ *	MEP Query $22: Touchpad Coordinate Range Query is not supported by
+ *	the NavPoint module, so sampled values provide the N/S/E/W limits.
+ */
+
+#define WEST	2416		/* 1/3 width */
+#define EAST	3904		/* 2/3 width */
+#define SOUTH	2480		/* 1/3 height */
+#define NORTH	3424		/* 2/3 height */
+
+static void navpoint_packet(void *dev)
+{
+	struct driver_data *drv_data;
+	int pressed;
+	unsigned x, y;
+	unsigned code;
+
+	drv_data = dev;
+
+	switch (drv_data->data[0]) {
+	case 0xff:	/* Garbage (packet?) between reset and Hello packet */
+	case 0x00:	/* Module 0, NULL packet */
+		break;
+	case 0x0e:	/* Module 0, Absolute packet */
+		pressed = (drv_data->data[1] & 0x01);
+		if ((drv_data->pressed ^ pressed) == 0)	/* No change */
+			break;
+		drv_data->pressed = pressed;
+		x = ((drv_data->data[2] & 0x1f) << 8) | drv_data->data[3];
+		y = ((drv_data->data[4] & 0x1f) << 8) | drv_data->data[5];
+		if (x < WEST)
+			code = KEY_LEFT;
+		else if (x > EAST)
+			code = KEY_RIGHT;
+		else if (y < SOUTH)
+			code = KEY_DOWN;
+		else if (y > NORTH)
+			code = KEY_UP;
+		else
+			code = KEY_ENTER;
+		if (pressed)
+			drv_data->code = code;
+		input_report_key(drv_data->input, drv_data->code, pressed);
+		input_sync(drv_data->input);
+		break;
+	case 0x19:	/* Module 0, Hello packet */
+		if ((drv_data->data[1] & 0xf0) == 0x10)
+			break;
+		/* FALLTHROUGH */
+	default:
+		dev_warn(dev, "spurious packet: 0x%02x,0x%02x,...\n",
+			drv_data->data[0],
+			drv_data->data[1]);
+		break;
+	}
+
+	drv_data->index = 0;
+}
+
+static irqreturn_t navpoint_int(int irq, void *dev)
+{
+	struct driver_data *drv_data;
+	struct ssp_device *ssp;
+	u32 status;
+	irqreturn_t ret;
+
+	drv_data = dev;
+	ssp = drv_data->ssp;
+
+	status = pxa_ssp_read_reg(ssp, SSSR);
+	ret = (status & (sssr | SSSR_RFS)) ? IRQ_HANDLED : IRQ_NONE;
+
+	if (status & sssr) {
+		dev_warn(dev, "spurious interrupt: 0x%02x\n", status);
+		pxa_ssp_write_reg(ssp, SSSR, (status & sssr));
+	}
+
+	while (status & SSSR_RNE) {
+		u32 data;
+
+		data = pxa_ssp_read_reg(ssp, SSDR);
+		drv_data->data[drv_data->index + 0] = (data >> 8);
+		drv_data->data[drv_data->index + 1] = data;
+		drv_data->index += 2;
+		if ((drv_data->data[0] & 0x07) < drv_data->index)
+			navpoint_packet(dev);
+		status = pxa_ssp_read_reg(ssp, SSSR);
+	}
+
+	return ret;
+}
+
+#ifdef CONFIG_SUSPEND
+int navpoint_suspend(struct device *dev)
+{
+	struct driver_data *drv_data;
+	struct ssp_device *ssp;
+
+	drv_data = dev_get_drvdata(dev);
+	ssp = drv_data->ssp;
+
+	if (drv_data->gpio)
+		gpio_set_value(drv_data->gpio, 0);
+
+	pxa_ssp_write_reg(ssp, SSCR0, 0);
+
+	clk_disable(ssp->clk);
+
+	return 0;
+}
+
+int navpoint_resume(struct device *dev)
+{
+	struct driver_data *drv_data;
+	struct ssp_device *ssp;
+
+	drv_data = dev_get_drvdata(dev);
+	ssp = drv_data->ssp;
+
+	clk_enable(ssp->clk);
+
+	pxa_ssp_write_reg(ssp, SSCR1, sscr1);
+	pxa_ssp_write_reg(ssp, SSSR, sssr);
+	pxa_ssp_write_reg(ssp, SSTO, 0);
+	pxa_ssp_write_reg(ssp, SSCR0, sscr0);	/* SSCR0_SSE written last */
+
+	if (drv_data->gpio)
+		gpio_set_value(drv_data->gpio, 1);
+
+	/* Wait until SSP port is ready for slave clock operations */
+	while (pxa_ssp_read_reg(ssp, SSSR) & SSSR_CSS)
+		msleep(1);
+
+	return 0;
+}
+
+static const struct dev_pm_ops navpoint_pm_ops = {
+	.suspend	= navpoint_suspend,
+	.resume		= navpoint_resume,
+};
+#endif
+
+static int __devinit navpoint_probe(struct platform_device *pdev)
+{
+	struct navpoint_platform_data *pdata = pdev->dev.platform_data;
+	int ret;
+	struct driver_data *drv_data;
+	struct ssp_device *ssp;
+	struct input_dev *input;
+
+	drv_data = kzalloc(sizeof(struct driver_data), GFP_KERNEL);
+	if (!drv_data) {
+		ret = -ENOMEM;
+		goto ret0;
+	}
+
+	ssp = pxa_ssp_request(pdata->port, pdev->name);
+	if (!ssp) {
+		ret = -ENODEV;
+		goto ret1;
+	}
+
+	ret = request_irq(ssp->irq, navpoint_int, 0, pdev->name, drv_data);
+	if (ret)
+		goto ret2;
+
+	input = input_allocate_device();
+	if (!input) {
+		ret = -ENOMEM;
+		goto ret3;
+	}
+	input->name = pdev->name;
+	__set_bit(EV_KEY, input->evbit);
+	__set_bit(KEY_ENTER, input->keybit);
+	__set_bit(KEY_UP, input->keybit);
+	__set_bit(KEY_LEFT, input->keybit);
+	__set_bit(KEY_RIGHT, input->keybit);
+	__set_bit(KEY_DOWN, input->keybit);
+	input->dev.parent = &pdev->dev;
+	ret = input_register_device(input);
+	if (ret)
+		goto ret4;
+
+	drv_data->ssp = ssp;
+	drv_data->gpio = pdata->gpio;
+	drv_data->input = input;
+
+	platform_set_drvdata(pdev, drv_data);
+
+	(void) navpoint_resume(&pdev->dev);
+
+	dev_info(&pdev->dev, "ssp%d, irq %d\n", pdata->port, ssp->irq);
+
+	return 0;
+
+ret4:
+	input_free_device(input);
+ret3:
+	free_irq(ssp->irq, drv_data);
+ret2:
+	pxa_ssp_free(ssp);
+ret1:
+	kfree(drv_data);
+ret0:
+	return ret;
+}
+
+static int __devexit navpoint_remove(struct platform_device *pdev)
+{
+	struct driver_data *drv_data;
+	struct ssp_device *ssp;
+	struct input_dev *input;
+
+	drv_data = platform_get_drvdata(pdev);
+	ssp = drv_data->ssp;
+	input = drv_data->input;
+
+	(void) navpoint_suspend(&pdev->dev);
+
+	input_unregister_device(input);
+
+	free_irq(ssp->irq, drv_data);
+
+	pxa_ssp_free(ssp);
+
+	kfree(drv_data);
+
+	return 0;
+}
+
+static struct platform_driver navpoint_driver = {
+	.probe		= navpoint_probe,
+	.remove		= __devexit_p(navpoint_remove),
+	.driver = {
+		.name	= "navpoint",
+		.owner	= THIS_MODULE,
+#ifdef CONFIG_SUSPEND
+		.pm	= &navpoint_pm_ops,
+#endif
+	},
+};
+
+static int __init navpoint_init(void)
+{
+	return platform_driver_register(&navpoint_driver);
+}
+
+static void __exit navpoint_exit(void)
+{
+	platform_driver_unregister(&navpoint_driver);
+}
+
+module_init(navpoint_init);
+module_exit(navpoint_exit);
+
+MODULE_AUTHOR("Paul Parsons <lost.distance@yahoo.com>");
+MODULE_DESCRIPTION("Synaptics NavPoint (PXA27x SSP/SPI) driver");
+MODULE_LICENSE("GPL");
diff -uprN clean-3.0.1/include/linux/input/navpoint.h linux-3.0.1/include/linux/input/navpoint.h
--- clean-3.0.1/include/linux/input/navpoint.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-3.0.1/include/linux/input/navpoint.h	2011-08-11 16:50:50.761188696 +0100
@@ -0,0 +1,12 @@
+/*
+ *  Copyright (C) 2011 Paul Parsons <lost.distance@yahoo.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+struct navpoint_platform_data {
+	int		port;		/* PXA SSP port for pxa_ssp_request() */
+	int		gpio;		/* GPIO for power on/off */
+};
