From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Aug 2011 14:03:42 +0100
Subject: [PATCH 4/4] Move top level platform devices in sysfs to
	/sys/devices/soc/X
In-Reply-To: <1312981422-13294-1-git-send-email-lee.jones@linaro.org>
References: <1312981422-13294-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1312981422-13294-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the request of Arnd Bergmann this patch moves all SoC
platform devices found in sysfs from /sys/devices/platform to
/sys/devices/soc/<SoCNum>/. It is believed as the devices are
SoC specific and a /sys/devices/soc node has recently become
available, that this would be a more appropriate place to
display the data.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c   |   19 +++++++++++++++----
 arch/arm/mach-ux500/board-u5500.c    |    6 ++++++
 arch/arm/mach-ux500/cpu-db5500.c     |    6 ++++++
 arch/arm/mach-ux500/cpu-db8500.c     |   12 +++++++++++-
 arch/arm/mach-ux500/devices-common.c |   19 +++++++++++++++----
 arch/arm/mach-ux500/usb.c            |    4 ++++
 6 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 5b43fed..4c3295d 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -603,6 +603,7 @@ static struct platform_device *snowball_platform_devs[] __initdata = {
 static void __init mop500_init_machine(void)
 {
 	int i2c0_devs;
+	int i;
 
 	/*
 	 * The HREFv60 board removed a GPIO expander and routed
@@ -620,12 +621,22 @@ static void __init mop500_init_machine(void)
 
 	mop500_pins_init();
 
-	if (machine_is_snowball())
+	if (machine_is_snowball()) {
+		if (soc_parent->parent != NULL)
+			for (i=0; i<ARRAY_SIZE(snowball_platform_devs); i++)
+				snowball_platform_devs[i]->dev.parent = soc_parent;
+
 		platform_add_devices(snowball_platform_devs,
-					ARRAY_SIZE(snowball_platform_devs));
-	else
+				ARRAY_SIZE(snowball_platform_devs));
+	}
+	else {
+		if (soc_parent->parent != NULL)
+			for (i=0; i<ARRAY_SIZE(mop500_platform_devs); i++)
+				mop500_platform_devs[i]->dev.parent = soc_parent;
+
 		platform_add_devices(mop500_platform_devs,
-					ARRAY_SIZE(mop500_platform_devs));
+				ARRAY_SIZE(mop500_platform_devs));
+	}
 
 	mop500_i2c_init();
 	mop500_sdi_init();
diff --git a/arch/arm/mach-ux500/board-u5500.c b/arch/arm/mach-ux500/board-u5500.c
index 81e0475..4866436 100644
--- a/arch/arm/mach-ux500/board-u5500.c
+++ b/arch/arm/mach-ux500/board-u5500.c
@@ -53,11 +53,17 @@ static void __init u5500_uart_init(void)
 
 static void __init u5500_init_machine(void)
 {
+	int i;
+
 	u5500_init_devices();
 
 	u5500_sdi_init();
 	u5500_uart_init();
 
+	if (soc_parent->parent != NULL)
+		for (i=0; i<ARRAY_SIZE(u5500_platform_devices); i++)
+			u5500_platform_devices[i]->dev.parent = soc_parent;
+
 	platform_add_devices(u5500_platform_devices,
 		ARRAY_SIZE(u5500_platform_devices));
 }
diff --git a/arch/arm/mach-ux500/cpu-db5500.c b/arch/arm/mach-ux500/cpu-db5500.c
index 7d940a8..52cbbd2 100644
--- a/arch/arm/mach-ux500/cpu-db5500.c
+++ b/arch/arm/mach-ux500/cpu-db5500.c
@@ -216,11 +216,17 @@ static int usb_db5500_tx_dma_cfg[] = {
 
 void __init u5500_init_devices(void)
 {
+	int i;
+
 	db5500_add_gpios();
 	db5500_dma_init();
 	db5500_add_rtc();
 	db5500_add_usb(usb_db5500_rx_dma_cfg, usb_db5500_tx_dma_cfg);
 
+	if (soc_parent->parent != NULL)
+		for (i=0; i<ARRAY_SIZE(db5500_platform_devs); i++)
+			db5500_platform_devs[i]->dev.parent = soc_parent;
+
 	platform_add_devices(db5500_platform_devs,
 			     ARRAY_SIZE(db5500_platform_devs));
 }
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 07562e8..cd63363 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -196,6 +196,8 @@ static int usb_db8500_tx_dma_cfg[] = {
  */
 void __init u8500_init_devices(void)
 {
+	int i;
+
 	if (cpu_is_u8500ed())
 		dma40_u8500ed_fixup();
 
@@ -203,7 +205,15 @@ void __init u8500_init_devices(void)
 	db8500_add_gpios();
 	db8500_add_usb(usb_db8500_rx_dma_cfg, usb_db8500_tx_dma_cfg);
 
-	platform_device_register_simple("cpufreq-u8500", -1, NULL, 0);
+
+	platform_device_register_resndata(
+		(soc_parent->parent != NULL) ? soc_parent : NULL,
+		"cpufreq-u8500", -1, NULL, 0, NULL, 0);
+
+	if (soc_parent->parent != NULL)
+		for (i=0; i<ARRAY_SIZE(platform_devs); i++)
+			platform_devs[i]->dev.parent = soc_parent;
+
 	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
 
 	return ;
diff --git a/arch/arm/mach-ux500/devices-common.c b/arch/arm/mach-ux500/devices-common.c
index 7418552..c8d1399 100644
--- a/arch/arm/mach-ux500/devices-common.c
+++ b/arch/arm/mach-ux500/devices-common.c
@@ -15,7 +15,7 @@
 #include <linux/gpio/nomadik.h>
 
 #include <mach/hardware.h>
-
+#include <mach/setup.h>
 #include "devices-common.h"
 
 struct amba_device *
@@ -45,6 +45,9 @@ dbx500_add_amba_device(const char *name, resource_size_t base,
 
 	dev->dev.platform_data = pdata;
 
+	if (soc_parent->parent != NULL)
+		dev->dev.parent = soc_parent;
+
 	ret = amba_device_register(dev, &iomem_resource);
 	if (ret) {
 		kfree(dev);
@@ -74,6 +77,9 @@ dbx500_add_platform_device(const char *name, int id, void *pdata,
 
 	dev->dev.platform_data = pdata;
 
+	if (soc_parent->parent != NULL)
+		dev->dev.parent = soc_parent;
+
 	ret = platform_device_add(dev);
 	if (ret)
 		goto out_free;
@@ -124,9 +130,14 @@ dbx500_add_gpio(int id, resource_size_t addr, int irq,
 		}
 	};
 
-	return platform_device_register_resndata(NULL, "gpio", id,
-				resources, ARRAY_SIZE(resources),
-				pdata, sizeof(*pdata));
+	return platform_device_register_resndata(
+		(soc_parent->parent != NULL) ? soc_parent : NULL,
+		"gpio",
+		id,
+		resources,
+		ARRAY_SIZE(resources),
+		pdata,
+		sizeof(*pdata));
 }
 
 void dbx500_add_gpios(resource_size_t *base, int num, int irq,
diff --git a/arch/arm/mach-ux500/usb.c b/arch/arm/mach-ux500/usb.c
index 0a01cbd..29cdd3c 100644
--- a/arch/arm/mach-ux500/usb.c
+++ b/arch/arm/mach-ux500/usb.c
@@ -9,6 +9,7 @@
 #include <linux/dma-mapping.h>
 #include <plat/ste_dma40.h>
 #include <mach/hardware.h>
+#include <mach/setup.h>
 #include <mach/usb.h>
 
 #define MUSB_DMA40_RX_CH { \
@@ -157,5 +158,8 @@ void ux500_add_usb(resource_size_t base, int irq, int *dma_rx_cfg,
 	ux500_usb_dma_update_rx_ch_config(dma_rx_cfg);
 	ux500_usb_dma_update_tx_ch_config(dma_tx_cfg);
 
+	if (soc_parent->parent != NULL)
+		ux500_musb_device.dev.parent = soc_parent;
+
 	platform_device_register(&ux500_musb_device);
 }
-- 
1.7.4.1
