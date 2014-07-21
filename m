From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 21 Jul 2014 18:00:34 +0100
Subject: [PATCH] platform: Make platform_bus device a platform device
In-Reply-To: <CAOesGMgvd1HbjywN7BDPtr8ZU7vucWH48B=AW3TZjng73YA8WA@mail.gmail.com>
References: <CAOesGMgvd1HbjywN7BDPtr8ZU7vucWH48B=AW3TZjng73YA8WA@mail.gmail.com>
Message-ID: <1405962034-25482-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... describing the root of the device tree, so one can write
a platform driver initializing the platform.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---

For what it's worth, the patch I came up back then.
*Untested* against current head...

 arch/arm/mach-imx/devices/devices.c |  4 ++--
 arch/unicore32/kernel/puv3-core.c   |  2 +-
 arch/unicore32/kernel/puv3-nb0916.c |  6 +++---
 drivers/base/platform.c             | 18 ++++++++++++------
 drivers/char/tile-srom.c            |  2 +-
 drivers/mmc/host/sdhci-pltfm.c      |  2 +-
 drivers/scsi/hosts.c                |  2 +-
 include/linux/platform_device.h     |  2 +-
 8 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-imx/devices/devices.c b/arch/arm/mach-imx/devices/devices.c
index 1b4366a..48c3817 100644
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
index 0c6618e..4b1c462 100644
--- a/arch/unicore32/kernel/puv3-nb0916.c
+++ b/arch/unicore32/kernel/puv3-nb0916.c
@@ -112,13 +112,13 @@ int __init mach_nb0916_init(void)
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
index eee48c4..cb69b38 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -30,8 +30,8 @@
 /* For automatically allocated device IDs */
 static DEFINE_IDA(platform_devid_ida);
 
-struct device platform_bus = {
-	.init_name	= "platform",
+struct platform_device platform_bus = {
+	.name	= "platform",
 };
 EXPORT_SYMBOL_GPL(platform_bus);
 
@@ -300,7 +300,7 @@ int platform_device_add(struct platform_device *pdev)
 		return -EINVAL;
 
 	if (!pdev->dev.parent)
-		pdev->dev.parent = &platform_bus;
+		pdev->dev.parent = &platform_bus.dev;
 
 	pdev->dev.bus = &platform_bus_type;
 
@@ -946,12 +946,18 @@ int __init platform_bus_init(void)
 
 	early_platform_cleanup();
 
-	error = device_register(&platform_bus);
+	dev_set_name(&platform_bus.dev, "%s", platform_bus.name);
+	error = device_register(&platform_bus.name);
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
index bd37747..4e4b7a2 100644
--- a/drivers/char/tile-srom.c
+++ b/drivers/char/tile-srom.c
@@ -350,7 +350,7 @@ static int srom_setup_minor(struct srom_dev *srom, int index)
 		       SROM_PAGE_SIZE_OFF, sizeof(srom->page_size)) < 0)
 		return -EIO;
 
-	dev = device_create(srom_class, &platform_bus,
+	dev = device_create(srom_class, &platform_bus.dev,
 			    MKDEV(srom_major, index), srom, "%d", index);
 	return PTR_ERR_OR_ZERO(dev);
 }
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 7e834fb..9a2b0d0 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -137,7 +137,7 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		dev_err(&pdev->dev, "Invalid iomem size!\n");
 
 	/* Some PCI-based MFD need the parent here */
-	if (pdev->dev.parent != &platform_bus && !np)
+	if (pdev->dev.parent != &platform_bus.dev && !np)
 		host = sdhci_alloc_host(pdev->dev.parent,
 			sizeof(struct sdhci_pltfm_host) + priv_size);
 	else
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 3cbb57a..c14c36f 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -218,7 +218,7 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 		goto fail;
 
 	if (!shost->shost_gendev.parent)
-		shost->shost_gendev.parent = dev ? dev : &platform_bus;
+		shost->shost_gendev.parent = dev ? dev : &platform_bus.dev;
 	if (!dma_dev)
 		dma_dev = shost->shost_gendev.parent;
 
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 16f6654..a99032a 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -44,7 +44,7 @@ extern int platform_device_register(struct platform_device *);
 extern void platform_device_unregister(struct platform_device *);
 
 extern struct bus_type platform_bus_type;
-extern struct device platform_bus;
+extern struct platform_device platform_bus;
 
 extern void arch_setup_pdev_archdata(struct platform_device *);
 extern struct resource *platform_get_resource(struct platform_device *,
-- 
1.9.1
