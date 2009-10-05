From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Mon, 5 Oct 2009 21:33:56 +0200
Subject: [PATCH] Move ADC driver from S3C24xx to S3C and adjust it for the
	S3C64xx.
Message-ID: <b2e8f9f70910051233u3ca77388w5dc7093f2529a5e9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is a try at generalizing the ADC driver for S3C24xx and S3C64xx.

I've used this as a base to port over Openmoko's touchscreen driver, and now
I'd want this to get integrated into mainline.

Comments/criticism/.. welcome.

Regards,
Maurus Cuelenaere


This moves the ADC driver from plat-s3c24xx to plat-s3c and adds support for
the S3C64xx.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>

---
 arch/arm/mach-s3c6400/include/mach/map.h  |    1 +
 arch/arm/plat-s3c/Kconfig                 |    9 +
 arch/arm/plat-s3c/Makefile                |    4 +
 arch/arm/plat-s3c/adc.c                   |  447 +++++++++++++++++++++++++++++
 arch/arm/plat-s3c/include/plat/adc.h      |    6 +-
 arch/arm/plat-s3c/include/plat/regs-adc.h |    2 +
 arch/arm/plat-s3c24xx/Kconfig             |    7 -
 arch/arm/plat-s3c24xx/Makefile            |    1 -
 arch/arm/plat-s3c24xx/adc.c               |  434 ----------------------------
 arch/arm/plat-s3c24xx/devs.c              |   14 +-
 arch/arm/plat-s3c64xx/Makefile            |    4 +
 arch/arm/plat-s3c64xx/dev-adc.c           |   51 ++++
 12 files changed, 533 insertions(+), 447 deletions(-)
 create mode 100644 arch/arm/plat-s3c/adc.c
 delete mode 100644 arch/arm/plat-s3c24xx/adc.c
 create mode 100644 arch/arm/plat-s3c64xx/dev-adc.c

diff --git a/arch/arm/mach-s3c6400/include/mach/map.h
b/arch/arm/mach-s3c6400/include/mach/map.h
index fc8b223..b66bfaf 100644
--- a/arch/arm/mach-s3c6400/include/mach/map.h
+++ b/arch/arm/mach-s3c6400/include/mach/map.h
@@ -42,6 +42,7 @@
 #define S3C64XX_PA_FB		(0x77100000)
 #define S3C64XX_PA_USB_HSOTG	(0x7C000000)
 #define S3C64XX_PA_WATCHDOG	(0x7E004000)
+#define S3C64XX_PA_ADC		(0x7E00B000)
 #define S3C64XX_PA_SYSCON	(0x7E00F000)
 #define S3C64XX_PA_AC97		(0x7F001000)
 #define S3C64XX_PA_IIS0		(0x7F002000)
diff --git a/arch/arm/plat-s3c/Kconfig b/arch/arm/plat-s3c/Kconfig
index 8931c5f..82ed66d 100644
--- a/arch/arm/plat-s3c/Kconfig
+++ b/arch/arm/plat-s3c/Kconfig
@@ -166,6 +166,15 @@ config S3C_DMA
 	help
 	  Internal configuration for S3C DMA core

+# ADC
+
+config S3C_ADC
+	bool "ADC common driver support"
+	help
+	  Core support for the ADC block found in the S3C SoC systems
+	  for drivers such as the touchscreen and hwmon to use to share
+	  this resource.
+
 # device definitions to compile in

 config S3C_DEV_HSMMC
diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
index 3c09109..788056a 100644
--- a/arch/arm/plat-s3c/Makefile
+++ b/arch/arm/plat-s3c/Makefile
@@ -22,6 +22,10 @@ obj-y				+= gpio-config.o

 obj-$(CONFIG_S3C_DMA)		+= dma.o

+# ADC support
+
+obj-$(CONFIG_S3C_ADC)		+= adc.o
+
 # PM support

 obj-$(CONFIG_PM)		+= pm.o
diff --git a/arch/arm/plat-s3c/adc.c b/arch/arm/plat-s3c/adc.c
new file mode 100644
index 0000000..2436850
--- /dev/null
+++ b/arch/arm/plat-s3c/adc.c
@@ -0,0 +1,447 @@
+/* arch/arm/plat-s3c/adc.c
+ *
+ * Copyright (c) 2008 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>, <ben-linux@fluff.org>
+ *
+ * S3C ADC device core
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+*/
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/list.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+
+#include <plat/regs-adc.h>
+#include <plat/adc.h>
+
+/* This driver is designed to control the usage of the ADC block between
+ * the touchscreen and any other drivers that may need to use it, such as
+ * the hwmon driver.
+ *
+ * Priority will be given to the touchscreen driver, but as this itself is
+ * rate limited it should not starve other requests which are processed in
+ * order that they are received.
+ *
+ * Each user registers to get a client block which uniquely identifies it
+ * and stores information such as the necessary functions to callback when
+ * action is required.
+ */
+
+struct s3c_adc_client {
+	struct platform_device	*pdev;
+	struct list_head	 pend;
+	wait_queue_head_t	*wait;
+
+	unsigned int		 nr_samples;
+	int			 result;
+	unsigned char		 is_ts;
+	unsigned char		 channel;
+
+	void	(*select_cb)(struct s3c_adc_client *c, unsigned selected);
+	void	(*convert_cb)(struct s3c_adc_client *c,
+			      unsigned val1, unsigned val2,
+			      unsigned *samples_left);
+};
+
+struct adc_device {
+	struct platform_device	*pdev;
+	struct platform_device	*owner;
+	struct clk		*clk;
+	struct s3c_adc_client	*cur;
+	struct s3c_adc_client	*ts_pend;
+	void __iomem		*regs;
+
+	unsigned int		 prescale;
+
+	int			 irq;
+	struct s3c_adc_platdata* pd;
+};
+
+static struct adc_device *adc_dev;
+
+static LIST_HEAD(adc_pending);
+
+#define adc_dbg(_adc, msg...) dev_dbg(&(_adc)->pdev->dev, msg)
+
+static inline void s3c_adc_convert(struct adc_device *adc)
+{
+	unsigned con = readl(adc->regs + S3C2410_ADCCON);
+
+	con |= S3C2410_ADCCON_ENABLE_START;
+	writel(con, adc->regs + S3C2410_ADCCON);
+}
+
+static inline void s3c_adc_select(struct adc_device *adc,
+				  struct s3c_adc_client *client)
+{
+	unsigned con = readl(adc->regs + S3C2410_ADCCON);
+
+	client->select_cb(client, 1);
+
+	con &= ~S3C2410_ADCCON_MUXMASK;
+	con &= ~S3C2410_ADCCON_STDBM;
+	con &= ~S3C2410_ADCCON_STARTMASK;
+
+	if (!client->is_ts)
+		con |= S3C2410_ADCCON_SELMUX(client->channel);
+
+	writel(con, adc->regs + S3C2410_ADCCON);
+}
+
+static void s3c_adc_dbgshow(struct adc_device *adc)
+{
+	adc_dbg(adc, "CON=%08x, TSC=%08x, DLY=%08x\n",
+		readl(adc->regs + S3C2410_ADCCON),
+		readl(adc->regs + S3C2410_ADCTSC),
+		readl(adc->regs + S3C2410_ADCDLY));
+}
+
+static void s3c_adc_try(struct adc_device *adc)
+{
+	struct s3c_adc_client *next = adc->ts_pend;
+
+	if (!next && !list_empty(&adc_pending)) {
+		next = list_first_entry(&adc_pending,
+					struct s3c_adc_client, pend);
+		list_del(&next->pend);
+	} else
+		adc->ts_pend = NULL;
+
+	if (next) {
+		adc_dbg(adc, "new client is %p\n", next);
+		adc->cur = next;
+		s3c_adc_select(adc, next);
+		s3c_adc_convert(adc);
+		s3c_adc_dbgshow(adc);
+	}
+}
+
+int s3c_adc_start(struct s3c_adc_client *client,
+		  unsigned int channel, unsigned int nr_samples)
+{
+	struct adc_device *adc = adc_dev;
+	unsigned long flags;
+
+	if (!adc) {
+		printk(KERN_ERR "%s: failed to find adc\n", __func__);
+		return -EINVAL;
+	}
+
+	if (client->is_ts && adc->ts_pend)
+		return -EAGAIN;
+
+	local_irq_save(flags);
+
+	client->channel = channel;
+	client->nr_samples = nr_samples;
+
+	if (client->is_ts)
+		adc->ts_pend = client;
+	else
+		list_add_tail(&client->pend, &adc_pending);
+
+	if (!adc->cur)
+		s3c_adc_try(adc);
+	local_irq_restore(flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(s3c_adc_start);
+
+static void s3c_convert_done(struct s3c_adc_client *client,
+			     unsigned v, unsigned u, unsigned *left)
+{
+	client->result = v;
+	wake_up(client->wait);
+}
+
+int s3c_adc_read(struct s3c_adc_client *client, unsigned int ch)
+{
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wake);
+	int ret;
+
+	client->convert_cb = s3c_convert_done;
+	client->wait = &wake;
+	client->result = -1;
+
+	ret = s3c_adc_start(client, ch, 1);
+	if (ret < 0)
+		goto err;
+
+	ret = wait_event_timeout(wake, client->result >= 0, HZ / 2);
+	if (client->result < 0) {
+		ret = -ETIMEDOUT;
+		goto err;
+	}
+
+	client->convert_cb = NULL;
+	return client->result;
+
+err:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(s3c_adc_convert);
+
+static void s3c_adc_default_select(struct s3c_adc_client *client,
+				   unsigned select)
+{
+}
+
+struct s3c_adc_client *s3c_adc_register(struct platform_device *pdev,
+					void (*select)(struct s3c_adc_client *client,
+						       unsigned int selected),
+					void (*conv)(struct s3c_adc_client *client,
+						     unsigned d0, unsigned d1,
+						     unsigned *samples_left),
+					unsigned int is_ts)
+{
+	struct s3c_adc_client *client;
+
+	WARN_ON(!pdev);
+
+	if (!select)
+		select = s3c_adc_default_select;
+
+	if (!pdev)
+		return ERR_PTR(-EINVAL);
+
+	client = kzalloc(sizeof(struct s3c_adc_client), GFP_KERNEL);
+	if (!client) {
+		dev_err(&pdev->dev, "no memory for adc client\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	client->pdev = pdev;
+	client->is_ts = is_ts;
+	client->select_cb = select;
+	client->convert_cb = conv;
+
+	return client;
+}
+EXPORT_SYMBOL_GPL(s3c_adc_register);
+
+void s3c_adc_release(struct s3c_adc_client *client)
+{
+	/* We should really check that nothing is in progress. */
+	if (adc_dev->cur == client)
+		adc_dev->cur = NULL;
+	if (adc_dev->ts_pend == client)
+		adc_dev->ts_pend = NULL;
+	else {
+		struct list_head *p, *n;
+		struct s3c_adc_client *tmp;
+
+		list_for_each_safe(p, n, &adc_pending) {
+			tmp = list_entry(p, struct s3c_adc_client, pend);
+			if (tmp == client)
+				list_del(&tmp->pend);
+		}
+	}
+
+	if (adc_dev->cur == NULL)
+		s3c_adc_try(adc_dev);
+	kfree(client);
+}
+EXPORT_SYMBOL_GPL(s3c_adc_release);
+
+static irqreturn_t s3c_adc_irq(int irq, void *pw)
+{
+	struct adc_device *adc = pw;
+	struct s3c_adc_client *client = adc->cur;
+	unsigned long flags;
+	unsigned data0, data1;
+
+	if (!client) {
+		dev_warn(&adc->pdev->dev, "%s: no adc pending\n", __func__);
+		goto exit;
+	}
+
+	data0 = readl(adc->regs + S3C2410_ADCDAT0);
+	data1 = readl(adc->regs + S3C2410_ADCDAT1);
+	adc_dbg(adc, "read %d: 0x%04x, 0x%04x\n", client->nr_samples, data0, data1);
+
+	client->nr_samples--;
+
+	if (client->convert_cb)
+		(client->convert_cb)(client, data0 & 0x3ff, data1 & 0x3ff,
+				     &client->nr_samples);
+
+	if (client->nr_samples > 0) {
+		/* fire another conversion for this */
+
+		client->select_cb(client, 1);
+		s3c_adc_convert(adc);
+	} else {
+		local_irq_save(flags);
+		(client->select_cb)(client, 0);
+		adc->cur = NULL;
+
+		s3c_adc_try(adc);
+		local_irq_restore(flags);
+	}
+
+exit:
+	if(adc->pd->adc_type == 1)
+		writel(0, adc->regs + S3C6410_ADCCLRI);
+
+	return IRQ_HANDLED;
+}
+
+static int s3c_adc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct s3c_adc_platdata *pd;
+	struct adc_device *adc;
+	struct resource *regs;
+	int ret;
+
+	pd = pdev->dev.platform_data;
+	if (!pd) {
+		dev_err(dev, "no platform data specified\n");
+		return -EINVAL;
+	}
+
+	adc = kzalloc(sizeof(struct adc_device), GFP_KERNEL);
+	if (adc == NULL) {
+		dev_err(dev, "failed to allocate adc_device\n");
+		return -ENOMEM;
+	}
+
+	adc->pdev = pdev;
+	adc->pd = pd;
+	adc->prescale = S3C2410_ADCCON_PRSCVL(49);
+
+	adc->irq = platform_get_irq(pdev, 1);
+	if (adc->irq <= 0) {
+		dev_err(dev, "failed to get adc irq\n");
+		ret = -ENOENT;
+		goto err_alloc;
+	}
+
+	ret = request_irq(adc->irq, s3c_adc_irq, 0, dev_name(dev), adc);
+	if (ret < 0) {
+		dev_err(dev, "failed to attach adc irq\n");
+		goto err_alloc;
+	}
+
+	adc->clk = clk_get(dev, "adc");
+	if (IS_ERR(adc->clk)) {
+		dev_err(dev, "failed to get adc clock\n");
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
+	writel(adc->prescale | S3C2410_ADCCON_PRSCEN,
+	       adc->regs + S3C2410_ADCCON);
+
+	dev_info(dev, "attached adc driver\n");
+
+	platform_set_drvdata(pdev, adc);
+	adc_dev = adc;
+
+	return 0;
+
+ err_clk:
+	clk_put(adc->clk);
+
+ err_irq:
+	free_irq(adc->irq, adc);
+
+ err_alloc:
+	kfree(adc);
+	return ret;
+}
+
+static int s3c_adc_remove(struct platform_device *pdev)
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
+static int s3c_adc_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct adc_device *adc = platform_get_drvdata(pdev);
+	u32 con;
+
+	con = readl(adc->regs + S3C2410_ADCCON);
+	con |= S3C2410_ADCCON_STDBM;
+	writel(con, adc->regs + S3C2410_ADCCON);
+
+	clk_disable(adc->clk);
+
+	return 0;
+}
+
+static int s3c_adc_resume(struct platform_device *pdev)
+{
+	struct adc_device *adc = platform_get_drvdata(pdev);
+
+	clk_enable(adc->clk);
+
+	writel(adc->prescale | S3C2410_ADCCON_PRSCEN,
+	       adc->regs + S3C2410_ADCCON);
+
+	return 0;
+}
+
+#else
+#define s3c_adc_suspend NULL
+#define s3c_adc_resume NULL
+#endif
+
+static struct platform_driver s3c_adc_driver = {
+	.driver		= {
+		.name	= "s3c-adc",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= s3c_adc_probe,
+	.remove		= __devexit_p(s3c_adc_remove),
+	.suspend	= s3c_adc_suspend,
+	.resume		= s3c_adc_resume,
+};
+
+static int __init adc_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&s3c_adc_driver);
+	if (ret)
+		printk(KERN_ERR "%s: failed to add adc driver\n", __func__);
+
+	return ret;
+}
+
+arch_initcall(adc_init);
diff --git a/arch/arm/plat-s3c/include/plat/adc.h
b/arch/arm/plat-s3c/include/plat/adc.h
index 5f3b1cd..a8c9f27 100644
--- a/arch/arm/plat-s3c/include/plat/adc.h
+++ b/arch/arm/plat-s3c/include/plat/adc.h
@@ -4,7 +4,7 @@
  *	http://armlinux.simnte.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
  *
- * S3C24XX ADC driver information
+ * S3C ADC driver information
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -14,6 +14,10 @@
 #ifndef __ASM_PLAT_ADC_H
 #define __ASM_PLAT_ADC_H __FILE__

+struct s3c_adc_platdata {
+	int adc_type;
+};
+
 struct s3c_adc_client;

 extern int s3c_adc_start(struct s3c_adc_client *client,
diff --git a/arch/arm/plat-s3c/include/plat/regs-adc.h
b/arch/arm/plat-s3c/include/plat/regs-adc.h
index 4323ccc..933ba79 100644
--- a/arch/arm/plat-s3c/include/plat/regs-adc.h
+++ b/arch/arm/plat-s3c/include/plat/regs-adc.h
@@ -19,6 +19,8 @@
 #define S3C2410_ADCDLY	   S3C2410_ADCREG(0x08)
 #define S3C2410_ADCDAT0	   S3C2410_ADCREG(0x0C)
 #define S3C2410_ADCDAT1	   S3C2410_ADCREG(0x10)
+#define S3C6410_ADCCLRI	   S3C2410_ADCREG(0x18)
+#define S3C6410_ADCCIDU	   S3C2410_ADCREG(0x20)


 /* ADCCON Register Bits */
diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
index 9c7aca4..c402ed9 100644
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ b/arch/arm/plat-s3c24xx/Kconfig
@@ -119,13 +119,6 @@ config S3C2410_DMA_DEBUG
 	  Enable debugging output for the DMA code. This option sends info
 	  to the kernel log, at priority KERN_DEBUG.

-config S3C24XX_ADC
-	bool "ADC common driver support"
-	help
-	  Core support for the ADC block found in the S3C24XX SoC systems
-	  for drivers such as the touchscreen and hwmon to use to share
-	  this resource.
-
 # SPI default pin configuration code

 config S3C24XX_SPI_BUS0_GPE11_GPE12_GPE13
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index 7780d2d..a2cb87b 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -38,7 +38,6 @@ obj-$(CONFIG_PM)		+= irq-pm.o
 obj-$(CONFIG_PM)		+= sleep.o
 obj-$(CONFIG_S3C2410_CLOCK)	+= s3c2410-clock.o
 obj-$(CONFIG_S3C2410_DMA)	+= dma.o
-obj-$(CONFIG_S3C24XX_ADC)	+= adc.o
 obj-$(CONFIG_S3C2410_IOTIMING)	+= s3c2410-iotiming.o
 obj-$(CONFIG_S3C2412_IOTIMING)	+= s3c2412-iotiming.o
 obj-$(CONFIG_S3C2410_CPUFREQ_UTILS) += s3c2410-cpufreq-utils.o
diff --git a/arch/arm/plat-s3c24xx/adc.c b/arch/arm/plat-s3c24xx/adc.c
deleted file mode 100644
index 11117a7..0000000
--- a/arch/arm/plat-s3c24xx/adc.c
+++ /dev/null
@@ -1,434 +0,0 @@
-/* arch/arm/plat-s3c24xx/adc.c
- *
- * Copyright (c) 2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>, <ben-linux@fluff.org>
- *
- * S3C24XX ADC device core
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License.
-*/
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/list.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-
-#include <plat/regs-adc.h>
-#include <plat/adc.h>
-
-/* This driver is designed to control the usage of the ADC block between
- * the touchscreen and any other drivers that may need to use it, such as
- * the hwmon driver.
- *
- * Priority will be given to the touchscreen driver, but as this itself is
- * rate limited it should not starve other requests which are processed in
- * order that they are received.
- *
- * Each user registers to get a client block which uniquely identifies it
- * and stores information such as the necessary functions to callback when
- * action is required.
- */
-
-struct s3c_adc_client {
-	struct platform_device	*pdev;
-	struct list_head	 pend;
-	wait_queue_head_t	*wait;
-
-	unsigned int		 nr_samples;
-	int			 result;
-	unsigned char		 is_ts;
-	unsigned char		 channel;
-
-	void	(*select_cb)(struct s3c_adc_client *c, unsigned selected);
-	void	(*convert_cb)(struct s3c_adc_client *c,
-			      unsigned val1, unsigned val2,
-			      unsigned *samples_left);
-};
-
-struct adc_device {
-	struct platform_device	*pdev;
-	struct platform_device	*owner;
-	struct clk		*clk;
-	struct s3c_adc_client	*cur;
-	struct s3c_adc_client	*ts_pend;
-	void __iomem		*regs;
-
-	unsigned int		 prescale;
-
-	int			 irq;
-};
-
-static struct adc_device *adc_dev;
-
-static LIST_HEAD(adc_pending);
-
-#define adc_dbg(_adc, msg...) dev_dbg(&(_adc)->pdev->dev, msg)
-
-static inline void s3c_adc_convert(struct adc_device *adc)
-{
-	unsigned con = readl(adc->regs + S3C2410_ADCCON);
-
-	con |= S3C2410_ADCCON_ENABLE_START;
-	writel(con, adc->regs + S3C2410_ADCCON);
-}
-
-static inline void s3c_adc_select(struct adc_device *adc,
-				  struct s3c_adc_client *client)
-{
-	unsigned con = readl(adc->regs + S3C2410_ADCCON);
-
-	client->select_cb(client, 1);
-
-	con &= ~S3C2410_ADCCON_MUXMASK;
-	con &= ~S3C2410_ADCCON_STDBM;
-	con &= ~S3C2410_ADCCON_STARTMASK;
-
-	if (!client->is_ts)
-		con |= S3C2410_ADCCON_SELMUX(client->channel);
-
-	writel(con, adc->regs + S3C2410_ADCCON);
-}
-
-static void s3c_adc_dbgshow(struct adc_device *adc)
-{
-	adc_dbg(adc, "CON=%08x, TSC=%08x, DLY=%08x\n",
-		readl(adc->regs + S3C2410_ADCCON),
-		readl(adc->regs + S3C2410_ADCTSC),
-		readl(adc->regs + S3C2410_ADCDLY));
-}
-
-static void s3c_adc_try(struct adc_device *adc)
-{
-	struct s3c_adc_client *next = adc->ts_pend;
-
-	if (!next && !list_empty(&adc_pending)) {
-		next = list_first_entry(&adc_pending,
-					struct s3c_adc_client, pend);
-		list_del(&next->pend);
-	} else
-		adc->ts_pend = NULL;
-
-	if (next) {
-		adc_dbg(adc, "new client is %p\n", next);
-		adc->cur = next;
-		s3c_adc_select(adc, next);
-		s3c_adc_convert(adc);
-		s3c_adc_dbgshow(adc);
-	}
-}
-
-int s3c_adc_start(struct s3c_adc_client *client,
-		  unsigned int channel, unsigned int nr_samples)
-{
-	struct adc_device *adc = adc_dev;
-	unsigned long flags;
-
-	if (!adc) {
-		printk(KERN_ERR "%s: failed to find adc\n", __func__);
-		return -EINVAL;
-	}
-
-	if (client->is_ts && adc->ts_pend)
-		return -EAGAIN;
-
-	local_irq_save(flags);
-
-	client->channel = channel;
-	client->nr_samples = nr_samples;
-
-	if (client->is_ts)
-		adc->ts_pend = client;
-	else
-		list_add_tail(&client->pend, &adc_pending);
-
-	if (!adc->cur)
-		s3c_adc_try(adc);
-	local_irq_restore(flags);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(s3c_adc_start);
-
-static void s3c_convert_done(struct s3c_adc_client *client,
-			     unsigned v, unsigned u, unsigned *left)
-{
-	client->result = v;
-	wake_up(client->wait);
-}
-
-int s3c_adc_read(struct s3c_adc_client *client, unsigned int ch)
-{
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wake);
-	int ret;
-
-	client->convert_cb = s3c_convert_done;
-	client->wait = &wake;
-	client->result = -1;
-
-	ret = s3c_adc_start(client, ch, 1);
-	if (ret < 0)
-		goto err;
-
-	ret = wait_event_timeout(wake, client->result >= 0, HZ / 2);
-	if (client->result < 0) {
-		ret = -ETIMEDOUT;
-		goto err;
-	}
-
-	client->convert_cb = NULL;
-	return client->result;
-
-err:
-	return ret;
-}
-EXPORT_SYMBOL_GPL(s3c_adc_convert);
-
-static void s3c_adc_default_select(struct s3c_adc_client *client,
-				   unsigned select)
-{
-}
-
-struct s3c_adc_client *s3c_adc_register(struct platform_device *pdev,
-					void (*select)(struct s3c_adc_client *client,
-						       unsigned int selected),
-					void (*conv)(struct s3c_adc_client *client,
-						     unsigned d0, unsigned d1,
-						     unsigned *samples_left),
-					unsigned int is_ts)
-{
-	struct s3c_adc_client *client;
-
-	WARN_ON(!pdev);
-
-	if (!select)
-		select = s3c_adc_default_select;
-
-	if (!pdev)
-		return ERR_PTR(-EINVAL);
-
-	client = kzalloc(sizeof(struct s3c_adc_client), GFP_KERNEL);
-	if (!client) {
-		dev_err(&pdev->dev, "no memory for adc client\n");
-		return ERR_PTR(-ENOMEM);
-	}
-
-	client->pdev = pdev;
-	client->is_ts = is_ts;
-	client->select_cb = select;
-	client->convert_cb = conv;
-
-	return client;
-}
-EXPORT_SYMBOL_GPL(s3c_adc_register);
-
-void s3c_adc_release(struct s3c_adc_client *client)
-{
-	/* We should really check that nothing is in progress. */
-	if (adc_dev->cur == client)
-		adc_dev->cur = NULL;
-	if (adc_dev->ts_pend == client)
-		adc_dev->ts_pend = NULL;
-	else {
-		struct list_head *p, *n;
-		struct s3c_adc_client *tmp;
-
-		list_for_each_safe(p, n, &adc_pending) {
-			tmp = list_entry(p, struct s3c_adc_client, pend);
-			if (tmp == client)
-				list_del(&tmp->pend);
-		}
-	}
-
-	if (adc_dev->cur == NULL)
-		s3c_adc_try(adc_dev);
-	kfree(client);
-}
-EXPORT_SYMBOL_GPL(s3c_adc_release);
-
-static irqreturn_t s3c_adc_irq(int irq, void *pw)
-{
-	struct adc_device *adc = pw;
-	struct s3c_adc_client *client = adc->cur;
-	unsigned long flags;
-	unsigned data0, data1;
-
-	if (!client) {
-		dev_warn(&adc->pdev->dev, "%s: no adc pending\n", __func__);
-		return IRQ_HANDLED;
-	}
-
-	data0 = readl(adc->regs + S3C2410_ADCDAT0);
-	data1 = readl(adc->regs + S3C2410_ADCDAT1);
-	adc_dbg(adc, "read %d: 0x%04x, 0x%04x\n", client->nr_samples, data0, data1);
-
-	client->nr_samples--;
-
-	if (client->convert_cb)
-		(client->convert_cb)(client, data0 & 0x3ff, data1 & 0x3ff,
-				     &client->nr_samples);
-
-	if (client->nr_samples > 0) {
-		/* fire another conversion for this */
-
-		client->select_cb(client, 1);
-		s3c_adc_convert(adc);
-	} else {
-		local_irq_save(flags);
-		(client->select_cb)(client, 0);
-		adc->cur = NULL;
-
-		s3c_adc_try(adc);
-		local_irq_restore(flags);
-	}
-
-	return IRQ_HANDLED;
-}
-
-static int s3c_adc_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct adc_device *adc;
-	struct resource *regs;
-	int ret;
-
-	adc = kzalloc(sizeof(struct adc_device), GFP_KERNEL);
-	if (adc == NULL) {
-		dev_err(dev, "failed to allocate adc_device\n");
-		return -ENOMEM;
-	}
-
-	adc->pdev = pdev;
-	adc->prescale = S3C2410_ADCCON_PRSCVL(49);
-
-	adc->irq = platform_get_irq(pdev, 1);
-	if (adc->irq <= 0) {
-		dev_err(dev, "failed to get adc irq\n");
-		ret = -ENOENT;
-		goto err_alloc;
-	}
-
-	ret = request_irq(adc->irq, s3c_adc_irq, 0, dev_name(dev), adc);
-	if (ret < 0) {
-		dev_err(dev, "failed to attach adc irq\n");
-		goto err_alloc;
-	}
-
-	adc->clk = clk_get(dev, "adc");
-	if (IS_ERR(adc->clk)) {
-		dev_err(dev, "failed to get adc clock\n");
-		ret = PTR_ERR(adc->clk);
-		goto err_irq;
-	}
-
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!regs) {
-		dev_err(dev, "failed to find registers\n");
-		ret = -ENXIO;
-		goto err_clk;
-	}
-
-	adc->regs = ioremap(regs->start, resource_size(regs));
-	if (!adc->regs) {
-		dev_err(dev, "failed to map registers\n");
-		ret = -ENXIO;
-		goto err_clk;
-	}
-
-	clk_enable(adc->clk);
-
-	writel(adc->prescale | S3C2410_ADCCON_PRSCEN,
-	       adc->regs + S3C2410_ADCCON);
-
-	dev_info(dev, "attached adc driver\n");
-
-	platform_set_drvdata(pdev, adc);
-	adc_dev = adc;
-
-	return 0;
-
- err_clk:
-	clk_put(adc->clk);
-
- err_irq:
-	free_irq(adc->irq, adc);
-
- err_alloc:
-	kfree(adc);
-	return ret;
-}
-
-static int s3c_adc_remove(struct platform_device *pdev)
-{
-	struct adc_device *adc = platform_get_drvdata(pdev);
-
-	iounmap(adc->regs);
-	free_irq(adc->irq, adc);
-	clk_disable(adc->clk);
-	clk_put(adc->clk);
-	kfree(adc);
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int s3c_adc_suspend(struct platform_device *pdev, pm_message_t state)
-{
-	struct adc_device *adc = platform_get_drvdata(pdev);
-	u32 con;
-
-	con = readl(adc->regs + S3C2410_ADCCON);
-	con |= S3C2410_ADCCON_STDBM;
-	writel(con, adc->regs + S3C2410_ADCCON);
-
-	clk_disable(adc->clk);
-
-	return 0;
-}
-
-static int s3c_adc_resume(struct platform_device *pdev)
-{
-	struct adc_device *adc = platform_get_drvdata(pdev);
-
-	clk_enable(adc->clk);
-
-	writel(adc->prescale | S3C2410_ADCCON_PRSCEN,
-	       adc->regs + S3C2410_ADCCON);
-
-	return 0;
-}
-
-#else
-#define s3c_adc_suspend NULL
-#define s3c_adc_resume NULL
-#endif
-
-static struct platform_driver s3c_adc_driver = {
-	.driver		= {
-		.name	= "s3c24xx-adc",
-		.owner	= THIS_MODULE,
-	},
-	.probe		= s3c_adc_probe,
-	.remove		= __devexit_p(s3c_adc_remove),
-	.suspend	= s3c_adc_suspend,
-	.resume		= s3c_adc_resume,
-};
-
-static int __init adc_init(void)
-{
-	int ret;
-
-	ret = platform_driver_register(&s3c_adc_driver);
-	if (ret)
-		printk(KERN_ERR "%s: failed to add adc driver\n", __func__);
-
-	return ret;
-}
-
-arch_initcall(adc_init);
diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index f52a92c..1b131e3 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -33,6 +33,7 @@
 #include <plat/regs-serial.h>
 #include <plat/udc.h>

+#include <plat/adc.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/regs-spi.h>
@@ -321,11 +322,16 @@ static struct resource s3c_adc_resource[] = {

 };

+static struct s3c_adc_platdata s3c_adc_pdata = {
+	.adc_type	= 0,
+};
+
 struct platform_device s3c_device_adc = {
-	.name		  = "s3c24xx-adc",
-	.id		  = -1,
-	.num_resources	  = ARRAY_SIZE(s3c_adc_resource),
-	.resource	  = s3c_adc_resource,
+	.name		   = "s3c-adc",
+	.id		   = -1,
+	.num_resources	   = ARRAY_SIZE(s3c_adc_resource),
+	.resource	   = s3c_adc_resource,
+	.dev.platform_data = &s3c_adc_pdata,
 };

 /* HWMON */
diff --git a/arch/arm/plat-s3c64xx/Makefile b/arch/arm/plat-s3c64xx/Makefile
index b85b435..8060017 100644
--- a/arch/arm/plat-s3c64xx/Makefile
+++ b/arch/arm/plat-s3c64xx/Makefile
@@ -35,6 +35,10 @@ obj-$(CONFIG_PM)		+= irq-pm.o

 obj-$(CONFIG_S3C64XX_DMA)	+= dma.o

+# ADC support
+
+obj-$(CONFIG_S3C_ADC)		+= dev-adc.o
+
 # Device setup

 obj-$(CONFIG_S3C64XX_SETUP_I2C0) += setup-i2c0.o
diff --git a/arch/arm/plat-s3c64xx/dev-adc.c b/arch/arm/plat-s3c64xx/dev-adc.c
new file mode 100644
index 0000000..5861ab3
--- /dev/null
+++ b/arch/arm/plat-s3c64xx/dev-adc.c
@@ -0,0 +1,51 @@
+/* linux/arch/arm/plat-s3c64xx/dev-adc.c
+ *
+ * Copyright 2009 Maurus Cuelenaere
+ *
+ * S3C64xx series device definition for ADC device
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+
+#include <mach/irqs.h>
+#include <mach/map.h>
+
+#include <plat/adc.h>
+#include <plat/devs.h>
+#include <plat/cpu.h>
+
+static struct resource s3c_adc_resource[] = {
+	[0] = {
+		.start = S3C64XX_PA_ADC,
+		.end   = S3C64XX_PA_ADC + SZ_256 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_TC,
+		.end   = IRQ_TC,
+		.flags = IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start = IRQ_ADC,
+		.end   = IRQ_ADC,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct s3c_adc_platdata s3c_adc_pdata = {
+	.adc_type	= 1,
+};
+
+struct platform_device s3c_device_adc = {
+	.name			= "s3c-adc",
+	.id			= -1,
+	.num_resources		= ARRAY_SIZE(s3c_adc_resource),
+	.resource		= s3c_adc_resource,
+	.dev.platform_data	= &s3c_adc_pdata,
+};
-- 
1.6.3.3
