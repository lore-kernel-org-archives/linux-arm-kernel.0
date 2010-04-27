From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 27 Apr 2010 09:46:48 +0530
Subject: [PATCH 10/14] ux500: move gpio devices to devices-db8500.c
In-Reply-To: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
References: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1272341812-4622-11-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO layout is different on DB5500, so move the current one to
devices-db8500.c.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/cpu-u8500.c            |   37 +---------------------------
 arch/arm/mach-ux500/devices-db8500.c       |   37 ++++++++++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/devices.h |    2 +
 3 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-u8500.c b/arch/arm/mach-ux500/cpu-u8500.c
index 730d020..51e9bf2 100644
--- a/arch/arm/mach-ux500/cpu-u8500.c
+++ b/arch/arm/mach-ux500/cpu-u8500.c
@@ -22,42 +22,7 @@
 #include <plat/mtu.h>
 #include <mach/hardware.h>
 #include <mach/setup.h>
-
-static struct nmk_gpio_platform_data u8500_gpio_data[] = {
-	GPIO_DATA("GPIO-0-31", 0),
-	GPIO_DATA("GPIO-32-63", 32), /* 37..63 not routed to pin */
-	GPIO_DATA("GPIO-64-95", 64),
-	GPIO_DATA("GPIO-96-127", 96), /* 97..127 not routed to pin */
-	GPIO_DATA("GPIO-128-159", 128),
-	GPIO_DATA("GPIO-160-191", 160), /* 172..191 not routed to pin */
-	GPIO_DATA("GPIO-192-223", 192),
-	GPIO_DATA("GPIO-224-255", 224), /* 231..255 not routed to pin */
-	GPIO_DATA("GPIO-256-288", 256), /* 258..288 not routed to pin */
-};
-
-static struct resource u8500_gpio_resources[] = {
-	GPIO_RESOURCE(0),
-	GPIO_RESOURCE(1),
-	GPIO_RESOURCE(2),
-	GPIO_RESOURCE(3),
-	GPIO_RESOURCE(4),
-	GPIO_RESOURCE(5),
-	GPIO_RESOURCE(6),
-	GPIO_RESOURCE(7),
-	GPIO_RESOURCE(8),
-};
-
-static struct platform_device u8500_gpio_devs[] = {
-	GPIO_DEVICE(0),
-	GPIO_DEVICE(1),
-	GPIO_DEVICE(2),
-	GPIO_DEVICE(3),
-	GPIO_DEVICE(4),
-	GPIO_DEVICE(5),
-	GPIO_DEVICE(6),
-	GPIO_DEVICE(7),
-	GPIO_DEVICE(8),
-};
+#include <mach/devices.h>
 
 static struct platform_device *platform_devs[] __initdata = {
 	&u8500_gpio_devs[0],
diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index 397f862..2033423 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -9,11 +9,48 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/gpio.h>
 #include <linux/amba/bus.h>
 
 #include <mach/hardware.h>
 #include <mach/setup.h>
 
+static struct nmk_gpio_platform_data u8500_gpio_data[] = {
+	GPIO_DATA("GPIO-0-31", 0),
+	GPIO_DATA("GPIO-32-63", 32), /* 37..63 not routed to pin */
+	GPIO_DATA("GPIO-64-95", 64),
+	GPIO_DATA("GPIO-96-127", 96), /* 98..127 not routed to pin */
+	GPIO_DATA("GPIO-128-159", 128),
+	GPIO_DATA("GPIO-160-191", 160), /* 172..191 not routed to pin */
+	GPIO_DATA("GPIO-192-223", 192),
+	GPIO_DATA("GPIO-224-255", 224), /* 231..255 not routed to pin */
+	GPIO_DATA("GPIO-256-288", 256), /* 268..288 not routed to pin */
+};
+
+static struct resource u8500_gpio_resources[] = {
+	GPIO_RESOURCE(0),
+	GPIO_RESOURCE(1),
+	GPIO_RESOURCE(2),
+	GPIO_RESOURCE(3),
+	GPIO_RESOURCE(4),
+	GPIO_RESOURCE(5),
+	GPIO_RESOURCE(6),
+	GPIO_RESOURCE(7),
+	GPIO_RESOURCE(8),
+};
+
+struct platform_device u8500_gpio_devs[] = {
+	GPIO_DEVICE(0),
+	GPIO_DEVICE(1),
+	GPIO_DEVICE(2),
+	GPIO_DEVICE(3),
+	GPIO_DEVICE(4),
+	GPIO_DEVICE(5),
+	GPIO_DEVICE(6),
+	GPIO_DEVICE(7),
+	GPIO_DEVICE(8),
+};
+
 struct amba_device u8500_ssp0_device = {
 	.dev = {
 		.coherent_dma_mask = ~0,
diff --git a/arch/arm/mach-ux500/include/mach/devices.h b/arch/arm/mach-ux500/include/mach/devices.h
index 251b4eb..76b3569 100644
--- a/arch/arm/mach-ux500/include/mach/devices.h
+++ b/arch/arm/mach-ux500/include/mach/devices.h
@@ -10,6 +10,8 @@
 struct platform_device;
 struct amba_device;
 
+extern struct platform_device u8500_gpio_devs[];
+
 extern struct amba_device ux500_pl031_device;
 extern struct amba_device u8500_ssp0_device;
 extern struct amba_device ux500_uart0_device;
-- 
1.7.0
