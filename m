From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 11 Dec 2012 17:21:59 +0000
Subject: [PATCH 5/7] arm64: ARMv8 RTSM model (SoC) support
In-Reply-To: <20121211163932.GC16071@arm.com>
References: <1354914392-9634-1-git-send-email-catalin.marinas@arm.com>
 <1354914392-9634-6-git-send-email-catalin.marinas@arm.com>
 <201212111541.16479.arnd@arndb.de> <20121211163932.GC16071@arm.com>
Message-ID: <1355246519.19818.20.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-12-11 at 16:39 +0000, Catalin Marinas wrote:
> > > diff --git a/arch/arm6
> > > +static const char *vexpress_dt_match[] __initdata = {
> > > +       "arm,vexpress",
> > > +       NULL,
> > > +};
> > > +
> > > +static int __init vexpress_init(void)
> > > +{
> > > +       if (!of_flat_dt_match(of_get_flat_dt_root(), vexpress_dt_match))
> > > +               return 0;
> > > +
> > > +       vexpress_sysreg_of_early_init();
> > > +       vexpress_clk_of_init();
> > > +
> > > +       return 0;
> > > +}
> > > +arch_initcall(vexpress_init);
> > 
> > I think it would be more appropriate for these two to check the presence of
> > the individual devices, and move the caller into the actual device driver,
> > rather than checking for the root node of the device tree.
> > 
> > There may be cases where we want to check the root node, but both the clock
> > setup and the sysreg should both be detectable.
> 
> I cc'ed Pawel as well since it's touching his code. We've been through
> several versions internally and didn't find a clear winner. Currently,
> vexpress_clk_of_init() requires vexpress_sysreg_of_early_init() to be
> called first. Pawel has a patch to allow sysreg self-initialisation when
> called from vexpress_clk_of_init().
> 
> This leaves us with a way to call vexpress_clk_of_init() directly from
> clk-vexpress.c. There are two ways:
> 
> 1. arch_initcall() in clk-vexpress.c, checking for the DT match.
> 2. driver registration (arch_initcall) and later probing when
>    of_platform_populate() is called from the arch/arm64 code.
> 
> The 2nd option above relies on the DT order since the clocks must be
> registered before any AMBA device is registered, so I'm not too keen.
> This leaves us with option 1 or any other suggestion you may have.

The idea I had was to associate the root of the device tree with the
"platform" device, see below. This makes it possible to write a platform
driver for the particular platform, so the code for the vexpress could
look more or less like this...

static int __devinit vexpress_probe(struct platform_device *dev)
{
        vexpress_sysreg_of_early_init();
        vexpress_clk_of_init();

        of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);

        return 0;
}

static const struct of_device_id vexpress_match[] = {
        { .compatible = "arm,vexpress", },
        {}
};

static struct platform_driver vexpress_driver = {
        .driver = {
                .name = "vexpress",
                .of_match_table = vexpress_match,
        },
        .probe = vexpress_probe,
};

static int __init vexpress_init(void)
{
        return platform_driver_register(&vexpress_driver);
}
arch_initcall(vexpress_init);

... and live, for example, in drivers/platforms/vexpress.c. I think it
would neatly fit the device model - a platform driver for the "platform"
platform device ;-)

Pawe?

8<---------------------------
>From a19b22ed4d5042a2249f0aa41633cbbc7310d5f3 Mon Sep 17 00:00:00 2001
From: Pawel Moll <pawel.moll@arm.com>
Date: Mon, 26 Nov 2012 12:35:10 +0000
Subject: [PATCH] platform: Make platform_bus device a platform device

... describing the root of the device tree, so one can write
a platform driver initializing the platform.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mach-imx/devices/devices.c |    4 ++--
 arch/unicore32/kernel/puv3-core.c   |    2 +-
 arch/unicore32/kernel/puv3-nb0916.c |    6 +++---
 drivers/base/platform.c             |   18 ++++++++++++------
 drivers/char/tile-srom.c            |    2 +-
 drivers/mmc/host/sdhci-pltfm.c      |    2 +-
 drivers/scsi/hosts.c                |    2 +-
 include/linux/platform_device.h     |    2 +-
 8 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-imx/devices/devices.c b/arch/arm/mach-imx/devices/devices.c
index 1b37482..ac68960 100644
--- a/arch/arm/mach-imx/devices/devices.c
+++ b/arch/arm/mach-imx/devices/devices.c
@@ -24,12 +24,12 @@
 
 struct device mxc_aips_bus = {
 	.init_name	= "mxc_aips",
-	.parent		= &platform_bus,
+	.parent		= &platform_bus.dev,
 };
 
 struct device mxc_ahb_bus = {
 	.init_name	= "mxc_ahb",
-	.parent		= &platform_bus,
+	.parent		= &platform_bus.dev,
 };
 
 int __init mxc_device_init(void)
diff --git a/arch/unicore32/kernel/puv3-core.c b/arch/unicore32/kernel/puv3-core.c
index 254adee..28d1387 100644
--- a/arch/unicore32/kernel/puv3-core.c
+++ b/arch/unicore32/kernel/puv3-core.c
@@ -272,7 +272,7 @@ void __init puv3_core_init(void)
 	platform_device_register_simple("PKUnity-v3-UART", 1,
 			puv3_uart1_resources, ARRAY_SIZE(puv3_uart1_resources));
 	platform_device_register_simple("PKUnity-v3-AC97", -1, NULL, 0);
-	platform_device_register_resndata(&platform_bus, "musb_hdrc", -1,
+	platform_device_register_resndata(&platform_bus.dev, "musb_hdrc", -1,
 			puv3_usb_resources, ARRAY_SIZE(puv3_usb_resources),
 			&puv3_usb_plat, sizeof(puv3_usb_plat));
 }
diff --git a/arch/unicore32/kernel/puv3-nb0916.c b/arch/unicore32/kernel/puv3-nb0916.c
index 181108b..b8f6fb3 100644
--- a/arch/unicore32/kernel/puv3-nb0916.c
+++ b/arch/unicore32/kernel/puv3-nb0916.c
@@ -111,13 +111,13 @@ int __init mach_nb0916_init(void)
 	platform_device_register_simple("PKUnity-v3-I2C", -1,
 			puv3_i2c_resources, ARRAY_SIZE(puv3_i2c_resources));
 
-	platform_device_register_data(&platform_bus, "pwm-backlight", -1,
+	platform_device_register_data(&platform_bus.dev, "pwm-backlight", -1,
 			&nb0916_backlight_data, sizeof(nb0916_backlight_data));
 
-	platform_device_register_data(&platform_bus, "gpio-keys", -1,
+	platform_device_register_data(&platform_bus.dev, "gpio-keys", -1,
 			&nb0916_gpio_button_data, sizeof(nb0916_gpio_button_data));
 
-	platform_device_register_resndata(&platform_bus, "physmap-flash", -1,
+	platform_device_register_resndata(&platform_bus.dev, "physmap-flash", -1,
 			&physmap_flash_resource, 1,
 			&physmap_flash_data, sizeof(physmap_flash_data));
 
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 9c16b6f..28e1f86 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -32,8 +32,8 @@ static DEFINE_IDA(platform_devid_ida);
 #define to_platform_driver(drv)	(container_of((drv), struct platform_driver, \
 				 driver))
 
-struct device platform_bus = {
-	.init_name	= "platform",
+struct platform_device platform_bus = {
+	.name	= "platform",
 };
 EXPORT_SYMBOL_GPL(platform_bus);
 
@@ -285,7 +285,7 @@ int platform_device_add(struct platform_device *pdev)
 		return -EINVAL;
 
 	if (!pdev->dev.parent)
-		pdev->dev.parent = &platform_bus;
+		pdev->dev.parent = &platform_bus.dev;
 
 	pdev->dev.bus = &platform_bus_type;
 
@@ -888,12 +888,18 @@ int __init platform_bus_init(void)
 
 	early_platform_cleanup();
 
-	error = device_register(&platform_bus);
+	dev_set_name(&platform_bus.dev, "%s", platform_bus.name);
+	error = device_register(&platform_bus.dev);
 	if (error)
 		return error;
 	error =  bus_register(&platform_bus_type);
-	if (error)
-		device_unregister(&platform_bus);
+	if (!error) {
+		platform_bus.dev.of_node = allnodes;
+		platform_bus.dev.bus = &platform_bus_type;
+		bus_add_device(&platform_bus.dev);
+	} else {
+		device_unregister(&platform_bus.dev);
+	}
 	return error;
 }
 
diff --git a/drivers/char/tile-srom.c b/drivers/char/tile-srom.c
index 3b22a60..9e7ffdc 100644
--- a/drivers/char/tile-srom.c
+++ b/drivers/char/tile-srom.c
@@ -369,7 +369,7 @@ static int srom_setup_minor(struct srom_dev *srom, int index)
 		       SROM_PAGE_SIZE_OFF, sizeof(srom->page_size)) < 0)
 		return -EIO;
 
-	dev = device_create(srom_class, &platform_bus,
+	dev = device_create(srom_class, &platform_bus.dev,
 			    MKDEV(srom_major, index), srom, "%d", index);
 	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
 }
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 2716445..246b702 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -115,7 +115,7 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		dev_err(&pdev->dev, "Invalid iomem size!\n");
 
 	/* Some PCI-based MFD need the parent here */
-	if (pdev->dev.parent != &platform_bus && !np)
+	if (pdev->dev.parent != &platform_bus.dev && !np)
 		host = sdhci_alloc_host(pdev->dev.parent, sizeof(*pltfm_host));
 	else
 		host = sdhci_alloc_host(&pdev->dev, sizeof(*pltfm_host));
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 593085a..bb4be31 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -217,7 +217,7 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 		goto fail;
 
 	if (!shost->shost_gendev.parent)
-		shost->shost_gendev.parent = dev ? dev : &platform_bus;
+		shost->shost_gendev.parent = dev ? dev : &platform_bus.dev;
 	if (!dma_dev)
 		dma_dev = shost->shost_gendev.parent;
 
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 5711e95..06738a0 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -44,7 +44,7 @@ extern int platform_device_register(struct platform_device *);
 extern void platform_device_unregister(struct platform_device *);
 
 extern struct bus_type platform_bus_type;
-extern struct device platform_bus;
+extern struct platform_device platform_bus;
 
 extern void arch_setup_pdev_archdata(struct platform_device *);
 extern struct resource *platform_get_resource(struct platform_device *, unsigned int, unsigned int);
-- 
1.7.10.4
