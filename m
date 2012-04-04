From: stigge@antcom.de (Roland Stigge)
Date: Wed,  4 Apr 2012 18:07:24 +0200
Subject: [PATCH RFC 1/2] ohci-nxp: Device tree support
Message-ID: <1333555645-2154-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree support to ohci-nxp.c

---

Applies to v3.4-rc1

There is one remaining problem when booting with devicetree enabled: 

Bootup looks fine:

===============================================================
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ISP1301 Vendor ID  : 0x04cc
ISP1301 Product ID : 0x1301
ISP1301 Version ID : 0x0210
usb-ohci usb-ohci: at 0xf3120000, irq 0
usb-ohci usb-ohci: nxp OHCI
usb-ohci usb-ohci: new USB bus registered, assigned bus number 1
usb-ohci usb-ohci: irq 59, io mem 0xf3120000
===============================================================

I.e., iomem, irq and i2c to the USB PHY (ISP1201) works.

Upon USB connection (e.g. Mass Storage), I get:

===============================================================
usb 1-1: new full-speed USB device number 2 using usb-ohci
usb 1-1: device descriptor read/64, error -62
usb 1-1: device descriptor read/64, error -62
usb 1-1: new full-speed USB device number 3 using usb-ohci
usb 1-1: device descriptor read/64, error -62
usb 1-1: device descriptor read/64, error -62
usb 1-1: new full-speed USB device number 4 using usb-ohci
VFS: Mounted root (nfs filesystem) on device 0:9.
Freeing init memory: 144K
usb 1-1: device not accepting address 4, error -62
usb 1-1: new full-speed USB device number 5 using usb-ohci
usb 1-1: device not accepting address 5, error -62
hub 1-0:1.0: unable to enumerate USB device on port 1
===============================================================

Another USB device consistently shows:

===============================================================
usb 1-1: new full-speed USB device number 6 using usb-ohci
hub 1-0:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-0:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-0:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-0:1.0: Cannot enable port 1.  Maybe the USB cable is bad?
hub 1-0:1.0: unable to enumerate USB device on port 1
===============================================================

With different devices, I traced it to a different place in drivers/usb/core
each, and since with every device we get a different error pattern, I suspected
incorrect clocking or signalling since the host already does part of the USB
protocol but can't find any.

Before the DT conversion, it worked as expected.

Is this a known pitfall upon DT conversions?

Thanks in advance!

In the next patch, I'm including my work-in-progress remaining DT conversion
patch. Together with my previously posted patch series of 8 (+gpio), this will
eventually become the LPC32xx DT conversion.

Roland


 Documentation/devicetree/bindings/usb/ohci-nxp.txt |   16 +++++
 drivers/usb/host/ohci-nxp.c                        |   57 +++++++++++++++------
 2 files changed, 57 insertions(+), 16 deletions(-)

--- /dev/null
+++ linux-2.6/Documentation/devicetree/bindings/usb/ohci-nxp.txt
@@ -0,0 +1,16 @@
+* OHCI controller, NXP ohci-nxp variant
+
+Required properties:
+- compatible: must be "nxp,ohci-nxp"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: The OHCI interrupt
+
+Example (LPC32xx):
+
+	ohci at 31020000 {
+		compatible = "nxp,ohci-nxp";
+		reg = <0x31020000 0x300>;
+		interrupt-parent = <&mic>;
+		interrupts = <0x3b 0>;
+	};
--- linux-2.6.orig/drivers/usb/host/ohci-nxp.c
+++ linux-2.6/drivers/usb/host/ohci-nxp.c
@@ -22,6 +22,7 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
+#include <linux/of.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -38,6 +39,7 @@
 
 /* USB_CTRL bit defines */
 #define USB_SLAVE_HCLK_EN	(1 << 24)
+#define USB_DEV_NEED_CLK_EN	(1 << 22)
 #define USB_HOST_NEED_CLK_EN	(1 << 21)
 
 #define USB_OTG_CLK_CTRL	IO_ADDRESS(USB_CONFIG_BASE + 0xFF4)
@@ -220,7 +222,7 @@ static void isp1301_configure_lpc32xx(vo
 		ISP1301_I2C_INTERRUPT_RISING | ISP1301_I2C_REG_CLEAR_ADDR, ~0);
 
 	/* Enable usb_need_clk clock after transceiver is initialized */
-	__raw_writel((__raw_readl(USB_CTRL) | (1 << 22)), USB_CTRL);
+	__raw_writel((__raw_readl(USB_CTRL) | USB_HOST_NEED_CLK_EN), USB_CTRL);
 
 	printk(KERN_INFO "ISP1301 Vendor ID  : 0x%04x\n",
 	      i2c_smbus_read_word_data(isp1301_i2c_client, 0x00));
@@ -374,6 +376,7 @@ static int __devinit usb_hcd_nxp_probe(s
 	const struct hc_driver *driver = &ohci_nxp_hc_driver;
 	struct i2c_adapter *i2c_adap;
 	struct i2c_board_info i2c_info;
+	struct resource *res;
 
 	int ret = 0, irq;
 
@@ -384,16 +387,10 @@ static int __devinit usb_hcd_nxp_probe(s
 		goto out;
 	}
 
-	if (pdev->num_resources != 2
-	    || pdev->resource[0].flags != IORESOURCE_MEM
-	    || pdev->resource[1].flags != IORESOURCE_IRQ) {
-		err("Invalid resource configuration");
-		ret = -ENODEV;
-		goto out;
-	}
-
 	/* Enable AHB slave USB clock, needed for further USB clock control */
-	__raw_writel(USB_SLAVE_HCLK_EN | (1 << 19), USB_CTRL);
+	__raw_writel(__raw_readl(USB_CTRL) | USB_SLAVE_HCLK_EN, USB_CTRL);
+	__raw_writel(__raw_readl(USB_CTRL) & ~(1 << 20), USB_CTRL);
+	__raw_writel(__raw_readl(USB_CTRL) | (1 << 19), USB_CTRL);
 
 	ret = i2c_add_driver(&isp1301_driver);
 	if (ret < 0) {
@@ -435,6 +432,7 @@ static int __devinit usb_hcd_nxp_probe(s
 	}
 
 	__raw_writel(__raw_readl(USB_CTRL) | USB_HOST_NEED_CLK_EN, USB_CTRL);
+	__raw_writel(__raw_readl(USB_CTRL) & ~USB_DEV_NEED_CLK_EN, USB_CTRL);
 
 	/* Set to enable all needed USB clocks */
 	__raw_writel(USB_CLOCK_MASK, USB_OTG_CLK_CTRL);
@@ -442,7 +440,7 @@ static int __devinit usb_hcd_nxp_probe(s
 	while ((__raw_readl(USB_OTG_CLK_STAT) & USB_CLOCK_MASK) !=
 	       USB_CLOCK_MASK) ;
 
-	hcd = usb_create_hcd (driver, &pdev->dev, dev_name(&pdev->dev));
+	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
 	if (!hcd) {
 		err("Failed to allocate HC buffer");
 		ret = -ENOMEM;
@@ -452,19 +450,33 @@ static int __devinit usb_hcd_nxp_probe(s
 	/* Set all USB bits in the Start Enable register */
 	nxp_set_usb_bits();
 
-	hcd->rsrc_start = pdev->resource[0].start;
-	hcd->rsrc_len = pdev->resource[0].end - pdev->resource[0].start + 1;
+	pdev->dev.coherent_dma_mask = 0xFFFFFFFF;
+	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get MEM resource");
+		ret =  -ENOMEM;
+		goto out4;
+	}
+	hcd->rsrc_start = IO_ADDRESS(res->start);
+	hcd->rsrc_len = resource_size(res);
 	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {
-		dev_dbg(&pdev->dev, "request_mem_region failed\n");
+		dev_err(&pdev->dev, "request_mem_region failed\n");
 		ret =  -ENOMEM;
 		goto out4;
 	}
-	hcd->regs = (void __iomem *)pdev->resource[0].start;
+	hcd->regs = ioremap(res->start, hcd->rsrc_len);
+	if (!hcd->regs) {
+		err("Failed to ioremap");
+		ret =  -ENOMEM;
+		goto out5;
+	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = -ENXIO;
-		goto out4;
+		goto out6;
 	}
 
 	nxp_start_hc();
@@ -478,6 +490,10 @@ static int __devinit usb_hcd_nxp_probe(s
 		return ret;
 
 	nxp_stop_hc();
+out6:
+	iounmap(hcd->regs);
+out5:
+	request_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name);
 out4:
 	nxp_unset_usb_bits();
 	usb_put_hcd(hcd);
@@ -517,10 +533,19 @@ static int usb_hcd_nxp_remove(struct pla
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:usb-ohci");
 
+#ifdef CONFIG_OF
+static const struct of_device_id usb_hcd_nxp_match[] = {
+	{ .compatible = "nxp,ohci-nxp" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, usb_hcd_nxp_match);
+#endif
+
 static struct platform_driver usb_hcd_nxp_driver = {
 	.driver = {
 		.name = "usb-ohci",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(usb_hcd_nxp_match),
 	},
 	.probe = usb_hcd_nxp_probe,
 	.remove = usb_hcd_nxp_remove,
