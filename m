From: pettno@gmail.com (Petter Nordby)
Date: Mon, 23 Jan 2012 12:25:06 +0100
Subject: [PATCH 1/1] ARM: Developed device driver for Atmel TSADC controller
In-Reply-To: <n>
References: <n>
Message-ID: <1327317907-2874-1-git-send-email-pettno@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some Atmel AT91 devices contains a touchscreen analog to digital
converter. This device driver use the ADC as a multi-channel raw
data input device.

Tested on AT91SAM9G45 boards.

Signed-off-by: Petter Nordby <pettno@gmail.com>
---
 CREDITS                                    |    4 +
 arch/arm/configs/at91sam9g45_defconfig     |    1 +
 arch/arm/mach-at91/include/mach/at91_adc.h |   16 ++
 drivers/misc/Kconfig                       |    7 +
 drivers/misc/Makefile                      |    1 +
 drivers/misc/atmel_tsadc.c                 |  361 ++++++++++++++++++++++++++++
 6 files changed, 390 insertions(+), 0 deletions(-)
 create mode 100644 drivers/misc/atmel_tsadc.c

diff --git a/CREDITS b/CREDITS
index 370b4c7..8c615eb 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2652,6 +2652,10 @@ S: 2364 Old Trail Drive
 S: Reston, Virginia 20191
 S: USA
 
+N: Petter Nordby
+E: pettno at gmail.com
+D: Atmel ADC device driver
+
 N: Fredrik Noring
 E: noring at nocrew.org
 W: http://www.lysator.liu.se/~noring/
diff --git a/arch/arm/configs/at91sam9g45_defconfig b/arch/arm/configs/at91sam9g45_defconfig
index 606d48f..748caca 100644
--- a/arch/arm/configs/at91sam9g45_defconfig
+++ b/arch/arm/configs/at91sam9g45_defconfig
@@ -15,6 +15,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
+CONFIG_CROSS_COMPILE="arm-linux-"
 CONFIG_ARCH_AT91=y
 CONFIG_ARCH_AT91SAM9G45=y
 CONFIG_MACH_AT91SAM9M10G45EK=y
diff --git a/arch/arm/mach-at91/include/mach/at91_adc.h b/arch/arm/mach-at91/include/mach/at91_adc.h
index 8e7ed5c..b665d61 100644
--- a/arch/arm/mach-at91/include/mach/at91_adc.h
+++ b/arch/arm/mach-at91/include/mach/at91_adc.h
@@ -29,12 +29,28 @@
 #define		AT91_ADC_LOWRES		(1 << 4)	/* Low Resolution */
 #define		AT91_ADC_SLEEP		(1 << 5)	/* Sleep Mode */
 #define		AT91_ADC_PRESCAL	(0x3f << 8)	/* Prescalar Rate Selection */
+#define			AT91_ADC_EPRESCAL	(0xff << 8)	/* Prescalar Rate Selection (Extended) */
 #define			AT91_ADC_PRESCAL_(x)	((x) << 8)
 #define		AT91_ADC_STARTUP	(0x1f << 16)	/* Startup Up Time */
 #define			AT91_ADC_STARTUP_(x)	((x) << 16)
 #define		AT91_ADC_SHTIM		(0xf  << 24)	/* Sample & Hold Time */
 #define			AT91_ADC_SHTIM_(x)	((x) << 24)
 
+#define AT91_ADC_TRGR		0x08		/* Trigger register */
+#define		AT91_ADC_TRGMOD	(7      <<  0)	/* Trigger mode */
+#define			AT91_ADC_TRGMOD_NONE		(0 << 0)
+#define			AT91_ADC_TRGMOD_EXT_RISING	(1 << 0)
+#define			AT91_ADC_TRGMOD_EXT_FALLING	(2 << 0)
+#define			AT91_ADC_TRGMOD_EXT_ANY		(3 << 0)
+#define			AT91_ADC_TRGMOD_PENDET		(4 << 0)
+#define			AT91_ADC_TRGMOD_PERIOD		(5 << 0)
+#define			AT91_ADC_TRGMOD_CONTINUOUS	(6 << 0)
+#define			AT91_ADC_TRGPER	(0xffff << 16)	/* Trigger period */
+
+#define AT91_ADC_TSR	0x0C	/* Touch Screen register */
+#define	  AT91_ADC_TSFREQ	(0xf <<  0)	/* TS Frequency in Interleaved mode */
+#define	  AT91_ADC_TSSHTIM	(0xf << 24)	/* Sample & Hold time */
+
 #define AT91_ADC_CHER		0x10		/* Channel Enable Register */
 #define AT91_ADC_CHDR		0x14		/* Channel Disable Register */
 #define AT91_ADC_CHSR		0x18		/* Channel Status Register */
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 6a1a092..d105f42 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -112,6 +112,13 @@ config ATMEL_TCB_CLKSRC_BLOCK
 	  TC can be used for other purposes, such as PWM generation and
 	  interval timing.
 
+config ATMEL_TSADC
+	tristate "Atmel touchscreen ADC char device driver"
+	depends on ARCH_AT91SAM9RL || ARCH_AT91SAM9G45
+	help
+	  Say Y here if you want to use the touchscreen ADC controller
+	  as a simple ADC input device.
+
 config IBM_ASM
 	tristate "Device driver for IBM RSA service processor"
 	depends on X86 && PCI && INPUT && EXPERIMENTAL
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 3e1d801..b6a13a1 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_INTEL_MID_PTI)	+= pti.o
 obj-$(CONFIG_ATMEL_PWM)		+= atmel_pwm.o
 obj-$(CONFIG_ATMEL_SSC)		+= atmel-ssc.o
 obj-$(CONFIG_ATMEL_TCLIB)	+= atmel_tclib.o
+obj-$(CONFIG_ATMEL_TSADC)	+= atmel_tsadc.o
 obj-$(CONFIG_BMP085)		+= bmp085.o
 obj-$(CONFIG_ICS932S401)	+= ics932s401.o
 obj-$(CONFIG_LKDTM)		+= lkdtm.o
diff --git a/drivers/misc/atmel_tsadc.c b/drivers/misc/atmel_tsadc.c
new file mode 100644
index 0000000..778bd4f
--- /dev/null
+++ b/drivers/misc/atmel_tsadc.c
@@ -0,0 +1,361 @@
+/*
+ *  Atmel Touch Screen Driver in ADC only mode
+ *
+ *  Copyright (c) 2012 Petter Nordby
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/interrupt.h>
+#include <linux/clk.h>
+#include <linux/uaccess.h>
+#include <linux/ioport.h>
+#include <linux/io.h>
+
+#include <asm/system.h>
+
+#include <mach/cpu.h>
+#include <mach/gpio.h>
+#include <mach/at91sam9g45.h>
+#include <mach/at91_adc.h>
+
+#define DEVICE_NAME "at-tsadc"
+#define NO_OF_CHANNELS 4
+#define NO_OF_SAMPLES  4
+
+static int major;
+static int minor;
+
+static void __iomem *tsadc_base;
+
+#define tsadc_readl(reg)		__raw_readl(tsadc_base + (reg))
+#define tsadc_writel(reg, val)	__raw_writel((val), tsadc_base + (reg))
+
+#define PRESCALER_VAL(x)	((x) >> 8)
+#define ADC_DEFAULT_CLOCK	100000
+
+
+struct tsadc_dev {
+	int id;
+	unsigned long tsadc_base;
+	unsigned long tsadc_size;
+	struct cdev cdev;
+
+	struct clk *clk;
+	unsigned int value[NO_OF_CHANNELS][NO_OF_SAMPLES];
+	unsigned int sample_no[NO_OF_CHANNELS];
+	unsigned int adc_clock;
+	u8 ts_sample_hold_time;
+};
+
+static struct tsadc_dev dev = {
+	.id = AT91SAM9G45_ID_TSC,
+	.tsadc_base = AT91SAM9G45_BASE_TSC,
+	.tsadc_size = SZ_16K,
+	.cdev = {
+		.kobj = { .name = DEVICE_NAME, },
+		.owner = THIS_MODULE,
+	},
+	.adc_clock = 300000,
+	.ts_sample_hold_time = 0x0a,
+};
+
+static dev_t devt;
+
+
+static irqreturn_t tsadc_interrupt(int irq, void *pdev)
+{
+	unsigned int ch, status, sample_no, sample;
+	status = tsadc_readl(AT91_ADC_SR);
+	status &= tsadc_readl(AT91_ADC_IMR);
+
+	for (ch = 0; ch < NO_OF_CHANNELS; ch++) {
+
+		/* Conversion finished? */
+		if (status & AT91_ADC_EOC(ch)) {
+
+			/* Store new measurement */
+			sample = tsadc_readl(AT91_ADC_CHR(ch)) & 0x3FF;
+			sample_no = dev.sample_no[ch];
+			dev.value[ch][sample_no] = sample;
+			dev.sample_no[ch] = (sample_no+1) % NO_OF_SAMPLES;
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+
+/***************************************************************************
+************************************ READ **********************************
+***************************************************************************/
+
+static ssize_t tsadc_read(struct file *filp, char *buff,
+	size_t length, loff_t *offp)
+{
+	unsigned long flags;
+	unsigned int sample_no, ch, i, bytes_read = 0;
+	u32 value = 0;
+	u8 *pv = (u8 *)&value;
+
+	/* Range check channel number */
+	ch = iminor(filp->f_dentry->d_inode);
+	if ((ch < 0) || (ch >= NO_OF_CHANNELS))
+		return -EFAULT;
+
+	/********** Start of critical section **********/
+	local_irq_save(flags);
+
+	for (sample_no = 0; sample_no < NO_OF_SAMPLES; sample_no++)
+		value += dev.value[ch][sample_no];
+	value = value / NO_OF_SAMPLES;
+
+	for (i = 0; length && (i < 4); i++) {
+		put_user(pv[i], buff++);
+		length--;
+		bytes_read++;
+	}
+
+	/********** End of critical section **********/
+	local_irq_restore(flags);
+
+	return bytes_read;
+}
+
+
+/***************************************************************************
+******************************* CONFIGURATION ******************************
+***************************************************************************/
+
+static int tsadc_init_hw(void)
+{
+	unsigned int ch, prsc, mode_reg;
+
+	clk_enable(dev.clk);
+	prsc = clk_get_rate(dev.clk);
+	printk(KERN_INFO "Master clock is set at: %d Hz\n", prsc);
+
+	if (!dev.adc_clock)
+		dev.adc_clock = ADC_DEFAULT_CLOCK;
+	for (ch = 0; ch < NO_OF_CHANNELS; ch++)
+		dev.sample_no[ch] = 0;
+
+	prsc = (prsc / (2 * dev.adc_clock)) - 1;
+
+	/* saturate if this value is too high */
+	if (cpu_is_at91sam9rl()) {
+		if (prsc > PRESCALER_VAL(AT91_ADC_PRESCAL))
+			prsc = PRESCALER_VAL(AT91_ADC_PRESCAL);
+	} else {
+		if (prsc > PRESCALER_VAL(AT91_ADC_EPRESCAL))
+			prsc = PRESCALER_VAL(AT91_ADC_EPRESCAL);
+	}
+
+	printk(KERN_INFO "Prescaler is set at: %d\n", prsc);
+
+	tsadc_writel(AT91_ADC_CR, AT91_ADC_SWRST);
+	mode_reg = ((0x00 << 5) & AT91_ADC_SLEEP) | /* ADC only mode */
+		(prsc << 8) |
+		((0x26 << 16) & AT91_ADC_STARTUP);
+	tsadc_writel(AT91_ADC_MR, mode_reg);
+
+	for (ch = 0; ch < NO_OF_CHANNELS; ch++)
+		tsadc_writel(AT91_ADC_CHER, AT91_ADC_CH(ch));
+	tsadc_writel(AT91_ADC_TRGR, AT91_ADC_TRGMOD_PERIOD | (0xFFFF << 16));
+
+	/* ADC clock = Master clock / ((prsc+1)*2) */
+	/* Trigger period = (0xFFFF+1) / ADC clock */
+
+	tsadc_writel(AT91_ADC_TSR,
+		(dev.ts_sample_hold_time << 24) & AT91_ADC_TSSHTIM);
+
+	tsadc_readl(AT91_ADC_SR);
+	for (ch = 0; ch < NO_OF_CHANNELS; ch++)
+		tsadc_writel(AT91_ADC_IER, AT91_ADC_EOC(ch));
+
+	return 0;
+}
+
+
+#define TSADC_IOC_MAGIC 0xA2
+#define TSADC_IOC_SET_CLK _IO(TSADC_IOC_MAGIC, 0x80)
+#define TSADC_IOC_GET_CLK _IO(TSADC_IOC_MAGIC, 0x81)
+
+static long tsadc_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	int ch = iminor(filp->f_dentry->d_inode);
+
+	/* Range check channel number */
+	if ((ch < 0) || (ch >= NO_OF_CHANNELS))
+		return -ENODEV;
+
+	switch (cmd) {
+	case TSADC_IOC_SET_CLK:
+		if (copy_from_user(&dev.adc_clock, (unsigned int *) arg,
+				sizeof(unsigned int)))
+			return -EFAULT;
+		return tsadc_init_hw();
+		break;
+
+	case TSADC_IOC_GET_CLK:
+		if (copy_to_user((unsigned int *) arg, &dev.adc_clock,
+				sizeof(unsigned int)))
+			return -EFAULT;
+		break;
+
+	default:
+		printk(KERN_INFO "Unsupported ioctl command (%u)\n", cmd);
+		return -ENOIOCTLCMD;
+	}
+	return 0;
+}
+
+
+/***************************************************************************
+******************************* OPEN - CLOSE *******************************
+***************************************************************************/
+
+static int tsadc_open(struct inode *inode, struct file *filp)
+{
+	int ch = iminor(inode);
+
+	/* Range check channel number */
+	if ((ch < 0) || (ch >= NO_OF_CHANNELS))
+		return -ENODEV;
+
+	try_module_get(THIS_MODULE);
+	return 0;
+}
+
+
+static int tsadc_release(struct inode *inode, struct file *filp)
+{
+	int ch = iminor(inode);
+
+	/* Range check channel number */
+	if ((ch < 0) || (ch >= NO_OF_CHANNELS))
+		return -ENODEV;
+
+	module_put(THIS_MODULE);
+	return 0;
+}
+
+
+const struct file_operations tsadc_fops = {
+	.owner = THIS_MODULE,
+	.read = tsadc_read,
+	.unlocked_ioctl = tsadc_ioctl,  /* supported if kernel >= 2.6.11 */
+	.open = tsadc_open,
+	.release = tsadc_release,
+};
+
+
+/***************************************************************************
+*************************** CONSTRUCT - DESTRUCT ***************************
+***************************************************************************/
+
+static int __init tsadc_init(void)
+{
+	int result;
+	printk(KERN_INFO "Initialize char device driver for touchscreen ADC\n");
+
+	if (!request_mem_region(dev.tsadc_base, dev.tsadc_size, DEVICE_NAME)) {
+		printk(KERN_ALERT "Can't get mem region 0x%lx\n", dev.tsadc_base);
+		result = -ENODEV;
+		goto err_request_mem_region;
+	}
+
+	tsadc_base = ioremap(dev.tsadc_base, dev.tsadc_size);
+	if (!tsadc_base) {
+		printk(KERN_ALERT "Failed to map registers\n");
+		result = -ENOMEM;
+		goto err_ioremap;
+	}
+
+	result = alloc_chrdev_region(&devt, minor, NO_OF_CHANNELS, DEVICE_NAME);
+	if (result < 0) {
+		printk(KERN_ALERT "Allocate device region failed (%d)\n", result);
+		goto err_alloc_chrdev_region;
+	}
+	major = MAJOR(devt);
+	printk(KERN_INFO "Device number: Major=%d Minor=%d\n", major, minor);
+
+	cdev_init(&dev.cdev, &tsadc_fops);
+	dev.cdev.owner = THIS_MODULE;
+	dev.cdev.ops = &tsadc_fops;
+	result = cdev_add(&dev.cdev, devt, NO_OF_CHANNELS);
+	if (result) {
+		printk(KERN_ALERT "Error %d adding cdev\n", result);
+		goto err_cdev_add;
+	}
+
+	result = request_irq(dev.id, tsadc_interrupt, IRQF_DISABLED,
+		DEVICE_NAME, &dev);
+	if (result) {
+		printk(KERN_ALERT "Error %d on request irq %d\n",
+			result, dev.id);
+		goto err_request_irq;
+	}
+
+	dev.clk = clk_get(NULL, "tsc_clk");
+	if (IS_ERR(dev.clk)) {
+		printk(KERN_ALERT "Failed to get ts_clk\n");
+		result = PTR_ERR(dev.clk);
+		goto err_clk_get;
+	}
+
+	at91_set_gpio_input(AT91_PIN_PD20, 0);	/* AD0_XR */
+	at91_set_gpio_input(AT91_PIN_PD21, 0);	/* AD1_XL */
+	at91_set_gpio_input(AT91_PIN_PD22, 0);	/* AD2_YT */
+	at91_set_gpio_input(AT91_PIN_PD23, 0);	/* AD3_TB */
+
+	return tsadc_init_hw();
+
+	clk_disable(dev.clk);
+	clk_put(dev.clk);
+err_clk_get:
+	disable_irq(dev.id);
+	free_irq(dev.id, &dev);
+err_request_irq:
+	cdev_del(&dev.cdev);
+err_cdev_add:
+	unregister_chrdev_region(devt, NO_OF_CHANNELS);
+err_alloc_chrdev_region:
+	iounmap(tsadc_base);
+err_ioremap:
+	release_mem_region(dev.tsadc_base, dev.tsadc_size);
+err_request_mem_region:
+	return result;
+}
+
+
+static void __exit tsadc_exit(void)
+{
+	printk(KERN_INFO "Clean up after char device driver for touchscreen ADC\n");
+
+	/* Stop tsadc hardware */
+	tsadc_writel(AT91_ADC_TRGR, 0);
+
+	disable_irq(dev.id);
+	free_irq(dev.id, &dev);
+	cdev_del(&dev.cdev);
+	unregister_chrdev_region(devt, NO_OF_CHANNELS);
+	iounmap(tsadc_base);
+	release_mem_region(dev.tsadc_base, dev.tsadc_size);
+	clk_disable(dev.clk);
+	clk_put(dev.clk);
+}
+
+module_init(tsadc_init);
+module_exit(tsadc_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Simple char device driver for touchscreen ADC in AT91");
+MODULE_AUTHOR("Petter Nordby <pettno@gmail.com>");
-- 
1.7.7
