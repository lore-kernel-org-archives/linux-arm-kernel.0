From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Fri, 13 Sep 2013 23:32:18 +1200
Subject: [RFC PATCH 2/3] Enable BCM2835 mailbox support
Message-ID: <5232F7C2.3070408@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reimplement BCM2835 mailbox support as a device registered with the
general purpose mailbox framework.

Signed-off-by: Craig McGeachie <slapdau@yahoo.com.au>
---

One specific area that I am looking for comment on is the device tree
design.  I'm not happy with the two attributes for channel numbers
and names that have to be matched up in terms of number of elements.
I would prefer something like

 mailbox {
 	compatible = "brcm,bcm2835-mbox";
  	reg = <0x7e00b800 0x400>;
 	reg = <0x7e00b880 0x40>;
 	interrupts = <0 1>;
	#address-cells = <1>;
	brcm,channel at 0 = {
		reg = <0>;
		brcm,channel-name = "power";
	};
	[...etc...]
 };

But I thought that might be too fussy, or too hard for a boot loader to
populate.

---
diff --git a/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
index 75dbb89..1779ad4 100644
--- a/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
+++ b/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
@@ -4,12 +4,19 @@ Required properties:
 
 - compatible : should be "brcm,bcm2835-mbox"
 - reg : Specifies base physical address and size of the registers.
-- interrupts : the interrupt number
+- interrupts : the interrupt number. Must be <0 1>, the mailbox interrupt.
+- brcm,channel-nums : The mailbox channels in use.
+- brcm,channel-names : list of symbolic channel names for mailbox clients to
+  use.
+
+The number of channel numbers must match the number of channel names.
 
 Example:
 
 mailbox {
 	compatible = "brcm,bcm2835-mbox";
-	reg = <0x7e00b800 0x400>;
+	reg = <0x7e00b880 0x40>;
 	interrupts = <0 1>;
+	brcm,channel-nums = <0 1 3 8>;
+	brcm,channel-names = "power", "fb", "vchiq", "property";
 };
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 4fc8a68..88855c0 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -33,6 +33,8 @@
 			compatible = "brcm,bcm2835-mbox";
 			reg = <0x7e00b880 0x40>;
 			interrupts = <0 1>;
+			brcm,channel-names = "power", "fb", "vchiq", "property";
+			brcm,channel-nums = <0 1 3 8>;
 		};
 
 		watchdog {
diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 34e9780..cc067bc 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -88,6 +88,8 @@ CONFIG_LEDS_TRIGGER_GPIO=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_LEDS_TRIGGER_TRANSIENT=y
 CONFIG_LEDS_TRIGGER_CAMERA=y
+CONFIG_MAILBOX=y
+CONFIG_BCM2835_MBOX=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
@@ -109,20 +111,20 @@ CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
 CONFIG_PRINTK_TIME=y
+CONFIG_BOOT_PRINTK_DELAY=y
+CONFIG_DYNAMIC_DEBUG=y
+CONFIG_DEBUG_INFO=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_UNUSED_SYMBOLS=y
-CONFIG_LOCKUP_DETECTOR=y
-CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_MEMORY_INIT=y
-CONFIG_BOOT_PRINTK_DELAY=y
+CONFIG_LOCKUP_DETECTOR=y
 CONFIG_SCHED_TRACER=y
 CONFIG_STACK_TRACER=y
 CONFIG_FUNCTION_PROFILER=y
-CONFIG_DYNAMIC_DEBUG=y
+CONFIG_TEST_KSTRTOX=y
 CONFIG_KGDB=y
 CONFIG_KGDB_KDB=y
-CONFIG_TEST_KSTRTOX=y
 CONFIG_STRICT_DEVMEM=y
 CONFIG_DEBUG_LL=y
 CONFIG_EARLY_PRINTK=y
diff --git a/arch/arm/mach-bcm2835/Makefile b/arch/arm/mach-bcm2835/Makefile
index 934ab42..4c3892f 100644
--- a/arch/arm/mach-bcm2835/Makefile
+++ b/arch/arm/mach-bcm2835/Makefile
@@ -1 +1 @@
-obj-y += bcm2835.o mailbox.o
+obj-y += bcm2835.o
diff --git a/arch/arm/mach-bcm2835/mailbox.c b/arch/arm/mach-bcm2835/mailbox.c
deleted file mode 100644
index cbc6898..0000000
--- a/arch/arm/mach-bcm2835/mailbox.c
+++ /dev/null
@@ -1,278 +0,0 @@
-/*
- *  Copyright (C) 2010 Broadcom
- *  Copyright (C) 2013 Lubomir Rintel
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This device provides a mechanism for writing to the mailboxes,
- * that are shared between the ARM and the VideoCore processor
- *
- * Parts of the driver are based on arch/arm/mach-bcm2708/vcio.c file
- * written by Gray Girling that was obtained from branch "rpi-3.6.y"
- * of git://github.com/raspberrypi/linux.git as well as documentation
- * available on the following web site:
- * https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface
- */
-
-#include <linux/module.h>
-#include <linux/completion.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/device.h>
-#include <linux/dma-mapping.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/kernel.h>
-
-#define BCM2835_MBOX_TIMEOUT HZ
-
-/* Mailboxes */
-#define ARM_0_MAIL0	0x00
-#define ARM_0_MAIL1	0x20
-
-/* Mailbox registers. We basically only support mailbox 0 & 1. We deliver to
- * the VC in mailbox 1, it delivers to us in mailbox 0. See BCM2835 ARM
- * Peripherals section 1.3 for an explanation about the placement of memory
- * barriers. */
-#define MAIL0_RD	(ARM_0_MAIL0 + 0x00)
-#define MAIL0_STA	(ARM_0_MAIL0 + 0x18)
-#define MAIL0_CNF	(ARM_0_MAIL0 + 0x1C)
-#define MAIL1_WRT	(ARM_0_MAIL1 + 0x00)
-
-/* Read/write Channels. Currently we just need the property one. */
-#define MBOX_CHAN_PROPERTY	8
-#define MBOX_CHAN_COUNT		9
-
-/* Status register: FIFO state. */
-#define ARM_MS_FULL		0x80000000
-#define ARM_MS_EMPTY		0x40000000
-
-/* Configuration register: Enable interrupts. */
-#define ARM_MC_IHAVEDATAIRQEN	0x00000001
-
-#define MBOX_MSG(chan, data28)		(((data28) & ~0xf) | ((chan) & 0xf))
-#define MBOX_CHAN(msg)			((msg) & 0xf)
-#define MBOX_DATA28(msg)		((msg) & ~0xf)
-
-static struct device *bcm2835_mbox_dev;	/* we assume there's only one! */
-
-struct bcm2835_mbox {
-	struct device *dev;
-	void __iomem *regs;
-	struct {
-		u32 msg;
-		struct completion comp;
-		struct mutex lock;
-	} chan[MBOX_CHAN_COUNT];
-};
-
-static irqreturn_t bcm2835_mbox_irq(int irq, void *dev_id)
-{
-	struct bcm2835_mbox *mbox = (struct bcm2835_mbox *)dev_id;
-	struct device *dev = mbox->dev;
-	int ret = IRQ_NONE;
-
-	/* wait for the mailbox FIFO to have some data in it */
-
-	while (!(readl(mbox->regs + MAIL0_STA) & ARM_MS_EMPTY)) {
-		u32 msg = readl(mbox->regs + MAIL0_RD);
-		unsigned int chan = MBOX_CHAN(msg);
-		rmb(); /* Finished last mailbox read. */
-
-		if (chan > MBOX_CHAN_COUNT) {
-			dev_err(dev, "invalid channel (%d)\n", chan);
-			continue;
-		}
-
-		if (mbox->chan[chan].msg) {
-			dev_err(dev, "overflow on channel (%d)\n", chan);
-			continue;
-		}
-
-		mbox->chan[chan].msg = msg;
-		complete(&mbox->chan[chan].comp);
-
-		ret = IRQ_HANDLED;
-	}
-
-	return ret;
-}
-
-/**
- * bcm2835_mbox_io() - send a message to BCM2835 mailbox and read a reply
- * @chan:	Channel number
- * @in28:	Message to send
- * @out28:	Where to put the response
- *
- * Sends a message to the BCM2835 mailbox.
- *
- * If the last argument is non-NULL, a response from VideoCore is awaited
- * for and written to memory pointed to by it.
- *
- * The I/O to property mailbox is more conveniently dealt with by using
- * bcm2835_mbox_property() function.
- *
- * Return: 0 in case of success, otherwise an error code
- */
-
-int bcm2835_mbox_io(unsigned chan, u32 in28, u32 *out28)
-{
-	struct bcm2835_mbox *mbox;
-	int timeout;
-	int ret = 0;
-
-	if (!bcm2835_mbox_dev)
-		return -ENODEV;
-
-	mbox = dev_get_drvdata(bcm2835_mbox_dev);
-
-	device_lock(bcm2835_mbox_dev);
-	/* wait for the mailbox FIFO to have some space in it */
-	while (readl(mbox->regs + MAIL0_STA) & ARM_MS_FULL)
-		cpu_relax();
-	rmb(); /* Finished last mailbox read. */
-
-	mutex_lock(&mbox->chan[chan].lock);
-	INIT_COMPLETION(mbox->chan[chan].comp);
-	wmb(); /* About to write to the mail box. */
-	writel(MBOX_MSG(chan, in28), mbox->regs + MAIL1_WRT);
-	device_unlock(bcm2835_mbox_dev);
-
-	timeout = wait_for_completion_timeout(&mbox->chan[chan].comp,
-						BCM2835_MBOX_TIMEOUT);
-	if (timeout  == 0) {
-		dev_warn(bcm2835_mbox_dev, "Channel %d timeout\n", chan);
-		ret = -ETIMEDOUT;
-		goto out;
-	}
-
-	if (out28 != NULL)
-		*out28 = MBOX_DATA28(mbox->chan[chan].msg);
-
-out:
-	mbox->chan[chan].msg = 0;
-	mutex_unlock(&mbox->chan[chan].lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(bcm2835_mbox_io);
-
-/**
- * bcm2835_mbox_property() - Call a BCM2835 Property mailbox service
- * @mem_bus:	DMA address of message
- *
- * Sends a message to the BCM2835 property mailbox and wait for VideoCore to
- * respond. The message memory should be obtained with dma_alloc_coherent()
- * and be filled with a properly formatted mailbox message.
- *
- * Return: 0 in case of success, otherwise an error code
- */
-
-int bcm2835_mbox_property(dma_addr_t mem_bus)
-{
-	int ret;
-	int val;
-
-	ret = bcm2835_mbox_io(MBOX_CHAN_PROPERTY, (u32)mem_bus, (u32 *)&val);
-	if (mem_bus != val) {
-		dev_warn(bcm2835_mbox_dev, "Bad response from property mailbox\n");
-		return -EIO;
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(bcm2835_mbox_property);
-
-static int bcm2835_mbox_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct bcm2835_mbox *mbox;
-	int irq;
-	int ret;
-	int i;
-	struct resource *iomem;
-
-	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
-	if (mbox == NULL) {
-		dev_err(dev, "Failed to allocate mailbox memory\n");
-		return -ENOMEM;
-	}
-
-	/* Initialize the channels */
-	for (i = 0; i < MBOX_CHAN_COUNT; i++) {
-		mbox->chan[i].msg = 0;
-		init_completion(&mbox->chan[i].comp);
-		mutex_init(&mbox->chan[i].lock);
-	}
-
-	platform_set_drvdata(pdev, mbox);
-	mbox->dev = dev;
-
-	irq = irq_of_parse_and_map(np, 0);
-	if (irq <= 0) {
-		dev_err(dev, "Can't get IRQ number for mailbox\n");
-		return -ENODEV;
-	}
-	ret = devm_request_irq(dev, irq, bcm2835_mbox_irq, IRQF_SHARED,
-						dev_name(dev), mbox);
-	if (ret) {
-		dev_err(dev, "Failed to register a mailbox IRQ handler\n");
-		return -ENODEV;
-	}
-
-	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mbox->regs = devm_request_and_ioremap(&pdev->dev, iomem);
-	if (!mbox->regs) {
-		dev_err(dev, "Failed to remap mailbox regs\n");
-		return -ENODEV;
-	}
-
-	/* Enable the interrupt on data reception */
-	writel(ARM_MC_IHAVEDATAIRQEN, mbox->regs + MAIL0_CNF);
-
-	dev_info(dev, "Broadcom BCM2835 mailbox IPC");
-	bcm2835_mbox_dev = dev;
-
-	return 0;
-}
-
-static int bcm2835_mbox_remove(struct platform_device *pdev)
-{
-	bcm2835_mbox_dev = NULL;
-	return 0;
-}
-
-static const struct of_device_id bcm2835_mbox_of_match[] = {
-	{ .compatible = "brcm,bcm2835-mbox", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, bcm2835_mbox_of_match);
-
-static struct platform_driver bcm2835_mbox_driver = {
-	.driver = {
-		.name = "bcm2835-mbox",
-		.owner = THIS_MODULE,
-		.of_match_table = bcm2835_mbox_of_match,
-	},
-	.probe		= bcm2835_mbox_probe,
-	.remove		= bcm2835_mbox_remove,
-};
-module_platform_driver(bcm2835_mbox_driver);
-
-/*
-static int __init bcm2835_mbox_init(void)
-{
-	return platform_driver_register(&bcm2835_mbox_driver);
-}
-
-arch_initcall(bcm2835_mbox_init);
-*/
-
-MODULE_AUTHOR("Lubomir Rintel");
-MODULE_DESCRIPTION("BCM2835 mailbox IPC driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index c8b5c13..b8bb414 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -50,4 +50,13 @@ config OMAP_MBOX_KFIFO_SIZE
 	  Specify the default size of mailbox's kfifo buffers (bytes).
 	  This can also be changed at runtime (via the mbox_kfifo_size
 	  module parameter).
+
+config BCM2835_MBOX
+	bool "BCM2835 Mailbox"
+	depends on ARCH_BCM2835
+	help
+	  An implementation of the BCM2385 Mailbox.  It is used to invoke
+	  the services of the Videocore. Say Y here if you want to use the
+	  BCM2835 Mailbox.
+
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 2fa343a..a682306 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_OMAP1_MBOX)	+= mailbox_omap1.o
 mailbox_omap1-objs		:= mailbox-omap1.o
 obj-$(CONFIG_OMAP2PLUS_MBOX)	+= mailbox_omap2.o
 mailbox_omap2-objs		:= mailbox-omap2.o
+obj-$(CONFIG_BCM2835_MBOX)	+= bcm2835-mbox.o
diff --git a/drivers/mailbox/bcm2835-mbox.c b/drivers/mailbox/bcm2835-mbox.c
new file mode 100644
index 0000000..e2b271a
--- /dev/null
+++ b/drivers/mailbox/bcm2835-mbox.c
@@ -0,0 +1,334 @@
+/*
+ *  Copyright (C) 2010 Broadcom
+ *  Copyright (C) 2013 Lubomir Rintel
+ *  Copyright (C) 2013 Craig McGeachie
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This device provides a mechanism for writing to the mailboxes,
+ * that are shared between the ARM and the VideoCore processor
+ *
+ * Parts of the driver are based on:
+ *  - arch/arm/mach-bcm2708/vcio.c file written by Gray Girling that was
+ *    obtained from branch "rpi-3.6.y" of git://github.com/raspberrypi/
+ *    linux.git
+ *  - drivers/mailbox/bcm2835-ipc.c by Lubomir Rintel at
+ *    https://github.com/hackerspace/rpi-linux/blob/lr-raspberry-pi/drivers/
+ *    mailbox/bcm2835-ipc.c
+ *  - documentation available on the following web site:
+ *    https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_controller.h>
+#include <linux/err.h>
+#include <linux/spinlock.h>
+
+/* Mailboxes */
+#define ARM_0_MAIL0	0x00
+#define ARM_0_MAIL1	0x20
+
+/* Mailbox registers. We basically only support mailbox 0 & 1. We deliver to
+ * the VC in mailbox 1, it delivers to us in mailbox 0. See BCM2835 ARM
+ * Peripherals section 1.3 for an explanation about the placement of memory
+ * barriers. */
+#define MAIL0_RD	(ARM_0_MAIL0 + 0x00)
+#define MAIL0_POL	(ARM_0_MAIL0 + 0x10)
+#define MAIL0_STA	(ARM_0_MAIL0 + 0x18)
+#define MAIL0_CNF	(ARM_0_MAIL0 + 0x1C)
+#define MAIL1_WRT	(ARM_0_MAIL1 + 0x00)
+
+#define MBOX_CHAN_COUNT		16
+
+/* Status register: FIFO state. */
+#define ARM_MS_FULL		0x80000000
+#define ARM_MS_EMPTY		0x40000000
+
+/* Configuration register: Enable interrupts. */
+#define ARM_MC_IHAVEDATAIRQEN	0x00000001
+
+#define MBOX_MSG(chan, data28)		(((data28) & ~0xf) | ((chan) & 0xf))
+#define MBOX_CHAN(msg)			((msg) & 0xf)
+#define MBOX_DATA28(msg)		((msg) & ~0xf)
+
+struct bcm2835_mbox;
+
+struct bcm2835_channel {
+	struct bcm2835_mbox *mbox;
+	struct ipc_link link;
+	u32 chan_num;
+	const char *name;
+	bool started;
+};
+
+struct bcm2835_mbox {
+	struct platform_device *pdev;
+	struct device *dev;
+	void __iomem *regs;
+	spinlock_t lock;
+	struct bcm2835_channel *channel[MBOX_CHAN_COUNT];
+	struct ipc_controller controller;
+};
+
+#define to_channel(link) container_of(link, struct bcm2835_channel, link)
+
+static irqreturn_t bcm2835_mbox_irq(int irq, void *dev_id)
+{
+	struct bcm2835_mbox *mbox = (struct bcm2835_mbox *) dev_id;
+	struct device *dev = mbox->dev;
+	while (!(readl(mbox->regs + MAIL0_STA) & ARM_MS_EMPTY)) {
+		u32 msg = readl(mbox->regs + MAIL0_RD);
+		unsigned int chan = MBOX_CHAN(msg);
+
+		if (!mbox->channel[chan]) {
+			dev_err(dev, "Unregistered channel %d\n", chan);
+			continue;
+		}
+		if (!mbox->channel[chan]->started) {
+			dev_err(dev, "Reply on stopped channel %d\n", chan);
+			continue;
+		}
+		dev_dbg(dev, "Reply 0x%08X\n", msg);
+		ipc_link_received_data(&mbox->channel[chan]->link,
+			(void *) MBOX_DATA28(msg));
+	}
+	rmb(); /* Finished last mailbox read. */
+	return IRQ_HANDLED;
+}
+
+static int bcm2835_send_data(struct ipc_link *link, void *data)
+{
+	struct bcm2835_channel *chan = to_channel(link);
+	struct bcm2835_mbox *mbox = chan->mbox;
+	int ret = 0;
+
+	if (!chan->started)
+		return -ENODEV;
+	spin_lock(&mbox->lock);
+	if (readl(mbox->regs + MAIL0_STA) & ARM_MS_FULL) {
+		rmb(); /* Finished last mailbox read. */
+		ret = -EBUSY;
+		goto end;
+	}
+	wmb(); /* About to write to the mail box. */
+	writel(MBOX_MSG(chan->chan_num, (u32) data), mbox->regs + MAIL1_WRT);
+	dev_dbg(mbox->dev, "Request 0x%08X\n", MBOX_MSG(chan->chan_num,
+		(u32) data));
+end:
+	spin_unlock(&mbox->lock);
+	return ret;
+}
+
+static int bcm2835_startup(struct ipc_link *link, void *params)
+{
+	struct bcm2835_channel *chan = to_channel(link);
+	chan->started = true;
+	return 0;
+}
+
+static void bcm2835_shutdown(struct ipc_link *link)
+{
+	struct bcm2835_channel *chan = to_channel(link);
+	chan->started = false;
+}
+
+static bool bcm2835_is_ready(struct ipc_link *link)
+{
+	struct bcm2835_channel *chan = to_channel(link);
+	struct bcm2835_mbox *mbox = chan->mbox;
+	bool ret;
+
+	if (!chan->started)
+		return false;
+	spin_lock(&mbox->lock);
+	ret = !(readl(mbox->regs + MAIL0_STA) & ARM_MS_FULL);
+	rmb();
+	spin_unlock(&mbox->lock);
+	return ret;
+}
+
+static struct ipc_link_ops bcm2835_ipc_link_ops = {
+	.send_data	= bcm2835_send_data,
+	.startup	= bcm2835_startup,
+	.shutdown	= bcm2835_shutdown,
+	.is_ready	= bcm2835_is_ready
+};
+
+static int request_mailbox_iomem(struct bcm2835_mbox *mbox)
+{
+	struct platform_device *pdev = mbox->pdev;
+	struct resource *iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dev_dbg(&pdev->dev, "iomem 0x%08X-0x%08X\n", iomem->start, iomem->end);
+	mbox->regs = devm_ioremap_resource(&pdev->dev, iomem);
+	dev_dbg(&pdev->dev, "registers at [0x%p]\n", mbox->regs);
+	if (IS_ERR(mbox->regs)) {
+		dev_err(&pdev->dev, "Failed to remap mailbox regs\n");
+		return PTR_ERR(mbox->regs);
+	}
+	dev_dbg(&pdev->dev, "iomem registered\n");
+	return 0;
+}
+
+static int request_mailbox_irq(struct bcm2835_mbox *mbox)
+{
+	int ret;
+	struct device *dev = mbox->dev;
+	struct device_node *np = dev->of_node;
+	int irq = irq_of_parse_and_map(np, 0);
+
+	if (irq <= 0) {
+		dev_err(dev, "Can't get IRQ number for mailbox\n");
+		return -ENODEV;
+	}
+	ret = devm_request_irq(dev, irq, bcm2835_mbox_irq, 0, dev_name(dev),
+		mbox);
+	if (ret) {
+		dev_err(dev, "Failed to register a mailbox IRQ handler\n");
+		return -ENODEV;
+	}
+	dev_dbg(dev, "Registered IRQ\n");
+	return 0;
+}
+
+static int parse_bcm2835_channels(struct bcm2835_mbox *mbox)
+{
+	struct device *dev = mbox->dev;
+	struct device_node *np = dev->of_node;
+	int chan_cnt, dsize;
+	unsigned int i, blk_size;
+	void *channel_blk, *links_blk;
+
+	chan_cnt = of_property_count_strings(np, "brcm,channel-names");
+	if (!chan_cnt) {
+		dev_err(dev, "No channels defined\n");
+		return -ENODEV;
+	}
+	of_get_property(np, "brcm,channel-nums", &dsize);
+	if (dsize != sizeof(u32) * chan_cnt) {
+		dev_err(dev, "Counts of brcm,channel-names and brcm,channel-nums mismatch\n");
+		return -ENODEV;
+	}
+	blk_size = sizeof(struct bcm2835_channel) * chan_cnt +
+		sizeof(struct ipc_link *) * (chan_cnt + 1);
+	channel_blk = devm_kzalloc(dev, blk_size, GFP_KERNEL);
+	if (!channel_blk) {
+		dev_err(dev, "Failed to alloc ipc_links\n");
+		return -ENOMEM;
+	}
+	links_blk = channel_blk + sizeof(struct bcm2835_channel) * chan_cnt;
+	mbox->controller.links = (struct ipc_link **) links_blk;
+	for (i = 0; i != chan_cnt; ++i) {
+		struct bcm2835_channel *channel =
+			&((struct bcm2835_channel *)channel_blk)[i];
+		if (of_property_read_string_index(np, "brcm,channel-names", i,
+			&channel->name)) {
+			dev_err(dev, "Channel name index %d read failed\n", i);
+			return -ENODEV;
+		}
+		if (of_property_read_u32_index(np, "brcm,channel-nums", i,
+			&channel->chan_num)) {
+			dev_err(dev, "Channel num index %d read failed\n", i);
+			return -ENODEV;
+		}
+		if (channel->chan_num >= MBOX_CHAN_COUNT) {
+			dev_err(dev, "Channel num %d too big\n",
+				channel->chan_num);
+			return -ENODEV;
+		}
+		snprintf(channel->link.link_name, 16, channel->name);
+		channel->mbox = mbox;
+		mbox->channel[channel->chan_num] = channel;
+		mbox->controller.links[i] = &channel->link;
+
+	}
+	mbox->controller.links[chan_cnt] = NULL;
+	dev_dbg(dev, "Channels parsed\n");
+
+	return 0;
+}
+
+static int bcm2835_mbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct bcm2835_mbox *mbox;
+	int ret = 0;
+
+	dev_dbg(dev, "Probing\n");
+	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
+	if (mbox == NULL) {
+		dev_err(dev, "Failed to allocate mailbox memory\n");
+		ret = -ENOMEM;
+		goto end;
+	}
+	platform_set_drvdata(pdev, mbox);
+	mbox->pdev = pdev;
+	mbox->dev = dev;
+	spin_lock_init(&mbox->lock);
+
+	dev_dbg(dev, "Requesting IRQ\n");
+	ret = request_mailbox_irq(mbox);
+	if (ret)
+		goto end;
+	dev_dbg(dev, "Requesting iomem\n");
+	ret = request_mailbox_iomem(mbox);
+	if (ret)
+		goto end;
+
+	dev_dbg(dev, "Parsing channels\n");
+	ret = parse_bcm2835_channels(mbox);
+	if (ret)
+		goto end;
+
+	dev_dbg(dev, "Initialising mailbox controller\n");
+	snprintf(mbox->controller.controller_name, 16, "bcm2835");
+	mbox->controller.txdone_poll = true;
+	mbox->controller.txpoll_period = 5;
+	mbox->controller.ops = &bcm2835_ipc_link_ops;
+	ret  = ipc_links_register(&mbox->controller);
+	if (ret)
+		goto end;
+	/* Enable the interrupt on data reception */
+	writel(ARM_MC_IHAVEDATAIRQEN, mbox->regs + MAIL0_CNF);
+	dev_info(dev, "mailbox enabled\n");
+
+end:
+	return ret;
+}
+
+static int bcm2835_mbox_remove(struct platform_device *pdev)
+{
+	struct bcm2835_mbox *mbox = platform_get_drvdata(pdev);
+	ipc_links_unregister(&mbox->controller);
+	return 0;
+}
+
+static const struct of_device_id bcm2835_mbox_of_match[] = {
+	{ .compatible = "brcm,bcm2835-mbox", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, bcm2835_mbox_of_match);
+
+static struct platform_driver bcm2835_mbox_driver = {
+	.driver = {
+		.name = "bcm2835-mbox",
+		.owner = THIS_MODULE,
+		.of_match_table = bcm2835_mbox_of_match,
+	},
+	.probe		= bcm2835_mbox_probe,
+	.remove		= bcm2835_mbox_remove,
+};
+module_platform_driver(bcm2835_mbox_driver);
+
+MODULE_AUTHOR("Craig McGeachie");
+MODULE_DESCRIPTION("BCM2835 mailbox IPC driver");
+MODULE_LICENSE("GPL v2");
