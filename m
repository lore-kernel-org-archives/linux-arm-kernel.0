From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:57:15 +0000
Subject: [PATCH 08/20] ARM: sa1111: add platform enable/disable functions
In-Reply-To: <20120203195419.GH14129@n2100.arm.linux.org.uk>
References: <20120203195419.GH14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPFz-000442-He@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add platform hooks to be called when individual sa1111 devices are
enabled and disabled.  This will allow us to move some platform
specifics out of the individual drivers.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/sa1111.c               |   22 +++++++++++++++++-----
 arch/arm/include/asm/hardware/sa1111.h |    8 ++++++--
 drivers/input/serio/sa1111ps2.c        |    6 +++++-
 drivers/pcmcia/sa1111_generic.c        |   11 +++++++++--
 drivers/usb/host/ohci-sa1111.c         |   19 ++++++++++++++-----
 5 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index b0f9362..1366e82 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -106,6 +106,7 @@ struct sa1111 {
 	int		irq_base;	/* base for cascaded on-chip IRQs */
 	spinlock_t	lock;
 	void __iomem	*base;
+	struct sa1111_platform_data *pdata;
 #ifdef CONFIG_PM
 	void		*saved_state;
 #endif
@@ -756,6 +757,7 @@ __sa1111_probe(struct device *me, struct resource *mem, int irq)
 	sachip->dev = me;
 	dev_set_drvdata(sachip->dev, sachip);
 
+	sachip->pdata = pd;
 	sachip->phys = mem->start;
 	sachip->irq = irq;
 
@@ -1282,16 +1284,23 @@ EXPORT_SYMBOL(sa1111_set_sleep_io);
  *	sa1111_enable_device - enable an on-chip SA1111 function block
  *	@sadev: SA1111 function block device to enable
  */
-void sa1111_enable_device(struct sa1111_dev *sadev)
+int sa1111_enable_device(struct sa1111_dev *sadev)
 {
 	struct sa1111 *sachip = sa1111_chip_driver(sadev);
 	unsigned long flags;
 	unsigned int val;
+	int ret = 0;
 
-	spin_lock_irqsave(&sachip->lock, flags);
-	val = sa1111_readl(sachip->base + SA1111_SKPCR);
-	sa1111_writel(val | sadev->skpcr_mask, sachip->base + SA1111_SKPCR);
-	spin_unlock_irqrestore(&sachip->lock, flags);
+	if (sachip->pdata && sachip->pdata->enable)
+		ret = sachip->pdata->enable(sachip->pdata->data, sadev->devid);
+
+	if (ret == 0) {
+		spin_lock_irqsave(&sachip->lock, flags);
+		val = sa1111_readl(sachip->base + SA1111_SKPCR);
+		sa1111_writel(val | sadev->skpcr_mask, sachip->base + SA1111_SKPCR);
+		spin_unlock_irqrestore(&sachip->lock, flags);
+	}
+	return ret;
 }
 EXPORT_SYMBOL(sa1111_enable_device);
 
@@ -1309,6 +1318,9 @@ void sa1111_disable_device(struct sa1111_dev *sadev)
 	val = sa1111_readl(sachip->base + SA1111_SKPCR);
 	sa1111_writel(val & ~sadev->skpcr_mask, sachip->base + SA1111_SKPCR);
 	spin_unlock_irqrestore(&sachip->lock, flags);
+
+	if (sachip->pdata && sachip->pdata->disable)
+		sachip->pdata->disable(sachip->pdata->data, sadev->devid);
 }
 EXPORT_SYMBOL(sa1111_disable_device);
 
diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/hardware/sa1111.h
index 29e320f..d54d781 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -556,9 +556,10 @@ struct sa1111_driver {
 #define SA1111_DRIVER_NAME(_sadev) ((_sadev)->dev.driver->name)
 
 /*
- * These frob the SKPCR register.
+ * These frob the SKPCR register, and call platform specific
+ * enable/disable functions.
  */
-void sa1111_enable_device(struct sa1111_dev *);
+int sa1111_enable_device(struct sa1111_dev *);
 void sa1111_disable_device(struct sa1111_dev *);
 
 unsigned int sa1111_pll_clock(struct sa1111_dev *);
@@ -581,6 +582,9 @@ void sa1111_set_sleep_io(struct sa1111_dev *sadev, unsigned int bits, unsigned i
 
 struct sa1111_platform_data {
 	int	irq_base;	/* base for cascaded on-chip IRQs */
+	void	*data;
+	int	(*enable)(void *, unsigned);
+	void	(*disable)(void *, unsigned);
 };
 
 #endif  /* _ASM_ARCH_SA1111 */
diff --git a/drivers/input/serio/sa1111ps2.c b/drivers/input/serio/sa1111ps2.c
index 40ec545..ad7d23b 100644
--- a/drivers/input/serio/sa1111ps2.c
+++ b/drivers/input/serio/sa1111ps2.c
@@ -124,13 +124,16 @@ static int ps2_open(struct serio *io)
 	struct ps2if *ps2if = io->port_data;
 	int ret;
 
-	sa1111_enable_device(ps2if->dev);
+	ret = sa1111_enable_device(ps2if->dev);
+	if (ret)
+		return ret;
 
 	ret = request_irq(ps2if->dev->irq[0], ps2_rxint, 0,
 			  SA1111_DRIVER_NAME(ps2if->dev), ps2if);
 	if (ret) {
 		printk(KERN_ERR "sa1111ps2: could not allocate IRQ%d: %d\n",
 			ps2if->dev->irq[0], ret);
+		sa1111_disable_device(ps2if->dev);
 		return ret;
 	}
 
@@ -140,6 +143,7 @@ static int ps2_open(struct serio *io)
 		printk(KERN_ERR "sa1111ps2: could not allocate IRQ%d: %d\n",
 			ps2if->dev->irq[1], ret);
 		free_irq(ps2if->dev->irq[0], ps2if);
+		sa1111_disable_device(ps2if->dev);
 		return ret;
 	}
 
diff --git a/drivers/pcmcia/sa1111_generic.c b/drivers/pcmcia/sa1111_generic.c
index 27f2fe3..0735c3e 100644
--- a/drivers/pcmcia/sa1111_generic.c
+++ b/drivers/pcmcia/sa1111_generic.c
@@ -163,12 +163,18 @@ int sa1111_pcmcia_add(struct sa1111_dev *dev, struct pcmcia_low_level *ops,
 static int pcmcia_probe(struct sa1111_dev *dev)
 {
 	void __iomem *base;
+	int ret;
+
+	ret = sa1111_enable_device(dev);
+	if (ret)
+		return ret;
 
 	dev_set_drvdata(&dev->dev, NULL);
 
-	if (!request_mem_region(dev->res.start, 512,
-				SA1111_DRIVER_NAME(dev)))
+	if (!request_mem_region(dev->res.start, 512, SA1111_DRIVER_NAME(dev))) {
+		sa1111_disable_device(dev);
 		return -EBUSY;
+	}
 
 	base = dev->mapbase;
 
@@ -212,6 +218,7 @@ static int __devexit pcmcia_remove(struct sa1111_dev *dev)
 	}
 
 	release_mem_region(dev->res.start, 512);
+	sa1111_disable_device(dev);
 	return 0;
 }
 
diff --git a/drivers/usb/host/ohci-sa1111.c b/drivers/usb/host/ohci-sa1111.c
index 7d2aa62..f61f4f9 100644
--- a/drivers/usb/host/ohci-sa1111.c
+++ b/drivers/usb/host/ohci-sa1111.c
@@ -27,9 +27,10 @@ extern int usb_disabled(void);
 
 /*-------------------------------------------------------------------------*/
 
-static void sa1111_start_hc(struct sa1111_dev *dev)
+static int sa1111_start_hc(struct sa1111_dev *dev)
 {
 	unsigned int usb_rst = 0;
+	int ret;
 
 	printk(KERN_DEBUG "%s: starting SA-1111 OHCI USB Controller\n",
 	       __FILE__);
@@ -57,9 +58,13 @@ static void sa1111_start_hc(struct sa1111_dev *dev)
 	 * Now, carefully enable the USB clock, and take
 	 * the USB host controller out of reset.
 	 */
-	sa1111_enable_device(dev);
-	udelay(11);
-	sa1111_writel(usb_rst, dev->mapbase + SA1111_USB_RESET);
+	ret = sa1111_enable_device(dev);
+	if (ret == 0) {
+		udelay(11);
+		sa1111_writel(usb_rst, dev->mapbase + SA1111_USB_RESET);
+	}
+
+	return ret;
 }
 
 static void sa1111_stop_hc(struct sa1111_dev *dev)
@@ -140,7 +145,10 @@ int usb_hcd_sa1111_probe (const struct hc_driver *driver,
 	}
 	hcd->regs = dev->mapbase;
 
-	sa1111_start_hc(dev);
+	ret = sa1111_start_hc(dev);
+	if (ret)
+		goto err2;
+
 	ohci_hcd_init(hcd_to_ohci(hcd));
 
 	retval = usb_add_hcd(hcd, dev->irq[1], 0);
@@ -148,6 +156,7 @@ int usb_hcd_sa1111_probe (const struct hc_driver *driver,
 		return retval;
 
 	sa1111_stop_hc(dev);
+ err2:
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
  err1:
 	usb_put_hcd(hcd);
-- 
1.7.4.4
