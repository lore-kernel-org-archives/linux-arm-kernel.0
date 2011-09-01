From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  1 Sep 2011 13:27:22 +0100
Subject: [PATCH 4/5] mach-ux500: move top level platform devices in sysfs to
	/sys/devices/soc/X
In-Reply-To: <1314880043-22517-1-git-send-email-lee.jones@linaro.org>
References: <1314880043-22517-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1314880043-22517-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the request of Arnd Bergmann this patch moves all SoC
platform devices found in sysfs from /sys/devices/platform to
/sys/devices/soc/<SoCNum>_<SocMachine>/. It is believed as the
devices are SoC specific and a /sys/devices/soc node has recently
become available, that this would be a more appropriate place to
display the data.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c   |   16 ++++++++++++++++
 arch/arm/mach-ux500/board-u5500.c    |    7 +++++++
 arch/arm/mach-ux500/cpu-db5500.c     |    7 +++++++
 arch/arm/mach-ux500/cpu-db8500.c     |   13 ++++++++++++-
 arch/arm/mach-ux500/devices-common.c |   19 ++++++++++++++++---
 arch/arm/mach-ux500/usb.c            |    6 ++++++
 6 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 4d75b0d..d3b1447 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -29,6 +29,7 @@
 #include <linux/smsc911x.h>
 #include <linux/gpio_keys.h>
 #include <linux/delay.h>
+#include <linux/sys_soc.h>
 
 #include <linux/leds.h>
 #include <asm/mach-types.h>
@@ -602,6 +603,7 @@ static struct platform_device *snowball_platform_devs[] __initdata = {
 static void __init mop500_init_machine(void)
 {
 	int i2c0_devs;
+	int i;
 
 	mop500_gpio_keys[0].gpio = GPIO_PROX_SENSOR;
 
@@ -609,6 +611,10 @@ static void __init mop500_init_machine(void)
 
 	mop500_pins_init();
 
+	if (soc_dev)
+		for (i=0; i<ARRAY_SIZE(mop500_platform_devs); i++)
+			mop500_platform_devs[i]->dev.parent = &soc_dev->dev;
+
 	platform_add_devices(mop500_platform_devs,
 			ARRAY_SIZE(mop500_platform_devs));
 
@@ -630,11 +636,16 @@ static void __init mop500_init_machine(void)
 static void __init snowball_init_machine(void)
 {
 	int i2c0_devs;
+	int i;
 
 	u8500_init_devices();
 
 	snowball_pins_init();
 
+	if (soc_dev)
+		for (i=0; i<ARRAY_SIZE(snowball_platform_devs); i++)
+			snowball_platform_devs[i]->dev.parent = &soc_dev->dev;
+
 	platform_add_devices(snowball_platform_devs,
 			ARRAY_SIZE(snowball_platform_devs));
 
@@ -655,6 +666,7 @@ static void __init snowball_init_machine(void)
 static void __init hrefv60_init_machine(void)
 {
 	int i2c0_devs;
+	int i;
 
 	/*
 	 * The HREFv60 board removed a GPIO expander and routed
@@ -667,6 +679,10 @@ static void __init hrefv60_init_machine(void)
 
 	hrefv60_pins_init();
 
+	if (soc_dev)
+		for (i=0; i<ARRAY_SIZE(mop500_platform_devs); i++)
+			mop500_platform_devs[i]->dev.parent = &soc_dev->dev;
+
 	platform_add_devices(mop500_platform_devs,
 			ARRAY_SIZE(mop500_platform_devs));
 
diff --git a/arch/arm/mach-ux500/board-u5500.c b/arch/arm/mach-ux500/board-u5500.c
index 5c9e665..5a74a41 100644
--- a/arch/arm/mach-ux500/board-u5500.c
+++ b/arch/arm/mach-ux500/board-u5500.c
@@ -11,6 +11,7 @@
 #include <linux/gpio.h>
 #include <linux/irq.h>
 #include <linux/i2c.h>
+#include <linux/sys_soc.h>
 #include <linux/mfd/ab5500/ab5500.h>
 
 #include <asm/mach/arch.h>
@@ -134,12 +135,18 @@ static void __init u5500_uart_init(void)
 
 static void __init u5500_init_machine(void)
 {
+	int i;
+
 	u5500_init_devices();
 	nmk_config_pins(u5500_pins, ARRAY_SIZE(u5500_pins));
 	u5500_i2c_init();
 	u5500_sdi_init();
 	u5500_uart_init();
 
+	if (soc_dev)
+		for (i=0; i<ARRAY_SIZE(u5500_platform_devices); i++)
+			u5500_platform_devices[i]->dev.parent = &soc_dev->dev;
+
 	platform_add_devices(u5500_platform_devices,
 		ARRAY_SIZE(u5500_platform_devices));
 }
diff --git a/arch/arm/mach-ux500/cpu-db5500.c b/arch/arm/mach-ux500/cpu-db5500.c
index e532c32..1638ccc 100644
--- a/arch/arm/mach-ux500/cpu-db5500.c
+++ b/arch/arm/mach-ux500/cpu-db5500.c
@@ -9,6 +9,7 @@
 #include <linux/amba/bus.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/sys_soc.h>
 
 #include <asm/mach/map.h>
 #include <asm/pmu.h>
@@ -222,11 +223,17 @@ static int usb_db5500_tx_dma_cfg[] = {
 
 void __init u5500_init_devices(void)
 {
+	int i;
+
 	db5500_add_gpios();
 	db5500_dma_init();
 	db5500_add_rtc();
 	db5500_add_usb(usb_db5500_rx_dma_cfg, usb_db5500_tx_dma_cfg);
 
+	if (soc_dev)
+		for (i=0; i<ARRAY_SIZE(db5500_platform_devs); i++)
+			db5500_platform_devs[i]->dev.parent = &soc_dev->dev;
+
 	platform_add_devices(db5500_platform_devs,
 			     ARRAY_SIZE(db5500_platform_devs));
 }
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 4598b06..655639e 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -17,6 +17,7 @@
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/sys_soc.h>
 
 #include <asm/mach/map.h>
 #include <asm/pmu.h>
@@ -193,6 +194,8 @@ static int usb_db8500_tx_dma_cfg[] = {
  */
 void __init u8500_init_devices(void)
 {
+	int i;
+
 	if (cpu_is_u8500ed())
 		dma40_u8500ed_fixup();
 
@@ -200,7 +203,15 @@ void __init u8500_init_devices(void)
 	db8500_add_gpios();
 	db8500_add_usb(usb_db8500_rx_dma_cfg, usb_db8500_tx_dma_cfg);
 
-	platform_device_register_simple("cpufreq-u8500", -1, NULL, 0);
+	platform_device_register_resndata(
+		(soc_dev) ? &soc_dev->dev : NULL,
+		"cpufreq-u8500", -1, NULL, 0, NULL, 0);
+
+	if (soc_dev) {
+		for (i=0; i<ARRAY_SIZE(platform_devs); i++)
+			platform_devs[i]->dev.parent = &soc_dev->dev;
+	}
+
 	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
 
 	return ;
diff --git a/arch/arm/mach-ux500/devices-common.c b/arch/arm/mach-ux500/devices-common.c
index 13a4ce0..74bfd1f 100644
--- a/arch/arm/mach-ux500/devices-common.c
+++ b/arch/arm/mach-ux500/devices-common.c
@@ -12,10 +12,12 @@
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
+#include <linux/sys_soc.h>
 
 #include <plat/gpio.h>
 
 #include <mach/hardware.h>
+#include <mach/setup.h>
 
 #include "devices-common.h"
 
@@ -46,6 +48,9 @@ dbx500_add_amba_device(const char *name, resource_size_t base,
 
 	dev->dev.platform_data = pdata;
 
+	if (soc_dev)
+		dev->dev.parent = &soc_dev->dev;
+
 	ret = amba_device_register(dev, &iomem_resource);
 	if (ret) {
 		kfree(dev);
@@ -75,6 +80,9 @@ dbx500_add_platform_device(const char *name, int id, void *pdata,
 
 	dev->dev.platform_data = pdata;
 
+	if (soc_dev)
+		dev->dev.parent = &soc_dev->dev;
+
 	ret = platform_device_add(dev);
 	if (ret)
 		goto out_free;
@@ -125,9 +133,14 @@ dbx500_add_gpio(int id, resource_size_t addr, int irq,
 		}
 	};
 
-	return platform_device_register_resndata(NULL, "gpio", id,
-				resources, ARRAY_SIZE(resources),
-				pdata, sizeof(*pdata));
+	return platform_device_register_resndata(
+		(soc_dev) ? &soc_dev->dev : NULL,
+		"gpio",
+		id,
+		resources,
+		ARRAY_SIZE(resources),
+		pdata,
+		sizeof(*pdata));
 }
 
 void dbx500_add_gpios(resource_size_t *base, int num, int irq,
diff --git a/arch/arm/mach-ux500/usb.c b/arch/arm/mach-ux500/usb.c
index 0a01cbd..aa2df4a 100644
--- a/arch/arm/mach-ux500/usb.c
+++ b/arch/arm/mach-ux500/usb.c
@@ -7,8 +7,11 @@
 #include <linux/platform_device.h>
 #include <linux/usb/musb.h>
 #include <linux/dma-mapping.h>
+#include <linux/sys_soc.h>
+
 #include <plat/ste_dma40.h>
 #include <mach/hardware.h>
+#include <mach/setup.h>
 #include <mach/usb.h>
 
 #define MUSB_DMA40_RX_CH { \
@@ -157,5 +160,8 @@ void ux500_add_usb(resource_size_t base, int irq, int *dma_rx_cfg,
 	ux500_usb_dma_update_rx_ch_config(dma_rx_cfg);
 	ux500_usb_dma_update_tx_ch_config(dma_tx_cfg);
 
+	if (soc_dev)
+		ux500_musb_device.dev.parent = &soc_dev->dev;
+
 	platform_device_register(&ux500_musb_device);
 }
-- 
1.7.4.1
