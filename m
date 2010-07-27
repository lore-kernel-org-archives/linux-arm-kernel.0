From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 27 Jul 2010 15:06:58 +0300
Subject: [PATCH 1/3 v2] [ARM] pxa3xx: Add U2D controller and ULPI driver
In-Reply-To: <1280232420-28691-1-git-send-email-grinberg@compulab.co.il>
References: <1280232420-28691-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <1280232420-28691-2-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB2.0 Device Controller (U2DC) which is found in Marvell PXA3xx.
U2DC supports both High and Full speed modes.
PXA320 and PXA300 U2DC supports only UTMI interface.
PXA310 U2DC supports only ULPI interface and has the OTG capability.

U2D Controller ULPI driver introduced in this patch supports only the
PXA310 USB Host via the ULPI.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/Kconfig                   |    4 +
 arch/arm/mach-pxa/Makefile                  |    2 +-
 arch/arm/mach-pxa/devices.c                 |   28 ++
 arch/arm/mach-pxa/devices.h                 |    1 +
 arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h |   35 +++
 arch/arm/mach-pxa/pxa3xx-ulpi.c             |  392 +++++++++++++++++++++++++++
 arch/arm/mach-pxa/pxa3xx.c                  |    2 +-
 7 files changed, 462 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h
 create mode 100644 arch/arm/mach-pxa/pxa3xx-ulpi.c

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 3b51741..e96fa2a 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -609,6 +609,7 @@ config CPU_PXA300
 config CPU_PXA310
 	bool
 	select CPU_PXA300
+	select PXA310_ULPI if USB_ULPI
 	help
 	  PXA310 (codename Monahans-LV)
 
@@ -674,4 +675,7 @@ config PXA_HAVE_BOARD_IRQS
 config PXA_HAVE_ISA_IRQS
 	bool
 
+config PXA310_ULPI
+	bool
+
 endif
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index b8f1f4b..27f9ee7 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -18,7 +18,7 @@ endif
 # SoC-specific code
 obj-$(CONFIG_PXA25x)		+= mfp-pxa2xx.o pxa2xx.o pxa25x.o
 obj-$(CONFIG_PXA27x)		+= mfp-pxa2xx.o pxa2xx.o pxa27x.o
-obj-$(CONFIG_PXA3xx)		+= mfp-pxa3xx.o pxa3xx.o smemc.o
+obj-$(CONFIG_PXA3xx)		+= mfp-pxa3xx.o pxa3xx.o smemc.o pxa3xx-ulpi.o
 obj-$(CONFIG_CPU_PXA300)	+= pxa300.o
 obj-$(CONFIG_CPU_PXA320)	+= pxa320.o
 obj-$(CONFIG_CPU_PXA930)	+= pxa930.o
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 8e10db1..cf5222e 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -5,6 +5,7 @@
 #include <linux/dma-mapping.h>
 
 #include <mach/udc.h>
+#include <mach/pxa3xx-u2d.h>
 #include <mach/pxafb.h>
 #include <mach/mmc.h>
 #include <mach/irda.h>
@@ -120,6 +121,33 @@ struct platform_device pxa27x_device_udc = {
 	}
 };
 
+#ifdef CONFIG_PXA3xx
+static struct resource pxa3xx_u2d_resources[] = {
+	[0] = {
+		.start	= 0x54100000,
+		.end	= 0x54100fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_USB2,
+		.end	= IRQ_USB2,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device pxa3xx_device_u2d = {
+	.name		= "pxa3xx-u2d",
+	.id		= -1,
+	.resource	= pxa3xx_u2d_resources,
+	.num_resources	= ARRAY_SIZE(pxa3xx_u2d_resources),
+};
+
+void __init pxa3xx_set_u2d_info(struct pxa3xx_u2d_platform_data *info)
+{
+	pxa_register_device(&pxa3xx_device_u2d, info);
+}
+#endif /* CONFIG_PXA3xx */
+
 static struct resource pxafb_resources[] = {
 	[0] = {
 		.start	= 0x44000000,
diff --git a/arch/arm/mach-pxa/devices.h b/arch/arm/mach-pxa/devices.h
index 93817d9..631935c 100644
--- a/arch/arm/mach-pxa/devices.h
+++ b/arch/arm/mach-pxa/devices.h
@@ -3,6 +3,7 @@ extern struct platform_device pxa3xx_device_mci2;
 extern struct platform_device pxa3xx_device_mci3;
 extern struct platform_device pxa25x_device_udc;
 extern struct platform_device pxa27x_device_udc;
+extern struct platform_device pxa3xx_device_u2d;
 extern struct platform_device pxa_device_fb;
 extern struct platform_device pxa_device_ffuart;
 extern struct platform_device pxa_device_btuart;
diff --git a/arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h b/arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h
new file mode 100644
index 0000000..9d82cb6
--- /dev/null
+++ b/arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h
@@ -0,0 +1,35 @@
+/*
+ * PXA3xx U2D header
+ *
+ * Copyright (C) 2010 CompuLab Ltd.
+ *
+ * Igor Grinberg <grinberg@compulab.co.il>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __PXA310_U2D__
+#define __PXA310_U2D__
+
+#include <linux/usb/ulpi.h>
+
+struct pxa3xx_u2d_platform_data {
+
+#define ULPI_SER_6PIN	(1 << 0)
+#define ULPI_SER_3PIN	(1 << 1)
+	unsigned int ulpi_mode;
+
+	int (*init)(struct device *);
+	void (*exit)(struct device *);
+};
+
+
+/* Start PXA3xx U2D host */
+int pxa3xx_u2d_start_hc(struct usb_bus *host);
+/* Stop PXA3xx U2D host */
+void pxa3xx_u2d_stop_hc(struct usb_bus *host);
+
+extern void pxa3xx_set_u2d_info(struct pxa3xx_u2d_platform_data *info);
+
+#endif /* __PXA310_U2D__ */
diff --git a/arch/arm/mach-pxa/pxa3xx-ulpi.c b/arch/arm/mach-pxa/pxa3xx-ulpi.c
new file mode 100644
index 0000000..e57439e
--- /dev/null
+++ b/arch/arm/mach-pxa/pxa3xx-ulpi.c
@@ -0,0 +1,392 @@
+/*
+ * linux/arch/arm/mach-pxa/pxa3xx-ulpi.c
+ *
+ * code specific to pxa3xx aka Monahans
+ *
+ * Copyright (C) 2010 CompuLab Ltd.
+ *
+ * 2010-13-07: Igor Grinberg <grinberg@compulab.co.il>
+ *             initial version: pxa310 USB Host mode support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/usb.h>
+#include <linux/usb/otg.h>
+
+#include <mach/hardware.h>
+#include <mach/regs-u2d.h>
+#include <mach/pxa3xx-u2d.h>
+
+struct pxa3xx_u2d_ulpi {
+	struct clk		*clk;
+	void __iomem		*mmio_base;
+
+	struct otg_transceiver	*otg;
+	unsigned int		ulpi_mode;
+};
+
+static struct pxa3xx_u2d_ulpi *u2d;
+
+static inline u32 u2d_readl(u32 reg)
+{
+	return __raw_readl(u2d->mmio_base + reg);
+}
+
+static inline void u2d_writel(u32 reg, u32 val)
+{
+	__raw_writel(val, u2d->mmio_base + reg);
+}
+
+#if defined(CONFIG_PXA310_ULPI)
+enum u2d_ulpi_phy_mode {
+	SYNCH		= 0,
+	CARKIT		= (1 << 0),
+	SER_3PIN	= (1 << 1),
+	SER_6PIN	= (1 << 2),
+	LOWPOWER	= (1 << 3),
+};
+
+static inline enum u2d_ulpi_phy_mode pxa310_ulpi_get_phymode(void)
+{
+	return (u2d_readl(U2DOTGUSR) >> 28) & 0xF;
+}
+
+static int pxa310_ulpi_poll(void)
+{
+	int timeout = 50000;
+
+	while (timeout--) {
+		if (!(u2d_readl(U2DOTGUCR) & U2DOTGUCR_RUN))
+			return 0;
+
+		cpu_relax();
+	}
+
+	pr_warning("%s: ULPI access timed out!\n", __func__);
+
+	return -ETIMEDOUT;
+}
+
+static int pxa310_ulpi_read(struct otg_transceiver *otg, u32 reg)
+{
+	int err;
+
+	if (pxa310_ulpi_get_phymode() != SYNCH) {
+		pr_warning("%s: PHY is not in SYNCH mode!\n", __func__);
+		return -EBUSY;
+	}
+
+	u2d_writel(U2DOTGUCR, U2DOTGUCR_RUN | U2DOTGUCR_RNW | (reg << 16));
+	msleep(5);
+
+	err = pxa310_ulpi_poll();
+	if (err)
+		return err;
+
+	return u2d_readl(U2DOTGUCR) & U2DOTGUCR_RDATA;
+}
+
+static int pxa310_ulpi_write(struct otg_transceiver *otg, u32 val, u32 reg)
+{
+	if (pxa310_ulpi_get_phymode() != SYNCH) {
+		pr_warning("%s: PHY is not in SYNCH mode!\n", __func__);
+		return -EBUSY;
+	}
+
+	u2d_writel(U2DOTGUCR, U2DOTGUCR_RUN | (reg << 16) | (val << 8));
+	msleep(5);
+
+	return pxa310_ulpi_poll();
+}
+
+struct otg_io_access_ops pxa310_ulpi_access_ops = {
+	.read	= pxa310_ulpi_read,
+	.write	= pxa310_ulpi_write,
+};
+
+static void pxa310_otg_transceiver_rtsm(void)
+{
+	u32 u2dotgcr;
+
+	/* put PHY to sync mode */
+	u2dotgcr = u2d_readl(U2DOTGCR);
+	u2dotgcr |=  U2DOTGCR_RTSM | U2DOTGCR_UTMID;
+	u2d_writel(U2DOTGCR, u2dotgcr);
+	msleep(10);
+
+	/* setup OTG sync mode */
+	u2dotgcr = u2d_readl(U2DOTGCR);
+	u2dotgcr |= U2DOTGCR_ULAF;
+	u2dotgcr &= ~(U2DOTGCR_SMAF | U2DOTGCR_CKAF);
+	u2d_writel(U2DOTGCR, u2dotgcr);
+}
+
+static int pxa310_start_otg_host_transcvr(struct usb_bus *host)
+{
+	int err;
+
+	pxa310_otg_transceiver_rtsm();
+
+	err = otg_init(u2d->otg);
+	if (err) {
+		pr_err("OTG transceiver init failed");
+		return err;
+	}
+
+	err = otg_set_vbus(u2d->otg, 1);
+	if (err) {
+		pr_err("OTG transceiver VBUS set failed");
+		return err;
+	}
+
+	err = otg_set_host(u2d->otg, host);
+	if (err)
+		pr_err("OTG transceiver Host mode set failed");
+
+	return err;
+}
+
+static int pxa310_start_otg_hc(struct usb_bus *host)
+{
+	u32 u2dotgcr;
+	int err;
+
+	/* disable USB device controller */
+	u2d_writel(U2DCR, u2d_readl(U2DCR) & ~U2DCR_UDE);
+	u2d_writel(U2DOTGCR, u2d_readl(U2DOTGCR) | U2DOTGCR_UTMID);
+	u2d_writel(U2DOTGICR, u2d_readl(U2DOTGICR) & ~0x37F7F);
+
+	err = pxa310_start_otg_host_transcvr(host);
+	if (err)
+		return err;
+
+	/* set xceiver mode */
+	if (u2d->ulpi_mode & ULPI_IC_6PIN_SERIAL)
+		u2d_writel(U2DP3CR, u2d_readl(U2DP3CR) & ~U2DP3CR_P2SS);
+	else if (u2d->ulpi_mode & ULPI_IC_3PIN_SERIAL)
+		u2d_writel(U2DP3CR, u2d_readl(U2DP3CR) | U2DP3CR_P2SS);
+
+	/* start OTG host controller */
+	u2dotgcr = u2d_readl(U2DOTGCR) | U2DOTGCR_SMAF;
+	u2d_writel(U2DOTGCR, u2dotgcr & ~(U2DOTGCR_ULAF | U2DOTGCR_CKAF));
+
+	return 0;
+}
+
+static void pxa310_stop_otg_hc(void)
+{
+	pxa310_otg_transceiver_rtsm();
+
+	otg_set_host(u2d->otg, NULL);
+	otg_set_vbus(u2d->otg, 0);
+	otg_shutdown(u2d->otg);
+}
+
+static void pxa310_u2d_setup_otg_hc(void)
+{
+	u32 u2dotgcr;
+
+	u2dotgcr = u2d_readl(U2DOTGCR);
+	u2dotgcr |= U2DOTGCR_ULAF | U2DOTGCR_UTMID;
+	u2dotgcr &= ~(U2DOTGCR_SMAF | U2DOTGCR_CKAF);
+	u2d_writel(U2DOTGCR, u2dotgcr);
+	msleep(5);
+	u2d_writel(U2DOTGCR, u2dotgcr | U2DOTGCR_ULE);
+	msleep(5);
+	u2d_writel(U2DOTGICR, u2d_readl(U2DOTGICR) & ~0x37F7F);
+}
+
+static int pxa310_otg_init(struct pxa3xx_u2d_platform_data *pdata)
+{
+	unsigned int ulpi_mode = ULPI_OTG_DRVVBUS;
+
+	if (pdata) {
+		if (pdata->ulpi_mode & ULPI_SER_6PIN)
+			ulpi_mode |= ULPI_IC_6PIN_SERIAL;
+		else if (pdata->ulpi_mode & ULPI_SER_3PIN)
+			ulpi_mode |= ULPI_IC_3PIN_SERIAL;
+	}
+
+	u2d->ulpi_mode = ulpi_mode;
+
+	u2d->otg = otg_ulpi_create(&pxa310_ulpi_access_ops, ulpi_mode);
+	if (!u2d->otg)
+		return -ENOMEM;
+
+	u2d->otg->io_priv = u2d->mmio_base;
+
+	return 0;
+}
+
+static void pxa310_otg_exit(void)
+{
+	kfree(u2d->otg);
+}
+#else
+static inline void pxa310_u2d_setup_otg_hc(void) {}
+static inline int pxa310_start_otg_hc(struct usb_bus *host)
+{
+	return 0;
+}
+static inline void pxa310_stop_otg_hc(void) {}
+static inline int pxa310_otg_init(struct pxa3xx_u2d_platform_data *pdata)
+{
+	return 0;
+}
+static inline void pxa310_otg_exit(void) {}
+#endif /* CONFIG_PXA310_ULPI */
+
+int pxa3xx_u2d_start_hc(struct usb_bus *host)
+{
+	int err = 0;
+
+	clk_enable(u2d->clk);
+
+	if (cpu_is_pxa310()) {
+		pxa310_u2d_setup_otg_hc();
+		err = pxa310_start_otg_hc(host);
+	}
+
+	return err;
+}
+
+void pxa3xx_u2d_stop_hc(struct usb_bus *host)
+{
+	if (cpu_is_pxa310())
+		pxa310_stop_otg_hc();
+
+	clk_disable(u2d->clk);
+}
+
+static int pxa3xx_u2d_probe(struct platform_device *pdev)
+{
+	struct pxa3xx_u2d_platform_data *pdata = pdev->dev.platform_data;
+	struct resource *r;
+	int err;
+
+	u2d = kzalloc(sizeof(struct pxa3xx_u2d_ulpi), GFP_KERNEL);
+	if (!u2d) {
+		dev_err(&pdev->dev, "failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	u2d->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(u2d->clk)) {
+		dev_err(&pdev->dev, "failed to get u2d clock\n");
+		err = PTR_ERR(u2d->clk);
+		goto err_free_mem;
+	}
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		dev_err(&pdev->dev, "no IO memory resource defined\n");
+		err = -ENODEV;
+		goto err_put_clk;
+	}
+
+        r = request_mem_region(r->start, resource_size(r), pdev->name);
+        if (!r) {
+                dev_err(&pdev->dev, "failed to request memory resource\n");
+                err = -EBUSY;
+                goto err_put_clk;
+        }
+
+	u2d->mmio_base = ioremap(r->start, resource_size(r));
+	if (!u2d->mmio_base) {
+		dev_err(&pdev->dev, "ioremap() failed\n");
+		err = -ENODEV;
+		goto err_free_res;
+	}
+
+	if (pdata->init) {
+		err = pdata->init(&pdev->dev);
+		if (err)
+			goto err_free_io;
+	}
+
+	/* Only PXA310 U2D has OTG functionality */
+	if (cpu_is_pxa310()) {
+		err = pxa310_otg_init(pdata);
+		if (err)
+			goto err_free_plat;
+	}
+
+	platform_set_drvdata(pdev, &u2d);
+
+	return 0;
+
+err_free_plat:
+	if (pdata->exit)
+		pdata->exit(&pdev->dev);
+err_free_io:
+	iounmap(u2d->mmio_base);
+err_free_res:
+	release_mem_region(r->start, resource_size(r));
+err_put_clk:
+	clk_put(u2d->clk);
+err_free_mem:
+	kfree(u2d);
+	return err;
+}
+
+static int pxa3xx_u2d_remove(struct platform_device *pdev)
+{
+	struct pxa3xx_u2d_platform_data *pdata = pdev->dev.platform_data;
+	struct resource *r;
+
+	if (cpu_is_pxa310()) {
+		pxa310_stop_otg_hc();
+		pxa310_otg_exit();
+	}
+
+	if (pdata->exit)
+		pdata->exit(&pdev->dev);
+
+	platform_set_drvdata(pdev, NULL);
+	iounmap(u2d->mmio_base);
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(r->start, resource_size(r));
+
+	clk_put(u2d->clk);
+
+	kfree(u2d);
+
+	return 0;
+}
+
+static struct platform_driver pxa3xx_u2d_ulpi_driver = {
+        .driver		= {
+                .name   = "pxa3xx-u2d",
+		.owner	= THIS_MODULE,
+        },
+        .probe          = pxa3xx_u2d_probe,
+        .remove         = pxa3xx_u2d_remove,
+};
+
+static int pxa3xx_u2d_ulpi_init(void)
+{
+	return platform_driver_register(&pxa3xx_u2d_ulpi_driver);
+}
+module_init(pxa3xx_u2d_ulpi_init);
+
+static void __exit pxa3xx_u2d_ulpi_exit(void)
+{
+	platform_driver_unregister(&pxa3xx_u2d_ulpi_driver);
+}
+module_exit(pxa3xx_u2d_ulpi_exit);
+
+MODULE_DESCRIPTION("PXA3xx U2D ULPI driver");
+MODULE_AUTHOR("Igor Grinberg");
+MODULE_LICENSE("GPL v2");
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index f544e58..9a707db 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -265,7 +265,7 @@ static struct clk_lookup pxa3xx_clkregs[] = {
 	INIT_CLKREG(&clk_pxa3xx_i2c, "pxa2xx-i2c.0", NULL),
 	INIT_CLKREG(&clk_pxa3xx_udc, "pxa27x-udc", NULL),
 	INIT_CLKREG(&clk_pxa3xx_usbh, "pxa27x-ohci", NULL),
-	INIT_CLKREG(&clk_pxa3xx_u2d, NULL, "U2DCLK"),
+	INIT_CLKREG(&clk_pxa3xx_u2d, "pxa3xx-u2d", NULL),
 	INIT_CLKREG(&clk_pxa3xx_keypad, "pxa27x-keypad", NULL),
 	INIT_CLKREG(&clk_pxa3xx_ssp1, "pxa27x-ssp.0", NULL),
 	INIT_CLKREG(&clk_pxa3xx_ssp2, "pxa27x-ssp.1", NULL),
-- 
1.7.1
