From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:30:06 -0700
Subject: [PATCH 42/47] davinci: add tnetv107x keypad platform device
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-43-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

This patch adds a platform device definition for tnetv107x's keypad
controller.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/devices-tnetv107x.c      |   30 ++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/tnetv107x.h |    3 ++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-tnetv107x.c b/arch/arm/mach-davinci/devices-tnetv107x.c
index 2718a3a9..086269f 100644
--- a/arch/arm/mach-davinci/devices-tnetv107x.c
+++ b/arch/arm/mach-davinci/devices-tnetv107x.c
@@ -33,6 +33,7 @@
 #define TNETV107X_WDOG_BASE			0x08086700
 #define TNETV107X_SDIO0_BASE			0x08088700
 #define TNETV107X_SDIO1_BASE			0x08088800
+#define TNETV107X_KEYPAD_BASE			0x08088a00
 #define TNETV107X_ASYNC_EMIF_CNTRL_BASE		0x08200000
 #define TNETV107X_ASYNC_EMIF_DATA_CE0_BASE	0x30000000
 #define TNETV107X_ASYNC_EMIF_DATA_CE1_BASE	0x40000000
@@ -298,6 +299,30 @@ static int __init nand_init(int chipsel, struct davinci_nand_pdata *data)
 	return platform_device_register(pdev);
 }
 
+static struct resource keypad_resources[] = {
+	{
+		.start	= TNETV107X_KEYPAD_BASE,
+		.end	= TNETV107X_KEYPAD_BASE + 0xff,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_TNETV107X_KEYPAD,
+		.flags	= IORESOURCE_IRQ,
+		.name	= "press",
+	},
+	{
+		.start	= IRQ_TNETV107X_KEYPAD_FREE,
+		.flags	= IORESOURCE_IRQ,
+		.name	= "release",
+	},
+};
+
+static struct platform_device keypad_device = {
+	.name		= "tnetv107x-keypad",
+	.num_resources	= ARRAY_SIZE(keypad_resources),
+	.resource	= keypad_resources,
+};
+
 void __init tnetv107x_devices_init(struct tnetv107x_device_info *info)
 {
 	int i;
@@ -317,4 +342,9 @@ void __init tnetv107x_devices_init(struct tnetv107x_device_info *info)
 	for (i = 0; i < 4; i++)
 		if (info->nand_config[i])
 			nand_init(i, info->nand_config[i]);
+
+	if (info->keypad_config) {
+		keypad_device.dev.platform_data = info->keypad_config;
+		platform_device_register(&keypad_device);
+	}
 }
diff --git a/arch/arm/mach-davinci/include/mach/tnetv107x.h b/arch/arm/mach-davinci/include/mach/tnetv107x.h
index c720647..5a681d8 100644
--- a/arch/arm/mach-davinci/include/mach/tnetv107x.h
+++ b/arch/arm/mach-davinci/include/mach/tnetv107x.h
@@ -33,6 +33,8 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/serial_8250.h>
+#include <linux/input/matrix_keypad.h>
+
 #include <mach/mmc.h>
 #include <mach/nand.h>
 #include <mach/serial.h>
@@ -41,6 +43,7 @@ struct tnetv107x_device_info {
 	struct davinci_uart_config	*serial_config;
 	struct davinci_mmc_config	*mmc_config[2];  /* 2 controllers */
 	struct davinci_nand_pdata	*nand_config[4]; /* 4 chipsels */
+	struct matrix_keypad_platform_data *keypad_config;
 };
 
 extern struct platform_device tnetv107x_wdt_device;
-- 
1.7.2.1
