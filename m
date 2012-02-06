From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Feb 2012 11:22:25 -0800
Subject: [PATCH 5/6] mach-ux500: move top level platform devices in sysfs to
 /sys/devices/socX
In-Reply-To: <1328556146-3730-1-git-send-email-lee.jones@linaro.org>
References: <1328556146-3730-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1328556146-3730-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the request of Arnd Bergmann this patch moves all SoC
platform devices found in sysfs from /sys/devices/platform to
/sys/devices/soc<SoCNum>/. It is believed as the devices are
SoC specific and a /sys/devices/soc node has recently
become available, that this would be a more appropriate place to
display the data.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c   |   12 ++++++++++++
 arch/arm/mach-ux500/board-u5500.c    |    4 ++++
 arch/arm/mach-ux500/cpu-db5500.c     |    4 ++++
 arch/arm/mach-ux500/cpu-db8500.c     |    8 +++++++-
 arch/arm/mach-ux500/devices-common.c |   13 ++++++++++---
 arch/arm/mach-ux500/usb.c            |    3 +++
 6 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index f9ce2a1..04afcdf 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -610,6 +610,7 @@ static void __init mop500_init_machine(void)
 {
 	struct device *parent = NULL;
 	int i2c0_devs;
+	int i;
 
 	mop500_gpio_keys[0].gpio = GPIO_PROX_SENSOR;
 
@@ -617,6 +618,9 @@ static void __init mop500_init_machine(void)
 
 	mop500_pins_init();
 
+	for (i = 0; i < ARRAY_SIZE(mop500_platform_devs); i++)
+		mop500_platform_devs[i]->dev.parent = parent;
+
 	platform_add_devices(mop500_platform_devs,
 			ARRAY_SIZE(mop500_platform_devs));
 
@@ -639,11 +643,15 @@ static void __init snowball_init_machine(void)
 {
 	struct device *parent = NULL;
 	int i2c0_devs;
+	int i;
 
 	parent = u8500_init_devices();
 
 	snowball_pins_init();
 
+	for (i = 0; i < ARRAY_SIZE(snowball_platform_devs); i++)
+		snowball_platform_devs[i]->dev.parent = parent;
+
 	platform_add_devices(snowball_platform_devs,
 			ARRAY_SIZE(snowball_platform_devs));
 
@@ -665,6 +673,7 @@ static void __init hrefv60_init_machine(void)
 {
 	struct device *parent = NULL;
 	int i2c0_devs;
+	int i;
 
 	/*
 	 * The HREFv60 board removed a GPIO expander and routed
@@ -677,6 +686,9 @@ static void __init hrefv60_init_machine(void)
 
 	hrefv60_pins_init();
 
+	for (i = 0; i < ARRAY_SIZE(mop500_platform_devs); i++)
+		mop500_platform_devs[i]->dev.parent = parent;
+
 	platform_add_devices(mop500_platform_devs,
 			ARRAY_SIZE(mop500_platform_devs));
 
diff --git a/arch/arm/mach-ux500/board-u5500.c b/arch/arm/mach-ux500/board-u5500.c
index d7a9596..0ff4be7 100644
--- a/arch/arm/mach-ux500/board-u5500.c
+++ b/arch/arm/mach-ux500/board-u5500.c
@@ -136,6 +136,7 @@ static void __init u5500_uart_init(struct device *parent)
 static void __init u5500_init_machine(void)
 {
 	struct device *parent = NULL;
+	int i;
 
 	parent = u5500_init_devices();
 	nmk_config_pins(u5500_pins, ARRAY_SIZE(u5500_pins));
@@ -144,6 +145,9 @@ static void __init u5500_init_machine(void)
 	u5500_sdi_init(parent);
 	u5500_uart_init(parent);
 
+	for (i = 0; i < ARRAY_SIZE(u5500_platform_devices); i++)
+		u5500_platform_devices[i]->dev.parent = parent;
+
 	platform_add_devices(u5500_platform_devices,
 		ARRAY_SIZE(u5500_platform_devices));
 }
diff --git a/arch/arm/mach-ux500/cpu-db5500.c b/arch/arm/mach-ux500/cpu-db5500.c
index 8f8acfd..bca47f3 100644
--- a/arch/arm/mach-ux500/cpu-db5500.c
+++ b/arch/arm/mach-ux500/cpu-db5500.c
@@ -227,6 +227,7 @@ static struct device * __init db5500_soc_device_init(void)
 struct device * __init u5500_init_devices(void)
 {
 	struct device *parent;
+	int i;
 
 	parent = db5500_soc_device_init();
 
@@ -236,6 +237,9 @@ struct device * __init u5500_init_devices(void)
 	db5500_add_rtc(parent);
 	db5500_add_usb(parent, usb_db5500_rx_dma_cfg, usb_db5500_tx_dma_cfg);
 
+	for (i = 0; i < ARRAY_SIZE(db5500_platform_devs); i++)
+		db5500_platform_devs[i]->dev.parent = parent;
+
 	platform_add_devices(db5500_platform_devs,
 			     ARRAY_SIZE(db5500_platform_devs));
 
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index afcde3d..9bd8163 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -188,6 +188,7 @@ static struct device * __init db8500_soc_device_init(void)
 struct device * __init u8500_init_devices(void)
 {
 	struct device *parent;
+	int i;
 
 	parent = db8500_soc_device_init();
 
@@ -195,7 +196,12 @@ struct device * __init u8500_init_devices(void)
 	db8500_add_gpios(parent);
 	db8500_add_usb(parent, usb_db8500_rx_dma_cfg, usb_db8500_tx_dma_cfg);
 
-	platform_device_register_simple("cpufreq-u8500", -1, NULL, 0);
+	platform_device_register_data(parent,
+		"cpufreq-u8500", -1, NULL, 0);
+
+	for (i = 0; i < ARRAY_SIZE(platform_devs); i++)
+		platform_devs[i]->dev.parent = parent;
+
 	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
 
 	return parent;
diff --git a/arch/arm/mach-ux500/devices-common.c b/arch/arm/mach-ux500/devices-common.c
index 96be248..96effbd 100644
--- a/arch/arm/mach-ux500/devices-common.c
+++ b/arch/arm/mach-ux500/devices-common.c
@@ -47,6 +47,8 @@ dbx500_add_amba_device(struct device *parent, const char *name,
 
 	dev->dev.platform_data = pdata;
 
+	dev->dev.parent = parent;
+
 	ret = amba_device_register(dev, &iomem_resource);
 	if (ret) {
 		kfree(dev);
@@ -126,9 +128,14 @@ dbx500_add_gpio(struct device *parent, int id, resource_size_t addr, int irq,
 		}
 	};
 
-	return platform_device_register_resndata(NULL, "gpio", id,
-				resources, ARRAY_SIZE(resources),
-				pdata, sizeof(*pdata));
+	return platform_device_register_resndata(
+		parent,
+		"gpio",
+		id,
+		resources,
+		ARRAY_SIZE(resources),
+		pdata,
+		sizeof(*pdata));
 }
 
 void dbx500_add_gpios(struct device *parent, resource_size_t *base, int num,
diff --git a/arch/arm/mach-ux500/usb.c b/arch/arm/mach-ux500/usb.c
index bef6a31..cdae63e 100644
--- a/arch/arm/mach-ux500/usb.c
+++ b/arch/arm/mach-ux500/usb.c
@@ -7,6 +7,7 @@
 #include <linux/platform_device.h>
 #include <linux/usb/musb.h>
 #include <linux/dma-mapping.h>
+
 #include <plat/ste_dma40.h>
 #include <mach/hardware.h>
 #include <mach/usb.h>
@@ -157,5 +158,7 @@ void ux500_add_usb(struct device *parent, resource_size_t base, int irq,
 	ux500_usb_dma_update_rx_ch_config(dma_rx_cfg);
 	ux500_usb_dma_update_tx_ch_config(dma_tx_cfg);
 
+	ux500_musb_device.dev.parent = parent;
+
 	platform_device_register(&ux500_musb_device);
 }
-- 
1.7.5.4
