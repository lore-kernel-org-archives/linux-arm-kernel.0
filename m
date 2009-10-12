From: cgagneraud@techworks.ie (Christian Gagneraud)
Date: Mon, 12 Oct 2009 15:24:14 +0100
Subject: [RFC PATCH v1] EP93XX: Add ADC support
Message-ID: <20091012142413.30881.62391.stgit@archeopterix.techworks.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add support for the ADC found in the EP93XX.

This work is based on S3C platform ADC, apart from hardware related
stuff, the following modifications have been done:
- Remove touchscreen support:
  On S3C the TS is a "normal" ADC client, but it has priority over all
  other clients. On EP93XX the TS controller is built-in and offer
  advanced features.
- Remove convert and select callbacks:
  This was done for the shake of simplicity, it can be added easily.
- Channel definition:
  On S3c, channel is just an index (unsigned char). On EP93xx channel
  is the analog switch configuration (unsigned long), it gives the
  client full freedom on how to make the analog conversion (including
  routing VRef+ and VRef-, activationg PU/PD resistors, connecting
  pins to VDD/GND, ...)


This is a first draft. Comments and criticism welcome.

Signed-off-by: Christian Gagneraud <cgagneraud@techworks.ie>
---

 arch/arm/mach-ep93xx/Makefile                   |    2 
 arch/arm/mach-ep93xx/adc.c                      |  415 +++++++++++++++++++++++
 arch/arm/mach-ep93xx/clock.c                    |    7 
 arch/arm/mach-ep93xx/core.c                     |   31 ++
 arch/arm/mach-ep93xx/include/mach/adc.h         |   54 +++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |   21 +
 arch/arm/mach-ep93xx/include/mach/hwmon.h       |   43 ++
 arch/arm/mach-ep93xx/ts72xx.c                   |   78 ++++
 drivers/hwmon/Kconfig                           |   17 +
 drivers/hwmon/Makefile                          |    1 
 drivers/hwmon/ep93xx-hwmon.c                    |  416 +++++++++++++++++++++++
 11 files changed, 1083 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-ep93xx/adc.c
 create mode 100644 arch/arm/mach-ep93xx/include/mach/adc.h
 create mode 100644 arch/arm/mach-ep93xx/include/mach/hwmon.h
 create mode 100644 drivers/hwmon/ep93xx-hwmon.c

diff --git a/arch/arm/mach-ep93xx/Makefile b/arch/arm/mach-ep93xx/Makefile
index eae6199..e3c62fe 100644
--- a/arch/arm/mach-ep93xx/Makefile
+++ b/arch/arm/mach-ep93xx/Makefile
@@ -6,6 +6,8 @@ obj-m			:=
 obj-n			:=
 obj-			:=
 
+obj-$(CONFIG_EP93XX_ADC)	+= adc.o
+
 obj-$(CONFIG_MACH_ADSSPHERE)	+= adssphere.o
 obj-$(CONFIG_MACH_EDB93XX)	+= edb93xx.o
 obj-$(CONFIG_MACH_GESBC9312)	+= gesbc9312.o
diff --git a/arch/arm/mach-ep93xx/adc.c b/arch/arm/mach-ep93xx/adc.c
new file mode 100644
index 0000000..78dc074
--- /dev/null
+++ b/arch/arm/mach-ep93xx/adc.c
@@ -0,0 +1,415 @@
+/*
+ * arch/arm/mach-ep93xx/adc.c
+ *
+ * ADC support for Cirrus EP93xx chips.
+ *
+ * Copyright (C) 2009 Christian Gagneraud <cgagneraud@techworks.ie>
+ *
+ * Based on arch/arm/plat-s3c24xx/adc.c by Simtec Electronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ */
+        
+/*
+ * Touchscreen and Direct ADC:
+ *
+ * +------------------------+-----+-----+-----+-----+ 
+ * |ADC/TS driver in use    | n/n | y/n | n/y | y/y | 
+ * +------------------------+-----+-----+-----+-----+
+ * |SYSCON_DEVCFG_ADCPD     |  1  |  0  |  0  |  0  |
+ * |SYSCON_DEVCFG_TIN       |  X  |  1  |  0  | 1/0 |
+ * |SYSCON_KEYTCHCLKDIV_TSEN|  0  |  1  |  1  |  1  |
+ * |TS_SETUP_ENABLE (*)     |  0  |  0  |  1  | 0/1 |
+ * +------------------------+-----+-----+-----+-----+
+ * (*) 
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/list.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
+
+#include <mach/hardware.h>
+
+static inline void ep93xx_adc_set_reg(void __iomem *reg,
+                                      unsigned long val)
+{	
+	__raw_writel(EP93XX_TS_SWLOCK_UNLOCK, EP93XX_TS_SWLOCK);
+	__raw_writel(val, reg);
+}
+
+static inline void ep93xx_adc_clr_reg_bits(void __iomem *reg,
+                                           unsigned long bits)
+{
+	unsigned long val = __raw_readl(reg);
+	val &= ~bits;
+	ep93xx_adc_set_reg(reg,val);
+}
+
+static inline void ep93xx_adc_set_reg_bits(void __iomem *reg,
+                                           unsigned long bits)
+{
+	unsigned long val = __raw_readl(reg);
+	val |= bits;
+	ep93xx_adc_set_reg(reg,val);
+}
+
+struct ep93xx_adc_client {
+	struct platform_device *pdev;
+	struct list_head pend;
+	wait_queue_head_t *wait;
+	unsigned int nr_samples;
+	int result;
+	unsigned int channel;
+};
+
+struct adc_device {
+	struct platform_device *pdev;
+	struct platform_device *owner;
+	struct clk *clk;
+	struct ep93xx_adc_client *cur;
+	void __iomem *regs;
+	int irq;
+	unsigned int refm;              /* Reading when Vin = Vref- */
+	unsigned int refp;              /* Reading when Vin = Vref+ */
+};
+
+static struct adc_device *adc_dev;
+
+static LIST_HEAD(adc_pending);
+
+#define adc_dbg(_adc, msg...) dev_dbg(&(_adc)->pdev->dev, msg)
+
+static inline void ep93xx_adc_convert(struct adc_device *adc)
+{
+	unsigned long prev_switch;
+	unsigned long next_switch;
+
+	/* Configure the switches */
+	prev_switch = __raw_readl(EP93XX_TS_DIRECT);
+	next_switch = adc->cur->channel;
+	if (next_switch != prev_switch) {
+		ep93xx_adc_set_reg(EP93XX_TS_DIRECT, next_switch);
+		/* Channel switch settling time */
+		/* TODO: depends on clock speed (500us or 2ms) */
+		/* FIXME: the caller has disabled interrupts and the
+		 * caller can even be the irq handler. Should we
+		 * better fire a timer? */
+		mdelay(2);
+	}
+
+	/* Fire ADC engine with Sync Data Ready IRQ enabled */
+	ep93xx_adc_set_reg_bits(EP93XX_TS_SETUP2, EP93XX_TS_SETUP2_RINTEN);
+	__raw_readl(EP93XX_TS_XYRESULT);
+}
+
+static void ep93xx_adc_try(struct adc_device *adc)
+{
+	struct ep93xx_adc_client *next;
+
+	if (!list_empty(&adc_pending)) {
+		next = list_first_entry(&adc_pending,
+					struct ep93xx_adc_client, pend);
+		list_del(&next->pend);
+		adc_dbg(adc, "new client is %p\n", next);
+		adc->cur = next;
+		ep93xx_adc_convert(adc);
+	}
+}
+
+int ep93xx_adc_start(struct ep93xx_adc_client *client,
+		     unsigned long channel, unsigned int nr_samples)
+{
+	struct adc_device *adc = adc_dev;
+	unsigned long flags;
+
+	if (!adc) {
+		printk(KERN_ERR "%s: failed to find adc\n", __func__);
+		return -EINVAL;
+	}
+
+	local_irq_save(flags);
+
+	client->channel = channel;
+	client->nr_samples = nr_samples;
+
+	list_add_tail(&client->pend, &adc_pending);
+
+	if (!adc->cur)
+		ep93xx_adc_try(adc);
+	local_irq_restore(flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ep93xx_adc_start);
+
+static void ep93xx_convert_done(struct ep93xx_adc_client *client,
+				unsigned val, unsigned *left)
+{
+	client->result = val;
+	wake_up(client->wait);
+}
+
+int ep93xx_adc_read(struct ep93xx_adc_client *client, unsigned int ch)
+{
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wake);
+	int ret;
+
+	client->wait = &wake;
+	client->result = -1;
+
+	ret = ep93xx_adc_start(client, ch, 1);
+	if (ret < 0)
+		goto err;
+
+	ret = wait_event_timeout(wake, client->result >= 0, HZ / 2);
+	if (client->result < 0) {
+		ret = -ETIMEDOUT;
+		goto err;
+	}
+
+	return client->result;
+      err:
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(ep93xx_adc_convert);
+
+struct ep93xx_adc_client *ep93xx_adc_register(struct platform_device *pdev)
+{
+	struct ep93xx_adc_client *client;
+
+	printk("adc_register: %s\n", pdev->name);
+
+	WARN_ON(!pdev);
+
+	if (!pdev)
+		return ERR_PTR(-EINVAL);
+
+	client = kzalloc(sizeof(struct ep93xx_adc_client), GFP_KERNEL);
+	if (!client) {
+		dev_err(&pdev->dev, "no memory for adc client\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	client->pdev = pdev;
+
+	return client;
+}
+
+EXPORT_SYMBOL_GPL(ep93xx_adc_register);
+
+void ep93xx_adc_release(struct ep93xx_adc_client *client)
+{
+	struct list_head *p, *n;
+	struct ep93xx_adc_client *tmp;
+
+	/* We should really check that nothing is in progress. */
+	if (adc_dev->cur == client)
+		adc_dev->cur = NULL;
+
+	list_for_each_safe(p, n, &adc_pending) {
+		tmp = list_entry(p, struct ep93xx_adc_client, pend);
+		if (tmp == client)
+			list_del(&tmp->pend);
+	}
+
+	if (adc_dev->cur == NULL)
+		ep93xx_adc_try(adc_dev);
+	kfree(client);
+}
+
+EXPORT_SYMBOL_GPL(ep93xx_adc_release);
+
+static irqreturn_t ep93xx_adc_irq(int irq, void *pw)
+{
+	struct adc_device *adc = pw;
+	struct ep93xx_adc_client *client = adc->cur;
+	unsigned long flags;
+	unsigned long data;
+
+	if (!client) {
+		dev_warn(&adc->pdev->dev, "%s: no adc pending\n",
+			 __func__);
+		return IRQ_HANDLED;
+	}
+
+	/* Read and convert data */
+	data = __raw_readl(EP93XX_TS_XYRESULT);
+	data &= 0x0000FFFF;
+	if (data < 0x7000)
+		data += 0x10000;
+	data -= adc->refm;
+
+	client->nr_samples--;
+
+	ep93xx_convert_done(client, data, &client->nr_samples);
+
+	/* If all samples are done, disable IRQ, and kick start the next
+	 * one if any. */
+	if (client->nr_samples == 0) {
+		local_irq_save(flags);
+		adc->cur = NULL;
+		ep93xx_adc_clr_reg_bits(EP93XX_TS_SETUP2,
+                                        EP93XX_TS_SETUP2_RINTEN);
+		ep93xx_adc_try(adc);
+		local_irq_restore(flags);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int ep93xx_adc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct adc_device *adc;
+	struct resource *regs;
+	int ret;
+
+	printk("adc_probe: %s\n", pdev->name);
+
+	adc = kzalloc(sizeof(struct adc_device), GFP_KERNEL);
+	if (adc == NULL) {
+		dev_err(dev, "failed to allocate adc_device\n");
+		return -ENOMEM;
+	}
+
+	adc->pdev = pdev;
+
+	adc->irq = platform_get_irq(pdev, 0);
+	if (adc->irq <= 0) {
+		dev_err(dev, "failed to get adc irq\n");
+		ret = -ENOENT;
+		goto err_alloc;
+	}
+
+	ret = request_irq(adc->irq, ep93xx_adc_irq, IRQF_DISABLED,
+			  dev_name(dev), adc);
+	if (ret < 0) {
+		dev_err(dev, "failed to attach adc irq\n");
+		goto err_alloc;
+	}
+
+	adc->clk = clk_get(dev, "ep93xx-analog");
+	if (IS_ERR(adc->clk)) {
+		dev_err(dev, "failed to get ADC clock\n");
+		ret = PTR_ERR(adc->clk);
+		goto err_irq;
+	}
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs) {
+		dev_err(dev, "failed to find registers\n");
+		ret = -ENXIO;
+		goto err_clk;
+	}
+
+	adc->regs = ioremap(regs->start, resource_size(regs));
+	if (!adc->regs) {
+		dev_err(dev, "failed to map registers\n");
+		ret = -ENXIO;
+		goto err_clk;
+	}
+
+	clk_enable(adc->clk);
+
+	// Enable ADC, inactivate TS controller
+	ep93xx_devcfg_set_clear(EP93XX_SYSCON_DEVCFG_TIN,
+				EP93XX_SYSCON_DEVCFG_ADCPD);
+	// Disable TS engine
+	ep93xx_adc_clr_reg_bits(EP93XX_TS_SETUP, EP93XX_TS_SETUP_ENABLE);
+	// Set ADC to signed mode
+	ep93xx_adc_clr_reg_bits(EP93XX_TS_SETUP2, EP93XX_TS_SETUP2_NSIGND);
+
+	dev_info(dev, "attached adc driver\n");
+
+	platform_set_drvdata(pdev, adc);
+
+	/* Defaults from datasheet (approximated values) */
+	adc->refm = 0xFFFF - 25000;
+	adc->refp = 25000;
+	adc_dev = adc;
+
+	return 0;
+
+      err_clk:
+	clk_put(adc->clk);
+
+      err_irq:
+	free_irq(adc->irq, adc);
+
+      err_alloc:
+	kfree(adc);
+	return ret;
+
+}
+
+static int ep93xx_adc_remove(struct platform_device *pdev)
+{
+	struct adc_device *adc = platform_get_drvdata(pdev);
+
+	iounmap(adc->regs);
+	free_irq(adc->irq, adc);
+	clk_disable(adc->clk);
+	clk_put(adc->clk);
+	kfree(adc);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int ep93xx_adc_suspend(struct platform_device *pdev,
+			      pm_message_t state)
+{
+	struct adc_device *adc = platform_get_drvdata(pdev);
+	ep93xx_devcfg_clear(EP93XX_SYSCON_DEVCFG_ADCPD);
+	clk_disable(adc->clk);
+	return 0;
+}
+
+static int ep93xx_adc_resume(struct platform_device *pdev)
+{
+	struct adc_device *adc = platform_get_drvdata(pdev);
+	clk_enable(adc->clk);
+	ep93xx_devcfg_set(EP93XX_SYSCON_DEVCFG_ADCPD);
+	return 0;
+}
+
+#else
+#define ep93xx_adc_suspend NULL
+#define ep93xx_adc_resume NULL
+#endif
+
+static struct platform_driver ep93xx_adc_driver = {
+	.driver = {
+		   .name = "ep93xx-analog",
+		   .owner = THIS_MODULE,
+		   },
+	.probe = ep93xx_adc_probe,
+	.remove = __devexit_p(ep93xx_adc_remove),
+	.suspend = ep93xx_adc_suspend,
+	.resume = ep93xx_adc_resume,
+};
+
+static int __init adc_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&ep93xx_adc_driver);
+	if (ret)
+		printk(KERN_ERR "%s: failed to add adc driver\n",
+		       __func__);
+
+	return ret;
+}
+
+arch_initcall(adc_init);
diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index dda19cd..d604e37 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -72,6 +72,12 @@ static struct clk clk_keypad = {
 	.enable_mask	= EP93XX_SYSCON_KEYTCHCLKDIV_KEN,
 	.set_rate	= set_keytchclk_rate,
 };
+static struct clk clk_analog = {
+	.sw_locked	= 1,
+	.enable_reg	= EP93XX_SYSCON_KEYTCHCLKDIV,
+	.enable_mask	= EP93XX_SYSCON_KEYTCHCLKDIV_TSEN,
+	.set_rate	= set_keytchclk_rate,
+};
 static struct clk clk_pwm = {
 	.rate		= EP93XX_EXT_CLK_RATE,
 };
@@ -147,6 +153,7 @@ static struct clk_lookup clocks[] = {
 	INIT_CK(NULL,			"pll2",		&clk_pll2),
 	INIT_CK("ep93xx-ohci",		NULL,		&clk_usb_host),
 	INIT_CK("ep93xx-keypad",	NULL,		&clk_keypad),
+	INIT_CK("ep93xx-analog",	NULL,		&clk_analog),
 	INIT_CK("ep93xx-fb",		NULL,		&clk_video),
 	INIT_CK(NULL,			"pwm_clk",	&clk_pwm),
 	INIT_CK(NULL,			"m2p0",		&clk_m2p0),
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index f7ebed9..17d3c11 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -684,6 +684,37 @@ EXPORT_SYMBOL(ep93xx_pwm_release_gpio);
 
 
 /*************************************************************************
+ * EP93xx Analog Touch Screen Interface peripheral handling.
+ * Note: TS and ADC share the same resource
+ *************************************************************************/
+static struct resource ep93xx_analog_resource[] = {
+	[0] = {
+		.start	= EP93XX_TS_PHYS_BASE,
+		.end	= EP93XX_TS_PHYS_BASE + 0x24 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_EP93XX_TOUCH,
+		.end	= IRQ_EP93XX_TOUCH,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device ep93xx_analog_device = {
+	.name		= "ep93xx-analog",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ep93xx_analog_resource),
+	.resource	= ep93xx_analog_resource,
+};
+
+/* HWMON */
+struct platform_device ep93xx_hwmon_device = {
+	.name		= "ep93xx-hwmon",
+	.id		= -1,
+	.dev.parent	= &ep93xx_analog_device.dev,
+};
+
+/*************************************************************************
  * EP93xx video peripheral handling
  *************************************************************************/
 static struct ep93xxfb_mach_info ep93xxfb_data;
diff --git a/arch/arm/mach-ep93xx/include/mach/adc.h b/arch/arm/mach-ep93xx/include/mach/adc.h
new file mode 100644
index 0000000..c4c6a5a
--- /dev/null
+++ b/arch/arm/mach-ep93xx/include/mach/adc.h
@@ -0,0 +1,54 @@
+/* arch/arm/mach-ep93xx/include/arch/adc.h
+ *
+ * Copyright 2009, Christian Gagneraud <cgagneraud@techworks.ie>
+ *
+ * Based on arch/arm/plat-s3c/include/plat/adc.h by Simtec Electronics
+ *
+ * EP93XX ADC driver information
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_ADC_H
+#define __ASM_ARCH_ADC_H __FILE__
+
+/* ADC Channels definition (switches) */
+#define ADC_SW_XP_IN		(1<<0)
+#define ADC_SW_XM_IN		(1<<1)
+#define ADC_SW_YP_IN		(1<<2)
+#define ADC_SW_YM_IN		(1<<3)
+#define ADC_SW_SXP_IN           (1<<4)
+#define ADC_SW_SXM_IN           (1<<5)
+#define ADC_SW_SYP_IN           (1<<6)
+#define ADC_SW_SYM_IN           (1<<7)
+#define ADC_SW_VBAT_IN          (1<<8)
+#define ADC_SW_AVDD_REFP        (1<<9)
+#define ADC_SW_AGND_REFM        (1<<10)
+#define ADC_SW_SXP_REFP         (1<<24)
+#define ADC_SW_SXM_REFM         (1<<25)
+#define ADC_SW_SYP_REFP         (1<<26)
+#define ADC_SW_SYM_REFM         (1<<27)
+#define ADC_SW_DAC_IN		(1<<29)
+#define ADC_SW_IN_LOAD		(1<<30)
+
+/* AGND as VREF-, AVDD as VREF+ */
+#define ADC_SW_APWR_REF         (ADC_SW_AVDD_REFP|ADC_SW_AGND_REFM)
+
+struct ep93xx_adc_client;
+
+extern struct platform_device ep93xx_analog_device;
+
+extern int ep93xx_adc_start(struct ep93xx_adc_client *client,
+			    unsigned int channel, unsigned int nr_samples);
+
+extern int ep93xx_adc_read(struct ep93xx_adc_client *client,
+			   unsigned int ch);
+
+extern struct ep93xx_adc_client *ep93xx_adc_register(struct platform_device
+						     *pdev);
+
+extern void ep93xx_adc_release(struct ep93xx_adc_client *client);
+
+#endif				/* __ASM_ARCH_ADC_H */
diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index 0fbf87b..7453c08 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -145,8 +145,25 @@
 
 #define EP93XX_KEY_MATRIX_BASE		EP93XX_APB_IOMEM(0x000f0000)
 
-#define EP93XX_ADC_BASE			EP93XX_APB_IOMEM(0x00100000)
-#define EP93XX_TOUCHSCREEN_BASE		EP93XX_APB_IOMEM(0x00100000)
+/* Note:
+ * The EP9301 and EP9302 processors support a general 12-bit ADC, but
+ * no touchscreen, the EP9307, EP9312 and EP9315 processors each
+ * support up to an 8-wire touch screen or a general 12-bit ADC
+ */
+#define EP93XX_TS_PHYS_BASE		(EP93XX_APB_PHYS_BASE + 0x00100000)
+#define EP93XX_TS_BASE			EP93XX_APB_IOMEM(0x00100000)
+#define EP93XX_TS_REG(x)		(EP93XX_TS_BASE + (x))
+#define EP93XX_TS_SETUP			EP93XX_TS_REG(0x00)
+#define EP93XX_TS_SETUP_ENABLE		(1<<15)
+#define EP93XX_TS_XYRESULT              EP93XX_TS_REG(0x08)
+#define EP93XX_TS_XYRESULT_SDR          (1<<31)
+#define EP93XX_TS_DIRECT		EP93XX_TS_REG(0x18)
+#define EP93XX_TS_SWLOCK		EP93XX_TS_REG(0x20)
+#define EP93XX_TS_SWLOCK_UNLOCK		0x000000AA
+#define EP93XX_TS_SETUP2		EP93XX_TS_REG(0x24)
+#define EP93XX_TS_SETUP2_RINTEN		(1<<11)
+#define EP93XX_TS_SETUP2_NSIGND		(1<<9)
+
 
 #define EP93XX_PWM_PHYS_BASE		(EP93XX_APB_PHYS_BASE + 0x00110000)
 #define EP93XX_PWM_BASE			EP93XX_APB_IOMEM(0x00110000)
diff --git a/arch/arm/mach-ep93xx/include/mach/hwmon.h b/arch/arm/mach-ep93xx/include/mach/hwmon.h
new file mode 100644
index 0000000..fec3db9
--- /dev/null
+++ b/arch/arm/mach-ep93xx/include/mach/hwmon.h
@@ -0,0 +1,43 @@
+/* linux/arch/arm/mach-ep93xx/include/arch/hwmon.h
+ *
+ * Copyright (C) 2009 Christian Gagneraud <cgagneraud@techworks.ie>
+ *
+ * Based on linux/arch/arm/plat-s3c/include/plat/hwmon.h by Simtec Electronics
+ *
+ * EP93XX - HWMon interface for ADC
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_HWMON_H
+#define __ASM_ARCH_HWMON_H __FILE__
+
+extern struct platform_device ep93xx_hwmon_device;
+
+/**
+ * ep93xx_hwmon_chcfg - channel configuration
+ * @name: The name to give this channel.
+ * @mult: Multiply the ADC value read by this.
+ * @div: Divide the value from the ADC by this.
+ *
+ * The value read from the ADC is converted to a value that
+ * hwmon expects (mV) by result = (value_read * @mult) / @div.
+ */
+struct ep93xx_hwmon_chcfg {
+	const char *name;
+	unsigned long channel;
+	unsigned long mult;
+	unsigned long div;
+};
+
+/**
+ * ep93xx_hwmon_pdata - HWMON platform data
+ * @in: One configuration for each possible channel used.
+ */
+struct ep93xx_hwmon_data {
+	struct ep93xx_hwmon_chcfg *in[7];
+};
+
+#endif				/* __ASM_ARCH_HWMON_H */
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 259f782..2bbf05b 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -18,6 +18,8 @@
 #include <linux/mtd/physmap.h>
 
 #include <mach/hardware.h>
+#include <mach/adc.h>
+#include <mach/hwmon.h>
 #include <mach/ts72xx.h>
 
 #include <asm/mach-types.h>
@@ -92,6 +94,8 @@ static struct map_desc ts72xx_alternate_nand_io_desc[] __initdata = {
 	}
 };
 
+static struct ep93xx_hwmon_data ts72xx_hwmon_info;
+
 static void __init ts72xx_map_io(void)
 {
 	ep93xx_map_io();
@@ -109,6 +113,8 @@ static void __init ts72xx_map_io(void)
 				ARRAY_SIZE(ts72xx_nand_io_desc));
 		}
 	}
+        
+	ep93xx_hwmon_device.dev.platform_data = &ts72xx_hwmon_info;
 }
 
 /*************************************************************************
@@ -170,6 +176,74 @@ static struct ep93xx_eth_data ts72xx_eth_data = {
 	.phy_id		= 1,
 };
 
+
+#define TS72XX_ADC0 (ADC_SW_YM_IN  | ADC_SW_APWR_REF)
+#define TS72XX_ADC1 (ADC_SW_SXP_IN | ADC_SW_APWR_REF)
+#define TS72XX_ADC2 (ADC_SW_SXM_IN | ADC_SW_APWR_REF)
+#define TS72XX_ADC3 (ADC_SW_SYP_IN | ADC_SW_APWR_REF)
+#define TS72XX_ADC4 (ADC_SW_SYM_IN | ADC_SW_APWR_REF)
+
+// TODO: board dependant
+// TS-7200: ADC0, ADC4
+// TS-7250: ADC0 to ADC4
+// TS-7260: Vin, 5V_104, ADC2, Vcore, ADC4
+// TS-7300: 5V, 1.2V, ADC2, 1.8V, ADC4
+
+// 0V gives 0, 3.3V gives c. 50000
+// TODO: self calibrate by using VBAT and Load resistor switches
+static struct ep93xx_hwmon_data ts72xx_hwmon_info = {
+	/* POWER_IN*10K/150K (4.5-20V) */
+	.in[0] = &(struct ep93xx_hwmon_chcfg) {
+		.name		= "ts72xx-vin",
+                .channel        = TS72XX_ADC0,
+		.mult		= 33*(15+1),
+		.div		= 500*1,
+	},
+	/* PC104_5V*10K/54.9K (5V) */
+	.in[1] = &(struct ep93xx_hwmon_chcfg) {
+		.name		= "ts72xx-v5",
+                .channel        = TS72XX_ADC4,
+		.mult		= 33*(549+100),
+		.div		= 500*100,
+	},
+	/* Vcore (1.8V)  */
+	.in[2] = &(struct ep93xx_hwmon_chcfg) {
+		.name		= "ts72xx-vcore",
+                .channel        = TS72XX_ADC2,
+		.mult		= 33*1,
+		.div		= 500*1,
+	},
+	/* User ADC on DIO2.8  (0-3.3V) */
+	.in[3] = &(struct ep93xx_hwmon_chcfg) {
+		.name		= "ts72xx-dio2.8",
+                .channel        = TS72XX_ADC3,
+		.mult		= 33*1,
+		.div		= 500*1,
+	},
+	/* User ADC on DIO2.10 (0-3.3V) */
+	.in[4] = &(struct ep93xx_hwmon_chcfg) {
+		.name		= "ts72xx-dio2.10",
+                .channel        = TS72XX_ADC1,
+		.mult		= 33*1,
+		.div		= 500*1,
+	},
+	/* EP93XX.VBAT (1.8V)  */
+	.in[5] = &(struct ep93xx_hwmon_chcfg) {
+		.name		= "ep93xx-vbat",
+                .channel        = ADC_SW_VBAT_IN|ADC_SW_APWR_REF,
+		.mult		= 33*1,
+		.div		= 500*1,
+	},
+	/* EP93XX.DAC (?)  */
+	.in[6] = &(struct ep93xx_hwmon_chcfg) {
+		.name		= "ep93xx-vdac",
+                .channel        = ADC_SW_DAC_IN|ADC_SW_APWR_REF,
+		.mult		= 33*1,
+		.div		= 500*1,
+	},
+};
+
+
 static void __init ts72xx_init_machine(void)
 {
 	ep93xx_init_devices();
@@ -177,6 +251,10 @@ static void __init ts72xx_init_machine(void)
 	platform_device_register(&ts72xx_rtc_device);
 
 	ep93xx_register_eth(&ts72xx_eth_data, 1);
+        
+	platform_device_register(&ep93xx_analog_device);
+        
+	platform_device_register(&ep93xx_hwmon_device);
 }
 
 MACHINE_START(TS72XX, "Technologic Systems TS-72xx SBC")
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 700e93a..af6f08a 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -690,6 +690,23 @@ config SENSORS_S3C_RAW
 	  Say Y here if you want to include raw copies of all the ADC
 	  channels in sysfs.
 
+config SENSORS_EP93XX
+	tristate "EP93XX on-chip ADC"
+	depends on ARCH_EP93XX
+	help
+	  If you say yes here you get support for the on-board ADCs of
+	  the Cirrus Logic EP93XX series of SoC
+
+	  This driver can also be built as a module. If so, the module
+	  will be called ep93xx-hwmo.
+
+config SENSORS_EP93XX_RAW
+	bool "Include raw channel attributes in sysfs"
+	depends on SENSORS_EP93XX
+	help
+	  Say Y here if you want to include raw copies of all the ADC
+	  channels in sysfs.
+
 config SENSORS_SIS5595
 	tristate "Silicon Integrated Systems Corp. SiS5595"
 	depends on PCI
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 9f46cb0..eea13fc 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_SENSORS_S3C)	+= s3c-hwmon.o
+obj-$(CONFIG_SENSORS_EP93XX)	+= ep93xx-hwmon.o
 obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
 obj-$(CONFIG_SENSORS_SIS5595)	+= sis5595.o
 obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
diff --git a/drivers/hwmon/ep93xx-hwmon.c b/drivers/hwmon/ep93xx-hwmon.c
new file mode 100644
index 0000000..2e4a9f7
--- /dev/null
+++ b/drivers/hwmon/ep93xx-hwmon.c
@@ -0,0 +1,416 @@
+/* linux/drivers/hwmon/ep93xx-hwmon.c
+ *
+ * Copyright 2009, Christian Gagneraud <cgagneraud@techworks.ie>
+ *
+ * Based on linux/drivers/hwmon/s3c-hwmon.c by Simtec Electronics
+ *
+ * EP93XX ADC hwmon support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*/
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+
+#include <mach/adc.h>
+#include <mach/hwmon.h>
+
+struct ep93xx_hwmon_attr {
+	struct sensor_device_attribute in;
+	struct sensor_device_attribute label;
+	char in_name[12];
+	char label_name[12];
+};
+
+/**
+ * struct ep93xx_hwmon - ADC hwmon client information
+ * @lock: Access lock to serialise the conversions.
+ * @client: The client we registered with the EP93XX ADC core.
+ * @hwmon_dev: The hwmon device we created.
+ * @attr: The holders for the channel attributes.
+*/
+struct ep93xx_hwmon {
+	struct semaphore lock;
+	struct ep93xx_adc_client *client;
+	struct device *hwmon_dev;
+	struct ep93xx_hwmon_attr attrs[7];
+};
+
+/**
+ * ep93xx_hwmon_read_ch - read a value from a given adc channel.
+ * @dev: The device.
+ * @hwmon: Our state.
+ * @channel: The channel we're reading from.
+ *
+ * Read a value from the @channel with the proper locking and sleep until
+ * either the read completes or we timeout awaiting the ADC core to get
+ * back to us.
+ */
+static int ep93xx_hwmon_read_ch(struct device *dev,
+				struct ep93xx_hwmon *hwmon, int channel)
+{
+	int ret;
+
+	ret = down_interruptible(&hwmon->lock);
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(dev, "reading channel %d\n", channel);
+
+	ret = ep93xx_adc_read(hwmon->client, channel);
+	up(&hwmon->lock);
+
+	return ret;
+}
+
+#ifdef CONFIG_SENSORS_EP93XX_RAW
+/**
+ * ep93xx_hwmon_show_raw - show a conversion from the raw channel number.
+ * @dev: The device that the attribute belongs to.
+ * @attr: The attribute being read.
+ * @buf: The result buffer.
+ *
+ * This show deals with the raw attribute, registered for each possible
+ * ADC channel. This does a conversion and returns the raw (un-scaled)
+ * value returned from the hardware.
+ */
+static ssize_t ep93xx_hwmon_show_raw(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct ep93xx_hwmon *adc =
+	    platform_get_drvdata(to_platform_device(dev));
+	struct sensor_device_attribute *sa = to_sensor_dev_attr(attr);
+	struct ep93xx_hwmon_data *pdata = dev->platform_data;
+	struct ep93xx_hwmon_chcfg *cfg;
+	int ret;
+
+	cfg = pdata->in[sa->index];
+
+	ret = ep93xx_hwmon_read_ch(dev, adc, cfg->channel);
+
+	return (ret < 0) ? ret : snprintf(buf, PAGE_SIZE, "%d\n", ret);
+}
+
+#define DEF_ADC_ATTR(x)	\
+	static SENSOR_DEVICE_ATTR(adc##x##_raw, S_IRUGO, ep93xx_hwmon_show_raw, NULL, x)
+
+DEF_ADC_ATTR(0);
+DEF_ADC_ATTR(1);
+DEF_ADC_ATTR(2);
+DEF_ADC_ATTR(3);
+DEF_ADC_ATTR(4);
+DEF_ADC_ATTR(5);
+DEF_ADC_ATTR(6);
+
+static struct attribute *ep93xx_hwmon_attrs[8] = {
+	&sensor_dev_attr_adc0_raw.dev_attr.attr,
+	&sensor_dev_attr_adc1_raw.dev_attr.attr,
+	&sensor_dev_attr_adc2_raw.dev_attr.attr,
+	&sensor_dev_attr_adc3_raw.dev_attr.attr,
+	&sensor_dev_attr_adc4_raw.dev_attr.attr,
+	&sensor_dev_attr_adc5_raw.dev_attr.attr,
+	&sensor_dev_attr_adc6_raw.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute_group ep93xx_hwmon_attrgroup = {
+	.attrs = ep93xx_hwmon_attrs,
+};
+
+static inline int ep93xx_hwmon_add_raw(struct device *dev)
+{
+	return sysfs_create_group(&dev->kobj, &ep93xx_hwmon_attrgroup);
+}
+
+static inline void ep93xx_hwmon_remove_raw(struct device *dev)
+{
+	sysfs_remove_group(&dev->kobj, &ep93xx_hwmon_attrgroup);
+}
+
+#else
+
+static inline void ep93xx_hwmon_add_raw(struct device *dev)
+{
+}
+
+static inline void ep93xx_hwmon_remove_raw(struct device *dev)
+{
+}
+
+#endif				/* CONFIG_SENSORS_EP93XX_RAW */
+
+/**
+ * ep93xx_hwmon_ch_show - show value of a given channel
+ * @dev: The device that the attribute belongs to.
+ * @attr: The attribute being read.
+ * @buf: The result buffer.
+ *
+ * Read a value from the ADC and scale it before returning it to the
+ * caller. The scale factor is gained from the channel configuration
+ * passed via the platform data when the device was registered.
+ */
+static ssize_t ep93xx_hwmon_ch_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct sensor_device_attribute *sen_attr =
+	    to_sensor_dev_attr(attr);
+	struct ep93xx_hwmon *hwmon =
+	    platform_get_drvdata(to_platform_device(dev));
+	struct ep93xx_hwmon_data *pdata = dev->platform_data;
+	struct ep93xx_hwmon_chcfg *cfg;
+	int ret;
+
+	cfg = pdata->in[sen_attr->index];
+
+	ret = ep93xx_hwmon_read_ch(dev, hwmon, cfg->channel);
+	if (ret < 0)
+		return ret;
+
+	ret *= cfg->mult;
+	ret = DIV_ROUND_CLOSEST(ret, cfg->div);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", ret);
+}
+
+/**
+ * ep93xx_hwmon_label_show - show label name of the given channel.
+ * @dev: The device that the attribute belongs to.
+ * @attr: The attribute being read.
+ * @buf: The result buffer.
+ *
+ * Return the label name of a given channel
+ */
+static ssize_t ep93xx_hwmon_label_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct sensor_device_attribute *sen_attr =
+	    to_sensor_dev_attr(attr);
+	struct ep93xx_hwmon_data *pdata = dev->platform_data;
+	struct ep93xx_hwmon_chcfg *cfg;
+
+	cfg = pdata->in[sen_attr->index];
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", cfg->name);
+}
+
+/**
+ * ep93xx_hwmon_create_attr - create hwmon attribute for given channel.
+ * @dev: The device to create the attribute on.
+ * @cfg: The channel configuration passed from the platform data.
+ * @channel: The ADC channel number to process.
+ *
+ * Create the scaled attribute for use with hwmon from the specified
+ * platform data in @pdata. The sysfs entry is handled by the routine
+ * ep93xx_hwmon_ch_show().
+ *
+ * The attribute name is taken from the configuration data if present
+ * otherwise the name is taken by concatenating in_ with the channel
+ * number.
+ */
+static int ep93xx_hwmon_create_attr(struct device *dev,
+				    struct ep93xx_hwmon_chcfg *cfg,
+				    struct ep93xx_hwmon_attr *attrs,
+				    int channel)
+{
+	struct sensor_device_attribute *attr;
+	int ret;
+
+	snprintf(attrs->in_name, sizeof(attrs->in_name), "in%d_input",
+		 channel);
+
+	attr = &attrs->in;
+	attr->index = channel;
+	attr->dev_attr.attr.name = attrs->in_name;
+	attr->dev_attr.attr.mode = S_IRUGO;
+	attr->dev_attr.attr.owner = THIS_MODULE;
+	attr->dev_attr.show = ep93xx_hwmon_ch_show;
+
+	ret = device_create_file(dev, &attr->dev_attr);
+	if (ret < 0) {
+		dev_err(dev, "failed to create input attribute\n");
+		return ret;
+	}
+
+	/* if this has a name, add a label */
+	if (cfg->name) {
+		snprintf(attrs->label_name, sizeof(attrs->label_name),
+			 "in%d_label", channel);
+
+		attr = &attrs->label;
+		attr->index = channel;
+		attr->dev_attr.attr.name = attrs->label_name;
+		attr->dev_attr.attr.mode = S_IRUGO;
+		attr->dev_attr.attr.owner = THIS_MODULE;
+		attr->dev_attr.show = ep93xx_hwmon_label_show;
+
+		ret = device_create_file(dev, &attr->dev_attr);
+		if (ret < 0) {
+			device_remove_file(dev, &attrs->in.dev_attr);
+			dev_err(dev, "failed to create label attribute\n");
+		}
+	}
+
+	return ret;
+}
+
+static void ep93xx_hwmon_remove_attr(struct device *dev,
+				     struct ep93xx_hwmon_attr *attrs)
+{
+	device_remove_file(dev, &attrs->in.dev_attr);
+	device_remove_file(dev, &attrs->label.dev_attr);
+}
+
+/**
+ * ep93xx_hwmon_probe - device probe entry.
+ * @dev: The device being probed.
+*/
+static int __devinit ep93xx_hwmon_probe(struct platform_device *dev)
+{
+	struct ep93xx_hwmon_data *pdata = dev->dev.platform_data;
+	struct ep93xx_hwmon *hwmon;
+	int ret = 0;
+	int i;
+
+	if (!pdata) {
+		dev_err(&dev->dev, "no platform data supplied\n");
+		return -EINVAL;
+	}
+
+	hwmon = kzalloc(sizeof(struct ep93xx_hwmon), GFP_KERNEL);
+	if (hwmon == NULL) {
+		dev_err(&dev->dev, "no memory\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(dev, hwmon);
+
+	init_MUTEX(&hwmon->lock);
+
+	/* Register with the core ADC driver. */
+
+	hwmon->client = ep93xx_adc_register(dev);
+	if (IS_ERR(hwmon->client)) {
+		dev_err(&dev->dev, "cannot register adc\n");
+		ret = PTR_ERR(hwmon->client);
+		goto err_mem;
+	}
+
+	/* add attributes for our adc devices. */
+
+	ret = ep93xx_hwmon_add_raw(&dev->dev);
+	if (ret)
+		goto err_registered;
+
+	/* register with the hwmon core */
+
+	hwmon->hwmon_dev = hwmon_device_register(&dev->dev);
+	if (IS_ERR(hwmon->hwmon_dev)) {
+		dev_err(&dev->dev, "error registering with hwmon\n");
+		ret = PTR_ERR(hwmon->hwmon_dev);
+		goto err_raw_attribute;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(pdata->in); i++) {
+		if (!pdata->in[i])
+			continue;
+
+		if (pdata->in[i]->mult >= 0x10000)
+			dev_warn(&dev->dev,
+				 "channel %d multiplier too large\n", i);
+
+		ret = ep93xx_hwmon_create_attr(&dev->dev, pdata->in[i],
+					       &hwmon->attrs[i], i);
+		if (ret) {
+			dev_err(&dev->dev,
+				"error creating channel %d\n", i);
+
+			for (i--; i >= 0; i--)
+				ep93xx_hwmon_remove_attr(&dev->dev,
+							 &hwmon->attrs[i]);
+
+			goto err_hwmon_register;
+		}
+	}
+
+	return 0;
+
+      err_hwmon_register:
+	hwmon_device_unregister(hwmon->hwmon_dev);
+
+      err_raw_attribute:
+	ep93xx_hwmon_remove_raw(&dev->dev);
+
+      err_registered:
+	ep93xx_adc_release(hwmon->client);
+
+      err_mem:
+	kfree(hwmon);
+	return ret;
+}
+
+static int __devexit ep93xx_hwmon_remove(struct platform_device *dev)
+{
+	struct ep93xx_hwmon *hwmon = platform_get_drvdata(dev);
+	int i;
+
+	ep93xx_hwmon_remove_raw(&dev->dev);
+
+	for (i = 0; i < ARRAY_SIZE(hwmon->attrs); i++)
+		ep93xx_hwmon_remove_attr(&dev->dev, &hwmon->attrs[i]);
+
+	hwmon_device_unregister(hwmon->hwmon_dev);
+	ep93xx_adc_release(hwmon->client);
+
+	return 0;
+}
+
+static struct platform_driver ep93xx_hwmon_driver = {
+	.driver = {
+		   .name = "ep93xx-hwmon",
+		   .owner = THIS_MODULE,
+		   },
+	.probe = ep93xx_hwmon_probe,
+	.remove = __devexit_p(ep93xx_hwmon_remove),
+};
+
+static int __init ep93xx_hwmon_init(void)
+{
+	return platform_driver_register(&ep93xx_hwmon_driver);
+}
+
+static void __exit ep93xx_hwmon_exit(void)
+{
+	platform_driver_unregister(&ep93xx_hwmon_driver);
+}
+
+module_init(ep93xx_hwmon_init);
+module_exit(ep93xx_hwmon_exit);
+
+MODULE_AUTHOR("Christian Gagneraud <cgagneraud@techworks.ie>");
+MODULE_DESCRIPTION("EP93XX ADC HWMon driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:ep93xx-hwmon");
